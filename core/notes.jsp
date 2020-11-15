<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	notes.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "70%";
	String pageTitle = "Notes Maintenance";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/approverinstructions.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/notes.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	int route = website.getRequestParameter(request,"rte", 0);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	try{
		String auditby = "";
		String auditdate = "";
		String note = "";
		String sql = "";

		if (route>0){
			Ini ini = IniDB.getINI(conn,route);
			auditby = ini.getKlanid();
			auditdate = ini.getKdate();
			note = ini.getNote();
		}
		else{
			route = 0;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = user;
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\"notesx.jsp\">" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' width=\"15%\">Note:&nbsp;</td>" );
		out.println("					 <td>" );

		//FCKeditor fckEditor = new FCKeditor(request,"note","600","400","ASE","","");
		//fckEditor.setValue(note);
		//out.println(fckEditor);

%>
		<textarea cols="80" id="note" name="note" rows="10"><%=note%></textarea>
		<script type="text/javascript">
			//<![CDATA[
				CKEDITOR.replace( 'note',
					{
						toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
											],
						enterMode : CKEDITOR.ENTER_BR,
						shiftEnterMode: CKEDITOR.ENTER_P
					});
			//]]>
			</script>
<%

		out.println("					</td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + campus + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditby + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditdate + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input name=\'route\' type=\'hidden\' value=\'" + route + "\'>" );

		out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

		if ("YES".equals(SysDB.getSys(conn,"sendMail")))
			out.println("							<input type=\'submit\' name=\'aseSubmitTest\' id=\'aseSubmit\' value=\'Submit & Test\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

		out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm();\">" );
		out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'s\'>" );
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

<br/>
NOTE:
<ul>
	<li>Submit saves notes and returns to approver sequence</li>
	<li>Submit & Test saves notes then sends a sample email (available only when email is enabled)</li>
	<li>Cancel aborts the operation</li>
</ul>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
