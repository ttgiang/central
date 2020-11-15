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
	*
	* x15 contains the original pre req data. in the new version, the content of x15 was moved to c25
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String user = "THANHG";

	out.println("Start<br/>");

	if (processPage){
		//out.println(process(conn) + " <br/>");
	}

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

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;
		PreparedStatement ps2 = null;
		ResultSet rs2= null;

		String campus="LEE";

		logger.info("---------------------- START");

		try{

			// read from archived table and put into campus data what is not found
			// update C25 with content of x15 before blanking out x15

			String sql = "SELECT historyid,coursealpha,coursenum,auditdate,proposer,x15 FROM tblcoursearc WHERE campus='LEE' AND coursetype='ARC' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String coursealpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String coursenum = AseUtil.nullToBlank(rs.getString("coursenum"));
				String auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
				String auditby = AseUtil.nullToBlank(rs.getString("proposer"));
				String x15 = AseUtil.nullToBlank(rs.getString("x15"));
				sql = "SELECT historyid,campus,c25 FROM tblCampusdata WHERE campus=? AND historyid=? AND coursetype='ARC' ";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ps2.setString(2,historyid);
				rs2 = ps2.executeQuery();
				if (!rs2.next()){
					// archived data does not exist so put the data in the right place
					sql = "INSERT INTO tblcampusdata (historyid,campus,coursealpha,coursenum,coursetype,auditdate,auditby,c25) VALUES(?,?,?,?,?,?,?,?)";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,historyid);
					ps2.setString(2,campus);
					ps2.setString(3,coursealpha);
					ps2.setString(4,coursenum);
					ps2.setString(5,"ARC");
					ps2.setString(6,auditdate);
					ps2.setString(7,auditby);
					ps2.setString(8,x15);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					// put the data in the right place
					sql = "UPDATE tblcoursearc SET X15=null WHERE campus=? AND historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,campus);
					ps2.setString(2,historyid);
					rowsAffected = ps2.executeUpdate();
				}
				else{
					String c25 = AseUtil.nullToBlank(rs2.getString("c25"));
					if (c25.equals(Constant.BLANK) && !x15.equals(Constant.BLANK)){
						// archived data found so transfer x15 to c25
						sql = "UPDATE tblcampusdata SET c25=? WHERE campus=? AND historyid=? AND coursetype='ARC'";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,x15);
						ps2.setString(2,campus);
						ps2.setString(3,historyid);
						rowsAffected = ps2.executeUpdate();
						ps2.close();

						// put the data in the right place
						sql = "UPDATE tblcoursearc SET X15=null WHERE campus=? AND historyid=?";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,campus);
						ps2.setString(2,historyid);
						rowsAffected = ps2.executeUpdate();
					}
				}

				rs2.close();
				ps2.close();

				++i;
				System.out.println(i + ": " + campus + " - " + historyid);

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

