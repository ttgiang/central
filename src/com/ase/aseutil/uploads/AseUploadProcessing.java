/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.uploads;

import com.ase.aseutil.AseUtil;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.io.BufferedReader;
import java.util.Enumeration;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import org.apache.log4j.Logger;

public class AseUploadProcessing extends HttpServlet {

	static Logger logger = Logger.getLogger(AseUploadProcessing.class.getName());

	private HashMap hashMapParms = null;

	private HashMap hashMapFileNames = null;

	public MultipartRequest processUpload(HttpServletRequest request, HttpServletResponse response) throws IOException {

		MultipartRequest multi = null;

		try {
			// Use an advanced form of the constructor that specifies a character
			// encoding of the request (not of the file contents), a file
			// rename policy and a type policy.

			// at this point, uploads are all done. The code below is for show and tell only
			multi = new MultipartRequest(request,
													"",
													10*1024*1024,
													"ISO-8859-1",
													new DefaultFileRenamePolicy(),
													new DefaultFileTypePolicy());

			hashMapParms = new HashMap();

			hashMapFileNames = new HashMap();

			// show result of file upload (parameters included)
			if (multi.getParameterNameCount() > 0 || multi.getFileNameCount() > 0){
				if (multi.getParameterNameCount() > 0){
					Enumeration params = multi.getParameterNames();
					if (params != null){
						while (params.hasMoreElements()) {
							String name = (String)params.nextElement();
							String value = multi.getParameter(name);
							hashMapParms.put(name,value);
						}
					} // params
				} // getParameterNameCount

				if (multi.getFileNameCount() > 0){
					Enumeration files = multi.getFileNames();
					if (files != null){

						int fileCounter = 0;

						while (files.hasMoreElements()) {
							String name = (String)files.nextElement();
							String filename = multi.getFilesystemName(name);
							String originalFilename = multi.getOriginalFileName(name);
							String type = multi.getContentType(name);
							File f = multi.getFile(name);
							if (f != null) {
								++fileCounter;
								hashMapFileNames.put("file"+fileCounter,f.toString());
							}
						} // while
					} // files
				} // getFileNameCount
			}

		}
		catch (IOException e) {
			logger.fatal("AseUploadProcessing - processUpload: " + e.toString());
		}

		return multi;
	}
}
