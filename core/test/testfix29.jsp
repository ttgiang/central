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

		int rowsAffected = 0;
		PreparedStatement ps = null;
		String X29 = "Suggested Grading Scale:<br/><br/>"
			+ "90 - 100% = A<br/>"
			+ "80 - 89% = B<br/>"
			+ "70 - 79% = C<br/>"
			+ "60 - 69% = D<br/>"
			+ "less than 60% = F<br/><br/>"
			+ "Whatever method of evaluation is used, it is understood that the instructor reserves the right to make necessary and reasonable adjustments to the evaluation policies outlined.";

		try{
			String sql = "UPDATE tblCourse "
					+ " SET x77=? "
					+ " WHERE campus='KAP' AND coursetype='CUR' AND progress='APPROVED' AND x77 is null";
			ps = conn.prepareStatement(sql);
			ps.setString(1,X29);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return "updated " + rowsAffected + " rows";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

