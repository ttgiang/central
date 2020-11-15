<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

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

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campus = website.getRequestParameter(request,"cps","");
	String kix = website.getRequestParameter(request,"kix","");

	out.println("Start<br/><br/>This page cleans code where the script tag was saved with content due to browser hack.<br><br>");

	if (processPage){

		try{
			/*

			SELECT     campus, historyid, type, seq, progress, degreeid, divisionid, effectivedate, title, descr, outcomes, functions, organized, enroll, resources, efficient, effectiveness,
										 proposed, rationale, substantive, articulated, additionalstaff, requiredhours, auditby, auditdate, hid, proposer, votefor, voteagainst, voteabstain, reviewdate,
										 comments, datedeleted, dateapproved, regents, regentsdate, route, subprogress, edit, edit0, edit1, edit2, reason, p14, p15, p16, p17, p18, p19, p20
			FROM         tblPrograms
			WHERE     (title LIKE '%adw95%')
			OR (descr LIKE '%adw95%')
			OR (outcomes LIKE '%adw95%')
			OR (functions LIKE '%adw95%')
			OR (organized LIKE '%adw95%')
			OR (enroll LIKE '%adw95%')
			OR (resources LIKE '%adw95%')
			OR (efficient LIKE '%adw95%')
			OR (effectiveness LIKE '%adw95%')
			OR (proposed LIKE '%adw95%')
			OR (rationale LIKE '%adw95%')
			OR (substantive LIKE '%adw95%')
			OR (articulated LIKE '%adw95%')
			OR (additionalstaff LIKE '%adw95%')
			OR (requiredhours LIKE '%adw95%')

			*/

			if(campus != "" && kix != ""){
				com.ase.aseutil.db.Cleaner cleaner = new com.ase.aseutil.db.Cleaner();
				out.println(cleaner.cleaner(conn,campus,kix));
				cleaner = null;
			}
			else{
				out.println("Invalid data to clean. Provide cps & kix to process page.");
			}

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	out.println("<br><br>return to <a href=\"ccutil.jsp\" class=\"linkcolumn\">CC</a>");

	out.println("<br/><br/>End");

	asePool.freeConnection(conn,"cleaner",user);
%>


</form>
		</td>
	</tr>
</table>

</body>
</html
