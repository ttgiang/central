/**

 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.test.aseutil;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import com.ase.aseutil.*;

import java.io.*;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.text.pdf.fonts.otf.TableHeader;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;

import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Element;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.FontProvider;
import com.itextpdf.text.Font;
import com.itextpdf.text.BaseColor;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.LinkProvider;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.itextpdf.tool.xml.Pipeline;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.parser.XMLParser;

import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;

import org.apache.log4j.Logger;
import org.jsoup.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author tgiang
 *
 */
public class OutlinesWithComments extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.OutlinesWithComments#testOutlinesWithComments()}.
	 */
	@Test
	public final void testOutlinesWithComments() {

		boolean processed = false;

		logger.info("--> OutlinesWithComments.testOutlinesWithComments.START");

		try{
			if (getConnection() != null){

				boolean doHTM = false;
				boolean doXML = false;
				boolean doPDF = false;

				String src = "outlines";

				if(getParm1() != null && getParm1().equals("1"))
					doHTM = true;

				if(getParm2() != null && getParm2().equals("1"))
					doXML = true;

				if(getParm3() != null && getParm3().equals("1"))
					doPDF = true;

				if(getParm4() != null)
					src = getParm4();

				boolean showHistory = false;
				if(getAlpha() == null || getAlpha().equals("0")){
					showHistory = false;
				}
				else if(getAlpha().equals("1")){
					showHistory = true;
				}

				boolean NotApprovedInCC = false;
				if(getNum() == null || getNum().equals("0")){
					NotApprovedInCC = false;
				}
				else if(getNum().equals("1")){
					NotApprovedInCC = true;
				}

				processed = runMe(getConnection(),getCampus(),getKix(),doHTM,doXML,doPDF,getDebug(),getType(),src,showHistory,NotApprovedInCC);
			}
		}
		catch(Exception e){
			processed = false;
		}

		assertTrue(processed);

		logger.info("--> OutlinesWithComments.testOutlinesWithComments.END");

	}

	public static boolean runMe(Connection conn,
											String campus,
											String kix,
											boolean doHTM,
											boolean doXML,
											boolean doPDF,
											boolean debug,
											String type,
											String src,
											boolean showHistory,
											boolean NotApprovedInCC) {

		boolean processed = false;

		try{
			if (conn != null){
				if(src.equals("outlines")){
					createOutlineComments(conn,campus,kix,doHTM,doXML,doPDF,debug,type,showHistory,NotApprovedInCC);
				}
				else{
					createProgramComments(conn,campus,kix,doHTM,doXML,doPDF,debug,type,showHistory,NotApprovedInCC);
				}
				processed = true;
			}
		}
		catch(Exception e){
			processed = false;
		}

		return processed;

	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToValue(String val,String defalt) {

		if (val==null || val.equals("null") || val.length()== 0)
			val = defalt;

		if (val.length() > 0)
			val = val.trim();

		return val;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static int nullToValue(int val,int defalt) {

		int temp = 0;

		if (Integer.toString(val) == null)
			temp = defalt;
		else
			temp = val;

		return temp;
	}

	public static int createOutlineComments(Connection conn,
														String campus,
														String kix,
														boolean doHTM,
														boolean doXML,
														boolean doPDF,
														boolean debug,
														String type,
														boolean showHistory,
														boolean NotApprovedInCC) throws Exception {

		Logger logger = Logger.getLogger("test");

		int outlinesWritten = 0;

		boolean methodCreatedConnection = false;
		boolean showComments = false;

		String user = "";

		boolean compressed = true;
		boolean print = true;
		boolean detail = false;
		String outputFolder = "ttg";

		String sql = "";
		String junk = "";

		try{
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			if (conn != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				String server = SysDB.getSys(conn,"server");
				com.ase.aseutil.pdf.Pdf58 makePdf = new com.ase.aseutil.pdf.Pdf58();

				try {

					AseUtil aseUtil = new AseUtil();
					CourseDB courseDB = new CourseDB();

					String campusName = CampusDB.getCampusName(conn,campus);

					String currentDrive = AseUtil.getCurrentDrive();
					String documents = SysDB.getSys(conn,"documents");
					String fileName = currentDrive
												+ ":"
												+ documents
												+ "outlines\\"
												+ outputFolder
												+ "\\";

					String htmlHeader = Util.getResourceString("header.ase");
					String htmlFooter = Util.getResourceString("footer.ase");

					String table = "tblCourse";
					if(type.equals("ARC")){
						table = "tblCourseARC";
					}

					String view = "vw_archived_outlines";
					sql = "select * from " + view + " where campus=? and coursetype=? and not coursedate is null  ";
					if(NotApprovedInCC){
						view = "vw_archived_outlines_null";
						sql = "select * from " + view + " where campus=? and coursetype=? ";
					}

					if(!kix.equals("")){
						sql += " and historyid='"+kix+"'";
					}
					sql += " order by coursealpha,coursenum";

					if(debug){
						logger.info("view: " + view);
						logger.info("fileName: " + fileName);
						logger.info("campus: " + campus);
						logger.info("kix: " + kix);
						logger.info("htm: " + doHTM);
						logger.info("xml: " + doXML);
						logger.info("pdf: " + doPDF);
						logger.info("type: " + type);
						logger.info("sql: " + sql);
					}

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						kix = AseUtil.nullToBlank(rs.getString("historyid"));
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));

						String title = AseUtil.nullToBlank(rs.getString("coursetitle"));
						String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
						String coursedate = AseUtil.nullToBlank(rs.getString("coursedate"));
						if(coursedate != null && !coursedate.equals("")){
							coursedate = aseUtil.ASE_FormatDateTime(coursedate, 6);
						}
						else{
							coursedate = "";
						}

						String filecode = campus + "_" + alpha + "_" + num + "_" + kix;
						String htmlfile = fileName + "htm\\" + type + "\\" + filecode + ".html";
						String xmllfile = fileName + "xml\\" + type + "\\" + filecode + ".xml";

						String checkedName = "";
						String aphist = "";

						if(doHTM)
							checkedName = fileName + "htm\\" + type + "\\" + filecode + ".html";
						else if(doPDF)
							checkedName = fileName + "pdf\\" + type + "\\" + filecode + ".pdf";
						else if(doXML)
							checkedName = fileName + "xml\\" + type + "\\" + filecode + ".xml";

						File file = new File(checkedName);
						if(!file.exists()){

							if(debug){
								logger.info("filecode: " + filecode);
								logger.info("coursedate: " + coursedate);
							}

							try{

								if(doHTM){
									fstream = new FileWriter(htmlfile);
									output = new BufferedWriter(fstream);

									output.write(htmlHeader);

									output.write("<p align=\"center\" class=\"outputTitleCenter\">" + com.ase.aseutil.CampusDB.getCampusName(conn,campus) + "<BR>");
									output.write(courseDB.getCourseDescriptionByTypePlus(conn,campus,alpha,num,type) + "</p>");
									com.ase.aseutil.Msg msg = viewOutline(conn,kix,user,compressed,print,false,detail);

									junk = spamy(kix,filecode,msg.getErrorLog());
									if(junk.equals("***")){
										junk = msg.getErrorLog();
									}
									if(debug) logger.info("spamy");

									// for some reason, using antispamy messed up attachments url.
									// we'll add the attachment data after the cleaning
									if(junk.contains("||_attachment_||")){
										junk = junk.replace("||_attachment_||",getAttachmentAsHTMLList(conn,kix));
									}

// cannot use this line when creating PDFs
//junk = junk.replace("http://localhost:8080/central/images","../../..");

									// use only to clean data for kuali
									//junk = Jsoup.parse(junk).text();

									output.write(junk);

									if(showHistory){
										// approval history (source for page is from crsinfy)
										aphist = "<br/>"
											+"<table border=\"0\" width=\"660\" class=\"tableCaption\">"
											+"<tr>"
											+"<td align=\"left\"><hr size=1><a style=\"text-decoration:none\" name=\"approval_history\"  class=\"goldhighlights\">Approval History</a></td>"
											+"</tr>";
										output.write(aphist);

										ArrayList list = HistoryDB.getHistories(conn,kix,type);
										if (list != null){
											History history;
											aphist = "";
											for (int i=0; i<list.size(); i++){
												history = (History)list.get(i);
												aphist += "<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>"
													+ "<tr><td class=\"datacolumn\" valign=top>" + history.getComments() + "</td></tr>";
											}

											if(!aphist.equals("")){
												aphist = "<tr bgcolor=\"#ffffff\">"
													+"<td>"
													+"<table border=\"0\" cellpadding=\"2\" width=\"100%\">"
													+ aphist
													+ "</table>"
													+"</td>"
													+"</tr>";
												output.write(aphist);
											}
										}
										aphist = "</table>";
										output.write(aphist);

										aphist =  "<br>";
										aphist += ""
											+ "<TABLE cellSpacing=0 cellPadding=5 width=\"680\" border=1>"
											+ "<TBODY>"
											+ "<TR>"
											+ "<TD class=\"textblackTH\" width=\"25%\">Proposer:</TD>"
											+ "<TD class=\"dataColumn\" width=\"75%\">"+proposer+"</TD>"
											+ "</TR>"
											+ "<TR>"
											+ "<TD class=\"textblackTH\" width=\"25%\">Approved Date:</TD>"
											+ "<TD class=\"dataColumn\">"+coursedate+"</TD>"
											+ "</TR>"
											+ "</TBODY>"
											+ "</TABLE>"
											+ "<br><br>";
										output.write(aphist);

									} // showHistory

									// approver comments
									if(showComments){
										aphist = "";
										int fid = ForumDB.getForumID(conn,campus,kix);
										if (fid == 0){
											aphist = "<table width=\"680\" cellspacing=\"1\" cellpadding=\"4\"><tr><td>";
											aphist += "<br><hr size=1>" + ReviewerDB.getReviewHistory2(conn,kix,0,campus,0,Constant.APPROVAL,"h1","c1");
											aphist += "</td></tr></table><br><br>";
											if(aphist != null){
												aphist = aphist.replace("display: none;","display: nn;");
											}
										}
										else{
											if (fid > 0){
												aphist = "<table width=\"100%\" cellspacing=\"1\" cellpadding=\"4\"><tbody>";
												int k = 0;
												String clss = "";
												for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid,0)){
													++k;
													int mid = Integer.parseInt(u.getString6());
													int item = Integer.parseInt(u.getString9());
													aphist += "<tr class=\""+clss+"\"><td style=\"text-align:left;\">";
													aphist += Board.printChildren(conn,fid,item,0,0,mid,user);
													aphist += "</td></tr>";
												} // for

												aphist += "</tbody></table><br><br>";
											} // if fid
										} // if enableMessageBoard

										if(!aphist.equals("")){
											output.write(aphist);
										}
									}

									output.write(htmlFooter);
								} // doHTM

								if(doXML){
									createXML(conn,outputFolder,campus,alpha,num,kix,type);
								}

								if(doPDF){
									createPDF(filecode,type,"outlines");
								} // doPDF

							}
							catch(Exception e){
								logger.info("failed to create outline");
							}
							finally{
								if(doHTM){
									output.close();
								}
							}

							++outlinesWritten;

						}
						else{
							deleteXML(xmllfile);
						} // file exist

					} // while
					rs.close();
					ps.close();

					makePdf = null;
				}
				catch(Exception e){
					logger.info("fail to process data");
				}

				// release connection
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					logger.fatal("createOutlineComments: " + e.toString());
				}

			} // conm

			// only if the connection was created here
			if (methodCreatedConnection){
				try{
					conn.close();
					conn = null;
				}
				catch(Exception e){
					logger.fatal("createOutlineComments: " + e.toString());
				}

			} // methodCreatedConnection

		}
		catch(Exception e){
			logger.fatal("createOutlineComments: " + e.toString());
		}

		return outlinesWritten;

	} // createOutlineComments

	public static int createProgramComments(Connection conn,
														String campus,
														String kix,
														boolean doHTM,
														boolean doXML,
														boolean doPDF,
														boolean debug,
														String type,
														boolean showHistory,
														boolean NotApprovedInCC) throws Exception {

		Logger logger = Logger.getLogger("test");

		int programsWritten = 0;

		boolean methodCreatedConnection = false;
		boolean showComments = false;

		String user = "";

		boolean compressed = true;
		boolean print = true;
		boolean detail = false;
		String outputFolder = "ttg";

		String sql = "";

		try{
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			if (conn != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				String server = SysDB.getSys(conn,"server");
				com.ase.aseutil.pdf.Pdf58 makePdf = new com.ase.aseutil.pdf.Pdf58();

				try {

					AseUtil aseUtil = new AseUtil();
					CourseDB courseDB = new CourseDB();

					String campusName = CampusDB.getCampusName(conn,campus);

					String currentDrive = AseUtil.getCurrentDrive();
					String documents = SysDB.getSys(conn,"documents");
					String fileName = currentDrive
												+ ":"
												+ documents
												+ "programs\\"
												+ outputFolder
												+ "\\";

					String htmlHeader = Util.getResourceString("header.ase");
					String htmlFooter = Util.getResourceString("footer.ase");

					sql = "select * from vw_archived_programs where campus=? and type=? and not dateapproved is null  ";
					if(!kix.equals("")){
						sql += " and historyid='"+kix+"'";
					}
					sql += " order by title";

					if(debug){
						logger.info("fileName: " + fileName);
						logger.info("campus: " + campus);
						logger.info("kix: " + kix);
						logger.info("htm: " + doHTM);
						logger.info("xml: " + doXML);
						logger.info("pdf: " + doPDF);
						logger.info("type: " + type);
						logger.info("sql: " + sql);
					}

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						kix = AseUtil.nullToBlank(rs.getString("historyid"));

						String title = AseUtil.nullToBlank(rs.getString("title"));
						String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
						String dateapproved = AseUtil.nullToBlank(rs.getString("dateapproved"));
						if(dateapproved != null && !dateapproved.equals("")){
							dateapproved = aseUtil.ASE_FormatDateTime(dateapproved, 6);
						}
						else{
							dateapproved = "";
						}

						String filecode = campus + "_" + kix;
						String htmlfile = fileName + "htm\\" + type + "\\" + filecode + ".html";
						String xmlfile = fileName + "xml\\" + type + "\\" + filecode + ".xml";

						String checkedName = "";
						String aphist = "";

						if(doHTM)
							checkedName = fileName + "htm\\" + type + "\\" + filecode + ".html";
						else if(doPDF)
							checkedName = fileName + "pdf\\" + type + "\\" + filecode + ".pdf";
						else if(doXML)
							checkedName = fileName + "xml\\" + type + "\\" + filecode + ".xml";

						if(debug){
							logger.info("title: " + title);
							logger.info("proposer: " + proposer);
							logger.info("dateapproved: " + dateapproved);
							logger.info("filecode: " + filecode);
							logger.info("dateapproved: " + dateapproved);
							logger.info("checkedName: " + checkedName);
						}

						File file = new File(checkedName);
						if(!file.exists()){

							try{

								if(doHTM){
									fstream = new FileWriter(htmlfile);
									output = new BufferedWriter(fstream);
									output.write(htmlHeader);
									output.write("<p align=\"center\" class=\"outputTitleCenter\">" + com.ase.aseutil.CampusDB.getCampusName(conn,campus) + "<BR>");
									output.write(title + "</p>");
									String junk = viewProgram(conn,campus,kix,type);
									//junk = Jsoup.parse(junk).text();
									output.write(junk);

									if(showHistory){
										// approval history (source for page is from crsinfy)
										aphist = "<br/>"
											+"<table border=\"0\" width=\"660\" class=\"tableCaption\">"
											+"<tr>"
											+"<td align=\"left\"><hr size=1><a style=\"text-decoration:none\" name=\"approval_history\"  class=\"goldhighlights\">Approval History</a></td>"
											+"</tr>";
										output.write(aphist);

										ArrayList list = HistoryDB.getHistories(conn,kix,type);
										if (list != null){
											History history;
											aphist = "";
											for (int i=0; i<list.size(); i++){
												history = (History)list.get(i);
												aphist += "<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>"
													+ "<tr><td class=\"datacolumn\" valign=top>" + history.getComments() + "</td></tr>";
											}

											if(!aphist.equals("")){
												aphist = "<tr bgcolor=\"#ffffff\">"
													+"<td>"
													+"<table border=\"0\" cellpadding=\"2\" width=\"100%\">"
													+ aphist
													+ "</table>"
													+"</td>"
													+"</tr>";
												output.write(aphist);
											}
										}
										aphist = "</table>";
										output.write(aphist);

										aphist =  "<br>";
										aphist += ""
											+ "<TABLE cellSpacing=0 cellPadding=5 width=\"680\" border=1>"
											+ "<TBODY>"
											+ "<TR>"
											+ "<TD class=\"textblackTH\" width=\"25%\">Proposer:</TD>"
											+ "<TD class=\"dataColumn\" width=\"75%\">"+proposer+"</TD>"
											+ "</TR>"
											+ "<TR>"
											+ "<TD class=\"textblackTH\" width=\"25%\">Approved Date:</TD>"
											+ "<TD class=\"dataColumn\">"+dateapproved+"</TD>"
											+ "</TR>"
											+ "</TBODY>"
											+ "</TABLE>"
											+ "<br><br>";
										output.write(aphist);
									} // showHistory

									output.write(htmlFooter);
								} // doHTM

								if(doXML){
									createXML(conn,outputFolder,campus,"","",kix,type);
								}

								if(doPDF){
									createPDF(filecode,type,"programs");
								} // doPDF

							}
							catch(Exception e){
								logger.info("failed to create outline");
							}
							finally{
								if(doHTM){
									output.close();
								}
							}

							++programsWritten;

						}
						else{
							deleteXML(xmlfile);
						}
						// file exist

					} // while
					rs.close();
					ps.close();

					makePdf = null;
				}
				catch(Exception e){
					logger.info("fail to process data\n" + e.toString());
				}

				// release connection
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					logger.fatal("createProgramComments: " + e.toString());
				}

			} // conm

			// only if the connection was created here
			if (methodCreatedConnection){
				try{
					conn.close();
					conn = null;
				}
				catch(Exception e){
					logger.fatal("createProgramComments: " + e.toString());
				}

			} // methodCreatedConnection

		}
		catch(Exception e){
			logger.fatal("createProgramComments: " + e.toString());
		}

		return programsWritten;

	} // createProgramComments

	public static int createXML(Connection conn,String outputFolder,String campus,String alpha,String num,String kix,String type) throws Exception {

		Logger logger = Logger.getLogger("test");

		org.htmlcleaner.HtmlCleaner cleaner = null;
		org.htmlcleaner.CleanerProperties props = null;
		org.htmlcleaner.TagNode node = null;

		String documentFolder = "";

		boolean foundation = false;

		boolean isAProgram = isAProgram(conn,kix);

		if(!isAProgram){
			foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
		}

		if(foundation){
			documentFolder = "fnd";
		}
		else{
			if (isAProgram){
				documentFolder = "programs";
			}
			else{
				documentFolder = "outlines";
			}
		}

		String outlineName = AseUtil.getCurrentDrive()
							+ ":"
							+ SysDB.getSys(conn,"documents")
							+ documentFolder
							+ "\\"
							+ outputFolder
							+ "\\";

		String htmFile = outlineName + "htm\\" + type + "\\" + campus + "_" + alpha + "_" + num + "_" + kix + ".html";
		String xmlFile = outlineName + "xml\\" + type + "\\" + campus + "_" + alpha + "_" + num + "_" + kix + ".xml";

		if (isAProgram){
			htmFile = outlineName + "htm\\" + type + "\\" + campus + "_" + kix + ".html";
			xmlFile = outlineName + "xml\\" + type + "\\" + campus + "_" + kix + ".xml";
		}

		try{
			cleaner = new org.htmlcleaner.HtmlCleaner();

			props = cleaner.getProperties();

			props.setUseCdataForScriptAndStyle(true);
			props.setRecognizeUnicodeChars(true);
			props.setUseEmptyElementTags(true);
			props.setAdvancedXmlEscape(false);
			props.setTranslateSpecialEntities(true);
			props.setBooleanAttributeValues("empty");

			node = cleaner.clean(new File(htmFile));
			new org.htmlcleaner.PrettyXmlSerializer(props).writeXmlToFile(node, xmlFile);

			cleaner = null;
			props = null;
			node = null;
		}
		catch(Exception e){
			logger.info("createXML: " + e.toString());
		}

		return 0;

	}

	public static int createPDF(String filecode,String type,String src) throws Exception {

		Logger logger = Logger.getLogger("test");

		int pdfCreated = 0;

		String XML = "C:/tomcat/webapps/centraldocs/docs/"+src+"/ttg/xml/"+type+"/"+filecode+".xml";
		String PDF = "C:/tomcat/webapps/centraldocs/docs/"+src+"/ttg/pdf/"+type+"/"+filecode+".pdf";
		String CSS = "C:/tomcat/webapps/central/inc/style.css";

		try{

			File file = new File(XML);
			if(file.exists()){
				// step 1
				Document document = new Document();
				// step 2
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(PDF));
				writer.setInitialLeading(12.5f);

				// step 3
				document.open();

				// CSS
				CSSResolver cssResolver = new StyleAttrCSSResolver();
				CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(CSS));
				cssResolver.addCss(cssFile);

				HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
				htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

				// Pipelines
				PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
				HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
				CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

				// XML Worker
				XMLWorker worker = new XMLWorker(css, true);
				XMLParser p = new XMLParser(worker);
				p.parse(new FileInputStream(XML));

				// step 5
				document.close();

				writer.close();

				try{
					file.delete();
				}
				catch(Exception e){
					logger.fatal("Unable to delete " + XML + "\n" + e.toString());
				}

				pdfCreated = 1;
			} // if
			file = null;
		}
		catch(Exception e){
			logger.info("createPDF: " + XML);
			logger.info("createPDF: " + PDF);
			logger.info("createPDF: " + e.toString());
		}
		finally{
		}

		return pdfCreated;

	}

	// deleteXML
	public static boolean deleteXML(String xmllfile) throws Exception {

		Logger logger = Logger.getLogger("test");

		boolean deleted = false;

		try{
			File file = new File(xmllfile);
			if(file.exists()){
				deleted = file.delete();
			} // if
			file = null;
		}
		catch(Exception e){
			logger.info("deleteXML: " + xmllfile);
		}
		finally{
			//
		}

		return deleted;

	}

	/*
	 * hasScriptTag
	 *	<p>
	 *	@return	boolean
	 *	<p>
	 */
	public static boolean hasScriptTag(String content) throws Exception {

		content = content.replace("<SCRIPT","<script").replace("</SCRIPT","</script");

		boolean found = false;

		found = false;

		Pattern script = Pattern.compile("<script.*?>.*?</script>");

		Matcher mscript = script.matcher(content);

		while (mscript.find() && !found){
			found = true;
		}

		return found;

	}

	/*
	 * removeJavaScriptTags - remove script tags from content
	 *	<p>
	 * @param	content	String
	 *	<p>
	 * @return String
	 */
	public static String removeJavaScriptTags(String content) throws Exception {

		Logger logger = Logger.getLogger("test");

		int start = 0;
		int end = 0;
		String left = null;
		String right = null;

		try{
			// script tags come following format:
			// &lt;SCRIPT src="some-crappy-site"&gt;&lt;/SCRIPT&gt;

			// remove the start and up to the first &gt; symbol.
			// repeat until all gone the do the same for the end tag

			if (content==null || content.length() == 0)
				content = "";

			start = content.toLowerCase().indexOf("<script");
			while (start != - 1){
				end = content.toLowerCase().indexOf(">",start)+1;
				left = content.substring(0,start-1);
				right = content.substring(end,content.length());
				content = left + right;
				start = content.toLowerCase().indexOf("<script");
			}

			start = content.toLowerCase().indexOf("</script");
			while (start != - 1){
				end = content.toLowerCase().indexOf(">",start)+1;
				left = content.substring(0,start-1);
				right = content.substring(end,content.length());
				content = left + right;
				start = content.toLowerCase().indexOf("</script");
			}
		} catch (Exception e) {
			logger.fatal("SQLUtil: removeJavaScriptTags - " + e.toString());
		}

		return content;
	}

	/**
	 * viewProgram
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * @param	type
	 * <p>
	 * @return	String
	 */
	public static String viewProgram(Connection conn,String campus,String kix,String type) {

		Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();
		String t1 = "";
		String t2 = "";
		String t3 = "";
		String temp = "";

		String question = null;

		int i = 0;

		String row1 = "<tr>"
			+"<td height=\"20\" class=textblackTH width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" width=\"98%\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" width=\"98%\" valign=\"top\"><| answer |></td>"
			+"</tr>";

		String extra = "<tr>"
			+"<td height=\"20\" colspan=\"2\" valign=\"top\">"
			+ "<fieldset class=\"FIELDSET100\"><legend>Other Departments</legend><| extra |></fieldset><br/>"
			+ "</td>"
			+"</tr>";

		try{
			String auditby = "";
			String auditdate = "";
			String title = "";
			String effectiveDate = "";
			String description = "";
			String degreeDescr = "";
			String divisionDescr = "";
			int degree = 0;
			int division = 0;

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if (!"".equals(kix)){
				Programs program = getProgram(conn,campus,kix);
				if ( program != null ){
					title = program.getTitle();
					effectiveDate  = program.getEffectiveDate();
					description = program.getDescription();
					degreeDescr = program.getDegreeDescr();
					divisionDescr = program.getDivisionDescr();
					auditby = program.getAuditBy();
					auditdate = program.getAuditDate();
					degree = program.getDegree();
					division = program.getDivision();

					output.append("<table width=\"100%\" summary=\"ase1\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Degree:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + degreeDescr + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Division:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + divisionDescr + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Title:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + title + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Description:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + description + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Effective Date:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + effectiveDate + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td colspan=\"2\"><br/><hr size=\"1\"></td>"
						+ "</tr>"
						+ "</table>");

					ArrayList answers = getProgramAnswers(conn,campus,kix,type);
					ArrayList columns = getColumnNames(conn,campus);

					String column = "";

					if (answers != null){

						i = 0;

						output.append("<table summary=\"ase2\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">");

						// in create mode, LEE only prints 7
						boolean isNewProgram = false;
						isNewProgram = isNewProgram(conn,campus,title,degree,division);
						int itemsToPrint = answers.size();

						if (isNewProgram && "LEE".equals(campus))
							itemsToPrint = Constant.PROGRAM_ITEMS_TO_PRINT_ON_CREATE;

						String sql = "SELECT questionseq,question FROM tblProgramQuestions "
										+ "WHERE campus=? AND include='Y' ORDER BY questionseq";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ResultSet rs = ps.executeQuery();
						while(rs.next() && i < itemsToPrint){
							t1 = row1;
							t1 = t1.replace("<| counter |>",AseUtil.nullToBlank(rs.getString("questionseq")));
							t1 = t1.replace("<| question |>",AseUtil.nullToBlank(rs.getString("question")));
							output.append(t1);

							t2 = row2;
							t2 = t2.replace("<| answer |>",(String)answers.get(i));

							output.append(t2);

							column = (String)columns.get(i);

							String enableOtherDepartmentLink = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOtherDepartmentLink");
							if ((Constant.ON).equals(enableOtherDepartmentLink)){
								if (column != null && column.indexOf(Constant.PROGRAM_RATIONALE) > -1){
									temp = ExtraDB.getOtherDepartments(conn,
																					Constant.PROGRAM_RATIONALE,
																					campus,
																					kix,
																					false,
																					true);

									if (temp != null && temp.length() > 0){
										t3 = extra;
										t3 = t3.replace("<| extra |>",temp);
										output.append(t3);
									} // temp
								} // PROGRAM_RATIONALE
							} // enableOtherDepartmentLink

							++i;
						}
						rs.close();
						ps.close();

						output.append("</table>");

					} // answers != null

					String attachments = listProgramAttachments(conn,campus,kix);
					if (attachments != null && attachments.length() > 0){
						output.append("<table summary=\"ase3\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\"><tr><td>");
						output.append("<fieldset class=\"FIELDSET100\">"
							+ "<legend>Attachments</legend>"
							+ Html.BR()
							+ attachments
							+ "</fieldset>" );
							output.append("</td></tr></table>");
					}

					String outineSubmissionWithProgram = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutineSubmissionWithProgram");
					int counter = ProgramsDB.countPendingOutlinesForApproval(conn,campus,division);
					if (outineSubmissionWithProgram.equals(Constant.ON) && counter > 0){
						output.append("<table summary=\"ase4\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\"><tr><td>");
						output.append("<fieldset class=\"FIELDSET100\">"
							+ "<legend>Outlines Associated with this Program</legend>"
							+ Html.BR()
							+ Helper.listOutlinesForSubmissionWithProgram(conn,campus,division)
							+ "</fieldset>" );
							output.append("</td></tr></table>");
					}

					output.append("<table summary=\"ase5\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr>"
						+ "<td colspan=\"2\"><br/><hr size=\"1\"></td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Campus:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + campus + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Updated By:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + auditby + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Updated Date:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + auditdate + "</td>"
						+ "</tr>"
						+ "</table>");

					temp = "<table summary=\"ase6\" border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>"
							+ "<tr><td>"
							+ output.toString()
							+ "</td></tr>"
							+ "</table>";
				} // program != null
			} // kix != null

		} catch (SQLException e) {
			logger.fatal("OutlinesWithComments: viewProgram - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("OutlinesWithComments: viewProgram - " + ex.toString());
		}

		return temp;
	}

	/*
	 * Returns true if the kix is a program
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 */
	public static boolean isAProgram(Connection conn,String kix) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean isPogram = false;

		try {
			String sql = "SELECT degreeid FROM tblPrograms WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			isPogram = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("OutlinesWithComments: isAProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("OutlinesWithComments: isAProgram - " + e.toString());
		}

		return isPogram;
	}

	/**
	 * getProgram
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	Programs
	 */
	public static Programs getProgram(Connection conn,String campus,String kix) {

		Logger logger = Logger.getLogger("test");

		String sql = "SELECT * "
					+ "FROM vw_ProgramForViewing "
					+ "WHERE campus=? "
					+ "AND historyid=?";

		Programs program = null;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				program = new Programs();
				program.setAuditBy(AseUtil.nullToBlank(rs.getString("Updated By")));

				AseUtil aseUtil = new AseUtil();
				program.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("Updated Date"),Constant.DATE_DATETIME));

				program.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				program.setDegree(rs.getInt("degreeid"));
				program.setDegreeDescr(AseUtil.nullToBlank(rs.getString("degreeTitle")));
				program.setDegreeTitle(AseUtil.nullToBlank(rs.getString("degreeTitle")));
				program.setDescription(AseUtil.nullToBlank(rs.getString("descr")));
				program.setDivision(rs.getInt("divisionid"));
				program.setDivisionDescr(AseUtil.nullToBlank(rs.getString("divisionname")));
				program.setDivisionName(AseUtil.nullToBlank(rs.getString("divisionname")));
				program.setEffectiveDate(AseUtil.nullToBlank(rs.getString("Effective Date")));
				program.setDescription(AseUtil.nullToBlank(rs.getString("descr")));
				program.setHistoryId(AseUtil.nullToBlank(rs.getString("historyid")));
				program.setProgram(AseUtil.nullToBlank(rs.getString("program")));
				program.setProgress(AseUtil.nullToBlank(rs.getString("progress")));
				program.setProposer(AseUtil.nullToBlank(rs.getString("proposer")));
				program.setRoute(rs.getInt("route"));
				program.setSubProgress(AseUtil.nullToBlank(rs.getString("subprogress")));
				program.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				program.setType(AseUtil.nullToBlank(rs.getString("type")));

				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("OutlinesWithComments: getProgram - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("OutlinesWithComments: getProgram - " + ex.toString());
		}

		return program;
	}

	/*
	 * Returns true if the program exists in a particular title and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	title		String
	 * @param	degree	int
	 * @param	division	int
	 * <p>
	 */
	public static boolean isNewProgram(Connection conn,String campus,String title,int degree,int division) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean newProgram = false;

		try {
			String sql = "SELECT COUNT(degreeid) AS counter "
							+ "FROM tblPrograms "
							+ "WHERE campus=? "
							+ "AND title=? "
							+ "AND degreeid=? "
							+ "AND divisionid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,title);
			ps.setInt(3,degree);
			ps.setInt(4,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				int count = rs.getInt("counter");

				// there should only be 1 returned record to be new
				if (count == 1)
					newProgram = true;
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("OutlinesWithComments: isNewProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("OutlinesWithComments: isNewProgram - " + e.toString());
		}

		return newProgram;
	}

	/**
	 * getColumnNames
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList getColumnNames(Connection conn,String campus) {

		Logger logger = Logger.getLogger("test");

		ArrayList<String> columns = new ArrayList<String>();

		String sql = "SELECT Field_Name "
					+ "FROM vw_programitems "
					+ "WHERE campus=? "
					+ "AND include='Y' "
					+ "AND seq>0 "
					+ "ORDER BY Seq";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				columns.add(AseUtil.nullToBlank(rs.getString("Field_Name")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("OutlinesWithComments: getColumnNames - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("OutlinesWithComments: getColumnNames - " + ex.toString());
		}

		return columns;
	}

	/**
	 * getProgramAnswers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList getProgramAnswers(Connection conn,String campus,String kix,String type) {

		Logger logger = Logger.getLogger("test");

		ArrayList<String> answers = null;

		int numberOfAnswers = 0;
		String questions = "";

		boolean writeFile = true;
		FileWriter fstream1 = null;
		FileWriter fstream2 = null;

		BufferedWriter output1 = null;
		BufferedWriter output2 = null;

		try{
			questions = QuestionDB.getProgramColumns(conn,campus);

			if(writeFile){
				fstream1 = new FileWriter("C:\\tomcat\\webapps\\centraldocs\\docs\\programs\\ttg\\htm\\CUR\\log1.txt");
				output1 = new BufferedWriter(fstream1);

				fstream2 = new FileWriter("C:\\tomcat\\webapps\\centraldocs\\docs\\programs\\ttg\\htm\\CUR\\log2.txt");
				output2 = new BufferedWriter(fstream2);
			}

			if (questions != null){
				String sql = "SELECT " + questions + " FROM tblPrograms WHERE campus=? AND historyid=? AND type=?";
				numberOfAnswers = ProgramsDB.countProgramQuestions(conn,campus);
				if (numberOfAnswers > 0){
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,type);
					ResultSet rs = ps.executeQuery();
					if(rs.next()){
						answers = new ArrayList<String>();
						String[] aQuestions = questions.split(",");
						for(int i=0; i<numberOfAnswers; i++){
							String html = AseUtil.nullToBlank(rs.getString(aQuestions[i]));

							html = takeAwayHTML(html);

							if(writeFile){
								if(i==0) output1.write(html);
							}

							org.jsoup.nodes.Document doc = Jsoup.parse(html);
							org.jsoup.select.Elements el = doc.getAllElements();
							for (org.jsoup.nodes.Element e : el) {
								 org.jsoup.nodes.Attributes at = e.attributes();
								 for (org.jsoup.nodes.Attribute a : at) {
									  e.removeAttr("style");
									  e.removeAttr("type");
								 }
							}
							html = doc.html();
							html = putBackHTML(html);
							html = removeHeaderHTML(html);

							if(writeFile){
								if(i==0) output2.write(html);
							}

							answers.add(html);
						}
					}
					rs.close();
					ps.close();

					if(writeFile){
						output1.close();
						output2.close();
					}

				}
			} // questions != null

		} catch (SQLException e) {
			logger.fatal("ProgramsDB.getProgramAnswers\n" + questions + "\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB.getProgramAnswers\n" + questions + "\n" + e.toString());
		}

		return answers;
	}

	public static String takeAwayHTML(String html){

		//.replace("<b","$ob$<b")
		//.replace("<u","$ou$<u")
		//.replace("<i","$oi$<i")

		return html.replace(" class=\"MsoNormal\"","")
			.replace("</p>","$n$")
			.replace("</tr>","$n$")
			.replace("<b>","$ob$").replace("</b>","$cb$")
//.replace("<b ","$ob$~b~ ")
			.replace("<i>","$oi$").replace("</i>","$ci$")
//.replace("<i ","$oi$~i~ ")
			.replace("<li>","$li$").replace("</li>","$il$")
//.replace("<li ","$li$~li~ ")
			.replace("<ol>","$ol$").replace("</ol>","$lo$")
//.replace("<ol ","$ol$~ol~ ")
			.replace("<ul>","$ul$").replace("</ul>","$lu$")
//.replace("<ul","$ul$~ul~")
			.replace("<strike>","$ostrike$").replace("</strike>","$cstrike$")
			;
	}

	public static String putBackHTML(String html){

		// order of appearance is important here

		return html.replace("$n$","\n")
//.replace("$ob$~b~ ","<b>")
			.replace("$ob$","<b>").replace("$cb$","</b>")
//.replace("$oi$~i~ ","<i>")
			.replace("$oi$","<i>").replace("$ci$","</i>")
//.replace("$li$~li~ ","<li>")
			.replace("$li$","<li>").replace("$il$","</li>")
//.replace("$ol$~ol~ ","<ol>")
			.replace("$ol$","<ol>").replace("$lo$","</ol>")
//.replace("$ul$~ul~","<ul>")
			.replace("$ul$","<ul>").replace("$lu$","</ul>")
			.replace("$ostrike$","<strike>").replace("$cstrike$","</strike>")
			;

	}

	public static String removeHeaderHTML(String html){

		return html.replace("<html>","")
			.replace("<head></head>","")
			.replace("<body>","")
			.replace("</body>","")
			.replace("</html>","")
			;

	}

	public static Msg viewOutline(Connection conn,
											String kix,
											String user,
											boolean compressed,
											boolean print,
											boolean html,
											boolean detail) throws Exception {

		int section = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String type = info[2];

		if (type.equals("ARC"))
			section = Constant.COURSETYPE_ARC;
		else if (type.equals("CAN"))
			section = Constant.COURSETYPE_CAN;
		else if (type.equals("CUR"))
			section = Constant.COURSETYPE_CUR;
		else if (type.equals("PRE"))
			section = Constant.COURSETYPE_PRE;

		Msg msg = viewOutline(conn,kix,section,user,compressed,print,html,detail);

		return msg;
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											int section,
											String user,
											boolean compressed,
											boolean print,
											boolean html,
											boolean detail) throws Exception {

		Logger logger = Logger.getLogger("test");

		String row1 = "<tr>"
			+"<td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" valign=\"top\"><| answer |></td>"
			+"</tr>";

		String xml = "<item>\n"
			+"<counter><| counter |>.</counter>\n"
			+"<question><| question |></question>\n"
			+"<answer><| answer |></answer>\n"
			+"</item>\n";

		StringBuffer buf = new StringBuffer();
		Msg msg = new Msg();

		//
		// for xml output
		//
		//StringBuffer xbuf = new StringBuffer();

		int i = 0;

		String t1 = "";
		String t2 = "";
		String x = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		String question = "";										// item question
		String temp = "";												// date for processing

		AseUtil aseUtil = new AseUtil();

		int step = 1;

		String[] columns = QuestionDB.getCampusColumms(conn,campus).split(",");
		String[] data = null;

		step = 2;

		String history = "";

		try {

			int courseItems = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			// which question to display
			String headerText = 	IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableHeaderText");

			if(headerText.equals(Constant.ON)){
				headerText = "headertext";
			}
			else{
				headerText = "question";
			}

			// clear any old reported data
			// not using at this time since we are not able to generate pdfs
			//PDFDB.delete(conn,user,"Outline");
			step = 3;

			// any sticky notes added
			MiscDB.deleteStickyMisc(conn,kix,user);
			step = 4;

			// collect outline questions and answers
			data = getOutlineData(conn,kix,section,user,false,compressed);
			step = 5;

			if (data != null){
				step = 6;

				// used for detail display of comments
				int loopCounter = 0;
				int table = 1;

				// clear place holder or items without any data from the template
				for(i=0;i<data.length;i++){
					t1 = row1;
					t2 = row2;

					x = xml;

					if(detail){

						++loopCounter;

						int questionNumber = QuestionDB.getQuestionNumber(conn,campus,table,loopCounter);

						history = "<table summary=\"\" style=\"border: 1px solid #fad163\" width=\"98%\"><tr><td>"
							+ ReviewerDB.getReviewHistory(conn,kix,questionNumber,campus,table,0)
							+ "</td></tr></table><br><br>";

						//
						// at max course items, reset and go to campus items
						//
						if(loopCounter == courseItems){
							table = 2;
							loopCounter = 0;
						}
					}

					question = aseUtil.lookUp(conn, "vw_AllQuestions", headerText, "campus='" + campus + "' AND question_friendly = '" + columns[i] + "'" );
					if (question != null){
						t1 = t1.replace("<| counter |>",(""+(i+1)));
						t1 = t1.replace("<| question |>",question+"<br><br>");
						t2 = t2.replace("<| answer |>",data[i]+"<br><br>" + history);

						buf.append(t1);
						buf.append(t2);

						step = 7;
					}
				}

				if (attachmentExists(conn,kix)){
					step = 8;
					t1 = "<tr>"
						+"<td height=\"20\" colspan=\"2\" class=\"textblackTH\" valign=\"top\">Attachments<br><br></td>"
						+"</tr>";
					t2 = row2;
					//t2 = t2.replace("<| answer |>",getAttachmentAsHTMLList(conn,kix)+"<br><br>");
					t2 = t2.replace("<| answer |>","||_attachment_||<br><br>");
					buf.append(t1);
					buf.append(t2);
					step = 9;
				}

				temp = "<table summary=\"\" id=\"tableViewOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ buf.toString() + "</table>";

				// if not printing, and not creating HTML don't do sticky notes
				if (!print && !html){
					temp += MiscDB.getStickyNotes(conn,kix,user);
				}

				// determine whether we want ease of reading or crunched up HTML
				String appendNewLineToHTML = SysDB.getSys(conn,"appendNewLineToHTML");
				if (appendNewLineToHTML.equals(Constant.ON)){
					temp = temp.replace("</table>","\n</table>\n");
					temp = temp.replace("</tr>","</tr>\n");
					temp = temp.replace("</td>","</td>\n");

					temp = temp.replace("<ul>","\n<ul>\n");
					temp = temp.replace("</ul>","\n</ul>\n");

					temp = temp.replace("</li>","</li>\n");
				}

				// this is the returned data
				msg.setErrorLog(temp);

				// any sticky notes added
				MiscDB.deleteStickyMisc(conn,kix,user);
				step = 10;

			} // if (data != null)

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: viewOutline - " + e.toString() + "\nStep = " + step);
		}

		return msg;
	}

	/*
	 * getOutlineData - returns an outline data in a string array
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixSource	String
	 *	@param	section	int
	 *	@param	user		String
	 *	@param	compare	boolean
	 *	<p>
	 * @return Msg
	 */
	public static String[] getOutlineData(Connection conn,String kix,int section,String user,boolean compare,boolean compressed) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		if (campus == null || campus.length() == 0){
			info = Helper.getKixInfoFromOldCC(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}

		String line = "";												// input line
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";
		String tableCampus = "tblCampusData";

		// when comparing outlines side by side
		if (compare){
			table = "tblCourseCC2";
			tableCampus = "tblCampusDataCC2";
		}

		AseUtil aseUtil = new AseUtil();

		String[] data = null;

		int i = 0;

		try {
			String[] c1 = null;
			String[] c2 = null;

			String x1 = "";
			String x2 = "";

			String[] columns = null;

			// collect all columns from course and campus table
			String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
			f1 = AseUtil.nullToBlank(f1);

			String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
			f2 = AseUtil.nullToBlank(f2);

			// course items may not be empty
			if (!f1.equals(Constant.BLANK)){

				// combine columns (f1 & f2) into a single list
				c1 = f1.split(",");

				// make sure there is data
				if (!f2.equals(Constant.BLANK)){
					c2 = f2.split(",");
					columns = (f1 + "," + f2).split(",");
				}
				else{
					columns = f1.split(",");
				}

				// holder for resulting data from select statement
				data = new String[columns.length];

				// append to columns with aliasing for select statement below
				x1 = "c." + f1.replace(",",",c.");

				if (!f2.equals(Constant.BLANK)){
					x2 = "," + "s." + f2.replace(",",",s.");
				}

				temp = f1;

				switch (section) {
					case Constant.COURSETYPE_ARC:
						table = "tblCourseARC";
						break;
					case Constant.COURSETYPE_CAN:
						table = "tblCourseCAN";
						break;
					case Constant.COURSETYPE_CUR:
						break;
					case Constant.COURSETYPE_PRE:
						break;
				} // switch

				// select is now in proper format
				sql = "SELECT " + x1 + x2 + " "
					+ "FROM " + table + " c LEFT OUTER JOIN " + tableCampus + " s ON c.historyid = s.historyid "
					+ "WHERE c.historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					for(i=0;i<columns.length;i++){

						temp = AseUtil.nullToBlank(rs.getString(columns[i]));
						temp = Html.fixHTMLEncoding(temp);
						temp = formatOutline(conn,columns[i],campus,alpha,num,type,kix,temp,compressed,user);

						// data has faulty list tags should be removed
						temp = temp.replace("<ul></ul>","");

						if (temp != null && temp.length() > 0){
							data[i] = temp;
						}
						else{
							data[i] = "";
						}

					}	// for

				}	// if
				rs.close();
				ps.close();
			} // f1 != null && f2 != null

		} catch (SQLException se) {
			logger.fatal("Outlines: getOutlineData - " + se.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: getOutlineData - " + e.toString());
		}

		return data;
	} // getOutlineData

	/*
	 * formatOutline
	 *	<p>
	 * @param	conn			Connection
	 * @param	column		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * @param	kix			String
	 * @param	temp			String
	 * @param	compressed	boolean
	 * @param	user			String
	 * @param	catalog		boolean
	 *	<p>
	 * @return StringBuffer
	 */
	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp,
													boolean compressed,
													String user) throws Exception {

		return formatOutline(conn,column,campus,alpha,num,type,kix,temp,compressed,user,false);

	}

	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp,
													boolean compressed,
													String user,
													boolean catalog) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		int j = 0;
		String junk = "";
		String line = "";
		String[] reuse;

		String lookupData[] = new String[2];
		String questionData[] = new String[2];
		String lookUpCampus = "campus='"+campus+"' AND type='Campus' AND question_friendly='__'";
		String lookUpSys = "campus='SYS' AND type='Course' AND question_friendly='__'";
		String explainField = "";
		String explainSQL = "historyid=" + aseUtil.toSQL(kix,1);

		String department = "";

		boolean debug = false;

		String formattedText = "";

		String textToAppend = "";

		try{

			String fieldRef = "";
			//
			// clean up what we know as bad data
			//
			temp = cleansData(column,temp);

			// look up the reference for retrieval of checklist/radio data.
			// if not found as a campus item, then it's likely to be a system item
			junk = lookUpCampus;
			junk = junk.replace("__",column);
			questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
			if (questionData[0].equals("NODATA")){
				junk = lookUpSys;
				junk = junk.replace("__",column);
				questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
				if(questionData != null && questionData.length > 1){
					fieldRef = questionData[1];
				}
			}

			// for items with an explanation, look up the column holding the explanation
			// and print after the content.
			explainField = CCCM6100DB.getExplainColumnValue(conn,column);

			if (debug){
				logger.info("-------------------- formatOutline");
				logger.info("column: " + column);
				logger.info("explainField: " + explainField);
				logger.info("questionData[0]: " + questionData[0]);
				logger.info("questionData[1]: " + questionData[1]);
				logger.info("fieldRef: " + fieldRef);
				logger.info("temp: " + temp);
			}

			// ----------------------------------------------------
			// primary data
			// ----------------------------------------------------
			if (column.indexOf("date") > -1) {
				formattedText = aseUtil.ASE_FormatDateTime(temp, 6);
			}
			else if (questionData[0].equals("check")) {

				// take apart semester from CSV format and lookup actual value
				// using campus, category and id

				if (	column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_1) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_2) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_3) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_1) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_2) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_3) ||
						fieldRef.contains("UserDefinedControl_X")
					){

					if(temp != null && temp.length() > 0){

						questionData[0] = "";

						//
						// the ~~0 exists when working with multi-value but does
						// not apply to these puppies
						//
						reuse = temp.replace("~~0","").split(",");

						// retrive system settings with values saved as ids
						if (NumericUtil.isInteger(reuse[j])){

							for(j=0;j<reuse.length;j++){

								if (NumericUtil.getInt(reuse[j],0) > 0){
									junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
									lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
									junk = lookupData[1];
									if (junk != null && junk.length() > 0){
										if (questionData[0].equals(Constant.BLANK))
											questionData[0] = "<li class=\"datacolumn\">" + junk + "</li>";
										else
											questionData[0] = questionData[0] + "<li class=\"datacolumn\">" + junk + "</li>";
									} // if

								} // valid number

							} // for

						} // if reuse

						formattedText = "<ul>" + questionData[0] + "</ul>";

					}
					else{
						formattedText = "";
					}
					// we have data

				}
				else if (column.equals(Constant.COURSE_CCOWIQ)) {
					formattedText = CowiqDB.drawCowiq(conn,campus,kix,true);
				}
				else if (column.equals(Constant.COURSE_FUNCTION_DESIGNATION)) {
					formattedText = FunctionDesignation.drawFunctionDesignation(conn,campus,temp,true);
				}
				else if (column.equals(Constant.COURSE_GENCORE)) {
					formattedText = temp;
				}
				else{
					/*
						if we find ~~ in the fieldValue, it's because we are storing
						double values between commas.

						for example, 869~~5,870~~10,871~~15,872~~3 is similar to

						869,5
						870,10
						871,15
						872,3

						four sets of data as CSV

						this section of code breaks CSV into sub CSV and assign
						accordingly.

						for contact hours, we include a drop down list of hours for selection.

						lookupX returns array of 2 values. in this case, the start and ending
						values for the list range
					*/

					formattedText = com.ase.aseutil.util.CCUtil.removeDoubleCommas(temp);

					if (formattedText != null && !formattedText.equals(Constant.BLANK)){

						String dropDownValues = "";
						String[] aDropDownValues = null;
						boolean includeRange = IniDB.showItemAsDropDownListRange(conn,campus,"NumberOfContactHoursRangeValue");
						if(formattedText.indexOf(Constant.SEPARATOR)>-1 || includeRange){

							int junkInt = 0;
							int tempInt = 0;
							String[] tempString = null;
							String[] junkString = null;

							// if statement splits when there is data. else statement sets all to zero.
							if(formattedText.indexOf(Constant.SEPARATOR)>-1){

								String[] split = SQLValues.splitMethodEval(formattedText);
								if (split != null){
									formattedText = split[0];
									dropDownValues = split[1];
								}

							}
							else{
								tempString = formattedText.split(",");
								tempInt = tempString.length;

								for(junkInt = 0; junkInt<tempInt; junkInt++){
									if (junkInt == 0)
										dropDownValues = "0";
									else
										dropDownValues = dropDownValues + ",0";
								} // for
							}

							aDropDownValues = dropDownValues.split(",");

						} // (formattedText.indexOf(Constant.SEPARATOR)>-1)

						questionData[0] = "";
						reuse = formattedText.split(",");

						// retrive system settings with values saved as ids
						if (NumericUtil.isInteger(reuse[j])){

							for(j=0;j<reuse.length;j++){

								if (NumericUtil.getInt(reuse[j],0) > 0){

									junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
									lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
									junk = lookupData[1];
									if (junk != null && junk.length() > 0){

										if (includeRange && aDropDownValues[j] != null)
											junk = junk + " (" + aDropDownValues[j] + ")";

										if ("".equals(questionData[0]))
											questionData[0] = "<li class=\"datacolumn\">" + junk + "</li>";
										else
											questionData[0] = questionData[0] + "<li class=\"datacolumn\">" + junk + "</li>";
									} // if

								} // valid number

							} // for

						} // if reuse

						formattedText = "<ul>" + questionData[0] + "</ul>";

						if (column.equals(Constant.COURSE_METHODEVALUATION)){

							// TO DO - hard coding
							if (campus.equals(Constant.CAMPUS_UHMC)){
								formattedText = formattedText + "<br>" + Outlines.showMethodEval(conn,campus,kix);
							}

							formattedText = formattedText
								+ "<br>"
								+ printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
						}

					} // formattedText != null

				} // ccowiq

			} // check
			else if (questionData[0].equals("radio")) {

				if (	column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_1) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_2) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_3) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_1) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_2) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_3) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_4) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_5) ||
						fieldRef.contains("UserDefinedControl_X")
						){
					formattedText = IniDB.getKdesc(conn,temp);
				}
				else if (column.equalsIgnoreCase(Constant.COURSE_REASONSFORMODS)){
					formattedText = IniDB.getKdesc(conn,temp);
				}
				else if (questionData[1].indexOf("CONSENT") > -1){

					//
					// pre req consent
					//
					String displayOrConsentForPreReqs = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");
					if (questionData[1].equals("CONSENTPREREQ") && displayOrConsentForPreReqs.equals(Constant.ON)){
						formattedText = Outlines.drawPrereq(kix,temp,"",true);
					}
					else if (questionData[1].equals("CONSENTCOREQ")){
						if (debug) logger.info("CONSENTCOREQ");

						// does not exist for coreq
						//formattedText = AseUtil.expandText(temp,"Consent: YES","Consent: NO","");
					}

					//
					// course mod consent
					//
					String displayConsentForCourseMods = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayConsentForCourseMods");
					if (displayConsentForCourseMods.equals(Constant.OFF)){
						formattedText = "";
					}
					if (debug) logger.info("displayConsentForCourseMods: " + displayConsentForCourseMods);

					//
					// pre cor/req
					//
					if (column.equals(Constant.COURSE_PREREQ)){
						formattedText = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,kix);
						textToAppend = AseUtil.expandText(temp,"YES","NO","");
					}
					else if (column.equals(Constant.COURSE_COREQ)){
						formattedText = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,kix);

						if(formattedText != null && formattedText.length() > 0){
							textToAppend = "YES";
						}
						else{
							textToAppend = AseUtil.expandText(temp,"YES","NO","");
						}
					}

					if (debug) logger.info("formattedText: " + formattedText);
				}
				else if (questionData[1].equalsIgnoreCase("status")){
					formattedText = AseUtil.expandText(temp,"Active","Inactive","Inactive");
				}
				else if (questionData[1].equalsIgnoreCase("YESNO")){
					formattedText = AseUtil.expandText(temp,"YES","NO","");

					// if cross listed and there is data, just display data without yes/no
					if (column.equalsIgnoreCase("crosslisted")){
						junk = CourseDB.getCrossListing(conn,kix);

						if (junk != null && junk.length() > 0)
							formattedText = junk;
						else
							formattedText = formattedText + "<br>" + junk;
					}
				}
			} // radio
			else if (column.equals("division")) {
				formattedText = DivisionDB.getDivision(conn,campus,temp);
			}
			else if (column.equals("excluefromcatalog")) {
				formattedText = AseUtil.expandText(temp,"YES","NO","NO");
			}
			else if (column.equals("effectiveterm") && temp != null && temp.length() > 0) {
				formattedText = TermsDB.getTermDescription(conn, temp);
			}
			else if (column.equals(Constant.COURSE_OBJECTIVES)) {
				formattedText = printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_CONTENT)) {
				if(catalog){
					textToAppend = "";
					formattedText = temp + ContentDB.getContentAsHTMLList(conn,campus,alpha,num,Constant.CUR,kix,false,false);
				}
				else{
					formattedText = printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
					textToAppend = temp;
				}
			}
			else if (column.equals(Constant.COURSE_COMPETENCIES)) {
				if(catalog){
					textToAppend = "";
					formattedText = temp + CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
				}
				else{
					formattedText = printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
					textToAppend = temp;
				}
			}
			else if (column.equals(Constant.COURSE_EXPECTATIONS)) {
				formattedText = IniDB.getIniByCategory(conn,campus,"Expectations",temp,true);
			}
			else if (column.equals(Constant.COURSE_GESLO)) {

				String gesloText = "";
				String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
				if(useGESLOGrid.equals(Constant.ON)){
					gesloText = GESLODB.getGESLO(conn,campus,kix,true) + "<br>";
				}

				formattedText = gesloText
						+ printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);

			}
			else if (column.equals(Constant.COURSE_RECPREP)) {
				formattedText = ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_OTHER_DEPARTMENTS)) {

				String enableOtherDepartmentLink = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOtherDepartmentLink");
				if (enableOtherDepartmentLink.equals(Constant.ON)){
					formattedText = ExtraDB.getOtherDepartments(conn,
																				Constant.COURSE_OTHER_DEPARTMENTS,
																				campus,
																				kix,
																				false,
																				false);
					textToAppend = temp;
				}

			}
			else if (column.equals(Constant.COURSE_PROGRAM)) {
				formattedText = ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,false);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_PROGRAM_SLO)) {
				formattedText = printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_INSTITUTION_LO)) {
				formattedText = printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_TEXTMATERIAL)) {
				formattedText = TextDB.getTextAsHTMLList(conn,kix);
				textToAppend = temp;
			}
			else{
				formattedText = temp;
			} // column

			// ----------------------------------------------------
			// explained data
			// ----------------------------------------------------
			if(explainField != null && explainField.length() > 0 && CCCM6100DB.displayCommentsBox(conn,campus,column)){

				junk = AseUtil.nullToBlank(aseUtil.lookUp(conn,"tblCampusData",explainField,explainSQL));
				if (junk != null && junk.length() > 0){

					if(catalog){

						// FCKEditor tacks on <p> & </p> around content so we remove here
						if(junk.toLowerCase().startsWith("<p>") && junk.toLowerCase().endsWith("</p>")){
							junk = junk.substring(3);
							junk = junk.substring(0,junk.length()-4);
						}
					}

					if(formattedText != null && formattedText.length() > 0){
						formattedText = formattedText + "<br>" + junk;
					}
					else{
						formattedText = junk;
					}

				}
			}

			// ----------------------------------------------------
			// combined data
			// only pre/coreq had explain appearing before data
			// ----------------------------------------------------
			if (column.equals(Constant.COURSE_PREREQ) || column.equals(Constant.COURSE_COREQ)){
				if(textToAppend != null && textToAppend.length() > 0){

					if(formattedText != null && formattedText.length() > 0){
						formattedText = formattedText + "<br>" + textToAppend ;
					}
					else{
						formattedText = textToAppend ;
					}

				}
			}
			else{
				if(!catalog){
					if(textToAppend != null && textToAppend.length() > 0){

						if(formattedText != null && formattedText.length() > 0){
							formattedText = textToAppend + "<br>" + formattedText;
						}
						else{
							formattedText = textToAppend ;
						}

					}

				} // catalog

			} // prereq

			// ----------------------------------------------------
			// default text
			// ----------------------------------------------------

			// we got here not knowing the tab we're on so use the column name to
			// determine the tab

			int tab = 1;

			if(CampusDB.getCourseItems(conn,campus).indexOf(column) > -1){
				tab = Constant.TAB_COURSE;
			}
			else{
				tab = Constant.TAB_CAMPUS;
			}

			if(QuestionDB.isDefaultTextPermanent(conn,campus,tab,column)){

				String defaultText = QuestionDB.getDefaultText(conn,campus,tab,column);

				if(QuestionDB.defaultTextAppends(conn,campus,tab,column,"A")){
					formattedText = formattedText + "<br>" + defaultText ;
				}
				else if(QuestionDB.defaultTextAppends(conn,campus,tab,column,"B")){
					formattedText = defaultText + "<br>" + formattedText;
				}

			} // default text

		}
		catch(SQLException e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}
		catch(Exception e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}

		return formattedText;
	} // Outlines.formatOutline

	/*
	 * cleansData
	 * <p>
	 * @param	column	String
	 * @param	data		String
	 * <p>
	 * @return String
	 */
	public static String cleansData(String column,String data){

		// data cleansing
		if(column.equals(Constant.COURSE_PREREQ) || column.equals(Constant.COURSE_COREQ)){
			if(data.equals("0~~0") || data.equals("~~0")){
				data = "";
			}
		}

		return data;

	}

	/*
	 * attachmentExists
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean attachmentExists(Connection conn,String kix) throws SQLException {

		boolean exists = false;
		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter FROM tblAttach WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			if (counter>0)
				exists = true;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: attachmentExists\n" + e.toString());
		}

		return exists;
	}

	/*
	 * getAttachmentAsHTMLList
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return String
	 */
	public static String getAttachmentAsHTMLList(Connection connection,String kix) throws Exception {

		return getAttachmentAsHTMLList(connection,kix,null);

	}

	/*
	 * getAttachmentAsHTMLList
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return String
	 */
	public static String getAttachmentAsHTMLList(Connection connection,String kix,String src) throws Exception {

		int version = 0;
		String sql = "";
		StringBuffer contents = new StringBuffer();
		boolean found = false;
		String temp = "";
		String campus = "";
		String fileDescr = "";
		String fileName = "";
		String image = "";
		String extension = "";
		String folder = "campus";

		if (src == null || src.length() == 0){
			src = "Outline";
			folder = "campus";
		}
		else if (src.equals("forum")){
			folder = "forum";
		}

		sql = "SELECT campus,filedescr,filename,version "
			+ "FROM tblAttach, "
			+ "(SELECT DISTINCT fullname, MAX(version) AS lastversion "
			+ "FROM tblAttach "
			+ "GROUP BY fullname) derivedtable "
			+ "WHERE tblAttach.historyid=? "
			+ "AND tblAttach.fullname = derivedtable.fullname "
			+ "AND tblAttach.version = derivedtable.lastversion "
			+ "AND category=? "
			+ "ORDER BY filedescr ";
		try {
			String documentsURL = SysDB.getSys(connection,"documentsURL");
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				fileDescr = AseUtil.nullToBlank(rs.getString("filedescr"));
				//fileName = documentsURL + folder + "/" + campus + "/" + AseUtil.nullToBlank(rs.getString("fileName"));
				fileName = "../../../docs/" + folder + "/" + campus + "/" + AseUtil.nullToBlank(rs.getString("fileName"));
				extension = AseUtil2.getFileExtension(fileName);
				if (extension.indexOf(Constant.FILE_EXTENSIONS) == -1){
					extension = "default.icon";
				}
				image = "<img src=\"../../../images/ext/"+extension+".gif\" border=\"0\">&nbsp;";
				fileDescr = "<a href=\""+fileName+"\" target=\"_blank\" class=\"linkcolumn\">"+fileDescr+"</a>";
				contents.append("<li class=\"dataColumn\">" + image + fileDescr + "</li>");
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table name=\"tableGetAttachmentAsHTMLList\" border=\"0\" width=\"98%\">" +
					"<tr><td><br><ul>" +
					contents.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("AttachDB: getAttachmentAsHTMLList - " + e.toString());
		}

		return temp;
	}

	/**
	 * listProgramAttachments
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String listProgramAttachments(Connection conn,String campus,String kix){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String fullName = "";
		String fileName = "";
		int version = 0;
		int id = 0;
		String link = "";
		String rowColor = "";
		boolean found = false;
		int j = 0;

		try{
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			String sql = "SELECT a.id, a.filename, v.fullname, v.version "
				+ "FROM vw_AttachedLatestVersion v INNER JOIN "
				+ "tblAttach a ON v.historyid = a.historyid "
				+ "AND v.campus = a.campus "
				+ "AND v.version = a.version "
				+ "AND v.fullname = a.fullname "
				+ "WHERE v.historyid=? "
				+ "AND v.campus=? "
				+ "AND (v.category=? OR v.category=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,campus);
			ps.setString(3,Constant.PROGRAM);
			ps.setString(4,"programs");
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				fullName = AseUtil.nullToBlank(rs.getString("fullname"));
				fileName = AseUtil.nullToBlank(rs.getString("filename"));
				version = rs.getInt("version");
				id = rs.getInt("id");

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><a href=\"attchst.jsp?kix="+kix+"&id="+id+"\" title=\"view attachment history\" class=\"linkcolumn\"><img src=\"../images/attachment.gif\" border=\"0\"></a></td>");
				listings.append("<td class=\"datacolumn\"><a href=\""+documentsURL+"programs/"+campus+"/"+fileName+"\" title=\"" + fullName + "\" class=\"linkcolumn\" target=\"_blank\">" + version + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + fullName + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"10%\">History</td>" +
					"<td class=\"textblackth\" width=\"10%\">Version</td>" +
					"<td class=\"textblackth\" width=\"80%\">File Name</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
		}
		catch( SQLException e ){
			logger.fatal("OutlinesWithComments: listProgramAttachments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("OutlinesWithComments: listProgramAttachments - " + ex.toString());
		}

		return listing;
	}

	/**
	 * printLinkedMaxtrixContent - returns sql for linked src
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	src			String
	 * @param	user			String
	 * @param	print			boolean
	 * @param	compressed 	boolean
	 * <p>
	 * @return	String
	 */
	public static String printLinkedMaxtrixContent(Connection conn,
																	String kix,
																	String src,
																	String user,
																	boolean print,
																	boolean compressed) throws SQLException {

		Logger logger = Logger.getLogger("test");

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String campus = info[4];

		int j = 0;

		int getDstDataCount = 0;

		String srcName = "";
		String dst = "";
		String dstName = "";
		String linkedDst = "";
		String temp = "";
		String[] aLinkedDst = null;
		StringBuffer buf = new StringBuffer();

		String hideIncompleteLinkedItems = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","hideIncompleteLinkedItems");

		try{
			srcName = GetLinkedItemDescr(conn,src);
			linkedDst = GetLinkedKeys(conn,campus,src);
			if (linkedDst != null && linkedDst.length() > 0){
				aLinkedDst = linkedDst.split(",");
				for (j=0;j<aLinkedDst.length;j++){
					dst = aLinkedDst[j];

						dstName = GetKeyNameFromDst(conn,dst);

						getDstDataCount = SQLValues.getDstDataCount(conn,campus,kix,src,dst);

					// when the dst linked to item has no selection, don't display empty grid
					if (hideIncompleteLinkedItems.equals(Constant.ON) && getDstDataCount == 0){
						buf.append(showNonEstablishedLinks(srcName,dstName,true,compressed));
					}
					else{
						buf.append(showLinkedMatrixContentsX(conn,campus,kix,src,srcName,dst,dstName,true,"","",user,compressed));
					}

				} // for j
			}	// if
			else{
				buf.append(showLinkedMatrixContentsX(conn,campus,kix,src,srcName,"","",print,"","",user,compressed));
			}

		} catch (Exception e) {
			logger.fatal("LinkedUtil: printLinkedMaxtrixContent - " + e.toString());
		}

		temp = buf.toString();

		return temp;
	}

	/**
	 * GetKeyNameFromDst - returns the DST full name from the database table column name
	 * <p>
	 * @param	conn	Connection
	 * @param	dst	String
	 * <p>
	 * @return	String
	 */
	public static String GetKeyNameFromDst(Connection conn,String dst){

		Logger logger = Logger.getLogger("test");

		String keyName = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT linkeddst FROM tblLinkedItem WHERE linkedkey=?");
			ps.setString(1,dst);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				keyName = AseUtil.nullToBlank(rs.getString("linkeddst"));
				keyName = keyName.replace("Objectives","Course SLO");
			}

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetKeyNameFromDst - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetKeyNameFromDst - " + ex.toString());
		}

		return keyName;
	}

	/**
	 * GetDstFromKeyName - returns the short name from the full name
	 * <p>
	 * @param	conn		Connection
	 * @param	fullName	String
	 * <p>
	 * @return	String
	 */
	public static String GetDstFromKeyName(Connection conn,String fullName){

		Logger logger = Logger.getLogger("test");

		String dst = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT linkedkey FROM tblLinkedItem WHERE linkeddst=?");
			ps.setString(1,fullName);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				dst = AseUtil.nullToBlank(rs.getString("linkedkey"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetDstFromKeyName - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetDstFromKeyName - " + ex.toString());
		}

		return dst;
	}

	/**
	 * showNonEstablishedLinks - outline items configured for linking but connections have not been established
	 * <p>
	 * @param	srcName		String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	compressed 	boolean
	 * <p>
	 * @return	String
	 */
	public static String showNonEstablishedLinks(String srcName,String dstName,boolean print,boolean compressed) throws Exception {

		StringBuffer buffer = new StringBuffer();

		buffer.append("<br/>");
		buffer.append("<table summary=\"\" id=\"showNonEstablishedLinks\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
		buffer.append("<tr height=\"30\">");
		buffer.append("<td class=\"datacolumn\">");
		buffer.append("&nbsp;<img src=\"/central/images/reminder.gif\" border=\"0\">"+srcName+" to "+dstName+" has been configured but links have not been established.");
		buffer.append("</td>");
		buffer.append("</tr>");
		buffer.append("</table>");

		return buffer.toString();

	} // showNonEstablishedLinks

	/**
	 * showLinkedMatrixContents - returns sql for linked src
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	src			String
	 * @param	srcName		String
	 * @param	dst			String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	compressed	boolean
	 * <p>
	 * @return	String
	 */
	public static String showLinkedMatrixContents(HttpServletRequest request,
																	Connection conn,
																	String kix,
																	String src,
																	String srcName,
																	String dst,
																	String dstName,
																	boolean print,
																	boolean compressed) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		StringBuffer buffer = new StringBuffer();

		HttpSession session = request.getSession(true);

		String currentTab = (String)session.getAttribute("aseCurrentTab");
		String currentNo = (String)session.getAttribute("asecurrentSeq");

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try {
			session.setAttribute("aseLinker", Encrypter.encrypter("kix="+kix+","+"src="+src+","+"dst="+dst+","+"user="+user));

			AseUtil aseUtil = new AseUtil();

			String caller = aseUtil.getSessionValue(session,"aseCallingPage");

			aseUtil = null;

			buffer.append(showLinkedMatrixContentsX(conn,
																campus,
																kix,
																src,srcName,
																dst,dstName,
																print,
																currentTab,currentNo,
																user,
																compressed,
																caller));

		} catch (SQLException ex) {
			logger.fatal("LinkedUtil: showLinkedMatrixContents - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("LinkedUtil: showLinkedMatrixContents - " + e.toString());
		}

		temp = buffer.toString();
		temp = temp.replace("border=\"0\"","border=\"1\"");

		return temp;
	}

	/**
	 * showLinkedMatrixContentsX - returns sql for linked src
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	src			String
	 * @param	srcName		String
	 * @param	dst			String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	currentTab	String
	 * @param	currentNo	String
	 * @param	user			boolean
	 * @param	compressed	boolean
	 * @param	caller		String
	 * <p>
	 * @return	String
	 */
	public static String showLinkedMatrixContentsX(Connection conn,
																	String campus,
																	String kix,
																	String src,
																	String srcName,
																	String dst,
																	String dstName,
																	boolean print,
																	String currentTab,
																	String currentNo,
																	String user,
																	boolean compressed) throws Exception {

		return showLinkedMatrixContentsX(conn,
													campus,
													kix,
													src,
													srcName,
													dst,
													dstName,
													print,
													currentTab,
													currentNo,
													user,
													compressed,
													"");
	}

	public static String showLinkedMatrixContentsX(Connection conn,
																	String campus,
																	String kix,
																	String src,
																	String srcName,
																	String dst,
																	String dstName,
																	boolean print,
																	String currentTab,
																	String currentNo,
																	String user,
																	boolean compressed,
																	String caller) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String rowColor = "";
		String sql = "";
		String temp = "";
		String img = "";
		String dstFullName = "";
		String longcontent = "";
		StringBuffer buffer = new StringBuffer();
		StringBuffer connected = new StringBuffer();

		int ix = 0;
		int jy = 0;

		int i = 0;
		int j = 0;
		int rowsAffected = 0;

		String columnTitle = "";
		String stickyName = "";
		String tempSticky = "";
		String stickyRow = null;
		StringBuilder stickyBuffer = new StringBuilder();

		boolean found = false;
		boolean foundLink = false;

		String linked = "";
		String checked = "";
		String field = "";
		String selected = "";
		String thisKey = "";

		/*
			variables for use with creating legend. the top most row will be like excel where
			columns start with A-Z then AA, AB, and so on. To make this happen, a loop
			runs for as many items to display. with each 26 count, the start character will
			be the next in the series of alphabet. For example, for the first 26, they are shown
			as they are (A-Z). The second round starts of with aALPHABETS[iteration] where
			iteration = 0 or the letter A (AA-AZ). The next round or third round follows the
			same pattern by getting aALPHABETS[iteration+1] or BA - BZ.
		*/
		int alphaCounter = 0;
		int iteration = 0;
		String chars = "";

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"LinkedUtil");

			if (debug) {
				logger.info("------------------------- showLinkedMatrixContentsX - START");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("src: " + src + " - " + srcName);
				logger.info("dst: " + dst + " - " + dstName);
			}

			String server = SysDB.getSys(conn,"server");

			AseUtil aseUtil = new AseUtil();

			stickyName = "sticky"+src + "_" + dst;
			if (debug) logger.info("stickyName: " + stickyName);

			String[] xAxis = SQLValues.getSrcData(conn,campus,kix,src,"descr");
			String[] xiAxis = SQLValues.getSrcData(conn,campus,kix,src,"key");

			String[] yAxis = SQLValues.getDstData(conn,campus,kix,dst,"descr");
			String[] yiAxis = SQLValues.getDstData(conn,campus,kix,dst,"key");

			// used for popup help
			columnTitle = dstName;
			stickyRow = "<div id=\""+stickyName+"<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br/><| DESCR |></div>";

			String[] aALPHABETS = (Constant.ALPHABETS).split(",");

			if (xAxis!=null && yAxis!=null && yiAxis != null){

				if (debug) logger.info("valid data found - " + stickyName);

				found = true;

				buffer.append("<br/>");
				buffer.append("<table summary=\"\" id=\"tableShowLinkedMatrixContentsX_" + src + "_" + dst + "1\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");

				// print header row
				buffer.append("<tr height=\"20\" bgcolor=\"#e1e1e1\">");
				buffer.append("<td class=\"textblackth\" valign=\"top\">");
				buffer.append("&nbsp;"+srcName+"/"+dstName+"");
				buffer.append("</td>");

				// draw top row or column header (legend)
				for(i=0;i<yAxis.length;i++){

					if (i > 25 && alphaCounter > 25){
						alphaCounter = 0;
						chars = aALPHABETS[iteration++];
					}

					if (compressed){
						buffer.append("<td class=\"class=\"datacolumn\"Center\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" +  chars + aALPHABETS[alphaCounter] + "</td>");
					}
					else{
						buffer.append("<td class=\"class=\"datacolumn\"Center\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" + yAxis[i] + "</td>");
					}

					tempSticky = stickyRow;
					tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
					tempSticky = tempSticky.replace("<| STICKY |>",""+i);
					stickyBuffer.append(tempSticky);

					++alphaCounter;
				} // for

				buffer.append("</tr>");

				if (debug) logger.info("column header printed");

				// print detail row
				for(i=0;i<xAxis.length;i++){

					connected.setLength(0);

					ix = Integer.parseInt(xiAxis[i]);

					dstFullName = GetLinkedDestinationFullName(dst);
					if (dstFullName.equals("Objectives"))
						dstFullName = "SLO";

					// retrieve values saved to db
					if (dst.equals(Constant.COURSE_OBJECTIVES)){
						if (src.equals(Constant.COURSE_COMPETENCIES))
							selected = CompetencyDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else if (src.equals(Constant.COURSE_CONTENT))
							selected = ContentDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else
							selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);
					}
					else{
						selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);
					}

					// make into CSV for proper indexOf search
					selected = "," + selected + ",";

					for(j=0;j<yAxis.length;j++){

						foundLink = false;

						thisKey = "," + yiAxis[j] + ",";

						if (selected.indexOf(thisKey) > -1){
							foundLink = true;
						}

						if (print){
							if (foundLink){
								//img = "<p align=\"center\"><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" data-tooltip=\""+stickyName+""+j+"_"+i+"\" /></p>";
								img = "<p align=\"center\">&nbsp;X&nbsp;</p>";
							}
							else
								img = "<p align=\"center\">&nbsp;</p>";
						}
						else{
							checked = "";
							if (foundLink)
								checked = "checked";

							field = ""+yiAxis[j]+"_"+xiAxis[i];

							img = "<p align=\"center\">&nbsp;<input type=\"checkbox\" "+checked+" name=\""+field+"\" value=\"1\" data-tooltip=\""+stickyName+""+j+"_"+i+"\">&nbsp;</p>";
						}

						connected.append(Constant.TABLE_CELL_DATA_COLUMN
											+ img
											+ "</td>");

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br/><br/><b><u>"+srcName+"</u></b><br/><br/>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);

						stickyBuffer.append(tempSticky);
					}

					if (debug) logger.info("append to output buffer");

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					buffer.append(Constant.TABLE_CELL_DATA_COLUMN
										+ 	xAxis[i]
										+ 	"</td>");

					buffer.append(connected.toString());

					buffer.append("</tr>");
				} // for i;

				buffer.append("</table>"
									+ temp.replace("border=\"0\"","border=\"1\"")
									);

				if (!print){
					buffer.append(
						"<p align=\"right\">"
						+ "<input type=\"submit\" class=\"input\" name=\"aseSubmit\" value=\"Submit\" title=\"save data\">&nbsp;&nbsp;"
						+ "<input type=\"submit\" class=\"input\" name=\"aseCancel\" value=\"Cancel\" title=\"abort selected operation\" onClick=\"return cancelMatrixForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"')\">"
						+ "</p><hr size=\"1\" noshade>"
						);
				}

				if (compressed){
					buffer.append(Outlines.showLegend(yAxis));
				}

				MiscDB.insertSitckyNotes(conn,kix,user,stickyBuffer.toString());
			} // if data exists
			else{
				// there is data but not yet linked
				if (debug) logger.info("no valid data found");

				if (xAxis!=null){

					if (debug) logger.info("printing x axis only");

					found = true;

					buffer.append("<br/>");
					buffer.append("<table summary=\"\" id=\"tableShowLinkedMatrixContentsX_" + src + "_" + dst + "2\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");

					// print header row
					buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT)
							.append(Constant.TABLE_CELL_HEADER_COLUMN)
							.append(srcName)
							.append("</td>")
							.append("</tr>");

					// print detail row
					for(i=0;i<xAxis.length;i++){
						if (i % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
						buffer.append("<td class=\"datacolumn\" valign=\"top\">" + xAxis[i] + "</td>");

						buffer.append("</tr>");
					} // for i;

					buffer.append(
						"</table>"
						+ temp.replace("border=\"0\"","border=\"1\"")
						);
				}
			} // if data exists

			if (debug) logger.info("------------------------- showLinkedMatrixContentsX - END");

		} catch (SQLException ex) {
			logger.fatal("LinkedUtil: showLinkedMatrixContentsX - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("LinkedUtil: showLinkedMatrixContentsX - " + e.toString());
		}

		if (found){
			temp = buffer.toString();
			temp = temp.replace("border=\"0\"","border=\"1\"");
		}

		return temp;
	}

	/**
	 * GetLinkedSQL - returns sql for linked src
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedSQL(Connection conn,String campus,String kix,String src){

		String sql = "";

		try{
			AseUtil aseUtil = new AseUtil();

			if (src.equals(Constant.COURSE_COMPETENCIES)){
				sql = "SELECT seq AS thisID,content AS thisDescr "
					+ "FROM tblCourseCompetency "
					+ "WHERE historyid=?";
			}
			else if (src.equals(Constant.COURSE_OBJECTIVES)){
				sql = "SELECT compid AS thisID,comp AS thisDescr "
					+ "FROM tblCourseComp "
					+ "WHERE historyid=? "
					+ "ORDER BY rdr";
			}
			else if (src.equals(Constant.COURSE_GESLO)){
				sql = "SELECT id AS thisID,kid + ' - ' + kdesc AS thisDescr "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='GESLO' "
					+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
					+ "ORDER BY seq";
			}
			else if (src.equals(Constant.COURSE_METHODEVALUATION)){
				sql = "historyid=" + aseUtil.toSQL(kix,1);

				String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

				methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

				if (methodEvaluation != null && methodEvaluation.length() > 0){
					sql = "SELECT id AS thisID,kdesc AS thisDescr "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "AND id IN ("+methodEvaluation+") "
						+ "ORDER BY seq, kdesc";
				}
				else{
					sql = "SELECT id AS thisID,kdesc AS thisDescr "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "ORDER BY seq, kdesc";
				}
			}
			else if (src.equals(Constant.COURSE_PROGRAM_SLO) || src.equals(Constant.IMPORT_PLO)){
				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND src=? "
					+ "AND historyid=?";
			}
			else if (src.equals(Constant.COURSE_INSTITUTION_LO) || src.equals(Constant.IMPORT_ILO)){
				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND src=? "
					+ "AND historyid=?";
			}
			else if (src.equals(Constant.COURSE_CONTENT)){
				sql = "SELECT contentID AS thisID,LongContent AS thisDescr "
						+ "FROM tblCourseContent "
						+ "WHERE historyid=? "
						+ "ORDER BY rdr";
			}
		}
		catch(Exception e){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + e.toString());
		}

		return sql;
	}

	/**
	 * GetLinkedResultSet - returns sql for linked src
	 * <p>
	 * @param	conn		Connection
	 * @param	ps			PreparedStatement
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	level1	int
	 * <p>
	 * @return	ResultSet
	 */
	public static ResultSet GetLinkedResultSet(Connection conn,
																PreparedStatement ps,
																String campus,
																String kix,
																String src,
																int level1){

		String sql = "";
		String sqlSelect = "";
		ResultSet rs = null;

		try{

			String displayDescription = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowKeyDescsription");

			AseUtil aseUtil = new AseUtil();

			if (src.equals(Constant.COURSE_COMPETENCIES)){
				sql = "SELECT seq AS thisID,content AS thisDescr "
					+ "FROM tblCourseCompetency "
					+ "WHERE historyid=?";

				if (level1 > 0)
					sql += " AND seq="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}
			else if (src.equals(Constant.COURSE_OBJECTIVES)){
				sql = "SELECT compid AS thisID,comp AS thisDescr "
					+ "FROM tblCourseComp "
					+ "WHERE historyid=? ";

				if (level1 > 0)
					sql += "AND compid="+level1;

				sql += "ORDER BY rdr";

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}
			else if (src.equals(Constant.COURSE_GESLO)){

				if (displayDescription.equals("1"))
					sqlSelect = "kid AS thisDescr ";
				else if (displayDescription.equals("2"))
					sqlSelect = "kdesc AS thisDescr ";
				else if (displayDescription.equals("3"))
					sqlSelect = "kid + ' - ' + kdesc AS thisDescr ";

				sql = "SELECT id AS thisID, " + sqlSelect + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='GESLO' "
					+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
					+ "ORDER BY seq";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
			}
			else if (src.equals(Constant.COURSE_METHODEVALUATION)){
				sql = "historyid=" + aseUtil.toSQL(kix,1);

				String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

				methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

				if (displayDescription.equals("1"))
					sqlSelect = "kid AS thisDescr ";
				else if (displayDescription.equals("2"))
					sqlSelect = "kdesc AS thisDescr ";
				else if (displayDescription.equals("3"))
					sqlSelect = "kid + ' - ' + kdesc AS thisDescr ";

				if (methodEvaluation != null && methodEvaluation.length() > 0){
					sql = "SELECT id AS thisID, " + sqlSelect + " "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "AND id IN ("+methodEvaluation+") "
						+ "ORDER BY seq, kdesc";
				}
				else{
					sql = "SELECT id AS thisID, " + sqlSelect + " "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "ORDER BY seq, kdesc";
				}
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else if (src.equals(Constant.COURSE_PROGRAM_SLO) || src.equals(Constant.IMPORT_PLO)){

				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND (src=? OR src=?) "
					+ "AND historyid=? ";

				if (level1 > 0)
					sql += "AND id="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_PROGRAM_SLO);
				ps.setString(3,Constant.IMPORT_PLO);
				ps.setString(4,kix);
			}
			else if (src.equals(Constant.COURSE_INSTITUTION_LO) || src.equals(Constant.IMPORT_ILO)){

				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND (src=? OR src=?) "
					+ "AND historyid=? ";

				if (level1 > 0)
					sql += "AND id="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_INSTITUTION_LO);
				ps.setString(3,Constant.IMPORT_ILO);
				ps.setString(4,kix);
			}
			else if (src.equals(Constant.COURSE_CONTENT)){
				sql = "SELECT contentID AS thisID,LongContent AS thisDescr "
						+ "FROM tblCourseContent "
						+ "WHERE historyid=? ";

				if (level1 > 0)
					sql += "AND contentID="+level1;

				sql += "ORDER BY rdr";

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}

			rs = ps.executeQuery();
		}
		catch(SQLException s){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + s.toString() + "\n kix: " + kix);
		}
		catch(Exception e){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + e.toString() + "\n kix: " + kix);
		}

		return rs;
	}

	/**
	 * GetLinkedItemDescr - returns linked item
	 * <p>
	 * @param	conn	Connection
	 * @param	item	String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedItemDescr(Connection conn,String item){

		//Logger logger = Logger.getLogger("test");

		String linkedItem = "";

		try{
			String sql = "SELECT linkedItem FROM tblLinkeditem WHERE linkedkey=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				linkedItem = AseUtil.nullToBlank(rs.getString("linkedItem"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetLinkedItemDescr - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetLinkedItemDescr - " + ex.toString());
		}

		return linkedItem;
	}

	/**
	 * GetLinkedKeys - returns linked keys (dst)
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedKeys(Connection conn,String campus,String src){

		//Logger logger = Logger.getLogger("test");

		String dst = "";

		try{
			String sql = "SELECT linkeddst "
							+ "FROM tblLinkedKeys "
							+ "WHERE campus=? AND "
							+ "linkedsrc=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				dst = AseUtil.nullToBlank(rs.getString("linkeddst"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - aGetLinkedKeys - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - aGetLinkedKeys - " + ex.toString());
		}

		return dst;
	}

	/**
	 * GetLinkedItems - returns CSV of available items for linking.
	 *							if campus is empty, list all. with campus,
	 *							list only what was selected for campus to use.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String[] GetLinkedItems(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		boolean first = true;
		String[] rtn = new String[4];

		try{
			PreparedStatement ps = null;
			String sql = "";

			if (campus != null && campus.length() > 0){
				sql = "SELECT tli.linkedkey, tli.linkeditem, tli.linkeddst, tli.linkedtable "
					+ "FROM tblLinkedKeys tlk, tblLinkedItem tli "
					+ "WHERE tlk.campus=? "
					+ "AND tlk.linkedsrc = tli.linkedkey "
					+ "ORDER BY tli.linkeditem";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else{
				sql = "SELECT tli.linkedkey, tli.linkeditem, tli.linkeddst, tli.linkedtable "
					+ "FROM tblLinkedItem tli "
					+ "ORDER BY tli.linkeditem";
				ps = conn.prepareStatement(sql);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				if (first){
					rtn[0] = AseUtil.nullToBlank(rs.getString("linkeditem"));
					rtn[1] = AseUtil.nullToBlank(rs.getString("linkedkey"));
					rtn[2] = AseUtil.nullToBlank(rs.getString("linkeddst"));
					rtn[3] = AseUtil.nullToBlank(rs.getString("linkedtable"));
				}
				else{
					rtn[0] = rtn[0] + "," + AseUtil.nullToBlank(rs.getString("linkeditem"));
					rtn[1] = rtn[1] + "," + AseUtil.nullToBlank(rs.getString("linkedkey"));
					rtn[2] = rtn[2] + "," + AseUtil.nullToBlank(rs.getString("linkeddst"));
					rtn[3] = rtn[3] + "," + AseUtil.nullToBlank(rs.getString("linkedtable"));
				}

				first = false;
			}

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetLinkedItems - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetLinkedItems - " + ex.toString());
		}

		return rtn;
	}

	/**
	 * GetLinkedDestinationFullName - returns destination name as for example,
	 * Assess,GESLO,Competency,Content,MethodEval,Objectives,PSLO
	 * <p>
	 * @param	dst		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedDestinationFullName(String dst){

		return Constant.GetLinkedDestinationFullName(dst);
	}

	public static String spamy(String kix,String column,String str){

		Logger logger = Logger.getLogger("test");

		Policy policy = null;
		CleanResults cr = null;
		AntiSamy as = null;

		String cleaned = "***";

		if (str != null) {
			try{
				if (str.length() < 10){
					cleaned = str;
				}
				else{
					if (policy == null){
						policy = Policy.getInstance("/tomcat/webapps/central/web-inf/resources/AntiSamy.xml");
					}

					if (as == null){
						as = new AntiSamy(policy);
					}

					cr = as.scan(str);
					cleaned = cr.getCleanHTML();
					if (!cr.getErrorMessages().isEmpty()) {
						logger.fatal("AntiSpamy - spamy: "
										+ "kix: " + kix + "\n"
										+ "column: " + column + "\n"
										+ "str: " + cr.getErrorMessages());
					}
				}
			}catch(ScanException se){
				logger.fatal(se.toString());
			}catch(PolicyException pe){
				logger.fatal(pe.toString());
			}catch(Exception e){
				logger.fatal(e.toString());
			}
		}

		return cleaned;
	}

}
