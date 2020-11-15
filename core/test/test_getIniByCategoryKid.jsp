<%@ include file="ase.jsp" %>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">

<%
	out.println(IniDB.getIniByCategoryKid(conn,"Check","Check"));
	asePool.freeConnection(conn);
%>

</body>
</html>
