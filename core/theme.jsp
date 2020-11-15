<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "tasks";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Task Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/modal/modal.jsp" %>

   <script type="text/javascript">
	//<![CDATA[

		$().ready(function(){
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			$( "#dialog:ui-dialog" ).dialog( "destroy" );

			$( "#dialog-form" ).dialog({
				autoOpen: false,
				height: 700,
				width: 960,
				modal: true,
			});

			$('#ase').click(function() {
				$( "#dialog-form" ).dialog( "open" );
			});

			// table theme
			$("#asePager th").each(function(){
				$(this).addClass("ui-state-default");
			});

			$("#asePager td").each(function(){
				$(this).addClass("ui-widget-content");
			});

			$("#asePager tr").hover(
				function(){
					$(this).children("td").addClass("ui-state-hover");
				},
				function(){
					$(this).children("td").removeClass("ui-state-hover");
				}
			);

			$("#asePager tr").click(function(){
				$(this).children("td").toggleClass("ui-state-highlight");
			});
			// table theme

		});  // main function

   //]]>
   </script>



</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		if (!user.equals(Constant.BLANK) && processPage){
			out.println(TaskDB.showUserTasks(conn,campus,user));
		}
	}

	asePool.freeConnection(conn,"tasks",user);
%>

<%@ include file="./js/modal/taskdescr.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
