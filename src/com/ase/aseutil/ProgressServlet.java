/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// ProgressServlet.java
//
package com.ase.aseutil;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.report.ReportGeneric;
//import com.ase.aseutil.report.ReportOutline;
import com.itextpdf.text.DocumentException;

public class ProgressServlet extends HttpServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(ProgressServlet.class.getName());

	/**
	 * This class will keep a Pdf file
	 *
	 * @author ttgiang
	 */
	public class MyPdf implements Runnable {

		/** the ByteArrayOutputStream that holds the PDF data. */
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		/** the percentage of the PDF file that is finished */
		int p = 0;

		/**
		 * @see java.lang.Runnable#run()
		 */
		public void run() {
			try {
				while (p < 99) {
					Thread.sleep(100);
					p++;
				}
			} catch (InterruptedException e) {
				p = -1;
				logger.fatal("ProgressServlet: " + e.toString());
			}
			p = 100;
		}

		/**
		 * Gets the complete PDF data
		 *
		 * @return the PDF as an array of bytes
		 * @throws DocumentException
		 *             when the document isn't ready yet
		 */
		public ByteArrayOutputStream getPdf() throws DocumentException {
			if (p < 100) {
				throw new DocumentException("The document isn't finished yet!");
			}
			return baos;
		}

		/**
		 * Gets the current percentage of the file that is done.
		 *
		 * @return a percentage or -1 if something went wrong.
		 */
		public int getPercentage() {
			return p;
		}
	}

	/**
	**
	**/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	**
	**/
	public void destroy() {
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		Object o = session.getAttribute("myPdf");
		MyPdf pdf;
		if (o == null) {
			pdf = new MyPdf();
			session.setAttribute("myPdf", pdf);
			Thread t = new Thread(pdf);
			t.start();

			String rpt = (String)session.getAttribute("aseReport");

			// by default, we get here by saving the report name to session.
			// however, when providing the link to a report, we send the
			// report name via the query string.
			WebSite ws = new WebSite();
			if (rpt == null || rpt.length() == 0){
				rpt = ws.getRequestParameter(request,"rpt","");
				session.setAttribute("aseReport",rpt);
			}
			ws = null;

			ReportGeneric rg = new ReportGeneric();
			rg.runReport(request,response);
			rg = null;

		} else {
			pdf = (MyPdf) o;
		}

		response.setContentType("text/html");

		switch (pdf.getPercentage()) {
			case -1:
				isError(response.getOutputStream());
				return;
			case 100:
				isFinished(response.getOutputStream());
				session.removeAttribute("myPdf");
				return;
			default:
				isBusy(pdf,request,response);
				return;
		}
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		// We get a Session object
		HttpSession session = request.getSession(false);
		try {
			MyPdf pdf = (MyPdf)session.getAttribute("myPdf");
			session.removeAttribute("myPdf");
			ByteArrayOutputStream baos = pdf.getPdf();

			// setting some response headers
			response.setHeader("Expires", "0");
			response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");

			// setting the content type
			response.setContentType("application/pdf");

			// the contentlength is needed for MSIE!!!
			response.setContentLength(baos.size());

			// write ByteArrayOutputStream to the ServletOutputStream
			ServletOutputStream out = response.getOutputStream();
			baos.writeTo(out);
			out.flush();

		} catch (Exception e) {
			isError(response.getOutputStream());
		}
	}

	/**
	 * Sends an HTML page to the browser saying how many percent of the document
	 * is finished.
	 *
	 * @param pdf
	 *            the class that holds the PDF
	 * @param stream
	 *            the outputstream of the servlet
	 * @throws IOException
	 */
	private void isBusy2(MyPdf pdf, ServletOutputStream stream) throws IOException {
		stream.print("<html>\n\t<head>\n\t\t<title>Please wait...</title>\n\t\t<meta http-equiv=\"Refresh\" content=\"5\">\n\t</head>\n\t<body>");
		stream.print("<div style=\"visibility:visible; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
						+ "<p align=\"center\"><br/><br/><img src=\"../images/spinner.gif\" alt=\"processing...\" border=\"0\">"
						+ "<br/>processing "
						+ String.valueOf(pdf.getPercentage())
						+ " of 100%.</p>"
						+ "</div>");
	}

	public void isBusy(MyPdf pdf,
							HttpServletRequest request,
							HttpServletResponse response) throws IOException {

		ServletOutputStream stream = response.getOutputStream();

		HttpSession session = request.getSession(true);

      stream.print("<html>");
      stream.print("<head><meta http-equiv=\"Refresh\" content=\"5\">");

		String styleSheet = "bluetabs";

      stream.print("");
      stream.print("<title>");
      stream.print((String)session.getAttribute("aseApplicationTitle"));
      stream.print(':');
      stream.print(' ');
      stream.print("Processing...");
      stream.print("</title>");
      stream.print("<script type=\"text/javascript\" src=\"");
      stream.print(request.getContextPath());
      stream.print("/inc/dropdowntabs.js\"></script>");
      stream.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      stream.print(request.getContextPath());
      stream.print("/inc/style.css\">");
      stream.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      stream.print(request.getContextPath());
      stream.print("/inc/");
      stream.print(styleSheet);
      stream.print(".css\" />");
      stream.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      stream.print(request.getContextPath());
      stream.print("/inc/site.css\" />");
      stream.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      stream.print(request.getContextPath());
      stream.print("/inc/ase.css\" />");
      stream.print("");

		response.setDateHeader("Expires", 0); // date in the past
		response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.addHeader("Pragma", "no-cache"); // HTTP/1.0
		session.setMaxInactiveInterval(30*60);

      stream.print("");
      stream.print("</head>");
      stream.print("<body topmargin=\"0\" leftmargin=\"0\">");
      stream.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\" height=\"100%\">");
      stream.print("\t<tbody>");
      stream.print("\t\t<tr>");
      stream.print("\t\t\t<td bgcolor=\"#ffffff\" valign=\"top\" height=\"100%\">");
      stream.print("\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" height=\"100%\" background=\"images/stripes.png\">");
      stream.print("\t\t\t\t\t<!-- header -->");
      stream.print("\t\t\t\t\t<tr>");
      stream.print("\t\t\t\t\t\t<td class=\"intd\" height=\"05%\">");
      stream.print("\t\t\t\t\t\t\t");
      stream.print("<table border=\"0\" width=\"100%\" id=\"asetable2\" cellspacing=\"0\" cellpadding=\"3\">");
      stream.print("\t<tr class=\"");
      stream.print((String)session.getAttribute("aseBGColor"));
      stream.print("BGColor\">");
      stream.print("\t\t<td valign=\"top\">");
      stream.print("\t\t\t");

		int userLevel = NumericUtil.getNumeric(session,"aseUserRights");
		String aseServer = (String)session.getAttribute("aseServer");

		// -------------------------------------------------
		// MAIN
		// -------------------------------------------------
		stream.println("<div id=\"bluemenu\" class=\"" + styleSheet + "\">");
		stream.println("<ul>");

		String headerCampus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		if (	(String)session.getAttribute("aseApplicationTitle") != null && headerCampus != null ) {

			stream.println("<li><a href=\"/central/core/index.jsp\">Home</a></li>" +
				"<li><a href=\"/central/core/tasks.jsp\">My Tasks</a></li>" +
				"<li><a href=\"/central/core/crs.jsp\" rel=\"course\">Course</a></li>");

			if (userLevel>=Constant.FACULTY){
				stream.println("<li><a href=\"/central/core/index.jsp\" rel=\"slo\">SLO</a></li>");

				stream.println("<li><a href=\"/central/core/ccrpt.jsp\" rel=\"report\">Reports</a></li>" +
					"<li><a href=\"/central/core/ccutil.jsp\" rel=\"utilities\">Utilities</a></li>" +
					"<li><a href=\"/central/core/index.jsp\" rel=\"banner\">Banner</a></li>");
			}

			stream.println("<li><a href=\"https://login.its.hawaii.edu/cas/logout?service=http://"
				+ aseServer
				+ ":8080/central/core/lo.jsp\">Log Out</a></li>");
		}
		else{
			stream.println("&nbsp;");
		}

		stream.println("<li><a href=\"/central/core/cchlp.jsp\" rel=\"help\">Help</a></li>");

		stream.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#ffffff\""
			+ (String)session.getAttribute("aseSystem") + "</font>");

		stream.println("</ul>");
		stream.println("</div>");

		stream.println("<div id=\"course\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"slo\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"banner\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"report\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"programs\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"utilities\" class=\"dropmenudiv\"></div>");
		stream.println("<div id=\"help\" class=\"dropmenudiv\"></div>");

		stream.print("");
		stream.print("\t\t</td>");
		stream.print("\t\t<td class=\"");
		stream.print((String)session.getAttribute("aseBGColor"));
		stream.print("BGColor\" align=\"right\">");
		stream.print("\t\t\t<font color=\"#c0c0c0\">Welcome: ");
		stream.print((String)session.getAttribute("aseUserFullName"));
		stream.print("");
		stream.print("\t\t\t(");
		stream.print((String)session.getAttribute("aseDept"));
		stream.print(")");
		stream.print("\t\t\t&nbsp;&nbsp;&nbsp;</font>");
		stream.print("\t\t</td>");
		stream.print("\t</tr>");
		stream.print("</table>");
		stream.print("");
		stream.print("\t\t\t\t\t\t</td>");
		stream.print("\t\t\t\t\t</tr>");
		stream.print("\t\t\t\t\t<!-- header -->");
		stream.print("\t\t\t\t\t<tr>");
		stream.print("\t\t\t\t\t\t<td class=\"intd\" height=\"90%\" align=\"center\" valign=\"top\">");
		stream.print("\t\t\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
		stream.print("\t\t\t\t\t\t\t\t<tr>");
		stream.print("\t\t\t\t\t\t\t\t\t<td align=\"center\" valign=\"top\">");
		stream.print("");
		stream.print("\t\t\t\t\t\t\t\t\t");

		stream.print("\t\t\t\t\t\t\t\t\t\t<!-- PAGE CONTENT GOES HERE -->");
		stream.print("\t\t\t\t\t\t\t\t\t\t<fieldset class=\"FIELDSET100\">");
		stream.print("\t\t\t\t\t\t\t\t\t\t\t<legend>");
		stream.print("Processing...");
		stream.print("</legend>");
		stream.print("\t\t\t\t\t\t\t\t\t\t\t<br>");
		stream.print("");
		stream.print('\r');
		stream.print('\n');

		stream.print("<div style=\"visibility:visible; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
						+ "<p align=\"center\"><br/><br/><img src=\"../images/spinner.gif\" alt=\"processing...\" border=\"0\">"
						+ "<br/><br/>"
						+ String.valueOf(pdf.getPercentage())
						+ "% complete</p>"
						+ "</div>");

		stream.print('\r');
		stream.print('\n');
		stream.print("\t\t\t\t\t\t\t\t\t\t</fieldset>");
		stream.print("\t\t\t\t\t\t\t\t\t\t<!-- PAGE CONTENT ENDS HERE -->");
		stream.print("\t\t\t\t\t\t\t\t\t</td>");
		stream.print("\t\t\t\t\t\t\t\t</tr>");
		stream.print("\t\t\t\t\t\t\t</table>");
		stream.print("\t\t\t\t\t\t</td>");
		stream.print("\t\t\t\t\t</tr>");
		stream.print("\t\t\t\t\t<!-- footer -->");
		stream.print("\t\t\t\t\t<tr>");
		stream.print("\t\t\t\t\t\t<td class=\"intd\" height=\"05%\">");
		stream.print("\t\t\t\t\t\t\t");
		stream.print("<table border=\"0\" cellpadding=\"3\" cellspacing=\"0\" height=\"22\" width=\"100%\">");
		stream.print("\t<tbody>");
		stream.print("\t\t<tr class=\"");
		stream.print((String)session.getAttribute("aseBGColor"));
		stream.print("BGColor\">");
		stream.print("\t\t");

		int yearFooter = 0;

		try{
			java.util.Date todayFooter = new java.util.Date();
			java.sql.Date dateFooter = new java.sql.Date(todayFooter.getTime());
			java.util.GregorianCalendar calFooter = new java.util.GregorianCalendar();
			calFooter.setTime(dateFooter);
			yearFooter = calFooter.get(java.util.Calendar.YEAR);
		}
		catch(Exception z){
		}

		stream.print("");
		stream.print("");
		stream.print("\t\t\t<td nowrap=\"nowrap\" class=\"copyright\" width=\"33%\">Copyright &copy; 1997-");
		stream.print(yearFooter);
		stream.print(". All rights reserved</td>");
		stream.print("\t\t\t<td align=\"center\" nowrap=\"nowrap\" class=\"copyright\" width=\"34%\">Curriculum Central - ");
		stream.print((String)session.getAttribute("aseCampusName"));
		stream.print("</td>");
		stream.print("\t\t\t<td align=\"right\" width=\"33%\">");
		stream.print("\t\t\t\t<a href=\"/central/core/contact.jsp\" class=\"linkcolumn\"><font class=\"copyright\">contact</font></a>");
		stream.print("\t\t\t\t<font class=\"copyright\">|</font>&nbsp;<a href=\"/central/core/support.jsp\" class=\"linkcolumn\"><font class=\"copyright\">support</font></a>");
		stream.print("\t\t\t\t<font class=\"copyright\">|</font>&nbsp;<a href=\"/central/core/hlpidx.jsp\" class=\"linkcolumn\"><font class=\"copyright\">help</font></a>");
		stream.print("\t\t\t\t");

		if ( (String)session.getAttribute("aseUserRights") != null &&
			Integer.parseInt((String)session.getAttribute("aseUserRights")) == 3 ){

			stream.print("");
			stream.print("\t\t\t\t\t<font class=\"copyright\">|</font>&nbsp;<a href=\"/central/core/sess.jsp\" class=\"linkcolumn\"><font class=\"copyright\">profile</font></a>");
			stream.print("\t\t\t\t");

		}

		stream.print("");
		stream.print("\t\t\t\t&nbsp;");
		stream.print("\t\t\t</td>");
		stream.print("\t\t</tr>");
		stream.print("\t</tbody>");
		stream.print("</table>");
		stream.print("");
		stream.print("\t\t\t\t\t\t</td>");
		stream.print("\t\t\t\t\t</tr>");
		stream.print("\t\t\t\t\t<!-- footer -->");
		stream.print("\t\t\t\t</table>");
		stream.print("\t\t\t</td>");
		stream.print("\t\t</tr>");
		stream.print("\t</tbody>");
		stream.print("</table>");
		stream.print("</body>");
		stream.print("</html>");
	}

	/**
	 * Sends an HTML form to the browser to get the PDF
	 *
	 * @param stream
	 *            the outputstream of the servlet
	 * @throws IOException
	 */
	private void isFinished(ServletOutputStream stream) throws IOException {
		stream.print("<html>\n\t<head>\n\t\t<title>Finished!</title>\n\t</head>\n\t<body>");
		stream.print("<div style=\"visibility:visible; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
						+ "<p align=\"center\"><br/><br/>processing...<img src=\"../images/spinner.gif\" alt=\"processing...\" border=\"0\"></p>"
						+ "</div>");
		stream.print("</body>\n</html>");
	}

	/**
	 * Sends an error message in HTML to the browser
	 *
	 * @param stream
	 *            the outputstream of the servlet
	 * @throws IOException
	 */
	private void isError(ServletOutputStream stream) throws IOException {
		stream
				.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
		stream.print("An error occured.\n\t</body>\n</html>");
	}
}