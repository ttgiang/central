<%@ page language="java" import="org.apache.log4j.Logger"%>
<%@ page language="java" import="org.w3c.tidy.Tidy"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.net.URLConnection"%>
<%@ page language="java" import="java.net.URL"%>

<%@ page language="java" import="ase.aseutil.*"%>
<%@ page language="java" import="com.javaexchange.dbConnectionBroker.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
			<form method="post" action="testx.jsp" name="aseForm">
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HON";
	String user = "THANHG";

	int rowsAffected = 0;
	int counter = 0;

	System.out.println("Start<br/>");

	if (processPage){

		int idx = website.getRequestParameter(request,"idx",0);

		switch(idx){
			case 2:
				// tables already created use ER00014.mdf as the source to copy to ccv2
				//createHistoryID(conn);
				break;
			case 3:
				processINI(conn);
				break;
			case 4:
				importUsers(conn);
				break;
			case 5:
				importDept(conn);
				break;
			case 6:
				importHelp(conn);
				break;
			case 10:
				importWIN(conn);
				break;
			case 99:
				Tables.campusOutlines();
				break;
		}

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>
		</td>
	</tr>

	<tr>
		<td>
			<ul>
				<li><a href="?idx=2" class="linkcolumn">Create Course Historyd ID (UHMC)</a></li>
				<li><a href="?idx=3" class="linkcolumn">Process INI (UHMC)</a></li>
				<li><a href="?idx=4" class="linkcolumn">Import Users (UHMC & WIN)</a></li>
				<li><a href="?idx=5" class="linkcolumn">Import Dept/Divs (UHMC & WIN)</a></li>
				<li><a href="?idx=6" class="linkcolumn">Import Help (UHMC)</a></li>
				<li><a href="?idx=10" class="linkcolumn">Import WIN outlines (WIN)</a></li>
				<li><a href="?idx=99" class="linkcolumn">Create Campus Outlines (ALL)</a></li>
			</ul>
		</td>
	</tr>
</table>

<%!

	/**
	*	creates the data for import to main course and campus
	**/
	public static int createHistoryID(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			String table = "MAUtblCourse";

			System.out.println("----------------------------- START");

			String sql = "SELECT seq FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				if (seq > 0){
					String kix = SQLUtil.createHistoryID(1) + seq;
					sql = "UPDATE " + table + " SET id=?,historyid=? WHERE seq=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setString(2,kix);
					ps2.setInt(3,seq);
					rowsAffected += ps2.executeUpdate();
					System.out.println(seq);
				}
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	/**
	**/
	public static int processINI(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		com.ase.aseutil.AsePool pool = null;

		Connection connER00014 = null;

		int rowsAffected = 0;

		try {
			logger.fatal( "----------------------------- " );

			logger.fatal( "obtaining broker" );

			String host = "THANH";
			String port = "1433";
			String driver = "net.sourceforge.jtds.jdbc.Driver";
			String url = "jdbc:jtds:sqlserver";
			String db = "er00014";
			String user = "ccusr";
			String password = "Snn1q0tw";

			String campus = "UHMC";

			url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

			pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,
															AseUtil.getCurrentDrive()
															+ ":\\tomcat\\webapps\\central\\logs\\er00014-processINI.log",1.0,false,180,3);

			logger.fatal( "got broker" );

			logger.fatal( "obtaining connection" );

			connER00014 = pool.getConnection();

			logger.fatal( "got connection" );

			Ini ini = null;

			try{
				// delete existing INI data from CCV2
				String sql = "DELETE FROM tblINI WHERE (campus='UHMC' OR campus='WIN')";
				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from INI");

				sql = "DELETE FROM tblApprover WHERE (campus='UHMC' OR campus='WIN')";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from Approvers");

				sql = "SELECT * FROM tblINI WHERE (campus='UHMC' OR campus='WIN') ORDER BY category,kid";
				ps = connER00014.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					int newId = 0;
					int oldId = rs.getInt("id");
					String category = AseUtil.nullToBlank(rs.getString("category"));
					String kid = AseUtil.nullToBlank(rs.getString("kid"));
					String thisCampus = AseUtil.nullToBlank(rs.getString("campus"));

					logger.fatal("processing - " +category+"-"+kid);

					ini = new Ini("0",
										category,
										kid,
										AseUtil.nullToBlank(rs.getString("kdesc")),
										AseUtil.nullToBlank(rs.getString("kval1")),
										AseUtil.nullToBlank(rs.getString("kval2")),
										AseUtil.nullToBlank(rs.getString("kval3")),
										AseUtil.nullToBlank(rs.getString("kval4")),
										AseUtil.nullToBlank(rs.getString("kval5")),
										AseUtil.nullToBlank(rs.getString("klanid")),
										AseUtil.nullToBlank(rs.getString("kdate")),
										thisCampus,
										AseUtil.nullToBlank(rs.getString("kedit"))
										);

					boolean debug = false;

					if (!debug){

						// insert the main or master record
						IniDB.insertIni(conn,ini,"N");

						// get the added key and use it for detail records
						ini = IniDB.getIniByCategoryKid(conn,category,kid);
						if (ini != null){

							newId = Integer.parseInt(ini.getId());

							rowsAffected = 0;

							if (newId > 0){
								if (category.equals("ApprovalRouting")){
									sql = "SELECT * FROM tblapprover WHERE campus=? AND route=?";
									PreparedStatement ps2 = connER00014.prepareStatement(sql);
									ps2.setString(1,thisCampus);
									ps2.setInt(2,oldId);
									ResultSet rs2 = ps2.executeQuery();
									while(rs2.next()){

										sql = "INSERT INTO tblApprover (approver_seq,approver,delegated,multilevel,department,division,campus,addedby,addeddate,experimental,route) "
												+ " VALUES(?,?,?,?,?,?,?,?,?,?,?)";
										PreparedStatement ps3 = conn.prepareStatement(sql);

										ps3.setInt(1,rs2.getInt("approver_seq"));
										ps3.setString(2,AseUtil.nullToBlank(rs2.getString("approver")));
										ps3.setString(3,AseUtil.nullToBlank(rs2.getString("delegated")));
										ps3.setBoolean(4,false);
										ps3.setString(5,AseUtil.nullToBlank(rs2.getString("department")));
										ps3.setString(6,AseUtil.nullToBlank(rs2.getString("division")));
										ps3.setString(7,AseUtil.nullToBlank(rs2.getString("campus")));
										ps3.setString(8,"SYSADM");
										ps3.setString(9,AseUtil.getCurrentDateTimeString());
										ps3.setString(10,rs2.getString("experimental"));
										ps3.setInt(11,newId);
										rowsAffected += ps3.executeUpdate();
										ps3.close();

									} // while
									rs2.close();
									ps2.close();
								}// ApprovalRouting

							} // newId

							logger.fatal("inserted " + rowsAffected + " rows for approver seq");

						} // if ini

					} // debug

				} // while

				rs.close();
				ps.close();
			}
			catch(SQLException e){
				logger.fatal( "SQLException: " +  e.toString() );
			}
			finally{
				logger.fatal( "free connection" );

				pool.freeConnection(connER00014);

			}

			logger.fatal( "----------------------------- " );
		}
		catch (Exception e){
			logger.fatal( e.toString() );
		}

		return 0;
	}

	/**
	**/
	public static int importUsers(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		com.ase.aseutil.AsePool pool = null;

		Connection connER00014 = null;

		int rowsAffected = 0;

		try {
			logger.fatal( "----------------------------- " );

			logger.fatal( "obtaining broker" );

			String host = "THANH";
			String port = "1433";
			String driver = "net.sourceforge.jtds.jdbc.Driver";
			String url = "jdbc:jtds:sqlserver";
			String db = "er00014";
			String user = "ccusr";
			String password = "Snn1q0tw";

			String campus = "UHMC";

			url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

			pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,
															AseUtil.getCurrentDrive()
															+ ":\\tomcat\\webapps\\central\\logs\\er00014-importUsers.log",1.0,false,180,3);

			logger.fatal( "got broker" );

			logger.fatal( "obtaining connection" );

			connER00014 = pool.getConnection();

			logger.fatal( "got connection" );

			User usr = null;

			try{
				// delete existing INI data from CCV2
				String sql = "DELETE FROM tblUsers WHERE campus='UHMC' OR  campus='WIN'";
				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from users");

				rowsAffected = 0;

				sql = "SELECT * FROM tblUsers";
				ps = connER00014.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					usr = new User();
					usr.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
					usr.setUserid(AseUtil.nullToBlank(rs.getString("userid")));
					//usr.setPassword("c0mp1ex");
					usr.setPassword("1nn0v@te");
					usr.setFirstname(AseUtil.nullToBlank(rs.getString("firstname")));
					usr.setLastname(AseUtil.nullToBlank(rs.getString("lastname")));
					usr.setFullname(AseUtil.nullToBlank(rs.getString("fullname")));
					usr.setStatus(AseUtil.nullToBlank(rs.getString("status")));
					usr.setUserLevel(rs.getInt("userlevel"));
					usr.setDepartment(AseUtil.nullToBlank(rs.getString("department")));
					usr.setDivision(AseUtil.nullToBlank(rs.getString("division")));
					usr.setPosition(Constant.BLANK);
					usr.setEmail(AseUtil.nullToBlank(rs.getString("email")));
					usr.setLocation(AseUtil.nullToBlank(rs.getString("location")));
					usr.setPhone(AseUtil.nullToBlank(rs.getString("phone")));
					usr.setWebsite(AseUtil.nullToBlank(rs.getString("website")));
					usr.setTitle(Constant.BLANK);
					usr.setSalutation(Constant.BLANK);
					usr.setAuditBy("SYSADM");
					usr.setAuditDate(AseUtil.getCurrentDateTimeString());
					usr.setHours(Constant.BLANK);
					usr.setAlphas(Constant.BLANK);
					usr.setUH(1);
					usr.setSendNow(1);
					usr.setAttachment(0);
					usr.setWeburl(Constant.BLANK);

					rowsAffected += UserDB.insertUser(conn,usr);

				} // while

				rs.close();
				ps.close();

				logger.fatal("add " + rowsAffected + " rows to users");

				sql = "update tblusers "
					+ "set userlevel=2,department='AELC',division='UNC',title='APT',position='FACULTY',location='GT-207',phone='808-984-3378' "
					+ "where campus='UHMC' AND userid = 'DEBIE'";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal(rowsAffected + " row updated for DEBIE");

				sql = "update tblusers  "
					+ "set userlevel=2,department='HAW',division='HLAN',title='FACULTY',position='FACULTY',location='Ka Lama 215',phone='346' "
					+ "where campus='UHMC' AND userid = 'KAHELEON'";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal(rowsAffected + " row updated for KAHELEON");

			}
			catch(SQLException e){
				logger.fatal( "SQLException: " +  e.toString() );
			}
			finally{
				logger.fatal( "free connection" );

				pool.freeConnection(connER00014);

			}

			logger.fatal( "----------------------------- " );
		}
		catch (Exception e){
			logger.fatal( e.toString() );
		}

		return 0;
	}

	/**
	**/
	public static int importDept(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		com.ase.aseutil.AsePool pool = null;

		Connection connER00014 = null;

		int rowsAffected = 0;

		try {
			logger.fatal( "----------------------------- " );

			logger.fatal( "obtaining broker" );

			String host = "THANH";
			String port = "1433";
			String driver = "net.sourceforge.jtds.jdbc.Driver";
			String url = "jdbc:jtds:sqlserver";
			String db = "er00014";
			String user = "ccusr";
			String password = "Snn1q0tw";

			String campus = "UHMC";

			url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

			pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,
															AseUtil.getCurrentDrive()
															+ ":\\tomcat\\webapps\\central\\logs\\er00014-importDept.log",1.0,false,180,3);

			logger.fatal( "got broker" );

			logger.fatal( "obtaining connection" );

			connER00014 = pool.getConnection();

			logger.fatal( "got connection" );

			Division div = null;

			try{
				// delete existing INI data from CCV2
				// delete existing INI data from CCV2
				String sql = "DELETE FROM tblChairs "
							+ "WHERE programid IN "
							+ "( "
							+ "SELECT divid FROM tblDivision WHERE (campus='UHMC' OR campus='WIN') "
							+ ")";

				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from tblChair");

				sql = "DELETE FROM tblDivision WHERE (campus='UHMC' OR campus='WIN')";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from Division");

				sql = "SELECT * FROM tblDivision WHERE (campus='UHMC' OR campus='WIN') ORDER BY divisioncode";
				ps = connER00014.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					int newId = 0;
					int oldId = rs.getInt("divid");
					String divcode = AseUtil.nullToBlank(rs.getString("divisioncode"));
					String divname = AseUtil.nullToBlank(rs.getString("divisionname"));
					String chair = AseUtil.nullToBlank(rs.getString("chairname"));
					String delegated = AseUtil.nullToBlank(rs.getString("delegated"));
					String thisCampus = AseUtil.nullToBlank(rs.getString("campus"));

					logger.fatal("processing - " + divcode + " at " + thisCampus);

					div = new Division(0,divcode,divname,thisCampus,chair,delegated);

					DivisionDB.insertDivision(conn,div);

					boolean debug = false;

					if (!debug){
						div = DivisionDB.getDivisionByCampusCode(conn,thisCampus,divcode);
						if (div != null){

							newId = div.getDivid();

							rowsAffected = 0;

							if (newId > 0){
								sql = "SELECT * FROM tblchairs WHERE programid=?";
								PreparedStatement ps2 = connER00014.prepareStatement(sql);
								ps2.setInt(1,oldId);
								ResultSet rs2 = ps2.executeQuery();
								while(rs2.next()){
									sql = "INSERT INTO tblChairs(programid,coursealpha) VALUES(?,?)";
									PreparedStatement ps3 = conn.prepareStatement(sql);
									ps3.setInt(1,newId);
									ps3.setString(2,AseUtil.nullToBlank(rs2.getString("coursealpha")));
									rowsAffected += ps3.executeUpdate();
									ps3.close();
								} // while
								rs2.close();
								ps2.close();
							}// update approval sequence

							logger.fatal("inserted " + rowsAffected + " rows for tblChairs");

						} // if ini

					} // debug

				} // while

				rs.close();
				ps.close();
			}
			catch(SQLException e){
				logger.fatal( "SQLException: " +  e.toString() );
			}
			finally{
				logger.fatal( "free connection" );

				pool.freeConnection(connER00014);

			}

			logger.fatal( "----------------------------- " );
		}
		catch (Exception e){
			logger.fatal( e.toString() );
		}

		return 0;
	}

	/**
	**/
	public static int importHelp(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		com.ase.aseutil.AsePool pool = null;

		Connection connER00014 = null;

		int rowsAffected = 0;

		try {
			logger.fatal( "----------------------------- " );

			logger.fatal( "obtaining broker" );

			String host = "THANH";
			String port = "1433";
			String driver = "net.sourceforge.jtds.jdbc.Driver";
			String url = "jdbc:jtds:sqlserver";
			String db = "er00014";
			String user = "ccusr";
			String password = "Snn1q0tw";

			String campus = "UHMC";

			url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

			pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,
															AseUtil.getCurrentDrive()
															+ ":\\tomcat\\webapps\\central\\logs\\er00014-importHelp.log",1.0,false,180,3);

			logger.fatal( "got broker" );

			logger.fatal( "obtaining connection" );

			connER00014 = pool.getConnection();

			logger.fatal( "got connection" );

			Division div = null;

			try{
				// delete existing INI data from CCV2
				// delete existing INI data from CCV2
				String sql = "DELETE FROM tblhelpidx WHERE (campus='UHMC' OR campus='WIN')";
				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.fatal("deleted " + rowsAffected + " rows from tblhelpidx");

				rowsAffected = 0;

				sql = "SELECT * FROM tblhelpidx WHERE (campus='UHMC' OR campus='WIN')";
				ps = connER00014.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					rowsAffected += HelpDB.insertHelp(conn,	new Help("",
													AseUtil.nullToBlank(rs.getString("category")),
													AseUtil.nullToBlank(rs.getString("title")),
													AseUtil.nullToBlank(rs.getString("subtitle")),
													"",
													AseUtil.nullToBlank(rs.getString("auditby")),
													AseUtil.nullToBlank(rs.getString("auditdate")),
													AseUtil.nullToBlank(rs.getString("campus")))
										);
				} // while

				logger.fatal("inserted " + rowsAffected + " rows for tblhelpidx");

				rs.close();
				ps.close();
			}
			catch(SQLException e){
				logger.fatal( "SQLException: " +  e.toString() );
			}
			finally{
				logger.fatal( "free connection" );

				pool.freeConnection(connER00014);

			}

			logger.fatal( "----------------------------- " );
		}
		catch (Exception e){
			logger.fatal( e.toString() );
		}

		return 0;
	}

	/**
	**/
	public static int importWIN(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		com.ase.aseutil.AsePool pool = null;

		Connection connER00014 = null;

		int rowsAffected = 0;

		try {
			logger.fatal( "----------------------------- " );

			logger.fatal( "obtaining broker" );

			String host = "THANH";
			String port = "1433";
			String driver = "net.sourceforge.jtds.jdbc.Driver";
			String url = "jdbc:jtds:sqlserver";
			String db = "win";
			String user = "ccusr";
			String password = "Snn1q0tw";

			String campus = "UHMC";

			url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

			pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,
															AseUtil.getCurrentDrive()
															+ ":\\tomcat\\webapps\\central\\logs\\er00014-importWin.log",1.0,false,180,3);

			logger.fatal( "got broker" );

			logger.fatal( "obtaining connection" );

			connER00014 = pool.getConnection();

			logger.fatal( "got connection" );

			try{
				//createHistoryIDWIN(connER00014);
				//fixCourseDate(connER00014);
				PreparedStatement ps = null;
				String sql = "DELETE FROM tblCampusData";
				ps.executeUpdate();
				ps.close();

				sql = "DELETE FROM tblCourse";
				ps.executeUpdate();
				ps.close();

				sql = "DELETE FROM tblCourseARC";
				ps.executeUpdate();
				ps.close();

				sql = "DELETE FROM tblXref";
				ps.executeUpdate();
				ps.close();

				/*
				1) with all data in place, copy to course

				INSERT INTO tblCourse(historyid, CourseDate, id, campus, coursetype, courseAlpha, courseDescr, courseNum, courseTitle, X15, X16, X17, credits, maxcredit, [repeatable], hoursperweek, crosslisted, proposer, X76, X22, gradingoptions, X43, X19, X33, X23, X77, X34, X39, X37, X38, X42, X49, X48, x50, X36)
				SELECT  historyid, CourseDate, historyid, 'WIN' AS Expr1, [status], Alpha, [Description], Number, Title, [Pre-Requisite], [Co-Requisite], [Recommended Prep], credits, [Credits-Upper], [Repeatable], [Contact Hours], CrossList, UPPER([Proposer]) AS proposer, Justficiation, Materials, [Grading Options], Competencies, [Course Content], Actitivies, Evaluation, Grading, Costs, [Equivalent UH], [Similar in CCs], [Similar at UH], [Similar to Upper], [Currently Articulated], [Strategic Plan], Staff, Budget
				FROM WinCourses2;

				2) make sure the campus is correct
				UPDATE tblCourse SET campus='WIN';

				3) data specific clean up
				UPDATE tblCourse SET progress = 'ARCHIVED' WHERE coursetype='ARC';
				UPDATE tblCourse SET progress = 'APPROVED' WHERE coursetype='CUR';
				UPDATE tblCourse SET progress = 'MODIFY' WHERE coursetype='PRE';
				UPDATE tblCourse SET repeatable = 0 WHERE repeatable is null ;

				4) put ARC where it belongs
				INSERT INTO [tblCourseARC] ( id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits, repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate, auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60, X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst, votesabstain, route )
				SELECT id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits, repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate, auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60, X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst, votesabstain, route
				FROM tblCourse
				WHERE campus='WIN' AND CourseType='ARC';

				5) clean up
				DELETE FROM tblCourse WHERE campus='WIN' AND coursetype='ARC';

				6) campus data
				INSERT INTO tblCampusData (historyid,campus, courseAlpha, courseNum, Coursetype,
				C19, C6, C45, C46, C47, C48, C50, C51, C52, C53, C54, auditby )
				SELECT historyid, 'WIN', Alpha, Number, [Status],
				[Repeatable], Notes, [Assessment Year], Evaluation, Budget, [Course URL], [SLO for Gen ED], Resources, Certificates, [Credits towards the AA], [AA Degree], 'SYSADM'
				FROM         WinCourses2


				*/


			}
			catch(SQLException e){
				logger.fatal( "SQLException: " +  e.toString() );
			}
			finally{
				logger.fatal( "free connection" );

				if (connER00014 != null)
					pool.freeConnection(connER00014);

			}

			logger.fatal( "----------------------------- " );
		}
		catch (Exception e){
			logger.fatal( e.toString() );
		}

		return 0;
	}

	/**
	*	creates the data for import to main course and campus
	**/
	public static int fixCourseDate(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			String table = "WinCourses2";

			System.out.println("----------------------------- START");

			String sql = "SELECT [date],seq FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String date = AseUtil.nullToBlank(rs.getString("date"));
				int seq = rs.getInt("seq");
				if (seq > 0 && !date.equals("0000-00-00 00:00:00")){
					if (!date.equals("0000-00-00 00:00:00")){
						//date = null;
					}
					else{
						date = null;
					} // date

					sql = "UPDATE " + table + " SET coursedate=? WHERE seq=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,date);
					ps2.setInt(2,seq);
					rowsAffected += ps2.executeUpdate();
					System.out.println(seq);

				} // seq
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	/**
	*	creates the data for import to main course and campus
	**/
	public static int createHistoryIDWIN(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			String table = "WinCourses2";

			System.out.println("----------------------------- START");

			String sql = "SELECT seq FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				if (seq > 0){
					String kix = SQLUtil.createHistoryID(1) + seq;
					sql = "UPDATE " + table + " SET historyid=? WHERE seq=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setInt(2,seq);
					rowsAffected += ps2.executeUpdate();
					System.out.println(seq);
				}
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

