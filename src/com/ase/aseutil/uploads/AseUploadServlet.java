/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil.uploads;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AseUploadServlet extends HttpServlet {

	static Logger logger = Logger.getLogger(AseUploadServlet.class.getName());

	private String dirName;

	public void init(ServletConfig config) throws ServletException {

		super.init(config);

		// read the uploadDir from the servlet parameters
		dirName = config.getInitParameter("uploadDir");
		if (dirName == null) {
			throw new ServletException("Please supply uploadDir parameter");
		}
		else{

			// should point to drive:\tomcat\webapps\centraldocs\docs\temp\

			dirName = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps" + dirName.replace("/","\\") + "\\";
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		response.setContentType("text/plain");

		out.println("Demo Upload Servlet using MultipartRequest");
		out.println();

		try {
			// Use an advanced form of the constructor that specifies a character
			// encoding of the request (not of the file contents), a file
			// rename policy and a type policy.

			// at this point, uploads are all done. The code below is for show and tell only
			MultipartRequest multi = new MultipartRequest(request,
																			dirName,
																			10*1024*1024,
																			"ISO-8859-1",
																			new DefaultFileRenamePolicy(),
																			new DefaultFileTypePolicy());

			// show result of file upload (parameters included)
			if (multi.getParameterNameCount() > 0 || multi.getFileNameCount() > 0){
				if (multi.getParameterNameCount() > 0){
					Enumeration params = multi.getParameterNames();
					if (params != null){
						out.println("PARAMS:");
						while (params.hasMoreElements()) {
							String name = (String)params.nextElement();
							String value = multi.getParameter(name);
							out.println(name + "=" + value);
						}
						out.println();
					} // params
				} // getParameterNameCount

				if (multi.getFileNameCount() > 0){
					Enumeration files = multi.getFileNames();
					if (files != null){
						out.println("FILES:");
						while (files.hasMoreElements()) {
							String name = (String)files.nextElement();
							String filename = multi.getFilesystemName(name);
							String originalFilename = multi.getOriginalFileName(name);
							String type = multi.getContentType(name);
							File f = multi.getFile(name);
							out.println("name: " + name);
							out.println("filename: " + filename);
							out.println("originalFilename: " + originalFilename);
							out.println("type: " + type);
							if (f != null) {
								out.println("f.toString(): " + f.toString()); // C:\tomcat\webapps\centraldocs\docs\temp\DROID X - Ringtones.csv
								out.println("f.getName(): " + f.getName()); // DROID X - Ringtones.csv
								out.println("f.exists(): " + f.exists());
								out.println("f.length(): " + f.length());
							}
							out.println();
						} // while
					} // files
				} // getFileNameCount
			}
			else{
			}  // multi counter > 0

		}
		catch (IOException lEx) {
			logger.fatal(lEx);
			//this.getServletContext().log(lEx, "error reading or saving file");
		}
	}
}
