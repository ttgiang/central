<%@ page import="org.jasig.cas.client.validation.TicketValidator" %>
<%@ page import="org.jasig.cas.client.validation.Cas20ServiceTicketValidator" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>
<%@ page import="org.jasig.cas.client.validation.Assertion" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>

<%!

//
// A simple logging method; entry is sent to stdout.
//
protected void println(String msg) {
	String ts = String.format("%1$tY-%1$tb-%1$te %1$tT", new java.util.Date());
	System.out.println(ts + " DEBUG " + msg);
}

//
// Do a CAS login and save the uid (username).
//
protected void doCasLogin(HttpServletRequest req,
                          HttpServletResponse res,
                          String casUrl,
                          String frontPage,
                          String insidePage,
                          Connection conn,
                          ServletContext context) throws Exception {

	HttpSession sess = req.getSession();
	String sessionId = sess.getId();

	boolean debug = false;

	if(debug) println("doCasLogin - sessionId: " + sessionId);

	String ticket = req.getParameter("ticket");

	// There is a service ticket, need to validate it.
	if (ticket != null) {

		if(debug){
			println("doCasLogin - ticket     : " + ticket);
			println("doCasLogin - casUrl     : " + casUrl);
			println("doCasLogin - insidePage : " + insidePage);
			println("doCasLogin - frontPage : " + frontPage);
		}

		TicketValidator validator = new Cas20ServiceTicketValidator(casUrl);
		Assertion assertion = validator.validate(ticket, insidePage);
		AttributePrincipal principal = assertion.getPrincipal();

		String uid = principal.getName();
		if(debug) println("doCasLogin - uh-cas uid : " + uid);

		sess.setAttribute("uid", uid);
		req.setAttribute("uid", uid);

		// Redirect to remove the ticket from URL.
		if(debug) println("doCasLogin - redirecting: " + frontPage);

		String frontPagex = authenticateUser(req,res,conn,context,uid);
		sess.setAttribute("frontPagex", frontPagex);

		res.sendRedirect(frontPage);

		return;
	}

	String uid = (String) sess.getAttribute("uid");
	req.setAttribute("uid", uid);

	if(debug){
		println("doCasLogin - uid from session: " + uid);
	}

}

//
// doCasLogout
//
protected void doCasLogout(HttpServletRequest req,
                           HttpServletResponse res,
                           String logoutUrl) throws Exception {
	println("doCasLogout; invalidate session and logout.");
	req.getSession().invalidate();
	res.sendRedirect(logoutUrl);
}

/*
 *	authenticateUser
 *
 *	upong returning from the web service with a valid ticket,
 * we must check to see if this person has an account to CC and if
 * she does, is it active?
 *
 * if active, determine if there are tasks. If yes, show tasks,
 * else show news.
 *
 * if inactive, display not allowed message
*/
public String authenticateUser(HttpServletRequest req,
									HttpServletResponse res,
									Connection conn,
									ServletContext context,
									String uid){
	Msg msg;
	String user = "";
	String campus = "";
	String frontPage = "";
	String central = "";
	String dataType = "";
	String dept = "";
	String div = "";
	String check = "0";
	HttpSession session = req.getSession();
	String sessionId = session.getId();

	boolean debug = false;

	try{
		msg = UserDB.authenticateUserX(conn,uid,req,res,context,sessionId);

		central = getRoot(req.getRequestURL().toString());

		if(debug){
			println("authenticateUser: msg.getErrorLog : " + msg.getErrorLog());
			println("authenticateUser: msg.getMsg : " + msg.getMsg());
		}

		if ("Exception".equals(msg.getMsg())) {
			frontPage = central + "denied.jsp";
			if(debug) println("authenticateUser: denied : " + frontPage);
		}
		else if ("InactiveAccount".equals(msg.getMsg())){
			frontPage = central + "inactive.jsp";
			if(debug) println("authenticateUser: inactive : " + frontPage);
		}
		else{
			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			if(debug){
				println("authenticateUser: campus : " + campus);
				println("authenticateUser: user : " + user);
			}

			if (campus!=null && campus.length()>0){
				session.setAttribute("aseCampusName",CampusDB.getCampusNameOkina(conn,campus));

				dataType = (String)session.getAttribute("aseDataType");
				dept = (String)session.getAttribute("aseDept");
				div = (String)session.getAttribute("aseDivision");

				if(debug) {
					println("authenticateUser: dataType : " + dataType);
					println("authenticateUser: dept : " + dept);
					println("authenticateUser: div : " + div);
				}

				if (!div.equals(Constant.BLANK) && !dept.equals(Constant.BLANK)){

					long taskCount = TaskDB.countUserTasks(conn,user);
					String startPage = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","StartPage");
					if (startPage != null && "tasks".equals(startPage) && taskCount > 0 ){
						frontPage = central + "tasks.jsp";
					}
					else{
						frontPage = central + "index.jsp";
					}

					Cookie cookie;
					cookie = new Cookie ("CC_User", user);
					res.addCookie(cookie);

					session.setAttribute("aseBGColor", campus);
					cookie = new Cookie ("CC_Campus", campus);
					res.addCookie(cookie);

					Cron cron = new Cron(conn,session,dataType);
					TaskDB.createAdjustment(campus,user);

					if(debug){
						println("authenticateUser: central : " + central);
						println("authenticateUser: frontPage : " + frontPage);
					}

				}
				else{
					frontPage = central + "usrprfl.jsp?lid=" + user;
					if(debug)println("authenticateUser: frontPage : " + frontPage);
				}

			} // valid campus?
		}
	}
	catch( Exception ex ){
		//System.out.println(ex.toString());
		if(debug) println("authenticateUser: Exception\n" + ex.toString());
	}

	return frontPage;
}

/*
 *	getRoot
 *
 * given the current URL, determine the root folder
 * use this to get the user to the desired page.
 *
 * this is to avoid hard coding the entire link.
*/
public String getRoot(String url){

	String root = url;
	if (root.lastIndexOf("/") > 0){
		int pos = root.lastIndexOf("/");
		root = root.substring(0,pos+1);
	}

	return root;
}

%>
