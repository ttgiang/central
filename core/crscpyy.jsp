<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscpyy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String fromCampus = website.getRequestParameter(request,"fromCampus","");
	String fromAlpha = website.getRequestParameter(request,"fromAlpha","");
	String fromNum = website.getRequestParameter(request,"fromNum","");

	String toAlpha = website.getRequestParameter(request,"toAlpha","");
	String toNum = website.getRequestParameter(request,"toNum","");
	String comments = website.getRequestParameter(request,"comments","");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix","");

	String message = "";

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "";

	pageTitle = courseDB.setPageTitle(conn,"",fromAlpha,fromNum,campus);
	fieldsetTitle = "Copy Outline";

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
									+	"key1="+fromAlpha.toUpperCase()+","
									+	"key2="+fromNum.toUpperCase()+","
									+	"key3="+toAlpha.toUpperCase()+","
									+	"key4="+toNum.toUpperCase()+","
									+	"key5="+comments+","
									+	"key6="+formName+","
									+	"key7="+formAction+","
									+	"key8="+fromCampus));

		response.sendRedirect("/central/servlet/kpy");
	}

	asePool.freeConnection(conn,"crscpyy",user);
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
<p align="center">
<TABLE cellSpacing=0 cellPadding=0 width="30%" border=0>
	<TBODY>
		<div style="visibility:visible; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
		<p align="center"><br/><br/><img src="../images/spinner.gif" alt="processing...please wait." border="0"></p>
		</div>
	</tbody>
</table>
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
