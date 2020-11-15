<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcany.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = website.getRequestParameter(request,"kix","");
	int id = website.getRequestParameter(request,"id",0);

	String alpha = "";
	String num = "";
	String courseTitle = "";
	String fndType = "";

	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	if (!kix.equals(Constant.BLANK)){
		String[] info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		courseTitle = info[Constant.KIX_COURSETITLE];
		fndType = info[Constant.KIX_ROUTE];
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = alpha + " " + num + " - " + courseTitle + "<br/>" + fnd.getFoundationDescr(fndType);
	fieldsetTitle = "Cancel Foundation Course";

	if (processPage){
		String skew = "0";

		if (Skew.confirmEncodedValue(request)){
			skew = "1";
		}

		session.setAttribute("aseLinker",
			Encrypter.encrypter(	"kix="+kix+","
									+	"campus="+campus+","
									+	"user="+user+","
									+	"skew="+skew+","
									+	"alpha="+alpha+","
									+	"num="+num+","
									+	"key6="+formName+","
									+	"key7="+formAction+","
									+	"key8=foundation,"
									+	"key9="+id));

		response.sendRedirect("/central/servlet/kncl");
	}

	fnd = null;

	asePool.freeConnection(conn,"fndcany",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%= message %></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

