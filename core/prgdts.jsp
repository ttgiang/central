<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgdts.jsp	program created dates
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","prgdts");

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Program Creation Dates";
	fieldsetTitle = pageTitle;
	String type = website.getRequestParameter(request,"type");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": true,
				"bFilter": true,
				"bSortClasses": false,
				"bLengthChange": true,
				"bPaginate": true,
				"bInfo": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '30%' },
					{ sWidth: '20%' },
					{ sWidth: '50%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
%>
	  <div id="container90">
			<div id="demo_jui">

				<p align="left">
					<font class="textblackth">Program Type:</font>
					<font class="dataColumn">
						&nbsp;&nbsp;
						<%
							if(type.equals("ARC")){
								out.println("<span class=\"goldhighlights\">Archived</span>&nbsp;&nbsp;&nbsp;");
							}
							else{
								out.println("<a href=\"?type=ARC\" class=\"linkcolumn\">Archived</a>&nbsp;&nbsp;&nbsp;");
							}

							if(type.equals("CUR")){
								out.println("<span class=\"goldhighlights\">Approved</span>&nbsp;&nbsp;&nbsp;");
							}
							else{
								out.println("<a href=\"?type=CUR\" class=\"linkcolumn\">Approved</a>&nbsp;&nbsp;&nbsp;");
							}

							if(type.equals("PRE")){
								out.println("<span class=\"goldhighlights\">Proposed</span>&nbsp;&nbsp;&nbsp;");
							}
							else{
								out.println("<a href=\"?type=PRE\" class=\"linkcolumn\">Proposed</a>&nbsp;&nbsp;");
							}

						%>
					</font>
				</p>

				<%
					if(!type.equals(Constant.BLANK)){
				%>
					  <table id="jquery" class="display">
							<thead>
								 <tr>
									  <th align="left">Title</th>
									  <th align="left">Proposed Date</th>
									  <th align="left">Proposer</th>
								 </tr>
							</thead>
							<tbody>
								<%
									for(com.ase.aseutil.Generic g: com.ase.aseutil.ProgramsDB.getCreatedDates(conn,campus,type)){ %>
								  <tr>
									 <td align="left"><%=g.getString1()%></td>
									 <td align="left"><a href="vwhtml.jsp?cps=<%=campus%>&kix=<%=g.getString4()%>" class="linkcolumn" target="_blank"><%=g.getString2()%></a></td>
									 <td align="left"><%=g.getString3()%></td>
								  </tr>
							<% } %>
							</tbody>
					  </table>
				<%
					} // type
				%>

		 </div>
	  </div>
<%
	}

	paging = null;

	asePool.freeConnection(conn,"prgdte",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

