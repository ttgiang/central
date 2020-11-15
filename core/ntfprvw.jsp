<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ntfprvw.jsp
	*	2007.09.01	notification preview
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "Notification Preview";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/ntfprvw.js"></script>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>

	<script type="text/javascript">
		function FCKeditor_OnComplete(editorInstance) {
			window.status = editorInstance.Description;
		}
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		int lid = 0;
		String propName = "";
		String subject = "";
		String content = "";
		String property = "";
		String kix = "";
		String cc = "";
		String campus = website.getRequestParameter(request,"aseCampus","",true);

		lid = website.getRequestParameter(request,"lid",0);
		if ( lid > 0 ){
			kix = helper.getKix(conn,campus,"ENG","100","CUR");
			Props prop = PropsDB.getFullPropFromID(conn,campus,lid);
			if (prop != null){
				propName = prop.getPropName();
				subject = prop.getSubject();
				content = prop.getContent();
			}

			if (subject != null && subject.length() > 0){
				subject = subject.replace("[ALPHA]","ENG");
				subject = subject.replace("[NUM]","100");
			}

			if (content != null && content.length() > 0){
				content = content.replace("[ALPHA]","ENG");
				content = content.replace("[NUM]","100");
			}
		}
		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/boba\'>" );
		out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' height=\"30\" valign=\"top\">From:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\" height=\"30\" valign=\"top\">" + user +"</td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' height=\"30\" valign=\"top\">To:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\" height=\"30\" valign=\"top\">" + user +"</td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' height=\"30\" valign=\"top\">Subject:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\" height=\"30\" valign=\"top\">CC: " + subject +"</td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' height=\"30\" valign=\"top\">Content:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\" height=\"30\" valign=\"top\">"
								+ content
								+ "<br><br>Log in to <a href=\"\" target=\"_blank\">Curriculum Central</a>."
								+ "<br><br><strong>NOTE:</strong> This is an automated response. Do not reply to this message.");
		out.println("				</td></tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
		out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
		out.println("							<input name=\'prop\' type=\'hidden\' value=\'" + propName + "\'>" );

		out.println("							<input type=\'submit\' name=\'aseSend\' value=\'Send\' class=\'inputsmallgray\'>" );
		out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );

		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}

	asePool.freeConnection(conn,"ntfprvw",user);
%>



<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
