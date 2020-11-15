<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>

<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}


	System.out.println("Start<br/>");

	if (processPage){

		FileOutputStream fsout;
		PrintStream ps;
		try {
			// Create a new file output stream
			fsout = new FileOutputStream("c:\\tomcat\\webapps\\central\\core\\textdiff.txt");

			// Connect print stream to the output stream
			ps = new PrintStream(fsout);

			com.ase.textdiff.Report report = new com.ase.textdiff.TextDiff().compare( "c:\\tomcat\\webapps\\central\\core\\test.jsp", "c:\\tomcat\\webapps\\central\\core\\test.bak" );
			report.print(ps);
			ps.close();
		}
		catch (Exception e){
			System.err.println ("Error in writing to file");
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html