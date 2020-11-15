<%
	/**
	*	ASE
	*	asex.jsp
	*	2007.09.01	main drive to check on various settings
	*					differs from ase in that it uses ..inc/dbx.jsp
	**/

	if (	("".equals(Encrypter.decrypter((String)session.getAttribute("aseApplicationTitle")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseCampus")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseUserName")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseDept")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseDivision")))) )
		response.sendRedirect("login.jsp");
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/dbx.jsp" %>

<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="paging" scope="application" class="com.ase.paging.Paging" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />