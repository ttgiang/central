<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsasslnk.jsp	link compentency to assessment. Called by crsassr.
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "68%";
	String pageTitle = "Assessment";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsasslnk.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form name="aseForm" method="post" action="/central/servlet/als">
	<table border="0" cellpadding="2" width="100%">

	<%
		try{
			/*
				display all assessments for selection
			*/
			String assessID = "";
			ArrayList list = new ArrayList();
			String alpha = website.getRequestParameter(request,"alpha");
			String num = website.getRequestParameter(request,"num");
			String compid = website.getRequestParameter(request,"comp");
			String campus = (String)session.getAttribute("aseCampus");
			String checked = "";
			String comp = "";
			String temp = "";

			// display basic outline info
			comp = com.ase.aseutil.CompDB.getComp(conn,alpha,num,compid,campus);
			%>
				<tr>
					<td valign="top" width="10%">Course: </td>
					<td class="dataColumn"><%=alpha%>&nbsp;<%=num%></td>
				</tr>
				<tr>
					<td valign="top" width="10%">Competency: </td>
					<td class="dataColumn"><%=comp%><br/></td>
				</tr>
				<tr><td colspan="2"><hr size="1" noshade><br /></td></tr>
			<%

			// retrieve all assessed items. put in CSV here
			String selected = "," + com.ase.aseutil.AssessDB.getSelectedAssessments(conn, compid) + ",";

			// retrieve all available assessments
			list = com.ase.aseutil.AssessDB.getAssessments(conn,campus);

			if ( list != null ){
				Assess assess;
				for (int i = 0; i<list.size(); i++){
					assess = (Assess)list.get(i);

					// put a check on items already selected
					checked = "";
					temp = "," + assess.getId() + ",";
					if ( selected.indexOf(temp) >= 0 )
						checked = "checked";
				%>
					<tr>
						<td><input type="checkbox" name="assess_<%=assess.getId()%>" value="<%=assess.getId()%>" <%=checked%>></td>
						<td class="dataColumn"><%=assess.getAssessment()%></td>
					</tr>
				<%

					if ( assessID.length() == 0 )
						assessID = assess.getId();
					else
						assessID = assessID + "," + assess.getId();
				}

				// save these ids for later processing
				out.println( "<input type=hidden value=\'" + assessID + "\' name=assessID>" );
				out.println( "<input type=hidden value=\'" + list.size() + "\' name=numberOfIDs>" );
				out.println( "<input type=hidden value=\'" + alpha + "\' name=alpha>" );
				out.println( "<input type=hidden value=\'" + num + "\' name=num>" );
				out.println( "<input type=hidden value=\'" + campus + "\' name=campus>" );
				out.println( "<input type=hidden value=\'" + compid + "\' name=compid>" );
			}
		}
		catch (Exception e){
			out.println( e.toString() );
		}

		asePool.freeConnection(conn);
	%>
		<tr>
			<td colspan="2" align="left">
				<input type="hidden" value="c">
				<input type="hidden" value="aseForm">
				<br />
				<input type="submit" name="aseSubmit" value="save" class="inputsmallgray" onClick="return checkForm('s')">
				<input type="submit" name="aseCancel" value="cancel" class="inputsmallgray" onClick="return checkForm('c')">
			</td>

		</tr>

	</table>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>