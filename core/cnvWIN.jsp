<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "EDEA";
	String num = "197F";
	String type = "PRE";
	String user = "JAMESMC";
	String task = "Modify_outline";
	String kix = "L11l16h12246";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		//
		// WIN
		//
		//out.println(moveX23ToC11(conn,"WIN"));
		//out.println(moveX15ToC25(conn,"WIN"));
		//out.println(moveC46ToX77(conn,"WIN"));

		try{

		} catch (Exception e){
			System.err.println ("Error in writing to file");
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	//
	// WIN
	//
	public static int moveC46ToX77(Connection conn,String campus) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		// move data from x77 to C46 for win

		try{
			String sql = "select c.x77,c.coursealpha,c.coursenum,c.historyid,c46 from tblcourse c,tblcampusdata d where c.campus='WIN' AND c.historyid=d.historyid ORDER BY c.coursealpha,c.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String x77 = AseUtil.nullToBlank(rs.getString("x77"));
				String c46 = AseUtil.nullToBlank(rs.getString("c46"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (c46 != null && c46.length() > 0 && x77.length()== 0){
					sql = "UPDATE tblcourse SET x77=? WHERE campus='WIN' AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,c46);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					sql = "UPDATE tblcampusdata SET c46=? WHERE campus='WIN' AND historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,null);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					System.out.println((++i) + " - " + alpha + " - " + num);
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("Test: moveC46ToX77 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: moveC46ToX77 - " + e.toString());
		}

		return rowsAffected;

	}

	public static int moveX23ToC11(Connection conn,String campus) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		// move data from x23 to c11 for win

		try{
			String sql = "select c.x23,c.coursealpha,c.coursenum,c.historyid,c11 from tblcourse c,tblcampusdata d where c.campus='WIN' AND c.historyid=d.historyid ORDER BY c.coursealpha,c.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String x23 = AseUtil.nullToBlank(rs.getString("x23"));
				String c11 = AseUtil.nullToBlank(rs.getString("c11"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (x23 != null && x23.length() > 0 && c11.length()== 0){
					sql = "UPDATE tblcampusdata SET c11=? WHERE campus='WIN' AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,x23);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					sql = "UPDATE tblcourse SET x23=? WHERE campus='WIN' AND historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,null);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					System.out.println((++i) + " - " + alpha + " - " + num);
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("Test: moveX23ToC11 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: moveX23ToC11 - " + e.toString());
		}

		return rowsAffected;

	}

	public static int moveX15ToC25(Connection conn,String campus) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		// move data from x15 to c25 for win

		try{
			String sql = "select c.x15,c.coursealpha,c.coursenum,c.historyid,c25 from tblcourse c,tblcampusdata d where c.campus='WIN' AND c.historyid=d.historyid ORDER BY c.coursealpha,c.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String x15 = AseUtil.nullToBlank(rs.getString("x15"));
				String c25 = AseUtil.nullToBlank(rs.getString("c25"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (x15 != null && x15.length() > 0 && c25.length()== 0){
					sql = "UPDATE tblcampusdata SET c25=? WHERE campus='WIN' AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,x15);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					sql = "UPDATE tblcourse SET x15=? WHERE campus='WIN' AND historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,null);
					ps2.setString(2,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					System.out.println((++i) + " - " + alpha + " - " + num);
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("Test: moveX15ToC25 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: moveX15ToC25 - " + e.toString());
		}

		return rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html