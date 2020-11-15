<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsprgs.jsp
	*	2007.09.01	course edit
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String chromeWidth = "80%";
	String pageTitle = "";
	fieldsetTitle = "Outline Progress";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println(createUserTask(conn,session,request));
	asePool.freeConnection(conn);
%>

<%!

	/**
	 * createUserTask
	 * <p>
	 * @param	session		HttpSession
	 * @param	request		HttpServletRequest
	 * <p>
	 * @return	int
	 */
	private int createUserTask(Connection conn,HttpSession session,HttpServletRequest request) {

		Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String type = "";
		String proposer = "";
		String campus = "";
		int rowsAffected = 0;

		try{
			WebSite website = new WebSite();
			String usr = website.getRequestParameter(request,"usr");
			String kix = website.getRequestParameter(request,"kix");
			if (!"".equals(kix)){
				String[] info = Helper.getKixInfo(conn,kix);
				alpha = info[0];
				num = info[1];
				type = info[2];
				proposer = info[3];
				campus = info[4];
			}

System.out.println(alpha);
System.out.println(num);
System.out.println(campus);
System.out.println(usr);
System.out.println(proposer);

			rowsAffected = TaskDB.logTask(conn,usr,proposer,alpha,num,"Approve outline",campus,"","ADD",type);
		}
		catch(Exception ex){
			logger.fatal("SAServlet: createUserTask - " + ex.toString());
		}

		return rowsAffected;

	}

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
