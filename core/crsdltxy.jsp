<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdltxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String message = "";
	boolean valid = true;

	int route = 0;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix");
	String comments = website.getRequestParameter(request,"comments");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		route = NumericUtil.nullToZero(info[6]);
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
		message = "You may not delete an outline while modification is in progress";
		valid = false;
	}
	else{
		message = "<div align=\"left\">" +
			"&nbsp;&nbsp;&nbsp;If you select to continue, the following actions are performed:" +
			"<ul>" +
			"<li>The outline will be archived</li>" +
			"<li>Similar outline references will be removed</li>" +
			"</ul>" +
			"</div>";
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Outline";

	String approvalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsdlt.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#crsprereqidx").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 10,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '80%' }
				]
			});

			$("#crscoreqidx").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 10,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '80%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />

<%
	if (processPage){
%>

<form method="post" action="crsdltxz.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<%
				if(approvalSubmissionAsPackets.equals(Constant.OFF)){
			%>
				<TR>
					<TD align="center">
						<%=message%>
						<div class="hr"></div>
					</TD>
				</TR>
			<%
				} // approvalSubmissionAsPackets
			%>

			<%
				if (valid) {

					// display routing for selection when not working with packet
					if(approvalSubmissionAsPackets.equals(Constant.OFF)){

						String HTMLFormField = Html.drawRadio(conn,"ApprovalRouting","route",(route+""),campus,false);

						out.println("<tr><td>"
										+ "<TABLE cellSpacing=0 cellPadding=0 width=\"100%\" border=0>"
										+ "<tr><td colspan=\"2\" class=\"textblackth\">&nbsp;&nbsp;&nbsp;Select an approval routing</td></tr>"
										+ "<tr><td width=\"30%\">&nbsp;</td>"
										+ "<td width=\"70%\">" + HTMLFormField + "</td></tr></table></td></tr>");
					}

				%>
						<TR><TD align="center"><br/><font class="textblackth">Do you wish to continue?<br><br></font></td></tr>
						<TR><TD align="center"><div class="hr"></div><% out.println(Skew.showInputScreen(request)); %></td></tr>
						<TR>
							<TD align="center">
								<br />
								<input type="hidden" value="<%=kix%>" name="kix">
								<input type="hidden" value="<%=alpha%>" name="alpha">
								<input type="hidden" value="<%=num%>" name="num">
								<input type="hidden" value="<%=comments%>" name="comments">
								<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
								<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
								<input type="hidden" value="c" name="formAction">
								<input type="hidden" value="aseForm" name="formName">
							</TD>
						</TR>
				<%

				} // valid

			%>
		</TBODY>
	</TABLE>
</form>

<%
	}
%>

<br>
<%
	if (processPage){
		if ( alpha.length() > 0 && num.length() > 0 ){
			out.println("<table border=0 width=\"100%\">" );
			String sql = "";
			sql = aseUtil.getPropertySQL( session, "crsprereqidx" );
			if ( sql != null && sql.length() > 0 ){
				out.println("<tr class=tableCaption align=left><td colspan=2><font class=textblackTH>Pre-Requisites</font>" );

				sql = aseUtil.replace(sql, "_sql_", campus);
				sql = aseUtil.replace(sql, "_alpha_", alpha);
				sql = aseUtil.replace(sql, "_num_", num);
				sql = aseUtil.replace(sql, "_type_", "CUR");

				paging = null;

				com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
				out.println(jqPaging.showTable(conn,sql,"","crsprereqidx"));
				jqPaging = null;

				out.println("</td></tr>" );
			}

			out.println("<tr align=left><td colspan=2>&nbsp;</td></tr>" );

			sql = aseUtil.getPropertySQL( session, "crscoreqidx" );
			if ( sql != null && sql.length() > 0 ){
				out.println("<tr class=tableCaption align=left><td colspan=2><font class=textblackTH>Co-Requisites</font>" );
				sql = aseUtil.replace(sql, "_sql_", campus);
				sql = aseUtil.replace(sql, "_alpha_", alpha);
				sql = aseUtil.replace(sql, "_num_", num);
				sql = aseUtil.replace(sql, "_type_", "CUR");

				paging = null;

				com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
				out.println(jqPaging.showTable(conn,sql,"","crscoreqidx"));
				jqPaging = null;

				out.println("</td></tr>" );
			}
			out.println("</table>" );
		}
	}

	asePool.freeConnection(conn,"crsdltxy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
