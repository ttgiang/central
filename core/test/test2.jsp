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
	String alpha = "ICS";
	String num = "100";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");
	String kix = "1000kix";

	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Attachments";

	int seq = website.getRequestParameter(request,"seq",0);
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
		try{
			out.println("	<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' id=\"upload_files\" name=\'aseForm\' enctype=\"multipart/form-data\" action=\'test2x.jsp\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td colspan=\"2\" class=\'dataColumnCenter\'><strong>" +  pageTitle + "</strong>");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td valign=\"top\" width=\"12%\">Description:</td>" );
			out.println("				 <td valign=\"top\"><input type=\"text\" name=\"fileTitle\" id=\"fileTitle\" class=\"upload\" /></td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td valign=\"top\" width=\"12%\">Attachment*:</td>" );
			out.println("				 <td valign=\"top\"><input type=\"file\" name=\"fileName\" id=\"fileName\" class=\"upload\" />"
				+ "<input type=\"checkbox\" name=\"replace\" id=\"replace\" checked=\"checked\" /> Replace if it already exists?</td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td colspan=\"2\"><p align=\"center\"><br/><br/><font class=\"textblackth\">*Files may not exceed 4MB in size</font></p></td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td colspan=\"2\" align=\"right\">" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'user\' value=\'" + user + "\'>" );
			out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"save content\" type=\'submit\' name=\'aseUpload\' value=\'Upload\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseClose\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"')\">" );
			out.println("			</td></tr>" );

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

	asePool.freeConnection(conn);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
