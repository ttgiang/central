<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="java.io.ByteArrayOutputStream.*"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.*"%>

<%@
	page import="com.itextpdf.text.*,com.itextpdf.text.pdf.*,com.itextpdf.text.html.*,com.itextpdf.text.html.simpleparser.*"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<%@ include file="ase.jsp" %>
<title>untitled</title>
</meta>
</head>

<%
	try {
		runReport(request,response);
	}
	catch (Exception e) {
		System.out.println("error="+e.toString());
	} catch (Throwable t) {
		System.out.println("error="+t.toString());
	}

%>

<%!

    /**
     * Creates a PDF document.
     * @param filename the path to the new PDF document
     * @throws    DocumentException
     * @throws    IOException
     * @throws    SQLException
     */
	public static void runReport(HttpServletRequest request,HttpServletResponse response) throws IOException{

Logger logger = Logger.getLogger("test");

		AsePool connectionPool = null;
		Connection conn = null;
		String junk = "";
		String user = "";
		String alpha = "";
		String num = "";
		String campusName = "";
		String reportFileName = "";

		String[] info = null;
		String outlineCampus = "";
		String viewCampus = "";
		String report = "";
		String colum = "";
		String sql = "";
		String kix = "";
		String reportProps = "";
		String reportFolder = "";
		String outputFolder = "";
		String logoFile = "";
		String outline = "";

		int i = 0;

		boolean debug = false;

		PreparedStatement ps = null;
		ResultSet rs = null;

		PdfPCell cell = null;
		Phrase phrase = null;
		PdfPTable grid = null;

		float cursorPosition = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			viewCampus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			report = (String)session.getAttribute("rpt");
			kix = (String)session.getAttribute("kix");

			// step 0
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			// screen specifics
			info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			outlineCampus = info[Constant.KIX_CAMPUS];
			campusName = CampusDB.getCampusNameOkina(conn,outlineCampus);
			outline = CourseDB.getCourseDescription(conn,alpha,num,outlineCampus);

			reportProps = "report" + report;
			reportFolder = aseUtil.getReportFolder();
			outputFolder = aseUtil.getReportOutputFolder(viewCampus +"/");
			logoFile = aseUtil.getCampusLogo(outlineCampus);
			reportFileName = outputFolder + user + ".pdf";

			// step 1
			//Document document = new Document(PageSize.A4, l, r, t, b);	// 36 = =.5 inch
			Document document = new Document(PageSize.A4, 36, 36, 63, 36);

			// step 2
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(reportFileName));

			// step 3
			document.open();
			document.newPage();

			// step 4
			colum = "";
			sql = aseUtil.getPropertySQL(session,"");
			ps = conn.prepareStatement("SELECT seq+1 AS seq,field01,field02,colum,kix FROM tblPDF WHERE kix=? AND userid=? ORDER BY ID");
			ps.setString(1,"h53g29d10237");
			ps.setString(2,"THANHG");
			rs = ps.executeQuery();
			while (rs.next()) {
				++i;
				processElement(document,AseUtil.nullToBlank(rs.getString("field01")), i);
			}

			rs.close();
			ps.close();

			// step 5
			document.close();

			// open and launch document
			writePDF(request,response,reportFileName);

		} catch(IllegalArgumentException iae){
			System.out.println("ReportOutline - processRequest - iae: " + iae.toString());
		} catch(Exception ex){
			System.out.println("ReportOutline - processRequest ex: \n" + i + "\n" + junk + "\n" + ex.toString());
		} finally {
			connectionPool.freeConnection(conn,"ReportOutline",user);
		}
    }

	/*
	 * writeQuestion
	 * <p>
	 * @param	junk	String
	 *	<p>
	 */
	public static void writeQuestion(Document document,String junk,int i) {

Logger logger = Logger.getLogger("test");

		try{
			if (junk != null && junk.length() > 0){
				junk = "<font class=\"textblackth\"><br>" + "" + (i) + ". " + junk + "<br></font>";
				processElement(document,junk, i);
				document.add(new Phrase(""));
			}

		} catch(IllegalArgumentException iae){
			System.out.println("ReportOutline - writeQuestion - iae: " + iae.toString());
		} catch(Exception ex){
			System.out.println("ReportOutline - writeQuestion ex: \n" + ex.toString());
		}

	}

	/*
	 * processElement
	 * <p>
	 * @param	junk	String
	 *	<p>
	 */
	public static void processElement(Document document,String junk, int line) {

Logger logger = Logger.getLogger("test");

		StyleSheet styles = new StyleSheet();
		HashMap<String,Object> providers = null;

		styles.loadTagStyle("ul", "indent", "10");
		styles.loadTagStyle("li", "leading", "14");

		styles.loadStyle("li", "color", "#083772");
		styles.loadStyle("ul", "color", "#083772");

		styles.loadStyle("datacolumn", "color", "#083772");

		styles.loadStyle("textblackth", "color", "#525252");
		styles.loadStyle("textblackth", "style", "0");
		styles.loadStyle("textblackth", "size", "11pt");

		styles.loadStyle("font", "normal", "9pt");
		styles.loadStyle("body", "face", "Times-Roman");

		providers = new HashMap<String, Object>();
		providers.put("font_factory", new MyFontFactory());
		providers.put("img_provider", new MyImageFactory());

		try{
			if (junk != null && junk.length() > 0){
				junk = "<font class=\"textblackth\"><br><b>" + "" + (line) + ". " + junk + "</b><br></font>";
				ArrayList elementlist = HTMLWorker.parseToList(new StringReader(junk), styles, providers);
				for (int j = 0; j < elementlist.size(); j++) {
System.out.println(j);
					Element element = (Element)elementlist.get(j);
					document.add(element);
				}
			}
		} catch(DocumentException de){
			System.out.println("ReportOutline - processElements - de:\nLine: " + line + "\nJunk: " + junk + "\nError: " + de.toString());
		} catch(IllegalArgumentException iae){
			System.out.println("ReportOutline - processElements - iae:\nLine: " + line + "\nJunk: " + junk + "\nError: " + iae.toString());
		} catch(RuntimeException re){
			System.out.println("ReportOutline - processElements - re:\nLine: " + line + "\nJunk: " + junk + "\nError: " + re.toString());
		} catch(Exception ex){
			System.out.println("ReportOutline - processElements - ex:\nLine: " + line + "\nJunk: " + junk + "\nError: " + ex.toString());
		}

		return;
	}

	/**
	**	writePDF
	**/
	public static void writePDF(HttpServletRequest request,
										HttpServletResponse response,
										String reportFileName) {

Logger logger = Logger.getLogger("test");

		try {
			response.setHeader("Expires", "0");
			response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");
			response.setContentType("application/pdf");

			BufferedInputStream  bis = null;
			BufferedOutputStream bos = null;
			try {
				bis = new BufferedInputStream(new FileInputStream(reportFileName));
				bos = new BufferedOutputStream(response.getOutputStream ());
				byte[] buff = new byte[2048];
				int bytesRead;
				while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
			} catch(final IOException e) {
				System.out.println("ReportTemplate - writePDF: " + e.toString());
			} finally {
				if (bis != null)
					bis.close();

				if (bos != null)
					bos.close();
			}

			HttpSession session = request.getSession(true);
			session.removeAttribute("myPdf");

		} catch (IOException e) {
			System.out.println("ReportTemplate - writePDF: " + e.toString());
		}
	}

    /**
     * Inner class implementing the ImageProvider class.
     * This is needed if you want to resolve the paths to images.
     */
    public static class MyImageFactory implements ImageProvider {
        @SuppressWarnings("unchecked")
        public Image getImage(String src, HashMap h, ChainedProperties cprops, DocListener doc) {
            try {
                return Image.getInstance(
                    String.format(AseUtil.getCurrentDrive()
                    + ":/tomcat/webapps/central/images/add.gif",src.substring(src.lastIndexOf("/") + 1)));
            } catch (DocumentException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
    }


	/**
	* Inner class implementing the FontProvider class.
	* This is needed if you want to select the correct fonts.
	*/
	public static class MyFontFactory implements FontProvider {

		public Font getFont(String fontname,
									String encoding,
									boolean embedded,
									float size,
									int style,
									BaseColor color) {

			if (style==0)
				style = Font.NORMAL;
			else if (style==1)
				style = Font.BOLD;
			else if (style==2)
				style = Font.ITALIC;
			else if (style==4)
				style = Font.UNDERLINE;
			else if (style==8)
				style = Font.STRIKETHRU;

			return new Font(Font.TIMES_ROMAN, size, style, color);
		}

		public Font getFont(ChainedProperties props) {

			FontProvider fontImp = FontFactory.getFontImp();

			String face = props.getProperty(ElementTags.FACE);
			if (face != null) {
				StringTokenizer tok = new StringTokenizer(face, ",");
				while (tok.hasMoreTokens()) {
					face = tok.nextToken().trim();
					if (face.startsWith("\""))
						face = face.substring(1);
					if (face.endsWith("\""))
						face = face.substring(0, face.length() - 1);
					if (fontImp.isRegistered(face))
						break;
				}
			}
			int style = 0;

			if (props.hasProperty(HtmlTags.I))
				style |= Font.ITALIC;

			if (props.hasProperty(HtmlTags.B))
				style |= Font.BOLD;

			if (props.hasProperty(HtmlTags.U))
				style |= Font.UNDERLINE;

			if (props.hasProperty(HtmlTags.S))
				style |= Font.STRIKETHRU;

			String value = props.getProperty(ElementTags.SIZE);

			float size = 12;
			if (value != null)
				size = Float.parseFloat(value);

			BaseColor color = Markup.decodeColor(props.getProperty("color"));

			String encoding = props.getProperty("encoding");

			if (encoding == null)
				encoding = BaseFont.WINANSI;

			return fontImp.getFont(face, encoding, true, size, style, color);
		}

		public static Font getHeaderFont() {
			return new Font(Font.TIMES_ROMAN, 9, Font.BOLD, new BaseColor(82,82,82));
		}

		public static Font getDataFont() {
			return new Font(Font.TIMES_ROMAN, 9, Font.NORMAL, new BaseColor(8,55,114));
		}

		public static Font getBlackFont() {
			return new Font(Font.TIMES_ROMAN, 9, Font.NORMAL, BaseColor.BLACK);
		}

		public boolean isRegistered(String fontname) {
			return false;
		}

	}


%>

</html>
