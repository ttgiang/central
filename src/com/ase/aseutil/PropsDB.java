/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int deleteProp(Connection conn,int id) {
 *	public static Prop getProp(Connection conn,int id) {
 *	public static String getPropByID(Connection conn,int id) {
 *	public static int insertProp(Connection conn, Props prop)
 *	public static String processProp(Connection conn,String property,String kix,String user)
 *	public static int updateProp(Connection conn, Props prop) {
 *
 * @author ttgiang
 */

//
// PropsDB.java
//
package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class PropsDB {

	static Logger logger = Logger.getLogger(PropsDB.class.getName());

	public PropsDB() throws Exception {}

	/**
	 * insertProp
	 * <p>
	 * @param	conn	Connection
	 * @param	prop	Props
	 * <p>
	 * @return	int
	 */
	public static int insertProp(Connection conn, Props prop) {

		String sql = "INSERT INTO tblProps (campus,propname,propdescr,subject,content,cc,auditby) VALUES (?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,prop.getCampus());
			ps.setString(2,prop.getPropName());
			ps.setString(3,prop.getPropDescr());
			ps.setString(4,prop.getSubject());
			ps.setString(5,prop.getContent());
			ps.setString(6,prop.getCC());
			ps.setString(7,prop.getAuditBy());
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("PropsDB: insertProp - " + prop.getPropName() + " inserted by " + prop.getAuditBy());
		} catch (SQLException e) {
			logger.fatal("PropsDB: insertProp\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteProp
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteProp(Connection conn,int id) {

		String sql = "DELETE FROM tblProps WHERE id=?";
		int rowsAffected = 0;
		try {
			Props prop = PropsDB.getProp(conn, id);
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("PropsDB: deleteProp - " + prop.getPropName()+ " deleted by " + prop.getAuditBy());
		} catch (SQLException e) {
			logger.fatal("PropsDB: deleteProp\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateProp
	 * <p>
	 * @param	conn	Connection
	 * @param	prop	Props
	 * <p>
	 * @return	int
	 */
	public static int updateProp(Connection conn, Props prop) {

		String sql = "UPDATE tblProps SET propdescr=?,subject=?,content=?,cc=?,auditby=?,auditdate=? WHERE id =?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,prop.getPropDescr());
			ps.setString(2,prop.getSubject());
			ps.setString(3,prop.getContent());
			ps.setString(4,prop.getCC());
			ps.setString(5,prop.getAuditBy());
			ps.setString(6,AseUtil.getCurrentDateTimeString());
			ps.setInt(7,prop.getID());
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("PropsDB: updateProp - " + prop.getPropName() + " updated by " + prop.getAuditBy());
		} catch (SQLException e) {
			logger.fatal("PropsDB: updateProp\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getProp
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Prop
	 */
	public static Props getProp(Connection conn,int id) {

		String sql = "SELECT * FROM tblProps WHERE id=?";
		Props prop = new Props();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				prop.setPropName(aseUtil.nullToBlank(rs.getString("propname")));
				prop.setPropDescr(aseUtil.nullToBlank(rs.getString("propdescr")));
				prop.setSubject(aseUtil.nullToBlank(rs.getString("subject")));
				prop.setContent(aseUtil.nullToBlank(rs.getString("content")));
				prop.setCC(aseUtil.nullToBlank(rs.getString("cc")));
				prop.setAuditBy(aseUtil.nullToBlank(rs.getString("auditby")));
				prop.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
			}
			ps.close();
			rs.close();
		} catch (SQLException e) {
			logger.fatal("PropsDB: getProp\n" + e.toString());
			prop = null;
		} catch (Exception ex) {
			logger.fatal("PropsDB: getProp\n" + ex.toString());
			prop = null;
		}

		return prop;
	}

	/**
	 * getPropByCampusPropName
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	propBundle	String
	 * <p>
	 * @return	Props
	 */
	public static Props getPropByCampusPropName(Connection conn,String campus,String propBundle) {

		String sql = "SELECT * FROM tblProps WHERE campus=? AND propname=?";
		Props prop = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,propBundle);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				prop = new Props();
				prop.setPropName(AseUtil.nullToBlank(rs.getString("propname")));
				prop.setPropDescr(AseUtil.nullToBlank(rs.getString("propdescr")));
				prop.setSubject(AseUtil.nullToBlank(rs.getString("subject")));
				prop.setContent(AseUtil.nullToBlank(rs.getString("content")));
				prop.setCC(AseUtil.nullToBlank(rs.getString("cc")));
				prop.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				AseUtil aseUtil = new AseUtil();
				prop.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
			}
			ps.close();
			rs.close();
		} catch (SQLException e) {
			logger.fatal("PropsDB: getPropByCampusPropName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("PropsDB: getPropByCampusPropName - " + ex.toString());
		}

		return prop;
	}

	/**
	 * getFullPropFromID
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			int
	 * <p>
	 * @return	Props
	 */
	public static Props getFullPropFromID(Connection conn,String campus,int id) {

		String sql = "SELECT propname FROM tblProps WHERE id=?";
		Props props = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String property = AseUtil.nullToBlank(rs.getString("propname"));
				rs.close();
				props = PropsDB.getPropByCampusPropName(conn,campus,property);
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("PropsDB: getFullPropFromID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("PropsDB: getFullPropFromID - " + ex.toString());
		}

		return props;
	}

	/**
	 * getPropByID
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	String
	 */
	public static String getPropByID(Connection conn,int id) {

		String sql = "SELECT propname FROM tblProps WHERE id=?";
		String property = "";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				property = aseUtil.nullToBlank(rs.getString("propname"));
			}
			ps.close();
			rs.close();
		} catch (SQLException e) {
			logger.fatal("PropsDB: getPropByID\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("PropsDB: getPropByID\n" + ex.toString());
		}

		return property;
	}

	/**
	 * processProp
	 * <p>
	 * @param	conn		Connection
	 * @param	property	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 * @return	Props
	 */
	public static Props processProp(Connection conn,String property,String kix,String user) {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String[] defaults = (Constant.PROP_DEFAULTS).split(",");
		String[] defaultsx = (Constant.PROP_DEFAULTSX).split(",");
		int defaultCount = defaults.length;
		String subject = "";
		String content = "";
		String prop = "";
		int i = 0;
		Props props = null;

		try {
			AseUtil aseUtil = new AseUtil();

			sql = "SELECT " + Constant.PROP_DEFAULTSX + " FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				for (i=0;i<defaultCount;i++){
					defaultsx[i] = aseUtil.nullToBlank(rs.getString(defaultsx[i]));
				}
			}
			ps.close();
			rs.close();

			sql = "SELECT * FROM tblProps WHERE propname=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,property);
			rs = ps.executeQuery();
			if (rs.next()) {
				subject = aseUtil.nullToBlank(rs.getString("subject"));
				content = aseUtil.nullToBlank(rs.getString("content"));
				prop = aseUtil.nullToBlank(rs.getString("propname"));

				for (i=0;i<defaultCount;i++){
					subject = subject.replace("["+defaults[i]+"]",defaultsx[i]);
					content = content.replace("["+defaults[i]+"]",defaultsx[i]);
				}

				props = new Props();
				props.setSubject(property);
				props.setSubject(subject);
				props.setContent(content);

				//System.out.println("--------------------");
				//System.out.println(props);
			}
			ps.close();
			rs.close();
		} catch (SQLException e) {
			logger.fatal("PropsDB: processProp\n" + e.toString());
			props = null;
		} catch (Exception ex) {
			logger.fatal("PropsDB: processProp\n" + ex.toString());
			props = null;
		}

		return props;
	}

	/**
	 * reads and tests all SQL statements
	 *
	 * @param 	conn 	Connection
	 * @return	String
	 */
	public static String readProps(Connection conn) {

		// read through property file to test SQL statements for correctness

		//Logger logger = Logger.getLogger("test");

		StringBuffer contents = new StringBuffer();

		String campus = "HIL";
		String alpha = "ACC";
		String num = "201";
		String include = "Y";
		String kix = "123456789";
		String topic = "PSLO";
		String type = "CUR";
		String action = "1";
		PreparedStatement ps = null;
		String sql = null;
		String year = "2011";
		int line = 0;

		try {
			AseUtil aseUtil = new AseUtil();
			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);

			File aFile = new File(currentDrive + ":\\tomcat\\webapps\\central\\props\\ase\\central\\AseQueriesSQL.properties");
			BufferedReader input = new BufferedReader(new FileReader(aFile));

			try {
				while ((sql = input.readLine()) != null) {
					int pos = sql.indexOf("=");
					if (pos != -1){
						sql = sql.substring(pos+1);
						sql = sql.replace("_kix_",kix);
						sql = sql.replace("%_index_%",alpha);
						sql = sql.replace("_index_%",alpha);

						sql = sql.replace("%_campus_%",campus);
						sql = sql.replace("%_alpha_%",alpha);
						sql = sql.replace("%_num_%",num);

						sql = sql.replace("campus=?","campus='" + campus + "' ");
						sql = sql.replace("_camp_",campus);
						sql = sql.replace("_campus_",campus);
						sql = sql.replace("_alpha_",alpha);
						sql = sql.replace("_num_",num);

						sql = sql.replace("%_type_%",type);
						sql = sql.replace("_type_",type);

						sql = sql.replace("_sql_",campus);

						sql = sql.replace("%_include_%",include);

						sql = sql.replace("_sql_",campus);
						sql = sql.replace("_historyID_",kix);
						sql = sql.replace("_cat_",topic);

						sql = sql.replace("%_acktion_%",action);
						sql = sql.replace("AND (_experimental_)","");
						sql = sql.replace("AND _date_","");
						sql = sql.replace("WHERE userid=? and password=?","");
						sql = sql.replace("_year_",year);
						sql = sql.replace("_seq_","1");
						sql = sql.replace("_id_","1");
						sql = sql.replace("_dst_","PSLO");
						sql = sql.replace("_divid_","1");

						sql = sql + ";";

						try{
							++line;
							ps = conn.prepareStatement(sql);
							ps.executeQuery();
						}
						catch(SQLException e){
							contents.append("<h3 class=\"subheader\">"+line+"</h3>"
												 + Html.BR()
												 + "SQL: " + sql
												 + Html.BR()
												 + Html.BR()
												 + "Ex: " + e.toString()
												 + Html.BR()
												 );
						}
						finally{
							ps.close();
						}
					}
				}

			} finally {
				input.close();
			}
		} catch (IOException e) {
			logger.fatal("PropsDB - readProps: " + e.toString());
		} catch (Exception e) {
			logger.fatal("PropsDB - readProps: " + e.toString());
		}

		return contents.toString();
	}

	public void close() throws SQLException {}

}