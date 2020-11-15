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
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "m55g17d9203";
	String src = "x43";
	String dst = "m55g17d9203";

	out.println("Start<br/>");

	out.println(getCompsAsHTMLList(conn,alpha,num,campus,type,"c11b23d9188",true,""));

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static String getCompsAsHTMLList(Connection connection,
															String alpha,
															String num,
															String campus,
															String type,
															String hid,
															boolean detail,
															String sloType) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql;
		String sqlDetail;
		StringBuffer comps = new StringBuffer();
		StringBuffer compsDetail = new StringBuffer();
		boolean found = false;
		boolean foundDetail = false;
		String temp = "";
		int id = 0;
		int seq = 0;

		/*
			for every SLO found (sql), retrieve the linked evaluation (sqlDetail)
			outer while look collects all SLOs. Inner while collects all evals
		*/
		sqlDetail = "SELECT vw.content "
			+ "FROM tblCourseLinked tcl INNER JOIN "
			+ "vw_LinkedSLO2MethodEval vw ON tcl.historyid = vw.historyid AND "
			+ "tcl.seq = vw.seq AND tcl.id = vw.keyid "
			+ "WHERE tcl.historyid=? AND "
			+ "tcl.seq=? AND "
			+ "tcl.id=? ";

		try {
			sql = "SELECT tcc.historyid,tcc.Comp,tcc.Compid,tcl.id "
				+ "FROM tblCourseComp tcc LEFT OUTER JOIN "
				+ "tblCourseLinked tcl ON "
				+ "tcc.historyid = tcl.historyid AND tcc.CompID = tcl.seq "
				+ "WHERE tcc.historyid=? ";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,hid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				found = true;
				id = resultSet.getInt("id");
				seq = resultSet.getInt("compid");
				comps.append("<li class=\"dataColumn\">" + resultSet.getString("comp"));
				if (detail){
					compsDetail.setLength(0);
					foundDetail = false;

					PreparedStatement stmtDetail = connection.prepareStatement(sqlDetail);
					stmtDetail.setString(1,hid);
					stmtDetail.setInt(2,seq);
					stmtDetail.setInt(3,id);
					ResultSet rsDetail = stmtDetail.executeQuery();
					while (rsDetail.next()){
						foundDetail = true;
						compsDetail.append("<li class=\"dataColumn\">" + rsDetail.getString(1) + "</li>");
					}

					if (foundDetail){
						comps.append("<ul>");
						comps.append(compsDetail.toString());
						comps.append("</ul>");
					}

					rsDetail.close();
					stmtDetail.close();
				}

				comps.append("</li>");

			}
			resultSet.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td>&nbsp;</td></tr>" +
					"<tr><td><ul>" +
					comps.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("CompDB: getCompsAsHTMLList\n" + e.toString());
		}

		return temp;
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
