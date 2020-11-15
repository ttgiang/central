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

	session.setAttribute("aseThisPage","usrbrd");

	String pageTitle = "My Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String aseBoardsToShow = website.getRequestParameter(request,"s","1");

	session.setAttribute("aseBoard","usrbrd");
	session.setAttribute("aseBoardsToShow",aseBoardsToShow);
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
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

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
							  <th align="left" width="12%">Board ID</th>
							  <th align="left" width="27%">Board Name</th>
							  <th align="left" width="15%">Created By</th>
							  <th align="left" width="10%">Posts</th>
							  <th align="left" width="10%">Participants</th>
							  <th align="left" width="05%">Views</th>
							  <th align="left" width="15%">Last Post</th>
							  <th align="left" width="03%">Replies</th>
							  <th align="left" width="03%">Status</th>
						 </tr>
					</thead>
					<tbody>
						<%
							// sys admin sees all
							for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserMessages(conn,campus,user,aseBoardsToShow)){
						%>
						  <tr>
							 <td align="left">
							 	<a href="forum/usrbrd.jsp?fid=<%=u.getString1()%>" class="linkcolumn"><%=u.getString2()%></a>
							 </td>
							 <td align="left"><%=u.getString3()%></td>
							 <td align="left"><%=u.getString4()%></td>
							 <td align="left"><%=u.getString5()%></td>
							 <td align="left"><%=u.getString6()%></td>
							 <td align="left"><%=u.getString8()%></td>
							 <td align="left"><%=u.getString7()%></td>
							 <td align="left">
							 	<%
							 		if (u.getString9() != null && u.getString9().length() > 0){
							 			if (NumericUtil.getInt(u.getString9(),0) > 0){
											%>
												Yes
											<%
										}
										else{
											%>
												No
											<%
										}
									}
							 	%>
							 </td>
							 <td align="left"><%=u.getString0()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	}

	asePool.freeConnection(conn,"usrbrd",user);

%>

<br>
<a href="forum/usr.jsp" class="button"><span>New Messsage</span></a>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
