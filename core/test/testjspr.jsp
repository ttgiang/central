<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>

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
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ENG";
	String num = "18";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "I52a8c9702630";
	int route = 708;
	String message = "";
	String url = "";

	//out.println("Start<br/>");
	//out.println(showUserTasks(conn,"LEE","BERNER"));
	//out.println("<br/>End");
	doGet(request,response,conn,kix,user);

	asePool.freeConnection(conn);
%>

<%!

	protected void doGet(HttpServletRequest request,
						HttpServletResponse response,
						Connection conn,
						String kix,
						String user)throws ServletException, IOException{

		Logger logger = Logger.getLogger("test");

		try{
			CourseDB courseDB = new CourseDB();
			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String campus = info[4];
			String reportTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
			String campusName = CampusDB.getCampusName(conn,campus);

			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
			String reportFolder = currentDrive + Constant.REPORT_DESIGN_FOLDER;
			String outputFolder = currentDrive + Constant.REPORT_OUTPUT_FOLDER + campus +"/";
			String logoFile = currentDrive + Constant.REPORT_LOGO_FOLDER + "logo" + campus + ".jpg";

			HashMap parameters = new HashMap();
			parameters.put("aseCampus", campus);
			parameters.put("aseTitle", reportTitle);
			parameters.put("aseKix", kix);
			parameters.put("aseImage", logoFile);
			parameters.put("aseCampusName", campusName);

			System.out.println("--------------------------");
			System.out.println("setting parameters...");

			JasperDesign jasperDesign = JRXmlLoader.load(reportFolder + "outline.jrxml");
			System.out.println("loading report design...");
			System.out.println(reportFolder + "outline.jrxml");

			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			System.out.println("compiling report...");

			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,conn);
			System.out.println("creating print file...");

			JasperExportManager.exportReportToPdfFile(jasperPrint,outputFolder + user + ".pdf");
			System.out.println("creating PDF...");
			//response.setContentType("application/pdf");
		}
		catch(JRException e){
			logger.fatal("" + e.toString());
		}
		catch(Exception ex){
			logger.fatal("" + ex.toString());
		}
	}
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

