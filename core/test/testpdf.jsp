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

		String reportUser = null;

		String sql = null;

		boolean debug = false;

		AseUtil aseUtil = null;

		WebSite website = null;

		HashMap<String,Object> campusColorMap 	= null;

		try{
			aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			reportUser = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			int i = 0;
			int j = 0;

			String junk = "";

			// step 0
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			website = new WebSite();
			String campus = website.getRequestParameter(request,"c","");		// parm1
			String alpha = website.getRequestParameter(request,"a","");			// parm2
			String num = website.getRequestParameter(request,"n","");			// parm3
			String type = website.getRequestParameter(request,"t","");			// parm4
			String user = website.getRequestParameter(request,"u","");			// parm5
			String historyid = website.getRequestParameter(request,"h","");	// parm6
			int route = website.getRequestParameter(request,"r",0);				// parm7
			String p8 = website.getRequestParameter(request,"p8","");			// any value
			String p9 = website.getRequestParameter(request,"p9","");			// any value

			if (campus == null || campus.length() == 0)
				campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

			if (user == null || user.length() == 0)
				user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String campusName = CampusDB.getCampusNameOkina(conn,campus);

			String reportFolder = aseUtil.getReportFolder();
			String outputFolder = aseUtil.getReportOutputFolder(campus +"/");

			String logoFile = aseUtil.getCampusLogo(campus);
			String reportFileName = outputFolder + user + ".pdf";

			String reportType = "generic";
			String reportTitle = "";
			String colsWidth = "";
			String headerColumns = "";
			String dataColumns = "";

			String where = "";
			String order = "";
			String grouping = null;
			String savedGrouping = null;
			String groupedValue = null;
			String footer = null;
			String reportSubTitle = null;

			String sWhere = "";

			String parm1 = "";		// campus or FORUM src
			String parm2 = "";		// alpha or FORUM status
			String parm3 = "";		// num
			String parm4 = "";		// type
			String parm5 = "";		// user
			String parm6 = "";		//	historyid
			String parm7 = "";		//	route
			String parm8 = "";		//
			String parm9 = "";		//

			int psIndex = 0;

			String aseReport = (String)session.getAttribute("aseReport");

			if (aseReport != null && aseReport.length() > 0){

				ResourceBundle reportBundle = ResourceBundle.getBundle("ase.central.reports." + aseReport);
				if (reportBundle != null){

					com.ase.aseutil.bundle.BundleDB bundle = new com.ase.aseutil.bundle.BundleDB();

					reportType = bundle.getBundle(reportBundle,"reportType","");
					reportTitle = bundle.getBundle(reportBundle,"reportTitle","");
					colsWidth = bundle.getBundle(reportBundle,"colsWidth","");
					headerColumns = bundle.getBundle(reportBundle,"headerColumns","");
					dataColumns = bundle.getBundle(reportBundle,"dataColumns","");
					sql = bundle.getBundle(reportBundle,"sql","");
					grouping = bundle.getBundle(reportBundle,"grouping","");
					footer = bundle.getBundle(reportBundle,"footer","");
					reportSubTitle = bundle.getBundle(reportBundle,"reportSubTitle","");

					where = bundle.getBundle(reportBundle,"where","");
					if (where != null && where.length() > 0)
						where = where.replace("_EQUALS_","=");

					order = bundle.getBundle(reportBundle,"order","");
					parm1 = bundle.getBundle(reportBundle,"parm1","");	// campus, src
					parm2 = bundle.getBundle(reportBundle,"parm2","");	// alpha
					parm3 = bundle.getBundle(reportBundle,"parm3","");	// num
					parm4 = bundle.getBundle(reportBundle,"parm4","");	// type
					parm5 = bundle.getBundle(reportBundle,"parm5","");	// userid
					parm6 = bundle.getBundle(reportBundle,"parm6","");	// history
					parm7 = bundle.getBundle(reportBundle,"parm7","");	// route
					parm8 = bundle.getBundle(reportBundle,"parm8","");
					parm9 = bundle.getBundle(reportBundle,"parm9",""); // any single value

					bundle = null;

				} // reportBundle

				if (reportTitle != null && colsWidth != null && headerColumns != null && dataColumns != null && sql != null){
					PdfPTable table = null;
					Phrase phrase = null;
					PdfPCell cell = null;

					BaseColor campusColor = null;

					String[] aColsWidth = colsWidth.split(",");
					String[] aDataColumns = dataColumns.split(",");

					// define colum width
					int columns = aDataColumns.length;

					float[] fColsWidth = new float[aDataColumns.length];

					for(i=0; i<columns; i++){
						fColsWidth[i] = Float.valueOf(aColsWidth[i]).floatValue();
					}

					//---------------------------------------------------
					// define campus color; for grouping, use a different color
					//---------------------------------------------------
					if (reportType.equals(Constant.FORUM)){
						campusColor = (BaseColor)campusColorMap.get(Constant.CAMPUS_TTG);
					}
					else if (reportType.equals("ApprovalRouting")){
						campusColor = (BaseColor)campusColorMap.get(Constant.CAMPUS_TTG);
					}
					else{
						if (campus != null && campus.length() > 0 && campusColorMap.containsKey(campus))
							campusColor = (BaseColor)campusColorMap.get(campus);
					}

					if (campusColor == null)
						campusColor = BaseColor.LIGHT_GRAY;

					// step 1 of 5
					Document document = new Document(PageSize.LETTER.rotate());

					// step 2 of 5
					PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(reportFileName));
//TableHeader event = new TableHeader();
//writer.setPageEvent(event);
//					writer.setPageEvent(new Watermark("Curriculum Central"));

					// step 3 of 5
					document.open();
					document.newPage();

					// create table with user column count
					table = new PdfPTable(fColsWidth);
					table.setWidthPercentage(100f);
					table.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
					table.getDefaultCell().setUseAscender(true);
					table.getDefaultCell().setUseDescender(true);

					//---------------------------------------------------
					//formulate sql statement
					//---------------------------------------------------
					if (reportType.equals(Constant.FORUM)){
						parm1 = website.getRequestParameter(request,"src","");
						if (parm1 != null && parm1.length() > 0){
							sWhere = " src=? ";
						}

						parm2 = website.getRequestParameter(request,"status","");
						if (parm2 != null && parm2.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " status=? ";
						}
					}
					else if (reportType.equals("ApprovalRouting")){
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " c.campus=? ";
						}

						if (parm7 != null && parm7.length() > 0 && (route > 0 || route == -999)){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							if (route == -999)
								sWhere += " c.route>? ";
							else
								sWhere += " c.route=? ";
						}
					}
					else if (reportType.equals("SystemSettings")){
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " campus=? ";
						}

						if (parm9 != null && parm9.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " " + parm9 + "=? ";
						}
					}
					else{
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0){
							sWhere = " campus=? ";
						}

						if (parm2 != null && parm2.length() > 0 && alpha != null && alpha.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " alpha=? ";
						}

						if (parm3 != null && parm3.length() > 0 && num != null && num.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " num=? ";
						}

						if (parm4 != null && parm4.length() > 0 && type != null && type.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " type=? ";
						}

						if (parm5 != null && parm5.length() > 0 && user != null && user.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " userid=? ";
						}

						if (parm6 != null && parm6.length() > 0 && historyid != null && historyid.length() > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " historyid=? ";
						}

						if (parm7 != null && parm7.length() > 0 && route > 0){
							if (sWhere.length() > 0)
								sWhere += " AND ";

							sWhere += " route=? ";
						}

					} // reportType

					//---------------------------------------------------
					// final formulation of SQL
					//---------------------------------------------------
					if (where.length()==0 && sWhere.length()>0)
						where = " WHERE " + sWhere;
					else{
						where = " WHERE " + where;

						if (sWhere.length()>0)
							where += " AND " + sWhere;
					}

					// prevent empty where
					if (where.trim().toUpperCase().equals("WHERE"))
						where = "";

					if (order.length() > 0)
						order = " ORDER BY " + order;

					// prevent empty order
					if (order.trim().toUpperCase().equals("ORDER BY"))
						order = "";

					sql = sql + where + order;

					//---------------------------------------------------
					// Add the first header row (step 4 of 5)
					//---------------------------------------------------
					Font f = new Font();

					drawTitleRow(table,reportTitle,campusColor,f,BaseColor.WHITE,columns,Element.ALIGN_CENTER);

					//---------------------------------------------------
					// customized subtitles
					//---------------------------------------------------
					if (reportType.equals(Constant.FORUM)){
						reportSubTitle = parm1 + " Report";
					}
					else if (reportType.equals("ApprovalRouting")){
						if (route == -999)
							reportSubTitle = "Approval Routing";
						else
							reportSubTitle = "Approval Routing - " + ApproverDB.getRoutingFullNameByID(conn,campus,route);
					}
					else if (reportType.equals("SystemSettings")){
						reportSubTitle = "System Settings - " + p9;
					}

					if (reportSubTitle != null && reportSubTitle.length() > 0){
						drawTitleRow(table,reportSubTitle,campusColor,f,BaseColor.WHITE,columns,Element.ALIGN_CENTER);
					}

					//---------------------------------------------------
					// table header
					//---------------------------------------------------
					drawHeaderRow(table,campusColor,columns,headerColumns,f);

					table.getDefaultCell().setBackgroundColor(null);

					table.setHeaderRows(2);

					//---------------------------------------------------
					// get the data
					//---------------------------------------------------
					PreparedStatement ps = conn.prepareStatement(sql);

					if (reportType.equals(Constant.FORUM)){
						if (parm1 != null && parm1.length() > 0)
							ps.setString(1,parm1);

						if (parm2 != null && parm2.length() > 0)
							ps.setString(2,parm2);
					}
					else if (reportType.equals("ApprovalRouting")){
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0)
							ps.setString(++psIndex,campus);

						if (parm7 != null && parm7.length() > 0 && (route > 0 || route == -999)){
							if (route == -999)
								ps.setInt(++psIndex,0);
							else
								ps.setInt(++psIndex,route);
						}
					}
					else if (reportType.equals("SystemSettings")){
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0)
							ps.setString(++psIndex,campus);

						if (p9 != null && p9.length() > 0)
							ps.setString(++psIndex,p9);
					}
					else{
						if (parm1 != null && parm1.length() > 0 && campus != null && campus.length() > 0)
							ps.setString(++psIndex,campus);

						if (parm2 != null && parm2.length() > 0 && alpha != null && alpha.length() > 0)
							ps.setString(++psIndex,alpha);

						if (parm3 != null && parm3.length() > 0 && num != null && num.length() > 0)
							ps.setString(++psIndex,num);

						if (parm4 != null && parm4.length() > 0 && type != null && type.length() > 0)
							ps.setString(++psIndex,type);

						if (parm5 != null && parm5.length() > 0 && user != null && user.length() > 0)
							ps.setString(++psIndex,user);

						if (parm6 != null && parm6.length() > 0 && historyid != null && historyid.length() > 0)
							ps.setString(++psIndex,historyid);

						if (parm7 != null && parm7.length() > 0 && route > 0)
							ps.setInt(++psIndex,route);

					} // reportType

					ResultSet rs = ps.executeQuery();
					while(rs.next()){

//event.setHeader(reportTitle,campusName,user);

						if (grouping != null && grouping.length() > 0){
							groupedValue = AseUtil.nullToBlank(rs.getString(grouping));
							if (savedGrouping == null || !savedGrouping.equals(groupedValue)){
								savedGrouping = groupedValue;
								drawTitleRow(table,
												savedGrouping.toUpperCase(),
												campusColor,
												f,
												BaseColor.BLACK,
												columns,
												Element.ALIGN_LEFT);
							}
						} // grouping


System.out.println("----------------------------");
System.out.println("j: " + j);

						//if (j % 2 == 0)
//							table.getDefaultCell().setBackgroundColor(ASE_ODD_ROW_COLOR);
//						else
//							table.getDefaultCell().setBackgroundColor(ASE_EVEN_ROW_COLOR);

						for (i=0;i<columns;i++){

							if (!aDataColumns[i].equals("")){
								if (aDataColumns[i].indexOf("date") > -1){
									junk = aseUtil.ASE_FormatDateTime(rs.getString(aDataColumns[i]),Constant.DATE_DATE_MDY);
								}
								else{
									junk = aseUtil.nullToBlank(rs.getString(aDataColumns[i]));
								}
							}
							else{
								junk = "";
							}

							junk = junk.replace("<p>","");
							junk = junk.replace("</p>","\n");

System.out.println("*****************");
System.out.println(junk);
System.out.println("*****************");

							try{
								phrase = new Phrase();
								//phrase.add(createPhrase(junk,false));
								//cell = new PdfPCell(phrase);
								cell = new PdfPCell(processElement(junk, DATACOLOR, Font.NORMAL));
								cell.setFixedHeight(20);
								cell.setPaddingRight(10);
								table.addCell(cell);
							} catch(IllegalArgumentException e){
								logger.fatal("ReportGeneric - runReport 1: " + e.toString());
							} catch(Exception e){
								logger.fatal("ReportGeneric - runReport 2: " + e.toString());
							}
						}

						++j;
					} // while

System.out.println("while is done1");

					if (j==0){
						try{
							phrase = new Phrase();
							phrase.add(createPhrase("no date found for requested report",false));
							cell = new PdfPCell(phrase);
							cell.setFixedHeight(20);
							cell.setPaddingRight(10);
							cell.setColspan(columns);
							table.addCell(cell);
						} catch(IllegalArgumentException e){
							logger.fatal("ReportGeneric - runReport 1: " + e.toString());
						} catch(Exception e){
							logger.fatal("ReportGeneric - runReport 2: " + e.toString());
						}
					}

					document.add(table);

System.out.println("while is done2");

					// footer
					if (reportType.equals(Constant.FORUM)){

System.out.println("while is done3");

						footer = "<ul>"
							+ "<li class=\"datacolumn\">CLOSED - tickets combined with another item because of similarity in the work that is needed, or the work that is no longer necessary.</li>"
							+ "<li class=\"datacolumn\">COMPLETED - this status is set after development has been completed, and user confirms that CC is working as expected.</li>"
							+ "<li class=\"datacolumn\">MONITORING - either a problem cannot be recreated or a fix was implemented without a way to recreate the problem</li>"
							+ "<li class=\"datacolumn\">REQUIREMENTS - an enhancement or bug fix requiring additional specification prior to development.</li>"
							+ "<li class=\"datacolumn\">RESEARCH - the development team is unclear of the reported ticket or requset and requires time to better understand what has taken place and possible recommendation for the user.</li>"
							+ "<li class=\"datacolumn\">REVIEW - items the development team required additional time to understand.</li>"
							+ "<li class=\"datacolumn\">UAT - user acceptance testing (UAT) is the process where user(s) confirms that a fix or enhancement was completed as requested. If all goes well, the work is moved to production; otherwise, the work goes back for more requirements.</li>"
							+ "</ul>";

System.out.println("while is done4");

						try{
							document.add(processElement(footer, DATACOLOR, Font.NORMAL));
						} catch(IllegalArgumentException e){
							logger.fatal("ReportGeneric - runReport 1: " + e.toString());
						} catch(Exception e){
							logger.fatal("ReportGeneric - runReport 2: " + e.toString());
						}
					}

					// step 5 of 5
					document.close();

System.out.println("while is done5");

					// with report ready, open in browser
					writePDF(request,response,reportFileName);

System.out.println("while is done6");

				} // not null report fields

			} // aseReport

		} catch(SQLException ex){
			logger.fatal("ReportGeneric - runReport 3: " + ex.toString());
		} catch(IllegalArgumentException ex){
			logger.fatal("ReportGeneric - runReport - 4: " + ex.toString());
		} catch(Exception ex){
			logger.fatal("ReportGeneric - runReport 5: " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn,"ReportGeneric",reportUser);

			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}

			aseUtil = null;
			website = null;
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
				ArrayList elementlist = HTMLWorker.parseToList(new StringReader(junk), styles, null);
				for (int j = 0; j < elementlist.size(); j++) {
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

Logger logger = Logger.getLogger("test");

		public Font getFont(String fontname,
									String encoding,
									boolean embedded,
									float size,
									int style,
									BaseColor color) {

			if (style==0)
				style = Font.NORMAL;

			if (style==1)
				style |= Font.BOLD;

			if (style==2)
				style |= Font.ITALIC;

			if (style==4)
				style |= Font.UNDERLINE;

			if (style==8)
				style |= Font.STRIKETHRU;

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

			String value = props.getProperty(ElementTags.SIZE);

			int style = 0;

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
			return new Font(Font.TIMES_ROMAN, 11, Font.NORMAL, new BaseColor(8,55,114));
		}

		public static Font getBlackFont() {
			return new Font(Font.TIMES_ROMAN, 9, Font.NORMAL, BaseColor.BLACK);
		}

		public boolean isRegistered(String fontname) {
			return false;
		}

	}

	/*
	 * drawTitleRow
	 * <p>
	 * @param	table			PdfPTable
	 * @param	title			String
	 * @param	campusColor	BaseColor
	 * @param	font			Font
	 * @param	columns		int
	 * @param	alignment	int
	 *	<p>
	 *	@return Phrase
	 */
	private static void drawTitleRow(PdfPTable table,
												String title,
												BaseColor campusColor,
												Font font,
												BaseColor fontColor,
												int columns,
												int alignment) throws IOException{

Logger logger = Logger.getLogger("test");

		PdfPCell cell = null;

		font.setColor(fontColor);
		cell = new PdfPCell(new Phrase(title, font));
		cell.setBackgroundColor(campusColor);
		cell.setHorizontalAlignment(alignment);
		cell.setColspan(columns);
		cell.setFixedHeight(20);
		table.addCell(cell);

	}

	/*
	 * drawHeaderRow
	 * <p>
	 * @param	table			PdfPTable
	 * @param	campusColor	BaseColor
	 * @param	columns		int
	 * @param	aHeader		String[]
	 * @param	font			Font
	 *	<p>
	 *	@return Phrase
	 */
	private static void drawHeaderRow(PdfPTable table,
												BaseColor campusColor,
												int columns,
												String headerColumns,
												Font font) throws IOException{

Logger logger = Logger.getLogger("test");

		PdfPCell cell = null;

		String[] aHeaderColumns = headerColumns.split(",");

		table.getDefaultCell().setBackgroundColor(campusColor);
		for (int i=0;i<columns;i++){
			cell = new PdfPCell(new Phrase(aHeaderColumns[i], font));
			cell.setBackgroundColor(campusColor);
			cell.setFixedHeight(20);
			table.addCell(cell);
		}

	}

	/*
	 * createPhrase
	 * <p>
	 * @param	data		String
	 * @param	header	boolean
	 *	<p>
	 *	@return Phrase
	 */
	private static Phrase createPhrase(String data,boolean header) throws IOException{

Logger logger = Logger.getLogger("test");

		Phrase phrase = new Phrase();

		try{
			if (header)
				phrase.setFont(myFont.getHeaderFont());
			else
				phrase.setFont(myFont.getDataFont());

			phrase.add(data);

		} catch(IllegalArgumentException iae){
			logger.fatal("ReportGeneric - createPhrase - iae: " + iae.toString());
			phrase.add("");
		} catch(Exception ex){
			logger.fatal("ReportGeneric - createPhrase ex: " + ex.toString());
			phrase.add("");
		}

		return phrase;
	}

	/*
	 * processElement
	 * <p>
	 * @param	junk	String
	 *	<p>
	 *	@return Phrase
	 */
	public static Phrase processElement(String junk, BaseColor color, int style) {

Logger logger = Logger.getLogger("test");

		Phrase phrase = null;

		try{
			HashMap<String,Object> providers = null;
			providers = new HashMap<String, Object>();
			providers.put("font_factory", new MyFontFactory());
			providers.put("img_provider", new MyImageFactory());

			ArrayList elementlist = HTMLWorker.parseToList(new StringReader(junk), styles, providers);
			phrase = new Phrase();

			for (int j = 0; j < elementlist.size(); j++) {
				Element element = (Element)elementlist.get(j);
				phrase.add(element);
			}

			phrase.setFont(FontFactory.getFont(FontFactory.TIMES, 9, style, color));

		} catch(IllegalArgumentException e){
			logger.fatal("ReportGeneric - processElements - 1: " + e.toString());
		} catch(RuntimeException e){
			logger.fatal("ReportGeneric - processElements - 2: " + e.toString());
		} catch(Exception e){
			logger.fatal("ReportGeneric - processElements - 3: " + e.toString());
		}

		return phrase;
	}

%>

</html>
