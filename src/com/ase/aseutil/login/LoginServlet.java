package com.ase.aseutil.login;

import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	protected String site;
	protected String domain, restricted;
	protected SessionCache sessionCache;
	protected long flushTimeout=600000;
	protected long sessionTimeout=7200000;
	protected boolean protectedDir=false;
	protected String defaultPage="/index.html";

	//weblogic.servlet.FileServlet fileServlet;

	static {
		try{
			//new pool.JDCConnectionDriver("postgresql.Driver","jdbc:postgresql:ejbdemo","postgres", "pass");
		}catch(Exception e){
			System.out.println("new pool error"+e);
		}
	}

	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection("jdbc:jdc:jdcpool");
	}


	public void init(ServletConfig config) throws ServletException  {
		super.init(config);
		domain = config.getInitParameter("domain");
		restricted = config.getInitParameter("restricted");

		if(restricted != null) {
			protectedDir=true;
		}

		sessionCache = new SessionCache (flushTimeout);

		//if ((fileServlet=(weblogic.servlet.FileServlet)config.getServletContext().getServlet("file")) == null ) {
		//    throw new ServletException ("No FileServlet found installed ");
		//}

	}

    public void service(HttpServletRequest request,
                HttpServletResponse response) throws IOException {

       Cookie thisCookie=null;
       boolean activeSession;
       String cmd;

       Session session = validateSession (request, response);

       if ((cmd=request.getParameter ("action")) != null ) {
           setNoCache (request, response);

           if (cmd.equals ("login") && session == null ) {

              // create a new session
              session = startSession (request.getParameter("theuser"),
		request.getParameter ("password"), response);
              if(protectedDir) {
                  response.sendRedirect (restricted+"/index.html");
              } else {
                  response.sendRedirect (defaultPage);
              }
           } else if (cmd.equals ("displayDetails"))  {
                if(session != null) {
                   response.setContentType("text/html");
                   ServletOutputStream out = response.getOutputStream();
                   out.println("User id is "+session.getUser());
                   out.flush();
                } else {
                   response.sendRedirect ("/login.html");
                }
           } else if (cmd.equals ("logout")) {
              if (session != null ) {
                  endSession (session);
              }
              response.sendRedirect (defaultPage);
           } else {
              response.sendRedirect (defaultPage);
           }

       } else {

          if (session != null) {

               // already logged in
              if ( response.containsHeader ("Expires") == false ) {
                    response.setDateHeader ("Expires", session.getExpires());
              }
              try {
                   //fileServlet.doGet (request, response);
              }catch (Exception e) {
                   response.sendRedirect ("/login.html");
              }
          } else {
             // no existing session

             if( protectedDir &&
                   request.getRequestURI().indexOf(restricted)>=0) {

                 // restricted directory. Dont go in there!
                 response.sendRedirect ("/login.html");
             } else {

                // this file looks ok to serve dispense
                try {
                   //fileServlet.doGet (request, response);
                }catch (Exception e) {
                   response.sendRedirect ("/login.html");
                   System.out.println("error"+e);
                }
             }
          }
       }
    }

    protected boolean verifyPassword(String theuser, String password) {
        String originalPassword=null;

        try {
           Connection con=getConnection();
           Statement stmt= con.createStatement();
           stmt.executeQuery("select password from registration where theuser='"+theuser+"'");
           ResultSet rs = stmt.getResultSet();
           if(rs.next()) {
               originalPassword=rs.getString(1);
           }
           stmt.close();
           if(originalPassword.equals(password)) {
               return true;
           } else {
               return false;
           }
       } catch (Exception e){
           System.out.println("Exception: verifyPassword="+e);
           return false;
       }
    }

    protected Session startSession (String theuser, String password,
                                           HttpServletResponse response) {
        Session session = null;
        if ( verifyPassword(theuser, password) ) {
            // Create a session
            session = new Session (theuser);
            session.setExpires (sessionTimeout+System.currentTimeMillis());
            sessionCache.put (session);

            // Create a client cookie
            Cookie c = new Cookie("JDCAUCTION", String.valueOf (session.getId()));
            c.setPath ("/");
            c.setMaxAge (-1);
            c.setDomain (domain);
            response.addCookie (c);
	}
	return session;
    }

    private Session validateSession (HttpServletRequest request,
                                            HttpServletResponse response) {
       Cookie c[] = request.getCookies();
       Session session = null;
       if ( c != null ) {
          for (int i=0; i < c.length && session == null; i++ ) {
             if(c[i].getName().equals("JDCAUCTION")) {
                String key = String.valueOf (c[i].getValue());
                session=sessionCache.get (key);
             }
          }
       }
       return session;
    }

    protected void endSession (Session session) {
       synchronized (sessionCache) {
          sessionCache.remove (session);
       }
    }

    private void setNoCache (HttpServletRequest request,
                                       HttpServletResponse response) {

       if(request.getProtocol().compareTo ("HTTP/1.0") == 0) {
           response.setHeader ("Pragma", "no-cache");
       } else if (request.getProtocol().compareTo ("HTTP/1.1") == 0) {
           response.setHeader ("Cache-Control", "no-cache");
       }
       response.setDateHeader ("Expires", 0);
    }

}

