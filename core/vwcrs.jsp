<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwcrs.jsp
	*	2007.09.01	view outline.
	*				for PRE and CUR, send directly to vwcrsx since there would always
	*				be only 1 of each. For ARC, show user all the different versions
	*
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","vwcrs");

	String chromeWidth = "90%";
	String pageTitle = "View Outline";
	fieldsetTitle = pageTitle;

	String user = website.getRequestParameter(request,"aseUserName","",true);

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
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
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
	// initialize
	String table = "tblCourse";
	String historyID = null;

	// which direction did we come from
	String alpha = website.getRequestParameter(request,"alpha", "").trim();
	String num = website.getRequestParameter(request,"num", "").trim();
	String type = website.getRequestParameter(request,"t","");
	String hid = website.getRequestParameter(request,"hid","");
	String cid = website.getRequestParameter(request,"cid","");
	String rid = website.getRequestParameter(request,"rid","");

	String sendRedirect = "";

	/* it's possible to get here with a campus in the URL to say that
		we want to view another campus outline (crsinfx - outline detail)
		when empty or null, we use our own campus
	*/
	String cps = website.getRequestParameter(request,"cps","");
	if ( cps == null || cps.length() == 0 )
		cps = website.getRequestParameter(request,"aseCampus","",true);

	int lid = website.getRequestParameter(request,"lid",0);

	/*	it is possible to send in alpha/num or the table ID
		ID exists more or less because of paging

		If type is ARC, showing paging of archived courses. From there,
		send to viewer

		There are 4 possible scenarios for display outlines

		1) with the usual alpha and number. this is true for PRE and CUR
		2) lid for when viewing and there's a key field coming in from paging
		3) hid is available when viewing ARC and the history ID is sent
		4) cid is available when viewing CAN and the history ID is sent
		5) cps is available when viewing from outline detail where other campuses with same
			outline is shown
	*/

	if (processPage){

		if ( (alpha != null && num != null) || (lid > 0) || (hid != null) || (cid != null) || (rid != null)){
			// with an ID, send directly to viewer
			if (type.equals("ARC") ){
				String sql = aseUtil.getPropertySQL( session, "getArchivedOutlines" );
				if ( sql != null && sql.length() > 0 ){
					String thisCampus = website.getRequestParameter(request,"aseCampus","",true);
					sql = aseUtil.replace(sql, "%%",thisCampus);
					sql = aseUtil.replace(sql, "_alpha_", alpha);
					sql = aseUtil.replace(sql, "_num_", num);
				}

				com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
				jqPaging.setUrlKeyName("hid");
				out.println(jqPaging.showTable(conn,sql,"/central/core/vwcrs.jsp"));
				jqPaging = null;
			}
			else if ( lid > 0 ){
				sendRedirect = "vwcrsx.jsp?lid=" + lid + "&t=" + type;
			}
			else if ( hid != null && hid.length() > 0 ){
				sendRedirect = "vwcrsx.jsp?hid=" + hid;
			}
			else if (cid != null && cid.length() > 0 ){
				sendRedirect = "vwcrsx.jsp?t=CAN&cid=" + cid;
			}
			else if (rid != null && rid.length() > 0 ){
				sendRedirect = "vwcrsx.jsp?t=ARC&cid=" + rid;
			}
			else if ( cps != null && cps.length() > 0 ){
				sendRedirect = "vwcrsx.jsp?cps=" + cps + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
			}
			else{
				sendRedirect = "vwcrsx.jsp?alpha=" + alpha + "&num=" + num + "&t=" + type;
			}	// lid > 0

			response.sendRedirect(sendRedirect);

		}	// if alpha and num not null
	}	// processPage

	paging = null;

	asePool.freeConnection(conn,"vwcrs",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
