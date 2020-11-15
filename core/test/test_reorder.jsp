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
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	out.println("Start<br/>");
	//out.println(reorderList(conn,Constant.COURSE_ITEM_PREREQ,"c11b23d9188"));
	//out.println(reorderList(conn,Constant.COURSE_ITEM_COREQ,"c11b23d9188"));
	//out.println(reorderList(conn,Constant.COURSE_ITEM_SLO,"c11b23d9188"));
	//out.println(reorderList(conn,Constant.COURSE_ITEM_CONTENT,"c11b23d9188"));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static String reorderList(Connection conn,int list,String kix) throws Exception {

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int id = 0;
		long numberOfEntries = 0;
		int numberOfFields = 0;
		String sql = "";
		String alpha = "";
		String num = "";
		String grading = "";
		String temp = "";
		String campus = "";
		String fields = "";
		String order = "";
		String table = "";
		String[] columns;
		String[] data;
		String hiddenIds = "";

		if (!"".equals(kix)){
			String[] info = Helper.getKixInfo(conn,kix);
			campus = info[4];
		}

		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuffer buf = new StringBuffer();
		StringBuffer sel = new StringBuffer();

		switch(list){
			case Constant.COURSE_ITEM_PREREQ:
				fields = "id,prereqalpha,prereqnum,grading";
				order = "id";
				table = "tblPrereq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_COREQ:
				fields = "id,coreqalpha,coreqnum,grading";
				order = "id";
				table = "tblcoreq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_SLO:
				fields = "compid,comp";
				order = "compid";
				table = "tblcoursecomp";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_CONTENT:
				fields = "contentid,longcontent";
				order = "contentid";
				table = "tblcoursecontent";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
		}

		try {
			AseUtil au = new AseUtil();
			numberOfEntries = au.countRecords(conn,table,"WHERE historyid='"+kix+"'");
			if (numberOfEntries > 0){

				buf.append("<form name=\"aseForm\" method=\"post\" action=\"testx.jsp\">");
				buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
				buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>");

				// how many fields are we working with
				columns = fields.split(",");
				numberOfFields = columns.length;
				data = new String[numberOfFields];

				// create column header
				for(i=1;i<numberOfFields;i++){
					buf.append("<td valign=\"top\" class=\"textblackTH\">" + columns[i] + "</td>");
				}

				// create count of entries in drop down for selection
				for(i=1;i<=numberOfEntries;i++){
					sel.append("<option value=\""+i+"\">"+i+"</option>");
				}

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				rs = ps.executeQuery();
				while (rs.next()) {
					// collect data from result
					for(i=0;i<numberOfFields;i++){
						data[i] = au.nullToBlank(rs.getString(columns[i]));
					}

					if ("".equals(hiddenIds))
						hiddenIds = data[0];
					else
						hiddenIds += "," + data[0];

					// add list box to first column
					temp = "<select name=\"order_"+data[0]+"\" class=\"smalltext\">"
						+ "<option value=\"\"></option>"
						+ sel.toString()
						+ "</select>";

					// create data row
					buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
						+ temp
						+ "</td>");

					for(i=1;i<numberOfFields;i++){
						buf.append("<td valign=\"top\" class=\"dataColumn\">" + data[i] + "</td>");
					}
				}

				rs.close();
				ps.close();

				buf.append("</table>");
				buf.append("<input type=\"text\" name=\"kix\" value=\""+kix+"\">");
				buf.append("<input type=\"text\" name=\"campus\" value=\""+campus+"\">");
				buf.append("<input type=\"text\" name=\"list\" value=\""+list+"\">");
				buf.append("<input type=\"text\" name=\"ids\" value=\""+hiddenIds+"\">");
				buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Update\" class=\"inputsmallgray\">");
				buf.append("</form>");
			}
		} catch (SQLException se) {
			logger.fatal("CompDB: reorderList\n" + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("CompDB: reorderList\n" + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
