<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsacan.jsp	- cancel assess process
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"campus","",false);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = website.getRequestParameter(request,"alpha","",false);
	String num = website.getRequestParameter(request,"num","",false);

	String pageTitle = campus + " - " + alpha + " - " + num;
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form action="hist04.jsp" method="post">
	<table width="100%">
		<tr>
			<td valign="top" width="10%" class="textblackth">Outline</td>
			<td><%=pageTitle%><p>&nbsp;</p></td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">Archived</td>
			<td><% out.println(listArc(conn,campus,alpha,num)); %> </td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">History</td>
			<td><% out.println(listHist(conn,campus,alpha,num)); %> </td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">&nbsp;</td>
			<td>
				<input type="hidden" value="<%=campus%>" name="campus">
				<input type="hidden" value="<%=alpha%>" name="alpha">
				<input type="hidden" value="<%=num%>" name="num">
				<input type="submit" value="Next" name="Go">
				&nbsp;<a href="hist00.jsp" class="linkcolumn">start over</a>
				&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
				<a href="hist05.jsp?campus=<%=campus%>&alpha=<%=alpha%>&num=<%=num%>&arc=0&hst=0" class="linkcolumn">remove outline</a>
			</td>
		</tr>

	</table>
</form>

<%
	asePool.freeConnection(conn,"hist01",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	public static String listArc(Connection conn,String campus,String alpha,String num) {

		Logger logger = Logger.getLogger("test");

		StringBuilder sb = new StringBuilder();

		try{
			String sql = "SELECT historyid, dte FROM zarct WHERE campus=? AND coursealpha=? AND coursenum=? ORDER BY dte desc";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String dte = AseUtil.nullToBlank(rs.getString("dte"));

				sb.append("<input type=\"radio\" value=\""+historyid+"\" name=\"arc\">" + historyid + " - " + dte + Html.BR());

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return "<ul>" + sb.toString() + "</ul>";

	}

	public static String listHist(Connection conn,String campus,String alpha,String num) {

		Logger logger = Logger.getLogger("test");

		StringBuilder sb = new StringBuilder();

		try{
			String sql = "SELECT historyid, dte FROM zhstt WHERE campus=? AND coursealpha=? AND coursenum=? ORDER BY dte desc";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String dte = AseUtil.nullToBlank(rs.getString("dte"));

				sb.append("<input type=\"text\" text=\"10\" value=\""+historyid+"\" name=\"hsttext\"><input type=\"radio\" value=\""+historyid+"\" name=\"hst\">" + historyid + " - " + dte + Html.BR());

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return "<ul>" + sb.toString() + "</ul>";

	}


%>