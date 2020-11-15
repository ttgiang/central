<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Ann Berner";
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

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	out.println("Start<br/>");

	if (processPage){
		String campus = "LEE";
		String user = "BERNER";

		String kix = "";
		String alpha = "";
		String num = "";
		String type = "PRE";
		String proposer = "";

		int rowsAffected = 0;

		try{
			// read through the view designed to capture outlines approval missing for Ann Berner.
			// if the task does not exist, add it.

			String sql = "SELECT distinct historyid, coursealpha, coursenum "
				+ "FROM zvw_AnnBerner "
				+ "ORDER BY coursealpha, coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				if (TaskDB.isMatch(conn,user,alpha,num,Constant.APPROVAL_TEXT,campus))
					out.println("NOT ADDED ---> " + kix + " - " + alpha + " - " + num + "<br/>");
				else{
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,type);
					rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,Constant.APPROVAL_TEXT,campus,"","ADD",type);
					out.println("ADDED ---> " + kix + " - " + alpha + " - " + num + "<br/>");
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			System.out.println("fix - " + sx.toString());
		} catch(Exception ex){
			System.out.println("fix - " + ex.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

