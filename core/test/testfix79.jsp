<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
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
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	out.println("Start<br/>");
	out.println("fixing data..." + fix79Hil(conn) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	/*
	**
	**
	*/
	public static int fix79Hil(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;

		// HIL used X79 for course title instead of coursetitle column. This here fixes the problem
		// by moving things back.

		// impacting only items that changed

		// 1) read all outlines
		// 2) if x79 <> coursetitle, copy x79 to coursetitle
		// 3) update

		try{
			System.out.println("------------------- START");

			String sql = "SELECT historyid,coursealpha,coursenum,coursetitle, x79 "
							+ "FROM tblCourse "
							+ "WHERE campus='HIL'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));
				String x79 = AseUtil.nullToBlank(rs.getString("x79"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String coursealpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String coursenum = AseUtil.nullToBlank(rs.getString("coursenum"));

				if (!x79.equals(coursetitle)){
					System.out.println(++i + "," + coursealpha + "," + coursenum + "," + x79  + "," + coursetitle);

					sql = "UPDATE tblCourse  "
							+ "SET coursetitle=? "
							+ "WHERE campus='HIL' AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,x79);
					ps2.setString(2,historyid);
					ps2.executeUpdate();
					ps2.close();
					ps2 = null;
				}

			} // while
			rs.close();
			ps.close();

			System.out.println("------------------- END");

		}
		catch(SQLException sx){
			System.out.println("courseTitle - " + sx.toString());
		}
		catch(Exception ex){
			System.out.println("courseTitle - " + ex.toString());
		}

		return 0;
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

