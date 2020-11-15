<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sndr.jsp	mail test
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "70%";
	String pageTitle = "eMail";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/sndr.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String user = website.getRequestParameter(request,"aseUserName","",true);

	try{
		out.println("		<form method=\'post\' name=\'aseForm\' action=\'sndrx.jsp\'>" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\' class=\"reference\" >" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">From:&nbsp;</td>" );
		out.println("					 <td><input size=\'70\' class=\'input\' name=\'from\' id=\'from\' type=\'text\' value=\'"+user+"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">To:&nbsp;</td>" );
		out.println("					 <td><input size=\'70\' class=\'input\' name=\'to\' id=\'to\' type=\'text\' value=\'\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">CC:&nbsp;</td>" );
		out.println("					 <td><input size=\'70\' class=\'input\' name=\'cc\' id=\'cc\' type=\'text\' value=\'\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Subject:&nbsp;</td>" );
		out.println("					 <td><input size=\'70\' class=\'input\' name=\'subject\' id=\'subject\' type=\'text\' value=\'\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Message:&nbsp;</td>" );
		out.println("					 <td>" );

		String ckName = "content";
		String ckData = "";
%>
	<%@ include file="ckeditor02.jsp" %>
<%
		out.println("					</td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">SMTP:&nbsp;</td>" );
		out.println("					 <td>" );
		out.println("<select class=\"inputsmall\" name=\"smtp\">");
		out.println("<option value=\"\">-select-</option>");
		out.println("<option value=\"mail.hawaii.edu\" selected>Hawaii</option>");
		out.println("<option value=\""+Constant.SMTP_05045+"\">05045</option>");
		out.println("<option value=\""+Constant.SMTP_B6400+"\">B6400</option>");
		out.println("<option value=\""+Constant.SMTP_SZHI03+"\">SZHI03</option>");
		out.println("</select>");
		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Debug:&nbsp;</td>" );
		out.println("					 <td><input type=\"checkbox\" name=\'debug\' id=\'debug\' value=\'1\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td colspan=\'2\' align=\"right\"><div class=\"hr\"></div>" );
		out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Send\' class=\'inputsmallgray\'>" );
		out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

<p>
<font class="textblackth">Note:</font> default domain @hawaii.edu
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
