<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

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

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAU";
	String alpha = "ITE";
	String num = "390E";
	String type = "ARC";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "H28j30b1334";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{

			campus = "HAW";
			alpha = "ACC";
			num = "358";
			kix = "";
			type = "PRE";
			user = "THANHG";

			out.println(createSkill(conn,"C","Cognitive Skill") + "<br>");
			out.println(createSkill(conn,"GM","Gross Motor Skill") + "<br>");
			out.println(createSkill(conn,"L","Language Skill") + "<br>");
			out.println(createSkill(conn,"S","Social and Emotional Skill") + "<br>");
			out.println(createSkill(conn,"FM","Fine Motor Skill") + "<br>");
			out.println(createSkill(conn,"SH","Self-Help Skill") + "<br>");
			out.println(createSkill(conn,"C/RL.C","Cognitive/Receptive Language Skill") + "<br>");

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static String createSkill(Connection conn,String skill,String longname) {

Logger logger = Logger.getLogger("test");

		StringBuffer contents = new StringBuffer();

		int counter = 0;
		String content = "";
		String line = null;
		String rowColor = "#ffffff";

		try{

			//
			// file header
			//
			File aFile = new File("C:\\inetpub\\wwwroot\\learn\\skills\\skills_header.txt");
			BufferedReader skills_header = new BufferedReader(new FileReader(aFile));
			try {
				line = null; // not declared within while loop
				/*
				 * readLine is a bit quirky : it returns the content of a line
				 * MINUS the newline. it returns null only for the END of the
				 * stream. it returns an empty String if two newlines appear in
				 * a row.
				 */
				while ((line = skills_header.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}
			} finally {
				skills_header.close();
			}
			aFile = null;

			//
			// file content
			//
			String temp = "<h2>" + longname + "</h2>";
			contents.append(temp);

			temp = "</blockquote></blockquote></blockquote>";
			contents.append(temp);

			temp = "<table border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">";
			contents.append(temp);

			String sql = "SELECT skillid, s_skillid, title FROM tblSkills WHERE s_letter=? ORDER BY num";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,skill);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				if (counter % 2 == 1){
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				}
				else{
					rowColor = Constant.ODD_ROW_BGCOLOR;
				}

				String skillid = rs.getString("skillid");
				String s_skillid = rs.getString("s_skillid");
				String title = AseUtil.nullToBlank(rs.getString("title"));
				contents.append("<tr bgcolor='"+rowColor+"'>"
					+ "<td valign='top' width='03%'></td>"
					+ "<td valign='top' width='17%'>"
					+ "<font face='verdana, arial, helvetica' size='2'>"
					+ "<a href='used.asp?cat="+skillid+"'><img src='images/skills.gif' border=0></a>"
					+ "&nbsp;<a href='skills3.asp?cat=skills_" + skill + "&cid="+skillid+"' class=\"linkcolumn\">"+s_skillid+"</a></font></td>"
					+ "<td  valign='top' width='80%'>"
					+ "<font face='verdana, arial, helvetica' size='2'>"+title+"</font>"
					+ "</td></tr>");
				++counter;
			}
			rs.close();
			ps.close();

			//
			// file footer
			//
			aFile = new File("C:\\inetpub\\wwwroot\\learn\\skills\\skills_footer.txt");
			BufferedReader skills_footer = new BufferedReader(new FileReader(aFile));
			try {
				line = null; // not declared within while loop
				/*
				 * readLine is a bit quirky : it returns the content of a line
				 * MINUS the newline. it returns null only for the END of the
				 * stream. it returns an empty String if two newlines appear in
				 * a row.
				 */
				while ((line = skills_footer.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}
			} finally {
				skills_footer.close();
			}
			aFile = null;

			//
			// write output file
			//
			String skillfilename = skill.replace("/","").replace(".","").toLowerCase();
			FileWriter fstream = new FileWriter("C:\\inetpub\\wwwroot\\learn\\skills_" + skillfilename + ".html");
			BufferedWriter output = new BufferedWriter(fstream);
			output.write(contents.toString());
			output.close();

		} catch (IOException e) {
			logger.fatal("createSkill IOException: " + e.toString());
		} catch (Exception e) {
			logger.fatal("createSkill Exception: " + e.toString());
		}

		return "Written " + counter + " '" + skill + "' skills";

	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
