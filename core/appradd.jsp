<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	appradd.jsp	add routing
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String disabled = "";

	int route = website.getRequestParameter(request,"rte",0);
	String shortName = "";
	String longName = "";
	String college = "";
	String dept = "";
	String level = "";

	String pageTitle = "Add Approval Routing";

	if (route > 0){
		pageTitle = "Edit Approval Routing";
		disabled = "disabled";

		Ini ini = IniDB.getINI(conn,route);
		if (ini != null){
			shortName = ini.getKid();
			longName = ini.getKdesc();
			college = ini.getKval1();
			dept = ini.getKval2();
			level = ini.getKval3();
		}
	}

	fieldsetTitle = pageTitle;

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether college codes are displayed (EnableCollegeCodes)");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/appradd.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			out.println("<form name=\"aseForm\" method=\"post\" action=\"appraddx.jsp\">");

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			String enableCollegeCodes = Util.getSessionMappedKey(session,"EnableCollegeCodes");
			if(enableCollegeCodes.equals(Constant.ON)){
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>College Code:&nbsp;</td>" );
				out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
				String sql = aseUtil.getPropertySQL(session,"college");
				out.println(aseUtil.createSelectionBox( conn, sql, "college", college, false) + "</td>" );
				out.println("			</tr>" );

				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>Department:&nbsp;</td>" );
				out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
				sql = aseUtil.getPropertySQL(session,"bannerdepartment");
				out.println(aseUtil.createSelectionBox( conn, sql, "dept", dept, false) + "</td>" );
				out.println("			</tr>" );

				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>Level Code:&nbsp;</td>" );
				out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
				sql = aseUtil.getPropertySQL(session,"level");
				out.println(aseUtil.createSelectionBox( conn, sql, "level", level, false) + "</td>" );
				out.println("			</tr>" );
			}
			else{
				out.println("<input type=\"hidden\" name=\"college\" id=\"college\" value=\"\">");
				out.println("<input type=\"hidden\" name=\"dept\" id=\"dept\" value=\"\">");
				out.println("<input type=\"hidden\" name=\"level\" id=\"level\" value=\"\">");
			}

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>New Routing Short Name:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap><input type=\"text\" "+disabled+" class=\"input\" value=\""+shortName+"\" name=\"shortName\" size=\"50\" maxlength=\"50\"></td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>New Routing Long Name:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap><input type=\"text\" "+disabled+" class=\"input\" value=\""+longName+"\" name=\"longName\" size=\"50\" maxlength=\"50\"></td>" );
			out.println("			</tr>" );

			// ER00027 - 2011.12.05
			// approval with division chair sequence
			String ApprovalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");
			if (ApprovalSubmissionAsPackets.equals(Constant.ON)){

				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>Assoc. Div/Dept:&nbsp;</td>" );
				out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );

				out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top width=\"40%\">");
				out.println(DivisionDB.getDivisionsForRouting(conn,campus,route));
				out.println("					</td>" );
				out.println("					 <td class=\'textblackTH\' valign=\'middle\' width=\"20%\">" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   <   \" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   >   \" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
				out.println("					 </td>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top width=\"40%\">");
				out.println(DivisionDB.getDivisionToRouting(conn,route));
				out.println("					</td>" );
				out.println("				</tr>" );
				out.println("</table>" );

				out.println("				 </td>" );
				out.println("			</tr>" );

			} // sysadm

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
			out.println("<input type=\'hidden\' name=\'rte\' value=\'"+route+"\'>" );
			out.println("<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
			out.println("<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("<input type=\'hidden\' name=\'formAction\' value=\'q\'>" );
			out.println("<input name=\"aseSubmit\" id=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Submit\" onClick=\"return checkForm('s')\">");
			out.println("<input name=\"aseCancel\" id=\"aseCancel\" class=\"inputsmallgray\" type=\"submit\" value=\"Cancel\" onClick=\"return cancelForm("+route+")\">");
			out.println("				 </td>" );
			out.println("			</tr>" );

			out.println("	</table>" );

			out.println("</form>");
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"appradd",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
