<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfld.jsp
	*	2007.09.01	displays content of course for debugging or viewing purposes
	*	TODO	work on handling of arc and can? Most likely NOT NEEDED
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "90%";
	String pageTitle = "";
	String alpha = null;
	String num = null;
	String viewOption = null;

	alpha = website.getRequestParameter(request,"alpha");
	num = website.getRequestParameter(request,"num");;

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsfld");
	}

	viewOption = website.getRequestParameter(request,"view");;

	if ( viewOption != null && viewOption.length() > 0 )
		pageTitle = "Display " + viewOption + " Course Data";

	fieldsetTitle = pageTitle;

	// reset for next selection
	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
	session.setAttribute("aseView", null);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String temp;
	CourseFields courseFields = new CourseFields();

	if ( alpha == null ) {
		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
	}
	else{
		String campus = website.getRequestParameter(request,"campus");

		// not using sql here. only a reminder for TODO
		// it's likely that we shouldn't have to do this for ARC/CAN
		String sql = "";
		if ( "ARC".equals(viewOption) ){
			sql = "SELECT * from tblArchivesCourse WHERE campus='" + campus + "' AND coursealpha='_alpha_' AND coursenum='_num_'";
		}
		else{
			sql = "SELECT * FROM tblCourse WHERE campus='" + campus + "' AND coursealpha=_alpha_ AND coursenum=_num_ AND coursetype='" + viewOption + "'";
		}

		try{
			ArrayList list = CourseFieldsDB.getFieldMeta(conn,alpha,num,viewOption,campus);
			if ( list != null ){
				for (int i=0;i<list.size();i++){
					courseFields = (CourseFields)list.get(i);
					temp = "<br><b>" + (i+1) + ": " + courseFields.getName() + " (" + courseFields.getType() + ")</b><br><br>" + courseFields.getContent() + "<br>";
					out.println( temp );
				}
			}
			list = null;
		}
		catch( Exception e ){
			out.println( e.toString() + "<br>***" +  courseFields.getName() + "***");
		}

		out.println( "<br><hr size=\'1\'>");
		out.println( "<p align=\'center\'><a href=\'crsfld.jsp\' class=\'linkColumn\'>display another course</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class=\"linkcolumn\" href=\"index.jsp\">return to main</a></p>");
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
