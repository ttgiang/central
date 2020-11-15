/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.export;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.StringWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerException;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Attr;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Helper;
import com.ase.aseutil.SysDB;

public class ExportXML {

	static Logger logger = Logger.getLogger(ExportXML.class.getName());

	/*
	* process
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	kix		String
	*<p>
	*/
	public static void process(Connection conn,String campus,String kix) {

		try{
			// run through all tables and process only ones with historyid as a column
			//
			// at the root is CC (rootElement)
			// indent to add table (while loop - tableElement)
			// indent to add rows for tables (processX)

			// build document
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			// root elements
			Document doc = docBuilder.newDocument();
			Element rootElement = doc.createElement("CurriculumCentral");
			doc.appendChild(rootElement);

			String sql = "SELECT distinct so.name AS tbl "
				+ "FROM syscolumns sc, sysobjects so "
				+ "WHERE so.id = sc.id "
				+ "AND so.name LIKE 'tbl%' "
				+ "AND so.name NOT LIKE 'tblTemp%' "
				+ "AND sc.name='historyid' "
				+ "ORDER BY so.name ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				String table = rs.getString("tbl");

				Element tableElement = doc.createElement(table.toLowerCase().replace("tbl",""));
				rootElement.appendChild(tableElement);

				processX(conn,table,kix,doc,tableElement);
			} // while
			rs.close();
			ps.close();

			try{
				// write the content into xml file
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(doc);

				// push data to string writer so that write to file is possible
				StringWriter sw = new StringWriter();

				// using the writer, generate the transformation
				StreamResult sr = new StreamResult(sw);

				// transform
				transformer.transform(source,sr);

				// the resulting transformation is converted to a string for file write
				StringBuffer sb = sw.getBuffer();

				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];

				String fileName = AseUtil.getCurrentDrive()
								+ ":"
								+ SysDB.getSys(conn,"documents")
								+ "xml" + "\\"
								+ campus + "\\"
								+ alpha + "_" + num + "_" + kix+".xml";

				FileWriter fstream = new FileWriter(fileName);

				BufferedWriter out = new BufferedWriter(fstream);
				out.write(sb.toString());
				out.close();

			}
			catch (TransformerException e) {
				System.out.println("TransformerException: " + e.toString());
			}

		}
		catch(SQLException e){
			System.out.println("SQLException: " + e.toString());
		}
		catch(Exception e){
			System.out.println("Exception: " + e.toString());
		}

	}

	/*
	* process
	*<p>
	* @param	conn				Connection
	* @param	campus			String
	* @param	kix				String
	* @param	doc				Document
	* @param	tableElement	Element
	*<p>
	*/
	public static void processX(Connection conn,String table,String kix,Document doc,Element tableElement) {

		String columnName = "";

		int id = 0;

		try{

			String sql = "SELECT * FROM " + table + " WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				try{
					Element rowElement = doc.createElement("row");
					tableElement.appendChild(rowElement);

					rowElement.setAttribute("id", "" + (++id));

					ResultSetMetaData rsmd = rs.getMetaData();

					int colCount = rsmd.getColumnCount();

					for (int i = 1; i <= colCount; i++) {

						columnName = rsmd.getColumnName(i);

						String data = AseUtil.nullToBlank(rs.getString(columnName));

						Element columns = doc.createElement(columnName);
						columns.appendChild(doc.createTextNode(data));
						rowElement.appendChild(columns);

					} // for
				}
				catch (Exception e) {
					e.printStackTrace();
				}

			} // rs2
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			System.out.println("SQLException ("+table+"-"+columnName+"): " + e.toString());
		}
		catch(Exception e){
			System.out.println("Exception ("+table+"-"+columnName+"): " + e.toString());
		}

	}


}