<%@ page import="org.apache.log4j.Logger"%>
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

	String campus = "KAP";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100B";
	String type = "CUR";
	String task = "Modify_outline";
	String kix = "E43g26g946";
	int t = 0;

	kix = helper.getKix(conn,campus,alpha,num,"CUR");

	out.println("Start<br/>");

	try{
		//out.println(Outlines.showProgramSLO(conn,"E43g26g946","X72"));
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	public static String showProgramSLO(Connection conn,String kix,String src) throws Exception {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean found = false;
		String sql = "";
		String temp = "";
		String img = "";

		StringBuffer buffer = new StringBuffer();
		int i = 0;
		int j = 0;

		try {
			sql = "SELECT comments "
				+ "FROM tblGenericContent "
				+ "WHERE historyid=? and  "
				+ "src=? "
				+ "ORDER BY rdr";
			String xprms[] = {kix,src};
			String xdt[] = {"s","s"};
			String[] xAxis = SQLUtil.resultSetToArray(conn,sql,xprms,xdt);

			sql = "SELECT id "
				+ "FROM tblGenericContent "
				+ "WHERE historyid=? and  "
				+ "src=? "
				+ "ORDER BY rdr";
			String[] xiAxis = SQLUtil.resultSetToArray(conn,sql,xprms,xdt);

			sql = "SELECT content "
				+ "FROM tblCourseCompetency "
				+ "WHERE historyid=? "
				+ "ORDER BY rdr";
			String yprms[] = {kix};
			String ydt[] = {"s"};
			String[] yAxis = SQLUtil.resultSetToArray(conn,sql,yprms,ydt);

			sql = "SELECT seq "
				+ "FROM tblCourseCompetency "
				+ "WHERE historyid=? "
				+ "ORDER BY rdr";
			String[] yiAxis = SQLUtil.resultSetToArray(conn,sql,yprms,ydt);

			// print header row
			buffer.append(Constant.TABLE_START);
			buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
			buffer.append(Constant.TABLE_CELL_DATA_COLUMN);
			buffer.append("ProgramSLO/<br>Competency");
			buffer.append(Constant.TABLE_CELL_END);
			for(i=0;i<yAxis.length;i++){
				buffer.append(Constant.TABLE_CELL_DATA_COLUMN + yAxis[i] + Constant.TABLE_CELL_END);
			}
			buffer.append(Constant.TABLE_ROW_END);

			// print detail row
			for(i=0;i<xAxis.length;i++){
				buffer.append(Constant.TABLE_ROW_START);
				buffer.append(Constant.TABLE_CELL_DATA_COLUMN + xAxis[i] + Constant.TABLE_CELL_END);

				for(j=0;j<yAxis.length;j++){
					if (isProgramSLOLinked(conn,kix,src,xiAxis[i],yiAxis[j]))
						img = "<p align=center><img src='../images/images/checkmarkG.gif' border='0'></p>";
					else
						img = "&nbsp;";

					buffer.append(Constant.TABLE_CELL_DATA_COLUMN
						+ img
						+ Constant.TABLE_CELL_END);
				}

				buffer.append(Constant.TABLE_ROW_END);
			}
			buffer.append(Constant.TABLE_END);

		} catch (SQLException ex) {
			logger.fatal("Outlines: showProgramSLO\n" + ex.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: showProgramSLO\n" + e.toString());
		}

		temp = buffer.toString();

		temp = temp.replace("border=\"0\"","border=\"1\"");

		return temp;
	}

	public static boolean isProgramSLOLinked(Connection conn,String kix,String src,String x, String y) throws SQLException {
		String sql = "SELECT id "
			+ "FROM vw_GenericContent2Linked "
			+ "WHERE historyid=? "
			+ "AND src=? "
			+ "AND seq=? "
			+ "AND item=? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,src);
		ps.setString(3,x);
		ps.setString(4,y);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
