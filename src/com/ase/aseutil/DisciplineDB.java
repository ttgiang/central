/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *	public static ArrayList getDisciplines(Connection connection) {
 *	public static Discipline getDiscipline(Connection connection, String id)
 * public static String getDisciplineFromAlpha(Connection conn,String campus,String alpha)
 *
 * @author ttgiang
 */

//
// DisciplineDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class DisciplineDB {
	static Logger logger = Logger.getLogger(DisciplineDB.class.getName());

	public DisciplineDB() throws Exception {}

	/*
	 * getDiscipline
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				String
	 *	<p>
	 *	@return Discipline
	 */
	public static Discipline getDiscipline(Connection connection, String id) {

		String sql = "SELECT * from BannerAlpha WHERE dispid=?";
		Discipline discipline = new Discipline();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				discipline.setCourseAlpha(resultSet.getString(1).trim());
				discipline.setDiscipline(resultSet.getString(2).trim());
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DisciplineDB: getDiscipline - " + e.toString());
			discipline = null;
		}

		return discipline;
	}

	/*
	 * getDisciplineFromAlpha - returns the discipline name
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	<p>
	 *	@return 	String
	 */
	public static String getDisciplineFromAlpha(Connection conn,String campus,String alpha) {

		String disc = "";
		String sql = "SELECT ALPHA_DESCRIPTION from BannerAlpha WHERE COURSE_ALPHA=?";

		// we want to rely on banner for most data but in the past, campuses have created
		// their own so when necessary, go back to the campus for data
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, alpha);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				disc = AseUtil.nullToBlank(resultSet.getString(1));
			}
			else{
				resultSet.close();
				sql = "SELECT discipline from tblDiscipline WHERE campus=? AND coursealpha=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				resultSet = ps.executeQuery();
				if (resultSet.next()) {
					disc = AseUtil.nullToBlank(resultSet.getString(1));
				}
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DisciplineDB: getDisciplineFromAlpha - " + e.toString());
		}

		return disc;
	}

	/*
	 * getDisciplines
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getDisciplines(Connection connection) {
		String sql = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION FROM BannerAlpha ORDER BY ALPHA_DESCRIPTION";
		ArrayList<Discipline> list = new ArrayList<Discipline>();
		try {
			Discipline discipline;
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				discipline = new Discipline();
				discipline.setCourseAlpha(resultSet.getString(1).trim());
				discipline.setDiscipline(resultSet.getString(2).trim());
				list.add(discipline);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DisciplineDB: getDisciplines - " + e.toString());
			list = null;
		}

		return list;
	}
	public void close() throws SQLException {}

}