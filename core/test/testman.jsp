<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.exception.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Assign History ID";
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "VIET";
	String num = "197Z";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "l30i20f10222&";
	String message = "";
	String url = "";

	out.println("Start<br/>");

	if (processPage){
		try{
			//out.println("MAN: " + createHistoryID(conn,"MAN") + Html.BR());

			//out.println("WIN: " + createHistoryID(conn,"WIN") + Html.BR());
			//out.println("WIN-ARC: " + createHistoryID(conn,"WIN_ARC") + Html.BR());

			// must change tables with ID from int to varchar(18)
			// ID and historyid are identical values

			//out.println("MAN: " + updateID(conn,"MAN") + Html.BR());

			//out.println("WIN: " + createHistoryID(conn,"WIN") + Html.BR());
			//out.println("WIN-ARC: " + createHistoryID(conn,"WIN_ARC") + Html.BR());

			//out.println("WIN: " + updateCampusDataWin(conn,"WIN") + Html.BR());
			//out.println("WIN-ARC: " + updateCampusDataWin(conn,"WIN_ARC") + Html.BR());

			// rename WIN and WIN_ARC ID to IDX for safe keeping
			// create ID as varchar(18), for campusdatawin, make id an int

			//out.println("WIN: " + updateID(conn,"WIN") + Html.BR());
			//out.println("WIN-ARC: " + updateID(conn,"WIN_ARC") + Html.BR());

			out.println("Campus Data: " + updateCampusDataWINID(conn) + Html.BR());

			// must start with data in tblCourse from above conversion

/*

DELETE from tblcampusdata WHERE campus='WIN';

INSERT INTO tblcampusdata(id,historyid,campus,coursealpha,coursenum,coursetype)
select id,historyid,campus,coursealpha,coursenum,coursetype
from tblcampusdataWIN

DELETE from tblCourse WHERE campus='WIN';

INSERT INTO tblCourse
                      (id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits,
                      repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate,
                      auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31,
                      X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60,
                      X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst,
                      votesabstain, route)
SELECT     id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits,
                      repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate,
                      auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31,
                      X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60,
                      X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst,
                      votesabstain, route
FROM         tblCourseWIN

DELETE from tblCourseARC WHERE campus='WIN';

INSERT INTO tblCourseARC
                      (id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits,
                      repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate,
                      auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31,
                      X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60,
                      X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst,
                      votesabstain, route)
SELECT     id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits,
                      repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate,
                      auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31,
                      X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60,
                      X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst,
                      votesabstain, route
FROM         tblCourseWIN_ARC

DELETE FROM tblCoursecomp WHERE campus='WIN'

*/

			//out.println("WIN COMP: " + updateWINComp(conn) + Html.BR());

			//out.println("Campus Data: " + updateCampusDataID(conn) + Html.BR());

		}
		catch(Exception ce){
			//System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static int updateCampusDataWin(Connection conn,String campus) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String table = "tblcourse" + campus;

			String sql = "SELECT id,historyid FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String key = rs.getString("historyid");
				int id = rs.getInt("id");
				sql = "UPDATE tblCampusDataWIN SET historyid=? WHERE id=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,key);
				ps2.setInt(2,id);
				rowsAffected += ps2.executeUpdate();
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	public static int updateCampusDataWINID(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String sql = "SELECT historyid FROM tblCampusDataWIN";

			System.out.println(sql);

			int maxID = getNextID(conn);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				maxID = maxID + 1;
				String kix = rs.getString("historyid");
				sql = "UPDATE tblCampusDataWIN SET id=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,maxID);
				ps2.setString(2,kix);
				rowsAffected += ps2.executeUpdate();
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	public static int createHistoryID(Connection conn,String campus) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String table = "tblcourse" + campus;

			String sql = "SELECT id FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int key = rs.getInt("id");
				if (key > 0){
					String kix = SQLUtil.createHistoryID(1) + key;
					sql = "UPDATE " + table + " SET historyid=? WHERE id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setInt(2,key);
					rowsAffected += ps2.executeUpdate();
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

	public static int updateID(Connection conn,String campus) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String table = "tblcourse" + campus;

			String sql = "SELECT historyid FROM " + table;

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String key = rs.getString("historyid");
				sql = "UPDATE " + table + " SET id=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,key);
				ps2.setString(2,key);
				rowsAffected += ps2.executeUpdate();
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	public static int updateWINComp(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String sql = "SELECT alpha,num,SLO FROM tblCourseCompWIN ORDER BY ID";

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String alpha = rs.getString("alpha");
				String num = rs.getString("num");
				String comp = rs.getString("SLO");
				String kix = Helper.getKix(conn,"WIN",alpha,num,"CUR");
				Msg msg = CompDB.addRemoveCourseComp(conn,"a","WIN",alpha,num,comp,0,"SYSADM",kix);
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNextID
	 *	<p>
	 *	@return int
	 */
	public static int getNextID(Connection conn) throws SQLException {

Logger logger = Logger.getLogger("test");

		int id = 0;

		try {
			String sql = "SELECT MAX(id) AS maxid FROM tblCampusData";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid") + 1;
			}

			if (id==0){
				id = 1;
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB: getNextID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB: getNextID - " + e.toString());
		}

		return id;
	}

	public static int updateCampusDataID(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String sql = "SELECT historyid FROM tblCampusData WHERE (campus='MAN' OR campus='WIN') AND id=0";

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kix = rs.getString("historyid");
				int maxID = getNextID(conn);
				sql = "UPDATE tblCampusData SET id=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,maxID);
				ps2.setString(2,kix);
				rowsAffected += ps2.executeUpdate();
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

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

