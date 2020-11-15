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
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class OutlineServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(OutlineServlet.class.getName());
	static boolean debug = false;

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
			if (src.equals("apprrqst")){
				rowsAffected = requestingApproval(request,response);
				rtn = "msg";
				src = "tasks";
			}
			else if (src.equals("fstrk")){
				rowsAffected = fastTrackApproval(request,response);
				rtn = "msg3";
				src = "crsfstrk";
			}
			else if (src.equals("pslo")){
				rowsAffected = quickListPSLO(request,response);
				rtn = "msg3";
				src = "crspslo";
			}
			else if (src.equals("qlst")){
				rowsAffected = quickList(request,response);
				rtn = "msg3";

				if (rtn2.equals("edt") || rtn2.equals("edtslo") || rtn2.equals("edtpslo") || rtn2.equals("edtcnt"))
					src = "qlst2crslnks";
				else
					src = "qlst";
			}
			else if (src.equals("qlstntr")){
				rowsAffected = quickListEntries(request,response);
				rtn = "msg3";
				src = "crsqlst";
			}
			else if (src.equals("raw")){
				rowsAffected = rawUpdates(request,response);
				rtn = "msg";
				src = "crsfldy";
			}
		} catch (Exception ie) {
			throw new ServletException(ie);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/"+rtn+".jsp");
		} else {
			url = response.encodeURL("/core/"+rtn+".jsp?rtn="+src+"&kix="+kix+"&itm="+itm);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	/*
	 * requestingApproval
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int requestingApproval(HttpServletRequest request, HttpServletResponse response){

		//Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String message = "";

		int tempInt = 0;
		int junkInt = 0;

		String[] tempString = null;
		String[] junkString = null;

		String taskAlpha = "";
		String taskNum = "";

		String sql = "";
		String sqlx = "";
		String fieldName = "";
		String approval = "";

		String alphax = "";
		String numx = "";

		int rowsAffected = -1;

		WebSite website = new WebSite();

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		String property = "";
		String logMessage = "";
		String proposer = "";

		// approval is granted per kix or course outline
		String kix = website.getRequestParameter(request,"kix", "");

		Connection conn = connectionPool.getConnection();

		final int PREREQS		= 0;
		final int COREQS		= 1;
		final int XLIST		= 2;
		final int PROGRAMS	= 3;
		int typesOfApprovals = 4;

		String[] sqlu = new String[typesOfApprovals];
		String[] sqld = new String[typesOfApprovals];
		String[] fn = new String[typesOfApprovals];
		String[] msg = new String[typesOfApprovals];

		fn[PREREQS] = "preReq";

		msg[PREREQS] = "re requisites";

		sqlu[PREREQS] = "UPDATE tblPreReq SET "
			+ "pending=0,approvedby=?,approveddate=? "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND prereqalpha=? AND prereqnum=? AND coursetype='PRE'";

		sqld[PREREQS] = "DELETE FROM tblPreReq "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND prereqalpha=? AND prereqnum=? AND coursetype='PRE'";

		fn[COREQS] = "coReq";

		msg[COREQS] = "Co-requisites";

		sqlu[COREQS] = "UPDATE tblCoReq SET "
			+ "pending=0,approvedby=?,approveddate=? "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND coreqalpha=? AND coreqnum=? AND coursetype='PRE'";

		sqld[COREQS] = "DELETE FROM tblCoReq "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND coreqalpha=? AND coreqnum=? AND coursetype='PRE'";

		fn[XLIST] = "xref";

		msg[XLIST] = "Cross listing";

		sqlu[XLIST] = "UPDATE tblxref SET "
			+ "pending=0,approvedby=?,approveddate=? "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND coursealphaX=? AND coursenumX=? AND coursetype='PRE'";

		sqld[XLIST] = "DELETE FROM tblxref "
			+ "WHERE campus=? "
			+ "AND historyid=? AND coursealpha=? AND coursenum=? AND coursealphaX=? AND coursenumX=? AND coursetype='PRE'";

		fn[PROGRAMS] = "program";

		msg[PROGRAMS] = "Programs";

		sqlu[PROGRAMS] = "UPDATE tblExtra SET "
			+ "pending=0,approvedby=?,approveddate=? "
			+ "WHERE campus=? AND historyid=? AND coursealpha=? AND coursenum=? AND grading=? ";

		sqld[PROGRAMS] = "DELETE FROM tblExtra "
			+ "WHERE campus=? AND historyid=? AND coursealpha=? AND coursenum=? AND grading=? ";

		PreparedStatement ps = null;

		boolean debug = false;
		boolean deleteTask = false;

 		try{
			String[] info = Helper.getKixInfo(conn,kix);
			if (info != null){
				taskAlpha = info[Constant.KIX_ALPHA];
				taskNum = info[Constant.KIX_NUM];
				campus = info[Constant.KIX_CAMPUS];
				proposer = info[Constant.KIX_PROPOSER];

				// outer for goes through each of the 4 outline items above.
				// inner for retrieves data from request object for each item at a time
				for(int req=0; req<typesOfApprovals; req++){

					fieldName	= fn[req];		// database colum
					sql 			= sqlu[req];	// update sql
					sqlx 			= sqld[req];	// delete sql
					message 		= msg[req];		// message or friendly column name

					// when more than 1 single pre/co req exists and not all were processed, don't allow
					// delete to the task. allow user to return for processing until all are done.
					deleteTask = true;

					// hidden variable exists for each outline item. items are ENG~~100,ENG~~101,ENG~~102
					String data = website.getRequestParameter(request,fieldName,"");
					if(data != null && data.indexOf(Constant.SEPARATOR)>-1){
						tempString = data.split(",");
						tempInt = tempString.length;
						data = "";
						for(junkInt = 0; junkInt<tempInt; junkInt++){

							junkString = tempString[junkInt].split(Constant.SEPARATOR);	// ENG~~100
							alphax = junkString[0];													// ENG
							numx = junkString[1];													// 100
							approval = website.getRequestParameter(request,fieldName+"_"+alphax+"_"+numx,"");

							rowsAffected = -1;

							// when approved, remove pending flag
							// if not approved, remove the entry waiting for the approval
							if (approval.equals(Constant.ON)){

								ps = conn.prepareStatement(sql);

								if (req != PROGRAMS){
									ps.setString(1,user);
									ps.setString(2,AseUtil.getCurrentDateTimeString());
									ps.setString(3,campus);
									ps.setString(4,kix);
									ps.setString(5,taskAlpha);
									ps.setString(6,taskNum);
									ps.setString(7,alphax);
									ps.setString(8,numx);
								}
								else{
									ps.setString(1,user);
									ps.setString(2,AseUtil.getCurrentDateTimeString());
									ps.setString(3,campus);
									ps.setString(4,kix);
									ps.setString(5,taskAlpha);
									ps.setString(6,taskNum);
									ps.setString(7,alphax);
								}
								rowsAffected = ps.executeUpdate();
								ps.close();
								logMessage = "approved";
							}
							else if (approval.equals(Constant.OFF)){

								ps = conn.prepareStatement(sqlx);

								if (req != PROGRAMS){
									ps.setString(1,campus);
									ps.setString(2,kix);
									ps.setString(3,taskAlpha);
									ps.setString(4,taskNum);
									ps.setString(5,alphax);
									ps.setString(6,numx);
								}
								else{
									ps.setString(1,campus);
									ps.setString(2,kix);
									ps.setString(3,taskAlpha);
									ps.setString(4,taskNum);
									ps.setString(5,alphax);
								}
								rowsAffected = ps.executeUpdate();
								ps.close();
								logMessage = "not approved";
							}
							else{
								deleteTask = false;
							}// if approval


							// determine proper message (an update or delete took place)
							// send mail for each item processed
							if (rowsAffected > 0){
								if (approval.equals(Constant.ON)){

									property = "emailRequisiteApproved";

									if (req == XLIST){
										property = "emailCrossListingApproved";
									}
									else if (req == PROGRAMS){
										property = "emailProgramApproved";
									}
								}
								else if (approval.equals(Constant.OFF)){

									property = "emailRequisiteNotApproved";

									if (req == XLIST){
										property = "emailCrossListingNotApproved";
									}
									else if (req == PROGRAMS){
										property = "emailProgramNotApproved";
									}
								}

								// send mail and and remove task from approver
								// notify requestor of approve/not approve
								AseUtil.logAction(conn,
														user,
														"ACTION",
														message + " " + logMessage + " ("+ alphax + " " + numx + ")",taskAlpha,taskNum,campus,kix);

								MailerDB mailerDB = new MailerDB(conn,
																			user,
																			proposer,
																			Constant.BLANK,
																			Constant.BLANK,
																			taskAlpha,
																			taskNum,
																			campus,
																			property,
																			kix,
																			user);
							} // rowsAffected > 0 && deleteTask

						} // for each record of each approval type

					} // data from form submission

					property = Constant.BLANK;

					// determine proper message (an update or delete took place)
					// by default, deleteTask is set to true unless nothing was selected
					if (deleteTask){

						// are there approvals pending
						int preReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_PREREQ);
						int coReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_COREQ);
						if ((preReqs + coReqs == 0) && deleteTask){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	taskAlpha,
																	taskNum,
																	Constant.APPROVE_REQUISITE_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	Constant.PRE);
							if (debug) logger.info("Requisites approval request task removed for " + user);
						}

						// are there approvals pending
						int xref = XRefDB.crossListingRequiringApproval(conn,kix);
						if (xref == 0 && deleteTask){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	taskAlpha,
																	taskNum,
																	Constant.APPROVE_CROSS_LISTING_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	Constant.PRE);
							if (debug) logger.info("Cross listing approval request task removed for " + user);
						}

						// are there approvals pending
						int programs = ProgramsDB.programsRequiringApproval(conn,kix);
						if (programs == 0 && deleteTask){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	taskAlpha,
																	taskNum,
																	Constant.APPROVE_PROGRAM_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	Constant.PRE);
							if (debug) logger.info("Program approval request task removed for " + user);
						}

					} // rowsAffected property file

				}	// for
			} // if info != null

			message = "Operation completed successfully.";
		}
		catch(SQLException e){
			logger.fatal("OutlineServlet requestingApproval - " + e.toString());
			message = "Approval failed<br>";
			rowsAffected = -1;
		}
		catch(Exception e){
			logger.fatal("OutlineServlet requestingApproval - " + e.toString());
			message = "Approval failed<br>";
			rowsAffected = -1;
		} finally {
			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseApplicationMessage", message);

		return rowsAffected;

	}

	/*
	 * fastTrackApproval
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int fastTrackApproval(HttpServletRequest request, HttpServletResponse response){

		//Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int rowsAffected = -1;

		WebSite website = new WebSite();

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
		String kix = website.getRequestParameter(request,"kix");
		int seq = website.getRequestParameter(request,"appr", 0);
		int lastSeq = website.getRequestParameter(request,"lastSeq", 0);

		String message = "";
		String temp = "";

		Connection conn = connectionPool.getConnection();

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			int route = Integer.parseInt(info[6]);
			rowsAffected = ApproverDB.fastTrackApprovers(conn,campus,kix,seq,lastSeq,route,user);
			message = "Fast track completed successfully.<br>";
		} catch(Exception ex){
			logger.fatal("OutlineServlet fastTrackApprovers\n" + ex.toString());
			message = "Fast track failed.<br>";
			rowsAffected = -1;
		} finally {
			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseApplicationMessage", message);

		return rowsAffected;
	}

	/*
	 * rawUpdates
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int rawUpdates(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		session.setAttribute("aseException", "");

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;

		WebSite website = new WebSite();

		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		String alpha = "";
		String num = "";
		String type = "";

		String toAlpha = "";
		String toNum = "";

		String message = "";

		boolean updateRawData = false;
		boolean updateCourse = false;

		Msg msg = new Msg();

		Connection connection = connectionPool.getConnection();

		String kix = website.getRequestParameter(request,"kix");
		if (!kix.equals("")){
			String[] info = Helper.getKixInfo(connection,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];
		}

		try {
			debug = DebugDB.getDebug(connection,"OutlineServlet");

			if (debug) logger.info("OutlineServlet: rawUpdates - Entering");

			if (formName != null && formName.equals("aseForm") && Skew.confirmEncodedValue(request)){
				String data = website.getRequestParameter(request,"questions");
				String explain = website.getRequestParameter(request,"explain");
				String question_explain = website.getRequestParameter(request,"question_explain");
				String questionNumber = website.getRequestParameter(request,"questionNumber");
				String column = website.getRequestParameter(request,"column");
				String selectedCheckBoxes = website.getRequestParameter(request,"selectedCheckBoxes");
				int table = website.getRequestParameter(request,"table", 0);

				/*
					numberOfControls exits when working with checks or radios. in this case
					we want to iterate the number of controls and collect their values.
				*/
				int numberOfControls = website.getRequestParameter(request,"numberOfControls", 0);
				if (numberOfControls > 0){
					data = "";
					// 1 means that we have a radio or greater than 1 means check marks
					if ( numberOfControls == 1 ){
						data = website.getRequestParameter(request,"questions_0", "0");
					}
					else{
						data = selectedCheckBoxes;

						//
						//	when dealing with contact hours and there are drop down list, we combine
						//	each selected checked item with a separator with the hour
						//
						int junkInt = 0;
						String junkData = "";

						boolean includeRange = IniDB.showItemAsDropDownListRange(connection,campus,"NumberOfContactHoursRangeValue");
						if (includeRange){
							String[] tempString = data.split(",");
							int tempInt = tempString.length;
							data = "";
							for (junkInt = 0; junkInt < tempInt; junkInt++){
								junkData = website.getRequestParameter(request,tempString[junkInt] + "_ddl", "0");
								tempString[junkInt] = tempString[junkInt] + Constant.SEPARATOR + junkData;

								if (junkInt==0)
									data = tempString[junkInt];
								else
									data = data + "," + tempString[junkInt];
							}
						} // includeRange

					}
				}

				// when the course alpha/number is updated, we have to check to see if there is somethign
				// in flight before permitting it to go by. If not, permit only update of raw data
				if (column.toLowerCase().equals("coursenum") || column.toLowerCase().equals("coursealpha")){
					if (column.equals("coursenum")){
						toAlpha = alpha;
						toNum = data;
					}
					else{
						toNum = num;
						toAlpha= data;
					}

					msg = CourseDB.isCourseRenamable(connection,campus,alpha,num,toAlpha,toNum,user,type);
					if ("".equals(msg.getMsg())){
						updateRawData = true;
						updateCourse = true;
						logger.info("Renaming alpha or number");
					}
				}
				else
					updateRawData = true;

				// if ok to update, do it. however, if not alpha or num, then don't rename
				if (updateRawData){

					// when it's alpha or number, a rename covers it without having to update raw
					if (updateCourse){
						msg = CourseRename.renameOutline(connection,campus,alpha,num,toAlpha,toNum,user,type);

						// create the outline for easy and fast access
						Tables.createOutlines(connection,campus,kix,toAlpha,toNum,"html","","",false,false,true);
					}
					else{

						String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","UseGESLOGrid");
						if (column.equals(Constant.COURSE_GESLO) && useGESLOGrid.equals(Constant.ON)){
							msg = GESLODB.processGESLO(connection,request,kix);
						}
						else if (column.equals(Constant.COURSE_CCOWIQ)){
							CowiqDB.updateCowiq(connection,request,campus,kix,column,user);
						}
						else{
							msg = CourseDB.updateCourseRaw(connection,kix,column,data,user,explain,question_explain,table);
						}

						AseUtil.logAction(connection,user,"ACTION","Raw data edit (#"+questionNumber+" - " + column + ")",alpha,num,campus,kix);

						// create the outline for easy and fast access
						Tables.createOutlines(connection,campus,kix,alpha,num,"html","","",false,false,true);

					}

					if (!"Exception".equals(msg.getMsg()))
						message = "Outline item was updated successfully.<br>";
					else
						message = "Outline item update failed.<br>";
				}
				else{
					message = "The requested update is not permitted on an outline that is being modified.";
				}

			}	// valid form
			else{
				message = "Invalid security code";
			}

			session.setAttribute("aseApplicationMessage", message);

			if (debug) logger.info("OutlineServlet: rawUpdates - Exiting");

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
		if (!"".equals(kix)){
			String[] info = Helper.getKixInfo(connection,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
		}

		try {
			debug = DebugDB.getDebug(connection,"OutlineServlet");

			if (formName != null && formName.equals("aseForm") && Skew.confirmEncodedValue(request)){
				String lst = website.getRequestParameter(request,"lst");
				String clear = website.getRequestParameter(request,"clr","0");
				String clearList = website.getRequestParameter(request,"clrList","0");

				String temp = "";
				String[] arr;
				int i = 0;

				// clear existing content before updating
				if (clear.equals("1")){
					if (itm.equals(Constant.COURSE_OBJECTIVES)){
						CompDB.updateObjective(connection,kix,"");
					}
					else if(itm.equals(Constant.COURSE_COMPETENCIES)){
						CompetencyDB.updateCompetency(connection,kix,"");
					}
					else if(itm.equals(Constant.COURSE_PROGRAM_SLO)){
						GenericContentDB.updateProgramSLO(connection,kix,"");
					}
					else if(itm.equals(Constant.COURSE_INSTITUTION_LO)){
						GenericContentDB.updateGenericCourseContent(connection,kix,itm,"");
					}
					else if(itm.equals(Constant.COURSE_CONTENT)){
						ContentDB.updateContent(connection,kix,"");
					}
				}

				// clear existing list before updating
				if (clearList.equals("1")){
					Outlines.deleteLinkedItems(connection,campus,kix,itm);
				}

				// split content and save
				arr = lst.split("//");
				for(i=0;i<arr.length;i++){
					if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){
						if (itm.equals(Constant.COURSE_OBJECTIVES)){
							msg = CompDB.addRemoveCourseComp(connection,"a",campus,alpha,num,arr[i],0,user,kix);
						}
						else if(itm.equals(Constant.COURSE_COMPETENCIES)){
							msg = CompetencyDB.addRemoveCompetency(connection,"a",campus,alpha,num,arr[i],0,user,kix);
						}
						else if(itm.equals(Constant.COURSE_PROGRAM_SLO)){
							GenericContent gc = new GenericContent(0,kix,campus,alpha,num,type,itm,arr[i],"",user,0);
							GenericContentDB.insertContent(connection,gc);
						}
						else if(itm.equals(Constant.COURSE_INSTITUTION_LO)){
							GenericContent gc = new GenericContent(0,kix,campus,alpha,num,type,itm,arr[i],"",user,0);
							GenericContentDB.insertContent(connection,gc);
						}
						else if(itm.equals(Constant.COURSE_CONTENT)){
							ContentDB.addRemoveCourseContent(connection,"a",campus,alpha,num,user,"",arr[i],0,kix);
						}

						if (!"Exception".equals(msg.getMsg()))
							message = "Operation completed successfully";
						else
							message = "Unable to complete requested operation";
					} // if arr
				}	// for
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
	 * quickListPSLO
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int quickListPSLO(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int rowsAffected = 0;

		WebSite website = new WebSite();
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		Msg msg = new Msg();

		String message = "";

		Connection connection = connectionPool.getConnection();

		try {
			debug = DebugDB.getDebug(connection,"OutlineServlet");

			if (formName != null && formName.equals("aseForm")){
				String lst = website.getRequestParameter(request,"lst");
				String alpha = website.getRequestParameter(request,"alpha","");
				String num = "";
				String type = "CUR";
				String itm = Constant.COURSE_PROGRAM_SLO;
				String temp = "";
				String historyid = "";
				String[] arr;
				int i = 0;

				GenericContent gc = null;

				arr = lst.split("//");

				String sql = "SELECT historyid,coursenum FROM tblCourse WHERE campus=? AND coursealpha=? and coursetype=?";
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,type);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					historyid = rs.getString("historyid");
					num = rs.getString("coursenum");

					if (historyid != null && historyid.length()>0){
						for(i=0;i<arr.length;i++){
							if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){
								gc = new GenericContent(0,historyid,campus,alpha,num,type,itm,arr[i],"",user,0);
								GenericContentDB.insertContent(connection,gc);
								++rowsAffected;
							}
						}
					}
				}
				rs.close();
				ps.close();

				message = "Operation completed successfully. " + rowsAffected + " row(s) update";
			}
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
	 * quickListEntries
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int quickListEntries(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int rowsAffected = 0;

		WebSite website = new WebSite();
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);
		String listType = "";

		Msg msg = new Msg();

		String message = "";

		Connection connection = connectionPool.getConnection();

		try {
			debug = DebugDB.getDebug(connection,"OutlineServlet");

			if (formName != null && formName.equals("aseForm")){
				String lst = website.getRequestParameter(request,"lst");
				String alpha = website.getRequestParameter(request,"alpha","");
				int division = website.getRequestParameter(request,"division",0);
				String divisionCode = DivisionDB.getDivisonCodeFromID(connection,campus,division);

				// when division name is missing, alpha it is. or reverse
				if (divisionCode == null || divisionCode.length() == 0)
					divisionCode = alpha;
				else if (alpha == null || alpha.length() == 0)
					alpha = divisionCode;

				// what type of list
				String itm = website.getRequestParameter(request,"type","");
				if ((Constant.COURSE_GESLO).equals(itm))
					listType = "GESLO";
				else if ((Constant.COURSE_INSTITUTION_LO).equals(itm))
					listType = "ILO";
				else if ((Constant.COURSE_PROGRAM_SLO).equals(itm))
					listType = "PLO";
				else if ((Constant.COURSE_OBJECTIVES).equals(itm))
					listType = "SLO";

				String temp = "";
				String[] arr;
				Values values = null;
				int i = 0;

				arr = lst.split("//");

				for(i=0;i<arr.length;i++){

					if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){

						ValuesDB.insertValues(connection,
													new Values(0,campus,listType + " - " + divisionCode,alpha,arr[i],null,user,itm));
						++rowsAffected;
					}
				}

				message = "Operation completed successfully. " + rowsAffected + " row(s) update";
			}
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