<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>

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

	String campus = "KAU";
	String alpha = "ITE";
	String num = "390E";
	String type = "ARC";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "H28j30b1334";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			String temp = "crscnclled,crsdltd,vwhtml,crsexc,crsexp,crscon,vwcrsx,crsinfy,crssts,crsrvwsts,"
				+ "prgvw,prginfy,lstcoreqx,lstprereqx,crsrpt,crscmpr,crsrpt,crsrpt-cur,crsrpt-trms,crsrpt-enddate,"
				+ "crsrpt-expdate,crsrpt-rvwdate,crsrpt-fstrck,crsrpt-app,crsrpt-del,crsrpt-mod,crsrpt-txt,er16,"
				+ "crsrpt-showSLO,crsrpt-noSLO,crsrpt-showComp,crsrpt-noComp,prglo,prgrpt-app,prgdte";

			String[] reports = temp.split(",");

			for(int i=0; i<reports.length;i++){
				out.println(reports[i] + " - " + countRows(reports[i]) + "<br>");
			}
		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	/*
	 * A course is copyable if it's in the right progress
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	toAlpha	String
	 *	@param	toNum		String
	 * <p>
	 *	@return Msg
	 */
	public static int countRows(String report) throws SQLException {

		Logger logger = Logger.getLogger("test");

		String filename = "c:\\tomcat\\webapps\\central\\logs\\ase.log";
		int counter = 0;
		int rowsAffected = 0;

		try{

			File target = new File(filename);
			if (target.exists()){
				String line;
				BufferedReader inputStream = new BufferedReader(new FileReader(filename));
				if (inputStream != null){
					while ((line = inputStream.readLine()) != null){
						++counter;
						if(line.toLowerCase().contains(report)){
							++rowsAffected;
						}
					}
					inputStream.close();
				}
			}

		} catch (Exception e){
			System.err.println (e.toString());
		}


		return rowsAffected;
	}


%>

</form>
		</td>
	</tr>
</table>

</body>
</html
