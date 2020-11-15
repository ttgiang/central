/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ReassignServlet extends TalinServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(ReassignServlet.class.getName());

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
		logger.info("ReassignServlet: destroyed...");
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
				getServletContext().getRequestDispatcher("/core/msg3.jsp?rtn=index").forward(request, response);
				return;
			default:
				isBusy(talin, request, response);
				return;
		}
	}

	private void doSometing(HttpServletRequest request,
									HttpServletResponse response,
									Talin talin){

		Connection conn = null;

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String formAction = null;
		String formName = null;
		String user = null;
		String campus = null;
		String fromName = null;
		String toName = null;
		String checked = null;
		String message = null;
		String skew = null;

		int rowsAffected = 0;
		int i;

		boolean failure = false;

		try {
			Msg msg = new Msg();

			conn = AsePool.createLongConnection();

			boolean debug = DebugDB.getDebug(conn,"ReassignServlet");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){

				fromName = enc.getKey1();
				toName = enc.getKey2();
				checked = enc.getKey3();

				campus = enc.getCampus();
				user = enc.getUser();

				formName = enc.getKey6();
				formAction = enc.getKey7();

				skew = enc.getSkew();

				String reassignedAlphas = "";


				if ( formName != null && formName.equals("aseForm") ){
					if (formAction.equalsIgnoreCase("s") && skew.equals(Constant.ON)){
						if (checked != null && checked.length() >0){
							int pos = 0;
							String alpha = "";
							String num = "";
							String[] aChecked = checked.split("~");
							StringBuffer buf = new StringBuffer();

							buf.append("<ul>");
							for(i=0;i<aChecked.length;i++){
								checked = aChecked[i];
								if (!checked.equals(Constant.BLANK)){
									pos = checked.indexOf("_");
									if (pos>-1){
										alpha = checked.substring(0,pos);
										num = checked.substring(pos+1,checked.length());
										msg = Outlines.reassignOwnership(conn,campus,user,fromName,toName,alpha,num);
										buf.append("<li class=\"datacolumn\">" + alpha + " " + num + "</li>");

										if (reassignedAlphas.equals(Constant.BLANK)){
											reassignedAlphas = alpha;
										}
										else{
											reassignedAlphas = reassignedAlphas + "," + alpha;
										}

									} // if pos

								} // if checked

							} // for

							// add reassigned alphas to user's profile
							if (!reassignedAlphas.equals(Constant.BLANK)){
								UserDB.updateUserAlphas(conn,toName,reassignedAlphas);
							}

							buf.append("</ul>");
							message = "Reassignments completed successfully" + "<br/>" + buf.toString();
							talin.setPercentage(100);
						} // checked
					} // formAction
					else{
						message = "Invalid security code";
						failure = true;
					}
				} // formName

				session.removeAttribute("aseLinker");
			} // enc

			session.setAttribute("aseApplicationMessage", message);

			// if doSomething made it through, logging would include all
			// we needed to know. However, if an error occur, this logging
			// tells us what we should know about the error.
			if (failure){
				// force end
				talin.setPercentage(100);
				logger.info("ReassignServlet: START");
				logger.info("ReassignServlet: " + message);
				logger.info("ReassignServlet: END");
			}

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			logger.fatal("ReassignServlet: " + e.toString());
		} finally {

			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("ReassignServlet - " + e.toString());
			}

		}
	}

}