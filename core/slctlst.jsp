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

	String listSrc = "";

	if (src.equals(Constant.COURSE_INSTITUTION_LO)){
		listSrc = "ILO";
	}
	else if (src.equals(Constant.COURSE_PROGRAM_SLO)){
		listSrc = "PSLO";
	}
	else if (src.equals(Constant.COURSE_OBJECTIVES)){
		listSrc = "SLO";
	}

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

		String HTMLFormField = ValuesDB.drawHTMLRadioListBySrc(conn,campus,listSrc);

		if (processPage && !HTMLFormField.equals(Constant.BLANK)){
%>
			<form name="aseForm" method="post" action="slctlstx.jsp">
				<table width="80%" cellspacing="0" cellpadding="0" border="0">
					<tr>
						<td width="35%" valign="top">
							<table width="100%" border="0">
								<tr>
									<td width="25%" class="textblackth" valign="top">Select a list:</td>
									<td class="datacolumn" valign="top"><%=HTMLFormField%>
										<br><br>
										<input type="hidden" value="<%=kix%>" name="kix">
										<input type="hidden" value="c" name="formAction">
										<input type="hidden" value="<%=rtn%>" name="rtn">
										<input type="hidden" value="<%=src%>" name="originalsrc">
										<input type="hidden" value="<%=listSrc%>" name="src">
										<input type="hidden" value="<%=dst%>" name="dst">
										<input type="hidden" value="" name="subtopic">
										<input type="hidden" value="aseForm" name="formName">
										<input type="submit" value="Continue" name="cmdSubmit" id="cmdSubmit" class="input" onClick="return checkForm('s')">
										<input type="submit" value="Cancel" name="cmdCancel" id="cmdCancel" class="input" onClick="return cancelForm()">
									</td>
								</tr>
							</table>
						</td>
						<td width="65%" valign="top">
							<table width="100%" border="0">
								<tr>
									<td class="datacolumn" valign="top">
										<div style="visibility:hidden; border: 1px solid rgb(204, 204, 204);" id="content">
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

				</table>

			</form>
<%
		}
		else{
			rtn = rtn + ".jsp?kix="+kix+"&src="+src+"&dst"+dst;
			out.println("List does not exist for import.<br/><br/><a href=\""+rtn+"\" class=\"linkcolumn\">return to entry screen</a>");
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"slctlst",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
