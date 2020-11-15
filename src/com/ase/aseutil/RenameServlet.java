/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// RenameServlet.java
//
package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class RenameServlet extends TalinServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(RenameServlet.class.getName());

	/**
	**
	**/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	**
	**/
	public void destroy() {
		logger.info("RenameServlet: destroyed...");
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		Object o = session.getAttribute("Talin");
		Talin talin;

		if (o == null) {
			talin = new Talin();

			session.setAttribute("Talin", talin);

			Thread t = new Thread(talin);

			t.start();

			//DO SOMETHING HERE - START

			doSometing(request,response,talin);

			//DO SOMETHING HERE - END
		} else {
			talin = (Talin) o;
		}

		response.setContentType("text/html");

		switch (talin.getPercentage()) {
			case -1:
				isError(response.getOutputStream());
				return;
			case 100:
				session.removeAttribute("Talin");
				getServletContext().getRequestDispatcher("/core/talin.jsp").forward(request, response);
				return;
			default:
				isBusy(talin, request, response);
				return;
		}
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @param talin
	 */
	private void doSometing(HttpServletRequest request,HttpServletResponse response,Talin talin){

		AsePool connectionPool = null;
		Connection conn = null;

		String kix = null;

		String formAction = null;
		String formName = null;

		String fromAlpha = null;
		String fromNum = null;
		String toAlpha = null;
		String toNum = null;

		String justification = null;

		String message = null;
		String type = null;

		String campus = null;
		String user = null;
		String skew = null;

		// when sent here from course modification, we do our best
		// to give user a link back to the course modificaiton.
		String crsedt = "";
		String[] crsedtArgs = new String[2];

		boolean failure = false;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"RenameServlet");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				kix = enc.getKix();
				fromAlpha = enc.getKey1();
				fromNum = enc.getKey2();
				toAlpha = enc.getKey3();
				toNum = enc.getKey4();
				type = enc.getKey5();
				formName = enc.getKey6();
				formAction = enc.getKey7();
				justification = enc.getKey9();

				// format comes in as tab dash item number
				// make sure we check that crsedt is a valid value
				// greater than 1 excludes the dash
				crsedt = enc.getKey8();
				if (crsedt != null && crsedt.length() > 1){
					crsedtArgs = crsedt.split("-");
				}

				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if (debug) {
					logger.info("RenameServlet");
					logger.info("-------------");
					logger.info("campus: " + campus);
					logger.info("kix: " + kix);
					logger.info("user: " + user);
					logger.info("skew: " + skew);
					logger.info("fromAlpha: " + fromAlpha);
					logger.info("fromNum: " + fromNum);
					logger.info("toAlpha: " + toAlpha);
					logger.info("toNum: " + toNum);
					logger.info("formAction: " + formAction);
					logger.info("formName: " + formName);
					logger.info("crsedt: " + crsedt);
					logger.info("justification: " + justification);
				}

				if ( formName != null && formName.equals("aseForm") ){

					if (formAction.equalsIgnoreCase("s") && skew.equals("1")){

						msg = CourseDB.isCourseRenamable(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type);

						if ("".equals(msg.getMsg())){

							String authority = "";

							String renameRenumberRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,
																														campus,
																														"System",
																														"RenameRenumberRequiresApproval");
							if(renameRenumberRequiresApproval.equals(Constant.ON)){

								String renameRenumberAuthority = IniDB.getIniByCampusCategoryKidKey1(conn,
																															campus,
																															"System",
																															"RenameRenumberAuthority");


								// ---------------------------------------------------------
								// if authority is on and is found, we send there. if not,
								// see if a department chair is there
								// ---------------------------------------------------------
								if(renameRenumberAuthority.equals(Constant.ON)){
									authority = IniDB.getKval(conn,campus,"RenameRenumberAuthority","kval2");

									// if authority is not found, find department chair of new alpha
									if(authority == null || authority.length() == 0){
										authority = ChairProgramsDB.getChairName(conn,campus,toAlpha);
									}

								} // renameRenumberAuthority

								// was system set up properly?
								if(authority != null && authority.length() > 0){

									TaskDB.logTask(conn,authority,user,
														fromAlpha,fromNum,
														Constant.RENAME_REQUEST_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.BLANK,
														Constant.BLANK);

									AseUtil.logAction(conn,
															user,
															"ACTION",
															"Rename/renumber " + fromAlpha + " " + fromNum + " to " + toAlpha + " " + toNum,
															fromAlpha,fromNum,campus,kix);

									message = "Rename/renumber submitted to " + authority + " for approval.";

									// create working copy
									RenameDB renameDB = new RenameDB();
									String proposer = CourseDB.getCourseProposer(conn,kix);
									renameDB.insert(conn,new Rename(campus,kix,proposer,fromAlpha,fromNum,toAlpha,toNum,justification));
									renameDB = null;

									// notify rename authority
									MailerDB mailerDB = new MailerDB(conn,
																				authority,
																				user,
																				Constant.BLANK,
																				Constant.BLANK,
																				fromAlpha,
																				fromNum,
																				campus,
																				"emailRenameRenumberAuthority",
																				kix,
																				user);

								}
								else{
									message = "Unable to process rename/renumber request. Contact your campus administrator for assistance.";
									failure = true;
								}
							}
							else{
								msg = CourseRename.renameOutline(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type,justification);
								if ("Exception".equals(msg.getMsg())){
									message = "Outline rename/renumber failed.";
								}
								else if (!"".equals(msg.getMsg())){
									message = "Unable to rename/renumber outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
								}
								else{
									message = "Outline renamed/renumbered successfully.<br>";

									if (crsedt != null && crsedt.length() > 1){
										message += "<br>click <a href=\"/central/core/crsedt.jsp?ts="+crsedtArgs[0]+"&no="+crsedtArgs[1]+"&kix="+kix+"\" class=\"linkcolumn\">here</a> to resume course modification.<br>";
									}
								} // if exception
							} // rename requires approval
						}
						else{
							message = "Unable to rename/renumber outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
							failure = true;
						}
					}	// action = s
					else{
						message = "Invalid security code";
						failure = true;
					}
				}	// valid form

				session.removeAttribute("aseLinker");
			}
			else{
				message = "Unable to process request";
				failure = true;
			}

			session.setAttribute("aseApplicationMessage", message);

			// if doSomething made it through, logging would include all
			// we needed to know. However, if an error occur, this logging
			// tells us what we should know about the error.
			if (failure){
				// force end
				logger.info("RenameServlet: START");
				logger.info("RenameServlet: " + message);
				logger.info("RenameServlet: END");
			}

		}
		catch(SQLException se){
			logger.fatal("RenameServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("RenameServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"RenameServlet",user);
			talin.setPercentage(100);
		}
	}
}