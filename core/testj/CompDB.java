/**
	* Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
	* You may not modify, use, reproduce, or distribute this software except
	* in compliance with the terms of the License made with Applied Software Engineernig
	* @author ttgiang
	*
	* void close () throws SQLException{}
	*
*/

//
//  CompDB.java
//

import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import java.sql.*;
import java.util.*;
import javax.sql.*;

import java.util.Vector;

public class CompDB
{
	static Logger logger = Logger.getLogger(CompDB.class.getName());

	public CompDB () throws Exception{}

	/*
	 * getComps
	 * <p>
	 *	@return	Vector
	 */
	public static Vector getComps(
			Connection connection,
			String alpha,
			String num,
			String campus) throws Exception{

		String getCompSQL = "SELECT comp FROM tblComp WHERE courseAlpha=? AND courseNum=? AND campus=?";
		Vector myVector = null;

		try{
			PreparedStatement preparedStatement = connection.prepareStatement(getCompSQL);
			preparedStatement.setString(1, alpha);
			preparedStatement.setString(2, num);
			preparedStatement.setString(3, campus);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				myVector.addElement(new String (resultSet.getString(1)));
			}
			resultSet.close();
			preparedStatement.close();
		}
		catch (Exception e){
			logger.fatal("CompDB: getComps\n" + e.toString());
			myVector = null;
		}
		finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					logger.fatal("CompDB: getComps\n" + e.toString());
				}
			}
		}

		return myVector;
	}

	public void close () throws SQLException{}

}