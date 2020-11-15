<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "ACC";
	String num = "151";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "W39b9i11236";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		insertOutLineReview(conn,campus,user,alpha,num);
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

		<input id="cmdSubmit" title="continue with request" type="submit" value="Submit" class="inputsmallgray">&nbsp;
		<input id="cmdCancel" title="end requested operation" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
		<input type="hidden" value="<%=kix%>" name="kix">
		<input type="hidden" value="c" name="formAction">
		<input type="hidden" value="aseForm" name="formName">

</table>

<%!
	public static int insertOutLineReview(Connection conn,String campus,String user,String alpha,String num) throws Exception {

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		int[] items = new int[4];
		items[0] = 89;
		items[1] = 3;
		items[2] = 96;
		items[3] = 97;

		int mode = 3;
		String table = "1";

		for(int i=0;i<items.length;i++){
			Review reviewDB = new Review();
			reviewDB.setId(0);
			reviewDB.setUser(user);
			reviewDB.setAlpha(alpha);
			reviewDB.setNum(num);
			reviewDB.setHistory(kix);
			reviewDB.setComments("item " + items[i] + ": " + (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date())
				+ "\nNow that you have a Google Apps account, it's time to make the switch to Gmail, Google Calendar, and all the other new apps you'll be working with! Use this site as a guide during your first days and throughout the transition.");
			reviewDB.setItem(items[i]);
			reviewDB.setCampus(campus);
			reviewDB.setEnable(true);
			reviewDB.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			ReviewDB.insertReview(conn,reviewDB,table,mode);
		}

		return 0;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>