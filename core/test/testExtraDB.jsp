<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
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
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

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

	String campus = "HIL";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "u42k31i102";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(getOtherDepartments(conn,"rationale",campus,kix,true,true));
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String getOtherDepartments(Connection conn,
															String src,
															String campus,
															String kix,
															boolean enableDelete,
															boolean showPending){

Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String descr = "";
		String rowColor = "";

		String deleteColumn = "";
		String aHrefStart = "";
		String aHrefEnd = "";
		String link = "";

		boolean pending = false;
		String sPending = "";

		boolean found = false;
		boolean debug   = false;

		int j = 0;
		int id = 0;

		try{
			debug = DebugDB.getDebug(conn,"ExtraDB");

debug = true;

			if (debug) System.out.println("-------------------------> START");
			if (debug) System.out.println("src: " + src);
			if (debug) System.out.println("kix: " + kix);
			if (debug) System.out.println("enableDelete: " + enableDelete);
			if (debug) System.out.println("showPending: " + showPending);

			String otherDepartmentsRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OtherDepartmentsRequiresApproval");

			if (debug) System.out.println("otherDepartmentsRequiresApproval: " + otherDepartmentsRequiresApproval);

			if (enableDelete){
				deleteColumn = ",e.id ";
				aHrefStart = "<a href=\"crsX29idx.jsp?lid=_LINK_\" class=\"linkcolumn\">";
				aHrefEnd = "</a>";
			}

			String sql = "SELECT e.grading, e.pending, b.ALPHA_DESCRIPTION  " + deleteColumn +
					" FROM tblExtra e LEFT OUTER JOIN " +
					" BannerAlpha b ON e.grading = b.COURSE_ALPHA " +
					" WHERE e.campus=? " +
					" AND e.historyid=? " +
					" AND src=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				link = "";

				alpha = AseUtil.nullToBlank(rs.getString("grading"));
				descr = AseUtil.nullToBlank(rs.getString("ALPHA_DESCRIPTION"));
				pending = rs.getBoolean("pending");

				if (enableDelete){
					id = rs.getInt("id");
					link = aHrefStart.replace("_LINK_",id + "&ack=r&kix=" + kix + "&src=" + src);
				}

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\">" + link + alpha + aHrefEnd + "</td>");
				listings.append("<td class=\"datacolumn\">" + descr + "</td>");

				if (showPending && (Constant.ON).equals(otherDepartmentsRequiresApproval))
					listings.append("<td class=\"datacolumn\">" + sPending + "</td>");

				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr height=\"30\" bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">" +
					"<td class=\"textblackTH\">Alpha</td>" +
					"<td class=\"textblackTH\">Description</td>";

				if (showPending && (Constant.ON).equals(otherDepartmentsRequiresApproval))
					listing += "<td valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>";

				listing += "</tr>" +
								listings.toString() +
								"</table>";
			}
			else{
				listing = "";
			}

			if (debug) System.out.println("-------------------------> END");
		}
		catch( SQLException e ){
			logger.fatal("ExtraDB: getOtherDepartments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ExtraDB: getOtherDepartments - " + ex.toString());
		}

		return listing;
	}
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>