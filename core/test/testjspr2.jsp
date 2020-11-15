<%@ include file="ase.jsp" %>
<%@ page import="java.io.*, java.util.*, java.sql.Connection,javax.sql.DataSource, javax.naming.InitialContext,
net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.design.JasperDesign,net.sf.jasperreports.engine.xml.JRXmlLoader,
net.sf.jasperreports.engine.export.*"
%>
<%

	try{
		InputStream input=new FileInputStream(new File("C:/tomcat/webapps/central/core/rpts/campus.jrxml"));
		JasperDesign design = JRXmlLoader.load(input);
		JasperReport report = JasperCompileManager.compileReport(design);
		Map parameters = new HashMap();
		//parameters.put("ReportTitle", "Excel JasperReport");

		//InitialContext initialContext = new InitialContext();
		//DataSource ds = (DataSource)initialContext.lookup("java:comp/env/jdbc/OracleDBConnectionDS");
		//Connection conn = ds.getConnection();

		JasperPrint print = JasperFillManager.fillReport(report,parameters, conn);
		OutputStream ouputStream=new FileOutputStream(new File("C:/tomcat/webapps/central/core/rpts/campus.xls"));
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

		JRXlsExporter exporterXLS = new JRXlsExporter();
		exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, print);
		exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, byteArrayOutputStream);

		exporterXLS.exportReport();
		ouputStream.write(byteArrayOutputStream.toByteArray());
		ouputStream.flush();
		ouputStream.close();
	}
	catch(Exception e){
		System.out.println(e.toString());
	}

	asePool.freeConnection(conn);

%>


