<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.util.UUID"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String historyID = "";
	String id = "";

	try {
		// 1
		User usr = UserDB.getUserByName(conn, user);

		historyID = SQLUtil.createHistoryID(1);

		// 2
		sql = "INSERT INTO tblCourse(historyid,coursealpha,coursenum,proposer,coursetitle,campus,dispid,division) "
				+ "VALUES(?,?,?,?,?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, historyID);
		ps.setString(2, alpha);
		ps.setString(3, num);
		ps.setString(4, user);
		ps.setString(5, title);
		ps.setString(6, campus);
		ps.setString(7, usr.getDepartment());
		ps.setString(8, usr.getDivision());
		int rowsAffected = ps.executeUpdate();
		ps.close();

		// 3
		sql = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,auditby,campus) VALUES(?,?,?,?,?)";
		ps = conn.prepareStatement(sql);
		ps.setString(1, historyID);
		ps.setString(2, alpha);
		ps.setString(3, num);
		ps.setString(4, user);
		ps.setString(5, campus);
		rowsAffected = ps.executeUpdate();
		ps.close();

		// 4
		rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Modify outline",campus,"crscrt.jsp","ADD");
		AseUtil.logAction(conn, user, "crscrt.jsp", "Course created",alpha, num, campus);
		logger.info("CourseDB: createOutline completed");

		created = true;
	} catch (Exception e) {
		logger.fatal("CourseDB: createOutline\n" + e.toString());
		created = false;
	}

	asePool.freeConnection(conn);
%>

<%!

	/*
	 * createHistoryID <p> @return String
	 */
	public static void updateHistoryID(Connection conn,String historyID,String id) throws Exception {

		PreparedStatement ps;
		String sql = "UPDATE tblCourse SET id=? WHERE historyid=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, historyID);
		ps.setString(2,id);
		int rowsAffected = ps.executeUpdate();
		ps.close();
	}

	/*
	 * createHistoryID <p> @return String
	 */
	public static String createHistoryID3() throws Exception {

		UUID uuid = UUID.randomUUID();

		return "" + uuid;
	}

	/*
	 * createHistoryID <p> @return String
	 */
	public static String createHistoryID2() throws Exception {

		return "" + System.currentTimeMillis();
	}

	/*
	 * createHistoryID <p> @return String
	 */
	public static String createHistoryID(String id) throws Exception {

		String historyID = "";
		String alpha = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
		String[] alphaArray = alpha.split(",");

		try {
			Calendar cal = new GregorianCalendar();

			// Get the components of the date
			// int era = cal.get(Calendar.ERA); 		// 0=BC, 1=AD
			int year = cal.get(Calendar.YEAR); 			// 2002
			int year2 = year - 2000;
			int month = cal.get(Calendar.MONTH) + 1;	// 0=Jan, 1=Feb, ...
			int day = cal.get(Calendar.DAY_OF_MONTH); // 1...
			int hour = cal.get(Calendar.HOUR);
			int min = cal.get(Calendar.MINUTE);
			int sec = cal.get(Calendar.SECOND);

			//historyID = "" + alphaArray[year2] + alphaArray[month] + alphaArray[day] + alphaArray[hour] + alphaArray[min] + alphaArray[sec];
			historyID = id + alphaArray[sec] + min + alphaArray[hour] + day + alphaArray[month] + year2;
			//historyID = "" + year2 + month + day + hour + min + sec;
		} catch (Exception e) {
			//logger.fatal("CourseDB: createHistoryID\n" + e.toString());
			historyID = "";
		}

		return historyID;
	}

%>