/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// PdfReportTemplate.java
//

package com.ase.aseutil.pdf;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;

import org.apache.log4j.Logger;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import java.io.*;
import java.io.FileOutputStream;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.GrayColor;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Image;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocListener;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.itextpdf.text.FontFactory;

import com.itextpdf.text.FontProvider;
import com.itextpdf.text.html.simpleparser.ChainedProperties;
import com.itextpdf.text.html.simpleparser.ImageProvider;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.html.simpleparser.HTMLWorker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.ArrayList;

public class PdfReportTemplate58 {

	private static final long serialVersionUID = 6524277708436373642L;

	private static Logger logger = Logger.getLogger(PdfReportTemplate58.class.getName());

	public static BaseColor ASE_CAMPUS_HAW 			= new BaseColor(145,0,75);
	public static BaseColor ASE_CAMPUS_HIL 			= new BaseColor(213,43,30);
	public static BaseColor ASE_CAMPUS_HON 			= new BaseColor(00,166,122);
	public static BaseColor ASE_CAMPUS_KAP 			= new BaseColor(00,35,149);
	public static BaseColor ASE_CAMPUS_KAU 			= new BaseColor(125,92,198);
	public static BaseColor ASE_CAMPUS_LEE 			= new BaseColor(61,123,219);
	public static BaseColor ASE_CAMPUS_MAN 			= new BaseColor(2,71,49);
	public static BaseColor ASE_CAMPUS_MAU 			= new BaseColor(0,81,114);
	public static BaseColor ASE_CAMPUS_WES 			= new BaseColor(167,25,48);
	public static BaseColor ASE_CAMPUS_WIN 			= new BaseColor(122,184,0);

	public static BaseColor ASE_HEADERCOLOR 			= new BaseColor(82,82,82);
	public static BaseColor ASE_DATACOLOR				= new BaseColor(8,55,114);

	public static BaseColor ASE_EVEN_ROW_COLOR		= new BaseColor(255,255,255);
	public static BaseColor ASE_ODD_ROW_COLOR			= new BaseColor(229,241,244);

	public static BaseColor ASE_LIGHT_GRAY				= new BaseColor(224, 224, 224);

	public static MyFontFactory myFont 					= null;
	public static BaseFont pdfFont						= null;
	public static StyleSheet styles 						= null;
	public static HashMap<String,Object> providers 	= null;

	public static Font headerFont 						= null;
	public static Font dataFontBold 						= null;
	public static Font dataFontNormal 					= null;

	public static int dataFontSize 							= 10;
	public static int titleFontSize							= 11;

	public static int headerFontSize							= 10;
	public static int footerFontSize							= 10;

	public static HashMap<String,Object> campusColorMap 	= null;

	/**
	* constructor
	*/
	public PdfReportTemplate58(){}

	/**
	* Inner class to add a watermark to every page.
	*/
	@SuppressWarnings("unchecked")
	public static void initParams(){

		campusColorMap = new HashMap<String, Object>();
		campusColorMap.put(Constant.CAMPUS_HAW,new BaseColor(145,0,75));
		campusColorMap.put(Constant.CAMPUS_HIL,new BaseColor(213,43,30));
		campusColorMap.put(Constant.CAMPUS_HON,new BaseColor(00,166,122));
		campusColorMap.put(Constant.CAMPUS_KAP,new BaseColor(00,35,149));
		campusColorMap.put(Constant.CAMPUS_KAU,new BaseColor(125,92,198));
		campusColorMap.put(Constant.CAMPUS_LEE,new BaseColor(61,123,219));
		campusColorMap.put(Constant.CAMPUS_MAN,new BaseColor(2,71,49));
		campusColorMap.put(Constant.CAMPUS_UHMC,new BaseColor(0,81,114));
		campusColorMap.put(Constant.CAMPUS_WOA,new BaseColor(167,25,48));
		campusColorMap.put(Constant.CAMPUS_WIN,new BaseColor(122,184,0));
		campusColorMap.put(Constant.CAMPUS_TTG,new BaseColor(166,202,240));

		styles = new StyleSheet();

		styles.loadTagStyle("ul", "indent", "10");
		styles.loadTagStyle("li", "leading", "14");

		styles.loadStyle("li", "color", "#083772");
		styles.loadStyle("ul", "color", "#083772");

		styles.loadStyle("datacolumn", "color", "#083772");
		styles.loadStyle("datacolumn", "style", "0");
		styles.loadStyle("datacolumn", "size", "9pt");

		styles.loadStyle("textblackth", "color", "#525252");
		styles.loadStyle("textblackth", "style", "1");
		styles.loadStyle("textblackth", "size", "10pt");

		styles.loadStyle("font", "normal", "11pt");
		styles.loadStyle("body", "face", "verdana");

		providers = new HashMap<String, Object>();
		providers.put("font_factory", new MyFontFactory());

		//
		// removed with itext 5.3.4
		//
		//providers.put("img_provider", new MyImageFactory());
		myFont = new MyFontFactory();

		headerFont = FontFactory.getFont(FontFactory.TIMES_ROMAN, titleFontSize, Font.BOLD, ASE_HEADERCOLOR);
		dataFontBold = FontFactory.getFont(FontFactory.TIMES_ROMAN, dataFontSize, Font.BOLD, ASE_DATACOLOR);
		dataFontNormal = FontFactory.getFont(FontFactory.TIMES_ROMAN, dataFontSize, Font.NORMAL, ASE_DATACOLOR);

		logger.info("PdfReportTemplate58 initialized...");
	}

	/**
	* Inner class to add a watermark to every page.
	*/
	static class Watermark extends PdfPageEventHelper {

		private String waterMark;

		Font font = new Font(Font.FontFamily.TIMES_ROMAN, 36, Font.NORMAL, new GrayColor(0.95f));

		public Watermark(){
			waterMark = "";
		}

		public Watermark(String wm){
			waterMark = wm;
		}

		public void onEndPage(PdfWriter writer, Document document) {

			ColumnText.showTextAligned(writer.getDirectContentUnder(),
											  Element.ALIGN_CENTER,
											  new Phrase(waterMark, font),
											  297.5f, 421, 0);

			// replace 0 with
			//		writer.getPageNumber() % 2 == 1 ? 45 : -45
			// for 45 angle effect
		}
	}

	/**
	* Inner class to add a table as header.
	*/
	static class TableHeader extends PdfPageEventHelper {

		String header;
		String campusName;
		String userName;

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
				throw new ExceptionConverter(e);
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
				phrase.setFont(myFont.getFooterFont());
				phrase.add(userName);
				table.addCell(phrase);

				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				phrase = new Phrase();
				phrase.setFont(myFont.getFooterFont());
				phrase.add(header);
				table.addCell(phrase);

				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
				phrase = new Phrase();
				phrase.setFont(myFont.getFooterFont());
				phrase.add(outlineLastDate);
				table.addCell(phrase);

				table.writeSelectedRows(0, -1, 34, 803, writer.getDirectContent());

				// footer
				PdfPTable footer = new PdfPTable(colsWidth);
				footer.setTotalWidth(document.right()-document.left());
				footer.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

				if(debug) System.out.println("1 - endpage: " + campusName);

				phrase = new Phrase();
				phrase.setFont(myFont.getFooterFont());
				phrase.add(campusName);
				footer.addCell(phrase);

				phrase = new Phrase();
				phrase.setFont(myFont.getFooterFont());
				phrase.add("Curriculum Central (CC)");
				PdfPCell cell = new PdfPCell(phrase);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setBorder(PdfPCell.NO_BORDER);
				footer.addCell(cell);

				if(debug) System.out.println("2 - endpage");

				phrase = new Phrase();
				phrase.setFont(myFont.getFooterFont());

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
				logger.fatal("PdfReportTemplate58: onEndPage - " + ex.toString());
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

		public Font getFont(String fontname,String encoding,boolean embedded,float size,int style,BaseColor color) {

			BaseFont bf;

			try {
				bf = BaseFont.createFont("c:/windows/fonts/arialuni.ttf","Identity-H", BaseFont.EMBEDDED);
			} catch (DocumentException e) {
				logger.fatal(e.toString());
				return new Font();
			} catch (IOException e) {
				logger.fatal(e.toString());
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

	/**
	**	writePDF
	**/
	public static void writePDF(HttpServletRequest request,
										HttpServletResponse response,
										String reportFileName) {

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
				logger.fatal("PdfReportTemplate58 - writePDF: " + e.toString());
			} finally {
				if (bis != null)
					bis.close();

				if (bos != null)
					bos.close();
			}

			HttpSession session = request.getSession(true);

			session.removeAttribute("myPdf");

		} catch (IOException e) {
			logger.fatal("PdfReportTemplate58 - writePDF: " + e.toString());
		}
	}

	/*
	 * convertToDOSCharacters
	 * <p>
	 * @param	junk	String
	 *	<p>
	 *	@return String
	 */
	public static String convertToDOSCharacters(String junk) {

		try{
			if (junk == null)
				junk = "";
			else{
				junk = junk.replace("<br>","\n");
				junk = junk.replace("<br/>","\n");
				junk = junk.replace("<br />","\n");
				junk = junk.replace("<p>","\n");
				junk = junk.replace("</p>","");
				junk = junk.replace("&nbsp;"," ");
			}
		} catch(Exception ex){
			logger.fatal("PdfReportTemplate58 - convertToDOSCharacters - ex: " + ex.toString());
		}

		return junk;
	}

}