/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.ase.aseutil.uploads.AseUploadProcessing;
import com.ase.aseutil.uploads.DefaultFileTypePolicy;
import com.ase.aseutil.util.HashUtil;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NewsServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(NewsServlet.class.getName());

	// upload values
	private static String aseWhiteList = Upload.getWhiteList();
	private static String aseBlackList = Upload.getBlackList();
	private static String aseUploadFolder = null;
	private static String aseUploadTempFolder = null;
	private static int aseSizeThreshold = 0;

	final int blankAction 	= 0;
	final int cancelAction 	= 1;
	final int deleteAction 	= 2;
	final int insertAction 	= 3;
	final int updateAction 	= 4;
	final int uploadAction 	= 5;

	/**
	* private data
	*/
	private String dirName;

	private boolean debug = false;

	/**
	* getters and settings
	*/
	public void init() throws ServletException {}

	public String getDirName() {
		return this.dirName;
	}

	public void setDirName(String value) {
		this.dirName = value;
	}

	public boolean getDebug() {
		return this.debug;
	}

	public void setDebug(boolean value) {
		this.debug = value;
	}

	/**
	* init
	*/
	public void init(ServletConfig config) throws ServletException {

		super.init(config);

		setDebug(false);

		String dirName = config.getInitParameter("uploadDir");

		if (dirName == null) {
			throw new ServletException("Please supply uploadDir parameter");
		}
		else{

			// should point to drive:\\tomcat\\webapps\\centraldocs\\docs\\uploads\\

			// convert from / to \

			dirName = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps" + dirName.replace("/","\\") + "\\";
		}

		setDirName(dirName);
	}

	/**
	*/
	public void destroy() {}

	/**
	* Processes upload to a folder.
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		if (getDebug()) logger.info("-------------- START ");

		String rtn = null;
		String mnu = null;

		int rowsAffected = 0;

		HttpSession session = request.getSession(true);

		try{
			rtn = (String)session.getAttribute("aseCallingPage");
			if (getDebug()) logger.info("rtn: " + rtn);

			mnu = (String)session.getAttribute("aseMnu");
			if (getDebug()) logger.info("mnu: " + mnu);

			WebSite website = new WebSite();

			// mnu = 1 for form data entry
			// mnu = 2 for file upload
			// mnu = 3 for delete

			if (mnu.equals("2")){

				String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
				if (getDebug()) logger.info("campus: " + campus);

				String dirName = getDirName();
				if (getDebug()) logger.info("dirName: " + dirName);

				String uploadDirName = dirName + campus;
				if (getDebug()) logger.info("uploadDirName: " + uploadDirName);

				try{
					MultipartRequest multi = new MultipartRequest(request,
																					uploadDirName,
																					10*1024*1024,
																					"ISO-8859-1",
																					new DefaultFileRenamePolicy(),
																					new DefaultFileTypePolicy());

					if (multi.getFileNameCount() > 0){

						if (getDebug()) logger.info("multi.getFileNameCount(): " + multi.getFileNameCount());

						String fileName = multi.getFileName("attach");
						if (getDebug()) logger.info("fileName: " + fileName);

						if (fileName != null){

							int id = multi.getParameter("lid",0);

							session.setAttribute("aseKey", "" + id);

							// fileName is the path + name. we only want to save the file name only

							fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
							if (getDebug()) logger.info("fileName: " + fileName);

							rowsAffected = saveAttachment(session,id,fileName);

						} // fileName != null

					}

					multi = null;
				}
				catch(IOException e){
					logger.fatal("Exception: NewsServlet - " + e.toString());
					session.setAttribute("aseApplicationMessage", "Unable to process requested operation. " + e.toString());
				}
				catch(Exception e){
					logger.fatal("Exception: NewsServlet - " + e.toString());
					session.setAttribute("aseApplicationMessage", "Unable to process requested operation. " + e.toString());
				}

			}
			else{
				rowsAffected = getNews(request,session);
			}

		}
		catch(Exception e){
			logger.fatal("Exception: NewsServlet - " + e.toString());
			session.setAttribute("aseApplicationMessage", "Unable to process requested operation");
		}

		// help determine where to redirect upon return to JSP

		if (rtn.equals("NEWS")){
			if (mnu.equals("1")){
				rtn = "newsidx1";
			}
			else if (mnu.equals("2")){
				rtn = "newsidx2";
			}
		}

		String url = null;

		// what driver to use
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg2.jsp?rtn=" + rtn);
		}

		if (getDebug()) logger.info("-------------- END");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	* doPost
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}

	/**
	* getNews
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public int getNews(HttpServletRequest request,HttpSession session) throws ServletException, IOException{

		String formInput = "";
		String fieldName = "";
		String fileName = "";
		String fileTitle = "";
		String contentType = "";

		// form values
		String infoTitle = null;
		String infoContent = null;
		String startDate = null;
		String enddDate = null;
		String lid = null;
		String uploadType = null;

		String cancel = null;
		String delete = null;
		String insert = null;
		String submit = null;
		String upload = null;

		// misc values
		String kix = "";
		String url = "";
		String user = "";
		String campus = "";
		String message = "";
		String uploadedFileName = "";

		String sAction = null;
		String rtn = null;
		int iAction = 0;

		int rowsAffected = 1;

		try{
			WebSite website = new WebSite();

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			uploadType = (String)session.getAttribute("aseCallingPage");

			if (getDebug()){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("uploadType: " + uploadType);
			}

			infoTitle = website.getRequestParameter(request,"infotitle","");
			infoContent = website.getRequestParameter(request,"infocontent","");
			startDate = website.getRequestParameter(request,"startdate","");
			enddDate = website.getRequestParameter(request,"enddate","");
			if (getDebug()){
				logger.info("infoTitle: " + infoTitle);
				logger.info("infoContent: " + infoContent);
				logger.info("startDate: " + startDate);
				logger.info("enddDate: " + enddDate);
			}

			lid = website.getRequestParameter(request,"lid","");
			if (getDebug()){
				logger.info("lid: " + lid);
			}
			session.setAttribute("aseKey", "" + lid);

			cancel = website.getRequestParameter(request,"aseCancel","");
			delete = website.getRequestParameter(request,"aseDelete","");
			insert = website.getRequestParameter(request,"aseInsert","");
			submit = website.getRequestParameter(request,"aseSubmit","");
			upload = website.getRequestParameter(request,"aseUpload","");
			if (getDebug()){
				logger.info("cancel: " + cancel);
				logger.info("delete: " + delete);
				logger.info("insert: " + insert);
				logger.info("submit: " + submit);
				logger.info("upload: " + upload);
			}

			News news = new News();
			news.setId(lid);
			news.setTitle(infoTitle);
			news.setContent(infoContent);
			news.setStartDate(startDate);
			news.setEndDate(enddDate);
			news.setAuditBy(user);
			news.setCampus(campus);
			news.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			if (getDebug()){
				logger.info("news: " + news);
			}

			if (cancel != null && cancel.length() > 0)	sAction = cancel;
			if (delete != null && delete.length() > 0)	sAction = delete;
			if (insert != null && insert.length() > 0)	sAction = insert;
			if (submit != null && submit.length() > 0)	sAction = submit;
			if (upload != null && upload.length() > 0)	sAction = upload;

			if (sAction != null){
				sAction = sAction.trim();
				if (getDebug()) logger.info("sAction: " + sAction);
				if (sAction.equalsIgnoreCase("cancel")) {	iAction = cancelAction; }
				if (sAction.equalsIgnoreCase("delete") || sAction.equalsIgnoreCase("yes")) {	iAction = deleteAction;	}
				if (sAction.equalsIgnoreCase("insert")) {	iAction = insertAction;	}
				if (sAction.equalsIgnoreCase("submit")) {	iAction = updateAction;	}
				if (sAction.equalsIgnoreCase("upload")) {	iAction = uploadAction;	}
			}

			if (getDebug()) logger.info("iAction: " + iAction);

			rowsAffected = saveNews(session,news,lid,iAction);

		}
		catch(Exception e){
			logger.fatal("Exception: NewsServlet - " + e.toString());
			message = "Unable to process requested operation";
		}

		return rowsAffected;
	}

	/**
	* saveNews
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	*/
	public int saveNews(HttpSession session,News news,String lid,int iAction) throws ServletException, IOException{

		int rowsAffected = 1;

		AsePool connectionPool = null;

		String message = "";

		Connection conn = null;

		try{
			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			connectionPool = AsePool.getInstance();

			conn = connectionPool.getConnection();

			switch (iAction) {
				case blankAction:
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = NewsDB.deleteNews(conn,campus,lid);

					if (rowsAffected == 1)
						message = "News deleted successfully";
					else
						message = "Unable to delete news item";

					break;
				case insertAction:
					rowsAffected = NewsDB.insertNews(conn, news);

					lid = "" + NewsDB.getLastIDByCampus(conn,campus);
					session.setAttribute("aseKey", lid);

					if (rowsAffected == 1)
						message = "News inserted successfully";
					else
						message = "Unable to insert news item";

					break;
				case updateAction:
					rowsAffected = NewsDB.updateNews(conn, news);

					if (rowsAffected == 1)
						message = "News updated successfully";
					else
						message = "Unable to update news item";

					break;
			}

		}
		catch(Exception e){
			logger.fatal("Exception: NewsServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		finally {
			if (conn != null){
				connectionPool.freeConnection(conn);
			}

			session.setAttribute("aseApplicationMessage", message);
		}

		return rowsAffected;
	}

	/**
	 * saveAttachment
	 * <p>
	 * @param	session		HttpSession
	 * @param	id				int
	 * @param	attachment	String
	 * <p>
	 * @return	int
	 */
	public int saveAttachment(HttpSession session,int id,String attachment) throws ServletException, IOException{

		int rowsAffected = 1;

		AsePool connectionPool = null;

		String message = "";

		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();

			conn = connectionPool.getConnection();

			rowsAffected = NewsDB.updateAttachment(conn,id,attachment);

			if (rowsAffected == 1)
				message = "News updated successfully";
			else
				message = "Unable to update news item";

		}
		catch(Exception e){
			logger.fatal("Exception: NewsServlet - " + e.toString());
			message = "Unable to process requested operation";
		}
		finally {
			if (conn != null){
				connectionPool.freeConnection(conn);
			}

			session.setAttribute("aseApplicationMessage", message);
		}

		return rowsAffected;
	}

}