<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.fop.*"%>
<%@ page import="org.w3c.tidy.Tidy"%>
<%@ page import="java.io.*"%>
<%@ page import="org.w3c.dom.Document"%>
<%@ page import="javax.xml.transform.stream.StreamResult"%>
<%@ page import="javax.xml.transform.dom.DOMSource"%>
<%@ page import="javax.xml.transform.TransformerFactory"%>
<%@ page import="javax.xml.transform.TransformerException"%>

<%@ page import="javax.xml.transform.stream.StreamSource"%>
<%@ page import="javax.xml.transform.Transformer"%>
<%@ page import="javax.xml.transform.Source"%>
<%@ page import="javax.xml.transform.Result"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.OutputStream"%>

<%@ page import="java.io.OutputStream"%>
<%@ page import="org.apache.fop.apps.FopFactory"%>
<%@ page import="java.net.URL"%>

<%@ page import="org.apache.fop.apps.FOUserAgent"%>
<%@ page import="org.apache.fop.apps.Fop"%>
<%@ page import="org.apache.fop.apps.FopFactory"%>
<%@ page import="org.apache.fop.apps.FOPException"%>
<%@ page import="org.apache.fop.apps.PageSequenceResults"%>
<%@ page import="org.apache.fop.apps.MimeConstants"%>
<%@ page import="org.apache.fop.apps.FormattingResults"%>

<%@ page import="javax.xml.transform.sax.SAXResult"%>

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

/*
// FOP
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.PageSequenceResults;
import org.apache.fop.apps.FormattingResults;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
*/

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

	String campus = "HIL";
	String user = "THANHG";

	out.println("Start<br/>");

	if (processPage){
		try{
			System.out.println("---------------------------- START");

			makePDF();

			System.out.println("---------------------------- END");
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"fop",user);
%>

</table>

<%!
	public void makePDF() throws IOException, TransformerException {

		try{
			System.out.println("---------------------------- START");

			try {
				String currentDrive = AseUtil.getCurrentDrive();

				String contextPath = currentDrive + ":\\tomcat\\webapps\\central\\fop\\";

				System.out.println(contextPath);

				File xmlfile = new File(contextPath + "xml\\xml\\outline.xml");
				File xsltfile = new File(contextPath + "xml\\xslt\\outline.xsl");
				File fofile = new File(contextPath + "out\\outline.fo");
				File pdffile = new File(contextPath + "out\\outline.pdf");

				convertXML2FO(xmlfile,xsltfile,fofile);
				System.out.println("XML 2 FO");

				convertFO2PDF(fofile, pdffile);
				System.out.println("FO 2 PDF");

			} catch (IOException e) {
				System.out.println(e.toString());
			}
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}

	}

	public void convertXML2FO(File xml, File xslt, File fo) throws IOException, TransformerException {

		//Setup output
		OutputStream out = new java.io.FileOutputStream(fo);
		System.out.println("OutputStream");

		try {
			//Setup XSLT
			TransformerFactory factory = TransformerFactory.newInstance();
			System.out.println("TransformerFactory");

			Transformer transformer = factory.newTransformer(new StreamSource(xslt));
			System.out.println("Transformer");

			//Setup input for XSLT transformation
			Source src = new StreamSource(xml);
			System.out.println("Source");

			//Resulting SAX events (the generated FO) must be piped through to FOP
			Result res = new StreamResult(out);
			System.out.println("Result");

			//Start XSLT transformation and FOP processing
			transformer.transform(src, res);
			System.out.println("transformed");


		} finally {
			out.close();
		}
	}

	/**
	* Converts an FO file to a PDF file using FOP
	* @param fo the FO file
	* @param pdf the target PDF file
	* @throws IOException In case of an I/O problem
	* @throws FOPException In case of a FOP problem
	*/
	public void convertFO2PDF(File fo, File pdf) throws IOException, FOPException {

		FopFactory fopFactory = FopFactory.newInstance();

		OutputStream out = null;

		try {
			FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

			// Setup output stream.  Note: Using BufferedOutputStream
			// for performance reasons (helpful with FileOutputStreams).
			out = new FileOutputStream(pdf);
			out = new BufferedOutputStream(out);

			// Construct fop with desired output format
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

			// Setup JAXP using identity transformer
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer(); // identity transformer

			// Setup input stream
			Source src = new StreamSource(fo);

			// Resulting SAX events (the generated FO) must be piped through to FOP
			Result res = new SAXResult(fop.getDefaultHandler());

			// Start XSLT transformation and FOP processing
			transformer.transform(src, res);

			// Result processing
			FormattingResults foResults = fop.getResults();

			java.util.List pageSequences = foResults.getPageSequences();

			for (java.util.Iterator it = pageSequences.iterator(); it.hasNext();) {
				PageSequenceResults pageSequenceResults = (PageSequenceResults)it.next();
				System.out.println("PageSequence "
				+ (String.valueOf(pageSequenceResults.getID()).length() > 0
				? pageSequenceResults.getID() : "<no id>")
				+ " generated " + pageSequenceResults.getPageCount() + " pages.");
			}
			System.out.println("Generated " + foResults.getPageCount() + " pages in total.");

		} catch (Exception e) {
			System.out.println(e.toString());
			//System.exit(-1);
		} finally {
			out.close();
		}
	}

	public void makePDF2() throws IOException, TransformerException {

		try{
			System.out.println("---------------------------- START");

			String htmFileName	= "http://localhost:8080/central/fop/xml/xml/a.html";

			String baseDir 		= "c:\\tomcat\\webapps\\centraldocs\\docs\\outlines\\KAP\\";

			String xmlFileName	= baseDir + "18b26f9189.xml";
			String xslFileName	= baseDir + "18b26f9189.xsl";
			String errFileName	= baseDir + "18b26f9189.txt";
			String pdfFileName	= baseDir + "18b26f9189.pdf";
			String foFileName		= baseDir + "18b26f9189.fo";

			URL 						fileHtml;
			BufferedInputStream 	fileIn;
			FileOutputStream 		fileOut;

			Tidy tidy = new Tidy();

			//Tell Tidy to convert HTML to XML
			tidy.setXmlOut(true);

			try {
				//Setup input and output files
				File xmlfile = new File(xmlFileName);
				File xsltfile = new File(xslFileName);
				File fofile = new File(foFileName);
				System.out.println("files set");

				convertXML2FO(xmlfile,xsltfile,fofile);
				System.out.println("XML 2 FO");

				File pdffile = new File(pdfFileName);

				convertFO2PDF(fofile, pdffile);
				System.out.println("FO 2 PDF");

			} catch (IOException e) {
				System.out.println(this.toString() + e.toString());
			}
		}
		catch(Exception ce){
			System.out.println(ce.toString());
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