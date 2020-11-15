/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// GenericUploadServlet.java
//
package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
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
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

public class GenericUploadServlet extends HttpServlet implements Servlet {

	private static final long serialVersionUID = 12L;

	private static int totalSessionElements = 8;

	static Logger logger = Logger.getLogger(GenericUploadServlet.class.getName());

	public GenericUploadServlet(){
		super();
	}

	/**
	* init
	*/
	public void init() throws ServletException{}

	/**
	* destroy
	*/
	public void destroy () {
		super.destroy();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

		boolean isMultipart = false;

		boolean debug = true;

		String[] rtn = new String[totalSessionElements];

		rtn[0] = "mprt";		// program
		rtn[1] = "";
		rtn[2] = "";

		try{
			isMultipart = ServletFileUpload.isMultipartContent(request);

			if (isMultipart){
				if (debug) logger.info("------------------------> GenericUploadServlet - START");

				rtn = processUploads(request,response);

				if (rtn != null){
					HttpSession session = request.getSession(true);
					session.setAttribute("aseSession",rtn);
				}

				// returns to msg2 where ImportServlet is then called to complete the process
				String url = response.encodeURL("/core/msg2.jsp?rtn=s3");

				getServletContext().getRequestDispatcher(url).forward(request, response);

				if (debug) logger.info("------------------------> GenericUploadServlet - END");
			}

		}
		catch(Exception e){
			logger.fatal("Exception: GenericUploadServlet - " + e.toString());
		}
	}

	/**
	* Processes upload to a folder.
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request,response);
	}

	/**
	* processUploads
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public String[] processUploads(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

boolean debug = true;

		String fieldName = "";
		String fileName = "";
		String fileTitle = "";
		String contentType = "";

		String comment = "";
		String message = "";

		String aseUploadFolder = null;
		String aseUploadTempFolder = null;
		String extension = null;
		String aseWhiteList = Upload.getWhiteList();
		String aseBlackList = Upload.getBlackList();

		String uploadType = "";
		String uploadProcess = "";
		String uploadKix = "";
		String uploadTo = "";
		String campus = "";
		String user = "";

		String temp = "";
		int aseSizeThreshold = 0;

		boolean fileFound = false;
		boolean uploadError = false;

		boolean isInMemory = false;
		boolean isMultipart = false;

		long sizeInBytes = 0;
		int rowsAffected = 1;

		HttpSession session = null;

		File savedFile = null;

		String currentDrive = "";
		String documents = "";
		String uploadDestination = "";

		String fid = null;
		String mid = null;
		String attachKix = null;

		String aseCallingPage = null;

		String sq = null;
		String en = null;
		String qn = null;

		String alpha = "";
		String num = "";

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (debug) logger.info("processUploads - START");

			// defaults
			aseWhiteList = this.getInitParameter("aseWhiteList");
			aseBlackList = this.getInitParameter("aseBlackList");
			temp = this.getInitParameter("aseSizeThreshold");

			// retrieve upload information
			session = request.getSession(true);

			//campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			//user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			campus = (String)session.getAttribute("aseCampus");
			user = (String)session.getAttribute("aseUserName");

			alpha = (String)session.getAttribute("aseAlpha");
			num = (String)session.getAttribute("aseNum");

			uploadProcess = AseUtil.nullToBlank((String)session.getAttribute("aseUploadProcess"));
			uploadTo = AseUtil.nullToBlank((String)session.getAttribute("aseUploadTo"));
			aseCallingPage = AseUtil.nullToBlank((String)session.getAttribute("aseCallingPage"));

			uploadKix = (String)session.getAttribute("aseKix");
			if (uploadKix == null){
				uploadKix = SQLUtil.createHistoryID(1);
			}

			//
			// foundation?
			//
			int foundationID = 0;
			boolean isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,uploadKix);
			if(isFoundation){
				foundationID = NumericUtil.getInt(com.ase.aseutil.fnd.FndDB.getFndItem(conn,uploadKix,"id"),0);

				sq = (String)session.getAttribute("aseSq");
				en = (String)session.getAttribute("aseEn");
				qn = (String)session.getAttribute("aseQn");
			}

			String[] info = null;

			if(isFoundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,uploadKix);
			}
			else{
				info = Helper.getKixInfo(conn,uploadKix);
			}
			campus = info[Constant.KIX_CAMPUS];

			if (debug){
				logger.info("uploadKix: " + uploadKix);
				logger.info("campus: " + campus);
			}

			//
			// what type of data are we uploading
			//
			if (uploadTo.equals(Constant.BLANK)){
				uploadTo = "Outline";
				uploadDestination = "campus";
			}
			else{
				uploadDestination = uploadTo.toLowerCase();
			}

			//
			// forum upload?
			//
			fid = (String)session.getAttribute("aseFid");
			mid = (String)session.getAttribute("aseMid");

			//
			// where to upload to
			//
			currentDrive = AseUtil.getCurrentDrive();

			documents = SysDB.getSys(conn,"documents");

			aseUploadFolder = currentDrive + ":" + documents + uploadDestination;

			aseUploadTempFolder = currentDrive + ":" + documents + "temp";

			if (aseWhiteList == null){
				aseWhiteList = Upload.getWhiteList();
			}

			if (aseBlackList == null){
				aseBlackList = Upload.getBlackList();
			}

			aseSizeThreshold = Upload.getUploadSizeThreshold();

			isMultipart = ServletFileUpload.isMultipartContent(request);

			if (debug) {
				logger.info("uploadTo: " + uploadTo);
				logger.info("uploadDestination: " + uploadDestination);
				logger.info("currentDrive: " + currentDrive);
				logger.info("documents: " + documents);
				logger.info("aseUploadFolder: " + aseUploadFolder);
				logger.info("aseCallingPage: " + aseCallingPage);
				logger.info("aseUploadTempFolder: " + aseUploadTempFolder);
				logger.info("aseWhiteList: " + aseWhiteList);
				logger.info("aseBlackList: " + aseBlackList);
				logger.info("aseSizeThreshold: " + aseSizeThreshold);
				logger.info("isMultipart: " + isMultipart);
				logger.info("fid: " + fid);
				logger.info("mid: " + mid);
				logger.info("sq: " + sq);
				logger.info("en: " + en);
				logger.info("qn: " + qn);
			}

			if (isMultipart){

				DiskFileItemFactory factory = new DiskFileItemFactory();

				factory.setSizeThreshold(aseSizeThreshold);

				factory.setRepository(new File(aseUploadTempFolder));

				ServletFileUpload upload = new ServletFileUpload(factory);

				upload.setSizeMax(aseSizeThreshold);

				if (debug) logger.info("setSizeMax");

				List items = null;
				try{
					items = upload.parseRequest(request);
				}
				catch(org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException ue){
					uploadError = true;
					logger.fatal("FileSizeLimitExceededException: GenericUploadServlet - the request was rejected because its size exceeds the configured maximum");
					message = "The attached file exceeds the allowable limit of 10MB and will not be processed.";
				}
				catch(FileUploadBase.SizeLimitExceededException e){
					uploadError = true;
					logger.fatal(e.toString());
					message = "The attached file exceeds the allowable limit of 10MB and will not be processed.";
				}
				catch(Exception e){
					uploadError = true;
					logger.fatal(e.toString());
					message = e.toString();
				}

				if (!uploadError){

					if (debug) logger.info("!uploadError");

					FileItem writeItem = null;

					Iterator iter = items.iterator();
					while (iter.hasNext()) {
						FileItem item = (FileItem) iter.next();
						fieldName = AseUtil.nullToBlank(item.getFieldName());
						comment = "";

						if (item.isFormField()) {
							comment = AseUtil.nullToBlank(item.getString());
							if (comment != null && comment.length() > 0){
								if ("uploadType".equals(fieldName))
									uploadType = comment;
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
									extension = AseUtil2.getFileExtension(fileName).toLowerCase();
									if (aseBlackList.contains(extension)){
										fileFound = false;
									} // if
								} // if
							} // if
						} // if/else
					} // while

					// when an extension is available, the upload file must match
					extension = AseUtil2.getFileExtension(fileName).toLowerCase();

					String originalFileName = fileName;

					if (debug){
						logger.info("uploadType: " + uploadType);
						logger.info("uploadProcess:" + uploadProcess);
						logger.info("fileName: " + fileName);
						logger.info("fileFound: " + fileFound);
						logger.info("extension: " + extension);
					}

					if (uploadProcess.equals("mprt") && !extension.equals("csv")){
						message = "Invalid file extension. Only files of type CSV is permitted.";
						fileFound = false;
						rowsAffected = -1;
					}
					else{
						// process only if all information we need is available
						if (fileFound && !uploadError){
							if (sizeInBytes < upload.getSizeMax()){

								File fullFile = new File(fileName);

								fileTitle = fullFile.getName();

								session.setAttribute("aseUploadFileTitle", fileTitle);

								aseUploadFolder = aseUploadFolder + File.separatorChar + campus + File.separatorChar;

								//
								// determine next version number
								//
								String version = "";
								int nextVersion = 0;

								if(isFoundation){
									nextVersion = com.ase.aseutil.fnd.FndDB.getNextVersionNumber(conn,
																													campus,
																													foundationID,
																													fileTitle,
																													NumericUtil.getInt(sq,0),
																													NumericUtil.getInt(en,0),
																													NumericUtil.getInt(qn,0));
								}
								else{
									nextVersion = AttachDB.getNextVersionNumber(conn,campus,uploadKix,"","",fileTitle);
								}

								//
								// pad numeric
								//
								if (nextVersion < 10){
									version = "V0" + nextVersion;
								}
								else{
									version = "V" + nextVersion;
								}

								//
								// append version to filename
								//
								if (uploadType == null || uploadType.equals(Constant.BLANK)){
									if(isFoundation){
										fileName = alpha+"_"+num+"_"+version+"_"+fileTitle;
									}
									else{
										fileName = uploadKix+"-"+version+"-"+fileTitle;
									}
									savedFile = new File(aseUploadFolder + "/",fileName);
								}
								else{
									if(isFoundation){
										fileName = alpha+"_"+num+"_"+version+"_"+fileTitle;
									}
									else{
										fileName = user + "-" + uploadType + "-" + uploadKix + "." + extension;
									}
									savedFile = new File(aseUploadTempFolder + "/",fileName);
								}

								if (debug) logger.info("fileName: " + fileName);

								//
								// log and save data
								//
								AseUtil.logAction(conn,
														user,
														"ACTION",
														"document " + fileTitle,
														"attached as " + fileName,
														Constant.BLANK,
														campus,
														uploadKix);

								writeItem.write(savedFile);

								if (debug) logger.info("file uploaded");

								if (!uploadProcess.equals("mprt")){

									attachKix = uploadKix;

									//
									//	when attaching for a forum message, we append a message id.
									//	we know this is done only if we have no presense of an underscore
									//
									if (attachKix.indexOf("_") < 0){
										if (mid != null && mid.length() > 0 && !mid.equals(Constant.OFF))
											attachKix = attachKix + "_" + mid;
									}

									if(isFoundation){
										int fileID = com.ase.aseutil.fnd.FndDB.addFile(conn,
																								campus,
																								user,
																								foundationID,
																								fileName,
																								originalFileName,
																								NumericUtil.getInt(en,0),
																								NumericUtil.getInt(sq,0),
																								NumericUtil.getInt(qn,0),
																								nextVersion);


										if (debug) logger.info("Foundation file id: " + fileID);

										//
										// sending back for use in msg2
										//
										fid = ""+fileID;

										rowsAffected = fileID;

									}
									else{
										Attach attach = new Attach(0,
																			attachKix,
																			campus,
																			"",
																			"",
																			"",
																			fileTitle,
																			fileName,
																			sizeInBytes,
																			AseUtil.getCurrentDateTimeString(),
																			user,
																			AseUtil.getCurrentDateTimeString(),
																			uploadTo,
																			nextVersion,
																			fileTitle);
										rowsAffected = AttachDB.insertAttachment(conn,attach);
									}

								} // import does not need saving

								connectionPool.freeConnection(conn);

								rowsAffected = 1;
							}
							else{
								message = "The request was rejected because its size exceeds the configured maximum";
								rowsAffected = -1;
							}	// sizeInBytes < upload.getSizeMax
						}
						else{
							message = "Unable to process requested operation";
							rowsAffected = -1;
						} // fileFound
					} // extension check

					if (debug) logger.info("message: " + message);

				}	// uploadError
			}
			else{
				logger.fatal("GenericUploadServlet - Not multipart/form-data request");
				rowsAffected = -1;
			} // isMultipart

			if (debug) logger.info("processUploads - END");
		}
		catch(IOException e){
			logger.fatal("IOException: ploadServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		catch(Exception e){
			logger.fatal("Exception: GenericUploadServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		finally {
			if (conn != null)
				connectionPool.freeConnection(conn);
		}

		if (rowsAffected == -1 || uploadError){
			message = "Error: " + message;
		}
		else{
			message = uploadType.toLowerCase() + Constant.SEPARATOR + uploadKix;
		}

		session.setAttribute("aseApplicationMessage", message);
		String src = (String)session.getAttribute("aseUploadSrc");

		String[] rtn = new String[totalSessionElements];
		rtn[0] = uploadProcess;
		rtn[1] = src;
		rtn[2] = uploadKix;
		rtn[3] = fid;
		rtn[4] = mid;
		rtn[5] = sq;
		rtn[6] = en;
		rtn[7] = qn;

		return rtn;
	}

}