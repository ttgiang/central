<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrty.jsp	create new outline.
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String title = website.getRequestParameter(request,"title");
	String comments = website.getRequestParameter(request,"comments");

	if (alpha.length()==0 && num.length()==0){
		response.sendRedirect("crscrt.jsp");
	}
	else{
		if (alpha.length()==0 || num.length()==0) {
			response.sendRedirect("../exp/generalerror.jsp");
		}
	}

	// GUI
	String chromeWidth = "70%";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "screen 3 of 4";
	fieldsetTitle = "Create New Outline";

	User usr = null;
	boolean exist = false;

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig",Constant.ON);
	session.setAttribute("aseConfigMessage","Determines how CC should behaves when reaching the last item for modification.");

	if (processPage){
		exist = courseDB.courseExist(conn,campus,alpha,num);
		usr = UserDB.getUserByName(conn,user);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscrt.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
			   "bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '40%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>
	<TABLE cellSpacing=0 cellPadding=4 width="100%" border=0>
		<TBODY class="tableBorder<%=session.getAttribute("aseTheme")%>">
			<tr>
				<TD class="textblackTH" width="15%">Campus:</TD>
				 <td class="dataColumn"><%=usr.getCampus()%></td>
			</TR>
			<tr>
				<TD class="textblackTH" width="15%">Proposer:</TD>
				 <td class="dataColumn"><%=user%></td>
			</TR>
			<tr>
				<TD class="textblackTH" width="15%">Division:</TD>
				 <td class="dataColumn"><%=usr.getDivision()%></td>
			</TR>
			<tr>
				 <td class="textblackTH" nowrap>Alpha:</td>
				 <td class="dataColumn"><%=alpha%></td>
			</tr>
			<tr>
				<TD class="textblackTH" width="15%">Number:</TD>
				 <td class="dataColumn"><%=num%></td>
			</TR>
			<tr>
				<TD class="textblackTH" width="15%">Title:</TD>
				 <td class="dataColumn"><%=title%></td>
			</TR>

			<tr>
				<TD class="textblackTH" width="15%">Comments:</TD>
				 <td class="dataColumn"><%=comments%></td>
			</TR>

			<form method="post" action="crscrtz.jsp" name="aseForm">
			<%
				if (processPage && !exist){
			%>
					<%@ include file="crscrtu.jsp" %>
			<%
				} // processPage
			%>

			<%
				if (processPage && !exist){
			%>
				<tr>
					<TD colspan="2"><br /><div class="hr"></div></TD>
				</TR>
				<tr>
					<TD align="center" colspan="2">
						Do you wish to continue?
						<br /><br />
						<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
						<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
						<input type="hidden" name="alpha" value="<%=alpha%>">
						<input type="hidden" name="num" value="<%=num%>">
						<input type="hidden" name="title" value="<%=title%>">
						<input type="hidden" name="comments" value="<%=comments%>">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>
			</form>
			<%
				}
			%>

			<%
				if (processPage && exist){
					out.println( "<tr><td colspan=2>" );
					out.println( "<br/><div class=\"hr\"></div><p align=\"center\">" + MsgDB.getMsgDetail("CourseExistCampusWide") + "</p>" );

					String sql = aseUtil.getPropertySQL( session, "getOtherCampuses2" );
					if ( sql != null && sql.length() > 0 ){

						sql = aseUtil.replace(sql, "_alpha_", alpha);
						sql = aseUtil.replace(sql, "_num_", num);

						/*
							paging = new com.ase.paging.Paging();
							paging.setRecordsPerPage(99);
							paging.setNavigation( false );
							paging.setSorting( false );
							paging.setSQL(sql);
							out.print( paging.showRecords( conn, request, response ) );
						*/

						paging = null;

						com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
						out.print(jqPaging.showTable(conn,sql,""));
						jqPaging = null;

					}

					out.println("<p align=\"center\"><a href=\"crscrt.jsp\" class=\"linkcolumn\">Try again</a></p>");

					out.println( "</td></tr>" );
				}
			%>
		</TBODY>
	</TABLE>
<%
	}

	// return resource
	asePool.freeConnection(conn,"crscrty",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
