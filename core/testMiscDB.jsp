<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.io.IOException"%>
<%@ page import="com.snowtide.pdf.OutputTarget"%>
<%@ page import="com.snowtide.pdf.PDFTextStream"%>

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
		<form method="post" action="shwfldx.jsp" name="aseForm">
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

	String campus = "MAN";
	String alpha = "AEC";
	String num = "110";
	String type = "ARC";
	String user = "ANNIE";
	String task = "Modify_outline";
	String kix = "w18f9d12161";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			String val = "";
			String descr = "";

			out.println("starting...<br>");

			MiscDB.getMisc(conn,user);
			MiscDB.getReviewMisc(conn,kix);
			MiscDB.deleteMisc(conn,kix);
			MiscDB.deleteReviewMisc(conn,kix);
			MiscDB.deleteStickyMisc(conn,kix);
			MiscDB.deleteStickyMisc(conn,kix,user);
			MiscDB.insertSitckyNotes(conn,kix,user,val);
			MiscDB.getStickyNotes(conn,kix,user);
			MiscDB.getMiscByHistoryUserID(conn,campus,kix,user);
			MiscDB.getEdit1(conn,kix);
			MiscDB.getEdit2(conn,kix);
			MiscDB.getEnabledItems(conn,kix,1);
			MiscDB.getEnabledItemsCSV(conn,kix,2);
			MiscDB.getCourseEditFromMiscEdit(conn,campus,kix,1);
			MiscDB.getCourseEditFlags(conn,campus,kix,1);
			MiscDB.getProgramEdit1(conn,kix);
			MiscDB.getProgramEdit2(conn,kix);
			MiscDB.getProgramEnabledItems(conn,kix);
			MiscDB.getProgramEditFromMiscEdit(conn,campus,kix,1);
			MiscDB.getMiscNote(conn,kix,descr);
			MiscDB.deleteMiscNote(conn,kix,descr);
			MiscDB.getColumn(conn,kix,"edited1");
			MiscDB.getColumn(conn,kix,"edited2");

			MiscDB.insertMisc(conn,campus,kix,alpha,num,"PRE",Constant.OUTLINE_MODIFICATION,
									"editSystem","auditby");

			MiscDB.insertMisc(conn,campus,kix,alpha,num,"PRE",Constant.OUTLINE_MODIFICATION,
									"editSystem","auditby","1","20");

			out.println("ending...<br>");

		}
		catch(Exception e){
			out.println(e.toString());
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
