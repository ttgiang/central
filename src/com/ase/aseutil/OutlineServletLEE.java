/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class OutlineServletLEE extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(OutlineServletLEE.class.getName());
	private AsePool connectionPool;

	/*
	 * init
	 */
	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	/*
	 * destroy
	 */
	public void destroy() {
		connectionPool.destroy();
	}

	/*
	 * doGet
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		WebSite website = new WebSite();
		String kix = website.getRequestParameter(request,"kix");
		String src = website.getRequestParameter(request,"src");
		String rtn2 = website.getRequestParameter(request,"rtn2");
		String itm = website.getRequestParameter(request,"itm");

		int rowsAffected = 0;
		String rtn = "";

		try{
			if ("ccslo".equals(src)){
				rowsAffected = quickList(request,response);
				rtn = "msg3";

				if ("edt".equals(rtn2) || "edtslo".equals(rtn2))
					src = "ccslocrslnks";
				else
					src = "ccslo";
			}
		} catch (Exception ie) {
			throw new ServletException(ie);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/"+rtn+".jsp");
		} else {
			url = response.encodeURL("/core/"+rtn+".jsp?rtn="+src+"&kix="+kix+"&itm="+Constant.COURSE_OBJECTIVES);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	/*
	 * quickList
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int quickList(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int rowsAffected = 0;

		WebSite website = new WebSite();
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		Msg msg = new Msg();

		String alpha = "";
		String num = "";
		String type = "";
		String message = "";

		Connection connection = connectionPool.getConnection();

		String itm = website.getRequestParameter(request,"itm");
		String kix = website.getRequestParameter(request,"kix");
		if (!(Constant.BLANK).equals(kix)){
			String[] info = Helper.getKixInfo(connection,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
		}

		try {
			if (formName != null && formName.equals("aseForm") && Skew.confirmEncodedValue(request)){
				String lst = website.getRequestParameter(request,"lst");
				String outlineContent = website.getRequestParameter(request,"outlineContent");
				String clear = website.getRequestParameter(request,"clr","0");
				String clearList = website.getRequestParameter(request,"clrList","0");

				String temp = "";
				String[] arr;
				int i = 0;

				// clear existing content before updating
				if ((Constant.ON).equals(clear)){
					CompDB.updateObjective(connection,kix,"");
				}

				// clear existing list before updating
				if ((Constant.ON).equals(clearList)){
					Outlines.deleteLinkedItems(connection,campus,kix,itm);
				}

				// split content and save
				arr = lst.split("//");
				for(i=0;i<arr.length;i++){
					if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){
						if ((Constant.COURSE_OBJECTIVES).equals(itm))
							msg = CompDB.addRemoveCourseComp(connection,"a",campus,alpha,num,arr[i],0,user,kix);
					} // if arr
				}	// for

				if (outlineContent != null && outlineContent.length() > 0)
					CompDB.updateObjective(connection,kix,outlineContent);

				if (!"Exception".equals(msg.getMsg())){
					message = "Operation completed successfully";

					Tables.createOutlines(campus,kix,alpha,num);
				}
				else
					message = "Unable to complete requested operation";

			}	// form
			else{
				message = "Invalid security code";
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception ie) {
			rowsAffected = -1;
			session.setAttribute("aseApplicationMessage", ie.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(ie);
		} finally {
			connectionPool.freeConnection(connection);
		}

		return rowsAffected;
	}

	/*
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}