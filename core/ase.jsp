<%
	/**
	*	ASE
	*	ase.jsp
	*	2007.09.01	main drive to check on various settings
	**/

	String fieldsetTitle = "";

	if (com.ase.aseutil.session.SessionCheck.checkSession(request).equals("")){
		response.sendRedirect("login.jsp");
	}
	else{
		session.setAttribute("aseThisPage","");
		session.setAttribute("aseConfig","");
		session.setAttribute("aseConfigMessage","");
	}

%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/db.jsp" %>

<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="helper" scope="application" class="com.ase.aseutil.Helper" />
<jsp:useBean id="log" scope="application" class="com.ase.aseutil.ASELogger" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />
<jsp:useBean id="outlines" scope="application" class="com.ase.aseutil.Outlines" />
<jsp:useBean id="paging" scope="application" class="com.ase.paging.Paging" />
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
