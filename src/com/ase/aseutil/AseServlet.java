/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// AseServlet.java
//
package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class AseServlet extends HttpServlet{

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(AseServlet.class.getName());

	private String kix = "";
	private String url = "";
	private String message = "";
	private int rowsAffected = 0;

	/**
	* init
	*/
	public void init() throws ServletException{}

    public void destroy () {}

	/*
	 * doGet
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		WebSite website = new WebSite();
		String action = website.getRequestParameter(request,"act");
		String aseCancel = website.getRequestParameter(request,"aseCancel","",false);
		String rtn = "";
		String src = "";
		String args = "";

		HttpSession session = request.getSession(true);

		try{

			if (aseCancel.equals("Cancel")){
				if (action.equals("reseq")){
					rtn = "msg3";
					src = "ini";
				}
				message = "Operation cancelled successfully";
			}
			else if (action.equals("reseq")){
				rowsAffected = processINIResequence(request,response);
				rtn = "msg3";
				src = "ini";
			}
			else if (action.equals("reseqApprovers")){
				int route = website.getRequestParameter(request,"route",0);
				rowsAffected = resequenceApprovers(request,response);
				rtn = "msg3";
				src = "appridx";
				args = "&route="+route;
			}

		} catch (Exception ie) {
			throw new ServletException(ie);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/"+rtn+".jsp");
		} else {
			url = response.encodeURL("/core/"+rtn+".jsp?rtn="+src+"&kix="+kix+args);
		}

		session.setAttribute("aseApplicationMessage",message);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

	/*
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}

	/**
	* processINIResequence
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	* @return int
	*/
	public int processINIResequence(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		rowsAffected = -1;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			WebSite website = new WebSite();

			String campus = website.getRequestParameter(request,"aseCampus","",true);
			String user = website.getRequestParameter(request,"aseUserName","",true);
			String controls = website.getRequestParameter(request,"controls","",false);
			String category = website.getRequestParameter(request,"category","",false);

			String cmdSave = website.getRequestParameter(request,"aseSave");
			String cmdAutoSave = website.getRequestParameter(request,"aseAutoSave");
			String cmdCancel = website.getRequestParameter(request,"aseCancel");

			String id = "";

			int i = 0;
			int seq = 0;
			String[] arr = null;
			String sql = "";
			String updateSQL = "";

			PreparedStatement ps = null;

			if (!controls.equals(Constant.BLANK)){

				updateSQL = "UPDATE tblINI SET seq=?,klanid=?,kdate=? WHERE campus=? AND category=? AND id=?";

				// save requires updating by user selected sequence.
				// autosave is saving in alphabetical order
				if (cmdSave.equals("Save")){
					// put control values into array
					arr = controls.split(",");

					// go through each control and update to new values
					for(i=0;i<arr.length;i++){
						id = arr[i];
						seq = website.getRequestParameter(request,"controlName_" + id,0,false);
						ps = conn.prepareStatement(updateSQL);
						ps.setInt(1,seq);
						ps.setString(2,user);
						ps.setString(3,AseUtil.getCurrentDateTimeString());
						ps.setString(4,campus);
						ps.setString(5,category);
						ps.setInt(6,Integer.parseInt(id));
						rowsAffected = ps.executeUpdate();
					}

					ps.close();

					message = "Resequencing completed successfully.";
				}
				else if (cmdAutoSave.equals("AutoSave")){
					seq = 0;

					sql = "SELECT id FROM tblini WHERE campus=? AND category=? ORDER BY kid";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,category);
					ResultSet rs = ps.executeQuery();
					while (rs.next()){
						int idx = NumericUtil.nullToZero(rs.getInt("id"));
						PreparedStatement ps2 = conn.prepareStatement(updateSQL);
						ps2.setInt(1,++seq);
						ps2.setString(2,user);
						ps2.setString(3,AseUtil.getCurrentDateTimeString());
						ps2.setString(4,campus);
						ps2.setString(5,category);
						ps2.setInt(6,idx);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
					}
					rs.close();
					ps.close();

					message = "Resequencing completed successfully.";

				} // if save/autosave
			} // if controls != blank
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			logger.fatal("AseServlet - processINIResequence: " + e.toString());
			throw new ServletException(e);
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	* resequenceApprovers
	* <p>
	* @param	request	HttpServletRequest
	* @param	response	HttpServletResponse
	* <p>
	* @return int
	*/
	public int resequenceApprovers(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		//Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		//int rowsAffected = -1;
		//String message = "";

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			WebSite website = new WebSite();

			String campus = website.getRequestParameter(request,"aseCampus","",true);
			String user = website.getRequestParameter(request,"aseUserName","",true);
			String controls = website.getRequestParameter(request,"controls","",false);
			int route = website.getRequestParameter(request,"route",0);

			String cmdSave = website.getRequestParameter(request,"aseSave");
			String cmdCancel = website.getRequestParameter(request,"aseCancel");

			String id = "";

			int i = 0;
			int seq = 0;
			String[] arr = null;

			if (!controls.equals(Constant.BLANK)){

				String sql = "UPDATE tblApprover SET approver_seq=?,addedby=?,addeddate=? WHERE campus=? AND approverid=? AND route=?";

				// save requires updating by user selected sequence.
				// autosave is saving in alphabetical order
				if (cmdSave.equals("Save")){
					// put control values into array
					arr = controls.split(",");

					// go through each control and update to new values
					for(i=0;i<arr.length;i++){
						id = arr[i];
						seq = website.getRequestParameter(request,"controlName_" + id,0,false);
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setInt(1,seq);
						ps.setString(2,user);
						ps.setString(3,AseUtil.getCurrentDateTimeString());
						ps.setString(4,campus);
						ps.setInt(5,NumericUtil.getInt(id,0));
						ps.setInt(6,route);
						rowsAffected = ps.executeUpdate();
						ps.close();
					}

					message = "Resequencing completed successfully.";
				}

			} // if controls != blank
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			logger.fatal("AseServlet - resequenceApprovers: " + e.toString());
			throw new ServletException(e);
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("AseServlet: resequenceApprovers - " + e.toString());
			}
		}

		return rowsAffected;
	}

}