3<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnmy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String thisPage = "crsrnm";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String message = "";

	String fromAlpha = website.getRequestParameter(request,"fromAlpha","");
	String fromNum = website.getRequestParameter(request,"fromNum","");
	String toAlpha = website.getRequestParameter(request,"toAlpha","");
	String toNum = website.getRequestParameter(request,"toNum","");
	String type = website.getRequestParameter(request,"type","");
	String justification = website.getRequestParameter(request,"justification","");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",fromAlpha,fromNum,campus);
	fieldsetTitle = "Rename Outline";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	String kix = website.getRequestParameter(request,"kix","");
	String ts = website.getRequestParameter(request,"ts","");
	String no = website.getRequestParameter(request,"no","");

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
									+	"key5="+type+","
									+	"key6="+formName+","
									+	"key7="+formAction+","
									+	"key8="+ts+"-"+no+","
									+	"key9="+justification));

		response.sendRedirect("/central/servlet/rnm");
	}

	asePool.freeConnection(conn,"crsrnmy",user);
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
		<TR>
			<TD class="textblackth">From:&nbsp;</td>
			<td class="datacolumn"><%=fromAlpha%>&nbsp;<%=fromNum%></td>
		</tr>
		<tr>
			<td class="textblackth">To:&nbsp;</td>
			<td class="datacolumn"><%=toAlpha%>&nbsp;<%=toNum%></td>
		</tr>
	</tbody>
</table>
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
