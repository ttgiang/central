<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsstsh.jsp - outline approval history
	*	TODO - need to send over alpha and number correctly
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Outline Approval History";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String helpButton = website.getRequestParameter(request,"help");
	String campus = (String)session.getAttribute("aseCampus");

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

	out.println( "Completed approvals" );
	msg = showCompletedApprovals(conn,campus,"ICS","212");
	out.println(msg.getErrorLog());
	out.println( "<br/>" );
	out.println( "Pending approvals" );
	out.println(showPendingApprovals(conn,campus,"ICS",msg.getMsg()));

	asePool.freeConnection(conn);

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

<%!

	/**
	 * showCompletedApprovals
	 * <p>
	 * @param	Connection
	 * @param	String
	 * <p>
	 * @return	Msg
	 */
	public static Msg showCompletedApprovals(Connection conn,String campus,String alpha,String num){

Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String rtn = "";

		String approvers = "";
		String title = "";
		String dte = "";
		String approved = "";
		String position = "";

		String rowColor = "";
		int j = 0;

		Msg msg = new Msg();
		String approver = "";

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT ta.seq, ta.approver, tu.title, tu.position, ta.dte, ta.approved " +
				"FROM tblApprovalhist ta INNER JOIN tblUsers tu ON ta.approver = tu.userid " +
				"WHERE ta.campus=? AND Coursealpha=? AND Coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				if (j++ % 2 == 0)
					rowColor = "#ffffff";
				else
					rowColor = "#e1e1e1";

				approver = aseUtil.nullToBlank(rs.getString("approver")).trim();
				title = aseUtil.nullToBlank(rs.getString("title")).trim();
				position = aseUtil.nullToBlank(rs.getString("position")).trim();
				dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),6);
				approved = aseUtil.nullToBlank(rs.getString("approved")).trim();
				if ("1".equals(approved))
					approved = "YES";
				else
					approved = "NO";

				if (j==1)
					approvers = approver;
				else
					approvers = approvers + "," + approver;

				buf.append("<tr bgcolor=\"" + rowColor + "\">" +
					"<td class=\"dataColumn\">" + approver + "</td>" +
					"<td class=\"dataColumn\">" + title + "</td>" +
					"<td class=\"dataColumn\">" + position + "</td>" +
					"<td class=\"dataColumn\">" + dte + "</td>" +
					"<td class=\"dataColumn\">" + approved + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showCompletedApprovals\n" + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showCompletedApprovals\n" + ex.toString());
			buf.setLength(0);
		}

		rtn = "<table class=\"" + campus + "BGColor\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
				"<tr class=\"" + campus + "BGColor\">" +
				"<td>Approver</td>" +
				"<td>Title</td>" +
				"<td>Position</td>" +
				"<td>Date</td>" +
				"<td>Approved</td>" +
				"</tr>" +
				buf.toString() +
				"</table>";

		msg.setMsg(approvers);
		msg.setErrorLog(rtn);

		return msg;
	}

	/**
	 * showPendingApprovals
	 * <p>
	 * @param	Connection
	 * @param	String
	 * <p>
	 * @return	String
	 */
	public static String showPendingApprovals(Connection conn,String campus,String alpha,String completed){

Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String rtn = "";

		String approver = "";
		String title = "";
		String position = "";

		String rowColor = "";
		int j = 0;

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			completed = "'" + completed.replace(",","','") + "'";

			String sql = "SELECT ta.approver_seq AS Sequence, ta.Approver, tu.Title, tu.Position " +
				"FROM tblApprover AS ta INNER JOIN tblUsers AS tu ON ta.approver = tu.userid " +
				"WHERE ta.approver<>? AND ta.campus=? AND ta.approver NOT IN (" + completed + ") " +
				"UNION " +
				"SELECT ta.approver_seq AS Sequence, tu.userid AS Approver, tu.title, tu.position " +
				"FROM tblApprover ta INNER JOIN tblUsers AS tu ON ta.campus = tu.campus " +
				"WHERE tu.position=? AND tu.campus=? AND tu.department=? AND ta.approver=? AND tu.userid NOT IN (" + completed + ") ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,"DIVISIONCHAIR");
			ps.setString(2,campus);
			ps.setString(3,"DIVISION CHAIR");
			ps.setString(4,campus);
			ps.setString(5,alpha);
			ps.setString(6,"DIVISIONCHAIR");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				if (j++ % 2 == 0)
					rowColor = "#ffffff";
				else
					rowColor = "#e1e1e1";

				approver = aseUtil.nullToBlank(rs.getString("approver")).trim();
				title = aseUtil.nullToBlank(rs.getString("title")).trim();
				position = aseUtil.nullToBlank(rs.getString("position")).trim();

				buf.append("<tr bgcolor=\"" + rowColor + "\">" +
					"<td class=\"dataColumn\">" + approver + "</td>" +
					"<td class=\"dataColumn\">" + title + "</td>" +
					"<td class=\"dataColumn\">" + position + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showPendingApprovals\n" + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showPendingApprovals\n" + ex.toString());
			buf.setLength(0);
		}

		rtn = "<table class=\"" + campus + "BGColor\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
				"<tr class=\"" + campus + "BGColor\">" +
				"<td>Approver</td>" +
				"<td>Title</td>" +
				"<td>Position</td>" +
				"</tr>" +
				buf.toString() +
				"</table>";

		return rtn;
	}

%>


</body>
</html>