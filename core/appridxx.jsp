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

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String enableCollegeCodes = Util.getSessionMappedKey(session,"EnableCollegeCodes");

	if (processPage && enableCollegeCodes.equals(Constant.ON)){

		String sql = "";

		try{
			String cdl = website.getRequestParameter(request,"cdl","");

			String college = website.getRequestParameter(request,"c","");
			String dept = website.getRequestParameter(request,"d","");
			String level = website.getRequestParameter(request,"l","");

			String route = website.getRequestParameter(request,"r","");

			String control = "";
			String defalt = "";

			if(cdl.equals("c")){
				sql = SQL.getApproverDept(campus,college);
				control = "dept";
				defalt = dept;
			}
			else if(cdl.equals("cd")){
				sql = SQL.getApproverLevel(campus,college,dept);
				control = "level";
				defalt = level;
			}
			else if(cdl.equals("cdl")){
				sql = SQL.getApproverCDL(campus,college,dept,level);
				control = "route";
				defalt = route;
			}

			out.println(aseUtil.createSelectionBox(conn,sql,control,defalt,"","0",false,"",true,true));
		}
		catch(Exception e){
			//logger.fatal(e.toString());
		}

	}

	asePool.freeConnection(conn,"appridxx",user);

%>

