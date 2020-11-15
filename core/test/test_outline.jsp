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
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String num = "241";
	String user = "THANHG";

	String toAlpha = "ICS";
	String toNum = "269";

	int option = 3;

	out.println(getCourseDates(conn,"o58j27l852"));

	asePool.freeConnection(conn);
%>

<%!

	public static String[] getCourseDates(Connection connection,String hid) throws SQLException {

		Logger logger = Logger.getLogger("test");

		final int TOTALCOLUMNS = 9;
		String sql = "";
		String[] temp = new String[TOTALCOLUMNS];
		PreparedStatement ps = null;

		/*
			by default, we want to show the CUR progress. However, if the outline is going
			through modifications, use that instead.

			to get the PRE entry, look up the alpha and number for the CUR entry and do a
			reverse look up for the HID.
		*/

		try {
			AseUtil aseUtil = new AseUtil();
			String[] info = Helper.getKixInfo(connection,hid);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];

			if (courseExistByTypeCampus(connection,campus,alpha,num,"PRE")){
				 hid = Helper.getKix(connection,campus,alpha,num,"PRE");
			}

			sql = "SELECT U.fullname,C.Progress,C.dateproposed,B.TERM_DESCRIPTION," +
				"C.reviewdate,C.assessmentdate,C.coursedate,C.auditdate,C.reason " +
				"FROM (tblCourse C INNER JOIN tblUsers U ON C.proposer = U.userid) " +
				"INNER JOIN BannerTerms B ON C.effectiveterm = B.TERM_CODE " +
				"WHERE C.historyid=?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, hid);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				temp[0] = aseUtil.nullToBlank(results.getString(1));
				temp[1] = aseUtil.nullToBlank(results.getString(2));
				temp[2] = aseUtil.ASE_FormatDateTime(results.getString(3),6);
				temp[3] = aseUtil.nullToBlank(results.getString(4));
				temp[4] = aseUtil.ASE_FormatDateTime(results.getString(5),6);
				temp[5] = aseUtil.ASE_FormatDateTime(results.getString(6),6);
				temp[6] = aseUtil.ASE_FormatDateTime(results.getString(7),6);
				temp[7] = aseUtil.ASE_FormatDateTime(results.getString(8),6);
				temp[8] = aseUtil.nullToBlank(results.getString(9));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseDates\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDates\n" + ex.toString());
		}

		return temp;
	}

%>
