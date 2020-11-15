/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

// The version in use is located in package com.ase.aseutil.io.ListImportServlet

package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.uploads.DefaultFileTypePolicy;
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
public class ListImportServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(ListImportServlet.class.getName());

	static boolean debug = false;

	private String dirName;

	private AsePool connectionPool;

	MultipartRequest multi = null;

	/*
	 * init
	 */
	public void init() throws ServletException {}

	public void init(ServletConfig config) throws ServletException {

		super.init(config);

		connectionPool = AsePool.getInstance();

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
		connectionPool.destroy();
	}

	/*
	 * doGet
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		int rowsAffected = 0;

		String rtn = null;
		String itm = null;
		String kix = null;
		String src = null;

		try {
			// Use an advanced form of the constructor that specifies a character
			// encoding of the request (not of the file contents), a file
			// rename policy and a type policy.

			// at this point, uploads are all done. The code below is for show and tell only

			logger.info("ListImportServlet ------------- START");

			multi = new MultipartRequest(request,
													dirName,
													10*1024*1024,
													"ISO-8859-1",
													new DefaultFileRenamePolicy(),
													new DefaultFileTypePolicy());

			rowsAffected = quickListEntries(request,response);

			logger.info("ListImportServlet ------------- START");

		}
		catch (IOException e) {
			logger.fatal(e);
		}

		String url;

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/"+rtn+".jsp");
		} else {
			url = response.encodeURL("/core/"+rtn+".jsp?rtn="+src+"&kix="+kix+"&itm="+itm);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);

		dispatcher.forward(request, response);
	}

	/*
	 * quickListEntries
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int quickListEntries(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		session.setAttribute("aseException", "");

		WebSite website = new WebSite();

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		String formAction = "";
		String formName = "";

		String alpha = "";
		String itm = "";
		String kix = "";
		String type = "";
		String listType = "";
		String message = "";
		String fileName = "";
		String divisionCode = "";

		int division = 0;
		int rowsAffected = 0;

		Msg msg = new Msg();

		Connection connection = connectionPool.getConnection();

		try {
			debug = DebugDB.getDebug(connection,"OutlineServlet");

debug = true;

			// retrieve form parameters
			if (multi != null){

				if (multi.getParameterNameCount() > 0){
					formAction = multi.getParameter("formAction","");
					formName = multi.getParameter("formName","");
					alpha = multi.getParameter("alpha","");
					itm = multi.getParameter("type","");
					division = multi.getParameter("division",0);
					type = multi.getParameter("type","");

					listType = Constant.GetLinkedDestinationFullName(itm);

					// when division name is missing, alpha it is. or reverse
					divisionCode = DivisionDB.getDivisonCodeFromID(connection,campus,division);
					if (divisionCode == null || divisionCode.length() == 0){
						divisionCode = alpha;
					}
					else if (alpha == null || alpha.length() == 0){
						alpha = divisionCode;
					}

				} // multi.getParameterNameCount()

 				if (multi.getFileNameCount() > 0){
 					logger.info("getFileNameCount: " + multi.getFileNameCount());
				}

				if (multi.getFileNameCount() > 0){
					fileName = multi.getFileName("file1");
				}
				else{
					fileName = "";
				} // multi.getFileNameCount()

				if (debug){
					logger.info("formAction: " + formAction);
					logger.info("formName: " + formName);
					logger.info("alpha: " + alpha);
					logger.info("itm: " + itm);
					logger.info("division: " + division);
					logger.info("type: " + type);
					logger.info("fileName: " + fileName);
					logger.info("listType: " + listType);
				}

			} // multi

			if (fileName != null && fileName.length() > 0){
				message = com.ase.aseutil.io.ImportDB.importListFromFile(connection,
																							campus,
																							user,
																							listType,
																							fileName,
																							divisionCode,
																							alpha,
																							itm);

				com.ase.aseutil.util.FileUtils fu = new com.ase.aseutil.util.FileUtils();

				fu.deleteFile(fileName,user);

				fu = null;
			}
			else{
				int i = 0;
				String[] arr;
				Values values = null;

				// called from crsqlstx.jsp with 'filename:' indicating a while was provided
				String lst = (String)session.getAttribute("aseImportList");

				arr = lst.split("//");

				for(i=0;i<arr.length;i++){

					if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){

						ValuesDB.insertValues(connection,
													new Values(0,
																	campus,
																	listType + " - " + divisionCode,
																	alpha,
																	arr[i],
																	arr[i],
																	user,
																	itm));
						++rowsAffected;
					}
				}

				message = "Import completed successfully. " + rowsAffected + " row(s) update";

			} // import by file

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception ie) {
			rowsAffected = -1;
			session.setAttribute("aseApplicationMessage", ie.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(ie);
		} finally {
			connectionPool.freeConnection(connection);
		}

		return rowsAffected;
	}

	/*
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}