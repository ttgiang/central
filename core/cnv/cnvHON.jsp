<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Data Conversion";
	fieldsetTitle = "Data Conversion";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	System.out.println("Start<br/>");

	if (processPage){
		//processData(conn,"HON");
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * processData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int processData(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int tables = 0;

		try{

			System.out.println("processData" + Html.BR());
			String sql = "SELECT historyid,repeat,max_credits FROM tblcoursehon";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String repeat = AseUtil.nullToBlank(rs.getString("repeat"));
				String max_credits = AseUtil.nullToBlank(rs.getString("max_credits"));

				String c19 = "";
				boolean repeatable = false;
				if(!repeat.equals("0")){
					repeatable = true;
					c19 = repeat;
				}

				sql = "UPDATE tblcourse SET repeatable=?,maxcredit=? WHERE campus=? AND historyid=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setBoolean(1,repeatable);
				ps2.setString(2,max_credits);
				ps2.setString(3,campus);
				ps2.setString(4,kix);
				int rowsAffected = ps2.executeUpdate();
				ps2.close();


				sql = "UPDATE tblcampusdata SET c19=? WHERE campus=? AND historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,c19);
				ps2.setString(2,campus);
				ps2.setString(3,kix);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - processData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - processData: " + e.toString());
		}

		return tables;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>