/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *
 * @author ttgiang
 */

//
// Conversion.java
//
package com.ase.aseutil.conversion;

import com.ase.aseutil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class Conversion {

	static Logger logger = Logger.getLogger(Conversion.class.getName());

	public Conversion() throws Exception {}

   /**
	 * createHelpKeys - create key for help pages
	 *	<p>
	 * @param	conn	Connection
	 */
	public static int createHelpKeys(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

			String campuses = CampusDB.getCampusNames(conn);
			if (!campuses.equals(Constant.BLANK)){

				String[] campus = campuses.split(",");
				String[] keys = "RecPrep,Pre-Requisite,Co-Requisite,SLO,Content,GESLO,ProgramSLO,ProgramILO,Competency,Other Departments,EnableItems".split(",");

				for(int i=0;i<campus.length;i++){
					for(int j=0;j<keys.length;j++){
						if(!HelpDB.isMatch(conn,campus[i],"Course",keys[j])){
							// add the help idx
							String sql = "insert into tblhelpidx (campus,category,title,subtitle,auditby,auditdate) values (?,'Course',?,?,'SYSADM',?)";
							PreparedStatement ps = conn.prepareStatement(sql);
							ps.setString(1,campus[i]);
							ps.setString(2,keys[j]);
							ps.setString(3,keys[j]);
							ps.setString(4,AseUtil.getCurrentDateTimeString());
							rowsAffected += ps.executeUpdate();
							ps.close();

							// retrieve the idx key and add content
							sql = "select id from tblhelpidx where campus=? AND title=? and category='Course'";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus[i]);
							ps.setString(2,keys[j]);
							ResultSet rs = ps.executeQuery();
							if (rs.next()){
								int id = rs.getInt("id");
								ps.close();
								sql = "insert into tblhelp(id,content) values (?,?)";
								ps = conn.prepareStatement(sql);
								ps.setInt(1,id);
								ps.setString(2,"Add your help text here");
								rowsAffected = ps.executeUpdate();
							}
							rs.close();
							ps.close();

						} // !match
					} // keys
				} // campuses
			} // if

		}
		catch(SQLException e){
			logger.fatal("Conversion - createHelpKeys: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Conversion - createHelpKeys: " + e.toString());
		}

		return rowsAffected;

	}

	/**
	 * createMissingSettingForCampus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int createMissingSettingForCampus(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String baseCampus = "TTG";

			// system setting
			String category = "System";

			// campus wide setting
			String campusWide = "N";

			// read all settings for TTG or base
			String sql = "select * from tblini where campus=? AND category=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,baseCampus);
			ps.setString(2,category);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kid = AseUtil.nullToBlank(rs.getString("kid"));
				String kdesc = AseUtil.nullToBlank(rs.getString("kdesc"));
				String kval1 = AseUtil.nullToBlank(rs.getString("kval1"));
				String kval2 = AseUtil.nullToBlank(rs.getString("kval2"));
				String kval3 = AseUtil.nullToBlank(rs.getString("kval3"));
				String kedit = AseUtil.nullToBlank(rs.getString("kedit"));

				kval1 = kval1.replaceAll(baseCampus,campus);

				Ini ini = new Ini("0",category,kid,kdesc,kval1,kval2,kval3,null,null,user,AseUtil.getCurrentDateTimeString(),campus,kedit);

 				rowsAffected += IniDB.insertIni(conn,ini,campusWide);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("IniDB: createMissingSettingForCampus - " + e.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: createMissingSettingForCampus - " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}