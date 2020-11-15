<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Data Conversion";
	fieldsetTitle = "Data Conversion";
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
	*	prod - use this to process any data adjustment in prod during upgrades
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HAW";

	//
	// MAN = KRI; HAW = HTR
	//
	String historyCode = "HTR";

	if(campus.equals("MAN")){
		historyCode = "KRI";
	}

	System.out.println("Start<br/>");

	if (processPage){

		int opt = website.getRequestParameter(request,"opt",-1);

		// rerunning is OK
		boolean run = true;

		String[] spans = new String[201];
		for(int s=0; s<spans.length; s++){
			spans[s] = "";
		}
		if(opt>=0){
			spans[opt] = "highlights1";
		}

		String logImage = "<img src=\"../images/reviews2.gif\">";
		String configImage = "<img src=\"../images/config.gif\">";

		int idx = website.getRequestParameter(request,"idx",0);

		out.println("<ul>");

		out.println("<li>Processing");
		out.println("<ul>");
		out.println("<li>"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;Reset Page</li>");
		out.println("<li><span class=\""+spans[1]+"\"><a href=\"../R01_xlist.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=1\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R01 - Xlist</span></li>");
		out.println("<li><span class=\""+spans[7]+"\"><a href=\"../R07_grading.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=7\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R07 - Grading Options</span></li>");
		out.println("<li><span class=\""+spans[90]+"\"><a href=\"../R90_coreqs.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=90\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R90 - CoReqs</span></li>");
		out.println("<li><span class=\""+spans[98]+"\"><a href=\"../R98_outlines.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=98\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R98 - Refresh Outlines</span></li>");
		out.println("<li><span class=\""+spans[99]+"\"><a href=\"../R99_outlines.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=99\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R99 - Create Outlines</span></li>");
		out.println("</ul>");
		out.println("</li>");
		out.println("<br>");

		out.println("</ul>");

		String result = "";

		spans = null;

		//
		// import
		//
		if(run){

			if(idx > 0){
				opt = 99;
			}

			switch(opt){

				case 1: result = R1_R2_xlist(conn,campus); break;
				case 7: result = R7_GradingOptions(conn,campus); break;
				case 90: result = R90_coreqs(conn,campus); break;
				case 98: result = R98_outlines(conn,campus); break;
				case 99: result = R99_createHTML(campus,idx); break;

			} // switch

			out.println("<span class=\"highlights1\">" + result + "</span>" + Html.BR());

		} // run

	} // process

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * xlist
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R1_R2_xlist(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		String xa = "";
		String xn = "";

		boolean debug = false;

		try{

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R01_xlist.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			// append to where for testing
			String sql = "SELECT c.historyid, h.CRSE_SUBJ, h.CRSE_NUMBER, c.coursedate, h.CROSS_LST_CRSE "
				+ "FROM  tblCourse c INNER JOIN "
				+ "haw_xlist h ON c.CourseAlpha = h.CRSE_SUBJ AND c.CourseNum = h.CRSE_NUMBER "
				+ "WHERE (c.campus = 'HAW') AND (c.CourseType = 'CUR') AND (c.coursedate IS NULL OR c.coursedate = '') ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String xlist = AseUtil.nullToBlank(rs.getString("CROSS_LST_CRSE"));
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));

				String hid = AseUtil.nullToBlank(rs.getString("HistoryID"));
				String type = "CUR";

				String output = "";

				if(debug){
					System.out.println("01 - xlist: " + xlist);
					System.out.println("01 - hid: " + hid);
				}

				// start by looking for space between alpha and number
				// if there, we can process further
				if(xlist.contains(" ")){

					int pos = xlist.indexOf(" ");
					if(pos > 0){
						xa = xlist.substring(0,pos);
						xn = xlist.substring(pos+1);

						output = alpha + " " + num + " --> " + xa + " " + xn + "\r\n";
						if(debug) System.out.println("02 - output: " + output);

						//
						// ignore experimental
						//
						if(!xn.endsWith("97") && !xn.endsWith("98")){

							if(!xa.equals(alpha)){		// R1

								if(debug) System.out.println("03 - xlist");

								sql = "update tblcourse set " + Constant.COURSE_CROSSLISTED + "=1 where campus=? and coursealpha=? AND coursenum=? AND historyid=?";
								PreparedStatement ps3 = conn.prepareStatement(sql);
								ps3.setString(1,campus);
								ps3.setString(2,alpha);
								ps3.setString(3,num);
								ps3.setString(4,hid);
								rowsAffected = ps3.executeUpdate();
								ps3.close();

								//
								// addRemoveXlist is done here because we need to bypass DC approval
								//
								try{
									rowsAffected = addRemoveXlist(conn,hid,"a",campus,alpha,num,xa,xn,"",0,type);

									if(rowsAffected > 0){
										++processed;
										output = "Updated XList (" + hid + ") " + output;
									}
									else{
										output = "*** Not Updated XList (" + hid + "): " + output;
									}

								}
								catch(Exception e){
									//
								}

							}
							else{
								output = "R1 - not processed - SAME ALPHA: " + output;

								if(debug) System.out.println("04 - SAME ALPHA");

							} // cannot xlist to same alpha

						}
						else{
							output = "R1 - not processed - experimental: " + output;

							if(debug) System.out.println("04 - experimental");

						} // cannot xlist to same alpha

						out.write(output);

					} // still valid


				} // valid

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - xlist1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - xlist2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - xlist3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - xlist4: " + e.toString());
			}

		}

		junk = "R01_xlist: " + processed + " of " + read + " rows processed";

		if(errorsFound){
			junk = junk + " (errors found)";
		}

		return junk;

	}

	/**
	 * getKix
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String getKix(Connection conn,String campus,String alpha,String num,String type,String term){

		Logger logger = Logger.getLogger("test");

		String kix = "";

		try{
			String sql = "SELECT historyid FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND effectiveterm=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,term);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}

		return kix;
	}

	/*
	 * addRemoveXlist
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlist(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID,
													String type) throws SQLException {

		int rowsAffected = 0;
		boolean added = true;

		String sql = "SELECT coursealphax FROM tblxref " +
							"WHERE campus=? AND coursealpha=?  AND coursenum=?  AND coursetype=? " +
							"AND coursealphax=? AND coursenumx=? AND historyid=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, campus);
		ps.setString(2, alpha);
		ps.setString(3, num);
		ps.setString(4, type);
		ps.setString(5, alphax);
		ps.setString(6, numx);
		ps.setString(7, kix);
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			added = false;
			rowsAffected = -1;
		}
		rs.close();
		ps.close();

		if (added){
			rowsAffected = addRemoveXlistX(connection,kix,action,campus,alpha,num,alphax,numx,user,reqID,type);
		}

		return rowsAffected;
	}

	/*
	 * addRemoveXlistX
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * @param	type			String
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlistX(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID,
													String type) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean debug = false;

		int rowsAffected = 0;

		String sql = "INSERT INTO tblXref"
				+ " (coursealpha,coursenum,campus,coursetype,historyid,coursealphax,coursenumx,auditby,id,pending)"
				+ " VALUES(?,?,?,?,?,?,?,?,?,?)";

		try {
			boolean pending = false;

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, campus);
			ps.setString(4, type);
			ps.setString(5, kix);
			ps.setString(6, alphax);
			ps.setString(7, numx);
			ps.setString(8, user);
			ps.setInt(9, XRefDB.getNextID(connection));
			ps.setBoolean(10, pending);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("XRefDB: addRemoveXlistX - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("XRefDB: addRemoveXlistX - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * R7_GradingOptions
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R7_GradingOptions(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		try{

			String dataColumn = "GRADING_OPT";

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R07_grading.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			HashMap hashMap = new HashMap();

			// build key mapping for conversion
			String sql = "SELECT id, kid FROM tblINI WHERE campus=? AND category=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Grading");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int id = rs.getInt("id");
				String kid = AseUtil.nullToBlank(rs.getString("kid"));

				if(kid.equals("Credit/NoCredit only")){
					kid = "C";
				}
				else if(kid.equals("Credit_by_Exam")){
					kid = "M";
				}
				else if(kid.equals("N Grade")){
					kid = "L";
				}
				else if(kid.equals("Pass_NoPass")){
					kid = "P";
				}
				else if(kid.equals("Standard_Letter")){
					kid = "L";
				}

				hashMap.put(kid, new String(""+id));
			}
			rs.close();
			ps.close();

			String alpha = "";
			String num = "";
			String term = "";
			String kix = "";

			// 1) get course data from banner import
			// 2) find matching data from dup table and update
			sql = "SELECT DISTINCT c.historyid, h.CRSE_SUBJ, h.CRSE_NUMBER "
				+ "FROM tblCourse AS c INNER JOIN "
				+ "haw_grading AS h ON c.CourseAlpha = h.CRSE_SUBJ AND c.CourseNum = h.CRSE_NUMBER "
				+ "WHERE (c.campus = 'HAW') AND (c.CourseType = 'CUR') AND (c.coursedate IS NULL OR c.coursedate = '') ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){

				++read;

				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));

				String temp = "";
				String talin = "";

				// get data and start conversion
				sql = "SELECT distinct "+dataColumn+" from haw_grading where CRSE_SUBJ=? AND CRSE_NUMBER=? AND not "+dataColumn+" is null";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,alpha);
				ps2.setString(2,num);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){

					boolean process = true;

					//
					// what we can ignore
					//
					String value = AseUtil.nullToBlank(rs2.getString(dataColumn));
					if(value.equals("A")){
						process = false;
					}
					else if(value.equals("X")){
						process = false;
					}

					if (process){
						if (!hashMap.containsValue(value)){

							junk = nullToValue((String)hashMap.get(value),error);

							if(junk.contains(error)){
								junk = "*** " + value + " ***";
							}

							if(temp.equals(Constant.BLANK)){
								temp = "" + junk;
								talin = "" + value;
							}
							else{
								temp = temp + "," + junk;
								talin = talin +  "," + value;
							}
						}
						else{
							System.out.println("not found");
						}
					}
					else{
						out.write("--- ignore " + alpha + " - " + num + ": removed " + value + "\r\n");
					} // process


				} // while
				rs2.close();
				ps2.close();

				String output = kix + " - " + alpha + " - " + num + ": " + talin + "\r\n";

				// update if found
				if(!temp.equals(Constant.BLANK)){

					if(courseItems.contains("gradingoptions")){
						if(temp.contains(error)){
							output = "updated ("+dataColumn+" ERROR): " + output;
							errorsFound = true;
						}
						else{
							sql = "update tblcourse set gradingoptions=? where campus=? and historyid=? and coursealpha=? AND coursenum=?";
							PreparedStatement ps3 = conn.prepareStatement(sql);
							ps3.setString(1,temp);
							ps3.setString(2,campus);
							ps3.setString(3,kix);
							ps3.setString(4,alpha);
							ps3.setString(5,num);
							rowsAffected = ps3.executeUpdate();
							ps3.close();

							if(rowsAffected > 0){
								++processed;
								output = "updated: " + output;
							}
							else{
								output = "*** not updated: " + output;
							}
						}
					}
					else{
						output = "*** gradingoptions not used " + output;
					}

					out.write(output);

				} // update

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - R7_GradingOptions1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R7_GradingOptions2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R7_GradingOptions3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R7_GradingOptions4: " + e.toString());
			}

		}

		junk = "R07_GradingOptions: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * R90_coreqs
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R90_coreqs(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R90_coreqs.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT DISTINCT c.historyid, h.CRSE_SUBJ, h.CRSE_NUMBER "
				+ "FROM  tblCourse c INNER JOIN "
				+ "haw_coreq h ON c.CourseAlpha = h.CRSE_SUBJ AND c.CourseNum = h.CRSE_NUMBER "
				+ "WHERE (c.campus = 'HAW') AND (c.CourseType = 'CUR') AND (c.coursedate IS NULL OR c.coursedate = '') "
				+ "ORDER BY h.CRSE_SUBJ, h.CRSE_NUMBER";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String kix = AseUtil.nullToBlank(rs.getString("HistoryID"));

				sql = "SELECT DISTINCT CO_REQ_CRSE FROM haw_coreq WHERE CRSE_SUBJ='"+alpha+"' AND CRSE_NUMBER='"+num+"'";
				String coreq = SQLUtil.resultSetToCSV(conn,sql,"");

				if(coreq != null && coreq.length() > 0){

					String[] aCoreq = coreq.split(",");

					if(aCoreq.length > 1){
						coreq = coreq.replace(",", ", ");
						coreq = coreq.substring(0, coreq.lastIndexOf(",") + 2) + "and " + coreq.substring(coreq.lastIndexOf(",") + 2);
					}
				}

				sql = "update tblcampusdata set " + Constant.EXPLAIN_COREQ + "=? where campus=? and coursealpha=? AND coursenum=? AND historyid=?";
				PreparedStatement ps3 = conn.prepareStatement(sql);
				ps3.setString(1,coreq);
				ps3.setString(2,campus);
				ps3.setString(3,alpha);
				ps3.setString(4,num);
				ps3.setString(5,kix);
				rowsAffected = ps3.executeUpdate();
				ps3.close();

				String output = alpha + " " + num + " ---> " + coreq + "\r\n";

				if(rowsAffected > 0){
					++processed;
					output = "updated ("+kix+"): " + output;
				}
				else{
					output = "*** not updated ("+kix+"): " + output;
				}

				out.write(output);

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - coreqs1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - coreqs2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - coreqs3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - coreqs4: " + e.toString());
			}

		}

		junk = "R90_coreqs: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToValue(String val,String defalt) {

		if (val==null || val.equals("null") || val.length()== 0)
			val = defalt;

		if (val.length() > 0)
			val = val.trim();

		return val;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static int nullToValue(int val,int defalt) {

		int temp = 0;

		if (Integer.toString(val) == null)
			temp = defalt;
		else
			temp = val;

		return temp;
	}

	/*
	 * outlines
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R98_outlines(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R98_outlines.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT DISTINCT tc.historyid, tc.CourseAlpha, tc.CourseNum, tc.coursetitle "
				+ "FROM haw h INNER JOIN tblCourse tc ON h.CRSE_SUBJ = tc.CourseAlpha AND h.CRSE_NUMBER = tc.CourseNum "
				+ "WHERE (tc.campus = 'HAW') AND (tc.CourseType = 'CUR') AND (tc.coursedate IS NULL) "
				+ "ORDER BY tc.CourseAlpha, tc.CourseNum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));

				CampusDB.updateCampusOutline(conn,kix,campus);

				out.write("Refreshed outline ("+kix+"): " + alpha + " " + num + " - " + coursetitle + " ("+kix+")\n");

				++processed;

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - outlines1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - outlines2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - outlines3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - outlines4: " + e.toString());
			}

		}

		return "R98_outlines outlines: " + processed + " of " + read + " rows processed";

	}

	/**
	*
	*	R99_createHTML
	*
	**/
	public static String R99_createHTML(String campus,int idx){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		Writer out = null;

		try{
			conn = AsePool.createLongConnection();

			if (conn != null){

				out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R99_outlines.txt"));
				out.write("campus: " + campus + "\n");
				out.write("------------\n");

				String sql = "SELECT DISTINCT tc.historyid, tc.CourseAlpha, tc.CourseNum, tc.coursetitle "
					+ "FROM haw h INNER JOIN tblCourse tc ON h.CRSE_SUBJ = tc.CourseAlpha AND h.CRSE_NUMBER = tc.CourseNum "
					+ "WHERE (tc.campus = 'HAW') AND (tc.CourseType = 'CUR') AND (tc.coursedate IS NULL) "
					+ "ORDER BY tc.CourseAlpha, tc.CourseNum";

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){

					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));

					Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

					out.write("Create outline ("+kix+"): " + alpha + " " + num + " - " + coursetitle + " ("+kix+")\n");

					++rowsAffected;
				} // while
				rs.close();
				ps.close();

			}	// if conn

		}
		catch(SQLException sx){
			logger.fatal("extract: createHTML - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("extract: createHTML - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("extract: createHTML - " + e.toString());
			}
		}

		return "R99_createHtml completed: " + rowsAffected + " rows";

	} // createHTML

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>