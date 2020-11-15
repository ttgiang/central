/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteGESLO(Connection conn,int id) {
 *	public static String getGESLO(Connection conn,String campus,String kix,boolean lock)
 *	public static ArrayList getGESLOByCampus(Connection conn,String campus) {
 *	public static ArrayList getGESLOAndDescByCampus(Connection conn,String campus,String kix) {
 * public static String getGESLOForOutline(Connection conn,String campus,String kix) {
 * public static boolean gesloExists(Connection connection,String campus,String kix,int geid)
 *	public static int insertGESLO(Connection conn, Props prop)
 * public static Msg processGESLO(Connection conn,HttpServletRequest request,String kix)
 *	public static int updateGESLO(Connection conn, Props prop)
 *
 * @author ttgiang
 */

//
// GESLODB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class GESLODB {

	static Logger logger = Logger.getLogger(GESLODB.class.getName());

	public GESLODB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	geid			int
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatch(Connection connection,String kix,int geid) throws SQLException {
		String sql = "SELECT historyid FROM tblGESLO WHERE historyid=? AND geid=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setInt(2,geid);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * updateGESLO
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	geslo	GESLO
	 * <p>
	 * @return	Msg
	 */
	public static Msg updateGESLO(Connection conn,String kix,GESLO geslo) {

		String sql = "UPDATE tblGESLO SET campus=?,geid=?,slolevel=?,sloevals=?,auditby=?,auditdate=? WHERE historyid=?";
		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps = null;

		try {
			AseUtil aseUtil = new AseUtil();
			if (isMatch(conn,kix,geslo.getGeid())){
				sql = "UPDATE tblGESLO SET slolevel=?,sloevals=?,auditby=?,auditdate=? "
					+ "WHERE historyid=? AND geid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,geslo.getSloLevel());
				ps.setString(2,geslo.getSloEvals());
				ps.setString(3,geslo.getAuditBy());
				ps.setString(4,aseUtil.getCurrentDateTimeString());
				ps.setString(5,kix);
				ps.setInt(6,geslo.getGeid());
			}
			else{
				sql = "INSERT INTO tblGESLO (campus,historyid,geid,slolevel,sloevals,auditby) VALUES(?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,geslo.getCampus());
				ps.setString(2,geslo.getHistoryID());
				ps.setInt(3,geslo.getGeid());
				ps.setInt(4,geslo.getSloLevel());
				ps.setString(5,geslo.getSloEvals());
				ps.setString(6,geslo.getAuditBy());
			}
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GESLODB: updateGESLO - " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("GESLODB: updateGESLO - " + ex.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	geid			int
	 * <p>
	 * @return	boolean
	 */
	public static boolean gesloExists(Connection connection,String campus,String kix,int geid) {

		String sql = "SELECT historyid "
			+ "FROM tblGESLO "
			+ "WHERE campus=? AND "
			+ "historyid=? AND "
			+ "geid=?";

		boolean exists = false;

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,geid);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("GESLODB: gesloExists - " + e.toString());
		}

		return exists;
	}

	/**
	 * getGESLO
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	geid	int
	 * <p>
	 * @return	GESLO
	 */
	public static GESLO getGESLO(Connection conn,String kix,int geid) {

		//Logger logger = Logger.getLogger("test");

		GESLO geslo = new GESLO();

		String sql = "SELECT * FROM tblGESLO WHERE historyid=? AND geid=?";

		try {
			AseUtil aseUtil = new AseUtil();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,geid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				geslo.setGeid(geid);
				geslo.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				geslo.setSloLevel(rs.getInt("slolevel"));
				geslo.setSloEvals(rs.getString("sloevals"));
				geslo.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				geslo.setCourseType(AseUtil.nullToBlank(rs.getString("coursetype")));
				geslo.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
			}
			else{
				geslo = null;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("GESLODB: getGESLO_0- " + e.toString());
			geslo = null;
		}
		catch(Exception ex){
			logger.fatal("GESLODB: getGESLO_0 - " + ex.toString());
			geslo = null;
		}

		return geslo;
	}

	/**
	 * getGESLO
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	geid			int
	 * <p>
	 * @return	GESLO
	 */
	public static GESLO getGESLO(Connection connection,String campus,String kix,int geid) {

		GESLO geslo = new GESLO();

		String sql = "SELECT * FROM tblGESLO WHERE campus=? AND historyid=? AND geid=?";

		try {
			AseUtil aseUtil = new AseUtil();
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,geid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				geslo.setGeid(geid);
				geslo.setSloLevel(rs.getInt("slolevel"));
				geslo.setSloEvals(rs.getString("sloevals"));
				geslo.setAuditBy(rs.getString("auditby"));
				geslo.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
			}
			else{
				geslo = null;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("GESLODB: getGESLO_1 - " + e.toString());
			geslo = null;
		}
		catch(Exception ex){
			logger.fatal("GESLODB: getGESLO_1 - " + ex.toString());
			geslo = null;
		}

		return geslo;
	}

	/*
	 * getGESLO
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	lock		boolean
	 *	<p>
	 *	@return String
	 */
	public static String getGESLO(Connection conn,String campus,String kix,boolean lock) {

		//Logger logger = Logger.getLogger("test");

		int id = 0;
		String sid = "";
		String kid = "";
		String kdesc = "";
		String kval1 = "";
		String kval2 = "";
		String kval3 = "";
		String slo = "";
		String sql = "";

		StringBuffer buf = new StringBuffer();

		int totalTopics = 20;
		String[] topic = new String[totalTopics];
		String[] color = new String[totalTopics];
		color[0] = "#e0e0e0";
		color[1] = "#ffffff";
		color[2] = "cyan";
		color[3] = "lightgreen";
		color[4] = "#ffffA8";
		color[5] = "#b0d8ff";
		color[6] = "#b5fbbf";
		color[7] = "#f4ffdd";
		color[8] = "#ffffff";
		color[9] = "#e0e0e0";
		color[10] = "#e0e0e0";
		color[11] = "#ffffff";
		color[12] = "cyan";
		color[13] = "lightgreen";
		color[14] = "#ffffA8";
		color[15] = "#b0d8ff";
		color[16] = "#b5fbbf";
		color[17] = "#f4ffdd";
		color[18] = "#ffffff";
		color[19] = "#e0e0e0";

		String temp = "";

		boolean found = false;

		int cellWidth = 0;
		int tableWidth = 90;

		int i=0;		// row of table
		int j=0;		// col of table

		GESLO geslo;

		int countOfEvals = 0;
		String[] evals = new String[totalTopics];

		boolean defaultGrid = true;

		// UHMC uses the default grid
		int checks = 4;

		// HON has a different format
		if(campus.equals(Constant.CAMPUS_HON)){
			checks = 3;
			defaultGrid = false;
		}

		int checkCounter = 0;
		String[] inputField = new String[checks];
		String[] checked = new String[checks];
		String[] levels = new String[checks];

		// For GESLO, HON has 2 checked items (AA & UHM)
		// database design is integer meant to hold a single value of 1 or 0
		// to accommodate HON without touching database, we'll use binary
		// math to save data
		//
		// AA can be 1 or 0
		// UHM can be 1 or 0
		//
		// using binary, we'll do this
		//
		// 00 - nothing selected (0)
		// 01 - AA selected (1)
		// 10 - UHM selected (2)
		// 11 - both selected (3)
		//

		try {
			AseUtil aseUtil = new AseUtil();

			String server = SysDB.getSys(conn,"server");

			countOfEvals = IniDB.mumberOfItems(conn,campus,"MethodEval");

			if(defaultGrid){
				levels[0] = "";
				levels[1] = "Preparatory Level";
				levels[2] = "Level 1";
				levels[3] = "Level 2";
			}
			else{
				levels[0] = "";
				levels[1] = "A.A.";
				levels[2] = "UHM";
			}

			i = 0;
			sql = "SELECT id, kid, kdesc, kval1, kval2, kval3 FROM tblINI WHERE campus=? AND category='GESLO' ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				kid = AseUtil.nullToBlank(rs.getString("kid"));
				kdesc = AseUtil.nullToBlank(rs.getString("kdesc"));
				kval1 = AseUtil.nullToBlank(rs.getString("kval1"));
				kval2 = AseUtil.nullToBlank(rs.getString("kval2"));
				kval3 = AseUtil.nullToBlank(rs.getString("kval3"));

				// clear with each while loop
				topic[i] = kid;

				for(checkCounter=0;checkCounter<checks;checkCounter++){
					checked[checkCounter] = "&nbsp;";
					inputField[checkCounter] = "&nbsp;";
				}

				geslo = GESLODB.getGESLO(conn,campus,kix,id);
				if (geslo!=null){
					evals[i] = "," + geslo.getSloEvals() + ",";

					if (geslo.getGeid() > 0){
						checked[0] = "checked";
					}

					// what to check on screen
					if(defaultGrid){
						switch(geslo.getSloLevel()){
							case 0 : checked[1] = "checked"; break;
							case 1 : checked[2] = "checked"; break;
							case 2 : checked[3] = "checked"; break;
						}
					}
					else{

						switch(geslo.getSloLevel()){
							case 1 : checked[1] = "checked"; break;
							case 2 : checked[2] = "checked"; break;
							case 3 : checked[1] = "checked"; checked[2] = "checked"; break;
						}

					}
				} // valid geslo

				if (lock){
					for(checkCounter=0;checkCounter<checks;checkCounter++){
						if ("checked".equals(checked[checkCounter])){

							if(!defaultGrid && checkCounter == 0){
								inputField[checkCounter] = "";
							}
							else{
								inputField[checkCounter] = "<img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" title=\"selected\" />" + levels[checkCounter];
							}

						} // if checked
					} // for i
				}
				else{
					if(defaultGrid){
						inputField[0] = "<input " + checked[0] + " type=\"checkbox\" value=\""+id+"\" name=\"slo_"+i+"\" class=\"input\">";
						inputField[1] = "<input " + checked[1] + " type=\"radio\" value=\"0\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[1] + "&nbsp;&nbsp;&nbsp;";
						inputField[2] = "<input " + checked[2] + " type=\"radio\" value=\"1\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[2] + "&nbsp;&nbsp;&nbsp;";
						inputField[3] = "<input " + checked[3] + " type=\"radio\" value=\"2\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[3] + "&nbsp;&nbsp;&nbsp;";
					}
					else{
						// we hide the check box so the slo_ value comes over when saving form data
						inputField[0] = "<input type=\"hidden\" value=\""+id+"\" name=\"slo_"+i+"\" class=\"input\">";
						inputField[1] = "<input " + checked[1] + " type=\"checkbox\" value=\"1\" name=\"level_AA_"+id+"\" class=\"input\">" + "&nbsp;" + levels[1] + "&nbsp;&nbsp;&nbsp;";
						inputField[2] = "<input " + checked[2] + " type=\"checkbox\" value=\"1\" name=\"level_UHM_"+id+"\" class=\"input\">" + "&nbsp;" + levels[2] + "&nbsp;&nbsp;&nbsp;";
					}
				} // lock

				if(defaultGrid){
					buf.append("<tr bgcolor=\""+ color[i] +"\"><td valign=\"top\">" + inputField[0] + "</td>")
						.append("<td valign=\"top\" class=\"datacolumn\"><b>" + kid + "</b> - ")
						.append(kdesc)
						.append("<br/><br/>")
						.append(inputField[1])
						.append(inputField[2])
						.append(inputField[3])
						.append("</td></tr>");
				}
				else{
					buf.append("<tr bgcolor=\""+ color[i] +"\"><td valign=\"top\">" + inputField[0] + "</td>")
						.append("<td valign=\"top\" class=\"datacolumn\"><b>" + kval1 + " - " + kval2 + "</b> - ")
						.append(kval3)
						.append("<br/><br/>")
						.append(inputField[1])
						.append(inputField[2])
						.append("</td></tr>");
				} // lock

				++i;

				found = true;

			} // while
			rs.close();
			ps.close();

			// actual topics
			totalTopics = i;

			if (found){

				// put together table of geslo
				slo = "<p align=\"center\"><table width=\"90%\" border=\"1\" cellpadding=\"5\" cellspacing=\"0\">"
					+ buf.toString()
					+ "</table></p>";

				// determines whether to show method evaluations for linking to GESLO
				String showGELSOLinkToEvals = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowGELSOLinkToEvals");
				if(showGELSOLinkToEvals.equals(Constant.ON)){

					buf.setLength(0);
					found = false;

					// if method of evaluation has been selected, limit this list to only what was selected;
					// otherwise, show the entire list.

					sql = "historyid=" + aseUtil.toSQL(kix, 1);

					String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

					methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

					if (methodEvaluation != null && methodEvaluation.length() > 0){

						// method eval is tried to GESLO by ~~ where the left is
						// method eval id and right is geslo.
						// at start of course create, left will have value during
						// method eval checking and saving. however, to save
						// correctly, we append 0 to the end so the separation
						// is correct. we replace the value here to allow for
						// proper sql
						methodEvaluation = methodEvaluation.replace("~~0","");

						if (methodEvaluation.startsWith(",")){
							methodEvaluation = methodEvaluation.substring(1);
						}

						//
						//	sid is string representation of id with commas on each end. the commas were added
						//	to help in the use if indexOf to find the values within the CSV of values saved to DB.
						//
						// DF00045 - when method eval not selected, don't show table
						//

						i = 0;

						if(methodEvaluation == null || methodEvaluation.length() == 0){
							methodEvaluation = "0";
						} // avoid SQL IN exception

						sql = "SELECT id, kdesc FROM tblINI WHERE campus=? "
							+ "AND category='MethodEval' AND id IN ("+methodEvaluation+") ORDER BY kdesc";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						rs = ps.executeQuery();
						while (rs.next()) {
							id = rs.getInt("id");
							sid = ","+id+",";
							kdesc = rs.getString("kdesc");

							buf.append("<tr><td class=\"textblackth\">" + kdesc + "</td>");

							for(j=0;j<totalTopics;j++){

								checked[0] = "&nbsp;";
								if (evals[j] != null && evals[j].length() > 0 && (evals[j].indexOf(sid)>=0)){
									checked[0] = "checked";
								}

								if (lock)
									if (checked[0].equals("checked"))
										inputField[0] = "<img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" title=\"selected\" />";
									else
										inputField[0] = "&nbsp;";
								else
									inputField[0] = "<input type=\"checkbox\" " + checked[0] + " value=\"" + id + "\" name=\"item_"+i+""+j+"\" class=\"input\">";

								buf.append("<td bgcolor=\"" + color[j] + "\" valign=\"top\" class=\"datacolumn\">" + inputField[0] + "</td>");
							}

							buf.append("</tr>");

							++i;
							found = true;
						} // while
						rs.close();
						ps.close();

						if (found){
							cellWidth = (int)((tableWidth-25)/totalTopics);
							temp = "";
							for(j=0; j<totalTopics;j++){
								temp = temp + "<td bgcolor=\"" + color[j] + "\" valign=\"top\" class=\"textblackth\" width=\"" + cellWidth + "%\">" + topic[j] + "</td>";
							}

							slo = slo + "<p align=\"center\">"
								+ "<table width=\"" + tableWidth + "%\" border=\"1\" cellpadding=\"5\" cellspacing=\"0\">"
								+ "<tr><td width=\"25%\">&nbsp;</td>" + temp + "</tr>"
								+ buf.toString()
								+ "</table></p>";
						} // found

					} // has method of eval

				} // showGELSOLinkToEvals

			}	// found

		} catch (SQLException e) {
			logger.fatal("GESLODB: getGESLO_2 - " + e.toString() + "\n kix: " + kix);
		} catch (Exception e) {
			logger.fatal("GESLODB: getGESLO_2 - " + e.toString() + "\n kix: " + kix);
		}

		return slo;
	}

	/**
	 * deleteGESLO
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	geid	int
	 * <p>
	 * @return	int
	 */
	public static int deleteGESLO(Connection conn,String kix,int geid) {

		String sql = "DELETE FROM tblGESLO WHERE historyid=? AND geid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,geid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GESLODB: deleteGESLO - " + e.toString() + "; kix: " + kix);
		} catch (Exception e) {
			logger.fatal("GESLODB: deleteGESLO - " + e.toString() + "; kix: " + kix);
		}


		return rowsAffected;
	}

	/**
	 * processGESLO - process data from crsedt (modification screen)
	 * <p>
	 * @param	conn		Connection
	 * @param	request	HttpServletRequest
	 * @param	kix		String
	 * <p>
	 * @return	Msg
	 */
	public static Msg processGESLO(Connection conn,HttpServletRequest request,String kix) {

		HttpSession session = request.getSession(true);

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		Msg msg = new Msg();

		int row = 0;
		int col = 0;
		int geid = 0;
		int sloLevel = 0;
		String sloEvals = "";
		String checkBoxes = "";
		String selected = "";

		try {
			WebSite website = new WebSite();

			int countOfEvals = IniDB.mumberOfItems(conn,campus,"MethodEval");
			int countOfTopics = IniDB.mumberOfItems(conn,campus,"GESLO");

			String showGELSOLinkToEvals = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowGELSOLinkToEvals");

			for(col=0;col<countOfTopics;col++){
				geid = website.getRequestParameter(request,"slo_"+col,0);
				if (geid > 0) {

					if (selected.equals(""))
						selected = ""+geid;
					else
						selected = selected+","+geid;

					sloEvals = "";
					sloLevel = website.getRequestParameter(request,"level_"+geid,0);

					if(showGELSOLinkToEvals.equals(Constant.ON)){

						for(row=0;row<countOfEvals;row++){
							checkBoxes = website.getRequestParameter(request,"item_"+row+""+col);
							if (!checkBoxes.equals("")){
								if (sloEvals.equals(""))
									sloEvals = checkBoxes;
								else
									sloEvals = sloEvals + "," + checkBoxes;
							}
						}

					} // showGELSOLinkToEvals

					msg = GESLODB.updateGESLO(conn,kix,new GESLO(campus,kix,geid,sloLevel,sloEvals,user));
				} // geid

				geid = 0;
				sloLevel = 0;
				sloEvals = "";
			}

			// updates above affects all items include unselected entries. this code
			// removes items added before and now deselected
			if (!"".equals(selected)){
				String sql = "DELETE FROM tblGESLO WHERE historyid=? AND geid NOT IN (" + selected + ")";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				int rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("GESLODB: processGESLO - " + e.toString() + "; kix: " + kix);
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("GESLODB: processGESLO - " + ex.toString() + "; kix: " + kix);
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/**
	 * processGESLO_HON - process data from crsedt (modification screen)
	 * <p>
	 * @param	conn		Connection
	 * @param	request	HttpServletRequest
	 * @param	kix		String
	 * <p>
	 * @return	Msg
	 */
	public static Msg processGESLO_HON(Connection conn,HttpServletRequest request,String kix) {

		//Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		Msg msg = new Msg();

		int row = 0;
		int col = 0;
		int geid = 0;
		int sloLevel = 0;

		int AA = 0;
		int UHM = 0;

		String sloEvals = "";
		String checkBoxes = "";
		String selected = "";

		try {
			WebSite website = new WebSite();

			int countOfEvals = IniDB.mumberOfItems(conn,campus,"MethodEval");
			int countOfTopics = IniDB.mumberOfItems(conn,campus,"GESLO");

			String showGELSOLinkToEvals = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowGELSOLinkToEvals");

			// For GESLO, HON has 2 checked items (AA & UHM)
			// database design is integer meant to hold a single value of 1 or 0
			// to accommodate HON without touching database, we'll use binary
			// math to save data
			//
			// AA can be 1 or 0
			// UHM can be 1 or 0
			//
			// using binary, we'll do this
			//
			// 00 - nothing selected (0)
			// 01 - AA selected (1)
			// 10 - UHM selected (2)
			// 11 - both selected (3)
			//

			for(col=0;col<countOfTopics;col++){
				geid = website.getRequestParameter(request,"slo_"+col,0);
				if (geid > 0) {

					if (selected.equals(""))
						selected = ""+geid;
					else
						selected = selected+","+geid;

					sloEvals = "";
					AA = website.getRequestParameter(request,"level_AA_"+geid,0);
					UHM = website.getRequestParameter(request,"level_UHM_"+geid,0);

					// how to save data
					if(AA == 0 && UHM == 0){
						sloLevel = 0;
					}
					else if(AA == 1 && UHM == 0){
						sloLevel = 1;
					}
					else if(AA == 0 && UHM == 1){
						sloLevel = 2;
					}
					else if(AA == 1 && UHM == 1){
						sloLevel = 3;
					}

					if(showGELSOLinkToEvals.equals(Constant.ON)){

						for(row=0;row<countOfEvals;row++){
							checkBoxes = website.getRequestParameter(request,"item_"+row+""+col);
							if (!checkBoxes.equals("")){
								if (sloEvals.equals(""))
									sloEvals = checkBoxes;
								else
									sloEvals = sloEvals + "," + checkBoxes;
							}
						}

					} // showGELSOLinkToEvals

					msg = GESLODB.updateGESLO(conn,kix,new GESLO(campus,kix,geid,sloLevel,sloEvals,user));

				} // geid

				geid = 0;
				sloLevel = 0;
				sloEvals = "";
				AA = 0;
				UHM = 0;
			}

			// updates above affects all items include unselected entries. this code
			// removes items added before and now deselected
			if (!"".equals(selected)){
				String sql = "DELETE FROM tblGESLO WHERE historyid=? AND geid NOT IN (" + selected + ")";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				int rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("GESLODB: processGESLO_HON - " + e.toString() + "; kix: " + kix);
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("GESLODB: processGESLO_HON - " + ex.toString() + "; kix: " + kix);
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/*
	 * getGESLOForOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return String
	 */
	public static String getGESLOForOutline(Connection conn,String campus,String kix) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		boolean found = false;
		String temp = "";

		try {
			String sql = "";
			int geid = 0;
			int sloLevel = 0;
			String level = "";
			String sloEvals = "";
			Ini ini = null;
			String[] junk;
			int index = 0;

			/*
				retrieve all available method evals into an array for processing below.
				2 arrays are created. 1 holding the item ID, and the other holding
				the item description.
			*/
			int countOfEvals = IniDB.mumberOfItems(conn,campus,"MethodEval");
			String[] aID = new String[countOfEvals];
			String[] aKdesc = new String[countOfEvals];

			sql = "SELECT id,kdesc "
				+ "FROM tblINI "
				+ "WHERE campus=? AND "
				+ "category='MethodEval' "
				+ "ORDER BY kdesc";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			int i = 0;
			while (rs.next()){
				aID[i] = (String)("" + rs.getInt("id"));
				aKdesc[i] = rs.getString("kdesc");
				++i;
			}
			rs.close();
			ps.close();

			/*
				read all items selected from GESLO and print out as if was looking on screen.
				for each GESLO, search arrays created above for the key and then use the key
				to print the description.
			*/
			sql = "SELECT geid,slolevel,sloevals FROM tblGESLO WHERE campus=? AND historyid=? ORDER BY geid";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				geid = rs.getInt("geid");
				sloLevel = rs.getInt("slolevel");

				switch(sloLevel){
					case 0: level = "Preparatory"; break;
					case 1: level = "1"; break;
					case 2: level = "2"; break;
				}

				sloEvals = rs.getString("sloevals");

				ini = IniDB.getINI(conn,geid);
				if (ini!=null){
					buf.append("<strong>" + ini.getKid() + "&nbsp(Level: " + level + ")</strong> - "
						+ ini.getKdesc() + "<br/>");

					buf.append("<ul>");
					junk = sloEvals.split(",");
					for (i=0;i<junk.length;i++){
						index = Arrays.binarySearch(aID,junk[i]);
						buf.append("<li>" + aKdesc[index] + "</li>");
					}
					buf.append("</ul>");
				}

				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				temp = buf.toString();

		} catch (Exception e) {
			logger.fatal("GESLODB: getGESLOForOutline - " + e.toString() + "; kix: " + kix);
		}

		return temp;
	}

	/*
	 * getGESLOByCampus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getGESLOByCampus(Connection conn,String campus) {

		ArrayList<GESLO> list = new ArrayList<GESLO>();
		GESLO geslo;

		try {
			String sql = "SELECT id,kid FROM tblINI WHERE campus=? AND category='GESLO' ORDER BY seq";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				geslo = new GESLO();
				geslo.setID(rs.getInt(1));
				geslo.setSloEvals(rs.getString(2).trim());
				list.add(geslo);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GESLODB: getGESLOByCampus - " + e.toString());
			return null;
		}

		return list;
	}

	/*
	 * getGESLOAndDescByCampus - for readability during linking
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getGESLOAndDescByCampus(Connection conn,String campus,String kix) {

		ArrayList<GESLO> list = new ArrayList<GESLO>();
		GESLO geslo;

		try {
			String sql = "SELECT id,kid + ' - ' + kdesc "
				+ "FROM tblINI "
				+ "WHERE campus=? "
				+ "AND category='GESLO' "
				+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
				+ "ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				geslo = new GESLO();
				geslo.setID(rs.getInt(1));
				geslo.setSloEvals(rs.getString(2).trim());
				list.add(geslo);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GESLODB: getGESLOAndDescByCampus - " + e.toString());
			return null;
		}

		return list;
	}

	/**
	 * copyGESLO
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	alpha
	 * @param	num
	 * @param	user
	 * @param	thisID
	 * <p>
	 * @return	int
	 */
	public static int copyGESLO(Connection conn,
												String kixOld,
												String kixNew,
												String alpha,
												String num,
												String user,
												int thisID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int nextID = 0;

		boolean debug = false;

		String src = Constant.COURSE_GESLO;
		String campus = "";

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"GESLODB");

			if (debug) logger.info("GESLODB COPYGESLO - STARTS");

			String sql = "INSERT INTO tblGESLO (campus,historyid,geid,slolevel,sloevals,auditby,courseType) VALUES(?,?,?,?,?,?,?)";

			GESLO geslo = getGESLO(conn,kixOld,thisID);

			if (geslo != null){
				campus = geslo.getCampus();

				String[] info2 = Helper.getKixInfo(conn,kixNew);
				String toCampus = info2[Constant.KIX_CAMPUS];

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,toCampus);
				ps.setString(2,kixNew);
				ps.setInt(3,thisID);
				ps.setInt(4,geslo.getSloLevel());
				ps.setString(5,geslo.getSloEvals());
				ps.setString(6,user);
				ps.setString(7,type);
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug) logger.info(kixNew + " - geslo copied");
			}

			if (debug) logger.info("GESLODB COPYGESLO - ENDS");

		} catch (SQLException e) {
			logger.fatal("ContentDB: copyGESLO - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ContentDB: copyGESLO - " + ex.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}