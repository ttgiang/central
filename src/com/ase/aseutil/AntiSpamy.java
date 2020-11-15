/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public boolean spamy(String str)
 *
 * @author ttgiang
 */

//
// AntiSpamy.java
//
package com.ase.aseutil;

import org.apache.log4j.Logger;
import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;

public final class AntiSpamy {

	static Logger logger = Logger.getLogger(AntiSpamy.class.getName());
	private static Policy policy = null;
	private static CleanResults cr = null;
	private static AntiSamy as = null;

	/*
	* spamy
	* <p>
	* @param		kix		String
	* @param		column	String
	* @param		str		String
	* @return	String
	* <p>
	*/

	public static String spamy(String str){

		return spamy("","",str);

	}

	public static String spamy(String kix,String column,String str){

		String cleaned = "";

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

	/**
	 *
	 */
	public void init(String path) throws Exception {
		policy = null;
		cr = null;
		as = null;
	}
}
