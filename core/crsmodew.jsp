<%@ page import="com.ase.paging.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crsmodew.jsp	mode maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
	String process = "";
	String override = "";
	int id = 0;

	if (processPage){
		id = website.getRequestParameter(request,"lid",0);
		if (id > 0){
			Mode mode = ModeDB.getProcessByID(conn,campus,id);
			if (mode != null){
				process = mode.getMode();

				if (mode.getOverride())
					override = "checked";
				else
					override = "";
			}
		}
	}

	String pageTitle = "Add Progress Required Items - steps 1 of 4";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<script type="text/javascript" src="js/crsmode.js"></script>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String sql = aseUtil.createStaticSelectionBox("MODIFY,NEW,REVIEW","MODIFY,NEW,REVIEW","process",process,"input","","DEFAULT","");
%>

<form method="post" action="crsmodex.jsp" name="aseForm">
	<TABLE width='80%' cellspacing='1' cellpadding='2' class='tableBorder<%=session.getAttribute("aseTheme")%>' align='center'  border='0'>
		<TBODY>
			<TR>
				<TD class='textblackTH' >
					Outline Process:&nbsp;&nbsp;<%=sql%>&nbsp;&nbsp;User may enable additional items:&nbsp;
					<input type="checkbox" name="override" value="1" <%=override%>>
					<br><br>
					<div class="hr"></div>
					<p align="right">
					<input type="submit" class="input" name="cmdSubmit" value="Next" title="continue to next step" onClick="return checkFormW()">&nbsp;&nbsp;
					<input type="submit" class="input" name="cmdCancel" value="Cancel" title="abort selected operation" onClick="return cancelFormW()">
					</p>
					<input type="hidden" value="<%=id%>" name="id">
					<font class="normaltext">Note:
						<ul>
							<li>select the outline process to assigned required items</li>
							<li>place a check mark if users are permitted to enable additional items</li>
						</ul>
					</font>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	asePool.freeConnection(conn,"crsmodew",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
