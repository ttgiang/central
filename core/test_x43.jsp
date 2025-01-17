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

<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="org.jsoup.Jsoup"%>

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
		int rowsAffected = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			HtmlCleaner cleaner = new HtmlCleaner();

/*
"courseCompetencies2" :[{"id": "1", "value": "a. apply knowledge of essential business disciplines including accounting, economics, finance, law, management, and marketing, and use business research methods to analyze information in order to develop solid business plans and strategies, and make effective and efficient business decisions;</p><p>        &nbsp;</p>"},
"courseCompetencies2" :[{"id": "2", "value": "b. use leadership and interpersonal skills to promote business ethics, values, and integrity related to professional activities and personal relationships;</p><p>        &nbsp;</p>"},
"courseCompetencies2" :[{"id": "3", "value": "c apply critical thinking skills to evaluate information, solve problems, and make decisions;</p><p>        &nbsp;</p>"},
"courseCompetencies2" :[{"id": "4", "value": "d. apply quantitative reasoning to enhance independent or group decision-making skills; and</p><p>        &nbsp;</p>"},
"courseCompetencies2" :[{"id": "5", "value": "e. communicate effectively with others utilizing appropriate forms of oral and written communication methods including multimedia presentations that applying information technologies and serve particular audiences and purposes."}]
*/

			String strKey = "";
			String strCol = "";

			FileWriter fstream = null;
			BufferedWriter output = null;

			String fileName = "c:\\tomcat\\webapps\\central\\core\\x43.txt";

			fstream = new FileWriter(fileName);
			output = new BufferedWriter(fstream);

			//String sql = "SELECT * FROM qryMau_Competencies where kscmid = 'BUS495_201710' order by KSCMid, compid";
			String sql = "SELECT * FROM qryMau_Competencies order by KSCMid, compid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				if(strKey.equals("")) strKey = rs.getString("KSCMid");

				String strData = rs.getString("comp");
				String spamy = AntiSpamy.spamy(strKey,"",strData);
				String sanitize = HtmlSanitizer.sanitize(spamy);
				String text = HtmlSanitizer.getText(sanitize).replace("&nbsp;","");

				if(!strKey.equals(rs.getString("KSCMid"))){
					// end one coure
					strCol += "]";
					output.write(strKey+"|"+strCol + "\n");

					// start new one
					strKey = rs.getString("KSCMid");
					strCol = "\"courseCompetencies2\" :[{\"id\": \"" + rs.getString("compid") + "\", \"value\": \"" + text + "\"}";
				}
				else{
					if(!strCol.equals("")) strCol += ", "; else strCol = "\"courseCompetencies2\" :[";
					strCol += "{\"id\": \"" + rs.getString("compid") + "\", \"value\": \"" + text + "\"}";
				}
			}

			rs.close();
			ps.close();

			// catch last course
			strCol += "]";
			output.write(strKey+"|"+strCol + "\n");
			output.close();
			System.out.println(strCol);

			aseUtil = null;

		} catch (IOException e) {
			logger.fatal("Test IOException - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("Test SQLException - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test Exception - " + e.toString());
		} finally {
		}

		return "";
	} // Test

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
