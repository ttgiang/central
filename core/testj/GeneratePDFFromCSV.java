package com.ficoh.jaspergw;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

public class GeneratePDFFromCSV {


	/**
	 * reportfile csvfile outputfile nvp=1,nvp=2
	 *
	 * @param args
	 */
	public static void main(String[] args) throws Exception {

		if (args.length < 3) {
			System.out
					.println("usage: \n java com.ficoh.jaspergw.GeneratePDFFromCSV reportfile csvfile outputfile [nvp=1,..]");
			System.exit(1);
		}
		String reportFile = args[0];
		String csvFile = args[1];
		String outputFile = args[2];
		Map parameters = (args.length > 3 ) ? parseNVPs(args[3]) : new HashMap();

		try {
			Date start = new Date();
			System.out.println("creating report");

			FICOHCSVDataSource ds = new FICOHCSVDataSource(new FileInputStream(csvFile));
			ds.setUseFirstRowAsHeader(true);
			ds.setFieldDelimiter('|');
			ds.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
			JasperReport jasperReport = JasperCompileManager.compileReport(reportFile);
			JasperPrint print = JasperFillManager.fillReport(jasperReport,parameters, ds);
			JasperExportManager.exportReportToPdfFile(print,outputFile);
			Date finish = new Date();
			System.out.println("Done creating report. Time spent (ms) " + (finish.getTime() - start.getTime()));
			System.exit(0);
		} catch (Exception e) {
			System.out.println("can't generate report " + e.getMessage());
			System.exit(1);
		}

	}

	/**
	 * Turn a a=b,c=d list to a map of a=>b, c=>d
	 *
	 * @param args
	 * @return
	 */
	static Map<String,String>  parseNVPs(String args) {
		Map<String,String> m = new HashMap<String,String> ();
		StringTokenizer t = new StringTokenizer(args,"|");
		for (; t.hasMoreElements();) {
			// split this a=b to a and b
			StringTokenizer y = new StringTokenizer(t.nextToken(),"=");
			String name = (String) y.nextElement();
			String value =(String) y.nextElement();
			m.put(name,value);
		}

		return m;
	}

}