<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "apprpt";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Approval Sequence";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

    <style type="text/css">
        #report { border-collapse:collapse;}
        #report h4 { margin:0px; padding:0px;}
        #report img { float:right;}
        #report ul { margin:10px 0 10px 40px; padding:0px;}
        #report th { background:#7CB8E2 url(../images/header_bkg.png) repeat-x scroll center left; color:#fff; padding:7px 15px; text-align:left;}
        #report td { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #report tr.odd td { background:#fff url(../images/row_bkg.png) repeat-x scroll center left; cursor:pointer; }
        #report div.arrow { background:transparent url(../images/arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
        #report div.up { background-position:0px 0px;}
    </style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#report tr:odd").addClass("odd");
            $("#report tr:not(.odd)").hide();
            $("#report tr:first-child").show();

            $("#report tr.odd").click(function(){
                $(this).next("tr").toggle();
                $(this).find(".arrow").toggleClass("up");
            });
            //$("#report").jExpand();
        });
    </script>

</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);

	if (processPage){
		out.println(ApproverDB.approverRoutes(conn,campus));
	}

	asePool.freeConnection(conn,"apprpt",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

