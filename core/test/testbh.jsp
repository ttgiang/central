<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">

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

	String campus = "UHMC";
	String alpha = "VIET";
	String num = "197F";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "o8l28i9166";
	String message = "";
	String url = "";
	String dst = "dst";

	if (processPage){
		try{

			String approvalSubmissionAsPacket = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");

//APPROVAL_PENDING_TEXT
out.println(showPrograms(conn,campus));


			//out.println(showSessionMappedKeys(session));
			//out.println(getSessionMappedKey(session,"PermitSharingOfSyllabi"));

			//out.println(showUserTasks(conn,"KAP",user));
			//out.println(showChildren(conn,39,7,0,0,137));
			//out.println(showChildren2(conn,40,0,0,100));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	asePool.freeConnection(conn,"","");
%>

<%!
	public static String showPrograms(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int i = 0;

		StringBuffer buf = new StringBuffer();

		String rowColor = "";

		String temp = "";

		String sql = "SELECT p.historyid, d.divisionname, p.effectivedate, p.title, p.outcomes, p.auditby, p.auditdate, p.seq, pd.descr "
						+ "FROM tblPrograms p INNER JOIN "
						+ "tblprogramdegree pd ON p.degreeid = pd.degreeid AND p.campus = pd.campus INNER JOIN "
						+ "tblDivision d ON p.campus = d.campus AND p.divisionid = d.divid "
						+ "WHERE p.auditby='THANHG' "
						+ "ORDER BY pd.descr,divisionname, p.title";

System.out.println(sql);

		try{

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String descr = AseUtil.nullToBlank(rs.getString("descr"));
				String divisionname = AseUtil.nullToBlank(rs.getString("divisionname"));
				String effectivedate = AseUtil.nullToBlank(rs.getString("effectivedate"));
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String outcomes = AseUtil.nullToBlank(rs.getString("outcomes"));

				if (++i % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr height=\"30\" valign=\"top\" bgcolor=\"" + rowColor + "\">"
					+ "<td class=\"datacolumn\">" + descr + "</td>"
					+ "<td class=\"datacolumn\">" + divisionname + "</td>"
					+ "<td class=\"datacolumn\">" + title + "</td>"
					+ "<td class=\"datacolumn\">" + effectivedate + "</td>"
					+ "<td class=\"datacolumn\">" + outcomes + "</td>"
					+ "</tr>");

			}
			rs.close();
			ps.close();

			temp = "<table class=\"" + campus + "BGColor\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
				+ "<tr class=\"" + campus + "BGColor\">"
				+ "<td width=\"15%\">Degree</td>"
				+ "<td width=\"15%\">Division Name</td>"
				+ "<td width=\"20%\">Title</td>"
				+ "<td width=\"10%\">Term</td>"
				+ "<td width=\"40%\">Outcomes</td>"
				+ "</tr>"
				+ buf.toString()
				+ "</table>";
		}
		catch(Exception e){
			logger.fatal("showSessionMappedKeys: " + e.toString());
		}

		return temp;

	}


	/**
	 * listModes
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int updateEnabledItems(Connection conn,String campus,String kix){

Logger logger = Logger.getLogger("test");

		String temp = null;
		String sql = null;

		String editSystem = null;
		String editCampus = null;

		String editSystemSeq = "";
		String editCampusSeq = "";

		String[] aEditSystem = null;
		String[] aEditCampus = null;

		int systemIndex = 0;
		int campusIndex = 0;

		String process = "MODIFY";
		String additionalQuestionNumberAsCSV = "";
		String item = null;
		int id = 0;

		int rowsAffected = -1;

		PreparedStatement ps = null;
		ResultSet rs = null;

		try{
			// what is being edited at this time
			editSystem = CourseDB.getCourseItem(conn,kix,"edit1");

			// make sure we have valid data as well as not all items are enabled
			if (editSystem != null && editSystem.length() > 0 && !"1".equals(editSystem)){

				System.out.println("ModeDB - updateEnabledItems - editSystem: " + editSystem);

				editCampus = CourseDB.getCourseItem(conn,kix,"edit2");
				System.out.println("ModeDB - updateEnabledItems - editCampus: " + editCampus);

				aEditSystem = editSystem.split(",");
				aEditCampus = editCampus.split(",");

				systemIndex = aEditSystem.length;
				campusIndex = aEditCampus.length;

				// extract enabled items from user selection and put into CSV
				for (int i = 0; i < systemIndex; i++){
					if (!"0".equals(aEditSystem[i])){
						if ("".equals(editSystemSeq))
							editSystemSeq = aEditSystem[i];
						else
							editSystemSeq = editSystemSeq + "," + aEditSystem[i];
					}
				}

				// with extracted items, find their friendly names
				// with each friendly name found, get the process id
				// with the process id, get the required items
				if (!"".equals(editSystemSeq)){
					System.out.println("ModeDB - updateEnabledItems - editSystemSeq: " + editSystemSeq);

					sql = "SELECT Field_Name "
						+ "FROM vw_CourseItems "
						+ "WHERE campus=? "
						+ "AND Seq IN ("+editSystemSeq+")";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					rs = ps.executeQuery();
					while(rs.next()){
						item = rs.getString("Field_Name");
						id = ModeDB.getIDByProcessAndItem(conn,campus,process,item);
						if (id > 0){
							additionalQuestionNumberAsCSV = ModeDB.additionalQuestionNumberAsCSV(conn,campus,id+"");
							editSystemSeq = editSystemSeq + "," + additionalQuestionNumberAsCSV;
						}
					}
					rs.close();
					ps.close();

					// list containing all items (enabled by user as well as required)
					editSystemSeq = Util.stringToArrayToStringInt(editSystemSeq,",",false);
					System.out.println("ModeDB - updateEnabledItems - editSystemSeq: " + editSystemSeq);

					// list of question numbers order by seq
					// example
					// 1,2,3,10,15,16,17,4,5,6,9,32,14,13,23,24,75,76,18,43,19,20,22,21,8,11,72,12,81,46,29,27,51,34,45,44,25,57,58,59,61,56,60,38,42,40,49,73,78,66
					String getCourseEnabledItemQuestionNumber = QuestionDB.getCourseEnabledItemQuestionNumber(conn,campus);
					System.out.println("ModeDB - updateEnabledItems - getCourseEnabledItemQuestionNumber: " + getCourseEnabledItemQuestionNumber);

					// Given editSystemSeq = 1,2,3,15,16,66,73,78 (question numbers)
					// locate the index in getCourseEnabledItemQuestionNumber for items enabled and
					// when found, the index of getCourseEnabledItemQuestionNumber is where the question
					// number is placed.
					// example, editSystemSeq value of 15 appears 5th in list represented by
					// getCourseEnabledItemQuestionNumber. If not found, replace with a zero
					// add the required sequences to the editable items

					String[] aEditSystemSeq = editSystemSeq.split(",");
					String[] aGetCourseEnabledItemQuestionNumber = getCourseEnabledItemQuestionNumber.split(",");

					int y = 0;
					boolean found = false;
					for(int x=0; x<aEditSystemSeq.length; x++){
						y = -1;
						found = false;
						while (!found && y<aGetCourseEnabledItemQuestionNumber.length){
							++y;
							if (aEditSystemSeq[x].equals(aGetCourseEnabledItemQuestionNumber[y])){
								found = true;
								aEditSystem[y] = aEditSystemSeq[x];
							}
						} // while
					} // for x

					editSystem = "";

					// combine all items into CSV
					for(y=0; y<aEditSystem.length; y++){
						if (y==0)
							editSystem = aEditSystem[y];
						else
							editSystem = editSystem + "," + aEditSystem[y];
					} // for

					// save to database
					rowsAffected = CourseDB.setCourseItem(conn,kix,"edit1",editSystem,"s");

				} // if aEditSystemSeq
			} // editSystemSeq != null && editSystemSeq.length() > 0
		}
		catch(SQLException ex ){
			logger.fatal("ModeDB: updateEnabledItems - " + ex.toString());
		}
		catch( Exception ex ){
			logger.fatal("ModeDB: updateEnabledItems - " + ex.toString());
		}

		return rowsAffected;
	}

	public static String test(Connection conn) throws Exception {

		String rtn = "";

		try {
			String sql = "SELECT c23 FROM tblCampusData WHERE historyid='X58h15j91602076'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				rtn = AseUtil.nullToBlank(rs.getString(1));
				if (rtn == null || rtn.length()==0)
					rtn = "";
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return rtn;
	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html>

