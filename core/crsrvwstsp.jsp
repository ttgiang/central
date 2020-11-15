<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwstsp.jsp - outline reviewers
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Reviewers";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

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
				"aaSorting": [ [1,'asc'], [3,'asc'] ],
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '70%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%
	String helpButton = website.getRequestParameter(request,"help");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		route = NumericUtil.nullToZero(info[6]);
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	String level = website.getRequestParameter(request,"lvl","1");

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

%>
<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
	<tr><td align="center" class="textblackthcenter">
		<%
			out.println(pageTitle + "<br>");
			out.println(courseDB.setPageTitle(conn,"",alpha,num,campus));
		%>
	</td></tr>
</table>
<p>
NOTE: The following reviewers have not completed reviewing <%=alpha%>&nbsp;<%=num%>.
<p/>

<%

	String allowReviewInReview = Util.getSessionMappedKey(session,"AllowReviewInReview");
	if(allowReviewInReview.equals(Constant.ON)){
		String sql = aseUtil.getPropertySQL( session,"reviewers3");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_lvl_", level);
			paging = null;
			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			out.print("<TR><td class=\"textblackth\">" + jqPaging.showTable(conn,sql,"") + "</td></tr>");
			jqPaging = null;
		}
	}
	else{

		String reviewers = ReviewerDB.getReviewerNames(conn,campus,alpha,num);

		if (reviewers != null && reviewers.length() > 0){
			reviewers = reviewers.replace(",","<br/>");
			out.println("<font class=\"datacolumn\">" + reviewers + "</font>");
		}
	}

	asePool.freeConnection(conn,"crsrvwstsp",user);

	if ( helpButton.equals("1")){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

</body>
</html>

