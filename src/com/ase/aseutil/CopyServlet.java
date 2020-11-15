/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// CopyServlet.java
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

public class CopyServlet extends TalinServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(CopyServlet.class.getName());

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
		logger.info("CopyServlet: destroyed...");
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
	private void doSometing(HttpServletRequest request,
									HttpServletResponse response,
									Talin talin){

		AsePool connectionPool = null;
		Connection conn = null;

		String formAction = null;
		String formName = null;

		String fromCampus = null;
		String fromAlpha = null;
		String fromNum = null;
		String toAlpha = null;
		String toNum = null;
		String comments = null;

		String message = null;
		String kix = null;

		String campus = null;
		String user = null;
		String skew = null;

		boolean failure = false;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"CopyServlet");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				kix = enc.getKix();

				fromAlpha = enc.getKey1();
				fromNum = enc.getKey2();
				toAlpha = enc.getKey3();
				toNum = enc.getKey4();
				comments = enc.getKey5();

				formName = enc.getKey6();
				formAction = enc.getKey7();

				fromCampus = enc.getKey8();

				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if (debug){
					logger.info("campus: " + campus);
					logger.info("user: " + user);
					logger.info("kix: " + kix);
					logger.info("skew: " + skew);
					logger.info("fromCampus: " + fromCampus);
					logger.info("fromAlpha: " + fromAlpha);
					logger.info("fromNum: " + fromNum);
					logger.info("toAlpha: " + toAlpha);
					logger.info("toNum: " + toNum);
					logger.info("formAction: " + formAction);
					logger.info("formName: " + formName);
				}

				if ( formName != null && formName.equals("aseForm") ){
					if (formAction.equalsIgnoreCase("s") && skew.equals("1")){
						msg = CourseDB.isCourseCopyable(conn,campus,toAlpha,toNum);
						if ("".equals(msg.getMsg())){
							// sending in kix as replacement for alpha/num because we need kix to
							// figure out type
							msg = CourseCopy.copyOutline(conn,campus,kix,kix,toAlpha,toNum,user,comments);
							if ( "Exception".equals(msg.getMsg()) ){
								message = "Outline copied failed.<br><br>";
								failure = true;
							}
							else if ( !"".equals(msg.getMsg()) ){
								message = "Unable to copy outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
								failure = true;
							}
							else{
								kix = Helper.getKix(conn,campus,toAlpha,toNum,"PRE");
								message = "Outline copied successfully";
							}
						}
						else{
							message = "Unable to copy outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
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
				logger.info("START");
				logger.info(message);
				logger.info("END");
			}

		}
		catch(SQLException se){
			logger.fatal("CopyServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("CopyServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"CopyServlet",user);
			talin.setPercentage(100);
		}
	}
}