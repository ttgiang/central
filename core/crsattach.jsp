<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsattach.jsp	course attachment
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	int currentTab = Constant.TAB_ATTACHMENT;
	int currentNo = 0;

	String kix = website.getRequestParameter(request,"kix","");
	if (kix == null || kix.equals(Constant.BLANK)){
		kix = (String)session.getAttribute("aseKix");
	}

	if (kix != null && !kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}

	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Attachments";

	int id = website.getRequestParameter(request,"id",0);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script type="text/javascript" src="js/crsattach.js"></script>

	<style type="text/css">
		.upload_field { width: 90%; display: block; }
		em.alt { color: #999; }
		#upload_files fieldset { border: 1px solid #ccc; -moz-border-radius: 7px; -webkit-border-radius: 7px; }
		#upload_files legend { font-size: 1.2em; }
		fieldset.alt { background-color: #f7f7ff; }
	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (caller.equals("crsedt") || caller.equals("crsfldy")){
		try{
			out.println("	<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' id=\"aseForm\" name=\'aseForm\' enctype=\"multipart/form-data\" action=\'/central/servlet/kuri\'>" );

			out.println("			<tr>" );
			out.println("					 <td colspan=\"2\" class=\'dataColumnCenter\'><strong>" +  pageTitle + "</strong>");
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td valign=\"top\" width=\"12%\" class=\"textblackth\">Description:</td>" );
			out.println("				 <td valign=\"top\"><input type=\"text\" name=\"fileTitle\" id=\"fileTitle\" class=\"upload\" maxlength=\"100\" /></td>" );
			out.println("			</tr>" );

			out.println("			<tr>" );
			out.println("				 <td valign=\"top\" width=\"12%\" class=\"textblackth\">Attachment*:</td>" );
			out.println("				 <td valign=\"top\"><input type=\"file\" name=\"fileName\" id=\"fileName\" class=\"upload\" />");
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td colspan=\"2\" align=\"right\">" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'r2\' value=\'crsattach\'>" );
			out.println("					<input type=\'hidden\' name=\'id\' value=\'" + id + "\'>" );
			out.println("					<input type=\'hidden\' name=\'category\' value=\'Outline\'>" );
			out.println("					<input type=\'hidden\' name=\'req\' value=\'upload\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"save content\" type=\'submit\' name=\'aseUpload\' value=\'Upload\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseClose\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+caller+"','"+kix+"','"+currentTab+"','"+currentNo+"')\">" );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td colspan=\"2\">"
				+ "<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
				+ "<p align=\"center\"><br/><br/>uploading attachment...<img src=\"../images/spinner.gif\" alt=\"uploading attachment...\" border=\"0\"></p>"
				+ "</div>");
			out.println("</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td colspan=\"2\">"
				+ "<div class=\"hr\"></div>"
				+ "<p align=\"center\">"
				+ "<font class=\"textblackth\">*Files may not exceed 10MB in size</font>"
				+ "<p align=\"left\"><font class=\"textblackth\">NOTE:</font> <font class=\"datacolumn\">Uploading attachments with similar names result in a FILE REPLACE action."
				+ "To maintain multiple versions of the same document, rename your document before uploading again.</font>"
				+ "</p></td>" );
			out.println("			</tr>" );

			out.println("		</form>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );
			out.println(AttachDB.getContentForEdit(conn,kix));
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
