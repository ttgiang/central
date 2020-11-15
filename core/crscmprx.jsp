<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmprx.jsp	compare outlines (with header)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Compare Outlines";
	fieldsetTitle = pageTitle;

	//SOURCE
	String cs = website.getRequestParameter(request,"cs","");	// campus
	String ts = website.getRequestParameter(request,"ts","");	// type
	String as = website.getRequestParameter(request,"as","");	// alpha
	String ns = website.getRequestParameter(request,"ns","");	// num
	String ks = website.getRequestParameter(request,"ks","");	// kix

	//DESTINATION
	String cd = website.getRequestParameter(request,"cd","");
	String td = website.getRequestParameter(request,"td","");
	String ad = website.getRequestParameter(request,"ad","");
	String nd = website.getRequestParameter(request,"nd","");
	String kd = website.getRequestParameter(request,"kd","");

	String kixSRC = "";
	String kixDST = "";

	// ks and kd are kix and take precedence over type, course alpha and course number
	if (ks.length() > 0 && kd.length() > 0){
		kixSRC = ks;
		kixDST = kd;
	}
	else{
		kixSRC = helper.getKix(conn,cs,as,ns,ts);
		kixDST = helper.getKix(conn,cd,ad,nd,td);
	}

	boolean debug = false;
	if(debug){
		System.out.println("SRC" + Html.BR());
		System.out.println("---" + Html.BR());
		System.out.println("cs: " + cs + Html.BR());
		System.out.println("ts: " + ts + Html.BR());
		System.out.println("as: " + as + Html.BR());
		System.out.println("ns: " + ns + Html.BR());
		System.out.println("ks: " + ks + Html.BR());

		System.out.println("SRC" + Html.BR());
		System.out.println("---" + Html.BR());
		System.out.println("cd: " + cd + Html.BR());
		System.out.println("td: " + td + Html.BR());
		System.out.println("ad: " + ad + Html.BR());
		System.out.println("nd: " + nd + Html.BR());
		System.out.println("kd: " + kd + Html.BR());
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="./js/crscmprx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		if (kixSRC.length() > 0 && kixDST.length() > 0){
			// this version is nice but comparing too much
			//msg = Outlines.compareOutlineWithDiff(conn,kixSRC,kixDST,user,false);

			// fix to correct SRC and DST reference
			//msg = Outlines.compareOutline(conn,kixSRC,kixDST,user,false);

			msg = TempOutlines.compareOutline(conn,kixSRC,kixDST,user,false,true);
			out.println(msg.getErrorLog());
		}
		else{
			out.println("Either SOURCE and/or DESTINATION outlines do not exist.<br/><br/>"
				+ "Click <a href=\"crscmpr.jsp\" class=\"linkcolumn\">here</a> to try again.");
		}
	}
	asePool.freeConnection(conn,"crscmprx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
