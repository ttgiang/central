<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstprereqx.jsp - outline pre req
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Pre-Requisites";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String helpButton = website.getRequestParameter(request,"help");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";
	String type = "";

	if (processPage){
		if (helpButton.equals(Constant.ON) )
			out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );

		String kix = website.getRequestParameter(request,"kix");
		if (!kix.equals(Constant.BLANK)){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}
		else{
			campus = website.getRequestParameter(request,"cps","");
			alpha = website.getRequestParameter(request,"alpha","");
			num = website.getRequestParameter(request,"num","");
			type = website.getRequestParameter(request,"t","");
			kix = helper.getKix(conn,campus,alpha,num,type);
		}

	%>
	<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
		<tr><td align="center" class="textblackthcenter">
			<%
				out.println(courseDB.setPageTitle(conn,"",alpha,num,campus));
			%>
			<br><br><%=alpha%> <%=num%> is listed as a pre-requisite for the following course outlines.
			<br><br>
		</td></tr>
	</table>

	<%
		// not sure where listOutlinePrereqsX went.Rewriting as listOutlineRequisites
		//out.println(helper.listOutlinePrereqsX(conn,kix,request,response));
		out.println(RequisiteDB.listOutlineRequisites(conn,campus,alpha,num,Constant.IMPORT_PREREQ));
	} // processPage

	asePool.freeConnection(conn,"lstprereqx",user);

	if (helpButton.equals(Constant.ON))
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>