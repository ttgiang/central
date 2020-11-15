<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ page import="java.io.StringWriter"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>

<%@ page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@ page import="javax.xml.transform.Transformer"%>
<%@ page import="javax.xml.transform.TransformerFactory"%>
<%@ page import="javax.xml.transform.TransformerException"%>
<%@ page import="javax.xml.transform.TransformerConfigurationException"%>
<%@ page import="javax.xml.transform.dom.DOMSource"%>
<%@ page import="javax.xml.transform.stream.StreamResult"%>
<%@ page import="javax.xml.parsers.ParserConfigurationException"%>

<%@ page import="org.w3c.dom.Document"%>
<%@ page import="org.w3c.dom.Element"%>
<%@ page import="org.w3c.dom.Attr"%>
<%@ page import="org.w3c.dom.Node"%>
<%@ page import="org.w3c.dom.NodeList"%>
<%@ page import="org.xml.sax.*"%>

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

<!--
	CATALOG {
		background-color: #ffffff;
		width: 100%;
	}

	CD{
		display: block;
		margin-bottom: 30pt;
		margin-left: 0;
	}

	TITLE{
		color: #FF0000;
		font-size: 20pt;
	}

	ARTIST{
		color: #0000FF;
		font-size: 20pt;
	}

	COUNTRY,PRICE,YEAR,COMPANY{
		display: block;
		color: #000000;
		margin-left: 20pt;
	}
-->

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

	String campus = "HAW";
	String alpha = "GEOL";
	String num = "150";
	String type = "PRE";
	String user = "KOMENAKA";
	String task = "Modify_outline";
	String kix = "s32l8f1274";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		read(conn,campus,kix);
		//com.ase.aseutil.export.ExportXML.process(conn,campus,kix);
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/**
	* parseValue
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	kix		String
	*<p>
	*/
	public static void read(Connection conn,String campus,String kix) {

		try {

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];

			String table = "";
			String column = "";

			String fileName = AseUtil.getCurrentDrive()
							+ ":"
							+ SysDB.getSys(conn,"documents")
							+ "xml" + "\\"
							+ campus + "\\"
							+ alpha + "_" + num + "_" + kix+".xml";

			File fXmlFile = new File(fileName);

			//------------------------------------------------
			// create factory
			//------------------------------------------------
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

			//------------------------------------------------
			// create builder
			//------------------------------------------------
			DocumentBuilder dBuilder = null;

			try {
				dBuilder = dbFactory.newDocumentBuilder();
			}
			catch (ParserConfigurationException ex) {
				System.out.println ("Oh no!");
			}

			//------------------------------------------------
			// create document
			//------------------------------------------------

			Document document = null;

			try {
				document = dBuilder.parse(fXmlFile);
			}
			catch (IOException ex) {
				System.out.println ("No file!");
			}
			catch (SAXException ex) {
				System.out.println ("Horrible error!");
			}

			//------------------------------------------------
			// get elements
			//------------------------------------------------

			Element rootElement = document.getDocumentElement();

			if (rootElement != null){

				System.out.println("------------------------------------");

				System.out.println("root: " + rootElement.getNodeName());

				System.out.println("outline: " + alpha + " - " + num);

				// this is the list of tables
				NodeList rootNodeList = rootElement.getChildNodes();

				System.out.println("nodes: " + rootNodeList.getLength());

				// work on 1 table at a time as long as there are nodes (i)
				// for every table, work on every row (j)
				// for every row, work on every column (k)

				//for(int i = 0; i < rootNodeList.getLength() ; i++){
				for(int i = 0; i < 6 ; i++){

					Node tables = rootNodeList.item(i);

					NodeList tableList = tables.getChildNodes();

					if(tableList != null && tableList.getLength() > 0){

						Element tableElement = (Element)tables;

						table = tableElement.getNodeName();

						for(int j = 0; j < tableList.getLength() ; j++){

							Node tableNode = tableList.item(j);

							NodeList rowNodeList = tableNode.getChildNodes();

							if(rowNodeList != null && rowNodeList.getLength() > 0){

								for(int k = 0; k < rowNodeList.getLength() ; k++){

									Node row = rowNodeList.item(k);

									Element columnElement = (Element)row;

									column = columnElement.getNodeName();

									System.out.println(k + ": " + table + "." + column + " - " + parseValue(row));

								} // k

							} // rowNodeList

						} // j

					} // tableList

				} // for i

			} // got root

		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	* parseValue
	*<p>
	* @param	node	Node
	*<p>
	* @return String
	*<p>
	*/
	public static String parseValue(Node node) {

		StringBuffer text = new StringBuffer();

		NodeList nodeChildren = node.getChildNodes();

		for (int i = 0; i < nodeChildren.getLength(); i++) {

			Node tempNode = nodeChildren.item (i);

			String value = tempNode.getNodeValue();

			if (value != null) {
				text.append (value);
			}
		}

		return text.toString();
	}


	/**
	* writeFile
	*<p>
	* @param	fileName	String
	* @param	document	Document
	*<p>
	*/
	public void writeFile (String filename, Document document) {

		File myFile = new File (filename);

		TransformerFactory transformerFactory = TransformerFactory.newInstance();

		Transformer transformer = null;

		try {
			transformer = transformerFactory.newTransformer();
		}
		catch (TransformerConfigurationException ex) {
			System.out.println ("This went horribly wrong.");
		}

		DOMSource source = new DOMSource (document);

		StreamResult result = new StreamResult (myFile);

		try {
			transformer.transform (source, result);
		}
		catch (TransformerException ex) {
			System.out.println ("Flee! Flee! For surely a ““plague of locusts is about to descend!");
		}

	}

	/**
	* writeFile
	*<p>
	* @param	tag		String
	* @param	element	Element
	*<p>
	*/
	private static String getTagValue(String tag, Element element) {

		NodeList nlList = element.getElementsByTagName(tag).item(0).getChildNodes();

		Node nValue = (Node) nlList.item(0);

		return nValue.getNodeValue();

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
