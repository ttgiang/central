<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwcan.jsp	- cancel outline review request
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "crsrvwcan";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	String message = "";

	String kix = website.getRequestParameter(request,"kix");

	boolean errorOnPage = false;

	//
	// used by review in review. this represents the user level
	//
	// REVIEW_IN_REVIEW
	// if level is greater than 1, we check to make sure this person
	// has reviewers in the pipeline to work with and not a URL hack
	//
	int level = website.getRequestParameter(request,"rl",0);
	if(level > 1){
		level = ReviewerDB.getReviewerLevel(conn,kix,user)+1;
	}
	else{
		if(level == 0 && user.equals(courseDB.getCourseItem(conn,kix,"proposer"))){
			level = 1;
		}
	}

	//
	//
	//
	if (processPage){
		if (!kix.equals("")){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];

			pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
			fieldsetTitle = "Cancel Outline Review";

		if (!courseDB.isCourseReviewable(conn,campus,alpha,num,user) && level < 1){
				message = "You are not authorized to cancel this outline or cancellation is not permitted at this time.";
				errorOnPage = true;
			}
		}
		else{
			response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsrvwcan.js"></script>

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

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	if (processPage && !errorOnPage){
	%>
		<form method="post" action="crsrvwcanx.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							Do you wish to continue?
							<br />
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="<%=alpha%>" name="alpha">
							<input type="hidden" value="<%=num%>" name="num">
							<input type="hidden" value="<%=level%>" name="level">
						</TD>
					</TR>
					<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
					<TR>
						<TD align="center">
							<br />
							<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
							<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
						</TD>
					</TR>

					<TR>
						<TD>
							<%
								String allowReviewInReview = Util.getSessionMappedKey(session,"AllowReviewInReview");
								if(allowReviewInReview.equals(Constant.ON)){

									String props = "reviewers";
									if(level > 1){
										props = "reviewers2";
									}

									String sql = aseUtil.getPropertySQL(session,props);
									if ( sql != null && sql.length() > 0 ){
										sql = aseUtil.replace(sql, "_alpha_", alpha);
										sql = aseUtil.replace(sql, "_num_", num);
										sql = aseUtil.replace(sql, "_level_", ""+level);
										paging = null;
										com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
										out.print("<TR><td class=\"textblackth\"><br/>Pending Reviews:<br><br>" + jqPaging.showTable(conn,sql,"") + "</td></tr>");
										jqPaging = null;
									}

								} // allowReviewInReview
							%>
						</TD>
					</TR>

				</TBODY>
			</TABLE>
		</form>
	<%
	}
	else{
		out.println(message);
	}

	asePool.freeConnection(conn,"crsrvwcan",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
