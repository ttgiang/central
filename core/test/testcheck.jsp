<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	testcheck.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";

	out.println("Start<br>");
	//out.println(fixChecks(conn,campus,"grading","gradingoptions"));
	//out.println(fixChecks(conn,campus,"ContactHrs","hoursperweek"));
	//out.println(fixChecks(conn,campus,"MethodEval","X23"));
	//out.println(fixChecks(conn,campus,"MethodInst","X24"));
	//out.println(fixChecks(conn,campus,"Expectations","X56"));
	//out.println(fixChecks(conn,campus,"MethodDelivery","X68"));
	//out.println(fixChecks(conn,campus,"semester","semester"));
	out.println("End<br>");

    //ComputerProject 127,38
    //HomeworkAssignment 125,40
    //PracticeLabTime 131,41
    //RehearsalTime 129,42
    //ResearchProject 126,43
    //TermPapers 128,44

	asePool.freeConnection(conn);
%>

<%!

	public static String fixChecks(Connection conn,String campus,String iniItem,String courseItem) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String id = "";
		String kdesc = "";
		String temp = "";
		String historyid = "";

		String[] key;
		String[] value;

		int itemIndex = 0;
		int rowsAffected = 0;

		StringBuffer buf = new StringBuffer();

		boolean debug = true;

		try {

			buf.append("START-------------------------<br/>");
			buf.append("collecting INI items...<br/>");

			AseUtil ae = new AseUtil();

			// collect all values and ids for current values into array
			// example
			//
			// 172,173,174,175
			// FALL,SPRING,SUMMER,WINTER
			//
			sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category=? ORDER BY id";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,iniItem);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				temp = ae.nullToBlank(rs.getString("id"));
				if ("".equals(id))
					id = temp;
				else
					id = id + "," + temp;

				temp = ae.nullToBlank(rs.getString("kdesc"));
				if ("".equals(kdesc))
					kdesc = temp;
				else
					kdesc = kdesc + "," + temp;
			}
			rs.close();
			ps.close();

			key = id.split(",");
			value = kdesc.split(",");

			buf.append("INI items collected...<br/>");
			buf.append("key: " + id + "<br/>");
			buf.append("value: " + kdesc + "<br/>");

			// read course table for column to fix
			//
			// semester contains 1 of the following: FALL,SPRING,SUMMER,WINTER
			// look in the array of item values to find the matching key index
			// when found, update back to table course with new values
			buf.append("Collecting course items..." + "<br/>");
			sql = "SELECT historyid," + courseItem + " FROM tblCourse WHERE campus=? ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while (rs.next()){
				temp = ae.nullToBlank(rs.getString(courseItem));
				historyid = ae.nullToBlank(rs.getString("historyid"));
				if (!"".equals(temp) && kdesc.indexOf(temp)>=0){
					itemIndex =	Arrays.binarySearch(value,temp);
					if (debug){
						sql = "UPDATE tblCourse SET " + courseItem + "=? WHERE historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,key[itemIndex]);
						ps.setString(2,historyid);
						rowsAffected = ps.executeUpdate();
					}
					buf.append("updated " + rowsAffected + " row for " + courseItem + " to " + key[itemIndex] + " for historyid="+historyid + "<br/>");
				}
			}
			rs.close();
			ps.close();
			buf.append("Course items collected..." + "<br/>");
			buf.append("END-------------------------" + "<br/>");

		} catch (Exception e) {
			buf.append(e.toString() + "<br/>");
		}

		return buf.toString();
	}

%>

