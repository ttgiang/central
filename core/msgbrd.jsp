<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	msgbrd.jsp
	*	2011.11.19	message board
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","msgbrd");

	String aseBoardsToShow = website.getRequestParameter(request,"s","1");

	session.setAttribute("aseBoard","msgbrd");
	session.setAttribute("aseBoardsToShow",aseBoardsToShow);

	session.setAttribute("aseCallingPage",null);
	session.setAttribute("aseOrigin",null);

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"message board help\" title=\"message board help\" onclick=\"switchMenu('msgbrdHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true
			});
		});
	</script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="./lib/msgbrd.jsp" %>

<%
	if (processPage) {
%>
	  <div id="container90">
			<div id="demo_jui">

				<%
					if (aseBoardsToShow.equals("0")){
				%>
						<a href="?s=1" class="linkcolumn">show active boards</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
						<font class="goldhighlights">show closed boards</font>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
						<a href="?s=2" class="linkcolumn">show all boards</a>
				<%
					}
					else if (aseBoardsToShow.equals("1")){
				%>
						<font class="goldhighlights">show active boards&nbsp;&nbsp;</font><font class="copyright">|</font>&nbsp;
						<a href="?s=0" class="linkcolumn">show closed boards</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
						<a href="?s=2" class="linkcolumn">show all boards</a>
				<%
					}
					else if (aseBoardsToShow.equals("2")){
				%>
						<a href="?s=1" class="linkcolumn">show active boards</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
						<a href="?s=0" class="linkcolumn">show closed boards</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
						<font class="goldhighlights">show all boards</font>
				<%
					}
				%>

			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">Board Name</th>
							  <th align="left">Created By</th>
							  <th align="left">Last Post</th>
							  <th align="left">Members</th>
							  <th align="left">Posts</th>
							  <th align="left">Views</th>
							  <th align="left">Status</th>
							  <th align="left">Source</th>
							  <th align="left">Board ID</th>
						 </tr>
					</thead>
					<tbody>
						<%

							for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserBoards(conn,campus,user,aseBoardsToShow)){

								int fid = NumericUtil.getInt(u.getString1(),0);

								String replies = "";
								String src = ForumDB.getForumItem(conn,fid,"src");

								if (ForumDB.getReplyCount(conn,user,fid) > 0){
									replies = "&nbsp;<img src=\"./forum/images/new.png\" border=\"0\">";
								}

						%>
						  <tr>
							 <td align="left"><a href="forum/usrbrd.jsp?fid=<%=u.getString1()%>" class="linkcolumn"><%=u.getString5()%></a><%=replies%></td> <!-- board name -->
							 <td align="left"><%=u.getString6()%></td> <!-- created by -->
							 <td align="left"><%=u.getString7()%></td> <!-- last post -->
							 <td align="left"><%=u.getString9()%></td> <!-- members -->
							 <td align="left"><%=u.getString8()%></td> <!-- posts -->
							 <td align="left"><%=u.getString0()%></td> <!-- views -->
							 <td align="left"><%=u.getString2()%></td> <!-- status -->
							 <td align="left"><%=src%></td> <!-- source -->
							 <td align="left"><%=u.getString3()%></td> <!-- board id -->
						  </tr>
					<% } %>
					</tbody>
			  </table>

			  <p align="left"><img src="./forum/images/new.png" border="0"> replies available</p>
		 </div>
	  </div>
<%
	}

	asePool.freeConnection(conn,"msgbrd",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

