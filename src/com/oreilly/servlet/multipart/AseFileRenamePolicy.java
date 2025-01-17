// Copyright (C) 2002 by Jason Hunter <jhunter_AT_acm_DOT_org>.
// All rights reserved.  Use of this class is limited.
// Please see the LICENSE for more information.

package com.oreilly.servlet.multipart;

import com.ase.aseutil.*;

import java.io.*;
import java.sql.*;

/**
 * Implements a renaming policy that adds increasing integers to the body of
 * any file that collides.  For example, if foo.gif is being uploaded and a
 * file by the same name already exists, this logic will rename the upload
 * foo1.gif.  A second upload by the same name would be foo2.gif.
 * Note that for safety the rename() method creates a zero-length file with
 * the chosen name to act as a marker that the name is taken even before the
 * upload starts writing the bytes.
 *
 * @author Jason Hunter
 * @version 1.1, 2002/11/05, making thread safe with createNewFile()
 * @version 1.0, 2002/04/30, initial revision, thanks to Yoonjung Lee
 *                           for this idea
 */
public class AseFileRenamePolicy implements FileRenamePolicy {

	// This method does not need to be synchronized because createNewFile()
	// is atomic and used here to mark when a file name is chosen
	public File rename(File f) {

		return f;

	}

  public File rename(File f,boolean includeDate) {

  	return rename(f,includeDate,"");

  }

  public File rename(File f,boolean includeDate,String  user) {

    if (createNewFile(f)) {
      return f;
    }

    String name = f.getName();
    String body = null;
    String ext = null;
    String dte = AseUtil.getCurrentDateString();

    int dot = name.lastIndexOf(".");
    if (dot != -1) {
      body = name.substring(0, dot);
      ext = name.substring(dot);  // includes "."
    }
    else {
      body = name;
      ext = "";
    }

	 //
	 // replace with user's name
	 //
	 if(user != null && !user.equals("")){
		body = user;
	 }

    // Increase the count until an empty spot is found.
    // Max out at 9999 to avoid an infinite loop caused by a persistent
    // IOException, like when the destination dir becomes non-writable.
    // We don't pass the exception up because our job is just to rename,
    // and the caller will hit any IOException in normal processing.
    int count = 0;
    while (!createNewFile(f) && count < 9999) {
      count++;
      String newName = body + "-" + dte + "-" + count + ext;
      f = new File(f.getParent(), newName);
    }

    return f;
  }

	/*
	*
	*
	*
	*/
	public File rename(Connection conn,File f,String campus,String kix,String user,String type,String dstination) {

		if (createNewFile(f)) {
			return f;
		}

		String name = f.getName();
		String body = null;
		String ext = null;

		int dot = name.lastIndexOf(".");

		if (dot != -1) {
			body = name.substring(0, dot);
			ext = name.substring(dot);
		}
		else {
			body = name;
			ext = "";
		} // if dot

		String fileName = null;
		String savedFile = null;
		String version = null;

		String currentDrive = AseUtil.getCurrentDrive();
		String documents = SysDB.getSys(conn,"documents");

		String aseUploadFolder = currentDrive + ":" + documents + "campus";
		String aseUploadTempFolder = currentDrive + ":" + documents + "temp";

		try{
			int nextVersion = AttachDB.getNextVersionNumber(conn,campus,kix,"","",body);

			if (nextVersion < 10){
				version = "V0" + nextVersion;
			}
			else{
				version = "V" + nextVersion;
			}
		}
		catch(Exception e){
			//System.out.println(e.toString());
		}

		if (type == null || type.equals(Constant.BLANK)){
			fileName = aseUploadFolder + "/" + kix + "-" + version + "-" + body;
		}
		else{
			fileName = aseUploadTempFolder + "/" + user + "-" + type + "-" + kix + "." + ext;
		}

		if (createNewFile(f)) {
			f = new File(f.getParent(), fileName);
		}

		return f;
	}

	/*
	*
	*
	*
	*/
	private boolean createNewFile(File f) {
		try {
			return f.createNewFile();
		}
		catch (IOException ignored) {
			return false;
		}
	}
}
