/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// CancelServlet.java
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

public class CancelServlet extends TalinServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(CancelServlet.class.getName());

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
		logger.info("CancelServlet: destroyed...");
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

		String alpha = null;
		String num = null;

		String message = null;
		String kix = null;

		String campus = null;
		String user = null;
		String skew = null;

		int id = 0;
		String foundation = "";

		boolean failure = false;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"CancelServlet");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){

				formName = enc.getKey6();
				formAction = enc.getKey7();

				foundation = enc.getKey8();
				id = NumericUtil.getInt(enc.getKey9(),0);

				kix = enc.getKix();
				alpha = enc.getAlpha();
				num = enc.getNum();
				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if ( formName != null && formName.equals("aseForm") ){
					if (formAction.equalsIgnoreCase("s") && skew.equals(Constant.ON)){

						if(foundation.equals("foundation") && id > 0){

							msg = com.ase.aseutil.fnd.FndCancel.cancel(conn,campus,user,kix,id);

							if ("Exception".equals(msg.getMsg())){
								message = "Foundation course cancellation failed.<br><br>" + msg.getErrorLog();
								failure = true;
							}
							else if (!"".equals(msg.getMsg())){
								message = "Unable to cancel foundation course.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
								failure = true;
							}
							else{
								message = "Foundation course cancelled successfully<br>";
								talin.setPercentage(100);
							}
						}
						else{
							/*
								kix is the id from table course. we'll start using the id where applicable.
								to avoid trouble with older implementation, we use kix to get the alpha and
								num needed for this to continue on successfully.

								kix works when we come here from sltcrs. when coming from task, kix does
								not exists.
							*/

							if (alpha.length() > 0 && num.length() > 0){
								msg = CourseCancel.cancelOutline(conn,campus,alpha,num,user);
							}
							else if (kix.length() > 0){
								msg = CourseCancel.cancelOutline(conn,campus,kix,user);
							}

							if ("Exception".equals(msg.getMsg())){
								message = "Outline cancellation failed.<br><br>" + msg.getErrorLog();
								failure = true;
							}
							else if ( !"".equals(msg.getMsg()) ){
								message = "Unable to cancel outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
								failure = true;
							}
							else{
								message = "Outline cancelled successfully<br>";
								talin.setPercentage(100);
							}
						} // foundation or not

					}	// action = s
					else{
						message = "Invalid security code";
						failure = true;
					}
				}	// valid form

				session.removeAttribute("aseLinker");
			} // enc

			session.setAttribute("aseApplicationMessage", message);

			// if doSomething made it through, logging would include all
			// we needed to know. However, if an error occur, this logging
			// tells us what we should know about the error.
			if (failure){
				// force end
				talin.setPercentage(100);
				logger.info("CancelServlet: START");
				logger.info("CancelServlet: " + message);
				logger.info("CancelServlet: END");
			}

		}
		catch(SQLException se){
			logger.fatal("CancelServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("CancelServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"CancelServlet",user);
		}
	}
}