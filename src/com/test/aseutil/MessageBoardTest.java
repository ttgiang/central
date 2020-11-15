/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.test.aseutil;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import java.util.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class MessageBoardTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.MessageBoardTest#testMe()}.
	 */
	@Test
	public final void testMe() {

		assertTrue(runMe(getConnection(),null));
	}

	public static boolean runMe(Connection conn,String campus) {

		// by default, we'll assume success until a delete goes wrong

		boolean success = true;

		try{
			if (conn != null){

				PreparedStatement ps = null;

				if(campus==null){
					ps = conn.prepareStatement("SELECT creator,forum_id FROM forums");
				}
				else{
					ps = conn.prepareStatement("SELECT creator,forum_id FROM forums WHERE campus=?");
					ps.setString(1,campus);
				}
				ResultSet rs = ps.executeQuery();
				while(rs.next() && success){
					int fid = rs.getInt("forum_id");
					String creator = rs.getString("creator");
					int rowsAffected = ForumDB.closeForum(conn,creator,fid);
					if (rowsAffected < 1){
						success = false;
					}
				}
				rs.close();
				ps.close();

			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}
