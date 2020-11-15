/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ReviewServlet extends HttpServlet {

	static Logger logger = Logger.getLogger(ReviewServlet.class.getName());

	private static final long serialVersionUID = 12L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";
		String url;

		int i;
		int iAction = 0;
		int rowsAffected = 0;

		String user = "";

		String kix = "";
		String alpha = "";
		String num = "";
		String tb = "";
		String rtn = "";
		int mode = 0;

		boolean dataSaved = false;
		boolean debug = false;
		boolean isProgram = false;
		boolean foundation = false;

		AsePool connectionPool = AsePool.getInstance();
		Connection conn = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			debug = DebugDB.getDebug(conn,"ReviewServlet");

debug = true;

			if (debug){
				logger.info("---------------------------");
				logger.info("ReviewServlet DOGET - START");
			}

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");
			String update = website.getRequestParameter(request, "aseUpdate");
			String delete = website.getRequestParameter(request, "aseDelete");

			if (cancel != null && cancel.length() > 0)	sAction = cancel;
			if (submit != null && submit.length() > 0)	sAction = submit;
			if (update != null && update.length() > 0)	sAction = update;
			if (delete != null && delete.length() > 0)	sAction = delete;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			sAction = sAction.trim();

			if (sAction.equalsIgnoreCase("cancel")) {	iAction = cancelAction;	}
			if (sAction.equalsIgnoreCase("submit")) { iAction = insertAction; }
			if (sAction.equalsIgnoreCase("update")) { iAction = updateAction; }
			if (sAction.equalsIgnoreCase("yes")) { iAction = deleteAction; }

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			tb = website.getRequestParameter(request,"tb","");
			kix = website.getRequestParameter(request, "kix");
			isProgram = ProgramsDB.isAProgram(conn,campus,kix);

			//
			// available from foundation
			//
			int sq = website.getRequestParameter(request,"sq",0);
			int en = website.getRequestParameter(request,"en",0);
			int qn = website.getRequestParameter(request,"qn",0);

			if(!isProgram){
				foundation = fnd.isFoundation(conn,kix);
			}

			//
			// kix information
			//
			String[] info = null;
			if(foundation){
				info = fnd.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
			}
			else{
				info = Helper.getKixInfo(conn,kix);
				if (!kix.equals(Constant.BLANK)){
					alpha = info[Constant.KIX_PROGRAM_TITLE];
					num = info[Constant.KIX_PROGRAM_DIVISION];
				}
				else{
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
				} // kix
			}

			//
			// program does not have review at this time. only approval and foundation
			//
			if (foundation){
				mode = website.getRequestParameter(request, "mode", 0);
			}
			else if (isProgram){
				mode = website.getRequestParameter(request,"md",0);
			}
			else{
				mode = website.getRequestParameter(request, "mode", 0);
			}

			//
			// where to send back
			//
			if (mode != Constant.REVIEW){
				if (foundation)
					rtn = "fndappr_comments";
				else if (isProgram)
					rtn = "prgappr_comments";
				else
					rtn = "crsappr_comments";
			}

			String comments = website.getRequestParameter(request,"comments","");

			//
			// not for foundation
			//
			int item = website.getRequestParameter(request, "item", 0);

			if(foundation){
				item = Constant.TAB_FOUNDATION;
			}

			//
			// in comment edit view
			//
			int id = website.getRequestParameter(request, "id", 0);

			// used for ER00019 - enable for revision
int qseq = website.getRequestParameter(request, "qseq", 0);
			int enableForMod = website.getRequestParameter(request, "enableForMod", 0);
			String enabledForEdits = website.getRequestParameter(request,"enabledForEdits","");

			// was this item enabled for edit?
			// not used at this time
			boolean enabled = false;
			String enable = website.getRequestParameter(request,"enable","");
			if (enable != null && enable.length() > 0){
				enabled = true;
			}

			Review reviewDB = new Review();
			reviewDB.setId(id);
			reviewDB.setUser(user);
			reviewDB.setAlpha(alpha);
			reviewDB.setNum(num);
			reviewDB.setHistory(kix);
			reviewDB.setComments(comments);
			reviewDB.setItem(item);
			reviewDB.setCampus(campus);
			reviewDB.setEnable(enabled);
			reviewDB.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			reviewDB.setSq(sq);
			reviewDB.setEn(en);
			reviewDB.setQn(qn);

			if (debug){
				logger.info("campus - " + campus);
				logger.info("sAction - " + sAction);
				logger.info("iAction - " + iAction);
				logger.info("user - " + user);
				logger.info("item - " + item);
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("tb: " + tb);
				logger.info("mode: " + mode);
				logger.info("comments: " + comments);
				logger.info("qseq - " + qseq);
				logger.info("enableForMod - " + enableForMod);
				logger.info("enabledForEdits - " + enabledForEdits);
				logger.info("foundation - " + foundation);
				logger.info("isProgram - " + isProgram);
				logger.info("sq - " + sq);
				logger.info("en - " + en);
				logger.info("qn - " + qn);
			}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";

					if (mode==Constant.REVIEW || mode==Constant.REVIEW_IN_APPROVAL){
						if (foundation)
							rtn = "fndrvwer&md="+mode;
						else if (isProgram)
							rtn = "prgappr_comments&md="+mode;
						else
							rtn = "crsrvwer&md="+mode;
					}
					else if (mode== Constant.APPROVAL){
						if (foundation)
							rtn = "fndappr_comments&md="+mode;
						if (isProgram)
							rtn = "prgappr_comments&md="+mode;
						else
							rtn = "crsappr_comments&md="+mode;
					}

					break;
				case deleteAction:
					rowsAffected = ReviewDB.deleteReview(conn,id);

					if (rowsAffected == 1)
						message = "Comment deleted successfully";
					else
						message = "Unable to delete comment";

					if (foundation)
						rtn = "fndcmnt&sq="+sq+"&en="+en+"&qn="+qn+"&md="+mode;
					else if (isProgram)
						rtn = "prgcmnt&qn="+item+"&c="+tb+"&md="+mode;
					else
						rtn = "crscmnt&qn="+item+"&c="+tb+"&md="+mode;

					break;
				case insertAction:

					if(comments != null && comments.length() > 0){
						rowsAffected = ReviewDB.insertReview(conn,reviewDB,tb,mode);
						if (rowsAffected == 1){
							message = "Comment inserted successfully";
						}
						else{
							message = "Unable to insert comment";
						}
					}

					if (foundation){
						if (mode==Constant.REVIEW || mode==Constant.REVIEW_IN_APPROVAL)
							rtn = "fndrvwer&qn="+item+"&c="+tb+"&md="+mode;
						else{
							dataSaved = true;
							rtn = "fndappr_comments&md="+mode;
						}
					}
					else if (isProgram){
						rtn = "prgcmnt&qn="+item+"&c="+tb+"&md="+mode;
					}
					else{
						if (mode==Constant.REVIEW || mode==Constant.REVIEW_IN_APPROVAL)
							rtn = "crsrvwer&qn="+item+"&c="+tb+"&md="+mode;
						else{
							dataSaved = true;
							rtn = "crsappr_comments&md="+mode;
						}
					}

					break;
				case updateAction:

					if(comments != null && comments.length() > 0){
						rowsAffected = ReviewDB.updateReview(conn,reviewDB);

						if (rowsAffected == 1)
							message = "Comment updated successfully";
						else
							message = "Unable to update comment";

					}

					if (foundation){
						dataSaved = true;
						rtn = "fndcmnt&sq="+sq+"&en="+en+"&qn="+qn+"&md="+mode;
					}
					else if (isProgram){
						rtn = "prgcmnt&qn="+item+"&c="+tb+"&md="+mode;
					}
					else{
						dataSaved = true;
						rtn = "crscmnt&qn="+item+"&c="+tb+"&md="+mode;
					}

					break;
			} // switch

			if(dataSaved){

				//ER00019 - enable for modification
				if(enableForMod==1){
					if(enabledForEdits.equals(Constant.BLANK)){
enabledForEdits = "" + qseq;
					}
					else{
						enabledForEdits = enabledForEdits + "," + qseq;
					}
				}
				else{
					com.ase.aseutil.ParkDB parkDB = new com.ase.aseutil.ParkDB();
					enabledForEdits = parkDB.removeEnabledItem(conn,kix,user,qseq);
					parkDB = null;
				} // enable for mod

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

			if (debug){
				logger.info("dataSaved - " + dataSaved);
				logger.info("enableForMod - " + enableForMod);
				logger.info("enabledForEdits - " + enabledForEdits);
			}

			session.setAttribute("aseApplicationMessage",message);

			if (debug) logger.info("ReviewServlet DOGET - END");

			website = null;

			fnd = null;

		} catch (Exception e) {
			logger.fatal("ReviewServlet: " + e.toString());
			session.setAttribute("aseApplicationMessage",e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn,"ReviewerServlet",user);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp?kix="+kix);
		} else {
			url = "/core/msg.jsp?rtn=" + rtn + "&kix=" + kix;
		}

		getServletContext().getRequestDispatcher(url).forward(request,response);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws IOException,ServletException {
		doGet(request,response);
	}
}