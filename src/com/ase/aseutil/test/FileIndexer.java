/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.test;

import com.test.aseutil.*;

import com.ase.aseutil.*;

import org.apache.log4j.Logger;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import java.io.File;
import java.io.FileReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import org.apache.poi.hwpf.*;
import org.apache.poi.hwpf.extractor.*;

public class FileIndexer extends AseTestCase {

	static Logger logger = Logger.getLogger(FileIndexer.class.getName());

	/*
	 * indexer
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */

	/**
	 * Test method for {@link com.test.aseutil.FileIndexer#testMe()}.
	 */
	 public final void testMe(){

		 FileIndexer(getCampus(),getKix(),getUser());

	 }

	 public static void FileIndexer(String campus,String idx,String dta){

		boolean success = false;

		//private static String dta = "C:\\tomcat\\webapps\\central\\doc\\completed";
		//private static String idx = "C:\\tomcat\\webapps\\centraldocs\\docs\\index";

		try{

			if(campus == null || campus.equals("")){
				campus = "ALL";
			}

			com.ase.aseutil.index.FileIndexer indexer = new com.ase.aseutil.index.FileIndexer();
			indexer.setCampus(campus);
			indexer.setIdx(idx);
			indexer.setDta(dta);
			indexer.createIndex();
			indexer = null;
			success = true;
		}
		catch(Exception e){
			success = false;
		}

		assertTrue(success);

	}

}