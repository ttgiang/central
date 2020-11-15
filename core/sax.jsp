<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sax.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String task = website.getRequestParameter(request,"tsk","");
	String idx = "";
	String message = "";

	String pageTitle = "System Administrations";
	String chromeWidth = "60%";
	fieldsetTitle = pageTitle;

	if (processPage){
		String skew = "0";

		if (Skew.confirmEncodedValue(request)){
			skew = "1";
		}

		if (task.equals("fco"))
			pageTitle = "Fill Campus Outlines";
		else if (task.equals("frce") || task.equals("all") || task.equals("diff") || task.equals("pre") || task.equals("outline"))
			pageTitle = "Create HTML";
		else if (task.equals("idx")){
			pageTitle = "Create HTML";
			idx = website.getRequestParameter(request,"idx","");
		}
		else if (task.equals("sync")){
			pageTitle = "Sync campuses INI";
		}
		else{
			pageTitle = "";
		}

		String cps = website.getRequestParameter(request,"cps","").toUpperCase();
		String alpha= website.getRequestParameter(request,"alpha","").toUpperCase();
		String num = website.getRequestParameter(request,"num","").toUpperCase();
		String type = website.getRequestParameter(request,"type","").toUpperCase();
		String kix = helper.getKix(conn,cps,alpha,num,type);

		if (task.equals("outline")){
			Tables.createOutlines(cps,kix,alpha,num);
			message = "Outline created<br><br><a href=\"sa.jsp\" class=\"linkcolumn\">back to sys admin</a>";
		}
		else if (task.equals("diff")){
			Tables.createOutlines(cps,kix,alpha,num,task);
			message = "Outline differential created<br><br><a href=\"sa.jsp\" class=\"linkcolumn\">back to sys admin</a>";
		}
		else{
			session.setAttribute("aseLinker",
				Encrypter.encrypter(	"kix=,"
										+	"campus="+campus+","
										+	"user="+user+","
										+	"skew="+skew+","
										+	"key1="+task+","
										+	"key2="+idx));

			response.sendRedirect("/central/servlet/utl");
		}
	} // processPage

	asePool.freeConnection(conn,"sax",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<p align="center"><%=message%></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
