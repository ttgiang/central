<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
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
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String user = "THANHG";
	System.out.println("Start<br/>");

	if (processPage){
		try{
			//findKix(conn,"o33e14b11158");
			compareKixes(conn,"TTGo33e14b11158","o33e14b11158-3");
		} catch (Exception e){
			System.err.println ("Error in writing to file");
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static int findKix(Connection conn,String kix) {

/*

1 - tblApprovalHist - o33e14b11158 - 5
2 - tblHtml - o33e14b11158 - 1
3 - tblMisc - o33e14b11158 - 1
4 - tblPrograms - TTGo33e14b11158 - 1
5 - tblUserLog - o33e14b11158 - 18
6 - tblUserLog2 - o33e14b11158 - 22

*/

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		String tbl = "";

		try{
			String sql = "select distinct tbl "
				+ "FROM "
				+ "( "
				+ "SELECT so.name as tbl,sc.name as col "
				+ "FROM syscolumns sc, sysobjects so  "
				+ "WHERE so.id = sc.id  "
				+ "AND (so.xtype='U' OR so.xtype='T')  "
				+ "AND so.name not like '%temp%' "
				+ "AND (sc.name = 'historyid' or sc.name = 'coursealpha' or sc.name like '%alpha%') "
				+ ") as drv "
				+ "where col = 'historyid'  ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				tbl = AseUtil.nullToBlank(rs.getString("tbl"));
				if (tbl != null){

					try{
						sql = "SELECT historyid, count(*) counter FROM " + tbl + " WHERE historyid like '%"+kix+"%' GROUP BY historyid";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ResultSet rs2 = ps2.executeQuery();
						if(rs2.next()){
							int counter = rs2.getInt("counter");
							String historyid = rs2.getString("historyid");
							if (counter > 0){
								System.out.println((++i) + " - " + tbl  + " - " + historyid + " - " + rs2.getInt("counter"));
							}
						}
						rs2.close();
						ps2.close();

					} catch (SQLException e) {
						logger.fatal("Test: lee - " + tbl + " - " + e.toString());
					} catch (Exception e) {
						logger.fatal("Test: lee - " + tbl + " - " + e.toString());
					}

				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("Test: lee - " + tbl + " - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: lee - " + tbl + " - " + e.toString());
		}

		return rowsAffected;

	}

	public static int compareKixes(Connection conn,String kix1, String kix2) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		String item = "functions,outcomes,organized,enroll,resources,efficient,effectiveness,proposed,rationale,substantive,articulated,additionalstaff,requiredhours";
		String[] items = item.split(",");

		try{
			String sql1 = "SELECT " + item + " FROM tblprograms WHERE historyid=?";
			String sql2 = "SELECT " + item + " FROM tblprograms WHERE historyid=?";
			PreparedStatement ps1 = conn.prepareStatement(sql1);
			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ps1.setString(1,kix1);
			ps2.setString(1,kix2);
			ResultSet rs1 = ps1.executeQuery();
			ResultSet rs2 = ps2.executeQuery();
			if(rs1.next() && rs2.next()){

				for(i=0; i<items.length; i++){
					String col1 = AseUtil.nullToBlank(rs1.getString(items[i]));
					String col2 = AseUtil.nullToBlank(rs2.getString(items[i]));

					if(!col1.equals(col2)){
						System.out.println("items not equal = " + items[i]);
					}
					else{
						System.out.println("items equal = " + items[i]);
					}
				}

			}
			rs1.close();
			ps1.close();

			rs2.close();
			ps2.close();

		} catch (SQLException e) {
			logger.fatal("Test: lee - " + items[i] + " - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: lee - " + items[i] + " - " + e.toString());
		}

		return rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html