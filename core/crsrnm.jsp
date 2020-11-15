<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnm.jsp	rename outline (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crsrnm";
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
	<script type="text/javascript" src="js/crsrnm.js"></script>
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
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) Outline Type:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>");

			int thisCounter = 0;
			int thisTotal = 2;

			String[] thisType = new String[thisTotal];
			String[] thisTitle = new String[thisTotal];

			thisType[0] = "CUR"; thisTitle[0] = "Approved";
			thisType[1] = "PRE"; thisTitle[1] = "Proposed";

			for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
				if (type.equals(thisType[thisCounter]))
					out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
				else
					out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
			}

			out.println("			</td></tr>" );

			if (!type.equals(Constant.BLANK)){
				out.println("<form name=\"aseForm\" method=\"post\" action=\"?\">");
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>2) Alpha Index:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,type,false) );
				out.println("<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
				out.println("			</td></tr>" );

				out.println("		<tr>" );
				out.println("			 <td colspan=2 align=left>" );
				out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

				if (idx==0){
					out.println("				<p align=\"center\"><br/><br/>Select alpha index to show available outlines</p>" );
				}
				else{
					out.println("				<p align=\"center\"><br/><br/>Loading available outlines...<img src=\"../images/spinner.gif\" alt=\"Loading available outlines...\" border=\"0\"></p>" );
				}

				out.println("				</div>" );
				out.println("			 </td>" );
				out.println("		</tr>" );
				out.println("</form>");

			} // type not blank

			out.println("			<tr class=\'\'>" );
			out.println("				 <td class=\'dataColumn\' colspan=\"2\">");

			out.println("<br/><div class=\"hr\"></div>" );

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
									 <td align="left"><a href="vwcrsy.jsp?kix=<%=g.getString1()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" title="view rename progress" alt="view rename progress"></a></td>
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
			out.println("<br/><div class=\"hr\"></div><br/>Note: the following describes how rename/renumbering works.<br/><br/>" );
			out.println("<ul>" );
			out.println("<li>Select the course to rename/renumber (FROM_COURSE)</li>" );
			out.println("<li>Provide the new alpha or number (TO_COURSE)</li>" );
			out.println("<li>CC verifies that the TO_COURSE does not exist with the same status (MODIFY, REVIEW, or APPROVE)." );
			out.println("If the course does not exist, CC renames/renumbers the course. The course progress is not affected. For example, proposed course remains in proposed status.</li>" );
			out.println("</ul>" );
			out.println("The end result is similar to performing a search and replace of one alpha/number to another alpha/number.<br/><br/>" );
			out.println("			</td></tr>" );

			out.println("	</table>" );
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"crsrnm",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

