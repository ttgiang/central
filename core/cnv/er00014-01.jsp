<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

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

		/*
		INSERT INTO BannerDept (dept_code,DEPT_description) VALUES('APT','APT');
		INSERT INTO BannerDept (dept_code,DEPT_description) VALUES('ADMIN','Administrative');

		INSERT INTO BannerAlpha (course_alpha,alpha_description) VALUES('APT','APT');
		INSERT INTO BannerAlpha (course_alpha,alpha_description) VALUES('ADMIN','Administrative');

		INSERT INTO BannerDivision (division_code,divs_description) VALUES('APT','APT');
		INSERT INTO BannerDivision (division_code,divs_description) VALUES('ADMIN','Administrative');

		INSERT INTO bannerdivision(division_code,divs_description) VALUES('ENG','Engineering');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('TAHR','Tropical Agriculture & Human Resources');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('ARCH','Architecture');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('HAWN','Hawaiian Knowledge');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('LAW','Law');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('MED','Medicine');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('NURS','Nursing & Dental Hygiene');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('OCN','Ocean & Earth Science & Technology');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('PAS','Pacific & Asian Studies');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('SW','Social Work');
		INSERT INTO bannerdivision(division_code,divs_description) VALUES('TIM','Travel Industry Management');
		*/

		int x = 0;
		String campuses = CampusDB.getCampusNames(conn);
		String[] aCampuses = campuses.split(",");

		out.println(++counter + ". Add missing campus settings" + Html.BR());
		createMissingSettingForCampus(conn,"TTG",user);

		out.println(++counter + ". Add missing campus settings" + Html.BR());
		out.println("<ul>");
		for(x=0; x<aCampuses.length; x++){
			out.println("<li>" + IniDB.createMissingSettingForCampus(conn,aCampuses[x],user) + "</li>");
		}
		out.println("</ul>");

		out.println(++counter + ". Resequence program items" + Html.BR());
		out.println("<ul>");
		for(x=0; x<aCampuses.length; x++){
			out.println("<li>" + QuestionDB.resequenceItems(conn,"p",campus,user) + "</li>");
		}
		out.println("</ul>");

		out.println(++counter + ". Resequence course items" + Html.BR());
		out.println("<ul>");
		for(x=0; x<aCampuses.length; x++){
			out.println("<li>" + QuestionDB.resequenceItems(conn,"r",campus,user) + "</li>");
		}
		out.println("</ul>");

		out.println(++counter + ". Resequence campus items" + Html.BR());
		out.println("<ul>");
		for(x=0; x<aCampuses.length; x++){
			out.println("<li>" + QuestionDB.resequenceItems(conn,"c",campus,user) + "</li>");
		}
		out.println("</ul>");
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static int addUsersFromWinMau(Connection conn) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "SELECT DISTINCT campus,userid FROM ztblUsers01 ORDER BY campus,userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String userid = AseUtil.nullToBlank(rs.getString("userid"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));

				if(UserDB.isMatch(conn,userid,campus)){
					logger.info("cnvrt_ini - addUsersFromWinMau: " + userid);
				}
				else{
					addUsersFromWinMau02(conn,userid);
				}
				//
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("IniDB: addUsersFromWinMau - " + e.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: addUsersFromWinMau - " + e.toString());
		}

		return rowsAffected;
	}

	public static int addUsersFromWinMau02(Connection conn,String userid) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "INSERT INTO tblUsers (campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, "
						+ "department, division, email, LOCATION, PHONE, WebSite) "
						+ "SELECT campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, "
						+ "department, division, email, LOCATION, PHONE, WebSite "
						+ "FROM ztblUsers01 "
						+ "WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,userid);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("\n"
							+ "------------------------"
							+ "\n"
							+ "addUsersFromWinMau2 - "
							+ "\n"
							+ userid
							+ "\n"
							+ e.toString()
							+ "\n"
							+ "------------------------"
							);
		} catch (Exception e) {
			logger.fatal("addUsersFromWinMau2 - " + "\n" + userid + "\n" + e.toString());
		}

		return rowsAffected;
	}

	public static int createMissingSettingForCampus(Connection conn,String campus,String user) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String baseCampus = "KAP";

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
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

