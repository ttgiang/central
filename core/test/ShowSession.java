package hall;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.net.*;
import java.util.*;

/** Simple example of session tracking. See the shopping
 *  cart example for a more detailed one.
 *  &lt;P&gt;
 *  Part of tutorial on servlets and JSP that appears at
 *  http://www.apl.jhu.edu/~hall/java/Servlet-Tutorial/
 *  1999 Marty Hall; may be freely used or adapted.
 */

public class ShowSession extends HttpServlet {
  public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(true);
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    String title = "Searching the Web";
    String heading;
    Integer accessCount = new Integer(0);;
    if (session.isNew()) {
      heading = "Welcome, Newcomer";
    } else {
      heading = "Welcome Back";
      Integer oldAccessCount =
        // Use getAttribute, not getValue, in version
        // 2.2 of servlet API.
        (Integer)session.getValue("accessCount");
      if (oldAccessCount != null) {
        accessCount =
          new Integer(oldAccessCount.intValue() + 1);
      }
    }
    // Use putAttribute in version 2.2 of servlet API.
    session.putValue("accessCount", accessCount);

    out.println("&lt;BODY BGCOLOR=\"#FDF5E6\"&gt;\n" +
                "&lt;H1 ALIGN=\"CENTER\"&gt;" + heading + "&lt;/H1&gt;\n" +
                "&lt;H2&gt;Information on Your Session:&lt;/H2&gt;\n" +
                "&lt;TABLE BORDER=1 ALIGN=CENTER&gt;\n" +
                "&lt;TR BGCOLOR=\"#FFAD00\"&gt;\n" +
                "  &lt;TH&gt;Info Type&lt;TH&gt;Value\n" +
                "&lt;TR&gt;\n" +
                "  &lt;TD&gt;ID\n" +
                "  &lt;TD&gt;" + session.getId() + "\n" +
                "&lt;TR&gt;\n" +
                "  &lt;TD&gt;Creation Time\n" +
                "  &lt;TD&gt;" + new Date(session.getCreationTime()) + "\n" +
                "&lt;TR&gt;\n" +
                "  &lt;TD&gt;Time of Last Access\n" +
                "  &lt;TD&gt;" + new Date(session.getLastAccessedTime()) + "\n" +
                "&lt;TR&gt;\n" +
                "  &lt;TD&gt;Number of Previous Accesses\n" +
                "  &lt;TD&gt;" + accessCount + "\n" +
                "&lt;/TABLE&gt;\n" +
                "&lt;/BODY&gt;&lt;/HTML&gt;");

  }

  public void doPost(HttpServletRequest request,
                     HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }
}

