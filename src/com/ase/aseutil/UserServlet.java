/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.validation.Validator;

public class UserServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	final int cancelAction = 1;
	final int deleteAction = 2;
	final int insertAction = 3;
	final int updateAction = 4;

	private AsePool connectionPool;
	static Logger logger = Logger.getLogger(UserServlet.class.getName());
	Connection connection;
	int iAction = 0;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";
		String id;
		String idx = "";			// index of user maintenance screen (A - Z)
		String userid;
		String campus;
		String temp = "";
		String usr = "";
		StringBuffer errorLog = new StringBuffer();

		/*
			chk tracks whether user completed some task that is required at log in.
			set in the system settings under check, this value is 1 when we want
			program flow to go off the normal path.

			once the user completes what is asked, the check flag in his profile
			is set to 1 so that we are not asking to do it again.
		*/
		String chk = "";

		int rowsAffected = 0;
		int i;

		connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			errorLog.append("");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			if (sAction.equalsIgnoreCase("Cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("Delete")) iAction = deleteAction;
			if (sAction.equalsIgnoreCase("Insert")) iAction = insertAction;
			if (sAction.equalsIgnoreCase("Save")) iAction = updateAction;

			idx = website.getRequestParameter(request,"idx");
			id = website.getRequestParameter(request,"lid");
			chk = website.getRequestParameter(request,"chk");

			User user = new User();
			user.setUserid(website.getRequestParameter(request, "userid"));
			userid = website.getRequestParameter(request, "userid");

			int uhSystem = website.getRequestParameter(request,"uh_0",1);
			if (uhSystem==1){
				//user.setPassword("c0mp1ex");
				user.setPassword("1nn0v@te");
			}
			else{
				user.setPassword(website.getRequestParameter(request,"pw"));
			}

			user.setUH(uhSystem);
			user.setFullname(website.getRequestParameter(request,"fullname"));
			user.setStatus(website.getRequestParameter(request,"status_0", "Active"));
			user.setDivision(website.getRequestParameter(request,"division"));
			user.setDepartment(website.getRequestParameter(request,"department"));

			// get the string, sort it
			temp = website.getRequestParameter(request,"alphas");
			temp = Util.stringToArrayToString(temp.toUpperCase(),",",false);
			user.setAlphas(temp);

			user.setEmail(website.getRequestParameter(request,"email"));
			user.setTitle(website.getRequestParameter(request,"title"));
			user.setSalutation(website.getRequestParameter(request,"salutation"));
			user.setLocation(website.getRequestParameter(request,"location"));
			user.setHours(website.getRequestParameter(request,"hours"));
			user.setPhone(website.getRequestParameter(request,"phone"));
			campus = website.getRequestParameter(request,"campus");
			user.setCampus(campus);
			usr = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			user.setAuditBy(usr);
			user.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			user.setUserLevel(Integer.parseInt(website.getRequestParameter(request,"userlevel")));
			user.setLastname(website.getRequestParameter(request,"last"));
			user.setFirstname(website.getRequestParameter(request,"first"));
			user.setPosition(website.getRequestParameter(request,"position"));
			user.setWebsite(website.getRequestParameter(request,"website"));
			user.setWeburl(website.getRequestParameter(request,"weburl"));
			user.setCollege(website.getRequestParameter(request,"college"));

			// not using validation routine at this time. @ in email is causing problem with
			// cleaning function
			//if (iAction==insertAction || iAction==updateAction){
			//	errorLog = validateData(request);
			//}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					message = UserDB.deleteUser(connection,campus,userid);
					break;
				case insertAction:
					if (!UserDB.isMatch(connection, userid, campus)) {
						rowsAffected = UserDB.insertUser(connection, user);

						if (rowsAffected == 1)
							message = "User <b>" + userid + "</b> inserted successfully";
						else
							message = "Unable to insert <b>" + userid + "</b>";

					} else {
						rowsAffected = -1;
						message = "User <b>" + userid + "</b> already exists in Curriculum Central";
					}

					break;
				case updateAction:
					rowsAffected = UserDB.updateUser(connection,user,request,response);

					if (rowsAffected == 1)
						message = "User <b>" + userid + "</b> updated successfully";
					else
						message = "Unable to update user <b>" + userid + "</b>";

					break;
			}	// switch

			session.setAttribute("aseApplicationMessage", message);

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"UserServlet",usr);
		}

		String url = "index";

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			//
			//	when checking is turned on, we are asking for update to user profile.
			//	when done, send back to index page.
			//
			if (chk.equals(Constant.ON)){
				try{
					UserDB.updateCheck(connection,campus,userid,chk);
				}
				catch(SQLException se){
					logger.fatal("UserServlet.updateCheck: " + se.toString());
				} catch (Exception e) {
					logger.fatal("UserServlet.updateCheck: " + e.toString());
				}
				url = "index";
			}
			else{
				url = "usridx&idx="+idx;
			}

			url = response.encodeURL("/core/msg.jsp?rtn=" + url);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/*
	*
	*/
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}

	/*
	*
	*/
	public StringBuffer validateData(HttpServletRequest request){

		WebSite website = new WebSite();
		StringBuffer buf = new StringBuffer();
		String thisData = "";
		String oldData = "";

		String[] cols = {
			"userid",
			"pw",
			"uh_0",
			"fullname",
			"status_0",		//4
			"division",
			"department",
			"email",
			"title",
			"salutation",	//9
			"location",
			"hours",
			"phone",
			"campus",
			"userlevel",	//14
			"first",
			"last",
			"position"};

		/*
			look through all input fields and clean SQL.
			If the cleaned value <> the oldData value, that means
			some cleaning took place. Cleaning happens only if there are possible
			bad characters.
		*/

		String user = website.getRequestParameter(request,cols[0]);
		String campus = website.getRequestParameter(request,cols[13]);

		for(int i=0;i<cols.length;i++){
			thisData = website.getRequestParameter(request,cols[i]);
			oldData = thisData;
			thisData = website.cleanSQLX(thisData);
			if (!thisData.equals(oldData)){
				buf.append("Error found in " + cols[i] +"<br>");
			}
		}

		try {
			String xmlSchemas = AseUtil.getXMLSchemas();
			File schemaFile = new File(xmlSchemas + "users.xsd");
			Validator validator = Validator.getInstance(schemaFile.toURL());

			if (iAction==insertAction){
				if (UserDB.isMatch(connection,user,campus))
					buf.append("User <b>" + user + "</b> already exists in the system");
			}

			if (!validator.isValid("userLevel", website.getRequestParameter(request,cols[14]))){
				buf.append("userLevel is invalid: "+website.getRequestParameter(request,cols[14]));
			}

		} catch (Exception e) {
			logger.fatal("UserServlet: validateData\n" + e.toString());
		}

		return buf;
	}
}