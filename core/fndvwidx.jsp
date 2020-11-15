<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndvwidx.jsp - difference between this and prgidx is this is CUR and the other is PRE
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String type = website.getRequestParameter(request,"type","");
	String foundation = website.getRequestParameter(request,"foundation","");

	//
	// set page title
	//
	String pageTitle = "Display Foundation Course";

	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%

	if (processPage){
		String sql = "";

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");

		out.println("<p align=\"left\">");

		out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		//
		// not showing type of course when in edit
		//
		out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" valign=\"top\" width=\"20%\" height=\"30\">Select status:&nbsp;&nbsp;</td><td valign=\"top\" class=\'dataColumn\'>");

		int thisCounter = 0;
		int thisTotal = 4;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "ARC"; thisTitle[0] = "Archived";
		thisType[1] = "CAN"; thisTitle[1] = "Cancelled";
		thisType[2] = "CUR"; thisTitle[2] = "Approved";
		thisType[3] = "PRE"; thisTitle[3] = "Proposed";

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
		}

		out.println("<input type=\"hidden\" name=\"type\" value=\""+type+"\"></td></tr>");

		if(!type.equals(Constant.BLANK)){
			out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">Select type:&nbsp;&nbsp;</td><td>");
			out.println(com.ase.aseutil.fnd.FndDB.drawFndRadio(conn,"foundation",foundation));
			out.println("</td></tr>");
		}

		out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">&nbsp;</td><td>"
						+ "<br/><input type=\"submit\" name=\"cmdSubmit\" value=\"Go\" class=\"input\">"
						+ "</td></tr>");

		out.println("</table>");
		out.println("</p></form>");

		if (!type.equals(Constant.BLANK) && !foundation.equals(Constant.BLANK)){

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
								for(com.ase.aseutil.Generic fd: com.ase.aseutil.fnd.FndDB.getFoundationForEditDisplay(conn,campus,type,foundation)){
									String proposer = fd.getString5();
									String coproposer = fd.getString9().replace(",","<br>");
							%>
							  <tr>
								 <td>
										<a href="vwpdf.jsp?kix=<%=fd.getString0()%>" class="linkcolumn" target="_blank"><img src="../images/ext/pdf.gif" border="0" title="view only" alt="view only"></a>&nbsp;&nbsp;

								 		<%
								 			//
								 			// in edit mode, only proposer or coproposers are allowed
								 			//
											if(type.equals("PRE") && (user.equals(proposer) || coproposer.contains(user))){
										%>
												<a href="fndedt.jsp?id=<%=fd.getString1()%>" class="linkcolumn"><img src="../images/edit.gif" border="0" title="edit" alt="edit"></a>
										<%
											}
								 		%>


								 		<%
								 			//
								 			// proposer may edit settings
								 			//
											if(user.equals(proposer)){
										%>
												<a href="fndcrtx.jsp?id=<%=fd.getString1()%>" class="linkcolumn"><img src="../images/settings.png" border="0" title="edit settings" alt="edit settings" width="18"></a>
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
						<% } %>
						</tbody>
				  </table>

				<style type="text/css">

					li {
						text-align: left;
					}

					p {
						text-align: left;
					}

				</style>

				<p><br>Legend:
				<ul>
					<li><img src="../images/ext/pdf.gif" alt="view foundation course" title="view foundation course"> - view foundation course</li>
					<li><img src="../images/edit.gif" alt="edit foundation course" title="edit foundation course"> - edit foundation course (available to proposers/authors)</li>
					<li><img src="../images/settings.png" alt="edit foundation course settings" title="edit foundation course settings" width="18"> - edit foundation course settings (available to proposers)</li>
				</ul>
				</p>

			 </div>
		  </div>

		<%
		} // if status

	} // if process

	paging = null;

	asePool.freeConnection(conn,"fndvwidx",user);
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

