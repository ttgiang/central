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
<%@ page import="javax.xml.transform.dom.DOMSource"%>
<%@ page import="javax.xml.transform.stream.StreamResult"%>
<%@ page import="javax.xml.parsers.ParserConfigurationException"%>

<%@ page import="org.w3c.dom.Document"%>
<%@ page import="org.w3c.dom.Element"%>
<%@ page import="org.w3c.dom.Attr"%>

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

	String campus = "KAU";
	String alpha = "GEOL";
	String num = "150";
	String type = "PRE";
	String user = "KOMENAKA";
	String task = "Modify_outline";
	String kix = "p41a26e12188";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		com.ase.aseutil.export.ExportXML.process(conn,campus,kix);
		//run(conn,campus,kix,out);
		//run2(conn,campus,"tblcoursecomp",kix,out);
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static void run(Connection conn,String campus,String kix,JspWriter out) {

		try{

			// run through all tables and process only ones with historyid as a column

			String sql = "SELECT distinct so.name AS tbl "
				+ "FROM syscolumns sc, sysobjects so "
				+ "WHERE so.id = sc.id "
				+ "AND so.name LIKE 'tbl%' "
				+ "AND so.name NOT LIKE 'tblTemp%' "
				+ "AND sc.name='historyid' "
				+ "ORDER BY so.name ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String table = rs.getString("tbl");
				run2(conn,campus,table,kix,out);
			} // while
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			System.out.println(e.toString());
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

	}

	public static void run2(Connection conn,String campus,String table,String kix,JspWriter out) {

		try{
			// build document
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			// root elements
			Document doc = docBuilder.newDocument();
			Element rootElement = doc.createElement(table.toLowerCase().replace("tbl",""));
			doc.appendChild(rootElement);

			String sql = "SELECT * FROM " + table + " WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				try{

					// historyid
					String columnName = "historyID";

					Element courseElement = doc.createElement(columnName);
					rootElement.appendChild(courseElement);

					// set attribute to staff element
					Attr attr = doc.createAttribute("id");

					// shorten way
					courseElement.setAttribute("id", kix);

					ResultSetMetaData rsmd = rs.getMetaData();

					int colCount = rsmd.getColumnCount();

					for (int i = 1; i <= colCount; i++) {

						// the element's name
						columnName = rsmd.getColumnName(i);

						String data = AseUtil.nullToBlank(rs.getString(columnName));

						Element columns = doc.createElement(columnName);
						columns.appendChild(doc.createTextNode(data));
						courseElement.appendChild(columns);

						System.out.println(data);

					} // for
				}
				catch (Exception e) {
					e.printStackTrace();
				}

			} // rs2
			rs.close();
			ps.close();

			try{
				// write the content into xml file
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(doc);

				StreamResult result = null;

				boolean debug = true;

				if (debug){
					result = new StreamResult(out); // or System.out
				}
				else{
					result = new StreamResult(new File("c:\\tomcat\\webapps\\central\\file.xml"));
				}

				transformer.transform(source, result);
			}
			catch (TransformerException e) {
				e.printStackTrace();
			}

		}
		catch(SQLException e){
			System.out.println(e.toString());
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
