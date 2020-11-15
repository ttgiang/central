/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static String cleanHTML(String descr) throws Exception
 *	public static String cleanHTML2(String descr) throws Exception
 *	public static String clearHTMLTags(String strHTML)
 *	public static String cleanSQL(String str)
 *	public static String cleanSQLX(String str)
 *	public String getRequestParameter(javax.servlet.http.HttpServletRequest request, String parameter,String def)
 *	public String getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter)
 *	public String getRequestParameterX(javax.servlet.http.HttpServletRequest request,String parameter)
 *	public int getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,int def)
 *	public boolean getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,boolean def)
 *
 * @author ttgiang
 */

//
// WebSite.java
//
package com.ase.aseutil;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;

import com.itextpdf.text.html.HtmlEncoder;

public final class WebSite {

	static Logger logger = Logger.getLogger(WebSite.class.getName());

	final static String[] blackList = {"--",";--","/*","*/","@@",
								 "char","nchar","varchar","nvarchar",
								 "alter","begin","cast","create","cursor","declare","delete","drop","end","exec","execute",
								 "fetch","insert","kill","open","xp_",
								 "information_schema","information_","_schema",
								 "schema.tables","table_name","union select",
								 "select", "sys","sysobjects","syscolumns",
								 "table","update",
								 "' or 1=1--",
								 "\" or 1=1--",
								 "or 1=1--",
								 "' or 'a'='a",
								 "\" or \"a\"=\"a",
								 ") or ('a'='a",
								 ".js"
								 };

	final static String[] blackList1 = {"--",";--","/*","*/","@@","xp_","information_schema","information_","_schema",
								 "schema.tables","table_name","union select","sysobjects","syscolumns",
								 "' or 1=1--",
								 "\" or 1=1--",
								 "or 1=1--",
								 "' or 'a'='a",
								 "\" or \"a\"=\"a",
								 ") or ('a'='a",
								 ".js"
								 };

	public User user = null;
	private static String realPath = "/tomcat/webapps/central/WEB-INF/resources/antisamy.xml";
	private static CleanResults cr = null;
	private static AntiSamy as = null;

	/**
	 * When website's instance at application level is created, it must be
	 * initialized by jsp page by giving the real path of web application which
	 * forces this website to load all configuration.
	 */
	public void init(String path) throws Exception {
		int i = path.lastIndexOf(java.io.File.separator);
		path = path.substring(0, i);
		user = new User(this);
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request			HttpServletRequest
	* @param		parameter		String
	* @param		def				String
	* @param		validateType	int
	* @return	String
	* <p>
	*/
	public String getRequestParameter(javax.servlet.http.HttpServletRequest request,
												String parameter,
												String def,
												int validateType) {

		boolean validated = false;

		String value = request.getParameter(parameter);

		switch(validateType){
			case Constant.VALIDATE_ADDRESS :
				validated = Validation.validateAddress(value);
				break;
			case Constant.VALIDATE_CITY :
				validated = Validation.validateCity(value);
				break;
			case Constant.VALIDATE_EMAIL :
				validated = Validation.validateEmail(value);
				break;
			case Constant.VALIDATE_FIRSTNAME :
				validated = Validation.validateFirstName(value);
				break;
			case Constant.VALIDATE_LASTNAME :
				validated = Validation.validateLastName(value);
				break;
			case Constant.VALIDATE_NUMERIC :
				validated = Validation.isNumeric(value);
				break;
			case Constant.VALIDATE_PHONE :
				validated = Validation.validatePhone(value);
				break;
			case Constant.VALIDATE_SSN :
				validated = Validation.validateSSN(value);
				break;
			case Constant.VALIDATE_STATE :
				validated = Validation.validateState(value);
				break;
			case Constant.VALIDATE_URL :
				validated = Validation.validateURL(value);
				break;
			case Constant.VALIDATE_ZIP :
				validated = Validation.validateZip(value);
				break;
		}

		if (validated){
			value = cleanSQL(value);

			if (value == null || "".equals(value))
				value = def;
		}
		else{
			value = "ERROR";
		}

		return value;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			String
	* <p>
	* @return	String
	* <p>
	*/
	public String getRequestParameterEditor(javax.servlet.http.HttpServletRequest request,String parameter) {

		return getRequestParameterEditor(request,parameter,"");
	}

	public String getRequestParameterEditor(javax.servlet.http.HttpServletRequest request,String parameter,String def) {

		String value = request.getParameter(parameter);

		value = removeBlankChar(AseUtil.nullToBlank(value));

		value = cleanSQL(value);

		if (value == null || value.equals(Constant.BLANK))
			value = def;

		return value;
	}

	/*
	* removeBlankChar
	* <p>
	* @param		value	String
	* <p>
	* @return	String
	* <p>
	*/
	public String removeBlankCharX(String value) {

		// chrome inserts paragraph and space HTML tags at the
		// front of the input area so it is cleaned here
		if (value != null && value.length()>0){

			if (value.toLowerCase().startsWith("<p>") && value.toLowerCase().endsWith("</p>")){
				value = AseUtil.nullToBlank(value.substring(3));
				value = value.substring(0,value.length()-4);
			}

			value = value.trim();
		}

		return value;
	}

	/*
	* removeBlankChar
	* <p>
	* @param		value	String
	* <p>
	* @return	String
	* <p>
	*/
	public String removeBlankChar(String value) {

		// chrome inserts paragraph and space HTML tags at the
		// front of the input area so it is cleaned here
		if (value != null && value.length()>0){
			if (value.toLowerCase().startsWith("<p>")){
				value = value.substring(3);
			}

			if (value.toLowerCase().endsWith("</p>")){
				value = value.substring(0,value.length()-4);
			}

			if (value.toLowerCase().startsWith("&nbsp;")){
				value = value.substring(6);
			}

			value = value.trim();
		}

		return value;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			String
	* <p>
	* @return	String
	* <p>
	*/
	public String getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,String def) {

		String value = request.getParameter(parameter);

		value = removeBlankChar(value);

		value = cleanSQL(value);

		if (value == null || value.equals(Constant.BLANK))
			value = def;

		return value;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			boolean
	* @param		useSession	boolean
	* <p>
	* @return	String
	* <p>
	*/
	public String getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,String def,boolean useSession) {

		String value = "";

		try{
			if (useSession){
				HttpSession session = request.getSession(true);

				String sessionVariables = "aseUserName,aseCampus";

				if (sessionVariables.indexOf(parameter)!=-1){
					value = Encrypter.decrypter((String)session.getAttribute(parameter));
				}
				else
					value = (String)session.getAttribute(parameter);
			}
			else{
				value = request.getParameter(parameter);
			}

			value = cleanSQL(value);

			if (value == null || "".equals(value))
				value = def;
		}
		catch(Exception e){
			//System.out.println(e.toString());
			value = "";
		}

		return value;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			int
	* <p>
	* @return	int
	* <p>
	*/
	public int getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,int def) {

		String value = request.getParameter(parameter);

		if (value == null || value.equals(Constant.BLANK))
			return def;
		else
			return Integer.parseInt(value);
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			int
	* @param		useSession	boolean
	* <p>
	* @return	int
	* <p>
	*/
	public int getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,int def,boolean useSession) {

		String value = "";
		int num = 0;

		try{
			if (useSession){
				HttpSession session = request.getSession(true);
				value = (String)session.getAttribute(parameter);
			}
			else{
				value = request.getParameter(parameter);
			}

			if (value == null || value.equals(Constant.BLANK))
				num = def;
			else
				num = Integer.parseInt(value);
		}
		catch(Exception e){
			num = 0;
		}

		return num;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* @param		def			boolean
	* <p>
	* @return	boolean
	* <p>
	*/
	public boolean getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,boolean def) {

		String value = request.getParameter(parameter);
		value = cleanSQL(value);

		boolean thisValue = def;

		if (value == null)
			thisValue = def;
		else{
			if (value.equals("1"))
				thisValue = true;
		}

		return thisValue;
	}

	public boolean getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter,boolean def,boolean useSession) {

		String value = "";

		boolean thisValue = def;

		try{
			if (useSession){
				HttpSession session = request.getSession(true);
				value = (String)session.getAttribute(parameter);
			}
			else{
				value = cleanSQL(request.getParameter(parameter));
			}

			if (value == null)
				thisValue = def;
			else{
				if (value.equals("1"))
					thisValue = true;
			}
		}
		catch(Exception e){
			thisValue = def;
		}

		return thisValue;
	}

	/*
	* getRequestParameter
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* <p>
	* @return	String
	* <p>
	*/
	public String getRequestParameter(javax.servlet.http.HttpServletRequest request,String parameter) {
		String value = request.getParameter(parameter);
		value = cleanSQL(value);
		return value == null ? "" : value;
	}

	/*
	* getRequestParameterX
	* <p>
	* @param		request		HttpServletRequest
	* @param		parameter	String
	* <p>
	* @return	String
	* <p>
	*/
	public String getRequestParameterX(javax.servlet.http.HttpServletRequest request,String parameter) {
		String value = request.getParameter(parameter);
		value = cleanSQL(value);
		return value == null ? "" : value;
	}

	/*
	* cleanSQL
	* <p>
	* @param		str	String
	* <p>
	* @return	String
	* <p>
	*/
	public static String cleanSQL(String str){

		String temp = "";

		if (str != null) {

			// doing this creates a problem with display HTML characters
			// on screen. Need to be able to decode after getting data
			// back from the database.
			// str = com.ase.aseutil.HtmlEncoder.encodeSimple(str);

			temp = str;

			// double dashes are bad
			// comments type characters are bad
			if (str.indexOf("--") > -1 ){
				//
				// disabled on 2013.03.11 due to errors at KAU with google docs conversion
				// creating hyphens
				//
				//temp = str.replaceAll("--","-");
				//logger.info("WebSite: cleanSQL - double dashes");

				temp = str.replaceAll("--","&#45;&#45;");
				logger.info("WebSite: cleanSQL - double dashes");
			}
			else if (str.indexOf("/*") > -1 ){
				temp = str.replaceAll("/*","");
				logger.info("WebSite: cleanSQL - comment characters");
			}

			/*
			try{

			//ServletContext sc = null;
			//sc = session.getServletContext();

			if (as == null)
				as = new AntiSamy();

			cr = as.scan(temp,realPath);
			temp = cr.getCleanHTML();
			System.out.println("before: " + temp);
			System.out.println("after: " + temp);

			}catch(ScanException se){
				logger.fatal(se.toString());
			}catch(PolicyException pe){
				logger.fatal(pe.toString());
			}catch(Exception e){
				logger.fatal(e.toString());
			}
			*/

			temp = cleanSQLXY(temp);
		}

		return temp;
	}

	public static String cleanSQLXY(String str){

		//Logger logger = Logger.getLogger("test");

		String temp = str;
		int len = blackList1.length;
		int i = 0;

		try{
			if (temp != null && temp.length() > 0){
				for(i=0;i<len;i++){
					temp = temp.replace(blackList1[i],"");
				}
			}
		}
		catch(Exception ex){
			logger.fatal(i + ": " + blackList1[i] + " - WebSite: cleanSQLXY - black listed - " + ex.toString());
		}

		return temp;
	}

	/*
	* cleanSQLX
	* <p>
	* @param		str	String
	* <p>
	* @return	String
	* <p>
	*/
	public static String cleanSQLX(String str){

		String temp = cleanSQL(str);
		String tempCopy = temp.toLowerCase();
		String front = "";
		String back = "";
		int pos = 0;

		/*
			Cannot use replace because we want to keep the original
			text in it's case sensitive format. remove the bad words and
			leave the text alone.

			front is the text up to the point of our word
			back is from the end of the word to the end of the text
			temp is reassembled from the split without bad word

			when a blacklisted word is found, check to see that a space does not
			follow it. in a single word check, it shouldn't have a space.

			however, in a sentence, a space is usually followed by other words that
			my not be good.
		*/

		if (temp != null && temp.length() > 0){
			for(int i=0;i<blackList.length;i++){
				pos = tempCopy.indexOf(blackList[i]);
				if (pos > -1){
					pos = tempCopy.indexOf(" ",pos);
					if (pos > -1){
						front = temp.substring(0,pos);
						back = temp.substring(pos+blackList[i].length());
						temp = front + back;
						tempCopy = temp;
						logger.info("WebSite: cleanSQLX - black listed - " + blackList[i]);
					}	// pos = " "
				}	// pos in black list
			}	// for loop
		}	// temp is valid

		return temp;
	}

	/*
	* cleanHTML
	* <p>
	* @param		descr	String
	* <p>
	* @return	String
	* <p>
	*/
	public static String cleanHTML(String descr) throws Exception {

		String beginning = "";
		String ending = "";
		int start = 0;
		int end = 0;

		if (!"".equals(descr)){
			start = descr.indexOf("<");
			while (start>=0){
				end = descr.indexOf(">");
				if (end>=0){
					beginning = descr.substring(0,start);
					ending = descr.substring(end+1);
					descr = beginning + ending;
				}
				start = descr.indexOf("<");
			}
		}

		return descr;
	}

	/*
	* cleanHTML2
	* <p>
	* @param		descr	String
	* <p>
	* @return	String
	* <p>
	*/
	public static String cleanHTML2(String descr) throws Exception {

		descr = descr.replaceAll("\\<.*?>","");
		return descr;
	}

	/*
	* clearHTMLTags
	* <p>
	* @param		strHTML	String
	* <p>
	* @return	String
	* <p>
	*/
	public static String clearHTMLTags(String strHTML){

		int intWorkFlow = -1;
		Pattern pattern = null;
		Matcher matcher = null;
		String regex;
		String strTagLess = null;
		strTagLess = strHTML;

		//removes all html tags
		if(intWorkFlow == -1){
			regex = "<[^>]*>";
			pattern = pattern.compile(regex);
			strTagLess = pattern.matcher(strTagLess).replaceAll(" ");
		}

		if(intWorkFlow > 0 && intWorkFlow < 3){
			regex = "[<]";
			//matches a single <
			pattern = pattern.compile(regex);
			strTagLess = pattern.matcher(strTagLess).replaceAll("<");

			regex = "[>]";
			//matches a single >
			pattern = pattern.compile(regex);
			strTagLess = pattern.matcher(strTagLess).replaceAll(">");
		}

		return strTagLess;
	}
}
