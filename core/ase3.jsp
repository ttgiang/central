<%@ page session="true" buffer="16kb" import="java.util.*"%>
<%
	if (	("".equals(Encrypter.decrypter((String)session.getAttribute("aseApplicationTitle")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseCampus")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseUserName")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseDept")))) ||
			("".equals(Encrypter.decrypter((String)session.getAttribute("aseDivision")))) )
		response.sendRedirect("login.jsp");

	String styleSheet = "bluetabs";
%>
<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/style.css">
