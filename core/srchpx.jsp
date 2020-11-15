<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	srchpx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central Program Search";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<%@ include file="ase2.jsp" %>

<%
	if (processPage){

		String txt1 = website.getRequestParameter(request,"txt1","");
		String txt2 = website.getRequestParameter(request,"txt2","");
		String txt3 = website.getRequestParameter(request,"txt3","");
		String term = website.getRequestParameter(request,"term","");
		String radio1 = website.getRequestParameter(request,"radio1","");
		String radio2 = website.getRequestParameter(request,"radio2","");
		String type = website.getRequestParameter(request,"type","");
		String cps = website.getRequestParameter(request,"cps","");

		boolean debug = false;
		if(debug){
			txt1 = "program";
			txt2 = "";
			txt3 = "";
			term = "fall 2012";
			radio1 = "";
			radio2 = "";
			type = "";
			cps = "";
		}

		if (!txt1.equals(Constant.BLANK)){
			out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			out.println(com.ase.aseutil.util.SearchDB.searchPrograms(conn,campus,cps,type,txt1,txt2,txt3,radio1,radio2,term));
			out.println("</td>");
			out.println("</tr>");
			out.println("</table></div>");
		}

	} // processPage

	asePool.freeConnection(conn,"srchpx",user);

%>

