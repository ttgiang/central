<%@ page import="org.apache.log4j.Logger"%>
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
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String alpha = "ICS";
	String alphax = "ICS";
	String num = "101";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String compid = "50";
	Comp comp = new Comp();
	String kix = "F52h22c9127";
	String hid = "F52h22c9127";
	int i = 0;

	out.println("Start<br>");

	out.println("<br>---------------------------------------------insertText<br>");
	Text text = new Text(kix,1,"title","edition","author","publisher","1999","isbn");
	//out.println(TextDB.insertText(conn,text));
	text = new Text(kix,2,"title","edition","author","publisher","1999","isbn");

	out.println("<br>---------------------------------------------insertText<br>");
	//out.println(TextDB.insertText(conn,text));

	out.println("<br>---------------------------------------------deleteText<br>");
	out.println(TextDB.deleteText(conn,kix,1));

	out.println("<br>---------------------------------------------getText<br>");
	out.println(TextDB.getText(conn,kix,2));

	out.println("<br>---------------------------------------------getTextAsHTMLList<br>");
	out.println(TextDB.getTextAsHTMLList(conn,kix));

	out.println("<br>---------------------------------------------getContentForEdit<br>");
	out.println(TextDB.getContentForEdit(conn,kix));

	out.println("<br>---------------------------------------------updateText<br>");
	text = new Text(kix,2,"title2","edition2","author2","publisher2","2000","isbn2");
	out.println(TextDB.updateText(conn,text));

	out.println("<br>---------------------------------------------showText<br>");
	out.println(showText(conn,campus,type));

	out.println("<br>");
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

<%!

	public static String showText(Connection conn,String campus,String type){

		Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String coursetitle = "";
		String author = "";
		String title = "";
		String edition = "";
		String publisher = "";
		String yeer = "";
		String isbn = "";
		boolean found = false;
		String temp = "";

		String holdAlpha = "";

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT tc.coursealpha,tc.coursenum,tc.coursetitle, "
				+ "tt.Title, tt.Edition,tt.Author,tt.Publisher,tt.yeer,tt.ISBN "
				+ "FROM tblCourse tc, tbltext tt "
				+ "WHERE tc.campus=? AND "
				+ "tc.coursetype=? AND "
				+ "tc.historyid=tt.historyid "
				+ "ORDER BY tc.coursealpha,tc.coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
				coursetitle = aseUtil.nullToBlank(rs.getString("coursetitle")).trim().toUpperCase();
				author = aseUtil.nullToBlank(rs.getString("author")).trim();
				title = aseUtil.nullToBlank(rs.getString("title")).trim();
				edition = aseUtil.nullToBlank(rs.getString("edition")).trim();
				publisher = aseUtil.nullToBlank(rs.getString("publisher")).trim();
				yeer = aseUtil.nullToBlank(rs.getString("yeer")).trim();
				isbn = aseUtil.nullToBlank(rs.getString("isbn")).trim();

				if ("".equals(holdAlpha) || !alpha.equals(holdAlpha)){
					holdAlpha = alpha;
				}
				else{
					alpha = "";
				}

				listing.append("<tr class=\"\">"
					+ "<td valign=\"top\" class=\"datacolumn\">" + alpha + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + num + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + coursetitle + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + author + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + title + "</td></tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>"
					+ "<tr class=\"textblackTRTheme\">"
					+ "<td width=\"05%\" valign=\"top\" class=\"textblackTH\">Alpha</td>"
					+ "<td width=\"05%\" valign=\"top\" class=\"textblackTH\">Num</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Course Title</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Author</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Book Title</td></tr>"
					+ listing.toString()
					+ "</table>";
			}
		}
		catch(Exception ex){
			logger.fatal("TextDB: showText\n" + ex.toString());
		}

		return temp;
	}

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
