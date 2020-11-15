/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 *	public static String getOutlineTerm(Connection conn, String kix)
 *	public static Terms getTerms(Connection connection, String term)
 *	public static String getTermDescription(Connection connection, String term)
 *
 * @author ttgiang
 */

//
// TermsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class TermsDB {
	static Logger logger = Logger.getLogger(TermsDB.class.getName());

	public TermsDB() throws Exception {}

	/*
	 * getTerms <p> @return Terms
	 */
	public static Terms getTerms(Connection connection, String term) {
		Terms terms = new Terms();
		try {
			String sql = "SELECT * FROM BannerTerms WHERE TERM_CODE=?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, term);
			ResultSet rs = preparedStatement.executeQuery();
			if (rs.next()) {
				terms.setTERM_CODE(rs.getString(1).trim());
				terms.setTERM_DESCRIPTION(rs.getString(2).trim());
			}

			rs.close();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("TermsDB: getTerms\n" + e.toString());
			return null;
		}

		return terms;
	}

	/*
	 * getTermDescription
	 * <p>
	 *	@return String
	 */
	public static String getTermDescription(Connection connection, String term) {
		String terms = "";

		try {
			if (term != null && term.length() > 0) {
				String sql = "SELECT TERM_DESCRIPTION FROM BannerTerms WHERE TERM_CODE=?";
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, term);
				ResultSet rs = preparedStatement.executeQuery();
				if (rs.next()) {
					terms = rs.getString(1);
				}

				rs.close();
				preparedStatement.close();
			}
		} catch (SQLException e) {
			logger.fatal("TermsDB: getTermDescription\n" + e.toString());
			terms = null;
		}

		return terms;
	}

	/*
	 * getOutlineTerm
	 * <p>
	 *	@return String
	 */
	public static String getOutlineTerm(Connection conn, String kix) {

		String term = "";

		try {
			if (kix != null && kix.length() > 0) {
				String sql = "SELECT effectiveterm FROM tblCourse WHERE id=?";
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, kix);
				ResultSet rs = preparedStatement.executeQuery();
				if (rs.next()) {
					term = rs.getString(1);
				}

				rs.close();
				preparedStatement.close();
			}
		} catch (SQLException e) {
			logger.fatal("TermsDB: getOutlineTerm\n" + e.toString());
		}

		return term;
	}

	public void close() throws SQLException {}

}