
<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dsplst.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String thisPage = "dsplst";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"../images/helpicon.gif\" border=\"0\" alt=\"show FAQ help\" title=\"show FAQ help\" onclick=\"switchMenu('forumHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// when looking at a listing of forums, we clear the session to start over
	session.setAttribute("aseKix",null);

	String src = website.getRequestParameter(request,"src","");
	String status = website.getRequestParameter(request,"status","");
	String mnu = website.getRequestParameter(request,"mnu","");

	// if we got here from the menu, blank out the data sent over from course/programs
	if (mnu.equals(Constant.ON)){
		session.setAttribute("aseOrigin",null);
	}

	session.setAttribute("aseReport","defect");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">

	<%@ include file="../datatables.jsp" %>
	<script type="text/javascript">

		$(document).ready(function () {

			oTable = $('#dsplst').dataTable({
						"bJQueryUI": true,
						"bPaginate": true,
						"iDisplayLength": 100,
						"bSort": true,
						"aoColumns": [
							{ sWidth: '5%' },
							{ sWidth: '10%' },
							{ sWidth: '5%' },
							{ sWidth: '10%' },
							{ sWidth: '5%' },
							{ sWidth: '25%' },
							{ sWidth: '10%' },
							{ sWidth: '10%' },
							{ sWidth: '10%' },
							{ sWidth: '10%' } ]
			 });

		}); // main
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>

<%@ include file="inc/header.jsp" %>

<br/><br/>

<%
	if (processPage){
		if (src == null || src.length() == 0){
			out.println(ForumDB.displayUserForum(conn,campus,user));
		}
		else{
			out.println(ForumDB.displayForum(conn,campus,src,status,user));
		}

		if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
			if (!origin.equals(Constant.COURSE) && !origin.equals(Constant.PROGRAM)){
				out.println(ForumDB.search());
			}
		}
	}

	asePool.freeConnection(conn,"dsplst",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
