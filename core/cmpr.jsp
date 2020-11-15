<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cmprx.jsp	outline copy/compare
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Copy Outline Items";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String typeSource = website.getRequestParameter(request,"typeS","");
	String typeDestination = website.getRequestParameter(request,"typeD","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/cmpr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		int thisCounter = 0;
		int thisTotal = 2;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "CUR"; thisTitle[0] = "Approved";
		thisType[1] = "PRE"; thisTitle[1] = "Proposed";

		String sql = aseUtil.getPropertySQL(session,"alphas2");
%>

		<form method="post" action="cmprx.jsp" name="aseForm">
			<table width="80%" cellspacing='1' cellpadding='2' class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
				<tr>
					<td class="textblackth" valign="top" colspan="2"><br/>
						Instructions: select the SOURCE and DESTINATION outlines to compare. Copying is permitted only from SOURCE to DESTINATION.
						<br/><br/>
					</td>
				</tr>

				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td class="textblackTH" width="20%" height="30" nowrap>Select Source Outline:&nbsp;</td>
					<td class="dataColumn" valign="top">
						Type:&nbsp;&nbsp;
						<select class="inputsmall" name="ts">
							<option value="">-select-</option>
							<%
								for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
									if (typeSource.equals(thisType[thisCounter]))
										out.println("<option value=\""+thisType[thisCounter]+"\" selected>" + thisTitle[thisCounter] + "</option>" );
									else
										out.println("<option value=\""+thisType[thisCounter]+"\">" + thisTitle[thisCounter] + "</option>" );
								}
							%>
						</select>&nbsp;&nbsp;

						Alpha:&nbsp;&nbsp;<%=aseUtil.createSelectionBox(conn,sql,"as",alpha,false)%>&nbsp;&nbsp;
						Number:&nbsp;&nbsp;<input name="ns" class="input" type="text" size="10" maxlength="10" value="<%=num%>">&nbsp;&nbsp;
					</td>
				</tr>

				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td class="textblackTH" width="20%" height="30" nowrap>Select Destination Outline:&nbsp;</td>
					<td class="dataColumn" valign="top">
						Type:&nbsp;&nbsp;
						<select class="inputsmall" name="td">
							<option value="">-select-</option>
							<%
								for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
									if (typeDestination.equals(thisType[thisCounter]))
										out.println("<option value=\""+thisType[thisCounter]+"\" selected>" + thisTitle[thisCounter] + "</option>" );
									else
										out.println("<option value=\""+thisType[thisCounter]+"\">" + thisTitle[thisCounter] + "</option>" );
								}
							%>
						</select>&nbsp;&nbsp;

						Alpha:&nbsp;&nbsp;<%=aseUtil.createSelectionBox(conn,sql,"ad",alpha,false)%>&nbsp;&nbsp;
						Number:&nbsp;&nbsp;<input name="nd" class="input" type="text" size="10" maxlength="10" value="<%=num%>">&nbsp;&nbsp;
						<input name="aseSubmit" class="inputsmallgray" type="submit" value="Submit" onClick="return checkForm('s')">
						<input name="aseCancel" class="inputsmallgray" type="submit" value="Cancel" onClick="return cancelForm()">
					</td>
				</tr>
			</table>
		</form>

<%
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
