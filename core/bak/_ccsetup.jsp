<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<html>
<head>
	<title>Curriculum Central: Course Questions</title>

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
	int routes = ApproverDB.getNumberOfRoutes(conn,campus);
	int departmentCount = DivisionDB.getDepartmentCount(conn,campus);
	int questionsCampus = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
	int questionsCourse = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
	int notifications = DistributionDB.getDistributionCount(conn,campus);
	int system = IniDB.getSystemSettingsCount(conn,campus);

	if (processPage){

		int verify = website.getRequestParameter(request,"v", 0);

		if (verify==1){

			// create any missing setting
			IniDB.createMissingSettingForCampus(conn,campus,user);

			// redirect back to get rid of URL
			response.sendRedirect("ccsetup.jsp");

		} // verify

	} // processPage

%>
	<link rel="stylesheet" href="./js/slidingform/css/style.css" type="text/css" media="screen"/>
	<script type="text/javascript" src="./js/slidingform/jquery.min.js"></script>
	<script type="text/javascript" src="./js/slidingform/sliding.form.js"></script>

    <style>
        span.reference{
            position:fixed;
            left:5px;
            top:5px;
            font-size:10px;
            text-shadow:1px 1px 1px #fff;
        }
        span.reference a{
            color:#555;
            text-decoration:none;
				text-transform:uppercase;
        }
        span.reference a:hover{
            color:#000;

        }
        h1{
            color:#333;
            font-size:24px;
            text-shadow:1px 1px 1px #fff;
            padding:20px;
        }
    </style>

</head>
    <body>
        <div>
            <span class="reference">
                <a href="/central/core/index.jsp">back to Curriculum Central</a>
            </span>
        </div>
        <div id="content">
            <h1>Curriculum Central Setup</h1>
            <div id="wrapper">
                <div id="steps">
                    <form id="aseForm" name="aseForm" action="ccsetup.jsp?v=1" method="post">
                        <fieldset class="step">
                            <legend>Users</legend>
                            <p>
                                <label for="usercount">User Count:</label>
                                <%=userCount%>
                            </p>
                            <p>
                                <label for="administrators">Administrators:</label>
                                <%=administrators%>
                            </p>
                        </fieldset>

                        <fieldset class="step">
                            <legend>Questions</legend>
                            <p>
                                <label for="cardnumber">Course Questions</label>
                                <%=questionsCourse%>
                            </p>

                            <p>
                                <label for="cardnumber">Campus Questions</label>
                                <%=questionsCampus%>
                            </p>
                        </fieldset>

                        <fieldset class="step">
                            <legend>Departments</legend>
                            <p>
                                <label for="cardnumber">Number of Departments</label>
                                <%=departmentCount%>
                            </p>

									<p>
									CC uses department chair to determine approval routings and notifications.
									</p>
                        </fieldset>

                        <fieldset class="step">
                            <legend>Approver Routing</legend>
                            <p>
                                <label for="name">Number of Routes</label>
                                <%=routes%>
                            </p>
                        </fieldset>

                        <fieldset class="step">
                            <legend>Notifications</legend>
                            <p>
                                <label for="name">Notification Count:</label>
                                <%=notifications%>
                            </p>
                        </fieldset>

                        <fieldset class="step">
                            <legend>System</legend>
                            <p>
                                <label for="name">System Settings Count:</label>
                                <%=system%>
                            </p>
                        </fieldset>

								<fieldset class="step">
									<legend>Verify</legend>
									<p>
									Basic settings are in place.<br><br>
									Click the 'Verify' button below to do a system check for missing settings.
									</p>

									<p class="submit">
										<button id="registerButton" type="submit">Verify</button>
									</p>

								</fieldset>
                    </form>
                </div>
                <div id="navigation" style="display:none;">
                    <ul>
                        <li class="selected"><a href="#">Users</a></li>
                        <li><a href="#">Questions</a></li>
                        <li><a href="#">Departments</a></li>
                        <li><a href="#">Approver Routing</a></li>
                        <li><a href="#">Notifications</a></li>
                        <li><a href="#">System</a></li>
								<li><a href="#">Verify</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>