<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
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
		<form name="aseForm" action="testz.jsp" method="post">
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

	String campus = "LEE";
	String alpha = "MGT";
	String num = "125";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "255i7d119";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		process(conn);
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	/*

SELECT historyid,coursealpha,coursenum,proposer,auditdate
FROM tblCourse
WHERE campus='KAP'
AND progress<>'APPROVED'
AND proposer is null
ORDER BY coursealpha,coursenum

o9v22b91781736	ART	113	NULL	2009-01-16 16:35:00	Introduction to Drawing
o9v22b91941839	BOT	105	NULL	2009-01-16 16:35:00	Ethnobotany
o9v22b9612034	ESOL	90S	NULL	2009-01-16 16:35:00	Beginning ESOL (Spring)
o9v22b92252035	ESOL	91F	NULL	2009-01-16 16:35:00	Intermediate ESOL (Fall)
o9v22b91002038	ESOL	91S	NULL	2009-01-16 16:35:00	Intermediate ESOL (Spring)
o9v22b92202039	ESOL	92F	NULL	2009-01-16 16:35:00	High Intermediate ESOL (Fall)
o9v22b91332042	ESOL	92S	NULL	2009-01-16 16:35:00	High Intermediate ESOL (Spr)
o9v22b9852043	ESOL	94F	NULL	2009-01-16 16:35:00	Advanced ESOL (Fall)
o9v22b92222044	ESOL	94S	NULL	2009-01-16 16:35:00	Advanced ESOL (Spring)
o9v22b922112	HIST	288	NULL	2009-01-16 16:35:00	Survey of Pacific Islands Hist
o9v22b92102288	LAW	104	NULL	2009-01-16 16:35:00	Civil Investigation
a59h15j92074321	MATH	100	NULL	NULL	Survey of Mathematics
o9v22b9822345	MATH	115	NULL	2009-01-16 16:35:00	Statistics
o9v22b9452347	MATH	140	NULL	2009-01-16 16:35:00	Trigonometry/Analytic Geometry
o9v22b91282530	PHIL	110	NULL	2009-01-16 16:35:00	Introduction toDeductive Logic
o9v22b9942555	POLS	120	NULL	2009-01-16 16:35:00	Introduction to World Politics
o9v22b91122665	SP	151	NULL	2009-01-16 16:35:00	Personal and Public Speech

SELECT alpha,num,userid
FROM tbluserlog
WHERE historyid IN
(
SELECT historyid
FROM tblCourse
WHERE campus='KAP'
AND progress<>'APPROVED'
AND proposer is null
)
ORDER BY alpha,num


SELECT 'UPDATE tblCourse SET proposer='''+userid+''' WHERE coursealpha='''+alpha+''' AND coursenum='''+num+''' AND historyid='''+historyid+'''',
	alpha,num,userid,historyid
FROM tbluserlog
WHERE historyid IN
(
SELECT historyid
FROM tblCourse
WHERE campus='KAP'
AND progress<>'APPROVED'
AND proposer is null
)
ORDER BY alpha,num

65881	DIK	ACTION	Outline modification (EBUS 101)	EBUS	101	2010-05-17 13:49:00	KAP	o9v22b9711959
74352	AAMODT	ACTION	Outline modification (MUS 253)	MUS	253	2010-09-07 12:11:00	KAP	o9v22b91742465
89114	WIGHT	ACTION	Outline modification (HAW 101)	HAW	101	2010-10-01 15:26:00	KAP	o9v22b92312091
95223	SOOAH	ACTION	Outline modification (KOR 102)	KOR	102	2010-10-15 14:41:00	KAP	o9v22b91472273
96832	GARGIULO	ACTION	Outline modification (ART 297)	ART	297	2010-10-19 16:18:00	KAP	z22h25i92051014
108726	NAWAA	ACTION	Outline modification (HAW 102)	HAW	102	2010-11-04 14:09:00	KAP	o9v22b9602092
108732	NAWAA	ACTION	Outline modification (HAW 201)	HAW	201	2010-11-04 14:10:00	KAP	o9v22b92432093
123001	CHIGGINS	ACTION	Outline modification (HIST 284)	HIST	284	2010-12-29 14:16:00	KAP	o9v22b91212111
125564	AAMODT	ACTION	Outline modification (MUS 253)	MUS	253	2011-01-12 15:40:00	KAP	o9v22b91742465
125687	TAKASEC	ACTION	Outline modification (NURS 12)	NURS	12	2011-01-13 10:04:00	KAP	o9v22b91112468
125691	TAKASEC	ACTION	Outline modification (NURS 13)	NURS	13	2011-01-13 10:07:00	KAP	o9v22b9572473
125695	TAKASEC	ACTION	Outline modification (NURS 14)	NURS	14	2011-01-13 10:07:00	KAP	o9v22b92512474
126860	VOYCE	ACTION	Outline modification (OCN 201)	OCN	201	2011-01-18 12:19:00	KAP	o9v22b91162489
128744	VOGATA	ACTION	Outline modification (ED 294)	ED	294	2011-01-23 11:18:00	KAP	o9v22b91271978
128750	CORYELL	ACTION	Outline modification (DEAF 201)	DEAF	201	2011-01-23 11:24:00	KAP	o9v22b91751913
128824	CORYELL	ACTION	Outline modification (DEAF 202)	DEAF	202	2011-01-23 14:22:00	KAP	o9v22b92271914
131949	TREMONT	ACTION	Outline modification (ART 246)	ART	246	2011-01-28 12:05:00	KAP	o9v22b92141783
132983	CORYELL	ACTION	Outline modification (DEAF 294)	DEAF	294	2011-01-29 16:39:00	KAP	o9v22b9951915
140445	CHERYLSO	ACTION	Outline modification (ART 290)	ART	290	2011-02-14 11:10:00	KAP	o9v22b91011799

UPDATE tblCourse SET proposer='TREMONT' WHERE coursealpha='ART' AND coursenum='246' AND historyid='o9v22b92141783';
UPDATE tblCourse SET proposer='CHERYLSO' WHERE coursealpha='ART' AND coursenum='290' AND historyid='o9v22b91011799';
UPDATE tblCourse SET proposer='GARGIULO' WHERE coursealpha='ART' AND coursenum='297' AND historyid='z22h25i92051014';
UPDATE tblCourse SET proposer='CORYELL' WHERE coursealpha='DEAF' AND coursenum='201' AND historyid='o9v22b91751913';
UPDATE tblCourse SET proposer='CORYELL' WHERE coursealpha='DEAF' AND coursenum='202' AND historyid='o9v22b92271914';
UPDATE tblCourse SET proposer='CORYELL' WHERE coursealpha='DEAF' AND coursenum='294' AND historyid='o9v22b9951915';
UPDATE tblCourse SET proposer='DIK' WHERE coursealpha='EBUS' AND coursenum='101' AND historyid='o9v22b9711959';
UPDATE tblCourse SET proposer='VOGATA' WHERE coursealpha='ED' AND coursenum='294' AND historyid='o9v22b91271978';
UPDATE tblCourse SET proposer='WIGHT' WHERE coursealpha='HAW' AND coursenum='101' AND historyid='o9v22b92312091';
UPDATE tblCourse SET proposer='NAWAA' WHERE coursealpha='HAW' AND coursenum='102' AND historyid='o9v22b9602092';
UPDATE tblCourse SET proposer='NAWAA' WHERE coursealpha='HAW' AND coursenum='201' AND historyid='o9v22b92432093';
UPDATE tblCourse SET proposer='CHIGGINS' WHERE coursealpha='HIST' AND coursenum='284' AND historyid='o9v22b91212111';
UPDATE tblCourse SET proposer='SOOAH' WHERE coursealpha='KOR' AND coursenum='102' AND historyid='o9v22b91472273';
UPDATE tblCourse SET proposer='AAMODT' WHERE coursealpha='MUS' AND coursenum='253' AND historyid='o9v22b91742465';
UPDATE tblCourse SET proposer='AAMODT' WHERE coursealpha='MUS' AND coursenum='253' AND historyid='o9v22b91742465';
UPDATE tblCourse SET proposer='TAKASEC' WHERE coursealpha='NURS' AND coursenum='12' AND historyid='o9v22b91112468';
UPDATE tblCourse SET proposer='TAKASEC' WHERE coursealpha='NURS' AND coursenum='13' AND historyid='o9v22b9572473';
UPDATE tblCourse SET proposer='TAKASEC' WHERE coursealpha='NURS' AND coursenum='14' AND historyid='o9v22b92512474';
UPDATE tblCourse SET proposer='VOYCE' WHERE coursealpha='OCN' AND coursenum='201' AND historyid='o9v22b91162489';

	*/

	/*
	 * findColumnName - returns all tables where the column name is found
	 * 					  returns as CSV
	 *	<p>
	 * @param	columnToFind	String
	 *	<p>
	 * @return String
	 */
	 public static void process(Connection conn){

Logger logger = Logger.getLogger("test");

		// locate all the courses without proposers
		// call process02 to find out which table(s) contain KIX for that course
		// if found, that's something to look at for proposer name in the auditby field

		try{
		String sql = "select core.* "
			+ "from "
			+ "( "
			+ "select historyid, coursealpha, coursenum, coursetype, proposer, progress, auditdate "
			+ "from tblcourse "
			+ "where campus='KAP' "
			+ "and progress <> 'APPROVED' "
			+ "and (proposer is null or proposer = '') "
			+ ") core ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String kix = rs.getString("historyid");
				process02(conn,kix);
			}
			rs.close();
			ps.close();

		}
		catch( SQLException e ){
			logger.fatal("Tables: findColumnName - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Tables: findColumnName - " + e.toString());
		}

		return;
	}

	 public static void process02(Connection conn,String kix){

		String tables = Tables.findColumnName("historyid");

		if (tables != null && tables.length() > 0){

			String[] table = tables.split(",");

			System.out.println("Kix: " + kix);
			System.out.println("-----------------------------------");

			for(int i=0; i<table.length; i++){
				if (table[i].toLowerCase().indexOf("temp") == -1){
					String where = "WHERE historyid='"+kix+"'";
					try{
						int rowsAffected = (int)countRecords(conn,table[i],where);
						if (rowsAffected > 0 && table[i].toLowerCase().indexOf("tblhtml") < 0){
							System.out.println(i + ". " + table[i] + " - " + rowsAffected);
						}
					}
					catch(Exception e){
						//
					}
				} // if
			} // for

			System.out.println("============================");

		} // if

		return;
	}

	/**
	 * Given a statement object, table and where clause, this function reports
	 * the number of records in a table.
	 * <p>
	 * @param conn 	Connection
	 * @param table 	String
	 * @param where	String
	 * <p>
	 * @return long
	 *
	 */
	public static long countRecords(Connection conn,String table,String where) {

Logger logger = Logger.getLogger("test");

		long lNumRecs = 0;

		/*
			do not include WHERE keyword in SQL statement. It's done at the point where it is called.
			we do this because it's possible that we don't do WHERE. We may use HAVING and so much
			more.
		*/

		String sql = "";

		try {
			Statement stmt = conn.createStatement();
			sql = "SELECT COUNT(0) FROM " + table + " " + where;
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
				lNumRecs = rs.getLong(1);
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			//logger.fatal("AseUtil - SQLException: countRecords - " + e.toString() + "\n" + sql);
		} catch (Exception e) {
			logger.fatal("AseUtil - Exception: countRecords - " + e.toString() + "\n" + sql);
		}

		return lNumRecs;
	}


%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>