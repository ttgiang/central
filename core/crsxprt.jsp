<%@ page session="true" buffer="16kb" import="java.util.*,java.util.regex.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsxprt.jsp		exporting
	*
	* copy from web content to textpad
	* save as text
	* import to excel
	*
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Export Outlines";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%
	StringBuffer data = new StringBuffer();
	String descr = "";
	String ending = "";
	String delimiter = "~";

	String sql = aseUtil.getPropertySQL(session,"export");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1, campus);
	ResultSet rs = ps.executeQuery();
	while (rs.next()){
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("CourseAlpha")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("CourseNum")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("dispID")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("Division")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("coursetitle")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("credits")).trim() + delimiter + ",");
		data.append(delimiter + aseUtil.nullToBlank(rs.getString("effectiveterm")).trim() + delimiter + ",");

		descr = website.clearHTMLTags(aseUtil.nullToBlank(rs.getString("coursedescr")).trim());
		data.append(delimiter + descr + delimiter + ",");

		descr = website.clearHTMLTags(aseUtil.nullToBlank(rs.getString("prereq")).trim());
		data.append(delimiter + descr + delimiter + ",");

		descr = website.clearHTMLTags(aseUtil.nullToBlank(rs.getString("coreq")).trim());
		data.append(delimiter + descr + delimiter + ",");

		descr = website.clearHTMLTags(aseUtil.nullToBlank(rs.getString("recprep")).trim());
		data.append(delimiter + descr + delimiter);

		ending = data.toString().replace("&nbsp;&nbsp;"," ");
		ending = data.toString().replace("&nbsp;"," ");
		ending = ending.replace("\"","\'");
		ending = ending.replace("&amp;","&");
		ending = ending.replace("<br>","\n\r");
		ending = ending.replace("<br/>","\n\r");
		out.println(ending+"<br/>");
		data.setLength(0);
	}
	rs.close();
	ps.close();
	asePool.freeConnection(conn);
%>

</body>
</html>