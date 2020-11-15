<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	val.jsp - generic text maintenance table
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","val");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String sql = aseUtil.getPropertySQL(session,"valCategory");
	String topic = website.getRequestParameter(request,"topic", "");
	String subtopic = "";

	//
	//	in the topic drop down list, topic is separated from subtopic by a dash
	//
	if (topic != null && topic.length() > 0){
		if (topic.indexOf(" - ") > -1){
			subtopic = topic.substring(topic.indexOf(" - ")+3);
			topic = topic.substring(0,topic.indexOf(" "));
		}
	}

	// pageClear = 1 is when this page is called from menu selection. This means
	// it's the first time to this page. If so, start with a clear page with
	// no saved session value.
	String pageValue = "";
	String pageValue2 = "";
	String pageClear = website.getRequestParameter(request,"pageClr","");
	if (pageClear.equals(Constant.BLANK)){
		pageValue = website.getRequestParameter(request,"asePageVAL","",true);
		if (topic.equals(Constant.BLANK) && !"".equals(pageValue))
			topic = pageValue;
		else
			session.setAttribute("asePageVAL",topic);

		pageValue2 = website.getRequestParameter(request,"asePageVAL2","",true);
		if (subtopic.equals(Constant.BLANK) && !pageValue2.equals(Constant.BLANK))
			subtopic = pageValue2;
		else
			session.setAttribute("asePageVAL2",subtopic);
	}
	else{
		session.setAttribute("asePageVAL","");
		session.setAttribute("asePageVAL2","");
	}

	String pageTitle = "System Tables";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/systemlist.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

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
				 "bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
				{ sWidth: '10%' },
				{ sWidth: '10%' },
				{ sWidth: '10%' },
				{ sWidth: '40%' },
				{ sWidth: '15%' },
				{ sWidth: '15%' } ]

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
	if (processPage){
		out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
		out.println("			<table width=\'" + session.getAttribute("aseTableWidth") + "\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					<td class=\"textblackth\">Select topic/subtopic: " + aseUtil.createSelectionBox(conn,sql,"topic",topic + " - " + subtopic,false) );
		out.println( "						<input type=\"submit\" value=\"Go\" name=\"cmdGo\" class=\"inputsmallgray\">" );

		if (!topic.equals(Constant.BLANK) && topic.equals("System")){
			out.println( "						&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"sssm.jsp?s=" + topic + "\" class=\"linkcolumn\">System Summary</a>" );
		}

		out.println( "						</td>" );
		out.println("				</tr>" );
		out.println("		</table>" );
		out.println("		</form>" );
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">Topic</th>
							  <th align="left">Subtopic</th>
							  <th align="left">Seq</th>
							  <th align="left">Description</th>
							  <th align="left">Updated By</th>
							  <th align="right">Updated Date</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Values o: com.ase.aseutil.ValuesDB.getValues(conn,campus,topic,subtopic)){ %>
						  <tr>
							 <td><a href="valmod.jsp?c=<%=topic%>&s=<%=o.getSubTopic()%>&lid=<%=o.getId()%>" class="linkcolumn"><%=o.getTopic()%></a></td>
							 <td><%=o.getSubTopic()%></td>
							 <td><%=o.getSeq()%></td>
							 <td><%=o.getShortDescr()%></td>
							 <td><%=o.getAuditBy()%></td>
							 <td align="right"><%=o.getAuditDate()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>
<%
	} // processpage

	asePool.freeConnection(conn,"val",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>