/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseRename.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseRename {
	static Logger logger = Logger.getLogger(CourseRename.class.getName());

	public CourseRename(){}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	/*
	 * renameOutline
	 *	<p>
	 * @return Msg
	 */
	public static Msg renameOutline(Connection conn,
											String campus,
											String fromAlpha,
											String fromNum,
											String toAlpha,
											String toNum,
											String user,
											String type) throws SQLException {

		return renameOutline(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type,"");

	}

	public static Msg renameOutline(Connection conn,
											String campus,
											String fromAlpha,
											String fromNum,
											String toAlpha,
											String toNum,
											String user,
											String type,
											String justification) throws SQLException {

		int rowsAffected = 0;

		Msg msg = new Msg();
		try{
			msg = CourseDB.isCourseRenamable(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type);

			if ("".equals(msg.getMsg())){

				//
				// we always rename from PRE
				//
				String kix = Helper.getKix(conn,campus,fromAlpha,fromNum,"PRE");
				if (kix == null || kix.length() == 0){
					kix = Helper.getKix(conn,campus,fromAlpha,fromNum,"CUR");
				}

				msg = renameOutlineX(campus,fromAlpha,fromNum,toAlpha,toNum,user,kix,type,justification);

				if ((Constant.BLANK).equals(msg.getMsg())){

					String action = "Outline renamed/renumbered (from: "
											+ fromAlpha + " "
											+ fromNum + " to: "
											+ toAlpha + " "
											+ toNum + ")";

					//
					// adding a note to indicate what is renamed/renumbered to (DF00111 - Manoa)
					//
					rowsAffected = MiscDB.insertMisc(conn,
																campus,
																kix,
																fromAlpha,
																fromNum,
																type,
																"emailNotifiedWhenRename",
																action,
																user);

					AseUtil.logAction(conn, user, "ACTION",action,fromAlpha,fromNum,campus,kix);

					// notification
					DistributionDB.notifyDistribution(conn,
																campus,
																fromAlpha,
																fromNum,
																type,
																user,
																Constant.BLANK,
																Constant.BLANK,
																"emailNotifiedWhenRename",
																"NotifiedWhenRename",
																user);
				}
			}
			else{
				logger.info("CourseRename: renameOutline - not permitted at this time - " + msg.getMsg());
			}

		}	// try
		catch(SQLException se){
			logger.fatal("CourseRename: renameOutline - " + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal("CourseRename: renameOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * renameOutlineX
	 *	<p>
	 *	@param	campus			String
	 *	@param	fromAlpha		String
	 *	@param	fromNum			String
	 *	@param	toAlpha			String
	 *	@param	toNum				String
	 *	@param	user				String
	 *	@param	kix				String
	 *	@param	type				String
	 *	@param	justification	String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg renameOutlineX(String campus,
												String fromAlpha,
												String fromNum,
												String toAlpha,
												String toNum,
												String user,
												String kix,
												String type,
												String justification) throws SQLException, Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int i = 0;
		int rowsAffected = 0;

		boolean debug = false;

		String sql = "";
		String table = "";
		String alpha = "";
		String num = "";

		Connection conn = null;

		try{
			if(debug) logger.info("--------------------- START");

			conn = AsePool.createLongConnection();

			if (conn != null){

				debug = DebugDB.getDebug(conn,"CourseRename");

				if(debug) {
					logger.info("Outline renamed by " + user);
					logger.info("kix: " + kix);
					logger.info("type: " + type);
					logger.info("fromAlpha: " + fromAlpha);
					logger.info("fromNum: " + fromNum);
					logger.info("toAlpha: " + toAlpha);
					logger.info("toNum: " + toNum);
					logger.info("justification: " + justification);
					logger.info("");
				}

				// clear out data before start
				// this is just writing out sql for research
				if(debug){
					TestDB.deleteTest(conn,"CourseRename",kix);
				}

				sql = "SELECT so.name AS tbl, sc.name AS col FROM syscolumns sc, sysobjects so  "
					+ "WHERE so.id = sc.id  "
					+ "AND so.name LIKE 'tbl%' AND so.name NOT LIKE 'tblTemp%' "
					+ "AND sc.name like '%alpha%'	ORDER BY so.name, sc.name";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					table = AseUtil.nullToBlank(rs.getString("tbl"));
					alpha = AseUtil.nullToBlank(rs.getString("col")).toLowerCase();

					if (alpha.equals("coursealpha") || alpha.equals("alpha")){

						++i;

						//
						// coursealpha has coursenum
						// alpha has num
						//
						if (alpha.equals("coursealpha")){
							num = "coursenum";
						}
						else{
							num = "num";
						}

						//
						//	not all tables with alpha will have num. we
						//	catch the exception here and let the program continue on
						//
						try{
							sql = "UPDATE " + table + " SET " + alpha + "=?," + num + "=?"
								+ " WHERE campus=? AND " + alpha + "=? AND " + num + "=? AND coursetype=? ";
							ps = conn.prepareStatement(sql);
							ps.setString(1,toAlpha);
							ps.setString(2,toNum);
							ps.setString(3,campus);
							ps.setString(4,fromAlpha);
							ps.setString(5,fromNum);
							ps.setString(6,type);
							rowsAffected = ps.executeUpdate();

							if(debug){

								TestDB.insertTest(conn,campus,kix,"CourseRename",sql);

								if (rowsAffected >= 0){
									logger.info(i + ": " + table + " (" + rowsAffected + " rows)");
								}
								else{
									logger.info(i + ": " + table + " (NO DATA)");
								}
							}

						}
						catch(SQLException e){
							// data structure does not contain same set of keys and is OK
							// use kis as part of update key
							logger.info(i + ": " + table + " (No ANT)");

							try{
								sql = "UPDATE " + table + " SET " + alpha + "=?," + num + "=? WHERE campus=? AND historyid=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1,toAlpha);
								ps.setString(2,toNum);
								ps.setString(3,campus);
								ps.setString(4,kix);
								rowsAffected = ps.executeUpdate();

								if(debug){

									TestDB.insertTest(conn,campus,kix,"CourseRename",sql);

									if (rowsAffected >= 0){
										logger.info(i + ": " + table + " (" + rowsAffected + " rows)");
									}
									else{
										logger.info(i + ": " + table + " (NO DATA)");
									}
								}

							}
							catch(SQLException ex){
								// data structure does not contain same set of keys and is OK
								// use kis as part of update key
								logger.info(i + ": " + table + " (No KIX)");
							}
							catch(Exception ex){
								// data structure does not contain same set of keys and is OK
								// use kis as part of update key
								logger.info(i + ": " + table + " (No KIX)");
							}

						}
						catch(Exception e){
							// data structure does not contain same set of keys and is OK
							if(debug) logger.info("CourseRename: renameOutlineX - " + e.toString());
						}

					} // valid column name

					++rowsAffected;
				}
				rs.close();
				ps.close();

				// add the new
				CampusDB.updateCampusOutline(conn,kix,campus);

				// remove the old
				CampusDB.removeCampusOutline(conn,campus,fromAlpha,fromNum,type);

				// for html print processing
				Html.updateHtml(conn,Constant.COURSE,kix);

				if(debug) logger.info(kix + " - CourseRename - HTML entry created");


			} // conn != null;

			if(debug) logger.info("--------------------- END");

		} catch (SQLException e) {
			logger.fatal("CourseRename: renameOutlineX - " + e.toString() + "\n" + sql);
			msg.setMsg("Exception");
		} catch (Exception e) {
			logger.fatal("CourseRename: renameOutlineX - " + e.toString() + "\n" + sql);
			msg.setMsg("Exception");
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("CourseRename: renameOutlineX - " + e.toString());
			}
		}

		return msg;
	}

	public void close() throws SQLException {}

}