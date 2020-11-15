/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.io;

import com.ase.aseutil.*;

import org.apache.log4j.Logger;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.io.BufferedReader;
import java.util.Enumeration;

import com.ase.aseutil.uploads.AseUploadProcessing;
import com.ase.aseutil.uploads.DefaultFileTypePolicy;
import com.ase.aseutil.util.HashUtil;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * A class to perform file upload and retrieve associated parms
 * <p>
 *
 * @author <b>ASE</b>, Copyright &#169; 2011
 *
 * @version 1.0, 2011/04/01
 */
public class MultiUploadServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(MultiUploadServlet.class.getName());

	private String dirName;

	MultipartRequest multi = null;

	/*
	 * init
	 */
	public void init() throws ServletException {}

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

	/*
	 * destroy
	 */
	public void destroy() {
	}

	/*
	 * doGet
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		String formName = "";
		String fileName = "";
		String rtn = "";

		try {
			HttpSession session = request.getSession(true);

			// this was set in the page calling this servlet. It is here and can be overriden
			// by the form field rtn if one exists. This is in case the form was not submitted
			// properly
			rtn = (String)session.getAttribute("aseCallingPage");

			// Use an advanced form of the constructor that specifies a character
			// encoding of the request (not of the file contents), a file
			// rename policy and a type policy.

			// at this point, uploads are all done. The code below is for show and tell only
			multi = new MultipartRequest(request,
													dirName,
													10*1024*1024,
													"ISO-8859-1",
													new DefaultFileRenamePolicy(),
													new DefaultFileTypePolicy());

			// show result of file upload (parameters included)
			if (multi.getParameterNameCount() > 0 || multi.getFileNameCount() > 0){

				formName = multi.getParameter("formName","");
				rtn = multi.getParameter("rtn");;
				fileName = multi.getFileName("fileName");

				if (!formName.equals(Constant.BLANK) && !fileName.equals(Constant.BLANK)){

					//String campus = website.getRequestParameter(request,"aseCampus","",true);
					//String user = website.getRequestParameter(request,"aseUserName","",true);

				} // if valid form and has a file

			} // upload is valid

			session.setAttribute("aseUserUploadFilename",fileName);

			multi = null;
		}
		catch (IOException e) {
			logger.fatal("MultiUploadServlet - doGet: " + e.toString());
		}
		catch (Exception e) {
			logger.fatal("MultiUploadServlet - doGet: " + e.toString());
		}

		String url = response.encodeURL("/core/rtr.jsp?rtn="+rtn);

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);

		dispatcher.forward(request, response);
	}

	/*
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}