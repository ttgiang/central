<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ntf.jsp
	*	2007.09.01	notification maintenance
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "Notification Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/ntf.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		int lid = 0;
		String propName = "";
		String descr = "";
		String subject = "";
		String content = "";
		String cc = "";
		String auditby = "";
		String auditdate = "";

		lid = website.getRequestParameter(request,"lid",0);
		if (lid>0){
			Props prop = PropsDB.getProp(conn,lid);
			if (prop != null){
				propName = prop.getPropName();
				descr = prop.getPropDescr();
				subject = prop.getSubject();
				content = prop.getContent();
				cc = prop.getCC();
				auditby = prop.getAuditBy();
				auditdate = prop.getAuditDate();
			}
		}
		else{
			lid = 0;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = user;
		}
		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/boba\'>" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );
		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">ID:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + lid + "</td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Property:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + propName +"</td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Description:&nbsp;</td>" );
		out.println("					 <td class=\'datacolumn\'><input name=\'descr\' type=\'hidden\' value=\'" + descr +"\'>" + descr + "</td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Subject:&nbsp;</td>" );
		out.println("					 <td><input size=\'100\' maxlength=\"100\" class=\'input\'  name=\'subject\' type=\'text\' value=\'" + subject +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Body:&nbsp;</td>" );
		out.println("					 <td>" );

		String ckName = "content";
		String ckData = content;

%>
<%@ include file="ckeditor02.jsp" %>
<%

		out.println("					</td>" );
		out.println("				</tr>" );

		out.println("					 <input name=\'cc\' type=\'hidden\' value=\'" + cc +"\'>" );

		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Campus:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + campus + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Updated By:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditby + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\"textblackth\">Updated Date:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditdate + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><div class=\"hr\"></div>" );
		out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
		out.println("							<input name=\'prop\' type=\'hidden\' value=\'" + propName + "\'>" );

		if ( lid > 0 ){
			//out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			//out.println("							<input type=\'submit\' name=\'asePreview\' value=\'Preview\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			//out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr><td colspan=\"2\"><div class=\"hr\"></div></td></tr>" );

		out.println("				<tr>" );
		out.println("					 <td nowrap>Defaults:&nbsp;</td>" );
		out.println("					 <td><ul>"
							+ "<li>[ALPHA] - course alpha</li>"
							+ "<li>[NUM] - course number</li>"
							+ "</ul>");
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}

	asePool.freeConnection(conn,"ntf",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
