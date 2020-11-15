<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		return;
	}

	String campus = "LEE";
	String alpha = "ICS";
	String num = "241";
	String user = "THANHG";

	out.println("---------->> modify start<br>");
	//out.println(CourseModify.modifyOutline(conn,"LEE",alpha,num,user,"jsid"));
	//out.println(CourseModify.modifyOutline(conn,"MAU","ICS","205",user,"jsid"));
	//out.println(CourseModify.modifyOutline(conn,"LEE","ENG","100",user,"jsid"));
	out.println("---------->> modify ends<br>");
	out.println("---------->> cancel starts<br>");
	out.println(CourseCancel.cancelOutline(conn,"LEE",alpha,num,user));
	out.println(CourseCancel.cancelOutline(conn,"MAU","ICS","205",user));
	out.println(CourseCancel.cancelOutline(conn,"LEE","ENG","100",user));
	out.println("---------->> ends ends<br>");

	asePool.freeConnection(conn);
%>

<%!
	public static Msg modifyOutlineAccess(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String jsid) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;
		int totalTables = 7;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];
		String thisSQL = "";
		Msg msg = new Msg();

		boolean debug = false;

		AsePool asePool = AsePool.getInstance();
		Connection connection = asePool.getConnection();

		connection.setAutoCommit(false);

		try {
			String historyID = SQLUtil.createHistoryID(1);
			PreparedStatement ps = null;

			sql = Constant.MAIN_TABLES.split(",");
			tempSQL = Constant.TEMP_TABLES.split(",");
			totalTables = sql.length;

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				if (!debug) rowsAffected = ps.executeUpdate();
				logger.info("CourseModify - modifyOutlineAccess - DELETE " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ tempSQL[i]
						+ " SELECT * FROM "
						+ sql[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,"CUR");
				if (!debug) rowsAffected = ps.executeUpdate();
				logger.info("CourseModify - modifyOutlineAccess - insert " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',"+
				"proposer=?,historyid=?,jsid=?,assessmentdate=?,coursedate=?,dateproposed=? "+
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			logger.info("CourseModify - modifyOutlineAccess - update 1 of 1");
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1,historyID);
			ps.setString(2,user);
			ps.setString(3,historyID);
			ps.setString(4,jsid);
			ps.setNull(5,java.sql.Types.VARCHAR);
			ps.setNull(6,java.sql.Types.VARCHAR);
			ps.setString(7,AseUtil.getCurrentDateString());
			ps.setString(8,campus);
			ps.setString(9,alpha);
			ps.setString(10,num);
			if (!debug) rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			ps.close();

			/*
				there is a posibility that campus data won't exist. if so, create an entry here
			*/
			rowsAffected = modifyOutlineXX(conn,campus,alpha,num,user,historyID);
			logger.info("CourseModify - modifyOutlineAccess - update campus - " + rowsAffected + " record");

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQL[i]
						+ " SET historyid=?,coursetype='PRE',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,historyID);
				ps.setString(2,AseUtil.getCurrentDateString());
				ps.setString(3,campus);
				ps.setString(4,alpha);
				ps.setString(5,num);
				if (!debug) rowsAffected = ps.executeUpdate();
				logger.info("CourseModify - modifyOutlineAccess - update " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ tempSQL[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				if (!debug) rowsAffected = ps.executeUpdate();
				logger.info("CourseModify - modifyOutlineAccess - insert " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			ps.close();

			connection.commit();

			AseUtil.loggerInfo("CourseModify: modifyOutlineAccess ",campus,user,alpha,num);
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseModify: modifyOutlineAccess\n" + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("CourseModify: modifyOutlineAccess\n" + e.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				logger.fatal("CourseModify: modifyOutlineAccess\n" + exp.toString() + "\n");
				msg.setMsg("Exception");
			}
		} finally {
			asePool.freeConnection(connection);
		}

		return msg;
	}

	public static int modifyOutlineXX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String historyID) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String thisSQL = "";

		try{
			/*
				add only if not there
			*/
			if (	!CampusDB.courseExistByCampus(conn,campus,alpha,num,"PRE") &&
					!CampusDB.courseExistByCampus(conn,campus,alpha,num,"CUR") ) {

				thisSQL = "INSERT INTO tblTempCampusData(historyid,CourseAlpha,CourseNum,auditby,campus) VALUES(?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(thisSQL);
				ps.setString(1,historyID);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,user);
				ps.setString(5,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();

			}
		}
		catch(SQLException se){
			logger.fatal("CourseModify: modifyOutlineXX\n" + se.toString());
			rowsAffected = -1;
		}
		catch(Exception e){
			logger.fatal("CourseModify: modifyOutlineXX\n" + e.toString());
			rowsAffected = -1;
		}

		return rowsAffected;
	}

%>
