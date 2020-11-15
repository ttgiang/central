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

	String campus = "HIL";
	String alpha = "ANTH";
	String num = "215";
	String user = "THANHG";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		try{
			Programs(conn,campus,user);
		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!
static String[] header = null;
static CellProcessor[] processor = null;
static String[] dataColumns = null;
static String programItems = null;
static int arraySize = 0;

	public static String Programs(Connection conn,String campus,String user) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		String outputFileName = "";

		String temp = "";

		boolean append = false;

		boolean hasData = true;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			// determine the campus question and number of questions to work with.
			// campus,progress,proposer,effectivedate,title,degree,divisionname
			// 15 HAW - proposed,requiredhours,P14,P20,P15,rationale,P17,outcomes
			// 17 HIL - outcomes,functions,organized,enroll,resources,effectiveness,additionalstaff,rationale,requiredhours,articulated
			// 20 LEE - functions,outcomes,organized,enroll,resources,efficient,effectiveness,proposed,rationale,substantive,articulated,additionalstaff,requiredhours
			QuestionDB qb = new QuestionDB();
			programItems = qb.getProgramColumns(conn,campus);
			qb = null;

			if(programItems != null && !programItems.equals("")){
				programItems = "campus,progress,proposer,effectivedate,title,degree,divisionname," + programItems + ",auditby,auditdate";
				String[] junk = programItems.split(",");
				arraySize = junk.length;
			}

			header = getHeader(campus);

System.out.println("1");

			processor = getCellProcessor(campus);

			dataColumns = getDataColumns();

System.out.println("2");

System.out.println(header.length);
System.out.println(processor.length);
System.out.println(dataColumns.length);

			// make sure number of columns are similar before processing
			if((header.length == processor.length) && (processor.length == dataColumns.length)){

System.out.println("3");

				String writeDir = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ outputFileName;

				String fileName = writeDir + ".out";

				String outputFile = writeDir + ".csv";

				writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);
				writer.writeHeader(header);

				String sql = Export(campus);

				if(sql != null && !sql.equals("")){
					final HashMap<String, ? super Object> data = new HashMap<String, Object>();
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while(rs.next()){

						for(int counter = 0; counter < dataColumns.length; counter++){
							//temp = Jsoup.parse(AseUtil.nullToBlank("" + rs.getString(dataColumns[counter]))).text();
							data.put(header[counter], temp);
						}
						writer.write(data, header, processor);

					}
					rs.close();
					ps.close();
				}
			} // valid length

		} catch (IOException e) {
			logger.fatal("Programs - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("Programs - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Programs - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("Programs - " + e.toString());
			}
		}

System.out.println("4");

		return outputFileName;
	} // Programs

	/*
	*
	* getCellProcessor
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static CellProcessor[] getCellProcessor(String campus) {

		Logger logger = Logger.getLogger("test");

		CellProcessor[] cellProcessor = null;

		try{
			String[] hdr = programItems.split(",");
			cellProcessor = new CellProcessor[hdr.length];
			for(int i=0; i < hdr.length; i++){
				cellProcessor[i] = new ConvertNullTo("\"\"");
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getCellProcessor: " + e.toString());
		}

		return cellProcessor;

	}

	/*
	*
	* getHeader
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static String[] getHeader(String campus) {

		Logger logger = Logger.getLogger("test");

		String[] header = null;

		try{
			String[] hdr = programItems.split(",");
			header = new String[hdr.length];
			for(int i=0; i < hdr.length; i++){
				header[i] = hdr[i];
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getHeader: " + e.toString());
		}

		return header;

	}

	/*
	*
	* getDataColumns
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static String[] getDataColumns() {

		Logger logger = Logger.getLogger("test");

		String[] columns = null;

		try{
			String[] hdr = programItems.split(",");
			columns = new String[hdr.length];
			for(int i=0; i < hdr.length; i++){
				columns[i] = hdr[i];
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getDataColumns: " + e.toString());
		}

		return columns;

	}

	/*
	*
	* Export
	*<p>
	* @param	sql	String
	*<p>
	*
	*/
	public static String Export(String campus) {

		Logger logger = Logger.getLogger("test");

		String sql = "";

		try{
			sql = "select " + programItems + " from vw_programs where campus = '" + campus+ "' order by progress";
		}
		catch(Exception e){
			logger.fatal("Programs: " + e.toString());
		}

		return sql;

	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
