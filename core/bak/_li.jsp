<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ page import="java.net.URLEncoder" %>

<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />

<%
	/**
	*	ASE
	*	li.jsp
	*	2007.09.01
	**/

	// save the courseDB bean for later use
	session.setAttribute("aseCourseDB", courseDB);

	String chromeWidth = "30%";
	String sForm = website.getRequestParameter(request,"formName");
	String sAction = website.getRequestParameter(request,"formAction");
	String sidErr = "";
	String pageTitle = "Login Securely";
	String fieldsetTitle = pageTitle;
	String url = "";
	String cookieUserName = "";
	String cookieUserCampus = "";

	if ( sForm != null && sForm.equals("aseForm") ) {
		// get connection object
		AsePool asePool = AsePool.getInstance();
		Connection conn = asePool.getConnection();

		// reset
		session.setAttribute("aseApplicationMessage", "");

		String sid = website.getRequestParameterX(request,"user");
		String spd = website.getRequestParameterX(request,"userpw");
		String campus = "";
		String user = "";

		try {
			ServletContext context = getServletContext();
			msg = UserDB.authenticateUser(conn,sid,spd,request,response,context);

			url = "login.jsp";
			if ("Exception".equals(msg.getMsg())) {
				session.setAttribute("aseApplicationMessage", "Login or Password is incorrect." );
			}
			else if ( !"".equals(msg.getMsg()) ){
				session.setAttribute("aseApplicationMessage", MsgDB.getMsgDetail(msg.getMsg()));
			}
			else{
				sidErr = "sendRedirect";

				user = (String)session.getAttribute("aseUserName");
				campus = (String)session.getAttribute("aseCampus");

				/*
					check for user action request. this is a value set by the admin under
					system settings. a 1 means that we want the user to do something upon
					a successful login
				*/
				String check = "0";
				Ini ini = IniDB.getIniByCategoryKid(conn,"System","Check");
				if ( ini != null )
					check = ini.getKval1();

				// only do this if checking is requested and the user hasn't done so
				if ("1".equals(check) && UserDB.checked(conn,user,campus) == false){
					url = "usr.jsp?chk=1";
				}
				else{
					long taskCount = TaskDB.countUserTasks(conn,user);
					if ( taskCount > 0 )
						url = "tasks.jsp";
					else
						url = "index.jsp";
				}	// check

				Cron cron = new Cron(conn,session,"Access");
			}
		}
		catch( UserNotAuthorizedException unfe ){
			sidErr = "UserNotAuthorizedException";
		}
		catch ( Exception ignore ){
			sidErr = "Exception";
		}

		asePool.freeConnection(conn);

		response.sendRedirect(url);
	} // form != null
	else{
		ServletContext context = getServletContext();
		session.setAttribute("aseApplicationTitle", context.getInitParameter("aseApplicationTitle"));
		session.setAttribute("aseApplicationMessage", "");

		// retreive cookies for user and campus when first on this screen
		Cookie cookies[] = request.getCookies();
		if (cookies != null){
			for (int i = 0; i < cookies.length; i++){
				if (cookies[i].getName().equals("CC_User")) {
					cookieUserName = cookies[i].getValue();
				}
				else if (cookies[i].getName().equals("CC_Campus")) {
					cookieUserCampus = cookies[i].getValue();
				}
			}

			session.setAttribute("aseUserName", cookieUserName);
			session.setAttribute("aseBGColor", cookieUserCampus);
		}

	} // if we have form values
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/li.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/body.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>