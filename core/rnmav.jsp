<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnmav.jsp	rename outline (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "rnmav";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Rename/Renumber Progress";

	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/rnmav.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
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
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '55%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">


<%
	try{
		if (processPage){

			RenameDB renameDB = new RenameDB();
			Rename rename = renameDB.getRename(conn,kix);

			if(rename != null){

				String title = courseDB.getCourseItem(conn,kix,"coursetitle");

				String proposer = rename.getProposer();

				String renameRenumber = "Rename "
											+ rename.getFromAlpha()
											+ " "
											+ rename.getFromNum()
											+ " to "
											+ rename.getToAlpha()
											+ " "
											+ rename.getToNum();

				String justification = rename.getJustification();

				String approvers = rename.getApprovers();

				out.println("		<form method=\'post\' name=\'aseForm\' action=\'rnmax.jsp\'>" );

				out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td width=\'15%\' class=\'textblackTH\' valign=\"top\" nowrap>Proposer:&nbsp;</td>" );
				out.println("					 <td width=\'70%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println(proposer);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Course Title:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(title);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Request:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(renameRenumber);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Justification:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(justification);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				</table>" );
			}

			renameDB = null;

%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">&nbsp;</th>
								  <th align="left">Approver</th>
								  <th align="left">Approved</th>
								  <th align="left">Date</th>
								  <th align="left">Comments</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic g: com.ase.aseutil.RenameDB.getRenameProgress(conn,kix)){ %>
							  <tr>
								 <td align="left"><%=g.getString1()%></td>
								 <td align="left"><%=g.getString2()%></td>
								 <td align="left"><%=g.getString3()%></td>
								 <td align="left"><%=g.getString5()%></td>
								 <td align="left"><%=g.getString4()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>
			 </div>
		  </div>
<%
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"rnmav",user);
%>

</body>
</html>
