<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	er16 - summary of course actions
	*	2012.07.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Summary of Course/Program Actions";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// set up default year
	String currentYear = com.ase.aseutil.util.AseDate.getCurrentYear();

	String isProgramOn = (String)session.getAttribute("aseMenuEnableProgram");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#jqCourseCount").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 6,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": false,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": true,
				"bInfo": false,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '40%' },
					{ sWidth: '60%' }
				]
			});

			$("#jqProgramCount").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 6,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": false,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": true,
				"bInfo": false,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '40%' },
					{ sWidth: '60%' }
				]
			});

			$("#jqCourse").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bJQueryUI": true,
				"bRetrieve": false,
				"bFilter": true,
				"aaSorting": [[1, "asc"]],
				"bSortClasses": false,
				"bLengthChange": true,
				"bPaginate": true,
				"bInfo": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '08%' },
					{ sWidth: '10%' },
					{ sWidth: '37%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});

			$("#jqProgram").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bJQueryUI": true,
				"bRetrieve": false,
				"bFilter": true,
				"aaSorting": [[1, "asc"]],
				"bSortClasses": false,
				"bLengthChange": true,
				"bPaginate": true,
				"bInfo": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '08%' },
					{ sWidth: '32%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		com.ase.aseutil.er.ER00016 er16 = new com.ase.aseutil.er.ER00016();

		int report = website.getRequestParameter(request,"r", -1);

		String fromDate = website.getRequestParameter(request,"fd",currentYear);

		String toDate = website.getRequestParameter(request,"td",currentYear);

		if(report < 0){

			String[] courseTitles = er16.getCourseTitles();

			int[] courseCounter = er16.getCourseCounters(conn,campus,fromDate,toDate);

			// program is not on automatically for all
			String[] programTitles = null;

			int[] programCounter = null;

			if (isProgramOn != null && isProgramOn.equals(Constant.ON)){
				programTitles = er16.getProgramTitles();
				programCounter = er16.getProgramCounters(conn,campus,fromDate,toDate);
			} // isProgramOn

%>
			<form name="aseForm" method="post" action="?">
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
					<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td width="05%" class="textblackth">From:</td>
						<td width="10%">
							<%
								out.println(Html.drawYearListBox(conn,campus,Constant.COURSE_APPROVED_TEXT,"fd",fromDate,"BLANK"));
							%>
						</td>
						<td width="05%" class="textblackth">To:</td>
						<td width="10%">
							<%
								out.println(Html.drawYearListBox(conn,campus,Constant.COURSE_APPROVED_TEXT,"td",toDate,"BLANK"));
							%>
						</td>
						<td height="30" width="70%" align="left">
							<input type="submit" value=" Go " class="inputsmallgray">
							&nbsp;&nbsp;&nbsp;<img src="./images/helpicon.gif" border="0" alt="show help" title="show help" onclick="switchMenu('er16Help');">
						</td>
					</tr>
				</table>
			</form>
			<br/>

		<div id="forum_wrapper">
				<div id="er16Help" style="width: 100%; display:none;">
					<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
						<TBODY>
							<TR>
								<TD class=title-bar width="50%"><font class="textblackth">Summary of Course/Program Actions</font></TD>
								<td class=title-bar width="50%" align="right">
									<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('er16Help');">
								</td>
							</TR>
							<TR>
								<TD colspan="2">
									CC assigns the following progress to courses and programs:
									<ul>
										<li>ARC - archived or deleted course/program</li>
										<li>PRE - in progress work on course/program (modify, revise, approval, etc)</li>
										<li>CUR - approved course/program</li>
									</ul>

									The above progresses are referenced in describing each report.

									<ul>
										<li>Final approval of modifications to existing courses/programs
											<ol>
												<li>A course/program must exist as CUR and ARC simultaneously</li>
											</ol>
										</li>
										<li>Final approval of new courses/programs
											<ol>
												<li>A course/program existing as CUR only</li>
											</ol>
										</li>
										<li>Final approval of deletions of existing courses/programs
											<ol>
												<li>A course/program existing as ARC only</li>
											</ol>
										</li>
										<li>Modified-but-not-yet-approved courses/programs still in the pipeline
											<ol>
												<li>A course/program must exist as CUR and PRE simultaneously</li>
											</ol>
										</li>
										<li>New-but-not-yet-approved courses/programs still in the pipeline
											<ol>
												<li>A course/program existing as PRE with status orther than DELETE</li>
											</ol>
										</li>
										<li>Deleted-but-not-yet-approved courses still in the pipeline
											<ol>
												<li>A course/program existing as PRE with status of DELETE</li>
											</ol>
										</li>
									</ul>
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</div>
		</div>

			<p align="left"><font class="titlemessage">Course Summary</font></p>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jqCourseCount" class="display">
						<thead>
							 <tr>
								  <th align="left">&nbsp;</th>
								  <th align="left">Title</th>
								  <th align="left">Outlines</th>
							 </tr>
						</thead>
						<tbody>
							<% for(int i=0; i<6; i++){ %>
							  <tr>
								 <td align="right"><%=i%></td>
								 <td align="left"><%=courseTitles[i]%></td>
								 <td align="left">
								 	<%
								 		if(courseCounter[i] > 0){
									%>
											<a href="?c=c&r=<%=i%>&fd=<%=fromDate%>&td=<%=toDate%>" class="linkcolumn"><%=courseCounter[i]%></a>
									<%
										}
										else{
									%>
											0
									<%
										}
								 	%>
								 </td>
							  </tr>
						<% } %>
						</tbody>
				  </table>

			 </div>
		  </div>

<%
			if (isProgramOn != null && isProgramOn.equals(Constant.ON)){
%>
				<p align="left"><font class="titlemessage">Program Summary</font></p>
			  <div id="container90">
					<div id="demo_jui">
					  <table id="jqProgramCount" class="display">
							<thead>
								 <tr>
									  <th align="left">&nbsp;</th>
									  <th align="left">Title</th>
									  <th align="left">Outlines</th>
								 </tr>
							</thead>
							<tbody>
								<% for(int i=0; i<5; i++){ %>
								  <tr>
									 <td align="right"><%=i%></td>
									 <td align="left"><%=programTitles[i]%></td>
									 <td align="left">
										<%
											if(programCounter[i] > 0){
										%>
									 		<a href="?c=p&r=<%=i%>&fd=<%=fromDate%>&td=<%=toDate%>" class="linkcolumn"><%=programCounter[i]%></a>
										<%
											}
											else{
										%>
									 		0
										<%
											}
										%>
									 </td>
								  </tr>
							<% } %>
							</tbody>
					  </table>

				 </div>
			  </div>
<%
			} // isProgramOn
%>

<%
		}
		else{

			String category = website.getRequestParameter(request,"c","");

			String reportTitle = "";

			if(category.equals("c")){
				reportTitle = er16.getCourseTitle(report);
			}
			else{
				reportTitle = er16.getProgramTitle(report);
			} // category

%>
			<table width="100%">
				<tr>
					<td class="titlemessage"><%=reportTitle%>&nbsp;(<%=fromDate%> - <%=toDate%>)</td>
					<td align="right"><a href="?fd=<%=fromDate%>&td=<%=toDate%>" class="linkcolumn">back to summary</a></td>
				</tr>
			</table>

<%
			if(category.equals("c")){
%>
			  <div id="container90">
					<div id="demo_jui">
					  <table id="jqCourse" class="display">
							<thead>
								 <tr>
									  <th align="left">&nbsp;</th>
									  <th align="left">Outline</th>
									  <th align="left">Title</th>
									  <th align="left">Proposer</th>
									  <th align="left">Date</th>
									  <th align="left">Progress</th>
								 </tr>
							</thead>
							<tbody>
								<% for(com.ase.aseutil.Generic g: er16.getCourses(conn,campus,report,fromDate,toDate)){ %>
								  <tr>
									<td>
										<a href="vwcrsy.jsp?pf=1&kix=<%=g.getString1()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline"></a>&nbsp;
										<a href="er16x.jsp?kix=<%=g.getString1()%>" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false" onfocus="this.blur()"><img src="../images/reviews1x.gif" border="0" alt="course summary" title="course summary"></a>&nbsp;
										<a href="er16y.jsp?kix=<%=g.getString1()%>" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false" onfocus="this.blur()"><img src="../images/viewhistory.gif" border="0" alt="approval history" title="approval history"></a>&nbsp;
									</td>
									 <td align="left"><%=g.getString2()%></td>
									 <td align="left"><%=g.getString3()%></td>
									 <td align="left"><%=g.getString4()%></td>
									 <td align="left"><%=g.getString5()%></td>
									 <td align="left"><%=g.getString6()%></td>
								  </tr>
							<% } %>
							</tbody>
					  </table>

				 </div>
			  </div>
<%
			}
			else{
%>
			  <div id="container90">
					<div id="demo_jui">
					  <table id="jqProgram" class="display">
							<thead>
								 <tr>
									  <th align="left">&nbsp;</th>
									  <th align="left">Title</th>
									  <th align="left">Effective Date</th>
									  <th align="left">Proposer</th>
									  <th align="left">Date</th>
									  <th align="left">Progress</th>
								 </tr>
							</thead>
							<tbody>
								<% for(com.ase.aseutil.Generic g: er16.getPrograms(conn,campus,report,fromDate,toDate)){ %>
								  <tr>
									<td>
										<a href="vwhtml.jsp?kix=<%=g.getString1()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline"></a>&nbsp;
									</td>
									 <td align="left"><%=g.getString2()%></td>
									 <td align="left"><%=g.getString3()%></td>
									 <td align="left"><%=g.getString4()%></td>
									 <td align="left"><%=g.getString5()%></td>
									 <td align="left"><%=g.getString6()%></td>
								  </tr>
							<% } %>
							</tbody>
					  </table>

				 </div>
			  </div>
<%
			} // category
		} // report

		er16 = null;

	} // processPage

	paging = null;

	asePool.freeConnection(conn,"er16",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

