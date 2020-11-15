<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ACC";
	String num = "101";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "a59h15j92203319";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){

		int i = 0;

		// stocks
		String symbol = "ggp,goog,hhc,mhtx,msft,orcl";
		String[] symbols = symbol.split(",");
		int totalStocks = symbols.length;

		// quantity
		float[] qty = new float[totalStocks]; // "33,3,3,100,39,21";
		qty[0] = 33;
		qty[1] = 3;
		qty[2] = 3;
		qty[3] = 100;
		qty[4] = 39;
		qty[5] = 21;

		float price = 0f;

		com.test.stock.StockPriceBean spbean = new com.test.stock.StockPriceBean();

		for(i = 0; i < totalStocks; i++){
			spbean.setSymbol(symbols[i]);
			price = spbean.getLatestPrice();
			out.println(symbols[i] + " = " + price + ", " + (price * qty[i]) + Html.BR() );
		}

		spbean = null;
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>