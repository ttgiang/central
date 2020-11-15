<html>
<head><title>jsp direct</title></head>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="ase.aseutil.*"%>
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />

<body>

<%
	String[] blackList = {"--",";--",";","/*","*/","@@","@",
								 "char","nchar","varchar","nvarchar",
								 "alter","begin","cast","create","cursor","declare","delete","drop","end","exec","execute",
								 "fetch","insert","kill","open",
								 "select", "sys","sysobjects","syscolumns",
								 "table","update",
								 "' or 1=1--",
								 "\" or 1=1--",
								 "or 1=1--",
								 "' or 'a'='a",
								 "\" or \"a\"=\"a",
								 ") or ('a'='a"
								 };


	int listLen = blackList.length;
	String temp = "";
	boolean equals = false;

	for (int i=0;i<listLen;i++){
		temp = website.cleanSQLX(blackList[i]);
		equals = temp.equals(blackList[i]);
		if (!equals)
			out.println(i + ": " + blackList[i] + " || " + temp + " || " + "<br>");
	}

%>

</body>
</html>