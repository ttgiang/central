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
	*	testfix15-16.jsp - moving pre req from X15 to C25 and coreq from X16 to C26
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	out.println("Start<br/>");
	//out.println(processItem(conn) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	processItem
	*/
	public static String processItemX(Connection conn){

		Logger logger = Logger.getLogger("test");

		int updated = 0;
		int deleted = 0;
		int id = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		String historyid = "";
		String x15 = "";
		String x16 = "";
		String alpha = "";
		String num = "";

		String campus = "KAP";

		try{
			String sql = "SELECT historyid,x15,x16,coursealpha,coursenum "
					+ " FROM tblCourse "
					+ " WHERE campus=? AND (NOT x15 IS NULL OR NOT X16 IS NULL) "
					+ " ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while (rs.next()){
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				x15 = AseUtil.nullToBlank(rs.getString("x15"));
				x16 = AseUtil.nullToBlank(rs.getString("x16"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				if (historyid!=null && historyid.length()>0){
					sql = "UPDATE tblCampusData SET C25=?,C26=? WHERE campus=? AND historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,x15);
					ps2.setString(2,x16);
					ps2.setString(3,campus);
					ps2.setString(4,historyid);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
					++updated;

					if (rowsAffected==1){
						sql = "UPDATE tblCourse SET x15='',x16='' WHERE campus=? AND historyid=?";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,campus);
						ps2.setString(2,historyid);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						++deleted;
					}

					logger.info(campus + ": " + updated + " " + alpha + " - " + num);
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return campus + " - updated " + updated + " rows; deleted " + deleted + " rows";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

