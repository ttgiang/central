<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscat.jsp	course catalog  (does not need alpha selection)
	*	TODO: Need to complete this
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crscat");

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Course Catalog";
	fieldsetTitle = "Course Catalog";

	String alpha = website.getRequestParameter(request,"aseList");

	// clear file drop history
	String clearFileDropList = website.getRequestParameter(request,"clr","0");
	if (clearFileDropList.equals("1")){
		com.ase.aseutil.db.FileDrop fd = new com.ase.aseutil.db.FileDrop();
		fd.clearDroppedFiles(conn,campus,user);
		fd = null;
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscat.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			out.println("<form name=\"aseForm\" method=\"post\" action=\"crscatz.jsp\">");
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" nowrap>Alpha:&nbsp;</td>" );

			// ER00025
			out.println("<td class=\'dataColumn\'>"
							+ helper.drawDiscipline2(conn,campus,alpha)
							+ "<br/><br/></td></tr>");

			out.println("<tr>" );
			out.println("<td class=\'textblackTH\' width=\"15%\" nowrap>Select Outline:&nbsp;</td>" );
			out.println("<td class=\'dataColumn\'>");
			String sql = aseUtil.getPropertySQL(session,"alphas3");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha2",alpha,false));
			out.println("<input id=\"num\" name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\"\">");
			out.println("<input name=\"type\" type=\"hidden\" value=\"CUR\">");
			out.println("<br/><br/></td></tr>");

			out.println("<tr>" );
			out.println("<td class=\'textblackTH\' width=\"15%\" nowrap>Clean HTML:&nbsp;</td>" );
			out.println("<td class=\'dataColumn\'>");
			out.println("<input id=\"parseHtml\" name=\"parseHtml\" class=\"input\" type=\"checkbox\" value=\"1\" checked>");
			out.println("&nbsp;check here to parse (remove) embedded tags from pasted content</td></tr>");

			out.println("<tr>" );
			out.println("<td class=\'textblackTH\' width=\"15%\" nowrap>Suppress Linked Data:&nbsp;</td>" );
			out.println("<td class=\'dataColumn\'>");
			out.println("<input id=\"suppress\" name=\"suppress\" class=\"input\" type=\"checkbox\" value=\"1\" checked>");
			out.println("&nbsp;check here to suppress printing of linked (matrix) data</td></tr>");

			out.println("<tr>" );
			out.println("<td>&nbsp;</td><td>" +
							"<br/><input type=\"submit\" name=\"cmdSubmit\" value=\"submit\" class=\"input\" onClick=\"return checkForm()\">" +
							"<input type=\"submit\" name=\"cmdCancel\" value=\"cancel\" class=\"input\" onClick=\"return cancelForm()\">" +
							"</td></tr>");

			out.println("			<tr>" );
			out.println("<td class=\'dataColumn\' colspan=\"2\">" +
							"<div class=\"hr\"></div>" +
							"Instructions: " +
							"<ul>" +
							"<li>Select an ALPHA and click submit to create a course catalog for the selected ALPHA</li>" +
							"<li>Select an outline to create a course catalog for the selected outline</li>" +
							"<li>Leave all fields empty to create a full course catalog</li>" +
							"</ul>" +
							"<br/>" +
							"Catalog template: " +
							"<ul>" +
							"<li>click <a href=\"stmtidx.jsp\" class=\"linkcolumnx\">here</a> to modify catalog template</li>" +
							"</ul>" +
							"<br/><br/></td></tr>");

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left><br/><br/>" );

%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">Date</th>
								  <th align="left">Selection</th>
								  <th align="left">File</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic fd: com.ase.aseutil.db.FileDrop.getDroppedFiles(conn,campus,user)){ %>
							  <tr>
								 <td><%=fd.getString2()%></td>
								 <td><%=fd.getString4()%></td>

								<%
								 	if(fd.getString1().contains("Processing error:")){
								%>
										 <td><%=fd.getString1()%></td>
								<%
									}
									else{
								%>
										 <td><a href="<%=fd.getString1()%>" class="linkcolumn" target="_blank"><%=fd.getString1()%></a></td>
								<%
									}
								 %>
							  </tr>
						<% } %>
						</tbody>
				  </table>

				<br><a href="crscat.jsp?clr=1" class="button"><span>clear list</span></a>

			 </div>
		  </div>

<%

			out.println("			 </td>" );
			out.println("		</tr>" );

			// form buttons
			out.println("	</table>" );
			out.println("	</form>" );

		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"crscat",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
