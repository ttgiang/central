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
	*	testfixkappslo.jsp - delete PSLOs added in error
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
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
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		String kix = "";
		String alpha = "";
		String num = "";
		String campus = "KAP";

		// read all approved outlines not touched by CC work
		// check KAP-PSLO for entry. If not found as LBART in KAP-PSLO,
		// delete entries created in PSLO table
		try{
			String sql = "SELECT historyid,coursealpha,coursenum "
					+ " FROM tblCourse "
					+ " WHERE campus='KAP' "
					+ " AND coursetype='CUR' "
					+ " AND dateproposed IS NULL "
					+ " ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()){
				kix = rs.getString("historyid");
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");

				sql = "SELECT id FROM [kap-pslo] WHERE subj=? AND crsno=? ";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,alpha);
				ps2.setString(2,num);
				rs2 = ps2.executeQuery();
				if (!rs2.next()){
					rowsAffected = GenericContentDB.deleteContents(conn,campus,kix,Constant.COURSE_PROGRAM_SLO);
					++i;
				}
				rs2.close();
				ps2.close();
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

