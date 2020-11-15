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
	*	testfix32.jsp - moving 'is hours spent' from X32 to C20. X32 will be checkmarks (BY CAMPUS)
	*							originally, LEE stored content in X32. However, an explain box has been added
	*							and is used by other campuses so we need to fix this up for LEE. The finx
	*							involves moving the 'X' value to the 'C' or explained value (C20).
	*							LEE will not have a listing of checked box values so nothing is stored in
	*							'X'.
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	out.println("Start<br/>");
	//out.println(processItem(conn,"LEE") + " <br/>");
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
	public static String processItem(Connection conn,String campus){

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
		String fromField = "X32";
		String fromData = "";
		String to = "C20";

		try{
			String sql = "SELECT historyid," + fromField
					+ " FROM tblCourse2 "
					+ " ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()){
				historyid = rs.getString("historyid");
				fromData = rs.getString(fromField);

				System.out.println(historyid + " - " + fromData);

				sql = "UPDATE tblCourse SET " + fromField + "=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,fromData);
				ps2.setString(2,historyid);
				rowsAffected = ps2.executeUpdate();
				++i;

			}
			rs.close();
			ps.close();
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

