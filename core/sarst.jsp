<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.apache.log4j.Logger"%>

<jsp:useBean id="kookie" scope="application" class="com.ase.aseutil.CookieManager" />

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		processPage = false;

		// not permitted when not admin so we bounce back to task listing
		response.sendRedirect("tasks.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String frontPage = "lgn.jsp";

	if (processPage){

		campus = website.getRequestParameter(request,"c",campus);
		user = website.getRequestParameter(request,"u",user);

		SysDB.resetSysAdm(conn,campus,user);

		JSIDDB.endJSID(conn,session.getId(),campus,user);
		request.getSession().setAttribute("CC_User", user);
		request.getSession().setAttribute("CC_Campus", campus);

		String sidErr = "";

		// from li.jsp

		try {
			ServletContext context = getServletContext();

			synchronized (this) {
				msg = UserDB.authenticateUserX(conn,user,request,response,context,"");
			}

			if ("Exception".equals(msg.getMsg())) {
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

					String dept = (String)session.getAttribute("aseDept");
					String div = (String)session.getAttribute("aseDivision");
					String dataType = (String)session.getAttribute("aseDataType");

					if (!div.equals(Constant.BLANK) && !dept.equals(Constant.BLANK)){
						/*
							check for user action request. this is a value set by the admin under
							system settings. a 1 means that we want the user to do something upon
							a successful login
						*/
						long taskCount = TaskDB.countUserTasks(conn,user);
						String startPage = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","StartPage");
						if (startPage != null && "tasks".equals(startPage) && taskCount > 0 )
							frontPage = "tasks.jsp";
						else
							frontPage = "index.jsp";

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
		catch(UserNotAuthorizedException e){
			sidErr = "UserNotAuthorizedException";
		}
		catch (Exception e){
			sidErr = "Exception";
		}
	}

	asePool.freeConnection(conn,"sarst",user);

	if (!frontPage.equals(Constant.BLANK)){
		//response.sendRedirect(frontPage);
	}

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>