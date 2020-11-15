<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slctlst.jsp	- select from a list to import
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String src = website.getRequestParameter(request,"src","");
	String dst = website.getRequestParameter(request,"dst","");
	String rtn = website.getRequestParameter(request,"rtn","");
	String subtopic = website.getRequestParameter(request,"subtopic","");

	String pageTitle = "Import List Items";

	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/slctlst.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		if (processPage && !subtopic.equals(Constant.BLANK)){

			String listName = DivisionDB.getDivisionNameFromCode(conn,campus,subtopic);

			if(listName.equals(Constant.BLANK)){
				listName = subtopic;
			}
%>
			<form name="aseForm" method="post" action="slctlsty.jsp">
				<table width="100%" cellspacing="4" cellpadding="4" align="center"  border="0">
					<tr>
						<td width="05%" class="textblackth">&nbsp;</td>
						<td class="textblackth"><%=listName%></td>
						<td width="05%" class="textblackth">&nbsp;</td>
					</tr>
					<tr>
						<td width="05%" class="textblackth">&nbsp;</td>
						<td class="datacolumn">
							<%
								out.println(ValuesDB.getListByCampusSrcSubTopic(conn,campus,src,subtopic));
							%>
						</td>
						<td width="05%" class="textblackth">&nbsp;</td>
					</tr>
					<tr>
						<td width="05%" class="textblackth">&nbsp;</td>
						<td class="datacolumn">
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="<%=rtn%>" name="rtn">
							<input type="hidden" value="<%=src%>" name="src">
							<input type="hidden" value="<%=dst%>" name="dst">
							<input type="hidden" value="<%=subtopic%>" name="subtopic">
							<input type="hidden" value="aseForm" name="formName">
							<input type="submit" value="Submit" name="cmdSubmit" class="input">
							<input type="submit" value="Cancel" name="cmdCancel" class="input" onClick="return cancelForm()">
							<br/><br/>
							NOTE: The content of the selected list will be imported to your outline.
						</td>
						<td width="05%" class="textblackth">&nbsp;</td>
					</tr>
				</table>
			</form>
<%
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"slctlstx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
