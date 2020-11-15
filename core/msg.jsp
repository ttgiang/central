<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	msg.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	/*
		servlets will call this file to display messages from
		any maintenance results. If rtn is available, it's because
		the maintenance was successful and rtn would be the
		page to send the user to.
	*/
	String rtn = website.getRequestParameter(request,"rtn","");
	String idx = website.getRequestParameter(request,"idx","");
	String noMsg = website.getRequestParameter(request,"nomsg","");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String type = website.getRequestParameter(request,"type","");
	String aseException = (String)session.getAttribute("aseException");

	String alpha = "";
	String num = "";
	String temp = "";
	String junk = "";

	String kix = website.getRequestParameter(request,"kix", "");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	if (type == null || type.equals(Constant.BLANK))
		type = (String)session.getAttribute("aseType");

	if (type == null || type.equals(Constant.BLANK))
		type = "PRE";

	String linkMessage = "return to previous page";
	String linkMessage2 = "";

	String exception = (String)session.getAttribute("aseException");
	String message = (String)session.getAttribute("aseApplicationMessage");
	if (message==null)
		message = "";

	int qn = 0;
	int c = 0;

	int md = website.getRequestParameter(request,"md",0);

%>

<%@ include file="pages.jsp" %>

<%
	if (rtn.length() > 0){
		if ( rtn.equals("alphaidx") )						{codeName = ALPHAIDX;}
		else if (rtn.equals("appridx") )					{codeName = APPRIDX;}
		else if (rtn.equals("crsappr") )					{codeName = CRSAPPR;}
		else if (rtn.equals("crsappr_comments") )		{codeName = CRSRVWER;}
		else if (rtn.equals("crsassr") )					{codeName = CRSASSR;}
		else if (rtn.equals("crscan") )					{codeName = CRSCAN;}
		else if (rtn.equals("crscanappr") )				{codeName = CRSCANAPPR;}
		else if (rtn.equals("crscanslo") )				{codeName = CRSCANSLO;}
		else if (rtn.equals("crscmnt") )					{codeName = CRSCMNT;}
		else if (rtn.equals("crscmp") )					{codeName = CRSCMP;}
		else if (rtn.equals("crscmpz") )					{codeName = CRSCMPZ;}
		else if (rtn.equals("crscmpzz") )				{codeName = CRSCMPZZ;}
		else if (rtn.equals("crsedt") )					{codeName = CRSEDT;}
		else if (rtn.equals("crsfldy") )					{codeName = CRSFLDY;}
		else if (rtn.equals("crsrvwer") )				{codeName = CRSRVWER;}
		else if (rtn.equals("crsslo") )					{codeName = CRSSLO;}
		else if (rtn.equals("crssloappr") )				{codeName = CRSSLOAPPR;}
		else if (rtn.equals("crssloapprcan") )			{codeName = CRSSLOAPPRCAN;}
		else if (rtn.equals("prgappr_comments") )		{codeName = PRGRVWER;}
		else if (rtn.equals("prgcmnt") )					{codeName = PRGCMNT;}
		else if (rtn.equals("prgedt") )					{codeName = PRGEDT;}
		else if (rtn.equals("profile") )					{codeName = PROFILE;}
		else if (rtn.equals("slostrt") )					{codeName = SLOSTRT;}
		else if (rtn.equals("sylidx") )					{codeName = SYLIDX;}
		else if (rtn.equals("shwfld") )					{codeName = SHWFLD;}
		else if (rtn.equals("usrtsks") )					{codeName = USRTSKS;}
		else if (rtn.equals("lstappr") )					{codeName = LSTAPPR;}
		else if (rtn.equals("fndappr_comments") )		{codeName = FNDRVWER;}
		else if (rtn.equals("fndrvwer") )				{codeName = FNDRVWER;}
		else if (rtn.equals("fndcmnt") )					{codeName = FNDCMNT;}
		else{
			codeName = -1;
		}
	}

	switch (codeName){
		case ALPHAIDX:
			rtn = "alphaidx.jsp?";
			break;
		case APPRIDX:
			String route = website.getRequestParameter(request,"route", "0");
			rtn = "appridx.jsp?route="+route;
			break;
		case APPRL:
			break;
		case CRSAPPR:
			noMsg = "1";
			rtn = null;
			break;
		case CRSASSR:
			rtn = "crsassr.jsp?alpha=" + alpha + "&num=" + num + "&campus=" + campus + "&view=PRE";
			break;
		case CRSCAN:
			rtn = null;
			break;
		case CRSDLT: break;
		case CRSEDT:
			String questionTab = (String)session.getAttribute("aseQuestionTab");
			String questionNo = (String)session.getAttribute("aseQuestionNo");

			linkMessage = "Continue to outline modifications";

			if (aseException != null && "Exception".equals(aseException))
				linkMessage = "";

			rtn = "crsedt.jsp?z=1";

			break;
		case CRSRVWER:

			if (rtn.equals("crsappr_comments"))
				rtn = "crsappr.jsp?hix=" + kix;
			else
				rtn = "crsrvwer.jsp?alpha=" + alpha + "&num=" + num;

			break;
		case FNDRVWER:

			if (rtn.equals("fndappr_comments"))
				rtn = "fndappr.jsp?hix=" + kix;
			else
				rtn = "fndrvwer.jsp?hix=" + kix;

			break;
		case CRSSLO:
			rtn = null;
			break;
		case CRSCANAPPR:
			rtn = null;
			break;
		case CRSCMPZ:
			rtn = rtn + ".jsp?jsid="+(String)session.getId();

			if (!"Exception".equals(exception)){

				if (rtn.indexOf("md=") < 0)
					rtn = rtn + "&md=" + md;

				response.sendRedirect("/central/core/" + rtn);
			}
			else
				rtn = rtn + ".jsp?jsid="+(String)session.getId();

			break;
		case CRSRWSLO: break;
		case CRSCANSLO:
			rtn = null;
			break;
		case CRSCMP:
			rtn = null;
			break;
		case CRSCMNT:
			qn = website.getRequestParameter(request,"qn",0);
			c = website.getRequestParameter(request,"c",0);
			rtn = rtn + ".jsp?qn="+qn+"&c="+c+"&md="+md;
			break;
		case FNDCMNT:
			qn = website.getRequestParameter(request,"qn",0);
			int sq = website.getRequestParameter(request,"sq",0);
			int en = website.getRequestParameter(request,"en",0);
			rtn = rtn + ".jsp?sq="+sq+"&en="+en+"&qn="+qn+"&c="+Constant.TAB_FOUNDATION+"&md="+md;
			break;
		case CRSCMPZZ:
			rtn = null;
			break;
		case CRSFLDY:
			rtn = rtn + ".jsp?x=0";
			break;
		case CRSSLOAPPRCAN:
			rtn = null;
			break;
		case CRSSLOAPPR:
			rtn = null;
			break;
		case LSTAPPR:

			rtn = "/central/core/lstappr.jsp?kix="+kix+"&s=99";

			if (rtn.indexOf("md=") < 0)
				rtn = rtn + "&md=" + md;

			response.sendRedirect(rtn);

			break;
		case LSTPREREQ: break;
		case PRGRVWER:

			if ("prgappr_comments".equals(rtn))
				rtn = "prgappr.jsp?hix=" + kix;

			break;
		case PRGCMNT:
			qn = website.getRequestParameter(request,"qn",0);
			c = website.getRequestParameter(request,"c",0);
			rtn = rtn + ".jsp?qn="+qn+"&c="+c+"&md="+md;

			if (md==Constant.REVIEW || md==Constant.REVIEW_IN_APPROVAL){
				temp = "prgrvwer";
				junk = "review";
			}
			else{
				temp = "prgappr";
				junk = "approval";
			}

			linkMessage2 = "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
							+ "<a href=\"/central/core/"+temp+".jsp?kix="+kix+"\" class=\"linkcolumn\">return to program " + junk + "</a>";
			break;
		case PRGEDT:
			linkMessage = "Continue to program modifications";

			if (aseException != null && "Exception".equals(aseException))
				linkMessage = "";

			rtn = "prgedt.jsp?z=1";

			break;
		case PROFILE:
			linkMessage = "<a href=\"/central/core/tasks.jsp\" class=\"linkcolumn\">view tasks</a>&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;" +
				"<a href=\"/central/core/index.jsp\" class=\"linkcolumn\">view news</a>&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;" +
				"<a href=\"/central/core/usrprfl.jsp\" class=\"linkcolumn\">return to profile</a>";
			break;
		case SHWFLD:
			linkMessage = "Continue to outline modifications";

			if (aseException != null && "Exception".equals(aseException))
				linkMessage = "";

			break;
		case SLOSTRT:
			rtn = null;
			break;
		case SYLIDX:
			kix = "";
			rtn = rtn + ".jsp";
			break;
		case USRTSKS:
			kix = "";
			noMsg = "0";
			String sid = website.getRequestParameter(request,"sid","");
			rtn = rtn + ".jsp?sid="+sid;
			linkMessage = "return to user tasks";
			break;
		case VWSLO: break;
		case DEFAULT:
		default:
			kix = "";
			rtn = rtn + ".jsp";
	}	// switch
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	out.println(message);

	if (noMsg.equals(Constant.OFF) || noMsg.equals(Constant.BLANK)){
		if (!kix.equals(Constant.BLANK) && !rtn.equals(Constant.BLANK)){
			if (codeName==CRSFLDY){

				if (rtn.indexOf("md=") < 0){
					rtn = rtn + "&md=" + md;
				}

				response.sendRedirect("/central/core/" + rtn + "&kix=" + kix);
			}
			else{

				rtn = rtn + "&kix=" + kix;

				// ER00019 - allow return to item we were working on
				if (codeName==CRSRVWER || codeName==PRGRVWER || codeName==FNDRVWER){
					String bookmark = (String)session.getAttribute("aseReviewApprovalItem");
					if(bookmark != null){
						rtn = rtn + "#" + bookmark;
					}
				}

				out.println( "<br><br><a href=\"/central/core/" + rtn + "\" class=\"linkcolumn\">"
								+ linkMessage
								+ "</a>"
								+ linkMessage2 );
			}
		}
		else{
			if(!idx.equals(Constant.BLANK)){
				idx = "?idx="+idx;
			}
			out.println( "<br><br><a href=\"/central/core/" + rtn + idx + "\" class=\"linkcolumn\">" + linkMessage + "</a>" );
		}
	}
	else{
		if (rtn != null && rtn.equals("profile")){
			out.println( "<br><br>" + linkMessage );
		}
	}

	// clear out current message
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"msg",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>