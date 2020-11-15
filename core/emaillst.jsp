<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	emaillst.jsp	Create email distribution list
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","emaillst");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Email Distribution List";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/personalemaillist.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/emaillst.js"></script>
</head>
<body topmargin="0" leftmargin="0" onload="showDistribution('<%=campus%>');">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		String auditby = "";
		String auditdate = "";
		String listName = "";
		String members = "";
		String sql = "";

		int lid = website.getRequestParameter(request,"lid",0);
		EmailLists emailList = new EmailLists();
		if (lid > 0){
			emailList = EmailListsDB.getEmailList(conn,lid);
			if (emailList != null){
				listName = emailList.getTitle();
				members = EmailListsDB.getEmailListMembers(conn,lid);
				auditby = emailList.getAuditBy();
				auditdate = emailList.getAuditDate();
			}
		}
		else{
			lid = 0;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = user;
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\"/central/servlet/tadao\">" );
		out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap colspan=4><br /><p align=\'center\'>Select names for your email distribution list</p><br /></td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>List Name:&nbsp;</td>" );
		out.println("					 <td colspan=\'3\'>" );
		out.println("						<input type=\'text\' name=\'listName\' value=\'" + listName + "\' class=\'input\' size=\'30\'>" );
		out.println("				</td></tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
		out.println("					 <td colspan=\'3\'class=\'datacolumn\' >" );
		out.println(campus);
		out.println("				</td></tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Users:&nbsp;</td>" );
		out.println("					 <td class=\'textblackTH\' nowrap valign=top>"
			+ DistributionDB.getCampusUsersNotInListDDL(conn,campus,NumericUtil.getInt(lid,0))
				+ "</td>" );
		out.println("					 <td class=\'textblackTH\' valign=\'middle\'>" );
		out.println( "<input type=\"button\" class=\"inputsmallgray80\" value=\"Remove\" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmd2\"><br/><br/>" );
		out.println( "<input type=\"button\" class=\"inputsmallgray80\" value=\"Add\" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmd1\">" );
		out.println("					 </td>" );

		out.println("					 <td class=\'textblackTD\' valign=\'middle\'>"
			+ DistributionDB.getEmailListMembersDDL(conn,campus,NumericUtil.getInt(lid,0))
			+ "</td>" );

		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Audit By:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\' colspan=\'3\'>" + auditby + "</td></tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Audit Date:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\' colspan=\'3\'>" + auditdate + "</td></tr>" );

		// form buttons
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
		out.println("							<input type=\'hidden\' name=\'lid\' value=\'" + lid + "\'>" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
		out.println("							<input type=\'hidden\' name=\'campus\' value=\'"+campus+"\'>" );

		if ( lid > 0 ){
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
			out.println("							<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"emaillst",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

