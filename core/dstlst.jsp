<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dstlst.jsp	Create distribution list
	*	TODO: populate selected names
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Distribution List";
	fieldsetTitle = pageTitle;
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/dstlst.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String auditby = "";
			String auditdate = "";
			String listName = "";
			String members = "";
			String sql = "";

			int lid = website.getRequestParameter(request,"lid",0);
			Distribution distribution = new Distribution();
			if ( lid > 0 ){
				distribution = DistributionDB.getDistribution(conn,lid);
				if (distribution != null){
					listName = distribution.getTitle();
					members = DistributionDB.getDistributionMembers(conn,lid);
					auditby = distribution.getAuditBy();
					auditdate = distribution.getAuditDate();
				}
			}
			else{
				lid = 0;
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\"/central/servlet/darth\">" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap colspan=4><br /><p align=\'center\'>Select names for your distribution list</p><br /></td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>List Name:&nbsp;</td>" );
			out.println("					 <td colspan=\'3\'>" );
			out.println("						<input type=\'text\' name=\'listName\' value=\'" + listName + "\' class=\'input\' size=\'30\'>" );
			out.println("				</td></tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Names:&nbsp;</td>" );
			out.println("					 <td class=\'textblackTH\' nowrap valign=top>" );
			boolean duplicate = false;
			out.println(CampusDB.getCampusUsers(conn,campus,members));
			out.println("</td>" );

			out.println("					 <td class=\'textblackTH\' valign=\'middle\'>" );
			out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   <   \" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmd2\"><br/><br/>" );
			out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   >   \" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmd1\">" );
			out.println("					 </td>" );
			out.println("					 <td class=\'textblackTD\' valign=\'middle\'>");

			out.println(DistributionDB.getDistributionMembersDDL(conn,campus,listName));

			out.println("</td>" );

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

			if ( lid > 0 ){
				//out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
				//out.println("							<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				//out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
