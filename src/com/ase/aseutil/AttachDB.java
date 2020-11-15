/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static boolean attachmentExists(Connection conn,String kix) throws SQLException {
 *	public static int countAttachments(Connection conn,String kix) throws SQLException {
 *	public static int countAttachments(Connection conn,String kix,String alpha,String num) throws SQLException {
 *	public static int deleteAttachment(Connection connection,String kix,int id) throws SQLException {
 *	public static int deleteUpload(Connection conn,String campus,String uploadType,int id) throws SQLException {
 * public static String getAttachmentAsHTMLList(Connection connection,String kix)
 *	public static Attach getAttachment(Connection connection,String kix,int id) throws SQLException {
 *	public static String listAttachmentsByCategoryKix(Connection conn,String category,String kix){
 *	public static String listAttachmentsVersions(Connection conn,String kix,int docId){
 *
 * @author ttgiang
 */

//
// AttachDB.java
//
package com.ase.aseutil;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class AttachDB {

	static Logger logger = Logger.getLogger(AttachDB.class.getName());

	public AttachDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param connection	Connection
	 * @param fileName	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection connection,String fileName) throws SQLException {

		String sql = "SELECT id FROM tblAttach WHERE filename like '%"+fileName+"%'";
		PreparedStatement ps = connection.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * getAttachmentAsHTMLList
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return String
	 */
	public static String getAttachmentAsHTMLList(Connection connection,String kix) throws Exception {

		return getAttachmentAsHTMLList(connection,kix,null);

	}

	/*
	 * getAttachmentAsHTMLList
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return String
	 */
	public static String getAttachmentAsHTMLList(Connection connection,String kix,String src) throws Exception {

		int version = 0;
		String sql = "";
		StringBuffer contents = new StringBuffer();
		boolean found = false;
		String temp = "";
		String campus = "";
		String fileDescr = "";
		String fileName = "";
		String image = "";
		String extension = "";
		String folder = "campus";

		if (src == null || src.length() == 0){
			src = "Outline";
			folder = "campus";
		}
		else if (src.equals("forum")){
			folder = "forum";
		}

		sql = "SELECT campus,filedescr,filename,version "
			+ "FROM tblAttach, "
			+ "(SELECT DISTINCT fullname, MAX(version) AS lastversion "
			+ "FROM tblAttach "
			+ "GROUP BY fullname) derivedtable "
			+ "WHERE tblAttach.historyid=? "
			+ "AND tblAttach.fullname = derivedtable.fullname "
			+ "AND tblAttach.version = derivedtable.lastversion "
			+ "AND category=? "
			+ "ORDER BY filedescr ";

		try {

			String documentsURL = SysDB.getSys(connection,"documentsURL");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				fileDescr = AseUtil.nullToBlank(rs.getString("filedescr"));
				fileName = documentsURL + folder + "/" + campus + "/" + AseUtil.nullToBlank(rs.getString("fileName"));

				extension = AseUtil2.getFileExtension(fileName);

				if (extension.indexOf(Constant.FILE_EXTENSIONS) == -1){
					extension = "default.icon";
				}

				image = "<img src=\"/central/images/ext/"+extension+".gif\" border=\"0\">&nbsp;";

				fileDescr = "<a href=\""+fileName+"\" target=\"_blank\" class=\"linkcolumn\">"+fileDescr+"</a>";

				contents.append("<li class=\"dataColumn\">" + image + fileDescr + "</li>");
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table name=\"tableGetAttachmentAsHTMLList\" border=\"0\" width=\"98%\">" +
					"<tr><td><br><ul>" +
					contents.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("AttachDB: getAttachmentAsHTMLList - " + e.toString());
		}

		return temp;
	}

	/*
	 * getContentForEdit
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * <p>
	 * @return String
	 */
	public static String getContentForEdit(Connection connection,String kix) throws SQLException {

		String sql = "";
		int id = 0;
		int version = 0;
		String campus = "";
		String extension = "";
		String fileDescr = "";
		String fileName = "";
		String fileDate = "";
		String image = "";
		StringBuffer buf = new StringBuffer();

		sql = "SELECT id,filedescr,filedate,filename,campus,version "
			+ "FROM tblAttach "
			+ "WHERE historyid=? "
			+ "AND category='Outline' "
			+ "ORDER BY fullname,version";

		try {
			String documentsURL = SysDB.getSys(connection,"documentsURL");

			AseUtil aseUtil = new AseUtil();
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>"
				+ "<td width=\"67%\" valign=\"top\" class=\"textblackTH\">File Name</td>"
				+ "<td width=\"10%\" valign=\"top\" class=\"textblackTH\">Version</td>"
				+ "<td width=\"20%\" valign=\"top\" class=\"textblackTH\">Upload Date</td><tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				version = rs.getInt("version");
				campus = aseUtil.nullToBlank(rs.getString("campus"));
				fileDescr = aseUtil.nullToBlank(rs.getString("filedescr"));
				fileName = documentsURL + "campus/" + campus + "/" + aseUtil.nullToBlank(rs.getString("filename"));
				fileDate = aseUtil.ASE_FormatDateTime(rs.getString("filedate"),Constant.DATE_DATETIME);

				extension = AseUtil2.getFileExtension(fileName);

				if (extension.indexOf(Constant.FILE_EXTENSIONS) == -1)
					extension = "default.icon";

				image = "<img src=\"/central/images/ext/" + extension +".gif\" border=\"0\">&nbsp;";

				fileDescr = "<a href=\""+fileName+"\" target=\"_blank\" class=\"linkcolumn\">" + image + "&nbsp;" + fileDescr + "</a>";

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
					+ "<img src=\"../images/del.gif\" border=\"0\" fileName=\"delete entry\" alt=\"delete entry\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + kix + "\'," + id + ");\">"
					+ "<td valign=\"top\" class=\"dataColumn\">" + fileDescr + "</td>"
					+ "<td valign=\"top\" class=\"dataColumn\" nowrap>" + version + "</td>"
					+ "<td valign=\"top\" class=\"dataColumn\" nowrap>" + fileDate + "</td></tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("AttachDB: getContentForEdit - " + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("AttachDB: getContentForEdit - " + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/**
	 * getFileAttachmentID
	 * <p>
	 * @param connection	Connection
	 * @param campus		String
	 * @param kix			String
	 * @param fileName	String
	 * <p>
	 * @return int
	 */
	public static int getFileAttachmentID(Connection connection,String campus,String kix,String fileName) throws SQLException {

		int id = -1;

		try{
			String sql = "SELECT id "
				+ "FROM tblAttach "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND filename=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,fileName);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("id");
				//logger.info("AttachDB - getFileAttachmentID: matching file upload found");
			}
			else{
				//logger.info("AttachDB - getFileAttachmentID: matching file upload not found");
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: getFileAttachmentID " + e.toString());
		}

		return id;
	}

	/**
	 * insertAttachment
	 * <p>
	 * @param	conn		Connection
	 * @param	attach	Attach
	 * <p>
	 * @return	int (1-new file upload; 2-same file upload)
	 */
	public static int insertAttachment(Connection conn, Attach attach) {

		String sql = "";

		int rowsAffected = 0;
		int attachmentID = 0;
		int newFile = 0;

		PreparedStatement ps = null;

		try {
			// if a similar file was uploaded, don't save as a new entry.
			// -1 tells insert to update the current record
			attachmentID = getFileAttachmentID(conn,attach.getCampus(),attach.getHistoryid(),attach.getFileName());
			if (attachmentID>0){
				sql = "UPDATE tblAttach "
					+ "SET filedescr=?,filesize=?,filedate=?,auditby=?,auditdate=?,version=?,fullname=? "
					+ "WHERE id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,attach.getFileDescr());
				ps.setDouble(2,attach.getFileSize());
				ps.setString(3,attach.getFileDate());
				ps.setString(4,attach.getAuditBy());
				ps.setString(5,attach.getAuditDate());
				ps.setInt(6,attachmentID);
				ps.setInt(7,attach.getVersion());
				ps.setString(8,attach.getFullName());
				newFile = 2;
			}
			else{
				sql = "INSERT INTO tblAttach(historyid,campus,coursealpha,coursenum,coursetype,filedescr,filename,filesize,filedate,auditby,category,id,version,fullname) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,attach.getHistoryid());
				ps.setString(2,attach.getCampus());
				ps.setString(3,attach.getCourseAlpha());
				ps.setString(4,attach.getCourseNum());
				ps.setString(5,attach.getCourseType());
				ps.setString(6,attach.getFileDescr());
				ps.setString(7,attach.getFileName());
				ps.setDouble(8,attach.getFileSize());
				ps.setString(9,attach.getFileDate());
				ps.setString(10,attach.getAuditBy());
				ps.setString(11,attach.getCategory());
				ps.setInt(12,getNextAttachmentID(conn));
				ps.setInt(13,attach.getVersion());
				ps.setString(14,attach.getFullName());
				newFile = 1;
			}
			rowsAffected = ps.executeUpdate();

			if (rowsAffected==1)
				rowsAffected = newFile;

			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: insertAttachment " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getAttachment
	 * <p>
	 * @param connection	Connection
	 * @param kix			String
	 * @param id			int
	 * <p>
	 * @return Attach
	 */
	public static Attach getAttachment(Connection connection,String kix,int id) throws SQLException {

		Attach attach = null;

		try{
			String sql = "SELECT  historyid, campus, coursealpha, coursenum, coursetype, filedescr, filename, filesize, filedate, auditby, auditdate, category "
				+ "FROM tblAttach "
				+ "WHERE historyid=? "
				+ "AND id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				attach = new Attach();
				attach.setId(id);
				attach.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
				attach.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				attach.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				attach.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				attach.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				attach.setCourseType(AseUtil.nullToBlank(rs.getString("coursetype")));
				attach.setFileDescr(AseUtil.nullToBlank(rs.getString("filedescr")));
				attach.setFileName(AseUtil.nullToBlank(rs.getString("filename")));
				attach.setFileSize(rs.getDouble("filesize"));
				attach.setFileDate(AseUtil.nullToBlank(rs.getString("filedate")));
				attach.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				attach.setAuditDate(AseUtil.nullToBlank(rs.getString("auditdate")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: getAttachment " + e.toString());
		}

		return attach;
	}

	/**
	 * deleteAttachment
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param id		int
	 * <p>
	 * @return int
	 */
	public static int deleteAttachment(Connection conn,String kix,int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		String fileName = "";
		String aseUploadFolder = "";
		String currentDrive = "";
		String campus = "";
		String sql = "";
		String root = "";

		try{
			AseUtil aseUtil = new AseUtil();

			Attach attach = getAttachment(conn,kix,id);
			if (attach != null){

				logger.info("attachment found");

				campus = attach.getCampus();
				fileName = attach.getFileName();

				if (fileName != null && fileName.length() > 0){

					aseUploadFolder  = SysDB.getSys(conn,"aseUploadFolder");
					root = SysDB.getSys(conn,"root");

					logger.info("aseUploadFolder: " + aseUploadFolder);
					logger.info("root: " + root);

					if (aseUploadFolder != null && aseUploadFolder.length() > 0){
						aseUploadFolder = aseUploadFolder.replace('\\', '/').replace('/', File.separatorChar);

						if (root != null && root.length() > 0)
							root = root.replace('\\', '/').replace('/', File.separatorChar);

						try {
							currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
							logger.info("currentDrive: " + currentDrive);

							fileName = currentDrive
								+ ":"
								+ root
								+ aseUploadFolder
								+ campus
								+ File.separatorChar
								+ fileName;

							logger.info("fileName: " + fileName);

							File target = new File(fileName);

							if (!target.exists()){
								logger.info(fileName + " does not exist to delete");
								rowsAffected = 1;
							}
							else{
								if (target.delete()){
									logger.info(fileName + " deleted successfully");
									rowsAffected = 1;
								}
								else
									logger.info("Unable to delete " + fileName);
							}
						}
						catch (SecurityException e) {
							logger.fatal("Unable to delete " + fileName + "(" + e.getMessage() + ")");
						}

						if (rowsAffected==1){
							sql = "DELETE "
								+ "FROM tblAttach "
								+ "WHERE historyid=? "
								+ "AND id=?";
							PreparedStatement ps = conn.prepareStatement(sql);
							ps.setString(1,kix);
							ps.setInt(2,id);
							rowsAffected = ps.executeUpdate();
							ps.close();
						}
					}	// folder location found

				}	// file name is valid

			}	// attachment available

		} catch (SQLException se) {
			logger.fatal("AttachDB: deleteAttachment " + se.toString());
		} catch (Exception e) {
			logger.fatal("AttachDB: deleteAttachment " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteUpload
	 * <p>
	 * @param conn			Connection
	 * @param campus		String
	 * @param uploadType	String
	 * @param id			int
	 * <p>
	 * @return int
	 */
	public static int deleteUpload(Connection conn,String campus,String uploadType,int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		String fileName = "";
		String aseGenericUploadFolder = "";
		String currentDrive = "";
		String sql = "";
		String root = "";

		try{
			AseUtil aseUtil = new AseUtil();

			fileName = campus+"-"+uploadType+"-"+id+"-"+NewsDB.getNewsFileName(conn,id);

			if (fileName != null && fileName.length() > 0){

				aseGenericUploadFolder  = SysDB.getSys(conn,"aseGenericUploadFolder");
				root = SysDB.getSys(conn,"root");

				logger.info("deleteUpload - aseGenericUploadFolder: " + aseGenericUploadFolder);
				logger.info("deleteUpload - root: " + root);

				if (aseGenericUploadFolder != null && aseGenericUploadFolder.length() > 0){
					aseGenericUploadFolder = aseGenericUploadFolder.replace('\\', '/').replace('/', File.separatorChar);

					if (root != null && root.length() > 0)
						root = root.replace('\\', '/').replace('/', File.separatorChar);

					try {
						currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
						logger.info("deleteUpload - currentDrive: " + currentDrive);

						fileName = currentDrive
							+ ":"
							+ root
							+ aseGenericUploadFolder
							+ campus
							+ File.separatorChar
							+ fileName;

						logger.info("deleteUpload - fileName: " + fileName);

						File target = new File(fileName);

						if (!target.exists()){
							logger.info("deleteUpload - " + fileName + " does not exist to delete");
							rowsAffected = 1;
						}
						else{
							if (target.delete()){
								logger.info("deleteUpload - " + fileName + " deleted successfully");
								rowsAffected = 1;
							}
							else
								logger.info("deleteUpload - Unable to delete " + fileName);
						}
					}
					catch (SecurityException e) {
						logger.fatal("Unable to delete " + fileName + "(" + e.getMessage() + ")");
					}
				}	// folder location found
			}	// file name is valid
		} catch (Exception e) {
			logger.fatal("AttachDB: deleteUpload " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNextAttachmentID
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextAttachmentID(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblAttach";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: getNextAttachmentID\n" + e.toString());
		}

		return id;
	}

	/*
	 * attachmentExists
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean attachmentExists(Connection conn,String kix) throws SQLException {

		boolean exists = false;
		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter FROM tblAttach WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			if (counter>0)
				exists = true;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: attachmentExists\n" + e.toString());
		}

		return exists;
	}

	/*
	 * getNextVersionNumber
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	fullName		String
	 *	<p>
	 *	@return int
	 */
	public static int getNextVersionNumber(Connection connection,
														String campus,
														String kix,
														String alpha,
														String num,
														String fullName) throws SQLException {

		int version = 0;

		try {
			String sql = "SELECT MAX(version) + 1 AS maxid "
				+ "FROM tblAttach "
				+ "WHERE campus=? AND historyid=? AND coursealpha=? AND coursenum=? AND fullname=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,fullName);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				version = rs.getInt("maxid");

			if (version==0)
				version = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: getNextVersionNumber - " + e.toString());
		}

		return version;
	}

	/**
	 * listProgramAttachments
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	docID		int
	 * @param	r1			String
	 * @param	r2			String
	 * <p>
	 * @return	String
	 */
	public static String listAttachmentsVersions(Connection conn,
																String campus,
																String kix,
																int docId,
																String r1,
																String r2){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";

		int id = 0;
		String category = "";
		String fullName = "";
		String fileName = "";
		int version = 0;
		long fileSize = 0;
		String fileDate = "";
		String auditBy = "";

		String link = "";
		String rowColor = "";
		boolean found = false;
		int j = 0;

		if ((Constant.PROGRAM).equals(r1))
			r1 = "pedt";
		else if ((Constant.COURSE).equals(r1))
			r1 = "c";
		else if ((Constant.FORUM).equals(r1))
			r1 = "f";

		if (("attchst").equals(r2))
			r2 = "ah";

		try{
			AseUtil aseUtil = new AseUtil();

			String documentsURL = SysDB.getSys(conn,"documentsURL");

			String sql = "SELECT id, category, fullname, version, filesize, filedate, auditby, filename "
				+ "FROM tblAttach "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND fullname IN "
				+ "(SELECT fullname FROM tblAttach WHERE id=?) "
				+ "ORDER BY version";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,docId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				id = rs.getInt("id");
				category = AseUtil.nullToBlank(rs.getString("category"));
				fullName = AseUtil.nullToBlank(rs.getString("fullname"));
				version = rs.getInt("version");
				fileSize = rs.getLong("fileSize");
				fileDate = aseUtil.ASE_FormatDateTime(rs.getString("filedate"),Constant.DATE_DATETIME);
				auditBy = AseUtil.nullToBlank(rs.getString("auditby"));
				fileName = AseUtil.nullToBlank(rs.getString("filename"));

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><a href=\"crsattachx.jsp?act=r&kix="+kix+"&id="+id+"&r1="+r1+"&r2="+r2+"\" title=\"delete attachment\" class=\"linkcolumn\"><img src=\"../images/del.gif\" border=\"0\"></a></td>");
				listings.append("<td class=\"datacolumn\"><a href=\""+documentsURL+"campus/"+campus+"/"+fileName+"\" title=\"" + fullName + "\" class=\"linkcolumn\" target=\"_blank\">" + version + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + fullName + "</td>");
				listings.append("<td class=\"datacolumn\">" + fileSize + "</td>");
				listings.append("<td class=\"datacolumn\">" + fileDate + "</td>");
				listings.append("<td class=\"datacolumn\">" + auditBy + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"10%\">&nbsp;</td>" +
					"<td class=\"textblackth\" width=\"10%\">Version</td>" +
					"<td class=\"textblackth\" width=\"40%\">File Name</td>" +
					"<td class=\"textblackth\" width=\"10%\">File Size</td>" +
					"<td class=\"textblackth\" width=\"15%\">File Date</td>" +
					"<td class=\"textblackth\" width=\"15%\">User Name</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
		}
		catch( SQLException e ){
			logger.fatal("AttachDB: listProgramAttachments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("AttachDB: listProgramAttachments - " + ex.toString());
		}

		return listing;
	}

	public static String listAttachmentsByCategoryKix(Connection conn,String category,String kix){

		return listAttachmentsByCategoryKix(conn,category,kix,"");
	}

	public static String listAttachmentsByCategoryKix(Connection conn,String campus,String category,String kix){

		return listAttachmentsByCategoryKix(conn,"",category,kix,"");
	}

	public static String listAttachmentsByCategoryKix(Connection conn,String campus,String category,String kix,String sort){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String fullName = "";
		String fileName = "";
		String fileDate = "";
		String auditBy = "";
		String extension = "";
		String image = "";
		int version = 0;
		int id = 0;
		String link = "";
		String rowColor = "";
		boolean found = false;
		int j = 0;

		String documentFolder = "campus";

		try{

			AseUtil aseUtil = new AseUtil();

			String documentsURL = SysDB.getSys(conn,"documentsURL");

			if (category != null && category.equals(Constant.FORUM)){
				documentFolder = category;
			} // category

			// set the sorting order
			if (sort == null || sort.equals(Constant.BLANK)){
				sort = "v.fullname";
			}
			else{
				if (sort.equals("date")){
					sort = "a.filedate";
				}
				else if (sort.equals("name")){
					sort = "v.fullname";
				}
			} // sort

			String sql = "";
			PreparedStatement ps = null;

			if(campus != null && campus.length() > 0){
				sql = "SELECT a.id, a.filename, v.fullname, v.version, a.filedate, a.auditby, a.campus "
					+ "FROM vw_AttachedLatestVersion v INNER JOIN "
					+ "tblAttach a ON v.historyid = a.historyid "
					+ "AND v.version = a.version "
					+ "AND v.fullname = a.fullname "
					+ "WHERE a.campus=? AND v.historyid=? "
					+ "AND (v.category=? OR v.category=?) "
					+ "ORDER BY " + sort;
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,category);
				ps.setString(4,Constant.PROGRAM);
			}
			else{
				sql = "SELECT a.id, a.filename, v.fullname, v.version, a.filedate, a.auditby, a.campus "
					+ "FROM vw_AttachedLatestVersion v INNER JOIN "
					+ "tblAttach a ON v.historyid = a.historyid "
					+ "AND v.version = a.version "
					+ "AND v.fullname = a.fullname "
					+ "WHERE v.historyid=? "
					+ "AND (v.category=? OR v.category=?) "
					+ "ORDER BY " + sort;
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,category);
				ps.setString(3,Constant.PROGRAM);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				fullName = AseUtil.nullToBlank(rs.getString("fullname"));
				fileName = AseUtil.nullToBlank(rs.getString("filename"));
				fileDate = aseUtil.ASE_FormatDateTime(rs.getString("filedate"),Constant.DATE_DATETIME);
				auditBy = AseUtil.nullToBlank(rs.getString("auditby"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				version = rs.getInt("version");
				id = rs.getInt("id");

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				extension = AseUtil2.getFileExtension(fileName);

				image = "<img src=\"/central/images/ext/"+extension+".gif\" border=\"0\">";

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><a href=\"/central/core/attchst.jsp?kix="+kix+"&id="+id+"\" title=\"view attachment history\" class=\"linkcolumn\"><img src=\"/central/images/attachment.gif\" border=\"0\"></a></td>");
				listings.append("<td class=\"datacolumn\">" + version + "</td>");
				listings.append("<td class=\"datacolumn\"><a href=\""+documentsURL+documentFolder+"/"+campus+"/"+fileName+"\" title=\"" + fullName + "\" target=\"_blank\">" + image + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + auditBy + "</td>");
				listings.append("<td class=\"datacolumn\">" + fileDate + "</td>");
				listings.append("<td class=\"datacolumn\">" + fullName + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			aseUtil = null;

			if (found){

				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#dbeaf5\">" +
					"<td class=\"textblackth\" width=\"10%\">History</td>" +
					"<td class=\"textblackth\" width=\"10%\">Version</td>" +
					"<td class=\"textblackth\" width=\"10%\">Type</td>" +
					"<td class=\"textblackth\" width=\"15%\">User</td>" +
					"<td class=\"textblackth\" width=\"15%\">File Date</td>" +
					"<td class=\"textblackth\" width=\"40%\">File Name</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";

			}
		}
		catch( SQLException e ){
			logger.fatal("AttachDB: listAttachmentsByCategoryKix - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("AttachDB: listAttachmentsByCategoryKix - " + ex.toString());
		}

		return listing;
	}

	/*
	 * countAttachments
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int countAttachments(Connection conn,String kix) throws SQLException {

		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter FROM tblAttach WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: countAttachments\n" + e.toString());
		}

		return counter;
	}

	/*
	 * countAttachments
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int countAttachments(Connection conn,String kix,String category) throws SQLException {

		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter FROM tblAttach WHERE historyid=? AND category=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,category);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: countAttachments\n" + e.toString());
		}

		return counter;
	}

	/*
	 * countAttachments
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int countAttachments(Connection conn,String kix,String alpha,String num,String category) throws SQLException {

		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter "
					+ "FROM tblAttach "
					+ "WHERE historyid=? AND coursealpha=? AND coursenum=? AND category=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,category);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: countAttachments\n" + e.toString());
		}

		return counter;
	}

	/*
	 * countAttachments
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int countAttachments(Connection conn,String kix,String alpha,String num,String category,String campus) throws SQLException {

		int counter = 0;

		try {
			String sql = "SELECT COUNT(id) AS counter "
					+ "FROM tblAttach "
					+ "WHERE campus=? AND historyid=? AND coursealpha=? AND coursenum=? AND category=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,category);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = rs.getInt("counter");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AttachDB: countAttachments\n" + e.toString());
		}

		return counter;
	}

	public void close() throws SQLException {}
}