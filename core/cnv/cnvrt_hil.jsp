<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.AseUtil"%>

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

	String campus = "HIL";
	String user = "THANHG";

	out.println("Start<br/>");

	if (processPage){
		out.println(main(conn));
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"cnvrt_hil",user);
%>

<%!

	public static int main(Connection conn){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "SELECT * FROM tblCourseQuestionsHIL WHERE campus='HIL' ORDER BY questionnumber";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String campus = "HIL";
				String type = "Course";
				int questionnumber = rs.getInt("questionnumber");
				int questionseq = rs.getInt("questionseq");
				int len = rs.getInt("len");
				String question = AseUtil.nullToBlank(rs.getString("question"));
				String include = AseUtil.nullToBlank(rs.getString("include"));
				String change = AseUtil.nullToBlank(rs.getString("change"));
				String help = AseUtil.nullToBlank(rs.getString("help"));
				String auditby = AseUtil.nullToBlank(rs.getString("auditby"));
				String required = AseUtil.nullToBlank(rs.getString("required"));
				String helpfile = AseUtil.nullToBlank(rs.getString("helpfile"));
				String audiofile = AseUtil.nullToBlank(rs.getString("audiofile"));
				String defalt = AseUtil.nullToBlank(rs.getString("defalt"));
				String comments = AseUtil.nullToBlank(rs.getString("comments"));
				String counttext = AseUtil.nullToBlank(rs.getString("counttext"));
				String extra = AseUtil.nullToBlank(rs.getString("extra"));
				String permanent = AseUtil.nullToBlank(rs.getString("permanent"));
				String append = AseUtil.nullToBlank(rs.getString("append"));
				String headertext = AseUtil.nullToBlank(rs.getString("headertext"));

				sql = "update tblCourseQuestions "
					+ "set questionnumber=?,questionseq=?,len=?,question=?,include=?,change=?,help=?,auditby=?,required=?,helpfile=?,audiofile=?,defalt=?,comments=?,counttext=?,extra=?,[permanent]=?,append=?,headertext=? where campus='HIL' AND id=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,questionnumber);
				ps2.setInt(2,questionseq);
				ps2.setInt(3,len);
				ps2.setString(4,question);
				ps2.setString(5,include);
				ps2.setString(6,change);
				ps2.setString(7,help);
				ps2.setString(8,"KOMENAKA");
				ps2.setString(9,required);
				ps2.setString(10,helpfile);
				ps2.setString(11,audiofile);
				ps2.setString(12,defalt);
				ps2.setString(13,comments);
				ps2.setString(14,counttext);
				ps2.setString(15,extra);
				ps2.setString(16,permanent);
				ps2.setString(17,append);
				ps2.setString(18,headertext);
				ps2.setInt(19,id);
				rowsAffected += ps2.executeUpdate();
				ps2.close();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

