<%@ include file="ase.jsp" %>

<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>

<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.OutputStream"%>

<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>

<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.ServletConfig"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.*"%>

<%@ page import="net.sf.jasperreports.view.JasperViewer"%>
<%@ page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@ page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@ page import="net.sf.jasperreports.engine.JasperReport"%>
<%@ page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@ page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@ page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@ page import="net.sf.jasperreports.engine.JRException"%>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import="net.sf.jasperreports.engine.JasperPrintManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@ page import="net.sf.jasperreports.engine.export.JExcelApiExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRCsvExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRRtfExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.export.oasis.JROdtExporter"%>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader"%>

<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.MediaTracker"%>
<%@ page import="java.awt.Panel"%>
<%@ page import="java.awt.Toolkit"%>

<%
	/**
	*	ASE
	*	crsasslnk.jsp	link compentency to assessment. Called by crsassr.
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "68%";
	String pageTitle = "Test";

	out.println("Start<br/>");
	//out.println("<a href=\"/central/servlet/jspr?campus=LEE&kix=Q37f9k9241&rpt=Outline&tp="+Constant.REPORT_TO_PDF+"\" target=\"_blank\">click here</a>");
	//process(request,response,"LEE","Q37f9k9241","Outline",Constant.REPORT_TO_PDF,conn,out);
	jasper(request,response,conn,"LEE","outline","I52a8c9702630","THANHG");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%!
	/**
	*
	**/
	public void jasper(HttpServletRequest request,
										HttpServletResponse response,
										Connection conn,
										String viewerCampus,
										String report,
										String kix,
										String user)throws ServletException, IOException{

Logger logger = Logger.getLogger("test");

//Connection conn = null;

		try{
//conn = connectionPool.getConnection();

			CourseDB courseDB = new CourseDB();

			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String outlineCampus = info[4];
			String reportTitle = courseDB.setPageTitle(conn,"",alpha,num,outlineCampus);
			String outlineCampusName = CampusDB.getCampusName(conn,outlineCampus);

			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
			String reportFolder = currentDrive + Constant.REPORT_DESIGN_FOLDER;
			String outputFolder = currentDrive + Constant.REPORT_OUTPUT_FOLDER + viewerCampus +"/";
			String logoFile = currentDrive + Constant.REPORT_LOGO_FOLDER + "logo" + outlineCampus + ".jpg";

			String jasperFile = reportFolder + report + ".jasper";
			String jrxmlFile = reportFolder + report + ".jrxml";
			String outputFileName = outputFolder + user + ".pdf";

			HashMap parameters = new HashMap();
			parameters.put("aseCampus", outlineCampus);
			parameters.put("aseTitle", reportTitle);
			parameters.put("aseKix", kix);
			parameters.put("aseImage", logoFile);
			parameters.put("aseCampusName", outlineCampusName);

			System.out.println("-------------------------- " + user + " (" + report + ")");
			System.out.println(kix + " - jasperFile ..." + jasperFile);
			System.out.println(kix + " - jrxmlFile..." + jrxmlFile);
			System.out.println(kix + " - setting parameters...");

			int rpt = 1;

			if (rpt == 1){
				JasperDesign jasperDesign = JRXmlLoader.load(jrxmlFile);
				System.out.println(kix + " - loading report design...");

				JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
				System.out.println(kix + " - compiling report...");

				JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,conn);
				System.out.println(kix + " - creating print file...");

				JasperExportManager.exportReportToPdfFile(jasperPrint,outputFileName);
				System.out.println(kix + " - creating PDF...");
			}
			else if (rpt == 2){
				// in case we don't have or have not ever viewed this outline, we have
				// to create the data that JASPER expects to process and render
				if ("outline".equals(report) && kix != null && kix.length() > 0){
					Msg msg = Outlines.viewOutline(conn,kix,user);
					System.out.println(kix + " - generating data...");
				}

				System.out.println(kix + " - report name..." + report);

				HttpSession session = request.getSession(true);
				System.out.println(kix + " - requesting session...");

				ServletOutputStream sos = response.getOutputStream();
				System.out.println(kix + " - obtaining output stream...");

				InputStream is = getServletConfig().getServletContext().getResourceAsStream(jasperFile);
				System.out.println(kix + " - obtaining report stream...");

				String sql = aseUtil.getPropertySQL(session,"report"+report);;
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				System.out.println(kix + " - obtaining resultset...");

				JRResultSetDataSource jrsd = new JRResultSetDataSource(rs);
				System.out.println(kix + " - filling report...");

				//JasperRunManager.runReportToPdfStream(is,sos,parameters,jrsd);
				//System.out.println(kix + " - exporting to PDF...");

JasperFillManager.fillReportToFile(jasperFile,parameters,jrsd);
System.out.println(kix + " - exporting to PDF...");

				rs.close();
				ps.close();
				System.out.println(kix + " - releasing resources...");

//response.setContentType("application/pdf");

				sos.flush();
				sos.close();
				System.out.println(kix + " - flushing streams...");
			}

		}
		catch(JRException e){
System.out.println("ReportServlet - processRequest JRE: " + e.toString());
		} catch(Exception ex){
System.out.println("ReportServlet - processRequest EX: " + ex.toString());
		} finally {
//connectionPool.freeConnection(conn);
		}

	}

	/**
	*
	**/
	public void jasper2(HttpServletRequest request,
							HttpServletResponse response,
							Connection conn,
							String kix)  throws Exception  {

		Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();
		CourseDB courseDB = new CourseDB();

		JasperReport jasperReport;
		JasperPrint jasperPrint;
		boolean error = false;

		HttpSession session = request.getSession(true);

		String report = website.getRequestParameter(request,"rpt");
		String p1 = website.getRequestParameter(request,"p1");
		String p2 = website.getRequestParameter(request,"p2");

report = "ApprovedOutlines";
p1 = "";
p2 = "";

		String jasperReportTitle = "";
		String jasperReportName = "";
		String jasperReportFormat = "";

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		String reportTitle = "";
		String userReportName = "";
		String url = "";
		String alpha = "";
		String num = "";

//Connection conn = null;

		try{
//conn = connectionPool.getConnection();

			File sourceFile = null;
			File destFile = null;
			boolean dynamicTitle = false;

			Map parameters = new HashMap();

			AseUtil aseUtil = new AseUtil();

//jasperReportName="approved";
//jasperReportTitle="Approved Outlines";
//jasperReportFormat="PDF";

jasperReportName="Outline";
jasperReportTitle="";
jasperReportFormat="PDF";

if (kix != null && kix.length() > 0){
	String[] info = Helper.getKixInfo(conn,kix);
	alpha = info[0];
	num = info[1];
	jasperReportTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
}

			String campusName = CampusDB.getCampusName(conn,campus);
			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
			String reportsFolder = currentDrive + ":/tomcat/webapps/central/core/rpts/";
			String outputFolder = currentDrive + ":/tomcat/webapps/central/docs/urpts/" + campus + "/";
			String reportName = reportsFolder + jasperReportName;
			String jasperFile = reportName + ".jasper";
			String jrprintFile = reportName + ".jrprint";

			String imageFile = currentDrive
				+ ":"
				+ File.separatorChar
				+ "tomcat" + File.separatorChar + "webapps\\central\\images\\logos\\logo" + campus + ".jpg";

			if (!"".equals(jasperReportTitle)){
System.out.println("------------------------");
System.out.println("currentDrive: " + currentDrive);
System.out.println("reportsFolder: " + reportsFolder);
System.out.println("outputFolder: " + outputFolder);
System.out.println("reportName: " + reportName);
System.out.println("jasperFile: " + jasperFile);
System.out.println("jrprintFile: " + jrprintFile);
System.out.println("imageFile: " + imageFile);
System.out.println("campusName: " + campus + " - " + campusName);
System.out.println("kix: " + kix);

parameters.put("aseCampus",campus);
parameters.put("aseTitle",jasperReportTitle);
parameters.put("aseKix",kix);
parameters.put("aseImage",imageFile);
parameters.put("aseCampusName",campusName);

				JasperFillManager.fillReportToFile(jasperFile,parameters,conn);
				sourceFile = new File(reportName + ".jrprint");
				jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

				userReportName = user + "." + jasperReportFormat.toLowerCase();
				destFile = new File(outputFolder, userReportName);

System.out.println("userReportName: " + userReportName);
System.out.println("jasperReportFormat: " + jasperReportFormat);

				if ("CSV".equals(jasperReportFormat)){
					JRCsvExporter exporterCSV = new JRCsvExporter();
					exporterCSV.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					exporterCSV.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
					exporterCSV.exportReport();
				}
				else if ("RTF".equals(jasperReportFormat)){
					JRRtfExporter exporterRTF = new JRRtfExporter();
					exporterRTF.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					exporterRTF.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
					exporterRTF.exportReport();
				}
				else if ("PDF".equals(jasperReportFormat)){
					JRPdfExporter exporterPDF = new JRPdfExporter();
					exporterPDF.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					exporterPDF.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
					exporterPDF.exportReport();
				}

				logger.info("Jasper - processReport " + report + " (" + user + ")");
			}
			else{
				error = true;
			}

		}catch (IOException ioe){
System.out.println("IOE - Jasper - processReport - " + userReportName + " - " + ioe.toString());
			error = true;
		}catch (JRException e){
System.out.println("E - Jasper - processReport - " + userReportName + " - " + e.toString());
			error = true;
		}catch (Exception ex){
System.out.println("EX - Jasper - processReport - " + userReportName + " - " + ex.toString());
		} finally {
//connectionPool.freeConnection(conn);
		}

		Msg msg = new Msg();
		if (!error){
			session.setAttribute("aseJasperMessage","Report processing completed successfully."
				+ "<br/><br/>Click <a href=\"/central/docs/urpts/" + campus + "/" + userReportName
				+ "\" class=\"linkcolumn\" target=\"_blank\">here</a> to view your report.");
		}
		else{
			session.setAttribute("aseJasperMessage","An error occurred while processing the requested report.");
		}

		url = response.encodeURL("/core/crsrpt.jsp");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}
%>

</body>
</html>
