/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import com.ase.aseutil.AseUtil;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.*;

public class FileUtils {

	static Logger logger = Logger.getLogger(FileUtils.class.getName());

	/*
	 * deleteFile
	 * <p>
	 * @param	fileName String
	 * @param	user		String
	 */
	public void deleteFile(String fileName,String user) {

		if (fileName != null && fileName.length() > 0){

			try{
				// A File object to represent the filename
				File f = new File(fileName);

				// Make sure the file or directory exists and isn't write protected
				if (!f.exists()){
					logger.fatal("FileUtils - DeleteFile: no such file or directory");
					throw new IllegalArgumentException("Delete: no such file or directory: " + fileName);
				}

				if (!f.canWrite()){
					logger.fatal("FileUtils - DeleteFile: write protected");
					//throw new IllegalArgumentException("Delete: write protected: " + fileName);
				}

				// If it is a directory, make sure it is empty
				if (f.isDirectory()) {

					String[] files = f.list();

					if (files.length > 0){
						logger.fatal("FileUtils - DeleteFile: directory not empty");
						//throw new IllegalArgumentException("Delete: directory not empty: " + fileName);
					}
				}

				// Attempt to delete it
				boolean success = f.delete();

				if (!success){
					logger.fatal("FileUtils - DeleteFile: deletion failed");
					//throw new IllegalArgumentException("Delete: deletion failed");
				}
				else{
					logger.info("FileUtils - DeleteFile: " + fileName + " deleted successfully by " + user);
				}
			}
			catch(Exception e){
				logger.fatal("FileUtils - DeleteFile: " + e.toString());

			} // try-catch

		} // if valid file

	} // deleteFile

	/*
	 * writeToFile
	 *	<p>
	 *	@param	user		String
	 *	@param	content	String
	 *	<p>
	 */
	public void writeToFile(String user,String content) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String jobName = "SearchData";

		try{

			String currentDrive = AseUtil.getCurrentDrive();

			String fileName = currentDrive
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ user
									+ ".out";

			FileWriter fstream = new FileWriter(fileName);

			BufferedWriter output = new BufferedWriter(fstream);

			output.write(content);

			output.close();

			fstream = null;

		}
		catch(Exception e){
			logger.fatal("FileUtils - writeToFile: " + e.toString());
		}

	} // writeToFile

}