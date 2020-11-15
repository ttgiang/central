<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	talin.jsp	- reads session message and display
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	// program servlet sent kix back
	String kix = website.getRequestParameter(request,"kix","");
	String ack = website.getRequestParameter(request,"ack","");

	String[] info = helper.getKixInfo(conn,kix);
	String type = info[Constant.KIX_TYPE];

	String exception = (String)session.getAttribute("aseException");
	String message = (String)session.getAttribute("aseApplicationMessage");

	if (message==null)
		message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '05%' },
					{ sWidth: '25%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td valign="top" align="left">
			<%
				if (kix != null && !"null".equals(kix) && kix.length() > 0){
					if (ack.equals("crt")){
						response.sendRedirect("/central/core/prgedt.jsp?kix="+kix);
					}
					else if (ack.equals("dlt")){
						// response.sendRedirect("/central/core/prgdlt.jsp");
						// display message is all that's needed
					}
					else if (ack.equals("can")){
						// response.sendRedirect("/central/core/prgdlt.jsp");
						// display message is all that's needed
					}
					else if ("updt".equals(ack)){
						message = message
								+ Html.BR()
								+ Html.BR()
								+ "<a href=\"/central/core/prgedt.jsp?type="+type+"&kix="+kix+"\" class=\"linkcolumn\">modify program</a>"
								+ "<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
								+ "<a href=\"/central/core/prgvw.jsp?type="+type+"&kix="+kix+"\" class=\"linkcolumn\">view program</a>";
					}
				}
			%>
		</td>
	</tr>
</table>

<%
	out.println(message);

	session.setAttribute("aseApplicationMessage","");

	if (processPage){

		out.println(Html.BR() + Html.BR());

		String title = (String)session.getAttribute("aseProgramTitle");
		String degree = (String)session.getAttribute("aseProgramDegree");
		String division = (String)session.getAttribute("aseProgramDivision");

		if (title != null && degree != null && division != null){
			String sql = aseUtil.getPropertySQL(session,"prgidx0");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
				sql = aseUtil.replace(sql, "_title_", title);
				sql = aseUtil.replace(sql, "_divid_", division);
				sql = aseUtil.replace(sql, "_id_", degree);

				com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
				jqPaging.setUrlKeyName("kix");
				out.println(jqPaging.showTable(conn,sql,"/central/core/prgvw.jsp?type="));
				jqPaging = null;
			}
		}

		session.setAttribute("aseProgramTitle",null);
		session.setAttribute("aseProgramDegree",null);
		session.setAttribute("aseProgramDivision",null);
	}

	paging = null;

	asePool.freeConnection(conn,"talin",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

