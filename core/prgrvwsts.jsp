<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwsts.jsp - program review status (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Program Review Status";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 999,
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
	try{
		if (processPage){
			int idx = website.getRequestParameter(request,"idx",0);

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Title Index:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"",true) );
			out.println("			</td></tr>" );

			if (idx > 0){
				out.println("			<tr>" );
				out.println("				 <td colspan=\'2\' class=\'dataColumn\'>");
				%>

				<p align="center">
				<img src="../images/viewcourse.gif" border="0" alt="view outline">&nbsp;view outline&nbsp;&nbsp;
				<img src="images/comment.gif" border="0" alt="view reviewer comments">&nbsp;view reviewer comments&nbsp;&nbsp;
				<img src="../images/people.gif" border="0" alt="view outline reviewers">&nbsp;view outline reviewers&nbsp;&nbsp;

				<%
				out.println("				 </td>");
				out.println("		</tr>" );
			}

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left><br/>" );

			ReviewDB.showReviewProgramJQuery(conn,campus,user,idx);
%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th>&nbsp;</th>
								  <th align="left">Title</th>
								  <th align="left">Div</th>
								  <th align="left">Deg</th>
								  <th align="left">Proposer</th>
								  <th align="left">Progress</th>
								  <th align="left">Initiated By</th>
								  <th align="right">Review By Date</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.REVIEWS,user)){ %>
							  <tr>
								 <td align="left"><%=o.getLinks()%></td>
								 <td align="left"><%=o.getOutline()%></td>
								 <td align="left"><%=o.getLastUpdated()%></td>
								 <td align="left"><%=o.getRoute()%></td>
								 <td align="left"><%=o.getProposer()%></td>
								 <td align="left"><%=o.getProgress()%></td>
								 <td align="left"><%=o.getCurrent()%></td>
								 <td align="right"><%=o.getDateProposed()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>
			 </div>
		  </div>
<%

			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		} // processPage
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"prgrvwsts",user);

%>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>
