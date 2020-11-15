<%@ page import="com.ase.paging.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crsmodex.jsp	mode maintenance
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

	if (override.equals(Constant.OFF))
		overRide = false;
	else
		overRide = true;

	int id = website.getRequestParameter(request,"id",0);
	String item = "";

	if (processPage){
		item = ModeDB.getItemByID(conn,campus,id);
	}

	String pageTitle = "Add Process Required Items - steps 2 of 4";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<script type="text/javascript" src="js/crsmode.js"></script>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form method="post" action="crsmodey.jsp" name="aseForm">
	<TABLE width='80%' cellspacing='1' cellpadding='2' class='tableBorder<%=session.getAttribute("aseTheme")%>' align='center'  border='0'>
		<TBODY>
			<tr>
				<td colspan="2">
					<%
						out.println(ModeDB.getProcessStep1(conn,campus,process,item,overRide));
					%>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<br><br>
					<div class="hr"></div>
					<p align="right">
					<input type="submit" class="input" name="cmdSubmit" value="Next" title="continue to next step" onClick="return checkFormW()">&nbsp;&nbsp;
					<input type="submit" class="input" name="cmdCancel" value="Cancel" title="abort selected operation" onClick="return cancelFormW()">
					</p>
					<input type="hidden" value="<%=process%>" name="process">
					<input type="hidden" value="<%=item%>" name="item">
					<input type="hidden" value="<%=id%>" name="id">
					<input type="hidden" value="<%=override%>" name="override">
				</td>
			</tr>
		</TBODY>
	</TABLE>
</form>

<%
	asePool.freeConnection(conn,"crsmodex",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
