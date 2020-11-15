package com.ase.aseutil.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ServletContextAttrib extends HttpServlet {

	private static final long serialVersionUID = 12L;

  public void service(HttpServletRequest request, HttpServletResponse response)
            				throws IOException, ServletException {

    response.setContentType("text/html");
    ServletOutputStream out = response.getOutputStream();

    out.print("<?xml version='1.0' encoding='UTF-8'?>");

    out.print("<!DOCTYPE html");
    out.print("PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN'");
    out.print("'DTD/xhtml1-strict.dtd'>");

    out.print("<html>");
    out.print("<head>");
    out.print("<title>ServletContext Attributes</title>");
    out.print("</head>");
    out.print("<body>");

    ServletContext context = getServletContext();

    String action = request.getParameter("action");

    String name = request.getParameter("name");
    String value = request.getParameter("value");

    if (action != null){
      if (action.equals("add")){
        String test = (String) context.getAttribute(name);
        if (test == null){
          context.setAttribute(name, value);
          out.print("Added Item To ServletContext object");
        }
        else {
          context.setAttribute(name, value);
          out.print("Replaced Item in ServletContext");
        }
      } // add
      else if (action.equals("remove")){
        String test = (String) context.getAttribute(name);
        if (test == null) {
          out.print("Item does not exist");
        }
        else {
          context.removeAttribute(name);
          out.print("Removed Item From ServletContext");
        }
      } // remove
      else{
        String test = (String) context.getAttribute(name);
        if (test == null){
          context.setAttribute(name, value);
          out.print("Added Item To ServletContext object");
        }
        else {
          context.setAttribute(name, value);
          out.print("Replaced Item in ServletContext");
        }
      }
    } // if (action != null)

    out.print("<center> <br /> <br />");
    out.print("<a href='./servletcontextattrib.html'>");
    out.print("Back To Home Page");
    out.print("</a>");
    out.print("</center>");

    out.print("</body>");
    out.print("</html>");

  }
}