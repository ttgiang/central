package com.ase.aseutil.listeners;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

public class SessionSnoop extends HttpServlet {

  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    res.setContentType("text/html");

    PrintWriter out = res.getWriter();

    // Get the current session object, create one if necessary
    HttpSession session = req.getSession(true);

    // Increment the hit count for this page. The value is saved
    // in this client's session under the name "snoop.count".
    Integer count = (Integer)session.getValue("snoop.count");
    if (count == null)
      count = new Integer(1);
    else
      count = new Integer(count.intValue() + 1);

    session.putValue("snoop.count", count);

    out.println("<HTML><HEAD><TITLE>SessionSnoop</TITLE></HEAD>");
    out.println("<BODY><H1>Session Snoop</H1>");

    // Display the hit count for this page
    out.println("You've visited this page " + count +
      ((count.intValue() == 1) ? " time." : " times."));

    out.println("<P>");

    out.println("<H3>Here is your saved session data:</H3>");
    String[] names = session.getValueNames();
    for (int i = 0; i < names.length; i++) {
      out.println(names[i] + ": " + session.getValue(names[i]) + "<BR>");
    }

    out.println("<H3>Here are some vital stats on your session:</H3>");
    out.println("Session id: " + session.getId() + "<BR>");
    out.println("New session: " + session.isNew() + "<BR>");
    out.println("Creation time: " + session.getCreationTime());
    out.println("<I>(" + new Date(session.getCreationTime()) + ")</I><BR>");
    out.println("Last access time: " + session.getLastAccessedTime());
    out.println("<I>(" + new Date(session.getLastAccessedTime()) +
                ")</I><BR>");

    out.println("Requested session ID from cookie: " + req.isRequestedSessionIdFromCookie() + "<BR>");
    out.println("Requested session ID from URL: " + req.isRequestedSessionIdFromUrl() + "<BR>");
    out.println("Requested session ID valid: " + req.isRequestedSessionIdValid() + "<BR>");

    out.println("<H3>Here are all the current session IDs");
    out.println("and the times they've hit this page:</H3>");
    HttpSessionContext context = session.getSessionContext();
    Enumeration ids = context.getIds();
    while (ids.hasMoreElements()) {
      String id = (String)ids.nextElement();
      out.println(id + ": ");
      HttpSession foreignSession = context.getSession(id);
      Integer foreignCount =
        (Integer)foreignSession.getValue("snoop.count");
      if (foreignCount == null)
        out.println(0);
      else
        out.println(foreignCount.toString());
      out.println("<BR>");
    }

    out.println("<H3>Test URL Rewriting</H3>");
    out.println("Click <A HREF=\"" + res.encodeUrl(req.getRequestURI()) + "\">here</A>");
    out.println("to test that session tracking works via URL");
    out.println("rewriting even when cookies aren't supported.");

    out.println("</BODY></HTML>");
  }
}