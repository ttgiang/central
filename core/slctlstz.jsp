<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

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

	if (processPage){

		try{
			String rtn = "";

			String topic = website.getRequestParameter(request,"t","");
			String subtopic = website.getRequestParameter(request,"s","");

			if(!topic.equals(Constant.BLANK) && !subtopic.equals(Constant.BLANK)){

				rtn = ValuesDB.getListByCampusSrcSubTopic(conn,campus,topic,subtopic);
			}

			out.println(rtn);
		}
		catch(Exception e){
			//logger.fatal(e.toString());
		}

	}

	asePool.freeConnection(conn,"slctlstz",user);

%>
