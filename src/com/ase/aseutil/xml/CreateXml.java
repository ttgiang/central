/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.xml;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import org.htmlcleaner.CleanerProperties;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.PrettyXmlSerializer;
import org.htmlcleaner.TagNode;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.ProgramsDB;
import com.ase.aseutil.SysDB;

public class CreateXml {

	static Logger logger = Logger.getLogger(CreateXml.class.getName());

	/**
	*
	*
	*
	**/
	public CreateXml(){}

	/**
	*
	*
	*
	**/
	public void createXML(Connection conn,String campus,String kix) throws Exception {

		HtmlCleaner cleaner = null;

		CleanerProperties props = null;

		TagNode node = null;

		String documentFolder = "";

		boolean foundation = false;

		boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

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
							+ campus
							+ "\\";

		String htmFile =  outlineName + kix + ".html";
		String xmlFile = outlineName + "xml\\" + kix + ".xml";

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

		return;

	}

}