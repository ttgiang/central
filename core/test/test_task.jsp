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
	String user = "HOTTA";
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";

	out.println("Start<br/>");
	//out.println(addTask(conn,campus,user,alpha,num,task));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static String addTask(Connection conn,String campus,String user,String alpha,String num,String task)

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String historyid = "";
		String proposer = "";
		String progress = "";
		String type = "";
		String message = "";

		int rowsAffected = 0;

		ResultSet rs = null;
		PreparedStatement ps = null;

		int code = 0;
		final int APPROVE = 0;
		final int MODIFY = 1;
		final int REVIEW = 2;

		if ("Approve_outline".equals(task))
			code = APPROVE;
		else if ("Modify_outline".equals(task))
			code = MODIFY;
		else if ("Review_SLO".equals(task))
			code = REVIEW;

		/*
			for modify outline task
				1) make sure the task is in MODIFY progress
				2) if task not created, create 1
		*/

		try {
			type = "PRE";
			sql = "SELECT historyid,proposer,progress "
				+ "FROM tblCourse "
				+ "WHERE campus=? AND "
				+ "coursealpha=? AND "
				+ "coursenum=? AND "
				+ "coursetype=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			rs = ps.executeQuery();
			if (rs.next()){
				historyid = AseUtil.nullToBlank(rs.getString("historyid")).trim();
				proposer = AseUtil.nullToBlank(rs.getString("proposer")).trim();
				progress = AseUtil.nullToBlank(rs.getString("progress")).trim();
			}
			rs.close();
			ps.close();

			switch(code){
				case APPROVE:
					if ("APPROVAL".equals(progress)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
						}
						else
							rowsAffected = 1;
					}

					break;
				case MODIFY:
					if ("MODIFY".equals(progress)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
						}
						else
							rowsAffected = 1;
					}

					break;
				case REVIEW:
					if ("REVIEW".equals(progress)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
						}
						else
							rowsAffected = 1;
					}

					break;
			}	// switch

		} catch (Exception e) {
			logger.fatal("TaskDB: addTask\n" + e.toString());
		}

		return temp;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
