<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.ase.aseutil.html.Html2Text"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.supercsv.*"%>
<%@ page import="org.supercsv.io.*"%>
<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.*"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>
<%@ page import="net.htmlparser.jericho.*"%>
<%@ page import="java.net.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "ER00001";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ACC";
	String num = "124";
	String type = "PRE";
	String user = "ERICD";
	String kix = "g17k15l10183";
	String message = "";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(com.ase.aseutil.export.Export.exportPLO(conn,campus,user));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	/*
	*
	*<p>
	* @param	conn	Connection
	* @param	user	String
	*<p>
	*
	*/
	public static int exportSLO(Connection conn,String user) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String outputFile = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\lee.csv";

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		com.ase.aseutil.util.FileUtils fu = null;

		try{
			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			final String[] header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "EffectiveTerm", "ModifiedDate", "SLO" };

    		CellProcessor[] processor = new CellProcessor[] { new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\"") };

			final HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer.writeHeader(header);

			html2Text = new Html2Text();

			fu = new com.ase.aseutil.util.FileUtils();

			String sql = "SELECT question_number,cccm6100,question_friendly,question_type "
							+ "FROM CCCM6100 "
							+ "WHERE campus=? "
							+ "AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,"SYS");
			ps.setString(2,"Course");
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String crsAlpha = AseUtil.nullToBlank(rs.getString("crsalpha"));
				String crsNo = AseUtil.nullToBlank(rs.getString("crsno"));
				String crsTitle = AseUtil.nullToBlank(rs.getString("crsTitle"));
				String effectiveTerm = AseUtil.nullToBlank(rs.getString("effectiveTerm"));
				String modifiedDate = AseUtil.nullToBlank(rs.getString("modifiedDate"));
				String slo = AseUtil.nullToBlank(rs.getString("slo"));

				fu.writeToFile(user,slo);

				String fileName = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ user
										+ ".out";

				slo = html2Text.HTML2Text(fileName);

				data.put(header[0], crsAlpha);
				data.put(header[1], crsNo);
				data.put(header[2], removeHTML(crsTitle));
				data.put(header[3], effectiveTerm);
				data.put(header[4], modifiedDate);
				data.put(header[5], removeHTML(slo));

				writer.write(data, header, processor);

			}
			rs.close();
			ps.close();

		} catch (IOException e) {
			logger.fatal("exportSLO - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportSLO - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportSLO - " + e.toString());
		} finally {

			fu = null;

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportSLO - " + e.toString());
			}
		}

		return rowsAffected;
	} // exportSLO

	public static String removeHTML(String html) {

		if (html != null){
			html = html.replaceAll("\\<.*?\\>", "");

			html = html.replaceAll("\r", "\n");
			html = html.replaceAll("&nbsp;", " ");
			html = html.replaceAll("&amp;", "&");
			html = html.replaceAll("<br/>", "\n");
			html = html.replaceAll("&#39;", "\'");
			html = html.replaceAll("&quot;", "\"");
			html = html.replaceAll("&lt;", "<");
			html = html.replaceAll("&gt;", ">");
		}

		return html;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

