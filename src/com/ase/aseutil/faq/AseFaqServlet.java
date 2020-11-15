/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 * private int createUserTask(HttpSession session,HttpServletRequest request,String action) {
 * public static int fillCCCMCampus(Connection conn,String campus){
 * public static int fillCCCMCourse(Connection conn,String campus){
 * private int fillMissingItems(HttpSession session){
 *
 */

package com.ase.aseutil.faq;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Encrypter;
import com.ase.aseutil.WebSite;

public class AseFaqServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(AseFaqServlet.class.getName());

	/**
	 * init
	 */
	public void init() throws ServletException {}

	/**
	 * destroy
	 */
	public void destroy() {}

	/**
	 * doGet
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		WebSite website = new WebSite();

		String message = "";

		int rowsAffected = 0;
		int score = 1;

		int id = website.getRequestParameter(request,"id",0);
		int seq = website.getRequestParameter(request,"seq",0);
		String cmd = website.getRequestParameter(request,"cmd","");
		String input = website.getRequestParameter(request,"faq","");
		boolean notify = website.getRequestParameter(request,"notify",false);
		String category = website.getRequestParameter(request,"cat","");
		String category2 = website.getRequestParameter(request,"cat2","");

		// a value found in new category overrides any selection made in the category list
		if (!category2.equals(Constant.BLANK)){
			category = category2;
		}

		if (cmd.equals("ask") || cmd.equals("ans")  || cmd.equals("bst") || cmd.equals("del")){

			if (cmd.equals("ask")){
				rowsAffected = FaqDB.insert(new Faq(0,campus,input,user,AseUtil.getCurrentDateTimeString(),category,notify));
			}
			else if (cmd.equals("ans")){
				rowsAffected = AnswerDB.insert(new Answer(id,seq,score,input,user,AseUtil.getCurrentDateTimeString(),campus));
			}
			else if (cmd.equals("bst")){
				rowsAffected = AnswerDB.bestAnswer(new Answer(id,seq,score,"",user,AseUtil.getCurrentDateTimeString(),campus));
			}
			else if (cmd.equals("del")){
				rowsAffected = AnswerDB.delete(id);
				rowsAffected = FaqDB.delete(id);
			}

			if (rowsAffected > -1)
				message = "CC Answer processed successfully.";
			else
				message = "There was a processing error.";

			session.setAttribute("aseApplicationMessage", message);

			session.setAttribute("aseFAQId", id);

		} // cmd

		String url = response.encodeURL("/core/faq/msg.htm");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}

