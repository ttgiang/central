/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * public static String confirmEncodedValue(HttpServletRequest request)
 * public static String getValueEncoded(HttpServletRequest request)
 *	public static String showInputScreen(HttpServletRequest request)
 *
 */

//
// Skew.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.temesoft.security.Base64Coder;
import com.temesoft.security.Config;
import com.temesoft.security.Encrypter;

public class Skew {
	static Logger logger = Logger.getLogger(Skew.class.getName());

	public Skew() throws Exception{}

	/*
	 * confirmEncodedValue
	 *	<p>
	 *	@return boolean
	 */
	public static boolean confirmEncodedValue(HttpServletRequest request){

		String passLine = "";
		String passLineCheck = "";
		String passLineEncoded = "";
		String passLineDecoded = "";
		String passLineString = "";
		String sessionId = "";

		/*
			default to true so that all cases are satified
		*/
		boolean encodedValueConfirmed = true;

		try{
			WebSite website = new WebSite();
			passLine = website.getRequestParameter(request, "passLine");
			passLineEncoded = website.getRequestParameter(request, "passLineEncoded");

			com.temesoft.security.Encrypter stringEncrypter = new com.temesoft.security.Encrypter();

			/*
				continue to validate only if values exist with data
			*/
			if ((passLine!=null && passLine.length()>0) || (passLineEncoded !=null && passLineEncoded.length()>0)) {
				passLineDecoded = Base64Coder.decode(passLineEncoded);
				passLineCheck = stringEncrypter.decrypt(passLineDecoded);
				passLineString = passLineCheck;

				passLineCheck = passLineCheck.substring(0, Config.getPropertyInt(Config.MAX_NUMBER));
				sessionId = passLineString.substring(passLineString.indexOf(".")+1, passLineString.length());

				if (!sessionId.equals(request.getSession().getId())) {
					encodedValueConfirmed = false;
				}

				if (!passLine.toUpperCase().equals(passLineCheck.toUpperCase())) {
					encodedValueConfirmed = false;
				}
			}
		}
		catch(Exception e) {
			logger.fatal("Skew: confirmEncodedValue - " + e.toString());
		}

		return encodedValueConfirmed;
	}

	/*
	 * getValueEncoded
	 *	<p>
	 *	@return String
	 */
	public static String getValueEncoded(HttpServletRequest request){

		String passlineValueEncoded = "";

		String passlineNormal = "";

		String sessionID = "";

		try{
			Encrypter stringEncrypter = new Encrypter();

			String randomLetters = new String("");

			for (int i=0; i<Config.getPropertyInt(Config.MAX_NUMBER); i++) {
				randomLetters += (char) (65 + (Math.random() * 24));
			}

			randomLetters = randomLetters.replaceAll("I","X");

			randomLetters = randomLetters.replaceAll("Q","Z");

			// for unit testing to work, we need valid session ID but coming from test doesn't
			// have the request object.
			if (request != null){
				sessionID = request.getSession().getId();
			}
			else{
				sessionID = Constant.SYSADM_NAME;
			}

			passlineNormal = randomLetters + "." + sessionID;

			passlineValueEncoded = stringEncrypter.encrypt(passlineNormal);

			passlineValueEncoded = Base64Coder.encode(passlineValueEncoded );

		}
		catch(Exception e) {
			logger.fatal("Skew: getValueEncoded - " + e.toString());
		}

		return passlineValueEncoded;
	}

	/*
	 * showInputScreen
	 *	<p>
	 *	@return String
	 */
	public static String showInputScreen(HttpServletRequest request){

		boolean forceDisplay = false;

		return showInputScreen(request,forceDisplay);
	}

	/*
	 * showInputScreen
	 *	<p>
	 *	@return String
	 */
	public static String showInputScreen(HttpServletRequest request,boolean forceDisplay){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String enablePasswordConfirmation = "";
		String campus = "";
		String user = "";

		try{
			HttpSession session = request.getSession(true);

			campus = com.ase.aseutil.Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = com.ase.aseutil.Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			if (!campus.equals(Constant.BLANK)){

				AsePool asePool = AsePool.getInstance();

				Connection conn = asePool.getConnection();

				if (conn != null){

					enablePasswordConfirmation = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnablePasswordConfirmation");

					if (enablePasswordConfirmation.equals(Constant.ON) || forceDisplay){

						String passLineValueEncoded = Skew.getValueEncoded(request);

						if (passLineValueEncoded != null && !passLineValueEncoded.equals(Constant.BLANK)){
							buf.append("<table width=\"200\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
								"<tr>" +
								"<td align=\"center\">" +
								"<table style=\"font-family:verdana; font-size:11px; color:#555555;\">" +
								"<tr><td colspan=\"2\" align=\"center\"><img src=\"../PassImageServlet/" + passLineValueEncoded + "\" border=\"0\"></td></tr>" +
								"<tr><td align=\"right\" nowrap>Anti spam code: </td><td nowrap><input type=\"text\" name=\"passLine\" size=\"9\">" +
								"&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\">" +
								"&nbsp;&nbsp;</td></tr>" +
								"</table>" +
								"<input type=\"hidden\" name=\"passLineEncoded\" value=\"" + passLineValueEncoded + "\">" +
								"</td>" +
								"</tr>" +
								"</table>");

							buf.append("<div id=\"crshlp\" style=\"width: 100%; display:none;\">"
								+ "<TABLE class=page-help border=\"0\" cellSpacing=\"0\" cellPadding=\"3\" width=\"100%\">"
								+ "<TBODY>"
								+ "<TR>"
								+ "<TD class=title-bar width=\"50%\"><font class=\"textblackth\">Course Help</font></TD>"
								+ "<td class=title-bar width=\"50%\" align=\"right\">"
								+ "<img src=\"../images/images/buttonClose.gif\" border=\"0\" alt=\"close help window\" title=\"close help window\" onclick=\"switchMenu('crshlp');\">"
								+ "</td>"
								+ "</TR>"
								+ "<TR>"
								+ "<TD colspan=\"2\">"
								+ "If you wish to continue with the current request, enter the anti-spam code in the input box and click to confirm your decision."
								+ "<br/><br/>The anti-spam code is a security feature of CC to verify that the request being made is with your knowledge."
								+ "</TD>"
								+ "</TR>"
								+ "</TBODY>"
								+ "</TABLE>"
								+ "</div>");
						} // passLineValueEncoded
					}

					asePool.freeConnection(conn,"skew",user);
				}	// conn != null
			}	// campus != ""
		}	// try
		catch(Exception e) {
			logger.fatal("Skew: showInputScreen - " + e.toString());
		}

		return buf.toString();
	}

	public void close() throws SQLException {}

}