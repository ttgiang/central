/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *
 */

//
// HtmlUtils.java
//
package com.ase.aseutil.html;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

import java.io.IOException;
import java.io.FileReader;
import java.io.Reader;
import java.io.File;
import java.util.List;
import java.util.ArrayList;

import javax.swing.text.html.parser.ParserDelegator;
import javax.swing.text.html.HTMLEditorKit.ParserCallback;
import javax.swing.text.html.HTML.Tag;
import javax.swing.text.MutableAttributeSet;

import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import java.sql.*;
import java.io.*;

import org.htmlcleaner.*;

public class HtmlUtils {

	static Logger logger = Logger.getLogger(HtmlUtils.class.getName());

	private HtmlUtils() {}

	/*
	 * Html2Text
	 *	<p>
	 *	@param	fileName	String
	 *	<p>
	 *	@return	String
	 */
	public static String Html2Text(String fileName) {

		String str = null;

		StringBuffer buf = new StringBuffer();

		try{
			FileReader reader = new FileReader(fileName);

			List<String> lines = HtmlUtils.extractText(reader);

			if (lines != null){
				for (String line : lines) {
					buf.append(line);
				}

				str = buf.toString();
			}
		}
		catch(Exception e){
			logger.fatal("HtmlUtils - " + e.toString());
		}

		return str;
	}

	/*
	 * extractText
	 *	<p>
	 *	@param	reader	Reader
	 *	<p>
	 */
	public static List<String> extractText(Reader reader) throws IOException {

		final ArrayList<String> list = new ArrayList<String>();

		ParserDelegator parserDelegator = new ParserDelegator();

		ParserCallback parserCallback = new ParserCallback() {

			public void handleText(final char[] data, final int pos) {
				list.add(new String(data));
			}

			public void handleStartTag(Tag tag, MutableAttributeSet attribute, int pos) { }
			public void handleEndTag(Tag t, final int pos) {  }
			public void handleSimpleTag(Tag t, MutableAttributeSet a, final int pos) { }
			public void handleComment(final char[] data, final int pos) { }
			public void handleError(final java.lang.String errMsg, final int pos) { }
		};

		parserDelegator.parse(reader, parserCallback, true);

		return list;
	}

	/*
	 * createXML
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	user		String
	 *	@param	html		String
	 *	<p>
	 */
	public static void createXML(Connection conn,String campus,String kix,String alpha,String num,String user,String html) throws Exception {

		try{
			html = html.replace("</br>","<br>");
			html = html.replace("<br>","<br>");
			html = html.replace("<br />","<br>");
			html = html.replace("<br>","\n");
			html = html.replace("&nbsp;"," ");

			FileWriter fstream = null;
			BufferedWriter output = null;
			fstream = new FileWriter(AseUtil.getCurrentDrive()
												+ ":"
												+ SysDB.getSys(conn,"documents")
												+ "outlines\\"
												+ campus
												+ "\\"
												+ kix
												+ ".xml");
			if (fstream != null){
				output = new BufferedWriter(fstream);
				output.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
				output.write("<outline>\n");
				CourseDB courseDB = new CourseDB();
				output.write("<campus>" + campus + "</campus>\n");
				output.write("<kix>" + kix + "</kix>\n");
				output.write("<user>" + user + "</user>\n");
				output.write("<campusname>" + CampusDB.getCampusNameOkina(conn,campus) + "</campusname>\n");
				output.write("<outlinename>" + courseDB.setPageTitle(conn,"",alpha,num,campus) + "</outlinename>\n");
				courseDB = null;
				output.write(html);
				output.write("</outline>\n");
				output.close();
				output = null;
				fstream = null;
			} // fstream != null
		}
		catch(Exception e){
			logger.fatal("HtmlUtils - createXML: " + e.toString());
		}

	}

	/*
	 * cleanHTML
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 */
	public static void cleanHTML(Connection conn,String campus,String kix) throws Exception {


		HtmlCleaner cleaner = null;

		CleanerProperties props = null;

		TagNode node = null;

		String fileName = AseUtil.getCurrentDrive()
							+ ":"
							+ SysDB.getSys(conn,"documents")
							+ "outlines\\"
							+ campus
							+ "\\"
							+ kix;

		File target = new File(fileName);
		if (target.exists()){
			String htmFile =  fileName + ".html";

			String xmlFile = fileName  + ".xml";

			try{
				cleaner = new HtmlCleaner();

				props = cleaner.getProperties();
				props.setUseCdataForScriptAndStyle(true);
				props.setRecognizeUnicodeChars(true);
				props.setUseEmptyElementTags(true);
				props.setAdvancedXmlEscape(true);
				props.setTranslateSpecialEntities(true);
				props.setBooleanAttributeValues("empty");

				node = cleaner.clean(new File(htmFile));

				new PrettyXmlSerializer(props).writeXmlToFile(node, xmlFile);

				cleaner = null;

				props = null;

				node = null;
			}
			catch(Exception e){
				logger.fatal("HtmlUtils - cleanHTML: " + e.toString());
			}
		} // file exists

	}

	/*
	 * htmlContentParser
	 *	<p>
	 *	@param	address	URL
	 *	<p>
	 *	@return	String
	 *	<p>
	 */
	public static String htmlContentParser(URL address) throws Exception {

		StringBuilder content = new StringBuilder();

		String sourceLine;

		// The URL address of the page to open.
		//URL address = new URL(url);

		// Open the address and create a BufferedReader with the source code.
		InputStreamReader pageInput = new InputStreamReader(address.openStream());
		BufferedReader source = new BufferedReader(pageInput);

		// Append each new HTML line into one string. Add a tab character.
		while ((sourceLine = source.readLine()) != null){
			content.append(sourceLine + "\t");
		}

		pageInput.close();
		source.close();

		return content.toString();

	}

	/*
	 * htmlContentParser
	 *	<p>
	 *	@return	String
	 *	<p>
	 */
	public static String htmlContentParser(String content) throws Exception {

		StringBuilder parsedHTML = new StringBuilder();

		String temp = content;

		boolean found = false;

		// for each search, we look, and if found, we set content for next search

		// Remove style tags & inclusive content
		found = false;
		Pattern style = Pattern.compile("<style.*?>.*?</style>");
		Matcher mstyle = style.matcher(temp);
		while (mstyle.find()){
			found = true;
			parsedHTML.append(mstyle.replaceAll(""));
		}

		if(found){
			temp = parsedHTML.toString();
			parsedHTML.setLength(0);
		}

		// Remove script tags & inclusive content
		found = false;
		parsedHTML.setLength(0);
		Pattern script = Pattern.compile("<script.*?>.*?</script>");
		Matcher mscript = script.matcher(temp);
		while (mscript.find()){
			found = true;
			parsedHTML.append(mscript.replaceAll(""));
		}

		if(found){
			temp = parsedHTML.toString();
			parsedHTML.setLength(0);
		}

		// Remove primary HTML tags
		found = false;
		Pattern tag = Pattern.compile("<.*?>");
		Matcher mtag = tag.matcher(temp);
		while (mtag.find()) {
			found = true;
			parsedHTML.append(mtag.replaceAll(""));
		}

		if(found){
			temp = parsedHTML.toString();
			parsedHTML.setLength(0);
		}

		// Remove comment tags & inclusive content
		found = false;
		Pattern comment = Pattern.compile("<!--.*?-->");
		Matcher mcomment = comment.matcher(temp);
		while (mcomment.find()){
			found = true;
			parsedHTML.append(mcomment.replaceAll(""));
		}

		if(found){
			temp = parsedHTML.toString();
			parsedHTML.setLength(0);
		}

		// Remove special characters, such as &nbsp;
		found = false;
		Pattern sChar = Pattern.compile("&.*?;");
		Matcher msChar = sChar.matcher(temp);
		while (msChar.find()){
			found = true;
			 parsedHTML.append(msChar.replaceAll(""));
		}

		if(found){
			temp = parsedHTML.toString();
			parsedHTML.setLength(0);
		}

		// Remove the tab characters. Replace with new line characters.
		found = false;
		Pattern nLineChar = Pattern.compile("\t+");
		Matcher mnLine = nLineChar.matcher(temp);
		while (mnLine.find()){
			found = true;
			parsedHTML.append(mnLine.replaceAll("\n"));
		}


		if(found){
			temp = parsedHTML.toString();
		}

		return temp;

	}

	/*
	 * buildSearchHtml - creates searchable data by convernting HTML outlines to text only
	 *	<p>
	 *	@return	int
	 *	<p>
	 */
	 public static int buildSearchHtml(){

		//Logger logger = Logger.getLogger("test");

		//
		// reads all available historyids, get the HTML outline associated with it,
		// then remove the text from html to save for ad hoc search
		//

		boolean debug = false;

		Connection conn = null;

		int rowsAffected = 0;

		try{

			conn = AsePool.createLongConnection();
			if (conn != null){

				String currentDrive = AseUtil.getCurrentDrive();
				String documents = SysDB.getSys(conn,"documents");

				String sql = "SELECT campus,historyid,category FROM tblHTML";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String category = AseUtil.nullToBlank(rs.getString("category"));

					if(category.equals("course")){
						category = "outlines";
					}
					else if(category.equals("program")){
						category = "programs";
					}

					String fileName = currentDrive
												+ ":"
												+ documents
												+ category
												+ "\\"
												+ campus
												+ "\\"
												+ kix
												+ ".html";

					File target = new File(fileName);
					if (target.exists()){
						String html2Text = com.ase.aseutil.html.HtmlUtils.Html2Text(fileName);
						sql = "UPDATE tblhtml SET data=? WHERE campus=? AND historyid=?";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,html2Text);
						ps2.setString(2,campus);
						ps2.setString(3,kix);
						int rowsUpdated = ps2.executeUpdate();
						ps2.close();

					}
					target = null;

					++rowsAffected;
				}
				rs.close();
				ps.close();
			}

		}
		catch( SQLException e ){
			logger.fatal("Html.buildSearchHtml - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Html.buildSearchHtml - " + e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Html.buildSearchHtml - " + e.toString());
			}
		}

		return rowsAffected;
	}

}