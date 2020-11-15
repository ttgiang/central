<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprcpyx.jsp - copy route confirmation
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	boolean valid = true;

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String shortName = website.getRequestParameter(request,"shortName","");
	String longName = website.getRequestParameter(request,"longName","");
	int route = website.getRequestParameter(request,"route", 0);
	int assoc = website.getRequestParameter(request,"assoc", 0);

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

	String assocDescr = "NO";
	if (assoc==1){
		assocDescr = "YES";
	}

	String message = "Do you wish to continue with copy operation?";

	if ( formName != null && formName.equals("aseForm") ){
		if ( formAction.equalsIgnoreCase("s") ){
			if (shortName.equals(Constant.BLANK)){
				message = "Missing or invalid approval routing name.";
				valid = false;
			}
		}	// action = s
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Copy Approval Routing";
	pageTitle = "Copy Approval Routing";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseApplicationMessage","");

	if (!processPage){
		valid = false;
	}

	asePool.freeConnection(conn,"apprcpyx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/apprcpy.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="apprcpyy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br /><br />
					<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0>
						<TBODY>
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
								<TD class="textblackth" width="30%" valign="bottom">Short Name:</td>
								<td class="datacolumn"><%=shortName%></td>
							</tr>
							<TR height="20">
								<TD class="textblackth" width="30%" valign="bottom">Long Name:</td>
								<td class="datacolumn"><%=longName%></td>
							</tr>
							<%
							// ER00027 - 2011.12.05
							// approval with division chair sequence
							// when route is available, allow editing of divisions associated with routing (ER00027)
							String ApprovalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");
							if (ApprovalSubmissionAsPackets.equals(Constant.ON)){
							%>
								<TR height="20">
									<TD class="textblackth" width="30%" nowrap valign="bottom">Copy Associated Div/Dept:</td>
									<td class="datacolumn"><%=assocDescr%></td>
								</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<input type="hidden" value="<%=shortName%>" name="shortName">
					<input type="hidden" value="<%=longName%>" name="longName">
					<input type="hidden" value="<%=route%>" name="route">
					<input type="hidden" value="<%=assoc%>" name="assoc">
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

