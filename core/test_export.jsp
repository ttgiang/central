<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

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

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ANTH";
	String num = "215";
	String user = "THANHG";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		try{
			KualiExport(conn,"los",campus,user);
		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	/*
	* KualiExport
	*<p>
	* @param	conn		Connection
	* @param	report	String
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static String KualiExport(Connection conn,String report,String campus,String user) {

		Logger logger = Logger.getLogger("test");

		// header for csv processing
		String[] header = null;

		// header for csv processing
		String[] dataType = null;

		// how CSV cells are created
		CellProcessor[] processor = null;

		// database columns
		String[] dataColumns = null;

		ICsvMapWriter writer = null;

		int rowsAffected = 0;

		String outputFileName = "";
		String temp = "";
		String junk = "";

		boolean append = false;
		boolean hasData = true;

		try{
			AseUtil aseUtil = new AseUtil();

			outputFileName = user + "_" + report + "_" + SQLUtil.createHistoryID(1);

			String columns = getColumns(conn,report);
			header =  getHeader(columns);

			String dataTypes = getDataType(conn,report,columns);
			dataType = dataTypes.split(",");

			dataColumns = getHeader(columns);

			processor = getCellProcessor(dataColumns.length);

			// make sure number of columns are similar before processing

			if((header.length == processor.length) && (processor.length == dataColumns.length)){

				String writeDir = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ outputFileName;

				String fileName = writeDir + ".out";

				String outputFile = writeDir + ".csv";

				writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);
				writer.writeHeader(header);

				String sql = getSql(columns, report);

				if(sql != null && !sql.equals("")){
					final HashMap<String, ? super Object> data = new HashMap<String, Object>();
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while(rs.next()){

						for(int counter = 0; counter < dataColumns.length; counter++){

							junk = AseUtil.nullToBlank("" + rs.getString(dataColumns[counter]));

							//
							// explain and course share a single view and explain is all text data type
							//

							temp = "";

							if(report.equals("course")){
								if(dataType[counter].indexOf("smalldatetime") >= 0){
									if(junk.length() > 1){
										try{
											temp = DateUtility.formatDateAsString(junk);
										}
										catch(Exception ex){
											System.out.println(dataType[counter]);
										}
									}
								}
								else{
									//temp = Jsoup.parse(junk).text();
								}
							}
							else{
								//temp = Jsoup.parse(junk).text();
							}

							data.put(header[counter], temp);
						}
						writer.write(data, header, processor);

					}
					rs.close();
					ps.close();

				} // if sql

			} // matching lengths

			aseUtil = null;

		} catch (IOException e) {
			logger.fatal("KualiExport IOException - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("KualiExport SQLException - " + e.toString());
		} catch (Exception e) {
			logger.fatal("KualiExport Exception - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("KualiExport - " + e.toString());
			}
		}

		return outputFileName;
	} // KualiExport

	/*
	*
	* getCellProcessor
	*
	*/
	public static CellProcessor[] getCellProcessor(int len) {

		Logger logger = Logger.getLogger("test");

		CellProcessor[] cellProcessor = new CellProcessor[len];

		try{
			for(int i = 0; i < len; i++){
				cellProcessor[i] = new ConvertNullTo("\"\"");
			}
		}
		catch(Exception e){
			logger.fatal("KualiExport - getCellProcessor: " + e.toString());
		}

		return cellProcessor;

	}

	/*
	*
	* getHeader
	*
	*/
	public static String[] getHeader(String columns) {

		Logger logger = Logger.getLogger("test");

		String[] aColumns = columns.split(",");

		String[] header = new String[aColumns.length];

		try{
			for(int i = 0; i < aColumns.length; i++){
				header[i] = aColumns[i];
			}
		}
		catch(Exception e){
			logger.fatal("KualiExport - etHeader: " + e.toString());
		}

		return header;

	}

	/*
	*
	* getColumns
	*
	*/
	public static String getColumns(Connection conn, String report) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String columns = "";

		try{

			PreparedStatement ps = null;
			ResultSet rs = null;

			if(report.equals("coreq")){
				columns = "campus,historyid,CourseAlpha,CourseNum,id,Grading";
			}
			else if(report.equals("course")){
				sql = "select col from vw_course_schema_in_use order by id";
				columns = "campus,historyid";
			}
			else if(report.equals("explain")){
				sql = "select explain as col from vw_course_schema_in_use where not explain is null AND explain <> '' order by id";
				columns = "campus,historyid";
			}
			else if(report.equals("ini")){
				columns = "campus,category,kdesc,kid,kval1,seq";
			}
			else if(report.equals("los")){
				columns = "Campus,historyid,CourseAlpha,CourseNum,datatype,seq,data";
			}
			else if(report.equals("prereq")){
				columns = "campus,historyid,CourseAlpha,CourseNum,id,Grading";
			}
			else if(report.equals("recprep")){
				columns = "campus,historyid,id,CourseAlpha,CourseNum,Grading";
			}
			else if(report.equals("xref")){
				columns = "campus,historyid,CourseAlpha,CourseNum,Id,CourseAlphaX,CourseNumX";
			}

			if(report.equals("course") || report.equals("explain")){
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){
					if(columns.length() > 0){
						columns = columns + ",";
					}
					columns += AseUtil.nullToBlank(rs.getString("col"));
				}

				rs.close();
				rs = null;
				ps.close();
				ps = null;
			}

		}
		catch(Exception e){
			logger.fatal("KualiExport - getColumns: " + e.toString());
		}

		//System.out.println("getColumns: " + columns);

		return columns;

	} // getColumns

	/*
	*
	* getDataType
	*
	*/
	public static String getDataType(Connection conn, String report, String columns) {

		Logger logger = Logger.getLogger("test");

		//
		// add 2 text items for historyid and campus
		//
		String dataType = "";
		String tbl = "";

		try{
			PreparedStatement ps = null;
			ResultSet rs = null;

			if(report.equals("coreq")){
				tbl = "tblcoreq";
			}
			else if(report.equals("course")){
				tbl = "tblcourse";
			}
			else if(report.equals("explain")){
				tbl = "tblcampusdata";
			}
			else if(report.equals("ini")){
				tbl = "tblini";
			}
			else if(report.equals("los")){
				tbl = " vw_all_campus_list";
			}
			else if(report.equals("prereq")){
				tbl = "tblprereq";
			}
			else if(report.equals("recprep")){
				tbl = "tblextra";
			}
			else if(report.equals("xref")){
				tbl = "tblxref";
			}

			if(report.equals("los")){
				dataType = "varchar,varchar,varchar,varchar,text,int,text";
			}
			else{
				String[] aColumns = columns.split(",");

				for(int i = 0; i < aColumns.length; i++){

					if(dataType.length() > 0){
						dataType += ",";
					}

					dataType += getColumnDataType(conn, tbl, aColumns[i]);
				}
			}

		}
		catch(Exception e){
			logger.fatal("Export: " + e.toString());
		}

		//System.out.println("KualiExport - getDataType: " + dataType);

		return dataType;

	} // getDataType

	/*
	*
	* getColumnDataType
	*
	*/
	public static String getColumnDataType(Connection conn, String tbl, String col) {

		Logger logger = Logger.getLogger("test");

		String columnDataType = "";

		try{
			PreparedStatement ps = conn.prepareStatement("select dt from vw_course_column_schema where tbl = ? and col = ?");
			ps.setString(1, tbl);
			ps.setString(2, col);
			ResultSet rs = ps.executeQuery();

			if(rs.next()){
				columnDataType = AseUtil.nullToBlank(rs.getString("dt"));
			}

			//System.out.println(tbl + " - " + col + " - " + columnDataType);

			rs.close();
			rs = null;
			ps.close();
			ps = null;
		}
		catch(Exception e){
			logger.fatal("KualiExport - getColumnDataType: " + e.toString());
		}

		return columnDataType;

	} // getColumnDataType

	/*
	*
	* getSql
	*
	*/
	public static String getSql(String columns, String report) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String table = "";
		String where = " where coursetype='CUR'";
		String orderby = " order by campus ";

		try{

			if(report.equals("coreq")){
				table = " tblcoreq ";
			}
			else if(report.equals("course")){
				table = " tblcourse ";
			}
			else if(report.equals("explain")){
				table = " tblcampusdata ";
			}
			else if(report.equals("ini")){
				table = " tblini ";
				where = "";
				orderby = " order by campus, category ";
			}
			else if(report.equals("los")){
				table = " vw_all_campus_list ";
				where = "";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("prereq")){
				table = " tblprereq ";
			}
			else if(report.equals("recprep")){
				table = " tblextra ";
			}
			else if(report.equals("xref")){
				table = " tblXRef ";
			}

			sql = "select " + columns + " from " + table + " " + where + " " + orderby;

		}
		catch(Exception e){
			logger.fatal("KualiExport - getSql: " + e.toString());
		}

		//System.out.println("getSql: " + sql);

		return sql;

	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
