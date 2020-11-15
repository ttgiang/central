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

import org.htmlcleaner.*;


/**
 * @author tgiang
 *
 */
public class TablesTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCreateOutlines() {

		boolean test = true;

		logger.info("========================== TablesTest.testCreateOutlines.START");

		try{
			if (getConnection() != null){

				String h = "p24h5j9242,T21b8j9167,R43b8j9235,L18k12i95,L24f1j9246,217c15h10185,B33f30k9254,q34f30k9225,K34f30k940,X55b8j9213,q20b18g9192,"
							+ "s18c17g9179,m19a4g9188,E9b2g10191,l58c2g10165,18b26f9189,C51b26f9162,d21k18i9174,P23l19g980,d24l11i9182,q23l11i9207,w15l27e10198,"
							+ "R23l19i968,G45k6f9122,824c24j10152,Q22l8c1099,f43l12i9240,y40a13i9188,s32k13i9249,19l13i9223,817c15h10162,H51d15h1081,F37k10i9133,"
							+ "214k15j9201,R22l19g982,q25c3g9181,V55d27i10235,F16d10i9161,b18k17g9190,D14a9j9188,p5c18h9191,O7c18h9178,G32l20h9148,y52j23j942,"
							+ "38c22j9195,u18d12i9164,321l13h1077,N16k15h940,K47k11i9136,d19a4g9188,H7k18i9230,D15a17g9188,P24a9j9188,x15a7j10188,R51c20h98,O51c20h920,"
							+ "211c13i9175,R10c13i9163,h18c17g9188,r57e5f9204,g14c10g10190,q10b2g10190,25f5f9178,65f5f9182,M11l27h10249,Q20b8j9165,d31l25g10183,"
							+ "m18c17g9196,H48b25g10235,B38b25g10168,w21l13h1021,X11c2g9170";

				/*
				p24h5j9242,,T21b8j9167,R43b8j9235,L18k12i95,217c15h10185,B33f30k9254,q34f30k9225,K34f30k940,55b8j9213,
				s18c17g9179,m19a4g9188,E9b2g10191,l58c2g10165,d21k18i9174,P23l19g980,d24l11i9182,q23l11i9207,w15l27e10198,
				R23l19i968,G45k6f9122,Q22l8c1099,,H51d15h1081,F37k10i9133,R22l19g982,V55d27i10235,F16d10i9161,b18k17g9190,
				D14a9j9188,p5c18h9191,O7c18h9178,,G32l20h9148,y52j23j942,38c22j9195,u18d12i9164,321l13h1077,K47k11i9136,
				P24a9j9188,j40d12b11164,x15a7j10188,R51c20h98,O51c20h920,211c13i9175,R10c13i9163,h18c17g9188,r57e5f9204,
				g14c10g10190,q10b2g10190,65f5f9182,25f5f9178,M11l27h10249,Q20b8j9165,d31l25g10183,m18c17g9196,H48b25g10235,
				B38b25g10168,w21l13h1021,X11c2g9170
				*/

				String[] historyid = h.split(",");

				String campus = null;
				String alpha = null;
				String num = null;
				String kix = null;
				String user = null;

				String[] info = null;

				boolean debug = false;

				int route = 2036;

				Msg msg = null;

				for(int i = 0; i < historyid.length; i++){
					kix = historyid[i];

					info = Helper.getKixInfo(getConnection(),kix);

					campus = info[Constant.KIX_CAMPUS];
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
					user = info[Constant.KIX_PROPOSER];

					/*
					msg = CourseDB.setCourseForApproval(getConnection(),
																	campus,
																	alpha,
																	num,
																	user,
																	Constant.COURSE_APPROVAL_TEXT,
																	route,
																	user);

					ApproverDB.fastTrackApprovers(getConnection(),campus,kix,6,0,route,Constant.SYSADM_NAME);

					*/

					Tables.createOutlines(campus,kix,alpha,num,null,null,null,false,true);

					// testing of XML creation
					if (debug){
						HtmlCleaner cleaner = null;

						CleanerProperties props = null;

						TagNode node = null;

						String fileName = AseUtil.getCurrentDrive()
											+ ":"
											+ SysDB.getSys(getConnection(),"documents")
											+ "outlines\\"
											+ campus
											+ "\\"
											+ kix;

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
							logger.fatal(e.toString());
						}
					} // debug

				} // for

			} // conn != null
		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}

		test = true;

		assertTrue(test);

		logger.info("========================== TablesTest.testCreateOutlines.END");

	}

}
