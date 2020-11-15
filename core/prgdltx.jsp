<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgdltx.jsp - delete program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "80%";
	fieldsetTitle = "Delete Program";
	String pageTitle = fieldsetTitle;

	String kix = website.getRequestParameter(request,"lid", "");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String auditby = "";
	String auditdate = "";
	String title = "";
	String effectiveDate = "";
	String description = "";

	int items = 0;

	if (processPage){
		try{
			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			Programs program = new Programs();
			if (!"".equals(kix)){
				program = ProgramsDB.getProgram(conn,campus,kix);
				if ( program != null ){
					title = program.getTitle();
					effectiveDate  = program.getEffectiveDate();
					auditby = program.getAuditBy();
					auditdate = program.getAuditDate();
					description = program.getDescription();
					pageTitle = title + " - " + effectiveDate;
				}
			}
			else{
				kix = "";
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/prgdltx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'prgdltxx.jsp\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			// title
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' width=\"15%\">Title:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + title +"</td>" );
			out.println("				</tr>" );

			// description
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Description:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + description + "</td>" );
			out.println("				</tr>" );

			// effective date
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Effective Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + effectiveDate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + campus + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><div class=\"hr\"></div>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input type=\'submit\' name=\'aseDelete\' id=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // if processPage

	asePool.freeConnection(conn,"prgdltx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
