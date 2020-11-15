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
	*	testfix41.jsp - moving 'is course comparable' from X41 to C24. X41 will be YESNO
   *
   *	explain was never used so X41 had the data. now that explain is needed, data
   *	is moved to C24 so that YESNO can be stored in X41.
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
	public static String processItem(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		String historyid = "";
		String x41 = "";
		String campus = "";

		try{
			// move X41 to C24
			String sql = "SELECT historyid,campus,x41 "
					+ " FROM tblCourse "
					+ " WHERE x41 is not null "
					+ " ORDER BY campus,coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()){
				historyid = rs.getString("historyid");
				x41 = rs.getString("x41");
				campus = rs.getString("campus");

				sql = "UPDATE tblCampusData SET C24=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,x41);
				ps2.setString(2,historyid);
				rowsAffected = ps2.executeUpdate();
				if (rowsAffected==0){
					logger.info("textfix41 - " + id + ": " + campus + " - " + historyid);
					++id;
				}
				++i;
			}
			rs.close();
			ps.close();

			sql = "UPDATE tblCourse SET X41=''";
			ps2 = conn.prepareStatement(sql);
			rowsAffected = ps2.executeUpdate();
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return "updated " + i + " rows; deleted " + rowsAffected + " rows";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

