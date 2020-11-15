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

	String arc = website.getRequestParameter(request,"arc","",false);
	String hst = website.getRequestParameter(request,"hst","",false);

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	int rowsAffeccted = 0;

	if(!arc.equals("0") && !hst.equals("0")){
		rowsAffeccted = update(conn,campus,arc,hst);
	}
	else{
		rowsAffeccted = delete(conn,campus,alpha,num);
	}

	if(rowsAffeccted > 0){
		out.println("kix updated succesfully");
	}
	else{
		out.println("fix update failed");
	}
%>

	<p>&nbsp;</p>
	<a href="hist00.jsp" class="linkcolumn">try again</a>
	&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
	<a href="hist01.jsp?campus=<%=campus%>" class="linkcolumn">return to <%=campus%></a>
	&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
	<a href="hist02.jsp?campus=<%=campus%>&alpha=<%=alpha%>" class="linkcolumn">return to <%=alpha%></a>
	&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
	<a href="hist03.jsp?campus=<%=campus%>&alpha=<%=alpha%>&num=<%=num%>" class="linkcolumn">return to <%=num%></a>

<%

	asePool.freeConnection(conn,"hist01",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	public static int update(Connection conn,String campus,String arc,String hst) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "update tblapprovalhist2 set historyid=? Where campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,arc);
			ps.setString(2,campus);
			ps.setString(3,hst);
			rowsAffected = ps.executeUpdate();
			ps.close();

System.out.println("campus - " + campus);
System.out.println("arc - " + arc);
System.out.println("hst - " + hst);

System.out.println(rowsAffected + " - " + sql);

			if(rowsAffected > 0){
				sql = "delete from zarct where campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,arc);
				rowsAffected = ps.executeUpdate();
				ps.close();
System.out.println(rowsAffected + " - " + sql);

				sql = "delete from zhstt where campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,hst);
				rowsAffected = ps.executeUpdate();
				ps.close();
System.out.println(rowsAffected + " - " + sql);

				sql = "delete from zarchstfix where campus=? AND arc=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,arc);
				rowsAffected = ps.executeUpdate();
				ps.close();
System.out.println(rowsAffected + " - " + sql);

			}


		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return rowsAffected;

	}

	public static int delete(Connection conn,String campus,String alpha,String num) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

System.out.println("campus - " + campus);
System.out.println("alpha - " + alpha);
System.out.println("num - " + num);

			String sql = "delete from zarct where campus=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rowsAffected = ps.executeUpdate();
			ps.close();
System.out.println("arc: " + rowsAffected);

			sql = "delete from zhstt where campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rowsAffected = ps.executeUpdate();
			ps.close();
System.out.println("hst: " + rowsAffected);

			sql = "delete from zarchstfix where campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rowsAffected = ps.executeUpdate();
			ps.close();
System.out.println("archst: " + rowsAffected);

		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return rowsAffected;

	}

%>