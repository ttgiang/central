/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.uploads;

import java.io.*;
import java.util.Date;
import java.sql.*;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class AseFileRenamePolicy implements FileRenamePolicy {

	/*
	 * rename
	 *	<p>
	 *	@param	f	File
	 *	@return 	File
	 *	<p>
	 */
	public File rename(File f){

		return rename(f,false);

	}

	/*
	 * rename
	 *	<p>
	 *	@param	f				File
	 *	@param	includeDate	boolean
	 *	@return 	File
	 *	<p>
	 */
	public File rename(File f,boolean includeDate){

		return rename(f,includeDate,"");

	}

	/*
	 * rename
	 *	<p>
	 *	@param	f				File
	 *	@param	includeDate	boolean
	 *	@param	user			String
	 *	@return 	File
	 *	<p>
	 */
	public File rename(File f,boolean includeDate,String user){

		//Get the parent directory path as in h:/home/user or /home/user
		String parentDir = f.getParent();

		//Get file name without its path location, such as 'index.txt'
		String fname = f.getName();

		//Get the extension if the file has one
		String fileExt = "";
		int i = -1;
		if(( i = fname.indexOf(".")) != -1){
			fileExt = fname.substring(i);
			fname = fname.substring(0,i);
		}

		//
		// replace with user's name
		//
		if(user != null && !user.equals("")){
			fname = user;
		}

		//
		// add the timestamp
		//
		if(includeDate){
			fname = fname + (""+( new Date().getTime() / 1000));
		}

		//piece together the file name
		fname = parentDir + System.getProperty("file.separator") + fname + fileExt;

		File temp = new File(fname);

		return temp;

	}

	/*
	 * rename
	 *	<p>
	 *	@param	connn			Connection
	 *	@param	f				File
	 *	@param	campus		String
	 *	@param	kix			String
	 *	@param	user			String
	 *	@param	type			String
	 *	@param	destination	String
	 *	@return 	File
	 *	<p>
	 */
	public File rename(Connection conn,File f,String campus,String kix,String user,String type,String destination){

		return new File("");

	}

}
