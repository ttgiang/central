<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		try{
			String campus = website.getRequestParameter(request,"cs","");
			String alpha = website.getRequestParameter(request,"as","");
			String num = website.getRequestParameter(request,"ns","");
			String type = website.getRequestParameter(request,"ts","");
			String term = website.getRequestParameter(request,"fs","");

			String table = "tblcourse";
			if(type.toLowerCase().equals("arc")){
				table = "tblcoursearc";
			}

			String control = "";
			String defalt = term;

			String sql = "SELECT DISTINCT c.effectiveterm, b.TERM_DESCRIPTION "
				+ "FROM " + table + " c INNER JOIN "
				+ "BannerTerms b ON c.effectiveterm = b.TERM_CODE "
				+ "WHERE (c.campus='"+campus+"') AND (c.CourseAlpha='"+alpha+"') AND (c.CourseNum='"+num+"') AND (c.coursetype='"+type+"') "
				+ "order by c.effectiveterm ";

			out.println(aseUtil.createSelectionBox(conn,sql,control,defalt,"","0",false,"",true,true));
		}
		catch(Exception e){
			//logger.fatal(e.toString());
		}

	}

	asePool.freeConnection(conn,"crscmprz",user);

%>

