/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// DocsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.io.File;
import java.io.FileNotFoundException;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.SysDB;

public class DocsDB {

	static Logger logger = Logger.getLogger(DocsDB.class.getName());

	public DocsDB() throws Exception {}

	/**
	 * insertDocs
	 * <p>
	 * <p>
	 * @return int
	 */
	public static int insertDocs(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		try{
			String sql = "DELETE FROM tbldocs WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.executeUpdate();
			ps.close();

			String directoryName = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\docs\\"+campus.toUpperCase()+"\\";
			String alpha = "";
			String num = "";
			String temp = "";

			File dir = new File(directoryName);
			String[] children = dir.list();
			if (children == null) {
				// Either dir does not exist or is not a directory
			}
			else {
				for (i=0; i<children.length; i++) {

					String filename = children[i];

					if (filename.toLowerCase().indexOf(".pdf") > -1){
						temp = filename;
						int pos = NumericUtil.findNumberInString(temp);
						if (pos > -1){
							temp = temp.replace(".pdf","");
							alpha = temp.substring(0,pos);
							num = temp.substring(pos,temp.length());
							rowsAffected += insertDocsX(conn,campus,filename,alpha,num);
						}
					} // if

				} // for
			} // if

			System.out.println(i);

		} catch (Exception e) {
			logger.fatal("DocsDB.insertDocs - " + e.toString());
		}

		return rowsAffected;

	}

	/**
	 * insertDocsX
	 * <p>
	 * <p>
	 * @return int
	 */
	public static int insertDocsX(Connection conn,String campus,String filename,String alpha,String num) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int i = 0;

		try{

			//does the document exists?
			if (!isMatchingDoc(conn,campus,filename,alpha,num)){

				// we know alphas are 5 or fewer
				String type = "P";

				if (alpha.length() > 5){
					type = "P";
					alpha = "";
					num = "";
				}
				else{
					type = "C";
				}

				String sql = "INSERT INTO tbldocs (type,filename,show,campus,alpha,num) VALUES(?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				ps.setString(2,filename);
				ps.setString(3,"Y");
				ps.setString(4,campus);
				ps.setString(5,alpha.toUpperCase());
				ps.setString(6,num.toUpperCase());
				rowsAffected = ps.executeUpdate();
				ps.close();
			} // not found
		} catch (SQLException e) {
			logger.fatal("DocsDB.insertDocsX - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DocsDB.insertDocsX - " + e.toString());
		}

		return rowsAffected;

	}

	/**
	 * isMatchingDoc
	 * <p>
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchingDoc(Connection conn,String campus,String type,String alpha,String num,String status) throws SQLException {

		String sql = "SELECT id FROM tbldocs WHERE campus=? AND type=? AND alpha=? AND num=? AND status=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,type);
		ps.setString(3,alpha);
		ps.setString(4,num);
		ps.setString(5,status);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * isMatchingDoc
	 * <p>
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchingDoc(Connection conn,String campus,String filename,String alpha,String num) throws SQLException {

		String sql = "SELECT id FROM tbldocs WHERE campus=? AND filename=? AND alpha=? AND num=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,filename);
		ps.setString(3,alpha);
		ps.setString(4,num);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * getDocumentName
	 * <p>
	 * <p>
	 * @return String
	 */
	public static String getDocumentName(Connection conn,String campus,String type,String alpha,String num,String status) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String documentName = "";

		//
		// type refers to course or program
		//
		try{
			if(isMatchingDoc(conn,campus,type,alpha,num,status)){
				String sql = "SELECT filename FROM tbldocs WHERE campus=? AND type=? AND alpha=? AND num=? AND status=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				ps.setString(3,alpha);
				ps.setString(4,num);
				ps.setString(5,status);
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					documentName = AseUtil.nullToBlank(rs.getString("filename"));
				}
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("DocsDB.getDocumentName - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DocsDB.getDocumentName - " + e.toString());
		}

		return documentName;

	}

	/**
	 * getDocumentPath
	 * <p>
	 * <p>
	 * @return String
	 */
	public static String getDocumentPath(Connection conn,String campus,String type,String alpha,String num,String status) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String documentPath = "";

		//
		// type refers to course or program
		//
		// these documents were scanned in prior to coming on line. if this document exists
		// and and ARC outline does not exist, show the link
		//
		try{
			String documentName = getDocumentName(conn,campus,type,alpha,num,status);
			if(documentName != null && documentName.length() > 0){

				String currentDrive = AseUtil.getCurrentDrive();
				String documents = SysDB.getSys(conn,"documents");
				documentPath = currentDrive
											+ ":"
											+ documents
											+ "docs\\"
											+ campus
											+ "\\"
											+ documentName;

				File file = new File(documentPath);
				boolean exists = file.exists();
				if(!exists){
					documentPath = "";
				}
				else{
					if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"ARC")){
						documents = SysDB.getSys(conn,"documentsURL");
						documentPath = documents + "docs/" + campus + "/" + documentName;
					}
					else{
						documentPath = "";
					}
				}

			}
		} catch (Exception e) {
			logger.fatal("DocsDB.getDocumentPath - " + e.toString());
		}

		return documentPath;

	}

	/**
	 * close
	 */
	public void close() throws Exception {}

}