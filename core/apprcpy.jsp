<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprcpy.jsp	copy routing
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

	int route = website.getRequestParameter(request,"rte",0);

	String pageTitle = "Copy Approval Routing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/apprcpy.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			out.println("<form name=\"aseForm\" method=\"post\" action=\"apprcpyx.jsp\">");

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			String routingShortName = "";
			String routingLongName = "";
			String college = "";
			String dept = "";
			String level = "";

			if (route > 0){
				routingShortName = ApproverDB.getRoutingNameByID(conn,campus,route);
				routingLongName = ApproverDB.getRoutingFullNameByID(conn,campus,route);

				Ini ini = IniDB.getINI(conn,route);
				if(ini != null){
					college = ini.getKval1();
					dept = ini.getKval2();
					level = ini.getKval3();
				}
			}

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"30%\" height=\"30\" nowrap>Approval Routing Short/Long Name:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"70%\" height=\"30\" nowrap>" + routingShortName + " / " + routingLongName + "</td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>College Code:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
			String sql = aseUtil.getPropertySQL(session,"college");
			out.println(aseUtil.createSelectionBox( conn, sql, "college", college,false) + "</td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>Department:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
			sql = aseUtil.getPropertySQL(session,"bannerdepartment");
			out.println(aseUtil.createSelectionBox( conn, sql, "dept",dept,false) + "</td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"20%\" height=\"30\" nowrap>Level Code:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"80%\" height=\"30\" nowrap>" );
			sql = aseUtil.getPropertySQL(session,"level");
			out.println(aseUtil.createSelectionBox( conn, sql, "level", level,false) + "</td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"30%\" height=\"30\" nowrap>New Routing Short Name:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"70%\" height=\"30\" nowrap><input type=\"text\" class=\"input\" name=\"shortName\" size=\"50\" maxlength=\"50\"></td>" );
			out.println("			</tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"30%\" height=\"30\" nowrap>New Routing Long Name:&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"70%\" height=\"30\" nowrap><input type=\"text\" class=\"input\" name=\"longName\" size=\"50\" maxlength=\"50\"></td>" );
			out.println("			</tr>" );

			// ER00027 - 2011.12.05
			// approval with division chair sequence
			// when route is available, allow editing of divisions associated with routing (ER00027)
			String ApprovalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");
			if (ApprovalSubmissionAsPackets.equals(Constant.ON)){
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"30%\" height=\"30\" nowrap>Copy Associated Div/Dept:&nbsp;</td>" );
				out.println("				 <td class=\'datacolumn\' width=\"70%\" height=\"30\" nowrap><input type=\"checkbox\" name=\"assoc\" value='1'><br><br>" );
				out.println(DivisionDB.getDivisionToRouting(conn,route));
				out.println("				 </td>" );
				out.println("			</tr>" );
			}

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"30%\" height=\"30\" nowrap>&nbsp;</td>" );
			out.println("				 <td class=\'datacolumn\' width=\"70%\" height=\"30\" nowrap>" );
			out.println("<input name=\"route\" type=\"hidden\" value=\""+route+"\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Submit\" onClick=\"return checkForm(this)\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Cancel\" onClick=\"return cancelForm("+route+")\">");
			out.println("				 </td>" );
			out.println("			</tr>" );

			out.println("	</table>" );

			out.println("</form>");
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"apprcpy",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
