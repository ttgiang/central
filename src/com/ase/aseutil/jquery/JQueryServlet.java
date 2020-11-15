/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.jquery;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ase.aseutil.*;
import com.ase.aseutil.report.ReportingStatus;

import java.sql.Connection;
import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;

public class JQueryServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(JQueryServlet.class.getName());

	public static final int SAVE_COMMENT 			= 1;
	public static final int PREP_COMMENT 			= 2;
	public static final int SAVE_PROGRAM_COMMENT = 3;
	public static final int SAVE_FND_COMMENT 		= 4;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String uri = req.getRequestURI();

		int firstPos = uri.lastIndexOf('/') + 1;

		int requestType = Integer.parseInt(uri.substring(firstPos, uri.length() - 3));

		AsePool connectionPool = null;

		Connection conn = null;

		String campus = null;

		String user = null;

		try{
			WebSite website = new WebSite();

			HttpSession session = req.getSession(true);

			boolean debug = false;

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			// ER00009 - when editing or providing comments, remember fields
			// to be enabled on following screen upon returning
			String enabledForEdits = website.getRequestParameter(req,"enabledForEdits","");
			String bkmrk = "";

			String kix = website.getRequestParameter(req,"kix","");
			String alpha = website.getRequestParameter(req,"alpha","");
			String num = website.getRequestParameter(req,"num","");

			String acktion = website.getRequestParameter(req,"acktion","c");

			String tab = "";		// course or campus; -1 is program
			int item = 0;			// question number of item
			int mode = 0;
			int seq = 0;

			int rowsAffected = 0;

			boolean enabled = false;

			String enable = "";
			String comments = "";

			boolean foundation = false;
			boolean isAProgram = false;
			boolean dataSaved = false;

			if (debug){
				logger.info("-----------------");
				logger.info("kix: " + kix);
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("requestType: " + requestType);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("enabledForEdits: " + enabledForEdits);
			}

			switch (requestType){

				case SAVE_COMMENT:

					isAProgram = false;
					foundation = false;

					mode = website.getRequestParameter(req,"md",0);
					tab = website.getRequestParameter(req,"tab",Constant.BLANK);
					item = website.getRequestParameter(req,"qn",0);
					seq = website.getRequestParameter(req,"seq",0);
					bkmrk = website.getRequestParameter(req,"bkmrk","");
					comments = website.getRequestParameter(req,"comment",Constant.BLANK);

					// was this item enabled for edit?
					// not in use at this time.
					enable = website.getRequestParameter(req,"enable",Constant.BLANK);
					if (enable != null && enable.length() > 0){
						enabled = true;
					}

					if (debug){
						logger.info("-----------------");
						logger.info("course");
						logger.info("enabled: " + enabled);
						logger.info("mode: " + mode);
						logger.info("item: " + item);
						logger.info("tab: " + tab);
						logger.info("seq: " + seq);
						logger.info("comments: " + comments);
						logger.info("acktion: " + acktion);
					}

					if (mode > 0
						&& item > 0
						&& !comments.equals(Constant.BLANK)
						&& !alpha.equals(Constant.BLANK)
						&& !num.equals(Constant.BLANK)
						&& acktion.toLowerCase().equals("s")){

						if (debug) logger.info("--------1---------");

						connectionPool = AsePool.getInstance();
						conn = connectionPool.getConnection();

						if (debug) logger.info("--------2---------");

						if(comments != null && comments.length() > 0){
							Review reviewDB = new Review();
							reviewDB.setId(0);
							reviewDB.setUser(user);
							reviewDB.setAlpha(alpha);
							reviewDB.setNum(num);
							reviewDB.setHistory(kix);
							reviewDB.setComments(comments);
							reviewDB.setItem(item);
							reviewDB.setCampus(campus);
							reviewDB.setEnable(enabled);
							reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
							rowsAffected = ReviewDB.insertReview(conn,reviewDB,tab,mode);
							reviewDB = null;
						} // comments
					} // have comments

					dataSaved = true;

					break;

				case SAVE_PROGRAM_COMMENT:

					isAProgram = true;
					foundation = false;

					mode = website.getRequestParameter(req,"md",0);
					item = website.getRequestParameter(req,"qn",0);
					tab = website.getRequestParameter(req,"tab",Constant.BLANK);
					comments = website.getRequestParameter(req,"comment",Constant.BLANK);

					// was this item enabled for edit?
					enabled = false;
					enable = website.getRequestParameter(req,"enable",Constant.BLANK);
					if (enable != null && enable.length() > 0){
						enabled = true;
					}

					if (debug){
						logger.info("-----------------");
						logger.info("program");
						logger.info("enabled: " + enabled);
						logger.info("mode: " + mode);
						logger.info("item: " + item);
						logger.info("comments: " + comments);
						logger.info("acktion: " + acktion);
					}

					if (mode > 0 && item > 0 && !comments.equals(Constant.BLANK) && acktion.toLowerCase().equals("s")){

						connectionPool = AsePool.getInstance();
						conn = connectionPool.getConnection();

						if(comments != null && comments.length() > 0){
							Review reviewDB = new Review();
							reviewDB.setId(0);
							reviewDB.setUser(user);
							reviewDB.setAlpha(alpha);
							reviewDB.setNum(num);
							reviewDB.setHistory(kix);
							reviewDB.setComments(comments);
							reviewDB.setItem(item);
							reviewDB.setCampus(campus);
							reviewDB.setEnable(enabled);
							reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
							rowsAffected = ReviewDB.insertReview(conn,reviewDB,tab,mode);
							reviewDB = null;
						}
					}

					dataSaved = true;

					break;

				case SAVE_FND_COMMENT:

					isAProgram = false;
					foundation = true;

					mode = website.getRequestParameter(req,"md",0);
					int sq = website.getRequestParameter(req,"f_sq",0);
					int en = website.getRequestParameter(req,"f_en",0);
					int qn = website.getRequestParameter(req,"f_qn",0);
					tab = ""+Constant.TAB_FOUNDATION;
					item = Constant.TAB_FOUNDATION;
					bkmrk = website.getRequestParameter(req,"bkmrk","");

					comments = website.getRequestParameter(req,"comment",Constant.BLANK);

					// was this item enabled for edit?
					enabled = false;
					enable = website.getRequestParameter(req,"enable",Constant.BLANK);
					if (enable != null && enable.length() > 0){
						enabled = true;
					}

					if (debug){
						logger.info("-----------------");
						logger.info("foundation");
						logger.info("enabled: " + enabled);
						logger.info("mode: " + mode);
						logger.info("sq: " + sq);
						logger.info("en: " + en);
						logger.info("qn: " + qn);
						logger.info("comments: " + comments);
						logger.info("acktion: " + acktion);
					}

					if (mode > 0 && sq > 0 && !comments.equals(Constant.BLANK) && acktion.toLowerCase().equals("s")){

						connectionPool = AsePool.getInstance();
						conn = connectionPool.getConnection();

						if(comments != null && comments.length() > 0){
							Review reviewDB = new Review();
							reviewDB.setId(0);
							reviewDB.setUser(user);
							reviewDB.setAlpha(alpha);
							reviewDB.setNum(num);
							reviewDB.setHistory(kix);
							reviewDB.setComments(comments);
							reviewDB.setItem(sq);
							reviewDB.setCampus(campus);
							reviewDB.setEnable(enabled);
							reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
							reviewDB.setSq(sq);
							reviewDB.setEn(en);
							reviewDB.setQn(qn);
							rowsAffected = ReviewDB.insertReview(conn,reviewDB,tab,mode);
							reviewDB = null;
						}
					}

					dataSaved = true;

					break;

				case PREP_COMMENT:

					break;

			} // switch

			String forwardTo = "";

			int tb = Integer.parseInt(tab);

			// enabled items or items with comments are remembered to
			// carry over to following page. build urlString
			// only if a save was completed
			if(dataSaved && !acktion.equals("c")){
				session.setAttribute("aseApplicationMessage","Comment inserted successfully");

				connectionPool = AsePool.getInstance();
				conn = connectionPool.getConnection();

				// ER00019
				int enableForMod = website.getRequestParameter(req, "enableForMod", 0);

				if (debug) logger.info("enableForMod1: " + enableForMod);

				if(enableForMod==1){
					if(enabledForEdits.equals(Constant.BLANK)){
						enabledForEdits = "" + seq;
					}
					else{
						enabledForEdits = enabledForEdits + "," + seq;
					}
				}
				else{
					com.ase.aseutil.ParkDB parkDB = new com.ase.aseutil.ParkDB();
					enabledForEdits = parkDB.removeEnabledItem(conn,kix,user,seq);
					parkDB = null;
				}

				if (debug) logger.info("enableForMod2: " + enableForMod);

				if(enabledForEdits != null && enabledForEdits.length() > 0){

					enabledForEdits = Util.removeDuplicateFromString(enabledForEdits);

					com.ase.aseutil.Park park = new com.ase.aseutil.Park();
					park.setCampus(campus);
					park.setUserId(user);
					park.setHistoryId(kix);
					park.setString1(enabledForEdits);
					ParkDB.setApproverCommentedItems(conn,park);
					park = null;
				}

			} // dataSaved

			//
			// bkmrk
			//
			String rtn = "";
			String urlString = "&e="+enabledForEdits+"&bkmrk="+bkmrk+"&md="+mode;

			// we do we go when it's all done
			if (mode==Constant.APPROVAL){
				if(foundation){
					rtn = "fndappr";
				}
				else if(isAProgram){
					rtn = "prgappr";
				}
				else{
					rtn = "crsappr";
				}
			}
			else if (mode==Constant.REVIEW){
				if(foundation){
					rtn = "fndrvwer";
				}
				else if(isAProgram){
					rtn = "prgrvwer";
				}
				else{
					rtn = "crsrvwer";
				}
			}
			else if (mode==Constant.REVIEW_IN_APPROVAL){
				if(foundation){
					rtn = "fndrvwer";
				}
				else if(isAProgram){
					rtn = "prgrvwer";
				}
				else{
					rtn = "crsrvwer";
				}
			}

			forwardTo = "msg4.jsp?rtn="+rtn+"&kix="+kix+urlString;

			req.getRequestDispatcher(forwardTo).forward(req, resp);
		}
		catch (Exception e){
			logger.fatal("JQueryServlet - " + e.toString());
		} finally {
			if (conn != null){
				connectionPool.freeConnection(conn,"JQueryServlet",user);
			}
		}
	}
}
