/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// ProgramServlet.java
//
package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ProgramServlet extends HttpServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(ProgramServlet.class.getName());

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
		logger.info("ProgramServlet: destroyed...");
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

		String kix = "";

		WebSite website = new WebSite();

		String action = website.getRequestParameter(request,"ack","");

		if (action.equals("can")){
			kix = cancelProgram(request,response);
		}
		else if (action.equals("crt")){
			kix = createProgram(request,response);
		}
		else if (action.equals("dlt")){
			kix = deleteProgram(request,response);
		}
		else if (action.equals("fstrk")){
			kix = website.getRequestParameter(request,"kix");
			int rowsAffected = fastTrackApproval(request,response);
			String rtn = "msg3";
			action = "prgfstrk";
		}
		else if (action.equals("updt")){
			kix = updateProgram(request,response);
		}

		getServletContext().
					getRequestDispatcher("/core/talin.jsp?ack="+action+"&kix="+kix).
					forward(request, response);
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
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

		AsePool connectionPool = AsePool.getInstance();

		Connection conn = connectionPool.getConnection();

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			int route = Integer.parseInt(info[6]);

			rowsAffected = ApproverDB.fastTrackApprovers(conn,campus,kix,seq,lastSeq,route,user);

			message = "Fast track completed successfully.<br>";
		} catch(Exception ex){
			logger.fatal("ProgramServlet fastTrackApprovers\n" + ex.toString());
			message = "Fast track failed.<br>";
			rowsAffected = -1;
		} finally {
			connectionPool.freeConnection(conn);
		}

		session.setAttribute("aseApplicationMessage", message);

		return rowsAffected;
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 */
	private String createProgram(HttpServletRequest request,HttpServletResponse response){

		AsePool connectionPool = null;
		Connection conn = null;

		String formAction = null;
		String formName = null;

		String degree = null;
		String division = null;
		String title = null;
		String description = null;
		String effectiveDate = null;
		String year = null;
		boolean regentApproval = false;

		String message = null;
		String kix = null;

		String campus = null;
		String user = null;
		String skew = null;

		boolean failure = false;

		int rowsAffected = 0;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"ProgramServlet");

			if (debug) logger.info("ProgramServlet - CREATEPROGRAM - START");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				degree = enc.getKey1();
				division = enc.getKey2();
				title = enc.getKey3();
				description = enc.getKey4();
				effectiveDate = enc.getKey5();
				year = enc.getKey6();

				if ((Constant.ON).equals(enc.getKey7()))
					regentApproval = true;

				formName = enc.getKey8();
				formAction = enc.getKey9();

				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if (debug){
					logger.info("ProgramServlet - campus: " + campus);
					logger.info("ProgramServlet - user: " + user);
					logger.info("ProgramServlet - kix: " + kix);
					logger.info("ProgramServlet - skew: " + skew);
					logger.info("ProgramServlet - degree: " + degree);
					logger.info("ProgramServlet - division: " + division);
					logger.info("ProgramServlet - title: " + title);
					logger.info("ProgramServlet - description: " + description);
					logger.info("ProgramServlet - effectiveDate: " + effectiveDate);
					logger.info("ProgramServlet - year: " + year);
					logger.info("ProgramServlet - regentApproval: " + regentApproval);
					logger.info("ProgramServlet - formAction: " + formAction);
					logger.info("ProgramServlet - formName: " + formName);
				}

				if ( formName != null && formName.equals("aseForm") ){
					if (formAction.equalsIgnoreCase("s") && skew.equals("1")){

						int deg = NumericUtil.stringToInt(degree);
						int div = NumericUtil.stringToInt(division);

						if (!ProgramsDB.programExistByTitleCampus(conn,campus,title,deg,div)){
							Programs program = new Programs();

							program.setCampus(campus);

							kix = SQLUtil.createHistoryID(1);

							program.setHistoryId(kix);
							program.setType("PRE");
							program.setDegree(Integer.parseInt(degree));
							program.setEffectiveDate(effectiveDate + " " + year);
							program.setTitle(title);
							program.setDescription(description);
							program.setAuditBy(user);
							program.setAuditDate(AseUtil. getCurrentDateTimeString());
							program.setProposer(user);
							program.setProgress(Constant.COURSE_MODIFY_TEXT);
							program.setRegentsApproval(regentApproval);
							program.setDivision(Integer.parseInt(division));
							rowsAffected = ProgramsDB.insertProgram(conn,program);
							if (rowsAffected < 1){
								message = "Create program failed.<br><br>";
								failure = true;
							}
							else{
								message = "Program created successfully";

								rowsAffected = TaskDB.logTask(conn,
																		user,
																		user,
																		title,
																		DivisionDB.getDivisonCodeFromID(conn,campus,div),
																		Constant.PROGRAM_CREATE_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE,
																		Constant.TASK_PROPOSER,
																		Constant.TASK_PROPOSER,
																		kix,
																		Constant.PROGRAM,
																		"NEW");

								AseUtil.logAction(conn, user, "ACTION","Program created",degree,division,campus,kix);
							} // if rowsAffected
						}
						else{
							message = "Create Program Error!<br/><br/>Attempting to create program that already exists.";

							session.setAttribute("aseProgramTitle", title);
							session.setAttribute("aseProgramDegree", degree);
							session.setAttribute("aseProgramDivision", division);

							logger.info(message);

							failure = false;
						} // program exists
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
				logger.info("ProgramServlet: START");
				logger.info("ProgramServlet: " + message);
				logger.info("ProgramServlet: END");
			}

			if (debug) logger.info("ProgramServlet - CREATEPROGRAM - END");

		}
		catch(SQLException se){
			logger.fatal("ProgramServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"ProgramServlet",user);
		}

		return kix;
	} // createProgram

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 */
	private String deleteProgram(HttpServletRequest request,HttpServletResponse response){

		AsePool connectionPool = null;
		Connection conn = null;

		String formAction = null;
		String formName = null;
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

			boolean debug = DebugDB.getDebug(conn,"ProgramServlet");

			if (debug) logger.info("ProgramServlet - DELETEPROGRAM - START");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				formName = enc.getKey8();
				formAction = enc.getKey9();

				kix = enc.getKix();
				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if (debug){
					logger.info("ProgramServlet - campus: " + campus);
					logger.info("ProgramServlet - user: " + user);
					logger.info("ProgramServlet - kix: " + kix);
					logger.info("ProgramServlet - skew: " + skew);
					logger.info("ProgramServlet - formAction: " + formAction);
					logger.info("ProgramServlet - formName: " + formName);
				}

				if ( formName != null && formName.equals("aseForm") ){
					if ("s".equalsIgnoreCase(formAction) && "1".equals(skew)){
						Programs program = new Programs();
						program.setCampus(campus);
						program.setHistoryId(kix);
						program.setAuditBy(user);
						int rowsAffected = ProgramsDB.deleteProgram(conn,program);
						if (rowsAffected < 1){
							message = "Delete program failed.<br><br>";
							failure = true;
						}
						else{
							message = "Program deleted successfully";
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
				logger.info("ProgramServlet: START");
				logger.info("ProgramServlet: " + message);
				logger.info("ProgramServlet: END");
			}

			if (debug) logger.info("ProgramServlet - DELETEPROGRAM - END");

		}
		catch(SQLException se){
			logger.fatal("ProgramServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"ProgramServlet",user);
		}

		return kix;
	} // deleteProgram

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 */
	private String cancelProgram(HttpServletRequest request,HttpServletResponse response){

		AsePool connectionPool = null;
		Connection conn = null;

		String formAction = null;
		String formName = null;
		String message = null;
		String kix = null;

		String campus = null;
		String user = null;
		String skew = null;

		boolean failure = false;

		int rowsAffected = 0;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"ProgramServlet");

			if (debug) logger.info("ProgramServlet - CANCELPROGRAM - START");

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				formName = enc.getKey8();
				formAction = enc.getKey9();

				kix = enc.getKix();
				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();

				if (debug){
					logger.info("campus: " + campus);
					logger.info("user: " + user);
					logger.info("kix: " + kix);
					logger.info("skew: " + skew);
					logger.info("formAction: " + formAction);
					logger.info("formName: " + formName);
				}

				if ( formName != null && formName.equals("aseForm") ){
					if (formAction.equalsIgnoreCase("s") && skew.equals("1")){
						Programs program = new Programs();
						program.setCampus(campus);
						program.setHistoryId(kix);
						program.setAuditBy(user);
						msg = ProgramsDB.cancelProgram(conn,program);
						if (msg != null){
							if (msg.getMsg().equals("CancelFailure")){
								message = "Program cancel failed.<br><br>";
								failure = true;
							}
							else if (msg.getMsg().equals("NotCancellable")){
								message = "Program is not available for canceling at this time.<br><br>";
								failure = true;
							}
							else if (msg.getMsg().equals("NotAvailableToCancel")){
								message = "Program is not available for canceling at this time.<br><br>";
								failure = true;
							}
							else{
								message = "Program cancelled successfully";
							}
						}
						else{
							message = "Program cancelled successfully";
						} // msg

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
				logger.info("ProgramServlet: START");
				logger.info("ProgramServlet: " + message);
				logger.info("ProgramServlet: END");
			}

			if (debug) logger.info("ProgramServlet - CANCELPROGRAM - END");

		}
		catch(SQLException se){
			logger.fatal("ProgramServlet: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramServlet: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"ProgramServlet",user);
		}

		return kix;
	} // cancelProgram


	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 */
	private String updateProgram(HttpServletRequest request,HttpServletResponse response){

		AsePool connectionPool = null;
		Connection conn = null;

		String formAction = null;
		String formName = null;

		String title = null;
		String description = null;
		String effectiveDate = null;
		String year = null;
		boolean regentApproval = false;

		int degree = 0;
		int division = 0;
		int rowsAffected = 0;

		String message = null;
		String kix = null;
		String raw = null;

		String campus = null;
		String user = null;
		String type = null;
		String proposer = null;

		boolean failure = false;

		try{
			HttpSession session = request.getSession(true);

			Msg msg = new Msg();

			WebSite website = new WebSite();

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			boolean debug = DebugDB.getDebug(conn,"ProgramServlet");

			if (debug) logger.info("ProgramServlet - UPDATEPROGRAM - START");

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			int items = website.getRequestParameter(request,"items",0);

			if (items > 0){

				if (debug) logger.info("items: " + items);

				// get column names from db table
				String column = null;
				ArrayList columns = ProgramsDB.getColumnNames(conn,campus);
				if (columns != null){

					if (debug) logger.info("columns: " + columns.size());

					degree = website.getRequestParameter(request,"degree",0);
					division = website.getRequestParameter(request,"division",0);
					title = website.getRequestParameter(request,"title","");
					description = website.getRequestParameter(request,"description","");
					effectiveDate = website.getRequestParameter(request,"effectiveDate","");
					year = website.getRequestParameter(request,"year","");
					raw = website.getRequestParameter(request,"raw","0");

					kix = website.getRequestParameter(request,"kix","");
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
					proposer = info[Constant.KIX_PROPOSER];

					if (debug){
						logger.info("degree: " + degree);
						logger.info("division: " + division);
						logger.info("title: " + title);
						logger.info("description: " + description);
						logger.info("effectiveDate: " + effectiveDate);
						logger.info("year: " + year);
						logger.info("kix: " + kix);
						logger.info("type: " + type);
						logger.info("raw: " + raw);
						logger.info("proposer: " + proposer);
					}

					// save data from form so we can update
					String[] data = new String[items];

					int i = 0;
					int j = 0;

					String sql = "";

					String edit1 = ProgramsDB.getProgramEdit1(conn,campus,kix);
					String[] edits = null;
					boolean enabledItems = false;
					boolean saveData = false;

					// are there enabled items?
					if (edit1.indexOf(",") > -1){
						edits = edit1.split(",");
						enabledItems = true;
					}

					for (i=0; i<items; i++){

						saveData = true;

						// when raw edit is turned on, override and allow to pass on
						if (raw.equals(Constant.ON)){
							saveData = true;
						}
						else if (enabledItems && edits[i].equals(Constant.OFF)){
							saveData = false;
						}

						if (saveData){

							column = (String)columns.get(i);

							if (debug) logger.info("ProgramServlet - saveData for item " + column);

							data[j] = website.getRequestParameter(request,"aseEditor"+i,"");

							if (j == 0){
								sql = column + "=?";
							}
							else{
								sql = sql + "," + column + "=?";
							}

							++j;

						} // if

					} // for

					try{
						i = 0;

						sql = "UPDATE tblPrograms "
									+ "SET " + sql + ","
									+ "auditby=?,auditdate=?,"
									+ "degreeid=?,divisionid=?,effectivedate=?,title=?,descr=?,proposer=?,regents=? "
									+ "WHERE campus=? "
									+ "AND historyid=? "
									+ "AND type=?";

						PreparedStatement ps = conn.prepareStatement(sql);
						for (i=0; i<j; i++){
							ps.setString(i+1,data[i]);
						}
						ps.setString(++i,user);
						ps.setString(++i,AseUtil.getCurrentDateTimeString());
						ps.setInt(++i,degree);
						ps.setInt(++i,division);
						ps.setString(++i,effectiveDate + " " + year);
						ps.setString(++i,title);
						ps.setString(++i,description);
						ps.setString(++i,proposer);
						ps.setBoolean(++i,regentApproval);
						ps.setString(++i,campus);
						ps.setString(++i,kix);
						ps.setString(++i,type);
						rowsAffected = ps.executeUpdate();

						if (rowsAffected > 0)
							message = "Program data updated successfully";
						else
							message = "Unable to update program data";

						ps.close();
						data = null;
						columns = null;

						Tables.createPrograms(campus,kix,""+degree,""+division);

					}
					catch(SQLException e){
						logger.fatal("ProgramServlet - updateProgram - " + e.toString());
					}
					catch(Exception e){
						logger.fatal("ProgramServlet - updateProgram - " + e.toString());
					}

				} // columns != null
			} // if items > 0

			session.setAttribute("aseApplicationMessage", message);

			// if doSomething made it through, logging would include all
			// we needed to know. However, if an error occur, this logging
			// tells us what we should know about the error.
			if (failure){
				// force end
				logger.info("ProgramServlet: START");
				logger.info("ProgramServlet: " + message);
				logger.info("ProgramServlet: END");
			}

			if (debug) logger.info("ProgramServlet - UPDATEPROGRAM - END");

		}
		catch(SQLException e){
			logger.fatal("ProgramServlet.updateProgram ("+kix+"): " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramServlet.updateProgram ("+kix+"): " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"ProgramServlet",user);
		}

		return kix;
	} // updateProgram


}