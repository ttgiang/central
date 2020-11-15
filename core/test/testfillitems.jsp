<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "m55g17d9203";
	String src = "x43";
	String dst = "m55g17d9203";

	out.println("Start<br/>");
	fillMissingCCCM(conn);
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	/**
	 * fillMissingCCCM
	 * <p>
	 * @param	Connection	conn
	 * <p>
	 * @return	int
	 */
	public static int fillMissingCCCM(Connection conn){

		String sql = "";
		String campus = "";
		int rowsAffected = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT campus FROM tblCampus WHERE campus>'' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				campus = rs.getString(1);
				System.out.println("campus: " + campus + " - " + fillMissingCCCMX(conn,campus));
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			System.out.println(ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * fillMissingCCCMX
	 * <p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * <p>
	 * @return	int
	 */
	public static int fillMissingCCCMX(Connection conn,String campus){

		String sql = "";
		int rowsAffected = 0;
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "INSERT INTO tblCourseQuestions (campus,type,questionnumber,questionseq,question,include,change,help,auditby) "
				+ "SELECT '" + campus + "' AS campus,  "
				+ "'Course' AS type,  "
				+ "CCCM6100.Question_Number,  "
				+ "0 AS questionseq,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'N' AS include,  "
				+ "'N' AS change,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'THANHG' AS auditby "
				+ "FROM CCCM6100 "
				+ "WHERE (((CCCM6100.Question_Number) Not In (SELECT questionnumber "
				+ "FROM tblCourseQuestions "
				+ "WHERE campus=?)))";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(Exception ex){
			System.out.println(ex.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
