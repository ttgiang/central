<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/db.jsp" %>

<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />
<jsp:useBean id="log" scope="application" class="com.ase.aseutil.ASELogger" />

<%
	/**
	*	ASE
	*	li.jsp
	*	2007.09.01
	**/

	String thisPage = "login";

	session.setAttribute("aseThisPage",thisPage);
	session.setAttribute("aseCourseDB", courseDB);
	session.setAttribute("aseScheduledJobs", null);

	String chromeWidth = "30%";
	String sForm = website.getRequestParameter(request,"formName");
	String sAction = website.getRequestParameter(request,"formAction");
	String sidErr = "";
	String pageTitle = "Login Securely";
	String fieldsetTitle = pageTitle;
	String frontPage = "";
	String cookieUserName = "";
	String cookieUserCampus = "";
	String dataType = "";
	String campus = "";
	String user = "";
	String dept = "";
	String div = "";

	if ( sForm != null && sForm.equals("aseForm") ) {

		session.setAttribute("aseApplicationMessage",Constant.BLANK);

		String sid = website.getRequestParameterX(request,"user");
		String spd = website.getRequestParameterX(request,"userpw");

		try {
			ServletContext context = getServletContext();

			synchronized (this) {
				msg = UserDB.authenticateUser(conn,sid,spd,request,response,context);
			}

			frontPage = "lgn.jsp";
			if(msg.getMsg().toLowerCase().equals("exception")){
				session.setAttribute("aseApplicationMessage", "Incorrect username or password" );
			}
			else if (!"".equals(msg.getMsg())){
				session.setAttribute("aseApplicationMessage", MsgDB.getMsgDetail(msg.getMsg()));
			}
			else{
				sidErr = "sendRedirect";

				// encrypter
				user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
				campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

				if (campus!=null && campus.length()>0){
					session.setAttribute("aseCampusName", CampusDB.getCampusNameOkina(conn,campus));

					dept = (String)session.getAttribute("aseDept");
					div = (String)session.getAttribute("aseDivision");
					dataType = (String)session.getAttribute("aseDataType");

					if (!div.equals(Constant.BLANK) && !dept.equals(Constant.BLANK)){
						/*
							check for user action request. this is a value set by the admin under
							system settings. a 1 means that we want the user to do something upon
							a successful login
						*/
						long taskCount = TaskDB.countUserTasks(conn,user);
						String startPage = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","StartPage");

						if(SQLUtil.isSysAdmin(conn,sid)){
								frontPage = "sa.jsp";
						}
						else{
							if (startPage != null && "tasks".equals(startPage) && taskCount > 0 ){
								frontPage = "tasks.jsp";
							}
							else{
								frontPage = "index.jsp";
							}
						}

						Cookie cookie;
						cookie = new Cookie ("CC_User", user);
						response.addCookie(cookie);

						session.setAttribute("aseBGColor", campus);
						cookie = new Cookie ("CC_Campus", campus);
						response.addCookie(cookie);

						TaskDB.createAdjustment(campus,user);
					}
					else{
						frontPage = "usrprfl.jsp?lid=" + user;
					}

				} // valid campus
			} // no error message
		}
		catch( UserNotAuthorizedException unfe ){
			sidErr = "UserNotAuthorizedException";
			//System.out.println(unfe.toString());
		}
		catch (Exception ignore){
			sidErr = "Exception";
			//System.out.println(ignore.toString());
		}
	} // form != null

	asePool.freeConnection(conn,"li",user);

	if (!frontPage.equals(Constant.BLANK)){
		response.sendRedirect(frontPage);
	}
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