<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	testfixbanner.jsp - delete all in BANNER that's found in the new download. After
	*  delete is done, insert from new downloads
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	out.println("Start<br/>");
	//out.println(BannerDB.processAlpha(conn) + " <br/>");
	//out.println(BannerDB.processBanner(conn) + " <br/>");
	//out.println(BannerDB.processCollege(conn) + " <br/>");
	//out.println(BannerDB.processDept(conn) + " <br/>");
	//out.println(BannerDB.processDivision(conn) + " <br/>");
	//out.println(BannerDB.processTerm(conn) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	processAlpha
	*/
	public static String processAlpha(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "banneralpha";
		String toTable = "zzzalpha";
		String columns = "COURSE_ALPHA,ALPHA_DESCRIPTION";
		String where = "COURSE_ALPHA=? AND ALPHA_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{
			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("COURSE_ALPHA");
				num = rs.getString("ALPHA_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processAlpha: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processAlpha: " + ex.toString());
		}

		return "Alpha: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	**	processBanner
	*/
	public static String processBanner(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String campus = "";
		String alpha = "";
		String num = "";
		String term = "";

		// if the course is not in the new table, delete it
		try{
			String sql = "SELECT ID,INSTITUTION, CRSE_ALPHA, CRSE_NUMBER, EFFECTIVE_TERM "
					+ "FROM banner "
					+ "ORDER BY INSTITUTION, CRSE_ALPHA, CRSE_NUMBER";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()){
				id = rs.getInt("id");
				campus = rs.getString("INSTITUTION");
				alpha = rs.getString("CRSE_ALPHA");
				num = rs.getString("CRSE_NUMBER");
				term = rs.getString("EFFECTIVE_TERM");

				sql = "SELECT ID "
					+ "FROM zzzbanner "
					+ "WHERE INSTITUTION=? AND CRSE_ALPHA=? AND CRSE_NUMBER=? AND EFFECTIVE_TERM=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,term);
				rs2 = ps.executeQuery();
				if (rs2.next()){
					sql = "DELETE FROM banner "
						+ "WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,id);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();
			}
			rs.close();

			sql = "INSERT INTO banner SELECT * FROM zzzbanner";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processBanner: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processBanner: " + ex.toString());
		}

		return "Banner: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	**	processCollege
	*/
	public static String processCollege(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerCollege";
		String toTable = "zzzcollege";
		String columns = "COLLEGE_CODE,COLL_DESCRIPTION";
		String where = "COLLEGE_CODE=? AND COLL_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("COLLEGE_CODE");
				num = rs.getString("COLL_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processCollege: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processCollege: " + ex.toString());
		}

		return "College: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	**	processDept
	*/
	public static String processDept(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerDept";
		String toTable = "zzzdept";
		String columns = "DEPT_CODE,DEPT_DESCRIPTION";
		String where = "DEPT_CODE=? AND DEPT_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("DEPT_CODE");
				num = rs.getString("DEPT_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processDept: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processDept: " + ex.toString());
		}

		return "Dept: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	**	processDivision
	*/
	public static String processDivision(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerDivision";
		String toTable = "zzzdivision";
		String columns = "DIVISION_CODE,DIVS_DESCRIPTION";
		String where = "DIVISION_CODE=? AND DIVS_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("DIVISION_CODE");
				num = rs.getString("DIVS_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processDivision: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processDivision: " + ex.toString());
		}

		return "Division: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	**	processTerm
	*/
	public static String processTerm(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerTerms";
		String toTable = "zzzterm";
		String columns = "TERM_CODE,TERM_DESCRIPTION";
		String where = "TERM_CODE=? AND TERM_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("TERM_CODE");
				num = rs.getString("TERM_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processTerm: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processTerm: " + ex.toString());
		}

		return "Terms: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

