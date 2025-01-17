import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.engine.export.*;

public class JasperReportServlet extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{

		ServletOutputStream servletOutputStream = response.getOutputStream();
		Connection conn = null;
		JasperReport jasperReport;
		JasperPrint jasperPrint;
		JasperDesign jasperDesign;
		try{
			// get a database connection
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.10.85:1521:oracledb", "xyz","abc");

			// create a map of parameters to pass to the report.
			Map parameters = new HashMap();
			parameters.put("Report_Title", "Salesman Details");

			// load JasperDesign from XML and compile it into JasperReport
			jasperDesign = JRXmlLoader.load("C:/tomcat/webapps/central/core/testj/jasper.jrxml");
			jasperReport = JasperCompileManager.compileReport(jasperDesign);

			// fill JasperPrint using fillReport() method
			jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,conn);

			JasperExportManager.exportReportToPdfFile(jasperPrint,"C:/tomcat/webapps/central/core/testj/demo.pdf");
			response.setContentType("application/pdf");

			//for creating report in excel format
			JRXlsExporter exporterXls = new JRXlsExporter();
			exporterXls.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,"C:/tomcat/webapps/central/core/testj/demo.xls");
			exporterXls.exportReport();
			JasperExportManager.exportReportToPdfStream(jasperPrint, servletOutputStream);

			servletOutputStream.flush();
			servletOutputStream.close();
		}
		catch(SQLException sqle){
		 System.err.println(sqle.getMessage());
		}
		catch (ClassNotFoundException e){
		 System.err.println("No such class found!");
		}
		catch (JRException e){
			StringWriter stringWriter = new StringWriter();
			PrintWriter printWriter = new PrintWriter(stringWriter);
			e.printStackTrace(printWriter);
			response.setContentType("text/plain");
			response.getOutputStream().print(stringWriter.toString());
		}
		finally{
			if(conn != null){
				try { conn.close(); }
				catch (Exception ignored) {}
			}
		}
	}
}