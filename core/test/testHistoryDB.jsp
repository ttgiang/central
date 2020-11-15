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

	String campus = "LEE";
	String alpha = "ICS";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "U2l17m9166";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(displayVotingHistory(conn,campus,kix));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String displayVotingHistory(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String approver = "";
		String inviter = "";
		String sql = "";
		String temp = "";
		String rowColor = "";
		String getAllApprovers = "";

		int seq = 0;
		int i = 0;

		boolean foundGroup = false;
		boolean foundAll = false;

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String proposer = info[Constant.KIX_PROPOSER];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			// group votes
			// figure out all the approvers and collect from history their votes and the people they invited for
			// reviews if any.
			boolean experimental = Outlines.isExperimental(num);

			Approver ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
			if (ap != null)
				getAllApprovers = ap.getAllApprovers();

			getAllApprovers = "'" + getAllApprovers.replace(",","','") + "'";

			sql = "SELECT DISTINCT inviter, approver_seq "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? "
				 	+ "AND inviter IN ("+getAllApprovers+")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				//approver = AseUtil.nullToBlank(rs.getString("approver"));
				inviter = AseUtil.nullToBlank(rs.getString("inviter"));
				seq = rs.getInt("approver_seq");

				if (inviter.length() > 0){

					/*
						the left of union collects all votes from reviewers as sent out by the inviter.
						right side of union collects the votes of the inviter
						the outer most adds the voites from the left and right of the union.
					*/

					sql = "SELECT SUM(votesfor) AS votesfor, SUM(votesagainst) AS votesagainst, SUM(votesabstain) AS votesabstain "
							+ "FROM ( "
							+ "SELECT SUM(votesfor) AS votesfor, SUM(votesagainst) AS votesagainst, SUM(votesabstain) AS votesabstain "
							+ "FROM tblApprovalHist "
							+ "WHERE historyid=? "
							+ "GROUP BY inviter "
							+ "HAVING inviter=? "
							+ "UNION "
							+ "SELECT SUM(votesfor) AS votesfor, SUM(votesagainst) AS votesagainst, SUM(votesabstain) AS votesabstain "
							+ "FROM tblApprovalHist "
							+ "WHERE historyid=? "
							+ "GROUP BY approver "
							+ "HAVING approver=? "
							+ ") AS Unionized";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setString(2,inviter);
					ps2.setString(3,kix);
					ps2.setString(4,inviter);
					ResultSet rs2 = ps2.executeQuery();
					while(rs2.next()){
						int voteFor = NumericUtil.nullToZero(rs2.getString("votesfor"));
						int voteAgainst = NumericUtil.nullToZero(rs2.getString("votesagainst"));
						int voteAbstain = NumericUtil.nullToZero(rs2.getString("votesabstain"));

						if (i++ % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						buf.append( "<tr height=\"20\" bgcolor=\"" + rowColor + "\">" );
						//buf.append( "<td class=\"datacolumn\" width=\"15%\">" + seq + "</td>" );
						buf.append( "<td class=\"datacolumn\" width=\"20%\">" + inviter + "</td>" );
						buf.append( "<td class=\"dataColumnRight\" width=\"20%\">" + voteFor + "&nbsp;&nbsp;</td>" );
						buf.append( "<td class=\"dataColumnRight\" width=\"20%\">" + voteAgainst + "&nbsp;&nbsp;</td>" );
						buf.append( "<td class=\"dataColumnRight\" width=\"20%\">" + voteAbstain + "&nbsp;&nbsp;</td>" );
						buf.append( "</tr>" );

						foundGroup = true;
					}
					rs2.close();

				} // if
			} // while
			rs.close();
			ps.close();

			rs = null;
			ps = null;

			if (foundGroup){
				temp = "<fieldset class=\"FIELDSET90\"><legend>Group Votes</legend>"
						+ "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">"
						+ "<tr height=\"20\" bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
						//+ "<td class=\"textblackth\" width=\"15%\">Sequence</td>"
						+ "<td class=\"textblackth\" width=\"20%\">Approver</td>"
						+ "<td class=\"textblackTHRight\" width=\"22%\">Vote For&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackTHRight\" width=\"22%\">Vote Against&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackTHRight\" width=\"22%\">Vote Abstain&nbsp;&nbsp;</td>"
						+ "</tr>"
						+ buf.toString()
						+ "</table>"
						+ "</fieldset>";
			}

			buf.setLength(0);
			i = 0;

			// individual votes
			ArrayList list = HistoryDB.getHistories(conn,kix,type,"");
			if (list != null){
				buf.append("<br/><fieldset class=\"FIELDSET90\"><legend>All Votes</legend>");
				buf.append("<table border=\"0\" cellpadding=\"2\" width=\"100%\">");
				History history;
				for (i=0; i<list.size(); i++){
					history = (History)list.get(i);
					buf.append( "<tr class=\"rowhighlight\"><td valign=top class=\"textblackth\">" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
					buf.append( "<tr><td valign=top class=\"datacolumn\">" + history.getComments() + "</td></tr>" );
					foundAll = true;
				}
				buf.append("</table>");
				buf.append("</fieldset>");

				if (foundAll)
					temp = temp + buf.toString();
			}

		}
		catch(SQLException ce){
			logger.fatal("HistoryDB - displayVotingHistory: " + ce.toString());
		}
		catch(Exception ce){
			logger.fatal("HistoryDB - displayVotingHistory: " + ce.toString());
		}

		if (!foundGroup && !foundAll)
			temp = "<br/><br/><p align=\"center\"><font class=\"textblack\">History data does not exist</font></p>";

		return temp;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>