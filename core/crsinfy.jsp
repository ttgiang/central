<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsinfy.jsp	- all about an outline
	*	TODO	prefill history id with some value (maybe)
	*	TODO	how to get to view course with campus as part of key
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String type = "";
	String num = "";
	String campus = "";
	int route = 0;

	String myCampus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix","");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
		route = NumericUtil.nullToZero(info[6]);
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"t");
		campus = website.getRequestParameter(request,"cps");
		kix = helper.getKix(conn,campus,alpha,num,type);
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Detail: " + pageTitle;
	paging = new com.ase.paging.Paging();
	String sql = "";

	// hide comes from approver status where we hide the menu when popping up new window
	String chromeWidth = "80%";
	int hide = website.getRequestParameter(request,"h",0);

	asePool.freeConnection(conn,"crsinfy",user);

	if(kix == null || kix.length() == 0){
		processPage = false;
	}
	else{
		// we need a longer running connection
		conn = asePool.createLongConnection();
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/help.js"></script>

	<link rel="stylesheet" type="text/css" href="forum/inc/forum.css">

	<%@ include file="../inc/expand.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#showCompletedApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '25%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#showPendingApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' }
				]
			});

			$("#getApprovedOutline").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#getArchivedOutlines").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#getCancelledOutline").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#getDeletedOutline").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' }
				]
			});

			$("#crscoreqidx2").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#getModifiedOutline").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#crsprereqidx2").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#crsxrfidx3").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '40%' }
				]
			});

			$("#getOtherCampuses").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' }
				]
			});

			$("#pendingTasks").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '50%' },
					{ sWidth: '20%' }
				]
			});

			$("#actionlog").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bFilter": true,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[4, "desc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '50%' },
					{ sWidth: '20%' }
				]
			});

		});
	</script>

	<script type="text/javascript" src="js/crsinfy.js"></script>


</head>
<body topmargin="0" leftmargin="0">

<%
	if (hide==1){
%>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	}
	else{
%>
<%@ include file="../inc/header.jsp" %>
<%
	}
%>

<%
	if(processPage){
%>


	<!---------------------------------	main menu --------------------------------------------->
	<table border="0" width="100%">
		<tr valign="TOP">
			<td>
				<ul>
					<li><a href="#approval_history" class="linkcolumn" title="view outline approval history">Approval History</a></li>
					<li><a href="#approver_comments" class="linkcolumn" title="view outline approval history">Approval/Review Comments</a></li>
					<li><a href="#approved_outlines" class="linkcolumn" title="view approved outline">Approved Outlines</a></li>
					<li><a href="#approved_status" class="linkcolumn" title="view outline approval status">Approval Status</a></li>
					<li><a href="#archived_outlines" class="linkcolumn" title="view archived outline">Archived/Deleted Outlines</a></li>
					<li><a href="#cancelled_outlines" class="linkcolumn" title="view cancelled outline">Cancelled Outlines</a></li>
					<li><a href="#deleted_outlines" class="linkcolumn" title="view deleted outline">Deleted Outlines</a></li>
					<li><a href="#co-requisites" class="linkcolumn" title="view outline co-requisites">Co-Requisites</a></li>
				</ul>
			</td>
			<td>
				<ul>
					<li><a href="#linked_items" class="linkcolumn" title="view linked outline items">Linked Items</a></li>
					<li><a href="#modified_outlines" class="linkcolumn" title="view modified outline">Modified Outlines</a></li>
					<li><a href="#other_campuses" class="linkcolumn" title="view similar outlines at other campuses">Other Campuses</a></li>
					<li><a href="#progress" class="linkcolumn" title="view outline progress">Outline Progress</a></li>
					<li><a href="#pre-requisites" class="linkcolumn" title="view outline pre-requisites">Pre-Requisites</a></li>
					<li><a href="#pending_tasks" class="linkcolumn" title="view pending tasks">Pending Tasks</a></li>
					<li><a href="#review_history" class="linkcolumn" title="view outline review history">Reviewer Comments</a></li>
				</ul>
			</td>
			<td>
				<ul>
					<li><a href="#CrossListed" class="linkcolumn" title="view cross listed outline items">Cross Listed</a></li>
					<li><a href="#actionlog" class="linkcolumn" title="view action log">Action Log</a></li>
				</ul>
			</td>
		</tr>
	</table>

	<!---------------------------------	approval status --------------------------------------------->

	<%@ include file="crsinfz.jsp" %>

	<!---------------------------------	approval history --------------------------------------------->

	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none" name="approval_history"  class="goldhighlights">Approval History</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
		<tr bgcolor="#ffffff">
			<td colspan="2">
				<table border="0" cellpadding="2" width="100%">
					<%
						ArrayList list = HistoryDB.getHistories(conn,kix,type);
						if (list != null){
							History history;
							for (int i=0; i<list.size(); i++){
								history = (History)list.get(i);
								out.println("<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
								out.println("<tr><td valign=top>" + history.getComments() + "</td></tr>" );
							}
						}
					%>
					<tr>
						<td>
							<p>&nbsp;</p><p><a href="##" class="linkcolumn" onClick="return moreHistory('<%=campus%>','<%=alpha%>','<%=num%>','ARC');">&nbsp;show archived history</a></p>
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="moreHistory">
								<img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<!---------------------------------	approver comments --------------------------------------------->

	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none" name="approver_comments"  class="goldhighlights">Approval/Review Comments</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
		<tr bgcolor="#ffffff">
			<td colspan="2">
				<%
					// only use the old format if there is data to display and nothing found in forum
					String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
					int fid = ForumDB.getForumID(conn,campus,kix);
					if (enableMessageBoard.equals(Constant.OFF) || fid == 0){
						out.println(ReviewerDB.getReviewHistory(conn,kix,0,campus,0,Constant.APPROVAL));
					}
					else{
						if (fid > 0 && enableMessageBoard.equals(Constant.ON)){
						%>
							<table width="100%" cellspacing="1" cellpadding="4">
								<tbody>

									<%
										int i = 0;

										String clss = "";

										for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid,0)){

											++i;

											int mid = Integer.parseInt(u.getString6());
											int item = Integer.parseInt(u.getString9());
									%>
										<tr class="<%=clss%>">
											<td style="text-align:left;">
												<%
													out.println(Board.printChildren(conn,fid,item,0,0,mid,user));
												%>
											</td>
										</tr>
									<%
										} // for
									%>

								</tbody>
							</table>
						<%
							} // if fid
					} // if enableMessageBoard
				%>
			</td>
		</tr>
	</table>

	<!---------------------------------	approval status --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none" name="approved_status"  class="goldhighlights">Approval Status</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
		<tr bgcolor="#ffffff">
			<td colspan="2">
				<%
						out.println("<font class=\"textblackTH\">Completed approvals</font>");
						msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
						out.println(msg.getErrorLog());
						out.println( "<br/>" );
						out.println("<font class=\"textblackTH\">Pending approvals</font>");
						out.println(ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route));
				%>
			</td>
		</tr>
	</table>

	<!--------------------------------- approved --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="approved_outlines"  class="goldhighlights">Approved Outline</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "getApprovedOutline" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
		}
		sql = sql.replace(myCampus,campus);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		jqPaging.setTarget("1");
		jqPaging.setUrlKeyName("kix");
		out.println(jqPaging.showTable(conn,sql,"/central/core/vwcrsy.jsp","getApprovedOutline"));
		jqPaging = null;

	%>

	<!--------------------------------- archived_outlines --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="archived_outlines"  class="goldhighlights">Archived/Deleted Outline</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "getArchivedOutlines" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
		}
		sql = sql.replace(myCampus,campus);

		jqPaging = new com.ase.paging.JQPaging();
		jqPaging.setTarget("1");
		jqPaging.setUrlKeyName("kix");
		out.println(jqPaging.showTable(conn,sql,"/central/core/vwcrsy.jsp","getArchivedOutlines"));
		jqPaging = null;


	%>

	<!--------------------------------- cancelled --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="cancelled_outlines"  class="goldhighlights">Cancelled Outline</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "getCancelledOutline" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
		}
		sql = sql.replace(myCampus,campus);

		jqPaging = new com.ase.paging.JQPaging();
		jqPaging.setTarget("1");
		jqPaging.setUrlKeyName("kix");
		out.println(jqPaging.showTable(conn,sql,"/central/core/vwcrsy.jsp","getCancelledOutline"));
		jqPaging = null;

	%>

	<!--------------------------------- deleted --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="deleted_outlines"  class="goldhighlights">Deleted Outline</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>

	  <div id="container90">
			<div id="demo_jui">
			  <table id="getDeletedOutline" class="display">
					<thead>
						 <tr>
							  <th align="left"></th>
							  <th align="left">Alpha</th>
							  <th align="left">Num</th>
							  <th align="left">Date</th>
							  <th align="left">Proposer</th>
							  <th align="left">Title</th>
							  <th align="left">Comments</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Generic g: com.ase.aseutil.CourseDelete.getDeletedOutline(conn,campus,alpha,num)){ %>
						  <tr>
							 <td align="left"><%=g.getString1()%></td>
							 <td align="left"><a href="vwcrsy.jsp?kix=<%=g.getString1()%>" target="_blank" class="linkcolumn"><%=g.getString2()%></a></td>
							 <td align="left"><%=g.getString3()%></td>
							 <td align="left"><%=g.getString4()%></td>
							 <td align="left"><%=g.getString5()%></td>
							 <td align="left"><%=g.getString6()%></td>
							 <td align="left"><a href="crsrsn.jsp?kix=<%=g.getString1()%>" target="_blank" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWinCrsrsn','800','600','yes','center');return false" onfocus="this.blur()">view comments</a></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>

	<!--------------------------------- co-requisites --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="co-requisites"  class="goldhighlights">Co-Requisites</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "crscoreqidx2" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", type);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","crscoreqidx2"));
			jqPaging = null;
		}
	%>

	<!--------------------------------- modified --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="modified_outlines"  class="goldhighlights">Modified Outline</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "getModifiedOutline" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
		}
		sql = sql.replace(myCampus,campus);

		jqPaging = new com.ase.paging.JQPaging();
		jqPaging.setTarget("1");
		jqPaging.setUrlKeyName("kix");
		out.println(jqPaging.showTable(conn,sql,"/central/core/vwcrsy.jsp","getModifiedOutline"));
		jqPaging = null;

	%>

	<!--------------------------------- Pre-requisites --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="pre-requisites"  class="goldhighlights">Pre-Requisites</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "crsprereqidx2" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", type);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","crsprereqidx2"));
			jqPaging = null;

		}
	%>

	<!--------------------------------- CrossListed --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="CrossListed"  class="goldhighlights">Cross Listed</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "crsxrfidx3" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", type);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","crsxrfidx3"));
			jqPaging = null;
		}
	%>

	<!--------------------------------- Other Campuses --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="other_campuses"  class="goldhighlights">Other Campuses</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<%
		sql = aseUtil.getPropertySQL( session, "getOtherCampuses" );
		if ( sql != null && sql.length() > 0 ){
			paging = new com.ase.paging.Paging();
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = sql.replace(myCampus,campus);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","getOtherCampuses"));
			jqPaging = null;

		}
	%>

	<font class="textblackth">NOTE:</font> Outlines shown at other campuses having matching alpha and number does not necessarily mean the outline is the same at <%=campus%>.
	<br/>

	<!--------------------------------- linked items --------------------------------------------->
	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="linked_items"  class="goldhighlights">Linked Items</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>
	<table border="0" width="100%">
		<tr>
			<td align="left"><% out.println(LinkerDB.getLinkedOutlineContent(conn,kix)); %></td>
		</tr>
	</table>

	<!--------------------------------- pending tasks --------------------------------------------->

	<%
		if (type.equals("PRE")){
	%>
		<br/>
		<table border="0" width="100%" class="tableCaption">
			<tr>
				<td align="left"><a style="text-decoration:none"  name="pending_tasks"  class="goldhighlights">Pending Tasks</a></td>
				<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
			</tr>
		</table>
	<%
		}

		sql = aseUtil.getPropertySQL(session, "pendingTasks" );
		if ( sql != null && sql.length() > 0 ){
			paging = new com.ase.paging.Paging();
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", type);
			sql = sql.replace(myCampus,campus);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","pendingTasks"));
			jqPaging = null;
		}
	%>


	<!--------------------------------- Action log --------------------------------------------->

	<br/>
	<table border="0" width="100%" class="tableCaption">
		<tr>
			<td align="left"><a style="text-decoration:none"  name="actionlog"  class="goldhighlights">Action Log</a></td>
			<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
		</tr>
	</table>

	<%
		sql = aseUtil.getPropertySQL(session, "actionlog" );
		if ( sql != null && sql.length() > 0 ){
			paging = new com.ase.paging.Paging();
			sql = aseUtil.replace(sql, "_kix_", kix);
			sql = sql.replace(myCampus,campus);

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","actionlog"));
			jqPaging = null;

		}
	%>

	<%
		try{
			if (conn != null){
				conn.close();
				conn = null;
			}
		}
		catch(Exception e){
			//logger.fatal("Tables: campusOutlines - " + e.toString());
		}
	%>

<%
	} // processPage
%>

<%
	if (hide==1){
%>
<%@ include file="../inc/chromefooter.jsp" %>
<%
	}
	else{
%>
<%@ include file="../inc/footer.jsp" %>
<%
	}
%>

<div id="help_container" class="popHide"></div>

</body>
</html>

