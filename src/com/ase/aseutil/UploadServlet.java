/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// UploadServlet.java
//
package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

public class UploadServlet extends HttpServlet implements Servlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(UploadServlet.class.getName());

	private String url = "";
	private String message = "";
	private int rowsAffected = 0;
	private static boolean debug = false;

	public UploadServlet(){
		super();
	}

	/**
	* init
	*/
	public void init() throws ServletException{
	}

    public void destroy () {
		super.destroy();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

		PrintWriter  out = response.getWriter();
		HttpSession  session = request.getSession();
		AseProgressListener  listener = null;
		StringBuffer buf = new StringBuffer();

		long bytesRead = 0, contentLength = 0;

		// Make sure the session has started
		if (session == null){
			return;
		}
		else if (session != null){
			// Check to see if we've created the listener object yet
			listener = (AseProgressListener)session.getAttribute("LISTENER");

			if (listener == null){
				return;
			}
			else{
				// Get the meta information
				bytesRead = listener.getBytesRead();
				contentLength = listener.getContentLength();
			}
		}

		/*
		* XML Response Code
		*/
		response.setContentType("text/xml");

		buf.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		buf.append("<response>\n");
		buf.append("\t<bytes_read>" + bytesRead + "</bytes_read>\n");
		buf.append("\t<content_length>" + contentLength + "</content_length>\n");

		// Check to see if we're done
		if (bytesRead == contentLength) {
			buf.append("\t<finished />\n");

			// No reason to keep listener in session since we're done
			session.setAttribute("LISTENER", null);
		}
		else{
			// Calculate the percent complete
			long percentComplete = ((100 * bytesRead) / contentLength);

			buf.append("\t<percent_complete>" + percentComplete + "</percent_complete>\n");
		}

		buf.append("</response>\n");

		out.println(buf.toString());
		out.flush();
		out.close();
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
		HttpSession session = null;
		String kix = "";

		try{

			session = request.getSession(true);
			kix = (String)session.getAttribute("aseKix");

			isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart){
				processUploads(request,response,kix);
			}
			else{
				processRequest(request,response,kix);
			}
		}
		catch(Exception e){
			logger.fatal("Exception: UploadServlet - " + e.toString());
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg2.jsp?rtn=crsattach&kix="+kix);
		}

		session.setAttribute("aseApplicationMessage", message);

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	* processRequest
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void processRequest(HttpServletRequest request, HttpServletResponse response,String kix)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		int iAction = 0;
		int id = 0;
		String rtn = "";

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			WebSite website = new WebSite();

			kix = website.getRequestParameter(request,"kix");
			id = website.getRequestParameter(request,"id",0);
			rtn = website.getRequestParameter(request,"rtn","");
			String action = website.getRequestParameter(request,"act");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseClose");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSave");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			if (sAction.equalsIgnoreCase("close")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("delete")) iAction = deleteAction;
			if (sAction.equalsIgnoreCase("insert")) iAction = insertAction;
			if (sAction.equalsIgnoreCase("save")) iAction = updateAction;

			if ("r".equals(action)){
				String aseCancel = website.getRequestParameter(request, "aseCancel");
				String aseDelete = website.getRequestParameter(request, "aseDelete");

				if (aseCancel != null && aseCancel.length() > 0) iAction = cancelAction;
				if (aseDelete != null && aseDelete.length() > 0) iAction = deleteAction;
			}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = AttachDB.deleteAttachment(conn,kix,id);

					if (rowsAffected == 1)
						message = "Attachment was deleted successfully";
					else
						message = "Unable to delete attachment";

					break;
			}

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			// rtn2 is having to go back a step further depending on the
			url = response.encodeURL("/core/msg2.jsp?rtn=crsattach&kix="+kix+"&id="+id+"&rtn2="+rtn);
		}

		session.setAttribute("aseApplicationMessage", message);
	}

	/**
	* processUploads
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void processUploads(HttpServletRequest request, HttpServletResponse response,String kix) throws ServletException, IOException{

		String alpha = "";
		String num = "";
		String comment = "";
		String fieldName = "";
		String fileName = "";
		String fileTitle = "";
		String contentType = "";

		String campus = "";
		String user = "";

		String aseUploadFolder = null;
		String aseUploadTempFolder = null;
		String extension = null;
		String aseWhiteList = Upload.getWhiteList();
		String aseBlackList = Upload.getBlackList();

		String temp = "";
		int aseSizeThreshold = 0;

		boolean fileFound = false;
		boolean uploadError = false;

		boolean isInMemory = false;
		boolean isMultipart = false;

		long sizeInBytes = 0;
		int rowsAffected = 1;

		AsePool connectionPool = null;
		Connection conn = null;

		HttpSession session = null;
		WebSite website = null;

		String currentDrive = "";
		String documents = "";

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			website = new WebSite();
			session = request.getSession(true);

			user = website.getRequestParameter(request,"aseUserName","",true);
			campus = website.getRequestParameter(request,"aseCampus","",true);

			// defaults
			aseWhiteList = this.getInitParameter("aseWhiteList");
			aseBlackList = this.getInitParameter("aseBlackList");
			temp = this.getInitParameter("aseSizeThreshold");

			currentDrive = AseUtil.getCurrentDrive();
			documents = SysDB.getSys(conn,"documents");

			// make sure values are valid
			if (aseUploadFolder == null){
				aseUploadFolder = currentDrive + ":" + documents + "campus";
			}
			else
				aseUploadFolder = aseUploadFolder.replace('\\', '/').replace('/', File.separatorChar);

			if (aseUploadTempFolder == null){
				aseUploadTempFolder = currentDrive + ":" + documents + "temp";
			}
			else
				aseUploadTempFolder = aseUploadTempFolder.replace('\\', '/').replace('/', File.separatorChar);

			if (aseWhiteList == null)
				aseWhiteList = Upload.getWhiteList();

			if (aseBlackList == null)
				aseBlackList = Upload.getBlackList();

			debug = DebugDB.getDebug(conn,"UploadServlet");
			if (debug){
				logger.info("------------------- UploadServlet STARTS");
				logger.info("currentDrive: " + currentDrive);
				logger.info("documents: " + documents);
				logger.info("aseUploadFolder: " + aseUploadFolder);
				logger.info("aseUploadTempFolder: " + aseUploadTempFolder);
				logger.info("aseWhiteList: " + aseWhiteList);
				logger.info("aseBlackList: " + aseBlackList);
			}

			aseSizeThreshold = Upload.getUploadSizeThreshold();
			if (debug) logger.info("aseSizeThreshold - " + aseSizeThreshold);

			AseProgressListener listener = new AseProgressListener();
			session.setAttribute("LISTENER", listener);
			if (debug) logger.info("LISTENER set");

			aseUploadFolder = aseUploadFolder + File.separatorChar + campus + File.separatorChar;
			if (debug) logger.info("aseUploadFolder - " + aseUploadFolder);

			isMultipart = ServletFileUpload.isMultipartContent(request);

			if (isMultipart){
				if (debug) logger.info("isMultipart - " + isMultipart);

				DiskFileItemFactory factory = new DiskFileItemFactory();
				factory.setSizeThreshold(aseSizeThreshold);
				factory.setRepository(new File(aseUploadTempFolder));

				ServletFileUpload upload = new ServletFileUpload(factory);
				if (debug) logger.info("got upload object");

				upload.setSizeMax(aseSizeThreshold);
				if (debug) logger.info("setSizeMax");

				upload.setProgressListener(listener);
				if (debug) logger.info("setProgressListener");

				List items = null;
				try{
					items = upload.parseRequest(request);
					if (debug) logger.info("upload.parseRequest(request)");
				}
				catch(org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException ue){
					uploadError = true;
					logger.fatal("FileSizeLimitExceededException: UploadServlet - the request was rejected because its size exceeds the configured maximum");
					message = "The attached file exceeds the allowable limit of 10MB and will not be processed.";
				}
				catch(Exception ex){
					uploadError = true;
					logger.fatal("FileSizeLimitExceededException: UploadServlet - the request was rejected because its size exceeds the configured maximum");
					message = "The attached file exceeds the allowable limit of 10MB and will not be processed.";
				}

				if (!uploadError){
					FileItem writeItem = null;

					Iterator iter = items.iterator();
					while (iter.hasNext()) {
						FileItem item = (FileItem) iter.next();
						fieldName = AseUtil.nullToBlank(item.getFieldName());
						comment = "";

						if (item.isFormField()) {
							comment = AseUtil.nullToBlank(item.getString());
							if (comment != null && comment.length() > 0){
								if ("alpha".equals(fieldName))
									alpha = comment;
								else  if ("fileTitle".equals(fieldName))
									fileTitle = comment;
								else if ("kix".equals(fieldName))
									kix = comment;
								else if ("num".equals(fieldName))
									num = comment;

								if (debug) logger.info("TEXT: " + fieldName + " - " + comment);
							}
						}
						else {

							if (!uploadError){
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
										if (debug) logger.info("black listed file: " + fieldName);
									} // if
								} // if
							} // if
						} // if/else
					} // while

					// process only if all information we need is available
					if (fileFound && !uploadError){

						if (debug) logger.info("fileFound");

						if (sizeInBytes < upload.getSizeMax()){

							if (debug) logger.info("sizeInBytes < upload.getSizeMax()");

							File fullFile = new File(fileName);

							if (fileTitle == null || fileTitle.length() == 0)
								fileTitle = fullFile.getName();

							String version = "";
							int nextVersion = AttachDB.getNextVersionNumber(conn,campus,kix,alpha,num,fullFile.getName());
							if (nextVersion < 10)
								version = "V0" + nextVersion;
							else
								version = "V" + nextVersion;

							fileName = kix+"-"+alpha+"-"+num+"-"+version+"-"+fullFile.getName();

							File savedFile = new File(aseUploadFolder + "/",fileName);
							writeItem.write(savedFile);

							Attach attach = new Attach(0,
																kix,
																campus,
																alpha,
																num,
																"",
																fileTitle,
																fileName,
																sizeInBytes,
																AseUtil.getCurrentDateTimeString(),
																user,
																AseUtil.getCurrentDateTimeString(),
																"Outline",
																nextVersion,
																fullFile.getName());
							rowsAffected = AttachDB.insertAttachment(conn,attach);

							if (rowsAffected==1)
								message = "File uploaded successfully";
							else if (rowsAffected==2)
								message = "File replaced successfully";
							else
								message = "File upload error";

							if (debug) logger.info("File: " + fieldName + " - " + fileName);
						}
						else{
							message = "The request was rejected because its size exceeds the configured maximum";
						}	// sizeInBytes < upload.getSizeMax
					}
					else{
						message = "Unable to process requested operation";
					} // fileFound
				}	// uploadError
			}
			else{
				logger.fatal("Not multipart/form-data request");
			} // isMultipart

			if (debug) logger.info("------------------- UploadServlet ENDS");
		}
		catch(IOException e){
			logger.fatal("IOException: ploadServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		catch(Exception e){
			logger.fatal("Exception: UploadServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		finally {
			connectionPool.freeConnection(conn);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg2.jsp?rtn=crsattach&kix="+kix);
		}

		session.setAttribute("aseApplicationMessage", message);

	}

}