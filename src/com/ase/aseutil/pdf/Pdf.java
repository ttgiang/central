/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// Pdf.java
//
package com.ase.aseutil.pdf;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.Pipeline;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.itextpdf.tool.xml.pipeline.html.LinkProvider;

import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.AsePool;
import com.ase.aseutil.CampusDB;
import com.ase.aseutil.Constant;
import com.ase.aseutil.CourseDB;
import com.ase.aseutil.Helper;
import com.ase.aseutil.Outlines;
import com.ase.aseutil.ProgramsDB;
import com.ase.aseutil.SysDB;

public class Pdf extends PdfReportTemplate {

	private static final long serialVersionUID = 6524277708436373642L;

	private static Logger logger = Logger.getLogger(Pdf.class.getName());

	/**
	*
	*
	*
	**/
	public Pdf(){}

	/**
	*
	*
	*
	**/
	public void createPDF(	HttpServletRequest request,
									HttpServletResponse response,
									String user,
									String kix){

		createPDF(request,response,user,kix,Constant.OFF);
	}

	public void createPDF(	HttpServletRequest request,
									HttpServletResponse response,
									String user,
									String kix,
									String aseShowAuditStampInFooter){

		// with report ready, open in browser

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();
			if (conn != null){

				String outlineType = "";
				String outlineLastDate = "";

				com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

				boolean foundation = false;

				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

				if(!isAProgram){
					foundation =fnd.isFoundation(conn,kix);
				}

				//
				// get campus based on kix because this page is not campus specific (display outlines)
				//
				String[] info = null;
				String campus = "";
				String type = "";

				if(foundation){
					info = fnd.getKixInfo(conn,kix);
				}
				else{
					info = Helper.getKixInfo(conn,kix);
				}

				campus = info[Constant.KIX_CAMPUS];
				type = info[Constant.KIX_TYPE];

				if (aseShowAuditStampInFooter.equals(Constant.ON)){
					if(foundation){
						outlineLastDate = fnd.footerStatus(conn,kix,type);
					}
					else if(isAProgram){
						outlineLastDate = ProgramsDB.footerStatus(conn,kix,type);
					}
					else{
						outlineLastDate = Outlines.footerStatus(conn,kix,type);
					}
				}

				String server = SysDB.getSys(conn,"server");

				File file = null;

				String folder = "";
				String title = "";

				if(foundation){
					folder = "fnd";
					title =fnd.getFndItem(conn,kix,"coursetitle");
					campus =fnd.getFndItem(conn,kix,"campus");
				}
				else{
					if (isAProgram){
						folder = "programs";
						title = ProgramsDB.getProgramTitle(conn,campus,kix);
					}
					else{
						folder = "outlines";
						title = CourseDB.getCourseItem(conn,kix,"coursetitle");
					}
				}

				AseUtil aseUtil = new AseUtil();
				String pdfName = aseUtil.getReportOutputFolder(campus +"/") + kix + ".pdf";
				aseUtil = null;

				//
				// make sure we have data file to process
				//
				String htmName = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\centraldocs\\docs\\"+folder+"\\"+campus+"\\xml\\"+kix+".xml";

				file = new File(htmName);

				if(file.exists()){

					createPDF(server,CampusDB.getCampusName(conn,campus),user,htmName,pdfName,title,aseShowAuditStampInFooter,outlineLastDate);

					//
					// make sure we have pdf file to view
					//
					file = new File(pdfName);
					if(!file.exists()){
						pdfName = "http://"+server+"/central/help/error.pdf";
					}

				}
				else{
					pdfName = "http://"+server+"/central/help/error.pdf";
				}


				writePDF(request,response,pdfName);

				fnd = null;

			} // valid connection

		}
		catch(Exception e){
			logger.fatal("createPDF: " + e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("createPDF: " + e.toString());
			}
		}

	}

	public void createPDF(String server,
								String campusName,
								String user,
								String htmName,
								String pdfName,
								String title,
								String aseShowAuditStampInFooter,
								String outlineLastDate){

		boolean debug = false;

		try{

			String currentDrive = AseUtil.getCurrentDrive();
			final String imageFolder = "http://"+server+"/central/images/";
			final String appFolder = "http://"+server+"/central/";

			String styleSheet = currentDrive + ":\\tomcat\\webapps\\central\\inc\\style.css";

			if(debug){
				logger.info("createPDF");
				logger.info("---------");
				logger.info("html: " + htmName);
				logger.info("pdf: " + pdfName);
				logger.info("imageFolder: " + imageFolder);
				logger.info("appFolder: " + appFolder);
				logger.info("styleSheet: " + styleSheet);
				logger.info("title: " + title);
				logger.info("outlineLastDate: " + outlineLastDate);
			}

			Document document = new Document();

			document.setMargins(36, 72, 70, 70);
			document.setMarginMirroringTopBottom(false);

			if(debug) logger.info("step 01 - new document");

			PdfWriter pdfWriter = PdfWriter.getInstance(document,new FileOutputStream(new File(pdfName)));
			pdfWriter.setInitialLeading(12.5f);

			TableHeader event = new TableHeader();

			event.setHeader(title,campusName,user,aseShowAuditStampInFooter,outlineLastDate);

			pdfWriter.setPageEvent(event);

			if(debug) logger.info("step 02 - got writer");

			document.open();

			if(debug) logger.info("step 03 - document is opened");

			HtmlPipelineContext htmlPipelineContext = new HtmlPipelineContext(null);

			htmlPipelineContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

			if(debug) logger.info("step 04 - pipeline created");

			//
			// image folder
			//
			htmlPipelineContext.setImageProvider(new AbstractImageProvider() {
				public String getImageRootPath() {
					return imageFolder;
				}
			}).setTagFactory(Tags.getHtmlTagProcessorFactory());

			if(debug) logger.info("step 05 - image root established");

			//
			// app folder
			//
			htmlPipelineContext.setLinkProvider(new LinkProvider() {
				public String getLinkRoot() {
					return appFolder;
				}
			}).setTagFactory(Tags.getHtmlTagProcessorFactory());

			if(debug) logger.info("step 06 - link root established");

			XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

			CSSResolver cssResolver = new StyleAttrCSSResolver();

			CssFile cssFile = helper.getCSS(new FileInputStream(styleSheet));

			cssResolver.addCss(cssFile);

			if(debug) logger.info("step 07 - css link established");

			Pipeline<?> pipeline = new CssResolverPipeline(cssResolver,
											new HtmlPipeline(htmlPipelineContext,
												new PdfWriterPipeline(document, pdfWriter)));

			if(debug) logger.info("step 08 - pipeline constructed");

			XMLWorker xmlWorker = new XMLWorker(pipeline, true);

			XMLParser xmlParser = new XMLParser(xmlWorker);

			if(debug) logger.info("step 09 - parser created");

			xmlParser.parse(new FileInputStream(htmName));

			if(debug) logger.info("step 10 - document parsed");

			document.close();

			if(debug) logger.info("step 11 - document closed");

		}
		catch (FileNotFoundException e) {
			logger.fatal("Pdf: createPDF1 - " + e.toString());
		} catch (IOException e) {
			logger.fatal("Pdf: createPDF2 - " + e.toString());
		} catch (DocumentException e) {
			logger.fatal("Pdf: createPDF3 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Pdf: createPDF4 - " + e.toString());
		}
	}

	/**
	*
	*
	*
	**/
	public static void run(String[] args) throws IOException, DocumentException {

		Pdf pdf = new Pdf();

		if (args.length < 2){
			System.err.println("Usage: java HTM_Filename PDF_Filename");
			System.exit(1);
		}

		//pdf.createPDF(null,"","",args[0].trim(),args[1].trim(),"");

		pdf = null;

	}

}
