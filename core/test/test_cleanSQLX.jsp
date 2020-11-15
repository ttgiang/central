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
								 "char","nchar","varchar","nvarchar","alter","begin","cast",
								 "create","cursor","declare","delete","drop","end","exec","execute",
								 "fetch","insert","kill","open","select", "sys","sysobjects",
								 "syscolumns","table","update"};

	String temp = "This is an update delete test char -- @@ drop end exec";
	String tempCopy = temp.toLowerCase();
	String front = "";
	String back = "";
	int pos = 0;

	if (temp != null && temp.length() > 0){
		for(int i=0;i<blackList.length;i++){
			pos = tempCopy.indexOf(blackList[i]);
			if ( pos > 0 ){
				/*
					front is the text up to the point of our word
					back is from the end of the word to the end of the text
					temp is reassembled from the split without bad word
				*/
				front = temp.substring(0,pos);
				back = temp.substring(pos+blackList[i].length());
				temp = front + back;
			}
			tempCopy = temp;
		}
	}

	out.println(temp);

%>

</body>
</html>