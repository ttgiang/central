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
			System.out.println("---------------------------- START");

String title = "Senior";
String campusName = "Thanh T. Giang";
String aseShowAuditStampInFooter = "OFF";
String outlineLastDate = "12/22/1966";
final String imageFolder = "http://localhost:8080/central/images/";
final String appFolder = "http://localhost:8080/central/";
String css = "c:\\tomcat\\webapps\\central\\inc\\style.css";

			String HTML = "C:/tomcat/webapps/centraldocs/docs/outlines/ttg/xml/LEE_ESL_9B.xml";
			String DEST = "C:/tomcat/webapps/centraldocs/docs/outlines/ttg/pdf/LEE_ESL_9B.pdf";

			// step 1
			Document document = new Document();
			document.setMargins(36, 72, 70, 70);
			document.setMarginMirroringTopBottom(false);

			// step 2
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(DEST));
			writer.setInitialLeading(12.5f);

			TableHeader event = new TableHeader();
			event.setHeader(title,campusName,user,aseShowAuditStampInFooter,outlineLastDate);
			writer.setPageEvent(event);

			// step 3
			document.open();

			HtmlPipelineContext htmlPipelineContext = new HtmlPipelineContext(null);
			htmlPipelineContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

			//
			// image folder
			//
			htmlPipelineContext.setImageProvider(new AbstractImageProvider() {
				public String getImageRootPath() {
					return imageFolder;
				}
			}).setTagFactory(Tags.getHtmlTagProcessorFactory());

			htmlPipelineContext.setLinkProvider(new LinkProvider() {
				public String getLinkRoot() {
					return appFolder;
				}
			}).setTagFactory(Tags.getHtmlTagProcessorFactory());


			XMLWorkerHelper hlpr = XMLWorkerHelper.getInstance();

			CSSResolver cssResolver = new StyleAttrCSSResolver();

			CssFile cssFile = hlpr.getCSS(new FileInputStream(css));

			cssResolver.addCss(cssFile);

			Pipeline<?> pipeline = new CssResolverPipeline(cssResolver,
											new HtmlPipeline(htmlPipelineContext,
												new PdfWriterPipeline(document, writer)));

			// step 4
			XMLWorkerHelper.getInstance().parseXHtml(writer, document,new FileInputStream(HTML));
			// step 5
			document.close();

			writer.close();

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

	/**
	* Inner class to add a table as header.
	*/
	static class TableHeader extends PdfPageEventHelper {

		String header;
		String campusName;
		String userName;

BaseFont pdfFont = null;
MyFontFactory myFont = null;
int dataFontSize 							= 10;
int titleFontSize							= 11;
int headerFontSize						= 10;
int footerFontSize						= 10;


		//
		// added for use of printing status line
		//
		String aseShowAuditStampInFooter = Constant.OFF;
		String outlineLastDate = "";

		/** The template with the total number of pages. */
		PdfTemplate total;

		/**
		* Allows us to change the content of the header.
		* @param header The new header String
		*/
		public void setHeader(String header) {
			this.header = header;
		}

		/**
		* Allows us to change the content of the header.
		* @param header The new header String
		*/
		public void setHeader(String header,String campusName,String userName) {
			this.header = header;
			this.campusName = campusName;
			this.userName = userName;
		}

		/**
		* Allows us to change the content of the header.
		* @param header The new header String
		*/
		public void setHeader(String header,String campusName,String userName,String aseShowAuditStampInFooter,String outlineLastDate) {
			this.header = header;
			this.campusName = campusName;
			this.userName = userName;
			this.aseShowAuditStampInFooter = aseShowAuditStampInFooter;
			this.outlineLastDate = outlineLastDate;
		}

		/**
		* Creates the PdfTemplate that will hold the total number of pages.
		* @see com.itextpdf.text.pdf.PdfPageEventHelper#onOpenDocument(
		*      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
		*/
		public void onOpenDocument(PdfWriter writer, Document document) {
			total = writer.getDirectContent().createTemplate(100, 100);
			total.setBoundingBox(new Rectangle(-20, -20, 100, 100));

			try {
				pdfFont = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
			} catch (Exception e) {
				//throw new IOException (e);
			}

		}

		/**
		* Adds a header to every page
		* @see com.itextpdf.text.pdf.PdfPageEventHelper#onEndPage(
		*      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
		*/
		public void onEndPage(PdfWriter writer, Document document) {

			boolean debug = false;

			float[] colsWidth = {25f,50f, 25f};
			PdfPTable table = new PdfPTable(colsWidth);
			try {
				// header
				table.setWidthPercentage(100);
				table.setTotalWidth(527);
				table.setLockedWidth(false);
				table.getDefaultCell().setFixedHeight(20);

				table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
				Phrase phrase = new Phrase();

				table.getDefaultCell().setBorder(Rectangle.BOTTOM);
				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());
				phrase.add(userName);
				table.addCell(phrase);

				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());
				phrase.add(header);
				table.addCell(phrase);

				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());
				phrase.add(outlineLastDate);
				table.addCell(phrase);

				table.writeSelectedRows(0, -1, 34, 803, writer.getDirectContent());

				// footer
				PdfPTable footer = new PdfPTable(colsWidth);
				footer.setTotalWidth(document.right()-document.left());
				footer.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

				if(debug) System.out.println("1 - endpage: " + campusName);

				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());
				phrase.add(campusName);
				footer.addCell(phrase);

				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());
				phrase.add("Curriculum Central (CC)");
				PdfPCell cell = new PdfPCell(phrase);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setBorder(PdfPCell.NO_BORDER);
				footer.addCell(cell);

				if(debug) System.out.println("2 - endpage");

				phrase = new Phrase();
				//phrase.setFont(myFont.getFooterFont());

				if(debug) System.out.println("3 - endpage: " + outlineLastDate);

				if(aseShowAuditStampInFooter==null){
					aseShowAuditStampInFooter = Constant.OFF;
				}

				if(debug) System.out.println("4 - endpage: " + aseShowAuditStampInFooter);

				if(aseShowAuditStampInFooter.equals(Constant.OFF)){
					phrase.add("Page " + writer.getPageNumber());
				}
				else{
					phrase.add(outlineLastDate);
				}

				if(debug) System.out.println("5 - endpage");

				cell = new PdfPCell(phrase);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setBorder(PdfPCell.NO_BORDER);
				footer.addCell(cell);

				PdfContentByte cb = writer.getDirectContent();
				footer.writeSelectedRows(0, -1, document.left(), document.bottom() - 10, cb);

			}
			catch(Exception ex) {
				//logger.fatal("PdfReportTemplate: onEndPage - " + ex.toString());
			}
		}

		/**
		* Fills out the total number of pages before the document is closed.
		* @see com.itextpdf.text.pdf.PdfPageEventHelper#onCloseDocument(
		*      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
		*/
		public void onCloseDocument(PdfWriter writer, Document document) {
			total.beginText();
			total.setFontAndSize(pdfFont, dataFontSize);
			total.setTextMatrix(0, 0);
			total.showText(String.valueOf(writer.getPageNumber() - 1));
			total.endText();
		}

	}

	/**
	* Inner class implementing the FontProvider class.
	* This is needed if you want to select the correct fonts.
	*/
	public static class MyFontFactory implements FontProvider {

static int dataFontSize 							= 10;
static int titleFontSize							= 11;
static int headerFontSize						= 10;
static int footerFontSize						= 10;

static BaseColor ASE_HEADERCOLOR 			= new BaseColor(82,82,82);
static BaseColor ASE_DATACOLOR				= new BaseColor(8,55,114);

		public Font getFont(String fontname,String encoding,boolean embedded,float size,int style,BaseColor color) {

			BaseFont bf;

			try {
				bf = BaseFont.createFont("c:/windows/fonts/arialuni.ttf","Identity-H", BaseFont.EMBEDDED);
			} catch (DocumentException e) {
				//logger.fatal(e.toString());
				return new Font();
			} catch (IOException e) {
				//logger.fatal(e.toString());
				return new Font();
			}

			return new Font(bf, size);

		}

		public static Font getHeaderFont() {
			return new Font(Font.FontFamily.TIMES_ROMAN, titleFontSize, Font.BOLD, ASE_HEADERCOLOR);
		}

		public static Font getDataFont() {
			return new Font(Font.FontFamily.TIMES_ROMAN, dataFontSize, Font.NORMAL, ASE_DATACOLOR);
		}

		public static Font getBlackFont() {
			return new Font(Font.FontFamily.TIMES_ROMAN, dataFontSize, Font.NORMAL, BaseColor.BLACK);
		}

		public static Font getFooterFont() {
			return new Font(Font.FontFamily.TIMES_ROMAN, footerFontSize, Font.NORMAL, BaseColor.LIGHT_GRAY);
		}

		public boolean isRegistered(String fontname) {
			return false;
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