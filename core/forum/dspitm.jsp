<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dspitm.jsp - print posts
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	int tab = website.getRequestParameter(request,"tab",0);
	int itm = website.getRequestParameter(request,"itm",0);

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String type = info[Constant.KIX_TYPE];

	String items = "";

	if (tab == Constant.TAB_COURSE){
		items = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'");
	}
	else if (tab == Constant.TAB_CAMPUS){
		items = aseUtil.lookUp(conn, "tblCampus", "campusitems", "campus='" + campus + "'");
		int courseTabCount = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
		itm = itm - courseTabCount;
	}
	else if (tab == Constant.TAB_PROGRAM){
		items = aseUtil.lookUp(conn, "tblCampus", "programitems", "campus='" + campus + "'");
	}

	try{
		if (items != null){

			String[] aItems = items.split(",");

			if (aItems.length > itm){

				// adjust for array
				itm = itm-1;

				String data = "";

				// get regular data
				if (tab == Constant.TAB_COURSE){
					data = courseDB.getCourseItem(conn,kix,aItems[itm]);
					data = Outlines.formatOutline(conn,aItems[itm],campus,alpha,num,type,kix,data,true,user);
				}
				else if (tab == Constant.TAB_CAMPUS){
					data = courseDB.getCampusItem(conn,kix,aItems[itm]);
					data = Outlines.formatOutline(conn,aItems[itm],campus,alpha,num,type,kix,data,true,user);
				}
				else if (tab == Constant.TAB_PROGRAM){
					data = ProgramsDB.getProgramItem(conn,kix,aItems[itm]);
				}

				out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> "
					+ "<tr> "
					+ "<td width=\"02%\">&nbsp;</td> "
					+ "<td> "
					+ "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> "
					+ "<tr><td class=\"datacolumn\">" + data + "</td></tr> "
					+ "</table>"
					+ "</td> "
					+ "<td width=\"02%\">&nbsp;</td> "
					+ "</tr> "
					+ "</table>");

			} // aItems is valid

		}
		else{
			out.println("");
		}
	}
	catch(Exception e){
		MailerDB mailerDB = new MailerDB(conn,campus,kix,user,e.toString(),"Display Collapse/Expand Item");
	}

	asePool.freeConnection(conn,"dspitm",user);
%>

