<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prg.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Foundation Course";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	asePool.freeConnection(conn,"prg",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">

		<tr>
			<td valign="top">
				<h3 class="subheader">Approval</h3>
				<ul>
					<li>Approve a Foundation Course</li>
					<li>Cancel Approval Request</li>
					<li>Foundation Course Approval Status</li>
				</ul>
			</td>
			<td valign="top">
				<h3 class="subheader">Maintenance</h3>
				<ul>
					<li><a href="/central/core/fndcan.jsp" class="linkcolumn">Cancel Proposed Foundation Course</a></li>
					<li><a href="/central/core/fndcrt.jsp" class="linkcolumn">Create New Foundation Course</a></li>
					<li>Delete Approved Foundation Course</li>
					<li><a href="/central/core/fndvwidx.jsp" class="linkcolumn">Display Foundation Course</a></li>
					<li><a href="/central/core/fndvwedit.jsp" class="linkcolumn">Edit Foundation Course</a></li>
					<li>Modify Approved Foundation Course</li>
					<li>Request Foundation Course Approval</li>
				</ul>
			</td>
			<td valign="top">
				<h3 class="subheader">Review</h3>
				<ul>
					<li><a href="/central/core/fndrvwcan.jsp?edt=PRE" class="linkcolumn">Cancel Review Request</a></li>
					<li><a href="/central/core/crsrvw.jsp?fnd=1" class="linkcolumn">Invite Reviewers</a></li>
					<li><a href="/central/core/fndrqstrvw.jsp" class="linkcolumn">Request Foundation Course Review</a></li>
					<li><a href="/central/core/rvw.jsp?itm=foundation" class="linkcolumn">Review Foundation Course</a></li>
					<li><a href="/central/core/fndrvwsts.jsp" class="linkcolumn">Foundation Course Review Status</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="3">
				<h3 class="subheader">Progress</h3>
				<ul>
					<li>Foundation Course Progress</li>
					<li><a href="/central/core/fndsrch.jsp" class="linkcolumn">Search Foundation Course</a></li>
				</ul>
			</td>
		</tr>
		<%
			if (userLevel > Constant.FACULTY){
		%>
		<tr>
			<td valign="top" colspan="3">
				<h3 class="subheader">Campus Admin</h3>
				<ul>
					<li>Edit Foundation Course  Data</li>
					<li><a href="/central/core/fndidx.jsp" class="linkcolumn">Foundation Course Item Definition</a> <font color="#E87B10">(this option has campus wide impact)</font></li>
				</ul>
			</td>
		</tr>
		<%
			}
		%>
</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

fndsrch.jsp
