<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndvwedit.jsp - difference between this and prgidx is this is CUR and the other is PRE
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	//
	// set page title
	//
	String pageTitle = "Edit Foundation Course";

	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"foundation edit help\" title=\"foundation edit help\" onclick=\"switchMenu('fndvweditHelp');\">";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

	<div id="fndvweditHelp" style="width: 100%; display:none;">
		<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
			<TBODY>
				<TR>
					<TD class=title-bar width="50%"><font class="textblackth">Edit Foundation Course</font></TD>
					<td class=title-bar width="50%" align="right">
						<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('fndvweditHelp');">
					</td>
				</TR>
				<TR>
					<TD colspan="2">
						<ul>
							<li><img src="../images/ext/pdf.gif" border="0" title="view only" alt="view only">&nbsp;&nbsp;&nbsp;View foundation course</li>
							<li><img src="../images/edit.gif" border="0" title="edit" alt="edit">&nbsp;&nbsp;&nbsp;Edit foundation course</li>
							<li><img src="../images/settings.png" border="0" title="settings" alt="settings" width="18">&nbsp;&nbsp;&nbsp;Edit foundation course properties. For example, co-authors, assessment.</li>
						</ul>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</div>

<%
	if (processPage){
		%>

		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">&nbsp;</th>
								  <th align="left">Created Date</th>
								  <th align="left">Course</th>
								  <th align="left">Title</th>
								  <th align="left">Proposer</th>
								  <th align="left">Co-Authors</th>
								  <th align="left">Progress</th>
								  <th align="left">Audity By</th>
								  <th align="left">Audit Date</th>
							 </tr>
						</thead>
						<tbody>
							<%
								com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

								for(com.ase.aseutil.Generic fd: fnd.getFoundationForEdit(conn,campus,user)){

									String proposer = fd.getString5();
									String coproposer = fd.getString9().replace(",",", ");
									String progress = fnd.getFndItem(conn,NumericUtil.getInt(fd.getString1(),0),"progress");
							%>
							  <tr>
								 <td>
										<a href="vwpdf.jsp?kix=<%=fd.getString0()%>" class="linkcolumn" target="_blank"><img src="../images/ext/pdf.gif" border="0" title="view only" alt="view only"></a>&nbsp;&nbsp;

										<%
											//
											// adjust settings
											//
											if(user.equals(proposer)){
										%>
												<a href="fndcrtx.jsp?id=<%=fd.getString1()%>" class="linkcolumn"><img src="../images/settings.png" border="0" title="settings" alt="settings" width="18"></a>
										<%
											}
										%>

										<%
											//
											// edit or not
											//
											if(progress.equals("MODIFY")){
										%>
												<a href="fndedt.jsp?id=<%=fd.getString1()%>" class="linkcolumn"><img src="../images/edit.gif" border="0" title="edit" alt="edit"></a>
										<%
											}
										%>

								 </td>
								 <td><%=fd.getString2()%></td>
								 <td><%=fd.getString3()%></td>
								 <td><%=fd.getString4()%></td>
								 <td><%=proposer%></td>
								 <td><%=coproposer%></td>
								 <td><%=fd.getString6()%></td>
								 <td><%=fd.getString7()%></td>
								 <td><%=fd.getString8()%></td>
							  </tr>
						<%
							} // for

							fnd = null;

						%>
						</tbody>
				  </table>

				  <br/>

				  Note: Modification is not permitted during review or approval process.

			 </div>
		  </div>

		<%

	} // if process

	paging = null;

	asePool.freeConnection(conn,"fndvwedit",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

<%@ include file="datatables.jsp" %>
<script type="text/javascript">
	$(document).ready(function () {
		$("#jquery").dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 99,
			"bJQueryUI": true,
			"bFilter": true,
			"bSortClasses": true,
			"bLengthChange": false,
			"bPaginate": false,
			"bInfo": false,
			"aaSorting": [ [2,'asc'] ],
			"aoColumns": [
			{ sWidth: '10%' },
			{ sWidth: '10%' },
			{ sWidth: '10%' },
			{ sWidth: '25%' },
			{ sWidth: '10%' },
			{ sWidth: '25%' },
			{ sWidth: '10%' },
			{ sWidth: '10%' },
			{ sWidth: '10%' } ]
		});
	});
</script>
