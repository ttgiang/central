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


SELECT     historyid, X18, X43, hoursperweek, x32
FROM         tblCourse
WHERE     (campus = 'KAP') AND (CourseType = 'CUR')

SELECT     C40, C41, C42, C43
FROM         tblCampusData
WHERE     (campus = 'KAP') AND (CourseType = 'CUR')

	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	out.println("Start<br/>");
	//
	// HIL
	//
	//out.println("fill cccm..." + fix06HIL(conn,"HIL") + " <br/>");
	//
	// KAP
	//
	//out.println("adjust edit1..." + fix01KAP(conn,"KAP") + " <br/>"); DO NOT USE
	//out.println("reverse data..." + fix02KAP(conn,"KAP") + " <br/>"); DO NOT USE
	//out.println("clear data..." + fix03KAP(conn,"KAP") + " <br/>");
	//out.println("fill data..." + fix04KAP(conn,"KAP") + " <br/>");
	//
	// LEE
	//
	//out.println("moving data..." + fix05LEE(conn,"LEE") + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**
	**
	*/
	public static int fix01KAP(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String historyid = "";
		String edit1 = "";

		try{
			String sql = "SELECT historyid,edit1 "
				+ "FROM tblCourse "
				+ "WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				edit1 = AseUtil.nullToBlank(rs.getString("edit1"));

				if (edit1.indexOf(",")>0){
					edit1 = edit1 + ",0";

					sql = "UPDATE tblCourse "
						+ "SET edit1=? "
						+ "WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,edit1);
					ps.setString(2,historyid);
					ps.executeUpdate();
					++rowsAffected;
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fix01KAP: fix01KAP\n" + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix01KAP: fix01KAP\n" + ex.toString());
		}

		return rowsAffected;
	}

	/*
	** slo to competencies
	** hoursperweek and contact hours
	*/
	public static int fix02KAP(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String historyid = "";
		String x18 = "";
		String hoursperweek = "";

		try{
			String sql = "SELECT historyid,x18,hoursperweek "
				+ "FROM tblCourse "
				+ "WHERE campus=? and coursetype='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				x18 = AseUtil.nullToBlank(rs.getString("x18"));
				hoursperweek = AseUtil.nullToBlank(rs.getString("hoursperweek"));

				sql = "UPDATE tblCourse "
					+ "SET x18=?,x43=?,hoursperweek=?,x32=? "
					+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,"");
				ps.setString(2,x18);
				ps.setString(3,"");
				ps.setString(4,hoursperweek);
				ps.setString(5,historyid);
				ps.executeUpdate();
				++rowsAffected;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fix01KAP: fix02KAP\n" + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix01KAP: fix02KAP\n" + ex.toString());
		}

		return rowsAffected;
	}

	/*
	** slo = ""
	** competency = ""
	** contact hours = ""
	** hoursperweek = ""
	** hoursperweek = ""
	*/
	public static int fix03KAP(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String historyid = "";
		String x18 = "";
		String hoursperweek = "";

		try{
			String sql = "SELECT historyid,x18,hoursperweek "
				+ "FROM tblCourse "
				+ "WHERE campus=? AND coursetype='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				x18 = AseUtil.nullToBlank(rs.getString("x18"));
				hoursperweek = AseUtil.nullToBlank(rs.getString("hoursperweek"));

				sql = "UPDATE tblCourse "
						+ "SET x18=?,x43=?,hoursperweek=?,x32=? "
						+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,"");
				ps.setString(2,x18);
				ps.setString(3,"");
				ps.setString(4,hoursperweek);
				ps.setString(5,historyid);
				ps.executeUpdate();
				++rowsAffected;
			}
		}
		catch(SQLException sx){
			logger.fatal("fix01KAP: fix03KAP" + historyid + " - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix01KAP: fix03KAP" + historyid + " - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	** slo = x18
	** competency = x43
	** contact hours = x32
	** hoursperweek = hoursperweek
	*/
	public static int fix04KAP(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String alpha = "";
		String num = "";
		String AAGEArea1;
		String AAGEExtra;
		String AAGEArea2;
		String ASGEExtra;
		String hoursperweek;

		try{
			String sql = "SELECT alpha, num, AAGEArea1, AAGEExtra, AAGEArea2, ASGEExtra, hoursperweek "
				+ "FROM kcc ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString("alpha"));
				num = AseUtil.nullToBlank(rs.getString("num"));
				AAGEArea1 = AseUtil.nullToBlank(rs.getString("AAGEArea1"));
				AAGEExtra = AseUtil.nullToBlank(rs.getString("AAGEExtra"));
				AAGEArea2 = AseUtil.nullToBlank(rs.getString("AAGEArea2"));
				ASGEExtra = AseUtil.nullToBlank(rs.getString("ASGEExtra"));
				hoursperweek = AseUtil.nullToBlank(rs.getString("hoursperweek"));

				sql = "UPDATE tblCampusData "
						+ "SET c40=?,c41=?,c42=?,c43=? "
						+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(sql);
				ps.setString(1,AAGEArea1);
				ps.setString(2,AAGEArea2);
				ps.setString(3,AAGEExtra);
				ps.setString(4,ASGEExtra);
				ps.setString(5,campus);
				ps.setString(6,alpha);
				ps.setString(7,num);
				ps.executeUpdate();

				sql = "UPDATE tblCourse "
						+ "SET x32=? "
						+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(sql);
				ps.setString(1,hoursperweek);
				ps.setString(2,campus);
				ps.setString(3,alpha);
				ps.setString(4,num);
				ps.executeUpdate();

				++rowsAffected;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fix01KAP: fix04KAP (" + alpha + " " + num + ") " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix01KAP: fix04KAP (" + alpha + " " + num + ") " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	** contact hours = x32
	** hoursperweek = hoursperweek
	**
	** moving hoursperweek to x80 (temp parking place)
	** moving x32 to hoursperweek
	*/
	public static int fix05LEE(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String alpha = "";
		String num = "";
		String historyid;
		String x32;
		String hoursperweek;
		String edit1 = "";

		try{
			String sql = "SELECT historyid,coursealpha,coursenum,x32,hoursperweek,edit1 "
				+ "FROM tblCourse "
				+ "WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				x32 = AseUtil.nullToBlank(rs.getString("x32"));
				hoursperweek = AseUtil.nullToBlank(rs.getString("hoursperweek"));
				edit1 = AseUtil.nullToBlank(rs.getString("edit1"));
				edit1 = edit1.replace("32","14");

				sql = "UPDATE tblCourse "
						+ "SET hoursperweek=?,x80=?,x32='',edit1=? "
						+ "WHERE campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,x32);
				ps.setString(2,hoursperweek);
				ps.setString(3,edit1);
				ps.setString(4,campus);
				ps.setString(5,historyid);
				ps.executeUpdate();

				++rowsAffected;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fix05LEE: fix05LEE (" + alpha + " " + num + ") " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix05LEE: fix05LEE (" + alpha + " " + num + ") " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	*/
	public static int fix06HIL(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int sequence = 0;
		String counter = "";
		String uhhilo;

		try{
			String sql = "SELECT counter,sequence,uhhilo "
				+ "FROM [cc-uhhil] ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				counter = AseUtil.nullToBlank(rs.getString("counter"));
				sequence = rs.getInt("sequence");
				uhhilo = AseUtil.nullToBlank(rs.getString("uhhilo"));

				sql = "UPDATE tblCourseQuestions "
						+ "SET include='Y',change='Y',questionseq=?,question=?,help=? "
						+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,sequence);
				ps.setString(2,uhhilo);
				ps.setString(3,uhhilo);
				ps.setString(4,campus);
				ps.setString(5,counter);
				ps.executeUpdate();

				++rowsAffected;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fix06HIL: fix06HIL (" + counter + ") " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix06HIL: fix06HIL (" + counter + ") " + ex.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

