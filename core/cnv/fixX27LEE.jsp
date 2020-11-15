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
	*	testfix29.jsp - fill in #29 for KAP
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	String campus = "LEE";
	String user = "THANHG";
	int route = 708;

	out.println("Start<br/>");

	out.println(process(conn) + " <br/>");

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	process
	*/
	public static String process(Connection conn){

		/*
			during a conversion, X27 was wiped out.
		*/

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;
		PreparedStatement ps2 = null;

		logger.info("---------------------- START");

		try{

			/*
			select c.campus,c.coursealpha,c.coursenum,c.historyid,t.x27,c.x27,d.c32
			from tblcourse t, tblcourselee c, tblcampusdata d
			where c.historyid=d.historyid
			and t.historyid=d.historyid
			and c.campus='LEE'
			and not c.x27 is null
			order by c.coursealpha, c.coursenum
			*/

			String sql = "SELECT c.campus,c.coursealpha,c.coursenum,c.historyid,c.x27,d.c32 "
							+ "FROM tblcourselee c, tblcampusdata d "
							+ "WHERE c.historyid=d.historyid "
							+ "AND c.campus='LEE' "
							+ "AND NOT c.x27 IS NULL "
							+ "ORDER BY c.coursealpha,c.coursenum ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String x27 = AseUtil.nullToBlank(rs.getString("x27"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String c32 = AseUtil.nullToBlank(rs.getString("c32"));

				if (!(Constant.BLANK).equals(x27)){

					/*
						append any existing content from the back up to any data
						entered since day that it went.
					*/

					++i;

					if (!(Constant.BLANK).equals(c32))
						c32 = c32 + Html.BR() + x27;
					else
						c32 = x27;

					// put the data in the right place
					sql = "UPDATE tblcampusdata SET c32=? WHERE historyid=? AND campus='LEE'";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,c32);
					ps2.setString(2,kix);
					int rowsAffected1 = ps2.executeUpdate();
					ps2.close();

					// clear from the old
					x27 = "";
					sql = "UPDATE tblCourse SET X27=? WHERE historyid=? AND campus='LEE'";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,x27);
					ps2.setString(2,kix);
					int rowsAffected2 = ps2.executeUpdate();
					ps2.close();
					//System.out.println(i + ": " + kix + " - " + alpha + " - " + num + " - " + rowsAffected1 + " - " + rowsAffected2);

					logger.info(i + ": " + kix + " - " + alpha + " - " + num);
				}

			}
			rs.close();
			ps.close();

		}
		catch(SQLException sx){
			System.out.println("process: " + sx.toString());
		} catch(Exception ex){
			System.out.println("process: " + ex.toString());
		}

		logger.info("---------------------- END");

		return "done";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

