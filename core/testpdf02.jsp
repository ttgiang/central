<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.fop.*"%>
<%@ page import="org.w3c.tidy.Tidy"%>
<%@ page import="java.io.*"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.FileOutputStream"%>

<%@ page import="java.net.URL"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%@ page import="com.itextpdf.text.Document"%>
<%@ page import="com.itextpdf.text.DocumentException"%>
<%@ page import="com.itextpdf.text.PageSize"%>
<%@ page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@ page import="com.itextpdf.tool.xml.XMLWorkerHelper"%>
<%@ page import="com.itextpdf.text.pdf.fonts.otf.TableHeader"%>
<%@ page import="com.itextpdf.text.pdf.PdfPageEventHelper"%>
<%@ page import="com.itextpdf.text.pdf.PdfTemplate"%>
<%@ page import="com.itextpdf.text.Rectangle"%>
<%@ page import="com.itextpdf.text.pdf.BaseFont"%>

<%@ page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@ page import="com.itextpdf.text.Phrase"%>
<%@ page import="com.itextpdf.text.Element"%>
<%@ page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@ page import="com.itextpdf.text.pdf.PdfContentByte"%>
<%@ page import="com.itextpdf.text.FontProvider"%>
<%@ page import="com.itextpdf.text.Font"%>
<%@ page import="com.itextpdf.text.BaseColor"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext"%>
<%@ page import="com.itextpdf.tool.xml.html.Tags"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.html.LinkProvider"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.css.CSSResolver"%>
<%@ page import="com.itextpdf.tool.xml.css.StyleAttrCSSResolver"%>
<%@ page import="com.itextpdf.tool.xml.css.CssFile"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.css.CSSResolver"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.html.HtmlPipeline"%>
<%@ page import="com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext"%>
<%@ page import="com.itextpdf.tool.xml.Pipeline"%>
<%@ page import="com.itextpdf.tool.xml.XMLWorker"%>
<%@ page import="com.itextpdf.tool.xml.parser.XMLParser"%>

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

	String campus = "HIL";
	String user = "THANHG";

	out.println("Start<br/>");

	if (processPage){
		try{
			if (!campus.equals(Constant.BLANK)){
				String kix = "h35c20b11194";
				campus = "KAP";
				out.println("outline(s) written: " + createOutlineComments(conn,campus,kix));
			}
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

	public static int createOutlineComments(Connection conn,String campus,String kix) throws Exception {

		Logger logger = Logger.getLogger("test");

		int outlinesWritten = 0;
		boolean methodCreatedConnection = false;
		String outputFolder = "ttg";

		String sql = "";

		try{
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			if (conn != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				String server = SysDB.getSys(conn,"server");
				com.ase.aseutil.pdf.Pdf58 makePdf = new com.ase.aseutil.pdf.Pdf58();

				try {

					AseUtil aseUtil = new AseUtil();

					String campusName = CampusDB.getCampusName(conn,campus);

					String currentDrive = AseUtil.getCurrentDrive();
					String documents = SysDB.getSys(conn,"documents");
					String fileName = currentDrive
												+ ":"
												+ documents
												+ "outlines\\"
												+ outputFolder
												+ "\\";

					sql = "select coursealpha,coursenum,historyid,coursetitle,coursedate  from tblcourse where campus=? and coursetype='CUR' and not coursedate is null  ";
					if(!kix.equals("")){
						sql += " and historyid='"+kix+"'";
					}
					sql += " order by coursealpha,coursenum";

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						kix = AseUtil.nullToBlank(rs.getString("historyid"));
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));

						String filecode = campus + "_" + alpha + "_" + num;
						String htmlfile = fileName + filecode + ".html";

						try{
							createPDF(filecode);
						}
						catch(Exception e){
							System.out.println("failed to create outline: " + e.toString());
						}
						finally{
						}

						++outlinesWritten;

					} // while
					rs.close();
					ps.close();

					makePdf = null;
				}
				catch(Exception e){
					System.out.println("fail to process data");
				}

				// release connection
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					logger.fatal("createOutlineComments: " + e.toString());
				}

			} // conm

			// only if the connection was created here
			if (methodCreatedConnection){
				try{
					conn.close();
					conn = null;
				}
				catch(Exception e){
					logger.fatal("createOutlineComments: " + e.toString());
				}

			} // methodCreatedConnection

		}
		catch(Exception e){
			logger.fatal("createOutlineComments: " + e.toString());
		}

		return outlinesWritten;

	}

	public static int createPDF(String filecode) throws Exception {

		Logger logger = Logger.getLogger("test");

		int pdfCreated = 0;

		try{

			String XML = "C:/tomcat/webapps/centraldocs/docs/outlines/ttg/xml/"+filecode+".xml";
			String PDF = "C:/tomcat/webapps/centraldocs/docs/outlines/ttg/pdf/"+filecode+".pdf";
			String CSS = "C:/tomcat/webapps/central/inc/style.css";

			File file = new File(XML);
			if(file.exists()){
				// step 1
				Document document = new Document();
				// step 2
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(PDF));
				writer.setInitialLeading(12.5f);

				// step 3
				document.open();

				// CSS
				CSSResolver cssResolver = new StyleAttrCSSResolver();
				CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(CSS));
				cssResolver.addCss(cssFile);

				HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
				htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

				// Pipelines
				PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
				HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
				CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

				// XML Worker
				XMLWorker worker = new XMLWorker(css, true);
				XMLParser p = new XMLParser(worker);
				p.parse(new FileInputStream(XML));

				// step 5
				document.close();

				writer.close();

				try{
					file.delete();
				}
				catch(Exception e){
					logger.fatal("Unable to delete " + XML + "\n" + e.toString());
				}

				pdfCreated = 1;
			}

		}
		catch(Exception e){
			System.out.println("failed to create outline: " + e.toString());
		}
		finally{
		}

		return pdfCreated;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>