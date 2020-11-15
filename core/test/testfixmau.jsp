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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAU";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";
	int totalDupsProcessed = 0;

	out.println("Start<br/>");

	if (processPage){

		/* fix up dups in mau
		for(int i=65;i<91;i++){
			out.println("<a href=\"?idx="+i+"\" class=\"linkcolumn\">" + (char)i + "</a>&nbsp;");
		}

		int idx = website.getRequestParameter(request,"idx",0);
		if (idx > 0){
			totalDupsProcessed = fixData00(conn,idx);
			out.println("<br/><br/>Processed " + totalDupsProcessed + " for letter " + (char)idx + "<br/>");
		}
		*/

		out.println("<br/><br/>Processed " + fixData(conn) + "<br/>");

	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	/*
	**	fixData
	*/
	public static int fixData(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalDupsFound = 0;
		int rowsAffected = 0;
		String historyid = "";

		String campus = "MAU";

		try{
			String sql = "SELECT col001 "
				+ "FROM zzzmau";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				++totalDupsFound;
				historyid = AseUtil.nullToBlank(rs.getString("col001"));
				rowsAffected = fixData02(conn,historyid);
				logger.info(totalDupsFound + " - delete dup - " + historyid);
			}
			rs.close();
			ps.close();

		}
		catch(SQLException sx){
			System.out.println("fixData: " + sx.toString());
		} catch(Exception ex){
			System.out.println("fixData: " + ex.toString());
		}

		System.out.println("totalDupsFound: " + totalDupsFound);

		return totalDupsFound;
	}

	/*
	**	fixData
	*/
	public static int fixData00(Connection conn,int idx){

		Logger logger = Logger.getLogger("test");

		int totalDupsFound = 0;
		int totalDupsProcessed = 0;
		int rowsAffected = 0;
		String alpha = "";
		String num = "";
		String progress = "";
		String historyid = "";
		String historyid2 = "";

		String campus = "MAU";

		// fixData 		- get all with dups
		// fixData01	- make sure not in modify mode
		// fixData02	- delete qualified entries with null auditdates
		// fixData03	- delete 1 of 2 remaining dups

		try{
			String sql = "SELECT CourseAlpha, CourseNum, COUNT(id) AS counter "
				+ "FROM tblCourse "
				+ "WHERE campus='MAU' "
				+ "AND CourseType='CUR' "
				+ "AND coursealpha like '"+(char)idx+"%' "
				+ "GROUP BY CourseAlpha, CourseNum "
				+ "HAVING COUNT(id)=3 "
				+ "ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				++totalDupsFound;
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				// found dups of 3 or more
				// work on outlines not having a modification going on (auditdate is null)
				if (alpha.length() > 0 && num.length() > 0){
					progress = CourseDB.getCourseProgress(conn,campus,alpha,num,"PRE");
					if (!"MODIFY".equals(progress)){
						++totalDupsProcessed;
						historyid = fixData01(conn,alpha,num);
						historyid2 = fixData03(conn,alpha,num);
						logger.info(totalDupsProcessed + " - " + alpha + " - " + num
							+ " - audit date - " + historyid
							+ " - delete dup - " + historyid2);
					}
				}
			}
			rs.close();
			ps.close();

		}
		catch(SQLException sx){
			System.out.println("fixData: " + sx.toString());
		} catch(Exception ex){
			System.out.println("fixData: " + ex.toString());
		}

		System.out.println("totalDupsFound: " + totalDupsFound);
		System.out.println("totalDupsProcessed: " + totalDupsProcessed);

		return totalDupsProcessed;
	}

	/*
	**	fixData01
	*/
	public static String fixData01(Connection conn,String alpha,String num){

		Logger logger = Logger.getLogger("test");

		String historyid = "";
		int rowsAffected = 0;

		try{
			String sql = "SELECT historyid "
				+ "FROM tblCourse "
				+ "WHERE campus='MAU' "
				+ "AND CourseType='CUR' "
				+ "AND coursealpha=? "
				+ "AND coursenum=? "
				+ "AND auditdate is null";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				historyid = rs.getString("historyid");
				rowsAffected = fixData02(conn,historyid);
				logger.info("Remove dups for MAU - " + historyid);
			}
			rs.close();
			ps.close();

		}
		catch(SQLException sx){
			System.out.println("fixData01: " + sx.toString());
		} catch(Exception ex){
			System.out.println("fixData01: " + ex.toString());
		}

		return historyid + " - " + rowsAffected;
	}

	/*
	**	fixData02
	*/
	public static int fixData02(Connection conn,String kix){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "DELETE  "
				+ "FROM tblCampusdata "
				+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "DELETE  "
				+ "FROM tblcourse "
				+ "WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected += ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			System.out.println("fixData02: " + sx.toString());
		} catch(Exception ex){
			System.out.println("fixData02: " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	**	fixData03
	*/
	public static String fixData03(Connection conn,String alpha,String num){

		Logger logger = Logger.getLogger("test");

		String historyid = "";
		int rowsAffected = 0;

		// there are now 2 remaining of each.
		// read through and get the last historyid.

		try{
			String sql = "SELECT historyid  "
				+ "FROM tblcourse "
				+ "WHERE campus='MAU' "
				+ "AND coursealpha=? "
				+ "AND coursenum=? "
				+ "AND coursetype='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				historyid = rs.getString("historyid");
			}
			rs.close();
			ps.close();

			if (historyid != null){
				rowsAffected = fixData02(conn,historyid);
			}
		}
		catch(SQLException sx){
			System.out.println("fixData03: " + sx.toString());
		} catch(Exception ex){
			System.out.println("fixData03: " + ex.toString());
		}

		return historyid;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

