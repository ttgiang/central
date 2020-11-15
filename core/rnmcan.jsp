<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnmcan.jsp	rename outline (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "rnmcan";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Rename/Renumber Outline";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/rnmcan.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#jqAPPROVAL").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": false,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '08%' },
					{ sWidth: '20%' },
					{ sWidth: '42%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});

			$("#jqPENDING").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": false,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '08%' },
					{ sWidth: '20%' },
					{ sWidth: '42%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0" onload="aseOnLoad('<%=idx%>','<%=type%>');">
<%@ include file="../inc/header.jsp" %>

<%
	try{

		if (processPage){
%>
			<fieldset class="FIELDSET90">
				<legend>Rename/Renumber in Progress</legend>
			  <div id="container90">
					<div id="demo_jui">
					  <table id="jqAPPROVAL" class="display">
							<thead>
								 <tr>
									  <th align="left">&nbsp;</th>
									  <th align="left">Proposer</th>
									  <th align="left">Course Title</th>
									  <th align="left">FROM</th>
									  <th align="left">TO</th>
								 </tr>
							</thead>
							<tbody>
								<% for(com.ase.aseutil.Generic g: com.ase.aseutil.RenameDB.getRenameProgress(conn,campus,"APPROVAL")){ %>
								  <tr>
									 <td align="left">
									 	<a href="vwcrsy.jsp?kix=<%=g.getString1()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" title="view rename progress" alt="view rename progress"></a>&nbsp;
									 	<a href="rnmav.jsp?kix=<%=g.getString1()%>" class="linkcolumn" onClick="asePopUpWindowX(this.href,800,400);return false;" onfocus="this.blur()"><img src="../images/reviews.gif" border="0" title="view rename progress" alt="view rename progress"></a>
									 	</td>
									 <td align="left"><%=g.getString2()%></td>
									 <td align="left"><%=g.getString5()%></td>
									 <td align="left"><%=g.getString3()%></td>
									 <td align="left"><%=g.getString4()%></td>
								  </tr>
							<% } %>
							</tbody>
					  </table>
				 </div>
			  </div>
			 </fieldset>

			<fieldset class="FIELDSET90">
				<legend>Pending Rename/Renumber Requests</legend>
			  <div id="container90">
					<div id="demo_jui">
					  <table id="jqPENDING" class="display">
							<thead>
								 <tr>
									  <th align="left">&nbsp;</th>
									  <th align="left">Proposer</th>
									  <th align="left">Course Title</th>
									  <th align="left">FROM</th>
									  <th align="left">TO</th>
								 </tr>
							</thead>
							<tbody>
								<% for(com.ase.aseutil.Generic g: com.ase.aseutil.RenameDB.getRenameProgress(conn,campus,"PENDING")){ %>
								  <tr>
									 <td align="left">
									 	<a href="vwcrsy.jsp?kix=<%=g.getString1()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" title="view rename progress" alt="view rename progress"></a>&nbsp;
									 	<%
									 		if(user.equals(g.getString2())){
										%>
									 		<a href="rnmcanx.jsp?kix=<%=g.getString1()%>" class="linkcolumn"><img src="../images/cancel.jpg" border="0" title="cancel pending request" alt="cancel pending request"></a>&nbsp;
										<%
											}
									 	%>
									 	</td>
									 <td align="left"><%=g.getString2()%></td>
									 <td align="left"><%=g.getString5()%></td>
									 <td align="left"><%=g.getString3()%></td>
									 <td align="left"><%=g.getString4()%></td>
								  </tr>
							<% } %>
							</tbody>
					  </table>
				 </div>
			  </div>
			 </fieldset>
<%
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"rnmcan",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

