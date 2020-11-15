<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsasslnk.jsp	link compentency to assessment. Called by crsassr.
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Course Competency";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsasslnk.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>


<form name="aseForm" method="post" action="/central/servlet/als">
	<table border="0" cellpadding="2" width="60%" align="center" cellspacing="1" class="tableBorder<%=session.getAttribute("aseTheme")%>">

	<%
		try{
			/*
				display all assessments for selection
			*/
			String assessID = "";
			ArrayList list = new ArrayList();
			String compid = website.getRequestParameter(request,"comp");
			String checked = "";
			String comp = "";
			String temp = "";

			// display basic outline info
			comp = CompDB.getComp(conn,alpha,num,compid,campus);
			%>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" colspan="2" class="textbrownTH">Methods Used for Assessing SLO<br></td>
				</tr>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" width="10%" class="textblackTH">Course: </td>
					<td class="dataColumn"><%=alpha%>&nbsp;<%=num%></td>
				</tr>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" width="10%" class="textblackTH">SLO: </td>
					<td class="dataColumn"><%=comp%><br/></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
			<%

			// retrieve all assessed items. put in CSV here
			String selected = "," + AssessDB.getSelectedAssessments(conn,kix,compid) + ",";

			// retrieve all available assessments
			list = AssessDB.getAssessments(conn,campus);

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
				out.println( "<input type=hidden value=\'" + kix + "\' name=kix>" );
				out.println( "<input type=hidden value=\'" + campus + "\' name=campus>" );
				out.println( "<input type=hidden value=\'" + compid + "\' name=compid>" );
				out.println( "<input type=hidden value=\'" + currentTab + "\' name=currentTab>" );
				out.println( "<input type=hidden value=\'" + currentNo + "\' name=currentNo>" );
			}
		}
		catch (Exception e){
			out.println( e.toString() );
		}

		asePool.freeConnection(conn);
	%>
		<tr>
			<td colspan="2" align="left">
				<br />
				<input type="hidden" name="formAction" value="c">
				<input type="hidden" name="formName" value="aseForm">
				<input title="save selected methods" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onClick="return checkForm('s')">
				<input title="abort selected operation" type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return cancelForm('c','<%=alpha%>','<%=num%>','<%=currentTab%>','<%=currentNo%>')">
				<br/><br/><br/>
				&nbsp;&nbsp;<b>Instruction:</b>&nbsp;place a check mark beside the method(s) used to assess the selected competency.
			</td>

		</tr>

	</table>
</form>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
