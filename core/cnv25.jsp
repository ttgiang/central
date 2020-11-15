<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/cnv25.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	/*
		GUI for catalog design.

		works but requires a lot of fixing
	*/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	System.out.println("Start<br/>");

	String campus = "KAP";

	if (processPage){

		StringBuffer buf = new StringBuffer();

		String sql =
			"SELECT tc.questionnumber AS number, tc.questionseq AS seq, tc.question, cm.Question_Friendly AS friendly, cm.Question_Explain AS explain "
			+ "FROM tblCourseQuestions AS tc INNER JOIN "
			+ "CCCM6100 AS cm ON tc.questionnumber = cm.Question_Number "
			+ "WHERE tc.campus=? AND tc.include='Y' AND cm.campus='SYS' AND cm.type='Course' "
			+ "ORDER BY seq ";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			buf.append("<option value=''></option>");
			while(rs.next()){
				buf.append("<option value='"+rs.getString("friendly")+"'>" + rs.getInt("seq") + " - " + rs.getString("question") + "</option>");
			} // while
			rs.close();
			ps.close();

			if (out != null){
				out.println("<form name=\"aseForm\" method=\"post\" action=\"\">");

				out.println("<table width=\"100%\" border=\"0\">");

				out.println("<tr>");
				out.println("<td valign=\"top\" width=\"30%\">");
				out.println("<h3 class=\"goldhighlightsbold\">Questions</h3>");
				out.println("<select name='itemList' id='itemList' size=10 width=\"300\" style=\"width: 300px\">" + buf.toString() + "</select>");
				out.println("</td>");
				out.println("<td valign=\"top\" width=\"20%\">");
				out.println("<h3 class=\"goldhighlightsbold\">Formatting</h3>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"bold\">Bold<br>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"italics\">Italics<br>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"underline\">Underline<br>");
				out.println("</td>");
				out.println("<td valign=\"top\" width=\"20%\">");
				out.println("<h3 class=\"goldhighlightsbold\">Display</h3>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"omit\">Omit if empty<br>");
				out.println("<h3 class=\"goldhighlightsbold\">Other</h3>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"rtn\">Append RETURN<br>");
				out.println("<input type=\"checkbox\" value=\"1\"  name=\"spc\">Append SPACE<br>");
				out.println("</td>");
				out.println("<td valign=\"middle\" width=\"30%\">&nbsp;");
				out.println("<input type=\"submit\" value=\"Add to Template\" name=\"submit\" onClick=\"return addToTemplate();\">");
				out.println("</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td valign=\"top\" colspan=\"3\">");
				out.println("<p>&nbsp;</p><h3 class=\"goldhighlightsbold\">Template</h3>");
				out.println("<select name='templateList' id='templateList' size=10 width=\"100%\" style=\"width: 100%\"></select>");
				out.println("</td>");
				out.println("<td valign=\"middle\" width=\"30%\">&nbsp;");
				out.println("<input type=\"submit\" value=\"Remove from Template\" onClick=\"return removeFromTemplate();\">");
				out.println("</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td valign=\"top\" colspan=\"3\">");
				out.println("<p>&nbsp;</p><h3 class=\"goldhighlightsbold\">Sample</h3>");
				out.println("<div style=\"visibility:visible; border: 1px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"sample\">&nbsp;</div>");
				out.println("</td>");
				out.println("<td valign=\"middle\" width=\"30%\">&nbsp;");
				out.println("<input type=\"submit\" value=\"Save Template\"  name=\"submit\">");
				out.println("</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td valign=\"top\" colspan=\"3\">");
				out.println("<p>&nbsp;</p><h3 class=\"goldhighlightsbold\">Debug</h3>");
				out.println("<div style=\"visibility:visible; border: 1px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"debug\">&nbsp;</div>");
				out.println("</td>");
				out.println("<td valign=\"middle\" width=\"30%\">&nbsp;");
				out.println("<input type=\"submit\" value=\"Save Template\"  name=\"submit\">");
				out.println("</td>");
				out.println("</tr>");

				out.println("</table>");

				out.println("</form>");
			}

		}
		catch(Exception e){
			System.out.println("Test - testX: " + e.toString());
		}

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

		</td>
	</tr>
</table>

<script language="JavaScript" type="text/javascript">
	insertLine("coursealpha","coursealpha");
	insertLine("coursenum","coursenum");
	insertLine("coursetitle","coursetitle");
	insertLine("credits","credits");
	insertLine("coursedate","coursedate");
</script>

</body>
</html>

