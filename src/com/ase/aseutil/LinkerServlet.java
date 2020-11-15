/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class LinkerServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(LinkerServlet.class.getName());

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
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		WebSite website = new WebSite();

		String arg = website.getRequestParameter(request,"arg");

		if (arg.equals("frm"))
			processForm(request,response);
		else if (arg.equals("fnd"))
			processFoundations(request,response);
		else if (arg.equals("lnk3"))
			processLinks3(request,response,arg);
		else if (arg.indexOf("lnk") > -1)
			processLinks(request,response,arg);
	}

	/*
	 * doPost
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 */
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException {
		doGet(request,response);
	}

	/*
	 * processForm
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 */
	public void processForm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";

		int iAction = 0;
		int rowsAffected = 0;
		int i;

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		String rtn = "crslnks";

		String alpha = "";
		String num = "";
		String type = "";
		String proposer = "";
		String url = "";
		String kix = "";
		String src = "";
		String dst = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			final int cancelAction 			= 1;
			final int deleteAction 			= 2;
			final int insertAction 			= 3;
			final int deleteForceAction 	= 4;

			String cancel = website.getRequestParameter(request, "aseFinish");
			String delete = website.getRequestParameter(request, "aseDelete");
			String deleteForce = website.getRequestParameter(request, "aseDeleteForce");
			String insert = website.getRequestParameter(request, "aseSave");

			if (cancel != null && cancel.length() > 0) sAction = cancel.trim();
			if (delete != null && delete.length() > 0) sAction = delete.trim();
			if (deleteForce != null && deleteForce.length() > 0) sAction = deleteForce.trim();
			if (insert != null && insert.length() > 0) sAction = insert.trim();

			// this class handles a lot of form actions and in some instances,
			// there is a need to give command buttons different names.
			if (sAction.equals(Constant.BLANK)){
				cancel = website.getRequestParameter(request,"aseCancel");
				if (cancel != null && cancel.length() > 0) sAction = cancel.trim();
			}

			if (sAction.equalsIgnoreCase("no") || sAction.equalsIgnoreCase("cancel")) {
				iAction = cancelAction;
			}
			else if (sAction.equalsIgnoreCase("yes") || sAction.equalsIgnoreCase("delete")) {
				iAction = deleteAction;
			}
			else if (sAction.equalsIgnoreCase("force delete")) {
				iAction = deleteForceAction;
			}
			else if (sAction.equalsIgnoreCase("save")) {
				iAction = insertAction;
			}

			src = website.getRequestParameter(request,"src");
			dst = website.getRequestParameter(request,"dst");
			kix = website.getRequestParameter(request,"kix");

			if (!kix.equals(Constant.BLANK)){
				String[] info = Helper.getKixInfo(connection,kix);
				alpha = info[0];
				num = info[1];
				type = info[2];
				proposer = info[3];
				campus = info[4];
			}

			// where to go back to
			if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
				rtn = "crslnks";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_PLO)){
				rtn = "crsgen";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO)){
				rtn = "crsgen";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_GESLO)){
				rtn = "crsgen";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){
				rtn = "crscntnt";
			}

			Msg msg = new Msg();

			// action is to add or remove (a or r)
			String action = website.getRequestParameter(request,"act", "");

			// if all the values are in place, add or remove
			if ( action.length() > 0 ){
				String content = website.getRequestParameter(request,"content", "");
				String descr = website.getRequestParameter(request,"description");
				int id = website.getRequestParameter(request,"keyid", 0);

				if (action.equals("a") || action.equals("r")){
					switch (iAction) {
						case cancelAction:
							message = "Operation was cancelled";
							break;
						case deleteAction:

							// IMPORTANT!!!
							//
							// this code is identical to code for deleteForceAction with
							// the exception that force deletion has
							//
							// LinkerDB.deleteLinkedItems(connection,campus,kix,src,id);
							//
							// to force delete
							//
							// should find a way to consolidate

							if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
								// delete the competency
								rowsAffected = CompetencyDB.deleteCompetency(connection,kix,id);
								if (rowsAffected == 1)
									msg.setMsg("");
								else
									msg.setMsg("Exception");
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_PLO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_GESLO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){
								msg = ContentDB.addRemoveCourseContent(connection,
																					"r",
																					campus,
																					alpha,
																					num,
																					user,
																					descr,
																					content,
																					id,
																					kix);

								if (!"Exception".equals(msg.getMsg()))
									message = "Content was deleted successfully";
								else
									message = "Unable to delete content";
							}

							break;
						case deleteForceAction:
							// when forcing deletes of links, start here
							LinkerDB.deleteLinkedItems(connection,campus,kix,src,id);

							if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){

								// delete the competency
								rowsAffected = CompetencyDB.deleteCompetency(connection,kix,id);
								if (rowsAffected == 1)
									msg.setMsg("");
								else
									msg.setMsg("Exception");
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_PLO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_GESLO)){
								rowsAffected = GenericContentDB.deleteContent(connection,kix,id);

								if (rowsAffected > 0)
									message = "Content deleted successfully.";
								else
									message = "Unable to delete content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){
								msg = ContentDB.addRemoveCourseContent(connection,
																					"r",
																					campus,
																					alpha,
																					num,
																					user,
																					descr,
																					content,
																					id,
																					kix);

								if (!"Exception".equals(msg.getMsg()))
									message = "Content was deleted successfully";
								else
									message = "Unable to delete content";
							}

							break;
						case insertAction:
							if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
								msg = CompetencyDB.addRemoveCompetency(connection,action,campus,alpha,num,content,id,user,kix);
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_PLO)){

								String genContent = website.getRequestParameter(request,"genContent");
								GenericContent gc = new GenericContent(id,kix,campus,alpha,num,"PRE",src,genContent,"",user,0);

								if (id==0)
									rowsAffected = GenericContentDB.insertContent(connection,gc);
								else
									rowsAffected = GenericContentDB.updateContent(connection,gc);

								if (rowsAffected > 0)
									message = "Content saved successfully.";
								else
									message = "Unable to save content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO)){

								String genContent = website.getRequestParameter(request,"genContent");
								GenericContent gc = new GenericContent(id,kix,campus,alpha,num,"PRE",src,genContent,"",user,0);

								if (id==0)
									rowsAffected = GenericContentDB.insertContent(connection,gc);
								else
									rowsAffected = GenericContentDB.updateContent(connection,gc);

								if (rowsAffected > 0)
									message = "Content saved successfully.";
								else
									message = "Unable to save content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_GESLO)){

								String genContent = website.getRequestParameter(request,"genContent");
								GenericContent gc = new GenericContent(id,kix,campus,alpha,num,"PRE",src,genContent,"",user,0);

								if (id==0)
									rowsAffected = GenericContentDB.insertContent(connection,gc);
								else
									rowsAffected = GenericContentDB.updateContent(connection,gc);

								if (rowsAffected > 0)
									message = "Content saved successfully.";
								else
									message = "Unable to save content";
							}
							else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){

								msg = ContentDB.addRemoveCourseContent(connection,
																					"a",
																					campus,
																					alpha,
																					num,
																					user,
																					descr,
																					content,
																					id,
																					kix);

								if (!"Exception".equals(msg.getMsg()))
									message = "Content was saved successfully";
								else
									message = "Unable to save content";
							}

							break;
					}	// switch
				}	// action
				else{
					msg.setMsg("Invalid action");
				}
			}	// action
			else{
				msg.setMsg("Invalid action");
			}

			session.setAttribute("aseApplicationMessage",message);
			session.setAttribute("aseMsg",msg);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage",e.toString());
			session.setAttribute("aseException", "Exception");
			logger.fatal("LinkerServlet - processForm - " + e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp?kix="+kix);
		} else {
			url = response.encodeURL("/core/msg3.jsp?rtn="+rtn+"&kix="+kix+"&src="+src+"&dst="+dst );
		}

		getServletContext().getRequestDispatcher(url).forward(request,response);
	}

	/*
	 * processLinks
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * @param	arg		String
	 * <p>
	 */
	public void processLinks(HttpServletRequest request, HttpServletResponse response,String arg) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";

		int iAction = 0;
		int rowsAffected = 0;

		String temp = "";
		String message = "";
		String kix = "";
		String campus = "";
		String user = "";

		String src = "";
		String dst = "";
		String caller = "";
		String sql = "";

		Msg msg = new Msg();

		Connection conn = connectionPool.getConnection();
		PreparedStatement ps = null;
		WebSite website = new WebSite();

		try {
			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			caller = website.getRequestParameter(request,"caller");
			kix = website.getRequestParameter(request,"kix");
			src = website.getRequestParameter(request,"src");
			dst = website.getRequestParameter(request,"dst");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int submitAction = 2;

			if (sAction.equalsIgnoreCase("Close")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("Save")) { iAction = submitAction; }

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled.<br/>";
					break;
				case submitAction:

					if (src.equals(Constant.COURSE_CONTENT) && (dst.equals("SLO") || dst.equals("Objectives")))
						rowsAffected = SLODB.saveLinkedData(request,conn,campus,src,kix,user);
					else
						rowsAffected = LinkedUtil.saveLinkedData(request,conn,campus,src,dst,kix,user);

					message = "Selection(s) saved successfully.";

					break;
			}

			msg.setMsg(message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			msg.setMsg("Exception");
			logger.fatal("LinkerServlet - processLinks - " + e.toString());
			throw new ServletException(e);
		} finally {
			try{
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				throw new ServletException(ex);
			}

			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseMsg",msg);

		String url = "";
		String rtn = "crslnks";

		// lnk2 is linking from new screen with full links
		if ("lnk2".equals(arg))
			rtn = "crslnkdxx";

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp?kix="+kix);
		} else {
			if (!"".equals(caller))
				rtn = caller;

			dst = LinkedUtil.GetDstFromKeyName(conn,dst);

			String level1 = website.getRequestParameter(request,"level1","");
			String level2 = website.getRequestParameter(request,"level2","");
			url = response.encodeURL("/core/msg3.jsp?rtn="+rtn+"&src="+src+"&dst="+dst+"&kix="+kix+"&level1="+level1+"&level2="+level2 );
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/*
	 * processLinks3
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * @param	arg		String
	 * <p>
	 */
	public void processLinks3(HttpServletRequest request, HttpServletResponse response,String arg) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";

		int i = 0;
		int j = 0;
		int ix = 0;
		int iAction = 0;
		int rowsAffected = 0;

		String campus = "";
		String user = "";

		String caller = "";
		String sql = "";

		String src = "";
		String dst = "";
		String temp = "";
		String kix = "";
		String alpha = "";
		String num = "";
		String field = "";
		String message = "";
		String dstFullName = "";

		Msg msg = new Msg();

		Connection conn = connectionPool.getConnection();
		PreparedStatement ps = null;
		WebSite website = new WebSite();

		try {
			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				kix = enc.getKix();
				src = enc.getSrc();
				dst = enc.getDst();
				user = enc.getUser();
			}

			session.removeAttribute("aseLinker");

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			caller = website.getRequestParameter(request,"caller","");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int submitAction = 2;

			if (sAction.equalsIgnoreCase("Cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("Submit")) { iAction = submitAction; }

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled.<br/>";
					break;
				case submitAction:

					String[] info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];

					String[] xiAxis = SQLValues.getSrcData(conn,campus,kix,src,"key");
					String[] yiAxis = SQLValues.getDstData(conn,campus,kix,dst,"key");

					if (xiAxis!=null && yiAxis != null){
						for(i=0;i<xiAxis.length;i++){
							message = "";
							for(j=0;j<yiAxis.length;j++){
								field = ""+yiAxis[j]+"_"+xiAxis[i];
								temp = website.getRequestParameter(request,field, "");
								if (temp != null && temp.length() > 0){
									if ((Constant.BLANK).equals(message))
										message = yiAxis[j];
									else
										message += "," + yiAxis[j];
								}
							}

							// in prior coding, we used full text for DST so this code keeps that
							// convention going to avoid breaking the retrieval of data
							dstFullName = LinkedUtil.GetLinkedDestinationFullName(dst);

							if (dstFullName.equals("Objectives")){
								dstFullName = "SLO";
							}

							ix = Integer.parseInt(xiAxis[i]);

							if (src.equals(Constant.COURSE_CONTENT) && dstFullName.equals("SLO")){
								rowsAffected = SLODB.saveLinkedData2(conn,campus,src,kix,user,message,ix);
							}
							else{
								rowsAffected = LinkedUtil.saveLinkedData2(conn,campus,src,dstFullName,kix,user,message,ix);
							}

						} // for
					} // if

					message = "Selection(s) saved successfully.";

					break;
			}

			msg.setMsg(message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			msg.setMsg("Exception");
			logger.fatal("LinkerServlet - processLinks - " + e.toString());
			throw new ServletException(e);
		} finally {
			try{
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				throw new ServletException(ex);
			}

			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseMsg",msg);

		String url = "";
		String rtn = "crslnks";

		rtn = "crslnkdxx";

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp?kix="+kix);
		} else {
			if (!"".equals(caller))
				rtn = caller;

			url = response.encodeURL("/core/msg3.jsp?rtn="+rtn+"&src="+src+"&dst="+dst+"&kix="+kix);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	} // processLinks3

	/*
	 * processFoundations
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * <p>
	 */
	public void processFoundations(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";

		int i = 0;
		int j = 0;
		int ix = 0;
		int iAction = 0;
		int rowsAffected = 0;

		String campus = "";
		String user = "";

		String caller = "";
		String sql = "";

		String src = "";
		String temp = "";
		String kix = "";
		String field = "";
		String message = "";

		int id = 0;

		Msg msg = new Msg();

		Connection conn = connectionPool.getConnection();
		PreparedStatement ps = null;
		WebSite website = new WebSite();

		try {
			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			caller = website.getRequestParameter(request,"caller","");
			id = website.getRequestParameter(request,"id",0);
			kix = website.getRequestParameter(request,"kix","");
			src = website.getRequestParameter(request,"src","");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int submitAction = 2;

			if (sAction.equalsIgnoreCase("Cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("Submit")) { iAction = submitAction; }

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled.<br/>";
					break;
				case submitAction:

					String junkX = website.getRequestParameter(request,"xiAxis", "");
					String junkY = website.getRequestParameter(request,"yiAxis", "");

					if (junkX!=null && junkY != null && id > 0){

						String[] xiAxis = junkX.split(",");
						String[] yiAxis = junkY.split(",");

						if (xiAxis!=null && yiAxis != null){

							//
							// with valid data, we start by deleting old selections
							//
							sql = "DELETE FROM tblfndlinked WHERE campus=? AND id=? AND historyid=?";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setInt(2,id);
							ps.setString(3,kix);
							rowsAffected = ps.executeUpdate();
							ps.close();

							for(i=0;i<yiAxis.length;i++){

								for(j=0;j<xiAxis.length;j++){

									field = ""+yiAxis[i]+"_"+xiAxis[j];
									temp = website.getRequestParameter(request,field, "");

									if(temp.equals(Constant.ON)){
										sql = "INSERT INTO tblfndlinked (campus,id,historyid,src,srcid,fndid,auditby,auditdate) VALUES(?,?,?,?,?,?,?,?)";
										ps = conn.prepareStatement(sql);
										ps.setString(1,campus);
										ps.setInt(2,id);
										ps.setString(3,kix);
										ps.setString(4,src);
										ps.setInt(5,NumericUtil.getInt(yiAxis[i],0));
										ps.setInt(6,NumericUtil.getInt(xiAxis[j],0));
										ps.setString(7,user);
										ps.setString(8,AseUtil.getCurrentDateTimeString());
										rowsAffected = ps.executeUpdate();
										ps.close();
									}

								} // for xiAxis

							} // for yiAxis

						} // valid axis data

						message = "Selection(s) saved successfully.";

					} // valid website data

					break;
			}

			msg.setMsg(message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			msg.setMsg("Exception");
			logger.fatal("LinkerServlet - processFoundations - " + e.toString());
			throw new ServletException(e);
		} finally {
			try{
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				throw new ServletException(ex);
			}

			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseMsg",msg);

		String url = "";
		String rtn = "fndedt";

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp?kix="+kix);
		} else {
			if (!caller.equals(Constant.BLANK))
				rtn = caller;

			url = response.encodeURL("/core/msg3.jsp?arg=fnd&rtn="+rtn+"&id="+id);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

}