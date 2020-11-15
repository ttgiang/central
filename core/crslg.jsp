<%@ page import="com.ase.paging.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crslg.jsp - cc log
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

	String pageTitle = "CC Log";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String priority = website.getRequestParameter(request,"pri","");
	String dte = website.getRequestParameter(request,"dte","");
	String ms = website.getRequestParameter(request,"ms","");

	if ("".equals(priority))
		priority = "INFO";

	String sql = aseUtil.createStaticSelectionBox("INFO,FATAL","INFO,FATAL","pri",priority,"",""," ","INFO");
%>

<form method="post" action="?" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD>
					Priority: <%=sql%>&nbsp;
					Date: <input type="text" size="20" class="input" maxlength="20" value="<%=dte%>" name="dte">&nbsp;
					Message: <input type="text" size="40" class="input" maxlength="20" value="<%=ms%>" name="ms">&nbsp;
					<input title="continue with request" type="submit" value=" go " class="inputsmallgray">&nbsp;
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	out.println("<br/>" + SQLUtil.showUserLog(conn,priority,dte,ms,request,response));

	asePool.freeConnection(conn,"crslg",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
