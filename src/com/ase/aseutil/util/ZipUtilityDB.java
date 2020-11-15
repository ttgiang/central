/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Helper;
import com.ase.aseutil.ProgramsDB;
import com.ase.aseutil.SysDB;
import com.ase.aseutil.Tables;

public class ZipUtilityDB {

	static Logger logger = Logger.getLogger(ZipUtilityDB.class.getName());

	private ZipOutputStream zipOutputStream = null;

	private boolean debug = true;

	/*
	 * main - for testing
	 *	<p>
	 * @param	args[]	String[]
	 */
	public static void main(String args[]) {

		if(args == null || args.length < 2) {
			//System.out.println("Usage: java ZipUtility <directory or file to be zipped> <directory of zip file to be created>");
			//return;
		}

		ZipUtility zipUtility = new ZipUtility();
		zipUtility.setSource("C:\\tomcat\\webapps\\central\\core\\testj\\");
		zipUtility.setTarget("C:\\tomcat\\webapps\\central\\core\\testj\\zipfile.zip");
		zipUtility.setWildCard("java");

		ZipUtilityDB zipDB = new ZipUtilityDB();
		zipDB.zip(zipUtility);
	}

	/*
	 * main - for testing
	 *	<p>
	 * @param	zipUtility	ZipUtility
	 */
	public void zip(ZipUtility zipUtility){
		try {

			File file = null;

			// when using kix, don't check for source because it will be empty
			if (zipUtility.getKix().length() == 0){
				file = new File(zipUtility.getSource());
				if (!file.isFile() && !file.isDirectory() ) {
					logger.info("ZipUtility - Zip: Source file/directory Not Found!");
					return;
				}
			}
			else{
				// set the target if it was not sent in. Target is based on KIX if available.
				zipUtility.setTarget(getTarget(zipUtility));
			}

			if (debug) logger.info("zipUtility.getTarget(): " + zipUtility.getTarget());

			FileOutputStream fos = new FileOutputStream(zipUtility.getTarget());
			zipOutputStream = new ZipOutputStream(fos);
			zipOutputStream.setLevel(9);

			if (debug) logger.info("Starting zip");
			zipFiles(file,zipUtility);
			if (debug) logger.info("Ending zip");

			zipOutputStream.finish();
			zipOutputStream.close();
			logger.info(zipUtility);
		}	catch (Exception e){
			logger.fatal(e.toString());
		}
	}

	/*
	 * zipFiles
	 *	<p>
	 * @param	file			File
	 * @param	zipUtility	ZipUtility
	 */
	private void zipFiles(File file,ZipUtility zipUtility) {

		String campus = zipUtility.getCampus();
		String kix = zipUtility.getKix();

		if (kix.length() > 0 || (file.isDirectory() && zipUtility.getWildCard().length() == 0)) {

			if (debug) logger.info("kix: " + kix);

			// read entire directory for all contents when source is available
			// when kix is available, read from database

			if (kix.length() > 0){

		      Connection conn = null;

		      try{
					conn = AsePool.createLongConnection();

					if (conn != null){

						File dfFile = null;
						String sql = "";
						String fileName = "";
						String currentDrive = AseUtil.getCurrentDrive();
						String documents = SysDB.getSys(conn,"documents");
						String docFolder = currentDrive
													+ ":"
													+ documents
													+ "campus\\"
													+ campus
													+ "\\";

						if (debug) logger.info("docFolder: " + docFolder);

						sql = "SELECT a.filename "
							+ "FROM "
							+ "( "
							+ "SELECT MAX(version) AS max_version, fullname "
							+ "FROM tblAttach "
							+ "WHERE campus=? "
							+ "AND historyid=? "
							+ "AND category='outline' "
							+ "GROUP BY fullname "
							+ ") AS tbl INNER JOIN "
							+ "tblAttach AS a "
							+ "ON tbl.max_version = a.version "
							+ "AND tbl.fullname = a.fullname "
							+ "WHERE a.campus=? "
							+ "AND a.historyid=?";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,campus);
						ps.setString(4,kix);
						ResultSet rs = ps.executeQuery();
						while(rs.next()){
							fileName = docFolder + AseUtil.nullToBlank(rs.getString("filename"));
							dfFile = new File(fileName);
							if (dfFile.exists()){
								if (debug) logger.info("fileName: " + fileName);
								addToZip(dfFile,zipUtility);
							}
						}
						rs.close();
						ps.close();

						fileName = createPrimaryDocument(conn,campus,documents,kix);
						if (fileName != null){
							dfFile = new File(fileName);
							if (dfFile.exists()){
								addToZip(dfFile,zipUtility);
							}
						} // fileName != null

					} // conn != null

				} catch (Exception e) {
					logger.fatal("ZipUtility: " + e.toString());
				}
				finally{
					try{
						if (conn != null){
							conn.close();
							conn = null;
						}
					}
					catch(Exception e){
						logger.fatal("ZipUtility: " + e.toString());
					}
				}

			}
			else{
				File[] fileList = file.listFiles() ;
				for (int i=0; i< fileList.length; i++){
					zipFiles(fileList[i],zipUtility) ;
				}
			}
		}
		else if (zipUtility.getWildCard() != null && zipUtility.getWildCard().length() > 0) {

			// read only for matching files

			File dir = new File(zipUtility.getSource());

			FileFilter fileFilter = new WildcardFileFilter(zipUtility.getWildCard());

			if (fileFilter != null){

				File[] files = dir.listFiles(fileFilter);

				if (files != null){
					for (int i = 0; i < files.length; i++) {
						addToZip(files[i],zipUtility);
					}
				} // files != null
			} // fileFilter
		}
		else {

			// a single file to work with

			addToZip(file,zipUtility);

		} // if-else-else (kix)
	} // zipFiles


	/*
	 * createPrimaryDocument
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createPrimaryDocument(Connection conn,String campus,String documents,String kix){

		String fileName = null;

		try{
			// after adding the attached document, include the HTML for program or outline as well
			String documentFolder = "";
			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			if (isAProgram){
				documentFolder = "programs";
			}
			else{
				documentFolder = "outlines";
			}

			// there is a chance that the file already exist but we want
			// to create from the most recent content
			String[] info = null;
			if (isAProgram){
				info = Helper.getKixInfo(conn,kix);
				String degree = info[Constant.KIX_PROGRAM_TITLE];
				String division = info[Constant.KIX_PROGRAM_DIVISION];
				Tables.createPrograms(campus,kix,degree,division);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];
				Tables.createOutlines(campus,kix,alpha,num,"html","",type,false,true);
			}

			fileName = AseUtil.getCurrentDrive()
									+ ":"
									+ documents
									+ documentFolder + "\\"
									+ campus + "\\"
									+ kix
									+ ".html";
		}
		catch(SQLException e){
			logger.fatal("ZipUtilityB - createPrimaryDocument: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ZipUtilityB - createPrimaryDocument: " + e.toString());
		}

		return fileName;

	}


	/*
	 * createPrimaryDocument
	 *	<p>
	 * @param	file			File
	 * @param	zipUtility	ZipUtility
	 */
	public void addToZip(File file,ZipUtility zipUtility){

		int byteCount;

		final int DATA_BLOCK_SIZE = 2048;

		FileInputStream fileInputStream;

		try {
			if(file.getAbsolutePath().equalsIgnoreCase(zipUtility.getTarget())){
				return;
			}

			zipUtility.setSize(zipUtility.getSize() + file.length());

			zipUtility.setNumOfFiles(zipUtility.getNumOfFiles() + 1);

			Filename fileName = new Filename(file.getPath(), '\\', '.');

			String strZipEntryName = fileName.fullname();

			fileInputStream = new FileInputStream(file) ;

			ZipEntry zipEntry = new ZipEntry(strZipEntryName);

			zipOutputStream.putNextEntry(zipEntry );

			byte[] b = new byte[DATA_BLOCK_SIZE];
			while ( (byteCount = fileInputStream.read(b, 0, DATA_BLOCK_SIZE)) != -1) {
				zipOutputStream.write(b, 0, byteCount);
			}

			zipOutputStream.closeEntry() ;

		} catch (Exception e) {
			logger.fatal(e.toString());
		}
	}

	/*
	 * getTarget
	 *	<p>
	 * @param	zipUtility	ZipUtility
	 */
	public static String getTarget(ZipUtility zipUtility){

		String target = "";

		if ((zipUtility.getTarget()).equals(Constant.BLANK)){

			Connection conn = null;

			try{
				conn = AsePool.createLongConnection();

				String currentDrive = AseUtil.getCurrentDrive();

				String documents = SysDB.getSys(conn,"documents");

				target = currentDrive
							+ ":"
							+ documents
							+ "temp\\"
							+ zipUtility.getUser()
							+ "_"
							+ zipUtility.getKix()
							+ ".zip";
			}
			catch( Exception e ){
				e.printStackTrace();
			}
			finally{
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		} // target is empty

		return target;
	}

}


