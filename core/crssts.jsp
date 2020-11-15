<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crssts.jsp - outline approval status (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crssts");

	// GUI
	String chromeWidth = "60%";
	String thisPage = "crssts";
	session.setAttribute("aseThisPage",thisPage);
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "Outline Approval Status";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="./js/modal/modalnews.jsp" %>
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
		boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

		try{
			int idx = website.getRequestParameter(request,"idx",0);

			out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"",true,"","/central/servlet/clone?rpt=OutlineApprovalStatus") );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td colspan=\'2\' class=\'dataColumn\'>");
	%>

			<p align="center">
			<a href="#dialogTaskDescription" name="modal" class="linkcolumn">View detail task description</a>&nbsp;&nbsp;&nbsp;
			<img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline">&nbsp;view outline&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="../images/viewhistory.gif" border="0" alt="view approval history" title="view approval history">&nbsp;view approval history&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="images/comment.gif" border="0" alt="view comments" title="view comments">&nbsp;view comments&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="../images/details.gif" border="0" alt="view outline detail" title="view outline detail">&nbsp;view outline detail&nbsp;&nbsp;&nbsp;&nbsp;
			<%
						if (isSysAdmin || isCampusAdmin){
							out.println("<img src=\"../images/routing.gif\" border=\"0\" alt=\"change approval routing\">&nbsp;change approval routing&nbsp;&nbsp;");
							out.println("<img src=\"../images/fastrack.gif\" border=\"0\" alt=\"view approval history\">&nbsp;fast track approval&nbsp;&nbsp;");
						}
	%>

			</p>

	<%
			out.println("				 </td>");
			out.println("		</tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left><br/>" );

			ApproverDB.showApprovalProgressJQuery(conn,campus,user,idx);

%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th>&nbsp;</th>
								  <th align="left">Outline</th>
								  <th align="left">Progress</th>
								  <th align="left">Proposer</th>
								  <th align="left">Current Approver</th>
								  <th align="left">Next Approver</th>
								  <th align="right">Date Proposed</th>
								  <th align="right">Last Updated</th>
								  <th align="left">Routing Sequence</th>
							 </tr>
						</thead>
						<tbody>
							<%
								String enableCCLab = Util.getSessionMappedKey(session,"EnableCCLab");

								for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.COURSE,user)){

									String pdf = "";
									String links = o.getLinks();
									String kix = o.getHistoryid();
									if (enableCCLab.equals(Constant.ON) && kix != null && !kix.equals(Constant.BLANK)){
										pdf = "<a href=\"vwpdf.jsp?kix="+kix+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>&nbsp;&nbsp;"+links;
									}
									else{
										pdf = links;
									}

							%>
							  <tr>
								 <td align="left"><%=pdf%></td>
								 <td align="left"><%=o.getOutline()%></td>
								 <td align="left"><%=o.getProgress()%></td>
								 <td align="left">
									<a href="http://localhost:8080/<%=o.getProposer()%>" rel="usridx_qtip.jsp?p=<%=o.getProposer()%>&kix=<%=o.getHistoryid()%>" class="linkcolumn"><%=o.getProposer()%></a>
								 </td>

								 <td align="left">
									<a href="http://localhost:8080/<%=o.getCurrent()%>" rel="crssts_qtip.jsp?p=<%=o.getCurrent()%>&kix=<%=o.getHistoryid()%>" class="linkcolumn"><%=o.getCurrent()%></a>
								 </td>

								 <td align="left">
									<a href="http://localhost:8080/<%=o.getNext()%>" rel="usridx_qtip.jsp?p=<%=o.getNext()%>&kix=<%=o.getHistoryid()%>" class="linkcolumn"><%=o.getNext()%></a>
								 </td>

								 <td align="right"><%=o.getDateProposed()%></td>
								 <td align="right"><%=o.getLastUpdated()%></td>
								 <td align="left"><%=o.getRoute()%></td>
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
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"crssts",user);
%>

<%@ include file="datatables.jsp" %>

<%
	int displayLength = 99;
%>

<%@ include file="qtip.jsp" %>

<%@ include file="tasksx.jsp" %>

<%@ include file="./js/modal/taskdescr2.jsp" %>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>
