<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccsetup.jsp 	setup CC
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Curriculum Central Set Up";

	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int userCount = UserDB.getUserCount(conn,campus,Constant.FACULTY);
	int administrators = UserDB.getUserCount(conn,campus,Constant.CAMPADM);
	String userWarning = "";

	int routes = ApproverDB.getNumberOfRoutes(conn,campus);
	String routesWarning = "";

	int departmentCount = DivisionDB.getDepartmentCount(conn,campus);
	String departmentsWarning = "";

	int questionsCampus = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
	int questionsCourse = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
	String questionsWarning = "";

	int notifications = DistributionDB.getDistributionCount(conn,campus);
	String notificationsWarning = "";

	int system = IniDB.getSystemSettingsCount(conn,campus);
	String systemWarning = "";

	if (processPage){

		int verify = website.getRequestParameter(request,"v", 0);

		if (verify==1){

			// create any missing setting
			IniDB.createMissingSettingForCampus(conn,campus,user);

			// redirect back to get rid of URL
			response.sendRedirect("ccsetup.jsp");

		} // verify

		//routesWarning = "&nbsp;<img src=\"../images/warning.gif\" border=\"0\">";

	} // processPage
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./accordion.jsp" %>
</head>

<body topmargin="0" leftmargin="0" background="images/stripes.png">

<%@ include file="../inc/header.jsp" %>

<div class="demo">

	<div id="accordion">
		<h3><a href="#">Users<%=userWarning%></a></h3>
		<div>
			 <p>
				  <label for="usercount">User Count:</label>
				  <%=userCount%>
			 </p>
			 <p>
				  <label for="administrators">Administrators:</label>
				  <%=administrators%>
			 </p>

			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="usridx.jsp" class="linkcolumn">user</a> maintenance
			 </p>

		</div>
		<h3><a href="#">Questions<%=questionsWarning%></a></h3>
		<div>
			 <p>
				  <label for="cardnumber">Course Questions</label>
				  <%=questionsCourse%>
			 </p>

			 <p>
				  <label for="cardnumber">Campus Questions</label>
				  <%=questionsCampus%>
			 </p>

			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="dfqst.jsp?t=r" class="linkcolumn">course</a> questions
				&nbsp;&nbsp;&nbsp;
				<img src="../images/arrow.gif" border="0"> go to <a href="dfqst.jsp?t=c" class="linkcolumn">campus</a> questions
			 </p>

		</div>
		<h3><a href="#">Departments<%=departmentsWarning%></a></h3>
		<div>
			 <p>
				  <label for="cardnumber">Number of Departments</label>
				  <%=departmentCount%>
			 </p>

			<p>
			CC uses department chair to determine approval routings and notifications.
			</p>

			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="dividx.jsp" class="linkcolumn">department</a> maintenance
			 </p>

		</div>
		<h3><a href="#">Approver Routing<%=routesWarning%></a></h3>
		<div>
			 <p>
				Approval routings are lists of defined users who are part of the approval process.
				<br>
				  <label for="name">Number of Routes</label>
				  <%=routes%>
			 </p>

			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="appridx.jsp?pageClr=1" class="linkcolumn">approval</a> routing
			 </p>

		</div>

		<h3><a href="#">Notifications<%=notificationsWarning%></a></h3>
		<div>
			 <p>
				Notifications are distribution lists of names to be notified depending on various user actions. For example,
				notification list 'NotifyWhenApproved' contains names of faculty who are notified when a course or program
				has been approved.
				<br>
				  <label for="name">Notification Count:</label>
				  <%=notifications%>
			 </p>


			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="dstidx.jsp" class="linkcolumn">Notification</a>
			 </p>
		</div>

		<h3><a href="#">System<%=systemWarning%></a></h3>
		<div>
			 <p>
				System settings determines how CC behaves. You should review your system settings to ensure proper operations.
				For example, there are settings telling CC how to handle user interactions, menu options, and various lists.
				<br>
				  <label for="name">System Settings Count:</label>
				  <%=system%>
			 </p>


			 <p>&nbsp;</p>
			 <p>
				<img src="../images/arrow.gif" border="0"> go to <a href="ini.jsp?pageClr=1" class="linkcolumn">System</a> settings
			 </p>
		</div>

	</div><!-- accordion -->

</div><!-- End demo -->

<%
	asePool.freeConnection(conn,"index",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

