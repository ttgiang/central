<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsass.jsp
	*	2007.09.01	assessment maintenance. Works with crsassidx
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "Assessment Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsass.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		int lid = 0;
		String assessment = "";
		String auditby = "";
		String auditdate = "";
		String sql;
		boolean canDelete = false;

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		// make sure we have and id to work with. if one exists,
		// it has to be greater than 0
		if ( request.getParameter("lid") != null ){
			lid = Integer.parseInt(request.getParameter("lid"));
			if (lid > 0){
				Assess assess = AssessDB.getAssessment(conn,lid);
				assessment = assess.getAssessment();
				auditby = assess.getAuditBy();
				auditdate = assess.getAuditDate();
				assess = null;

				canDelete = AssessDB.isDeletable(conn,lid);
			}
			else{
				lid = 0;
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/ases\'>" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>ID:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + lid + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Assessment:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'><textarea name=\'assessment\' cols=\'80\' rows=\'10\' class=\'input\'>" + assessment + "</textarea></td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + campus + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + auditby + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + auditdate + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );

		if ( lid > 0 ){
			out.println("							<input title=\"save entered data\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

			if (canDelete)
				out.println("							<input title=\"delete entered data\" type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );

			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			out.println("							<input title=\"insert entered data\" type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input title=\"cancel selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("<br/><br/><p align=\"left\" class=\'normaltext\'>Delete is available only if the above assessment hasn't been tied other data</p></td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
