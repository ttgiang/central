<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	appraddx.jsp - add route confirmation
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

	String shortName = website.getRequestParameter(request,"shortName","");
	String longName = website.getRequestParameter(request,"longName","");

	BannerData data = null;

	//
	// college
	//
	String college = website.getRequestParameter(request,"college","");
	String collegeName = "";
	if(!college.equals("")){
		data = BannerDataDB.getBannerData(conn,"bannercollege",college);
		if (data != null){
			collegeName = data.getDescr() + " ("+college+")";
		}
	}

	//
	// dept
	//
	String dept = website.getRequestParameter(request,"dept","");
	String deptName = "";
	if(!dept.equals("")){
		data = BannerDataDB.getBannerData(conn,"bannerdept",dept);
		if (data != null){
			deptName = data.getDescr() + " ("+dept+")";
		}
	}

	//
	// level
	//
	String level = website.getRequestParameter(request,"level","");
	String levelName = "";
	if(!level.equals("")){
		data = BannerDataDB.getBannerData(conn,"bannerlevel",level);
		if (data != null){
			levelName = data.getDescr() + " ("+level+")";
		}
	}

	String formSelect = website.getRequestParameter(request,"formSelect","");
	int route = website.getRequestParameter(request,"rte",0);

	boolean valid = true;

	String message = "Do you wish to continue with add operation?";

	if ( formName != null && formName.equals("aseForm") ){
		if (formAction.equalsIgnoreCase("s")){
			if (route > 0){

				int rowsAffected = IniDB.updateRouting(conn,route,college,dept,level,user);
				if (rowsAffected > 0){
					rowsAffected = DivisionDB.saveDivisionToRouting(conn,route,formSelect);;
					if (rowsAffected == -1)
						message = "Unable to update approval routing.<br><br>";
					else
						message = "Approval routing updated successfully";
				}

			}
			else{
				if (shortName.equals("")){
					message = "Missing or invalid approval routing name.";
					valid = false;
				}
			} // route
		}	// action = s
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Add Approval Routing";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseApplicationMessage","");

	if (!processPage){
		valid = false;
	}

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether college codes are displayed (EnableCollegeCodes)");

	asePool.freeConnection(conn,"appraddx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/appradd.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />

<%
	if (route == 0){
%>
<form method="post" action="appraddy.jsp" name="aseForm">
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
					<input type="hidden" value="<%=formSelect%>" name="formSelect">
					<input type="hidden" value="<%=shortName%>" name="shortName">
					<input type="hidden" value="<%=longName%>" name="longName">
					<input type="hidden" value="<%=college%>" name="college">
					<input type="hidden" value="<%=dept%>" name="dept">
					<input type="hidden" value="<%=level%>" name="level">
				</TD>
			</TR>
			<%
				if (valid) {
			%>
				<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<TD align="center">
						<br />
						<input title="save entered data" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkFormX('s')">&nbsp;
						<input title="abort selected operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
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
<%
	}
	else{
		out.println(
				"<p align=\"center\">"
				+ message
				+ "<br>"
				+ "<br>"
				+ "<a href=\"appridx.jsp?route="+route+"&college="+college+"&dept="+dept+"&level="+level+"\" class=\"linkcolumn\">return</a> to approval routing"
				+ "</p>"
		);
	} // route > 0
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

