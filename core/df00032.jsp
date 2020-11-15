<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "DF00032";
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
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	df00001.jsp
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String user = "THANHG";


	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(correctProposerName(conn));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"df00032",user);
%>

</table>

<%!

	/*
	 * correctProposerName
	 * <p>
	 * @param	connection
	 * <p>
	 * @return int
	 */
	public static int correctProposerName(Connection conn){

// TEMPDB (DF00032)

Logger logger = Logger.getLogger("test");

		String proposer = null;

		int id = 0;
		int rowsAffected = 0;

		try{
			logger.info("------------------- correctProposerName START");

			/*
				correct the proposer name means that the task submittedby should always be the proposer
				and not the name of the submittedfor.

				when submittedby is not the proposer as in the case of the last AND clause, we know
				something is not right.

			*/
			String sql = "SELECT t.campus,t.coursealpha, t.coursenum, t.id, t.submittedby, t.submittedfor,   c.proposer "
						+ "FROM tblCourse c, "
						+ "( "
						+ "select id, submittedby, submittedfor, coursealpha, coursenum, campus "
						+ "from tbltasks "
						+ "where submittedby = submittedfor "
						+ ") AS t "
						+ "WHERE c.campus=t.campus "
						+ "AND c.coursealpha=t.coursealpha "
						+ "AND c.coursenum=t.coursenum "
						+ "AND NOT c.proposer is null "
						+ "AND c.proposer <> t.submittedby "
						+ "ORDER BY t.campus, t.coursealpha, t.coursenum, t.submittedby ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				id = rs.getInt("id");
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				String submittedfor = AseUtil.nullToBlank(rs.getString("submittedfor"));

				if (proposer != null && proposer.length() > 0){
					sql = "UPDATE tblTasks SET submittedby=? WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,proposer);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();

					logger.info(alpha + " - " + num + " - " + proposer + " - " + submittedby + " - " + submittedfor);

					++rowsAffected;
				}

			} // while
			rs.close();
			ps.close();

			logger.info("fixed " + rowsAffected + " names");

			logger.info("------------------- correctProposerName END");

		}
		catch(SQLException sx){
			logger.fatal("TaskDB: correctProposerName - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("TaskDB: correctProposerName - " + ex.toString());
		}

		return rowsAffected;

	} // correctProposerName

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>