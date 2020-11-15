<%@ page import="com.ase.paging.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crsmodezz.jsp	mode maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
	String process = website.getRequestParameter(request,"process", "");
	String override = website.getRequestParameter(request,"override", "0");

	boolean overRide = false;

	if ("0".equals(override))
		overRide = false;
	else
		overRide = true;

	String item = website.getRequestParameter(request,"item", "");

	String pageTitle = "Add Process Required Items - steps 4 of 4";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<script type="text/javascript" src="js/crsmode.js"></script>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<TABLE width='80%' cellspacing='1' cellpadding='2' class='tableBorder<%=session.getAttribute("aseTheme")%>' align='center'  border='0'>
	<TBODY>
		<tr>
			<td colspan="2">
				<%
					out.println(ModeDB.getProcessStep4(conn,campus,process,item,request,overRide));
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><br/>
				<a href="crsmode.jsp" class="linkcolumn">return</a> to outline process maintenance
			</td>
		</tr>
	</TBODY>
</TABLE>

<%
	asePool.freeConnection(conn,"crsmodezz",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
