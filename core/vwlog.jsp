<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwlog - view log for a particular kix
	*	2012.07.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix","");

	String alpha = "";
	String num = "";
	String type = "";

	if(kix != null && kix.length() > 0){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
		type = website.getRequestParameter(request,"type","");
		kix = helper.getKix(conn,campus,alpha,num,type);
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				"bLengthChange": false,
				 "iDisplayLength": 999,
				 "bJQueryUI": true,
				 "aaSorting": [[6, "asc"]],
				 "bJQueryUI": true,
				 "bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '50%' },
					{ sWidth: '25%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage && !kix.equals(Constant.BLANK)){
%>
	  <div id="container90">
			<div id="demo_jui">

			<center><font class="titlemessage"><%=pageTitle%></font></center>

			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>&nbsp;</th>
							  <th align="left">UserID</th>
							  <th align="left">Action</th>
							  <th align="left">Description</th>
							  <th align="right">Date</th>
						 </tr>
					</thead>
					<tbody>
					<%
						// viewing log for a specific outline is problematic since the final approver
						// causes the kix to change from cur to arc, then pre to cur. reporting
						for(com.ase.aseutil.Generic g: UserLog.getActivities(conn,campus,kix)){
					%>
							  <tr>
								 <td align="left"><%=g.getString1()%></td>
								 <td align="left"><%=g.getString2()%></td>
								 <td align="left"><%=g.getString3()%></td>
								 <td align="left"><%=g.getString4()%></td>
								 <td align="right"><%=g.getString7()%></td>
							  </tr>
					<%
						} // for
					%>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	} // processPage

	paging = null;

	asePool.freeConnection(conn,"vwlog",user);
%>

</body>
</html>

