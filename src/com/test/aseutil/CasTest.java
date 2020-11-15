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

import edu.yale.its.tp.cas.client.ServiceTicketValidator;
import org.xml.sax.SAXException;
import javax.xml.parsers.ParserConfigurationException;
import java.net.URLEncoder;
import java.io.IOException;

import java.util.*;

/**
 * @author tgiang
 *
 */
public class CasTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.Approver#Approver()}.
	 */
	@Test
	public final void testCasTest() {

		boolean success = false;

		if(getDebug()) logger.info("--> CasTest.testCas.START");

		try{
			if (testCasTest(getCampus()) != null){
				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		assertTrue(success);

		if(getDebug()) logger.info("--> CasTest.testCas.END");

	}

	/*
	 *	doWebLogin
	 *
	 *	Return a netId (a.k.a., username); null if not logged in or
	 *	can't validate the service ticket from the Web Login Service.
	*/
	protected String testCasTest(String ticket)

		throws IOException, SAXException, ParserConfigurationException {

		String serviceURL = URLEncoder.encode("tasks","UTF-8");
		String weblogin = "https://login.its.hawaii.edu/cas";
		String validateURL = weblogin + "/serviceValidate";
		String netId = "";

		try{
			if (ticket != null) {
				ServiceTicketValidator validator = new ServiceTicketValidator();
				validator.setCasValidateUrl(validateURL);
				validator.setService(serviceURL);
				validator.setServiceTicket(ticket);
				validator.validate();
				if (validator.isAuthenticationSuccesful()) {
					netId = validator.getUser();
				}
			}
			else{
				netId = null;
			} // ticket != null
		}
		catch(Exception e){
			netId = null;
		}

		return netId;
	}

}
