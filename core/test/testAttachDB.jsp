<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "SPOPE";
	String task = "Modify_outline";
	String kix = "U2l17m9166";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{

			Attach attach = new Attach();

			out.println(Html.BR() + AttachDB.isMatch(conn,"appx.xls"));
			out.println(Html.BR() + AttachDB.getAttachmentAsHTMLList(conn,kix));
			out.println(Html.BR() + AttachDB.getContentForEdit(conn,kix));
			out.println(Html.BR() + AttachDB.getFileAttachmentID(conn,campus,kix,"appx.xls"));
			out.println(Html.BR() + AttachDB.insertAttachment(conn,attach));
			out.println(Html.BR() + AttachDB.getAttachment(conn,kix,105));
			out.println(Html.BR() + AttachDB.deleteAttachment(conn,kix,105));
			out.println(Html.BR() + AttachDB.deleteUpload(conn,campus,"",105));
			out.println(Html.BR() + AttachDB.getNextAttachmentID(conn));
			out.println(Html.BR() + AttachDB.attachmentExists(conn,kix));
			out.println(Html.BR() + AttachDB.getNextVersionNumber(conn,campus,kix,alpha,num,"appx.xls"));
			out.println(Html.BR() + AttachDB.listAttachmentsVersions(conn,campus,kix,105,"r1","r2"));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>