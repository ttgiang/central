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
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	out.println("Start<br/>");

	//out.println("resequence INI..." + resequenceINI(conn,"KAP") + " <br/>");
	//out.println("resequence INI..." + resequenceINI(conn,"LEE") + " <br/>");
	//out.println("resequence INI..." + resequenceINI(conn,"MAU") + " <br/>");

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	resequenceINI
	*/
	public static int resequenceINI(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int id = 0;
		int rowsAffected = 0;
		String[] cat = new String[11];

		cat[0] = "ApprovalRouting";
		cat[1] = "ContactHrs";
		cat[2] = "Expectations";
		cat[3] = "FunctionDesignation";
		cat[4] = "GESLO";
		cat[5] = "Grading";
		cat[6] = "MethodDelivery";
		cat[7] = "MethodEval";
		cat[8] = "MethodInst";
		cat[9] = "Semester";
		cat[10] = "System";

		// GESLO = Aesthetic Engagement, Communication, Interactive Learning, Self and Community/Diversity of Human Experience, Thinking/Inquiry
		try{
			for (i=0; i<cat.length; i++){

				j = 0;

				String sql = "SELECT seq,id "
					+ "FROM tblINI "
					+ "WHERE campus=? AND category=? ORDER BY kdesc";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,cat[i]);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					id = rs.getInt("id");
					sql = "UPDATE tblINI "
						+ "SET seq=? "
						+ "WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,j++);
					ps.setInt(2,id);
					ps.executeUpdate();
					++rowsAffected;
				}
				rs.close();
				ps.close();
			}
		}
		catch(SQLException sx){
			logger.fatal("resequenceINI: resequenceINI - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("resequenceINI: resequenceINI - " + ex.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

