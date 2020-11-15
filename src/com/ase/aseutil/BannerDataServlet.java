/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.sql.Connection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import org.apache.log4j.Logger;

public class BannerDataServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(BannerDataServlet.class.getName());

	/**
	* getters and settings
	*/
	public void init() throws ServletException {}

	/**
	* init
	*/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
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

		String rtn = "";

		int rowsAffected = 0;

		HttpSession session = request.getSession(true);

		try{
			WebSite website = new WebSite();

			String formAction = website.getRequestParameter(request,"formAction","");
			String formName = website.getRequestParameter(request,"formName","");
			String key = website.getRequestParameter(request,"key","");
			String code = website.getRequestParameter(request,"code","");
			String descr = website.getRequestParameter(request,"descr","");
			String tbl = website.getRequestParameter(request,"tbl","");
			rtn = website.getRequestParameter(request,"rtn","");

			// key exists for update and delete but not for add. that's where code comes in.
			// code exists only for add
			//System.out.println("----------------------");
			//System.out.println("formAction: " + formAction);
			//System.out.println("formName: " + formName);
			//System.out.println("code: " + code);
			//System.out.println("key: " + key);
			//System.out.println("descr: " + descr);
			//System.out.println("tbl: " + tbl);
			//System.out.println("rtn: " + rtn);

			if (formName.equals("aseForm")){

				AsePool connectionPool = null;

				Connection conn = null;

				try{

					connectionPool = AsePool.getInstance();

					if (connectionPool != null){

						conn = connectionPool.getConnection();

						if (conn != null){

							if (key.equals(Constant.BLANK) && !code.equals(Constant.BLANK)){
								formAction = "a";
								key = code;
							}

							if (formAction.equals("a")){
								rowsAffected = BannerDataDB.insertBannerData(conn,tbl,key,descr);
							}
							else if (formAction.equals("d")){
								rowsAffected = BannerDataDB.deleteBannerData(conn,tbl,key);
							}
							else if (formAction.equals("u")){
								rowsAffected = BannerDataDB.updateBannerData(conn,tbl,key,descr);
							}

							if (rowsAffected >= 0){
								session.setAttribute("aseApplicationMessage", "Data processed successfully.");
							}
							else{
								session.setAttribute("aseApplicationMessage", "Unable to process data.");
							}

						} // conn

					} // connectionPool

				}
				catch(Exception e){
					logger.fatal("Exception: BannerDataServlet - " + e.toString());
				}
				finally {
					if (conn != null){
						connectionPool.freeConnection(conn);
					}
				}

			} // valid form name

		}
		catch(Exception e){
			logger.fatal("Exception: BannerDataServlet - " + e.toString());
		}

		String url = response.encodeURL("/core/msg2.jsp?rtn="+rtn);

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

}