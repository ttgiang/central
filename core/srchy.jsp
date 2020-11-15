<%@ include file="ase.jsp" %>
<%@ page import="java.io.File"%>

<%
	/**
	*	ASE
	*	srchy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Search";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String kix = website.getRequestParameter(request,"kix","");

	if(!kix.equals(Constant.BLANK)){

		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String cps = info[Constant.KIX_CAMPUS];
		String progress = info[Constant.KIX_PROGRESS];
		String courseTitle = info[Constant.KIX_COURSETITLE];

		String profile = proposer;

		String dateText = "";
		String dateValue = "";

		boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

		if(isAProgram){
			if(type.equals(Constant.ARC)){
				dateText = "Archived on";

				dateValue = ProgramsDB.getProgramItem(conn,kix,"datedeleted");
				if(!dateValue.equals(Constant.BLANK)){
					dateText = "Deleted on";
					progress = "DELETED";
				}
				else{
					dateValue = ProgramsDB.getProgramItem(conn,kix,"auditdate");
				}
			}
			else if(type.equals(Constant.CAN)){
				dateText = "Cancelled on";
				dateValue = ProgramsDB.getProgramItem(conn,kix,"auditdate");
			}
			else if(type.equals(Constant.PRE)){
				dateText = "Last Updated";
				dateValue = ProgramsDB.getProgramItem(conn,kix,"auditdate");
			}
			else if(type.equals(Constant.CUR)){
				dateText = "Approved on";
				dateValue = ProgramsDB.getProgramItem(conn,kix,"dateapproved");
			}

			dateValue = aseUtil.ASE_FormatDateTime(dateValue,Constant.DATE_SHORT);

		}
		else{
			if(type.equals(Constant.ARC)){
				dateText = "Archived on";
				dateValue = courseDB.getCourseItemByTable(conn,kix,"coursedate",type);
			}
			else if(type.equals(Constant.CUR)){
				dateText = "Approved on";
				dateValue = courseDB.getCourseItem(conn,kix,"coursedate");
			}
			else if(type.equals(Constant.PRE)){
				dateText = "Last Updated";
				dateValue = courseDB.getCourseItem(conn,kix,"auditdate");
			}
		}

		String filename = aseUtil.getCurrentDrive()
							+ ":"
							+ com.ase.aseutil.SysDB.getSys(conn,"documents")
							+ "profiles\\"+profile.toUpperCase()+".png";

		//
		// place all code depending on 'profile' above this line
		//
		String output = "photo not available.";
		File prfl = new File(filename);
		if(!prfl.exists()){
			profile = "profile";
		}

		out.println("<table width=600 border=0 cellpadding=4 bgcolor=f0ffff>"
				+ "<tr><td width=100px rowspan=7>"
				+
				"<img src=\"/centraldocs/docs/profiles/"+profile+".png\" alt=\""+profile+"\" title=\""+profile+"\">"
				+ "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>Campus:</td><td class=\"datacolumn\">" + cps + "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>Outline:</td><td class=\"datacolumn\">" + alpha + " " + num + "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>Course Title:</td><td class=\"datacolumn\" valign=top>" + courseTitle + "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>Status:</td><td class=\"datacolumn\">" + progress + "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>Proposer:</td><td class=\"datacolumn\" valign=top>" + proposer + "</td></tr>"
				+ "<tr><td class=\"textblackth\" width=100px>"+dateText+":</td><td class=\"datacolumn\" valign=top>" + dateValue + "</td></tr>"
				+ "</table>");

	} // kix

	asePool.freeConnection(conn,"srchy",user);
%>

