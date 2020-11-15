/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int deleteText(Connection conn,String kix,int id) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Text getText(Connection conn,String kix,int id) {
 * public static String getTextAsHTMLList(Connection connection,String kix)
 *	public static int insertText(Connection conn, Text text)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateText(Connection conn, Text text) {
 *
 * @author ttgiang
 */

//
// EncDB.java
//
package com.ase.aseutil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class EncDB {

	static Logger logger = Logger.getLogger(EncDB.class.getName());

	public EncDB() throws Exception {}

	/**
	 * getEnc
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	sessValue	String
	 * <p>
	 * @return	Enc
	 */
	public static Enc getEnc(HttpServletRequest request,String sessValue) {

		//Logger logger = Logger.getLogger("test");
		Enc enc = null;

		try {
			HttpSession session = request.getSession(true);

			String aseLinker = Encrypter.decrypter((String)session.getAttribute(sessValue));
			if (aseLinker != null && aseLinker.length() > 0){
				String[] aAseLinker = aseLinker.split(",");

				enc = new Enc();

				for (int i = 0; i < aAseLinker.length; i++){

					String value = aAseLinker[i].substring(0,aAseLinker[i].indexOf("="));

					String data = aAseLinker[i].substring(aAseLinker[i].indexOf("=")+1);

					/*
						when using encrypter as shown here, commas in title division and other places
						throws off the CSV created.

						we mask the comman and have it restored here before return data

						Encrypter.encrypter(	"kix=,"
												+	"campus="+campus+","
												+	"user="+user+","
												+	"skew="+skew+","
												+	"alpha=,"
												+	"num=,"
												+	"key1="+degree+","
												+	"key2="+division+","
												+	"key3="+title.replace(",","[ASE_COMMA]")+","
												+	"key4="+description.replace(",","[ASE_COMMA]")+","
												+	"key5="+effectiveDate+","
												+	"key6="+year+","
												+	"key7="+regentApproval+","
												+	"key8="+formName+","
												+	"key9="+formAction));

					*/

					data = data.replace("[ASE_COMMA]",",");

					if (value.equals("alpha"))
						enc.setAlpha(data);
					else if (value.equals("campus"))
						enc.setCampus(data);
					else if (value.equals("data"))
						enc.setData(data);
					else if (value.equals("dst"))
						enc.setDst(data);
					else if (value.equals("key1"))
						enc.setKey1(data);
					else if (value.equals("key2"))
						enc.setKey2(data);
					else if (value.equals("key3"))
						enc.setKey3(data);
					else if (value.equals("key4"))
						enc.setKey4(data);
					else if (value.equals("key5"))
						enc.setKey5(data);
					else if (value.equals("key6"))
						enc.setKey6(data);
					else if (value.equals("key7"))
						enc.setKey7(data);
					else if (value.equals("key8"))
						enc.setKey8(data);
					else if (value.equals("key9"))
						enc.setKey9(data);
					else if (value.equals("kix"))
						enc.setKix(data);
					else if (value.equals("num"))
						enc.setNum(data);
					else if (value.equals("skew"))
						enc.setSkew(data);
					else if (value.equals("src"))
						enc.setSrc(data);
					else if (value.equals("user"))
						enc.setUser(data);
				}
			}
		}
		catch (Exception e) {
			logger.fatal("EncDB - getEnc - " + e.toString());
		}

		return enc;
	}

	public void close() throws Exception {}

}