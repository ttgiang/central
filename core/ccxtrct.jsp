<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
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
	*	ccxtrct.jsp
	*	2007.09.01
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
	String alpha = "VIET";
	String num = "197F";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "K34k8i11123";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		String temp = "";

		int idx = website.getRequestParameter(request,"idx",0);

		switch(idx){
			case 1:
				temp = xtrct(conn);
				break;
			case 2:
				temp = write(conn,user);
				break;
		}

	}

%>
	<ul>
		<li><a href="?idx=1" class="linkcolumn">Correct Data</a></li>
		<li><a href="?idx=2" class="linkcolumn">Export</a></li>
	</ul>

<%
	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String xtrct(Connection conn) {

Logger logger = Logger.getLogger("test");

/*
drop table zzzmorton;

SELECT     tblCourse.historyid, tblCourse.campus, tblCourse.CourseAlpha, tblCourse.CourseNum, tblCourse.coursetitle, tblCourse.credits,
                      tblCourse.hoursperweek, tblCourse.X32 AS contacthours, tblCampusData.C20
INTO zzzmorton
FROM         tblCourse LEFT OUTER JOIN
                      tblCampusData ON tblCourse.historyid = tblCampusData.historyid
WHERE     (tblCourse.CourseType = 'CUR') AND (tblCourse.campus = 'HIL' OR
                      tblCourse.campus = 'KAP' OR
                      tblCourse.campus = 'LEE')
ORDER BY tblCourse.campus, tblCourse.CourseAlpha, tblCourse.CourseNum

ALTER TABLE zzzmorton ADD id int IDENTITY (1,1);

select *
from zzzmorton
where not contacthours is null AND cast(contacthours as varchar)<>''

*/

		String sql = "";

		sql = "select * "
						+ "from zzzmorton "
						+ "where campus='HIL' AND not contacthours is null";

		sql = "select * "
						+ "from zzzmorton "
						+ "where campus='KAP' AND contacthours like '%456%'";

		sql = "select * "
						+ "from zzzmorton "
						+ "where campus='KAP' AND contacthours like '%457%'";

		sql = "select * "
						+ "from zzzmorton "
						+ "where campus='KAP' AND contacthours like '%458%'";

		sql = "select * "
						+ "from zzzmorton "
						+ "where campus='KAP' AND contacthours like '%786%'";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int id = rs.getInt("id");
				String contacthours = rs.getString("contacthours");
				if (contacthours != null){
					String[] data = contacthours.split(",");
					String temp = "";
					for (int i=0; i<data.length; i++){
						try{
							Ini ini = IniDB.getINI(conn,Integer.parseInt(data[i]));
							String descr = ini.getKdesc();
							if (temp.equals(Constant.BLANK)){
								temp = descr;
							}
							else{
								temp = temp + "," + descr;
							}
						}
						catch(Exception e){
							//
						}

						//System.out.println(id + " - " + data[i] + " - " + temp);
						sql = "UPDATE zzzmorton SET contacthours=? WHERE id= ?";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,temp);
						ps2.setInt(2,id);
						ps2.executeUpdate();
					}
				}
			} // if rs
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("userDB: xtrct - " + e.toString());
		}

		return "";
	}

	public static String write(Connection conn,String user) {

Logger logger = Logger.getLogger("test");

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		String outputFileName = "";

		String sql = "";

		PreparedStatement ps = null;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

			String[] header = null;

			String[] column = null;

    		CellProcessor[] processor = null;

			HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			html2Text = new Html2Text();

			sql = "SELECT campus,coursealpha,coursenum,coursetitle,credits,hoursperweek,contacthours,c20 "
					+ "FROM zzzmorton "
					+ "ORDER BY campus,coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			processor = new CellProcessor[] {	new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\"") };
			header = new String[] { "Campus", "Alpha", "Number", "Title", "Credits", "HoursPerWeek", "ContactHours", "ContactHours2" };
			column = new String[] { "Campus", "courseAlpha", "courseNum", "courseTitle", "Credits", "HoursPerWeek", "ContactHours", "C20" };

			writer.writeHeader(header);

			int columnCounter = header.length;

			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				for(int i=0; i<columnCounter; i++){
					data.put(header[i], AseUtil.nullToBlank(rs.getString(column[i])));
				}

				writer.write(data, header, processor);

			}
			rs.close();
			ps.close();

		} catch (IOException e) {
			logger.fatal("exportGeneric - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportGeneric - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportGeneric - " + e.toString());
		} finally {

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportGeneric - " + e.toString());
			}
		}

		return outputFileName;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>