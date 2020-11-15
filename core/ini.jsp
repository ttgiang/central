<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ini.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","ini");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String sql = aseUtil.getPropertySQL(session,"iniCategory");
	String category = website.getRequestParameter(request,"category", "");

	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

	// default SQL for all settings
	String props = "ini2";

	session.setAttribute("aseReport","SystemSettings");

	if (category.equals("System")){
		props = "iniSystem";
	}

	// pageClear = 1 is when this page is called from menu selection. This means
	// it's the first time to this page. If so, start with a clear page with
	// no saved session value.
	String pageValue = "";
	String pageClear = website.getRequestParameter(request,"pageClr","");
	if (pageClear.equals(Constant.BLANK)){
		pageValue = website.getRequestParameter(request,"asePageINI","",true);
		if (category.equals(Constant.BLANK) && !pageValue.equals(Constant.BLANK))
			category = pageValue;
		else
			session.setAttribute("asePageINI",category);
	}

	String pageTitle = "System Settings";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/systemlist.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="./js/plugins/plugins.jsp" %>
	<link rel="stylesheet" type="text/css" href="../inc/csstable.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 99,
				 "bJQueryUI": true,
				 "bAutoWidth": false,
				 "bLengthChange": false,
   			 "aoColumns": [
					{ sWidth: '20%' },
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' } ]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
		out.println("			<table width=\'" + session.getAttribute("aseTableWidth") + "\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					<td>" + aseUtil.createSelectionBox(conn,sql,"category",category,false) );
		out.println( "						<input type=\"submit\" value=\"Go\" name=\"cmdGo\" class=\"inputsmallgray\">" );

		if (!category.equals(Constant.BLANK) && category.equals("System")){
			out.println( "						&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"sssm.jsp?s=" + category + "\" class=\"linkcolumn\">System Summary</a>" );
		}

		// only system admin gets to add new
		if (SQLUtil.isSysAdmin(conn,user)){
			//out.println("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
			//		+ "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"inimod.jsp?c=System&lid=0\" class=\"linkcolumn\"><img src=\"../images/add.gif\" border=\"0\" alt=\"new system setting\" title=\"new system setting\"></a>" );
		}

		out.println( "						</td>" );

		String noAllowedToResequence = "ApprovalRouting,System";
		if (!category.equals(Constant.BLANK) && noAllowedToResequence.indexOf(category)==-1){
			out.println( "						<td align=\"right\">" );
			//out.println( "						<a href=\"inimod.jsp?lid=0&c=" + category + "\" class=\"linkcolumn\">Add item</a>&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;" );
			out.println( "						<a href=\"/central/servlet/progress?c="+campus+"&p9=" + category + "\" class=\"linkcolumn\" target=\"_blank\">Print</a>&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;" );
			//out.println( "						<a href=\"iniseq.jsp?s=" + category + "\" class=\"linkcolumn\">Resequence</a>&nbsp;&nbsp;&nbsp;" );
			out.println( "						</td>" );
		}

		out.println("				</tr>" );
		out.println("		</table>" );
		out.println("		</form>" );

		if (!category.equals(Constant.BLANK)){

			if (SQLUtil.isCampusAdmin(conn,user) || SQLUtil.isSysAdmin(conn,user)){
%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">Key</th>
								  <th align="left">Description</th>
								  <th align="left">Value</th>
								  <th align="left" nowrap>Updated By</th>
								  <th align="right" nowrap>Updated Date</th>
							 </tr>
						</thead>
						<tbody>
							<%

								for(com.ase.aseutil.Generic g: com.ase.aseutil.IniDB.getSysSettings(conn,campus,category)){

									String dataValue = g.getString4();

									if(dataValue.equals("1")){
										dataValue = "Yes";
									}
									else if(dataValue.equals("0")){
										dataValue = "No";
									}

								%>
									  <tr>
										 <td align="left"><a href="inimod.jsp?c=<%=category%>&lid=<%=g.getString1()%>" class="linkcolumn"><%=g.getString2()%></a></td>
										 <td align="left"><%=g.getString3()%></td>
										 <td align="left"><%=dataValue%></td>
										 <td align="left"><%=g.getString5()%></td>
										 <td align="right" nowrap><%=g.getString6()%></td>
									  </tr>
								<%
								} // for
						%>
						</tbody>
				  </table>
			 </div>
		  </div>

<%
			} // campus admin

		} // category

	} // processPage

	asePool.freeConnection(conn,"ini",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>