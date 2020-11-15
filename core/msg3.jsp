<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	msg3.jsp	- to get exactly to the right condition
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix","");
	String rtn = website.getRequestParameter(request,"rtn","");

	// from linkerservlet and reorderservlet
	String src = website.getRequestParameter(request,"src","");
	String dst = website.getRequestParameter(request,"dst","");
	String itm = website.getRequestParameter(request,"itm","");

	String cde = website.getRequestParameter(request,"cde","");

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	String message = "";
	String alpha = "";
	String num = "";
	String type = "";
	String align = "";
	String link = "";
	String returnPage = "";

	int codeName = 0;

	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}

	if (rtn.length() > 0){
		if (rtn.equals("crsedt"))
			codeName = 0;
		else if (rtn.equals("crslnks"))
			codeName = 1;
		else if (rtn.equals("crsrdr"))
			codeName = 2;
		else if (rtn.equals("modify"))
			codeName = 3;
		else if (rtn.equals("crsfstrk"))
			codeName = 4;
		else if (rtn.equals("qlst"))
			codeName = 5;
		else if (rtn.equals("crsgen"))
			codeName = 6;
		else if (rtn.equals("index"))
			codeName = 7;
		else if (rtn.equals("crscntnt"))
			codeName = 8;
		else if (rtn.equals("crspslo"))
			codeName = 9;
		else if (rtn.equals("ini"))
			codeName = 10;
		else if (rtn.equals("qlst2crslnks"))
			codeName = 11;
		else if (rtn.equals("crslnkdxx"))
			codeName = 12;
		else if (rtn.equals("ccslocrslnks"))
			codeName = 13;
		else if (rtn.equals("crsqlst"))
			codeName = 14;
		else if (rtn.equals("appridx"))
			codeName = 15;
		else if (rtn.equals("fndedt"))
			codeName = 16;
		else
			codeName = -1;
	}

	align = "left";

	switch (codeName){
		case 0:
			if (cde.equals("CONFLICT")){
				message = "<b>OUTLINE CONFLICT</b><br><br>"
					+ "<b>" + alpha + " " + num + "</b> "
					+ "may not be modified at this time because it is currently going through the approval process.<br/>"
					+ "If you want to modify the outline, you must first cancel the approval process. If you feel the <br/>"
					+ "task was incorrectly assigned and should be deleted, contact your campus administrator.";
			}
			else if ("NOACCESS".equals(cde)){
				message = "<strong>NO ACCESS TO OUTLINE MODIFICATION</strong><br><br>"
					+ "You do not have access to modify <b>" + alpha + " " + num + "</b>.<br/>"
					+ "If <strong>" + alpha + "</strong> is part of what you have access to modify, consider updating your <a href=\"usrprfl.jsp\" class=\"linkcolumn\">profile</a>.";
			}

			break;
		case 1:
			align = "center";
			msg = (Msg)session.getAttribute("aseMsg");
			if (!"Exception".equals(msg.getMsg()))
				message = msg.getMsg();
			else
				message = "Unable to complete requested operation.";

			//?z=1 is a wash
			rtn = rtn + ".jsp?z=1";

			if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){
				rtn = "crscntnt.jsp?z=1";
				returnPage = "return to Course Content screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

			}
			else if (src.equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
				rtn = "crscmp.jsp?s=c";
				returnPage = "return to Course Level SLO screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

			}
			else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_SLO)){
				rtn = "crscmp.jsp?s=c";
				returnPage = "return to Program SLO screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO)){
				rtn = "crscmp.jsp?s=c";
				returnPage = "return to Institution Learning Outcomes screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_GESLO)){
				rtn = "crscmp.jsp?s=c";
				returnPage = "return to Institution Learning Outcomes screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>";
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
				returnPage = "return to Course Competency screen";
				message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"&src="+src+"&dst="+dst+"\" class=\"linkcolumn\">"+returnPage+"</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

			}

			break;
		case 2:
			align = "center";
			msg = (Msg)session.getAttribute("aseMsg");
			if (!"Exception".equals(msg.getMsg()))
				message = "Operation completed successfully.";
			else
				message = "Unable to complete requested operation.";

			int list = 	website.getRequestParameter(request,"l",0);
			switch(list){
				case Constant.COURSE_ITEM_PREREQ:
					link = "&s=c";
					rtn = "crsreq.jsp";
					break;
				case Constant.COURSE_ITEM_COREQ:
					link = "&s=c";
					rtn = "crsreq.jsp";
					break;
				case Constant.COURSE_ITEM_SLO:
					link = "&s=c";
					rtn = "crscmp.jsp";
					break;
				case Constant.COURSE_ITEM_CONTENT:
					link = "&s=c";
					rtn = "crscntnt.jsp";
					break;
				case Constant.COURSE_ITEM_COMPETENCIES:
					link = "&s=c&z=1&src="+src+"&dst="+dst;
					rtn = "crslnks.jsp";
					break;
				case Constant.COURSE_ITEM_COURSE_RECPREP:
					link = "&s=c&z=1&src="+src+"&dst="+dst;
					rtn = "crsxtr.jsp";
					break;
				case Constant.COURSE_ITEM_PROGRAM_SLO:
					link = "&s=c&z=1&src="+src+"&dst="+dst;
					rtn = "crsgen.jsp";
					break;
				case Constant.COURSE_ITEM_ILO:
					link = "&s=c&z=1&src="+src+"&dst="+dst;
					rtn = "crsgen.jsp";
					break;
				case Constant.COURSE_ITEM_GESLO:
					link = "&s=c&z=1&src="+src+"&dst="+dst;
					rtn = "crsgen.jsp";
					break;
			}

			message += "<br/><br/><a href=\"/central/core/"+rtn+"?kix="+kix+link+"\" class=\"linkcolumn\">return to previous page</a>";

			break;
		case 3:
			String proposer = website.getRequestParameter(request,"p","");
			message = "You are not authorized to modify this outline.<br><br>"
				+ proposer + " is the proposer and is the only person with modify rights to <b>" + alpha + " " + num + "</b>.";
			break;
		case 4:
			align = "center";

			// during fast track and the outline has been approved, return to view more statuses
			if (!courseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE"))
				rtn = "crssts.jsp?z=1";
			else
				rtn = rtn + ".jsp?z=1";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"&kix="+kix+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 5:
			align = "center";
			rtn = rtn + ".jsp";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 6:
			align = "center";
			rtn = rtn + ".jsp?kix="+kix+"&src="+src;

			returnPage = "return to previous screen";
			if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO))
				returnPage = "return to Program SLO screen";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">"+returnPage+"</a>"
				+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

			if(caller.equals("crsfldy")){
				message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
			}
			else{
				message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
			}

			session.setAttribute("aseApplicationMessage","");

			break;
		case 7:
			align = "center";
			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			session.setAttribute("aseApplicationMessage","");
			break;
		case 8:
			align = "center";
			rtn = rtn + ".jsp?kix="+kix+"&src="+src;

			returnPage = "return to Course Content screen";
			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">"+returnPage+"</a>"
				+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

			if(caller.equals("crsfldy")){
				message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
			}
			else{
				message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
			}

			session.setAttribute("aseApplicationMessage","");

			break;
		case 9:
			align = "center";
			rtn = rtn + ".jsp";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 10:
			align = "center";
			rtn = rtn + ".jsp";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 11:
			align = "center";

			if (itm.equals(Constant.COURSE_OBJECTIVES))
				rtn = "crscmp.jsp?kix=" + kix + "&s=c";
			else if (itm.equals(Constant.COURSE_CONTENT))
				rtn = "crscntnt.jsp?kix=" + kix + "&src=" + itm + "&dst=" + itm;
			else if (itm.equals(Constant.COURSE_COMPETENCIES))
				rtn = "crslnks.jsp?kix=" + kix + "&src=" + itm + "&dst=" + itm;
			else if (itm.equals(Constant.COURSE_PROGRAM_SLO) || itm.equals(Constant.IMPORT_PLO))
				rtn = "crsgen.jsp?kix=" + kix + "&src=" + itm + "&dst=" + itm;
			else if (itm.equals(Constant.COURSE_INSTITUTION_LO) || itm.equals(Constant.IMPORT_ILO))
				rtn = "crsgen.jsp?kix=" + kix + "&src=" + itm + "&dst=" + itm;
			else if (itm.equals(Constant.COURSE_GESLO))
				rtn = "crsgen.jsp?kix=" + kix + "&src=" + itm + "&dst=" + itm;

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 12:
			align = "center";
			rtn = rtn + ".jsp";

			String level1 = website.getRequestParameter(request,"level1","");
			String level2 = website.getRequestParameter(request,"level2","");

			if (level1 != null && level1.length() > 0){
				returnPage = "return to Linked Outline Items screen";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true);
				message += "<br/><br/><a href=\"/central/core/"+rtn
					+"?src="+src
					+"&dst="+dst
					+"&kix="+kix
					+"&level1="+level1
					+"&level2="+level2+"\" class=\"linkcolumn\">return to Linked Outline Items screen</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

			}
			else{
				returnPage = "return to Linked Outline Item screen";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true);
				message += "<br/><br/><a href=\"/central/core/"+rtn
					+"?src="+src
					+"&dst="+dst
					+"&kix="+kix+"\" class=\"linkcolumn\">return to Linked Outline Items screen</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

			}

			break;
		case 13:
			align = "center";
			rtn = "ccslo.jsp";

			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">return to previous page</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
		case 14:
			align = "center";
			rtn = rtn + ".jsp";
			returnPage = "Return to Quick List Entry";
			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">"+returnPage+"</a>";

			session.setAttribute("aseApplicationMessage","");

			break;

		case 15:

			int route = website.getRequestParameter(request,"route",0);

			align = "center";
			rtn = rtn + ".jsp?route="+route;
			returnPage = "Return to approval sequence";
			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">"+returnPage+"</a>";

			session.setAttribute("aseApplicationMessage","");

			break;

		case 16:

			align = "center";
			int id = website.getRequestParameter(request,"id",0);
			returnPage = "Return to foundation course edit";
			message = website.getRequestParameter(request,"aseApplicationMessage","",true);
			message += "<br/><br/><a href=\"/central/core/fndedt.jsp?id="+id+"\" class=\"linkcolumn\">"+returnPage+"</a>";

			session.setAttribute("aseApplicationMessage","");

			break;
	}

	asePool.freeConnection(conn,"msg3",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tbody>
		<tr>
			<td width="10%">&nbsp;</td>
			<td align="<%=align%>"><%=message%></td>
			<td width="10%">&nbsp;</td>
		</tr>
	</tbody>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
