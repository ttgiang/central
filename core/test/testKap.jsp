<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "KES";
	String num = "143";
	String type = "PRE";
	String user = "SHINTAKU";
	String task = "Modify_outline";
	String kix = "N16k15h940";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{

			ServletContext context = getServletContext();

			login(campus,response,request,context);
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	public String login(String campus,
								HttpServletResponse response,
								HttpServletRequest request,
								ServletContext context) throws SQLException {

Logger logger = Logger.getLogger("test");

		int recordsRead = 0;
		int recordsProcessed = 0;

		String userid = "";

		Msg msg = null;

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();

			HttpSession session = request.getSession(true);

			String sql = "SELECT userid "
					+ "FROM tblUsers "
					+ "WHERE campus=? "
					+ "ORDER BY userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				++recordsRead;

				userid = AseUtil.nullToBlank(rs.getString("userid"));

				synchronized (this) {
					msg = UserDB.authenticateUser(conn,userid,"c0mp1ex",request,response,context);

					//logger.info(recordsRead + " - " + userid + " - " + msg);

					System.out.println(recordsRead + " - " + userid);

					Cron cron = new Cron(conn,session,"SQL");
					cron = null;

					TaskDB.createAdjustment(campus,userid);
				}

			}	// while
			rs.close();
			ps.close();
		}
		catch(SQLException se ){
			logger.fatal("testKAP: login - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("testKAP: login - " + ex.toString());
		}

		return "";
	}


%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>