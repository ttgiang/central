/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.db;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Helper;

import org.apache.log4j.Logger;

public class TSql {

	static Logger logger = Logger.getLogger(TSql.class.getName());

	/*
	 * getTables
	 *	<p>
	 * @param	conn	Connection
	 *	<p>
	 * @return String
	 */
	public static String getTables(Connection conn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//
		// returns all CC tables
		//

		String tables = "";

		try {

			String sql = "SELECT name from (SELECT DISTINCT name FROM sys.sysobjects "
				+ "WHERE (xtype = 'U' OR xtype = 'S') ) as x";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				if(tables.equals("")){
					tables = rs.getString("name");
				}
				else{
					tables = tables + "," + rs.getString("name");
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TSql.getTables: " + e.toString());
		} catch (Exception e) {
			logger.fatal("TSql.getTables: " + e.toString());
		}

		return tables;
	}

	/*
	 * getSchema
	 *	<p>
	 * @param	conn	Connection
	 *	<p>
	 * @return String
	 */
	public static String getSchema(Connection conn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//
		// returns table, column data type, length
		//

		String tables = "";

		try {

			String sql = "SELECT so.name, sc.name AS [column], systypes.name AS datatype, sc.length "
				+ "FROM syscolumns sc INNER JOIN sysobjects so ON sc.id = so.id "
				+ "INNER JOIN systypes ON sc.xtype = systypes.xtype "
				+ "WHERE (so.xtype='U' OR so.xtype='S')  "
				+ "AND (so.name=?) "
				+ "ORDER BY so.name, sc.name";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				//
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TSql.getSchema: " + e.toString());
		} catch (Exception e) {
			logger.fatal("TSql.getSchema: " + e.toString());
		}

		return tables;
	}

	/*
	 * isColumnInTable - does the column exist in the table
	 *	<p>
	 * @param	conn		Connection
	 * @param	table		String
	 * @param	column	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean isColumnInTable(Connection conn,String table,String column) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try {

			String sql = "SELECT so.name, sc.name AS [column] "
				+ "FROM syscolumns sc INNER JOIN sysobjects so ON sc.id = so.id "
				+ "INNER JOIN systypes ON sc.xtype = systypes.xtype "
				+ "WHERE (so.xtype='U' OR so.xtype='S') AND (so.name=?) AND sc.name=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,table);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TSql.isColumnInTable: " + e.toString());
		} catch (Exception e) {
			logger.fatal("TSql.isColumnInTable: " + e.toString());
		}

		return exists;
	}

	/*
	 * countRowsOfData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 *	@return 	String
	 */
	public static String countRowsOfData(Connection conn,String campus,String kix,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		int processed = 0;
		int read = 0;

		Writer out = null;

		StringBuffer ignored = new StringBuffer();
		StringBuffer columnsnotfound = new StringBuffer();
		StringBuffer campusnotfound = new StringBuffer();
		StringBuffer alphaornumnotfound = new StringBuffer();
		StringBuffer rowsfound = new StringBuffer();
		StringBuffer rowsnotfound = new StringBuffer();

		String type = "";
		String proposer = "";
		String title = "";
		String progress = "";
		String subprogress = "";

		boolean debug = false;

		try{

			//
			// some basic information
			//
			if(kix == null || kix.equals(Constant.BLANK)){

				type = "PRE";

				kix = Helper.getKix(conn,campus,alpha,num,type);
				if(kix == null || kix.equals(Constant.BLANK)){
					type = "CUR";
					kix = Helper.getKix(conn,campus,alpha,num,type);
				}

				if(kix != null && !kix.equals(Constant.BLANK)){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
					proposer = info[Constant.KIX_PROPOSER];
					progress = info[Constant.KIX_PROGRESS];
					subprogress = info[Constant.KIX_SUBPROGRESS];
					title = info[Constant.KIX_COURSETITLE];
				}
			}

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\tsql.txt"));
			out.write("campus: " + campus + "\n");
			out.write("title: " + title + "\n");
			out.write("proposer: " + proposer + "\n");
			out.write("kix: " + kix + "\n");
			out.write("alpha: " + alpha + "\n");
			out.write("num: " + num + "\n");
			out.write("type: " + type + "\n");
			out.write("progress: " + progress + "\n");
			out.write("subprogress: " + subprogress + "\n");
			out.write("============\n");

			//
			// get all tables in database
			//
			String tables = com.ase.aseutil.db.TSql.getTables(conn);

			if(tables != null){

				String[] aTables = tables.split(",");

				String table = "";
				String tuple = "";
				String sql = "";
				PreparedStatement ps = null;

				com.ase.aseutil.db.TSql tsql = new com.ase.aseutil.db.TSql();

				for(int i=0; i<aTables.length; i++){

					boolean found = false;
					boolean useKix = false;
					boolean useCampus = true;

					table = aTables[i].toLowerCase();

					//
					// change to not expose real table name
					//
					tuple = table.replace("tbl","");

					//
					// process only if not temp table
					//
					if(!table.contains("tbltemp")){

						++read;

						String columnAlpha = "";
						String columnNum = "";

						//
						// campus must exist when working with course alpha and number
						//
						if(!tsql.isColumnInTable(conn,table,"campus")){
							useCampus = false;
							campusnotfound.append(i + ". " + tuple + " - campus not found\n");
						}

						//
						// determine columns to use as key
						//
						if(tsql.isColumnInTable(conn,table,"historyid")){
							columnAlpha = "";
							columnNum = "";
							found = true;
							useKix = true;
						}
						else if(tsql.isColumnInTable(conn,table,"coursealpha")){
							columnAlpha = "coursealpha";
							columnNum = "coursenum";
							found = true;
						}
						else if(tsql.isColumnInTable(conn,table,"alpha")){
							columnAlpha = "alpha";
							columnNum = "num";
							found = true;
						}

						//
						// only if course alpha or alpha is found in table
						//
						if(found){

							//
							// if found, does it have the data we need?
							//
							try{
								if(useKix){
									if(useCampus){
										sql = "SELECT count(historyid) as counter FROM " + table + " WHERE campus=? AND historyid=?";
										ps = conn.prepareStatement(sql);
										ps.setString(1,campus);
										ps.setString(2,kix);
										if (debug) System.out.println(i + " - " + useCampus + " - " + table +  " - kix and campus");
									}
									else{
										sql = "SELECT count(historyid) as counter FROM " + table + " WHERE historyid=?";
										ps = conn.prepareStatement(sql);
										ps.setString(1,kix);
										if (debug) System.out.println(i + " - " + useCampus + " - " + table +  " - kix");
									}
								}
								else{
									sql = "SELECT count("+columnAlpha+") as counter FROM " + table + " WHERE campus=? AND " + columnAlpha + "=? AND "+columnNum+"=?";
									ps = conn.prepareStatement(sql);
									ps.setString(1,campus);
									ps.setString(2,alpha);
									ps.setString(3,num);
									if (debug) System.out.println(i + " - " + useCampus + " - " + table + " - full key");
								}

								ResultSet rs = ps.executeQuery();
								if(rs.next()){
									int counter = rs.getInt("counter");

									if(counter > 0){
										rowsfound.append(i + ". " + tuple + " - " + counter + " rows\n");
									}
									else{
										rowsnotfound.append(i + ". " + tuple + " - " + counter + " rows\n");
									}
								}
								rs.close();
								ps.close();
							}
							catch(SQLException e){
								alphaornumnotfound.append(i + ". " + tuple + " - alpha or num not found\n");
								if (debug) System.out.println(i + " - " + useCampus + " - " + table + " - error - " + e.toString());
							}
							catch(Exception e){
								logger.fatal("TSql.countRowsOfData: " + e.toString());
								if (debug) System.out.println(i + " - " + useCampus + " - " + table + " - error - " + e.toString());
							}

							++processed;

						}
						else{
							columnsnotfound.append(i + ". " + tuple + " - columns not found\n");
							if (debug) System.out.println(i + " - " + useCampus + " - " + table + " - ignored");
						} // found

					}
					else{
						ignored.append(i + ". " + tuple + " - ignored\n");
						if (debug) System.out.println(i + " - " + useCampus + " - " + table + " - temp");
					} // not temp

				} // for

				out.write("\n");

				out.write("Data found\n");
				out.write("----------\n");
				out.write(rowsfound.toString());
				out.write("\n");

				out.write("Data found (0 rows)\n");
				out.write("----------\n");
				out.write(rowsnotfound.toString());
				out.write("\n");

				out.write("Alpha or Num not found\n");
				out.write("----------\n");
				out.write(alphaornumnotfound.toString());
				out.write("\n");

				out.write("Alpha and Num not found\n");
				out.write("----------\n");
				out.write(columnsnotfound.toString());
				out.write("\n");

				out.write("campus not found\n");
				out.write("----------\n");
				out.write(campusnotfound.toString());
				out.write("\n");

				out.write("Ignored\n");
				out.write("----------\n");
				out.write(ignored.toString());
				out.write("\n");

				tsql = null;

			} // tables

		}
		catch(SQLException e){
			logger.fatal("TSql.countRowsOfData1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("TSql.countRowsOfData2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("TSql.countRowsOfData3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("TSql.countRowsOfData4: " + e.toString());
			}

		}

		return "Processed: " + processed + " of " + read + " tables";

	}

	/*
	 * countRowsOfData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 *	@return 	String
	 */
	public static String countRowsOfDataOBSOLETE(Connection conn,String campus,String kix,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		int processed = 0;
		int read = 0;

		Writer out = null;

		StringBuffer ignored = new StringBuffer();
		StringBuffer columnsnotfound = new StringBuffer();
		StringBuffer campusnotfound = new StringBuffer();
		StringBuffer alphaornumnotfound = new StringBuffer();
		StringBuffer rowsfound = new StringBuffer();
		StringBuffer rowsnotfound = new StringBuffer();

		String type = "";
		String proposer = "";
		String title = "";
		String progress = "";
		String subprogress = "";

		try{

			//
			// some basic information
			//
			if(kix == null || kix.equals(Constant.BLANK)){

				type = "PRE";

				kix = Helper.getKix(conn,campus,alpha,num,type);
				if(kix == null || kix.equals(Constant.BLANK)){
					type = "CUR";
					kix = Helper.getKix(conn,campus,alpha,num,type);
				}

				if(kix != null && !kix.equals(Constant.BLANK)){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
					proposer = info[Constant.KIX_PROPOSER];
					progress = info[Constant.KIX_PROGRESS];
					subprogress = info[Constant.KIX_SUBPROGRESS];
					title = info[Constant.KIX_COURSETITLE];
				}
			}

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\tsql.txt"));
			out.write("campus: " + campus + "\n");
			out.write("title: " + title + "\n");
			out.write("proposer: " + proposer + "\n");
			out.write("kix: " + kix + "\n");
			out.write("alpha: " + alpha + "\n");
			out.write("num: " + num + "\n");
			out.write("type: " + type + "\n");
			out.write("progress: " + progress + "\n");
			out.write("subprogress: " + subprogress + "\n");
			out.write("============\n");

			//
			// get all tables in database
			//
			String tables = com.ase.aseutil.db.TSql.getTables(conn);

			if(tables != null){

				String[] aTables = tables.split(",");

				String table = "";

				com.ase.aseutil.db.TSql tsql = new com.ase.aseutil.db.TSql();

				for(int i=0; i<aTables.length; i++){

					boolean found = false;

					table = aTables[i].toLowerCase();

					//
					// process only if not temp table
					//
					if(!table.contains("tbltemp")){

						++read;

						String columnAlpha = "";
						String columnNum = "";

						//
						// campus must exist
						//
						if(tsql.isColumnInTable(conn,table,"campus")){

							if(tsql.isColumnInTable(conn,table,"coursealpha")){
								columnAlpha = "coursealpha";
								columnNum = "coursenum";
								found = true;
							}
							else if(tsql.isColumnInTable(conn,table,"alpha")){
								columnAlpha = "alpha";
								columnNum = "num";
								found = true;
							}

							//
							// only if course alpha or alpha is found in table
							//
							if(found){

								//
								// if found, does it have the course data we need?
								//
								try{
									String sql = "SELECT count("+columnAlpha+") as counter FROM " + table + " WHERE campus=? AND " + columnAlpha + "=? AND "+columnNum+"=?";
									PreparedStatement ps = conn.prepareStatement(sql);
									ps.setString(1,campus);
									ps.setString(2,alpha);
									ps.setString(3,num);
									ResultSet rs = ps.executeQuery();
									if(rs.next()){
										int counter = rs.getInt("counter");

										if(counter > 0){
											rowsfound.append(i + ". " + table + " - " + counter + " rows\n");
										}
										else{
											rowsnotfound.append(i + ". " + table + " - " + counter + " rows\n");
										}

									}
									rs.close();
									ps.close();
								}
								catch(SQLException e){
									alphaornumnotfound.append(i + ". " + table + " - alpha or num not found\n");
								}
								catch(Exception e){
									logger.fatal("TSql.countRowsOfData: " + e.toString());
								}

								++processed;

							}
							else{
								columnsnotfound.append(i + ". " + table + " - columns not found\n");
							} // found

						}
						else{
							campusnotfound.append(i + ". " + table + " - campus not found\n");
						} // campus

					}
					else{
						ignored.append(i + ". " + table + " - ignored\n");
					} // not temp

				} // for

				out.write("\n");

				out.write("Data found\n");
				out.write("----------\n");
				out.write(rowsfound.toString());
				out.write("\n");

				out.write("Data found (0 rows)\n");
				out.write("----------\n");
				out.write(rowsnotfound.toString());
				out.write("\n");

				out.write("Alpha or Num not found\n");
				out.write("----------\n");
				out.write(alphaornumnotfound.toString());
				out.write("\n");

				out.write("Alpha and Num not found\n");
				out.write("----------\n");
				out.write(columnsnotfound.toString());
				out.write("\n");

				out.write("campus not found\n");
				out.write("----------\n");
				out.write(campusnotfound.toString());
				out.write("\n");

				out.write("Ignored\n");
				out.write("----------\n");
				out.write(ignored.toString());
				out.write("\n");

				tsql = null;

			} // tables

		}
		catch(SQLException e){
			logger.fatal("TSql.countRowsOfData1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("TSql.countRowsOfData2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("TSql.countRowsOfData3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("TSql.countRowsOfData4: " + e.toString());
			}

		}

		return "Processed: " + processed + " of " + read + " rows";

	}

}