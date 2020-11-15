<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprdlt.jsp - delete routing confirm
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int route = website.getRequestParameter(request,"rte", 0);

	boolean valid = true;

	String message = "Do you wish to continue with delete operation?";
	String shortName = "";
	String longName = "";

	String college = "";
	String dept = "";
	String level = "";

	String collegeName = "";
	String deptName = "";
	String levelName = "";

	if (route==0){
		message = "Missing or invalid approval routing.";
		valid = false;
	}
	else{
		shortName = ApproverDB.getRoutingNameByID(conn,campus,route);
		longName = ApproverDB.getRoutingFullNameByID(conn,campus,route);

		Ini ini = IniDB.getINI(conn,route);
		if (ini != null){
			college = ini.getKval1();
			dept = ini.getKval2();
			level = ini.getKval3();
		}
		ini = null;

		BannerData data = null;

		//
		// college
		//
		if(!college.equals("")){
			data = BannerDataDB.getBannerData(conn,"bannercollege",college);
			if (data != null){
				collegeName = data.getDescr() + " ("+college+")";
			}
		}

		//
		// dept
		//
		if(!dept.equals("")){
			data = BannerDataDB.getBannerData(conn,"bannerdept",dept);
			if (data != null){
				deptName = data.getDescr() + " ("+dept+")";
			}
		}

		//
		// level
		//
		if(!level.equals("")){
			data = BannerDataDB.getBannerData(conn,"bannerlevel",level);
			if (data != null){
				levelName = data.getDescr() + " ("+level+")";
			}
		}
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Delete Approval Routing";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseApplicationMessage","");

	if (!processPage)
		valid = false;

	asePool.freeConnection(conn,"apprdlt",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/apprdlt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="apprdltx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br /><br />
					<TABLE cellSpacing=0 cellPadding=0 width="60%" border=0>
						<TBODY>
							<%
								String enableCollegeCodes = Util.getSessionMappedKey(session,"EnableCollegeCodes");
								if(enableCollegeCodes.equals(Constant.ON)){
							%>
									<TR height="20">
										<TD class="textblackth" width="25%" valign="bottom">College:</td>
										<td class="datacolumn"><%=collegeName%></td>
									</tr>

									<TR height="20">
										<TD class="textblackth" width="25%" valign="bottom">Department:</td>
										<td class="datacolumn"><%=deptName%></td>
									</tr>

									<TR height="20">
										<TD class="textblackth" width="25%" valign="bottom">Level:</td>
										<td class="datacolumn"><%=levelName%></td>
									</tr>
							<%
								}
							%>

							<TR height="20">
								<TD class="textblackth" width="25%" valign="bottom">Short Name:</td>
								<td class="datacolumn"><%=shortName%></td>
							</tr>
							<TR height="20">
								<TD class="textblackth" width="25%" valign="bottom">Long Name:</td>
								<td class="datacolumn"><%=longName%></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" value="<%=route%>" name="route">
				</TD>
			</TR>
			<%
				if (valid) {
			%>
				<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<TD align="center">
						<br />
						<input title="save entered data" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
						<input title="abort selected operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm(<%=route%>)">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>
			<%
				}
			%>
		</TBODY>
	</TABLE>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

