/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

public class SyllabusServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(SyllabusServlet.class.getName());

	// upload values
	private static String aseWhiteList = Upload.getWhiteList();
	private static String aseBlackList = Upload.getBlackList();
	private static String aseGenericUploadFolder = null;
	private static String aseUploadTempFolder = null;
	private static int aseSizeThreshold = 0;

	private AsePool connectionPool;

	// form values
	private String infoTitle = null;
	private String infoContent = null;
	private String startDate = null;
	private String enddDate = null;
	private String infoID = null;
	private String uploadType = null;

	// class values
	private static HttpSession session = null;
	private static WebSite website = null;
	private Syllabus syllabus = null;

	private String cancel = null;
	private String delete = null;
	private String insert = null;
	private String save = null;
	private String saveNew = null;

	final int cancelAction = 1;
	final int deleteAction = 2;
	final int insertAction = 3;
	final int updateAction = 4;
	final int saveNewAction = 5;

	private String sAction = null;
	private String rtn = null;

	private int iAction = 0;
	private int rowsAffected = 0;

	// misc values
	private String kix = "";
	private String url = "";
	private String user = "";
	private String campus = "";
	private String message = "";
	private String uploadedFileName = "";

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	/**
	* Processes upload to a folder.
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		boolean isMultipart = false;

		logger.info("-------------- START ");

		try{
			website = new WebSite();

			session = request.getSession(true);

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart){
				// this call is used when dealing with an upload
				// most likely a file was selected on the form
				processUploads(request,response);
			}
			else{
				// this call is used when not dealing with uploads
				// nothing was entered for file
				processRequest(request,response);
			}
		}
		catch(Exception e){
			logger.fatal("Exception: SyllabusServlet - " + e.toString());
			message = "Unable to process requested operation";
		}

		logger.info("-------------- END");

		session.setAttribute("aseApplicationMessage", message);

		if (rowsAffected == -1)
			url = response.encodeURL("/core/msg.jsp");
		else
			url = response.encodeURL("/core/msg.jsp?rtn=sylidx");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	* Processes upload to a folder.
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		session = request.getSession(true);
		session.setAttribute("aseException", "");

		Connection connection = connectionPool.getConnection();
		try {
			website = new WebSite();

			String lid = website.getRequestParameter(request, "lid");
			String alpha = website.getRequestParameter(request, "alpha");
			String num = website.getRequestParameter(request, "num");
			String question = website.getRequestParameter(request, "question");
			String semester = website.getRequestParameter(request, "semester");
			String year = website.getRequestParameter(request, "year");
			String textbooks = website.getRequestParameter(request, "textbooks");
			String objectives = website.getRequestParameter(request,"objectives");
			String grading = website.getRequestParameter(request, "grading");
			String comments = website.getRequestParameter(request, "comments");

			String formAction = website.getRequestParameter(request,"formAction");

			cancel = website.getRequestParameter(request, "aseCancel");
			delete = website.getRequestParameter(request, "aseDelete");
			insert = website.getRequestParameter(request, "aseInsert");
			save = website.getRequestParameter(request, "aseSave");
			saveNew = website.getRequestParameter(request, "aseSaveNew");

			if (cancel != null && cancel.length() > 0)			sAction = cancel;
			else if (delete != null && delete.length() > 0)		sAction = delete;
			else if (insert != null && insert.length() > 0)		sAction = insert;
			else if (save != null && save.length() > 0)			sAction = save;
			else if (saveNew != null && saveNew.length() > 0)	sAction = saveNew;

			if (sAction.equalsIgnoreCase("close"))						iAction = cancelAction;
			else if (sAction.equalsIgnoreCase("delete"))				iAction = deleteAction;
			else if (sAction.equalsIgnoreCase("insert"))				iAction = insertAction;
			else if (sAction.equalsIgnoreCase("save"))				iAction = updateAction;
			else if (sAction.equalsIgnoreCase("save as new"))		iAction = insertAction;

			syllabus = new Syllabus(lid,
											alpha,
											num,
											semester,
											year,
											user,
											textbooks,
											objectives,
											grading,
											comments,
											AseUtil.getCurrentDateTimeString(),
											"",
											"");
			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = SyllabusDB.deleteSyllabus(connection, lid);

					if (rowsAffected == 1)
						message = "Course syllabus deleted successfully";
					else
						message = "Unable to delete course syllabus";

					break;
				case insertAction:
					rowsAffected = SyllabusDB.insertSyllabus(connection, syllabus);

					if (rowsAffected == 1)
						message = "Course syllabus saved successfully";
					else
						message = "Unable to save course syllabus";

					break;
				case updateAction:
					rowsAffected = SyllabusDB.updateSyllabus(connection, syllabus);

					if (rowsAffected == 1)
						message = "Course syllabus updated successfully";
					else
						message = "Unable to update course syllabus";

					break;
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection);
		}
	}

	/**
	* Processes upload to a folder.
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void processUploads(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String formInput = "";
		String fieldName = "";
		String fileName = "";
		String fileTitle = "";
		String contentType = "";

		String alpha = "";
		String num = "";
		String question = "";
		String semester = "";
		String year = "";
		String textbooks = "";
		String objectives = "";
		String grading = "";
		String comments = "";

		String extension = null;
		String temp = "";

		boolean fileFound = false;
		boolean isInMemory = false;
		boolean isMultipart = false;

		long sizeInBytes = 0;

		Connection conn = null;

		try{
			// defaults
			aseGenericUploadFolder = this.getInitParameter("aseGenericUploadFolder");
			aseUploadTempFolder = this.getInitParameter("aseUploadTempFolder");
			aseWhiteList = this.getInitParameter("aseWhiteList");
			aseBlackList = this.getInitParameter("aseBlackList");
			temp = this.getInitParameter("aseSizeThreshold");

			// make sure values are valid
			if (aseGenericUploadFolder == null)
				aseGenericUploadFolder = getServletContext().getRealPath("/docs/uploads/");
			else
				aseGenericUploadFolder = aseGenericUploadFolder.replace('\\', '/').replace('/', File.separatorChar);

			if (aseUploadTempFolder == null)
				aseUploadTempFolder = getServletContext().getRealPath("/docs/temp/");
			else
				aseUploadTempFolder = aseUploadTempFolder.replace('\\', '/').replace('/', File.separatorChar);

			if (aseWhiteList == null)
				aseWhiteList = Upload.getWhiteList();

			if (aseBlackList == null)
				aseBlackList = Upload.getBlackList();

			aseSizeThreshold = Upload.getUploadSizeThreshold();

			website = new WebSite();
			session = request.getSession(true);

			aseGenericUploadFolder = aseGenericUploadFolder + File.separatorChar + campus + File.separatorChar;

			conn = connectionPool.getConnection();

			isMultipart = ServletFileUpload.isMultipartContent(request);

			if (isMultipart){
				// Create a factory for disk-based file items
				DiskFileItemFactory factory = new DiskFileItemFactory();

				// Set factory constraints
				factory.setSizeThreshold(aseSizeThreshold);

				factory.setRepository(new File(aseUploadTempFolder));

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// Set overall request size constraint
				upload.setSizeMax(aseSizeThreshold);

				upload.setProgressListener(new AseProgressListener(user));

				// Parse the request
				List items = upload.parseRequest(request);

				FileItem writeItem = null;

				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();

					formInput = "";
					fieldName = AseUtil.nullToBlank(item.getFieldName());

					if (item.isFormField()) {
						formInput = AseUtil.nullToBlank(item.getString());
						if (formInput != null && formInput.length() > 0){
							if ("alpha".equals(fieldName))
								alpha = formInput;
							else if ("num".equals(fieldName))
								num = formInput;
							else if ("question".equals(fieldName))
								question = formInput;
							else if ("semester".equals(fieldName))
								semester = formInput;
							else if ("year".equals(fieldName))
								year = formInput;
							else if ("textbooks".equals(fieldName))
								textbooks = formInput;
							else if ("objectives".equals(fieldName))
								objectives = formInput;
							else if ("grading".equals(fieldName))
								grading = formInput;
							else if ("comments".equals(fieldName))
								comments = formInput;
							else if ("lid".equals(fieldName))
								infoID = formInput;
							else if ("uploadType".equals(fieldName))
								uploadType = formInput;
							else if ("aseCancel".equals(fieldName))
								cancel = formInput;
							else if ("aseDelete".equals(fieldName))
								delete = formInput;
							else if ("aseInsert".equals(fieldName))
								insert = formInput;
							else if ("aseSave".equals(fieldName))
								save = formInput;
							else if ("aseSaveNew".equals(fieldName))
								saveNew = formInput;
						}
					}
					else {
						// save file information
						writeItem = item;
						fileName = AseUtil.nullToBlank(item.getName());

						if (fileName != null && fileName.length() > 0){
							contentType = item.getContentType();
							isInMemory = item.isInMemory();
							sizeInBytes = item.getSize();
							fileFound = true;

							// check for black listed file
							extension = AseUtil2.getFileExtension(fileName);
							if (aseBlackList.indexOf("."+extension)>-1){
								fileFound = false;
								logger.info("SyllabusServlet - black listed file: " + fileName);
							}
						}
					} // form field
				}	// while

				// process only if all information we need is available
				if (fileFound){
					if (sizeInBytes < upload.getSizeMax()){
						File fullFile = new File(fileName);

						if (infoID != null && ("0".equals(infoID) || infoID.length()==0))
							infoID = NumericUtil.intToString(NewsDB.getNextInfoID(conn));

						uploadedFileName = fullFile.getName();

						fileName = campus+"-"+uploadType+"-"+infoID+"-"+uploadedFileName;

						File savedFile = new File(aseGenericUploadFolder + "/",fileName);
						writeItem.write(savedFile);

						logger.info("Filename - " + user + ": " + fileName);
					}
					else
						message = "The request was rejected because its size exceeds the configured maximum";
				}	// file found

				if (cancel != null && cancel.length() > 0)	sAction = cancel;
				if (delete != null && delete.length() > 0)	sAction = delete;
				if (insert != null && insert.length() > 0)	sAction = insert;
				if (save != null && save.length() > 0)	sAction = save;
				if (saveNew != null && saveNew.length() > 0)	sAction = saveNew;

				if (sAction.equalsIgnoreCase("cancel")) {	iAction = cancelAction; }
				if (sAction.equalsIgnoreCase("delete")) {	iAction = deleteAction;	}
				if (sAction.equalsIgnoreCase("insert")) {	iAction = insertAction;	}
				if (sAction.equalsIgnoreCase("save")) {	iAction = updateAction;	}
				if (sAction.equalsIgnoreCase("saveNew")) {	iAction = saveNewAction;	}

				syllabus = new Syllabus(infoID,
												alpha,
												num,
												semester,
												year,
												user,
												textbooks,
												objectives,
												grading,
												comments,
												AseUtil.getCurrentDateTimeString(),
												"",
												uploadedFileName);

				switch (iAction) {
					case cancelAction:
						message = "Operation was cancelled";
						break;
					case deleteAction:
						rowsAffected = SyllabusDB.deleteSyllabus(conn, infoID);

						if (rowsAffected == 1)
							message = "Course syllabus deleted successfully";
						else
							message = "Unable to delete course syllabus";

						break;
					case insertAction:
						rowsAffected = SyllabusDB.insertSyllabus(conn, syllabus);

						if (rowsAffected == 1)
							message = "Course syllabus saved successfully";
						else
							message = "Unable to save course syllabus";

						break;
					case updateAction:
						rowsAffected = SyllabusDB.updateSyllabus(conn, syllabus);

						if (rowsAffected == 1)
							message = "Course syllabus updated successfully";
						else
							message = "Unable to update course syllabus";

						break;
				}

				session.setAttribute("aseApplicationMessage", message);

			}	// multi part form
			else{
				logger.fatal("SyllabusServlet - Not multipart/form-data request");
			}
		}
		catch(IOException e){
			logger.fatal("IOException: ploadServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		catch(org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException ue){
			logger.fatal("FileSizeLimitExceededException: SyllabusServlet - the request was rejected because its size exceeds the configured maximum");
			message = "Unable to process requested operation";
		}
		catch(Exception e){
			logger.fatal("Exception: SyllabusServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		finally {
			connectionPool.freeConnection(conn);
		}
	}
}