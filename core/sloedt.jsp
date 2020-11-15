<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sloedt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	int lid = website.getRequestParameter(request,"lid", 0);
	String kix = website.getRequestParameter(request,"kix", "");

	if (lid==0 && "".equals(kix))
		response.sendRedirect("index.jsp");

	String pageTitle = "SLO Assessment";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/sloedt.js"></script>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	try{
		String alpha = "";
		String num = "";
		String type = "";
		String auditby = "";
		String auditdate = "";

		int i = 0;
		int j = 0;

		int controls = 7;															// number of WYSIWYG fields
		int controlsToShow = 0;													// number of WYSIWYG fields

		/*
			there are 7 questions in all. 4 for assessment and the other 3 comes after approval
		*/
		if (SLODB.sloProgress(conn,kix,Constant.COURSE_ASSESS_TEXT) || SLODB.sloProgress(conn,kix,Constant.COURSE_APPROVAL_TEXT))
			controlsToShow = 4;
		else
			controlsToShow = 7;

		String[] question = new String[controls];							// the question
		String outline = "";														// title
		String mode = "u";														// default mode
		boolean allApproved = true;											// whether all contents have been approved
		boolean isAssessing = false;
		boolean isApproving = false;
		boolean isApproved = false;
		boolean enableSaveButton = false;

		String[] getQuestions = new String[controls];
		String[] getApprovedBy = new String[controls];
		String[] getApprovedDate = new String[controls];

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		// determines whether we want to be notified when checkboxes for SLO have not been selected
		String WantsSLOApprovalNotification = "0";
		Ini ini = IniDB.getIniByCampusCategoryKid(conn,campus,"System","WantsSLOApprovalNotification");
		if (ini != null)
			WantsSLOApprovalNotification = ini.getKval1();

		// initialize
		for(i=0;i<controls;i++){
			getQuestions[i]="";					// the answer
			getApprovedBy[i]="";					// the approver
			getApprovedDate[i]="";				// the approved by date
			question[i]="";
		}

		// does this person have approval access?
		boolean isApprover = DistributionDB.hasMember(conn,campus,"SLOApprover",user);

		// read data from system and populate screen
		question = AssessedDataDB.getAssessedQuestionsX(conn,campus);

		CourseACCJC accjc = new CourseACCJC();
		if (lid>0){
			/*
				getAssessedData returns a String array of answer,chk,answer,check
				there is a pair for each question displayed on screen.
			*/
			j = 0;
			Vector vector = AssessedDataDB.getAssessedDataVector(conn,lid);
			if (vector != null){
				for (Enumeration e = vector.elements(); e.hasMoreElements();){
					AssessedData ad = (AssessedData) e.nextElement();
					getQuestions[j] = ad.getQuestion();					// the answer
					getApprovedBy[j] = ad.getApprovedBy();				// the approver
					getApprovedDate[j] = ad.getApprovedDate();		// the approved by date
					++j;
				}
			}
			else{
				mode = "a";
			}

			// detail about the comp we are assessing
			accjc = CourseACCJCDB.getACCJC(conn,campus,lid,kix,true);
			alpha = accjc.getCourseAlpha();
			num = accjc.getCourseNum();
			type = accjc.getCourseType();
			outline = alpha + " " + num + " - " + courseDB.getCourseDescription(conn,alpha,num,campus);
		}
		else{
			lid = 0;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = user;
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'sloedtx.jsp'>" );
		out.println("			<table height=\'150\' width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("<tr>");
		out.println("<td colspan=\"2\">");
		out.println("<table border=\"0\" width=\"100%\">");
		out.println("<tr>");
		out.println("<td height=\"20\" class=\"textblackTH\" width=\"25%\">Outline:</td>");
		out.println("<td class=\"dataColumn\">" + outline + "</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td height=\"20\" class=\"textblackTH\">Competency:</td>");
		out.println("<td class=\"dataColumn\">" + accjc.getComp() + "</td>");
		out.println("</tr>");

		if (!(Constant.CAMPUS_LEE).equals(campus)){
			out.println("<tr>");
			out.println("<td height=\"20\" class=\"textblackTH\" width=\"25%\">Content:</td>");
			out.println("<td class=\"dataColumn\">" + accjc.getContent() + "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td height=\"20\" class=\"textblackTH\">Assessment Method:</td>");
			out.println("<td class=\"dataColumn\">" + accjc.getAssessment() + "</td>");
			out.println("</tr>");
		}

		out.println("<tr>");
		out.println("<td height=\"20\" colspan=\"2\"><div class=\"hr\"></div></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</td>");
		out.println("</tr>");

		isAssessing = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_ASSESS_TEXT);
		isApproved = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_APPROVED_TEXT);
		isApproving = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_APPROVAL_TEXT);

		i = 0;
		for(i=0;i<controlsToShow;i++){
			out.println("				<tr>" );
			out.println("					<td class=\"textblackTH\">" + (i+1) + ".</td>" );
			out.println("					<td class=\"textblackTH\">" + question[i] + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'dataColumn\' width=\"2%\">&nbsp;</td>" );

			/*
				if approver name and date are available, that means this assessment was completed and shouldn't be
				available for edit.
			*/
			if (isApprover && isApproving){
				out.println("<td class=\'dataColumn\'>" + getQuestions[i] + "</td>" );
			}
			else{
				if ("".equals(getApprovedBy[i]) || getApprovedBy[i] == null){
					out.println("<td class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"wysiwyg","0","ase_"+i,getQuestions[i],0,0,false,"",false) + "</td>" );
					allApproved = false;
				}
				else{
					out.println("<td class=\'dataColumn\'>" + getQuestions[i] + "</td>" );
				}
			}

			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'dataColumn\' width=\"2%\">&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" );

			if (isApprover) {
%>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td height="20" class="textblackTH" width="15%" valign="bottom">Approved:</td>
						<td class="dataColumn" valign="bottom">
							<%
								if ("".equals(getApprovedBy[i]) || getApprovedBy[i] == null){
									out.println("<input type=\"checkbox\" name=\"chk" + i + "\">");
									enableSaveButton = true;
								}
								else{
									out.println("<input type=\"hidden\" value=\"1\" name=\"chk" + i + "\">YES");
								}
							%>
							&nbsp;
						</td>
						<td height="20" class="textblackTH" width="15%">Approver:</td>
						<td class="dataColumn"><%=getApprovedBy[i]%></td>
						<td height="20" class="textblackTH" width="15%" valign="bottom">Date:</td>
						<td class="dataColumn"><%=getApprovedDate[i]%></td>
					</tr>
				</table>
<%
			}

			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'dataColumn\' colspan=\"2\">&nbsp;</td>" );
			out.println("				</tr>" );
		}

		out.println("				<tr>" );
		out.println("					 <td colspan=\"2\" class=\'textblackTHRight\'><hr size=\'1\'>" );
		out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
		out.println("							<input name=\'alpha\' type=\'hidden\' value=\'" + alpha + "\'>" );
		out.println("							<input name=\'num\' type=\'hidden\' value=\'" + num + "\'>" );
		out.println("							<input name=\'type\' type=\'hidden\' value=\'" + type + "\'>" );
		out.println("							<input name=\'campus\' type=\'hidden\' value=\'" + campus + "\'>" );
		out.println("							<input name=\'mode\' type=\'hidden\' value=\'" + mode + "\'>" );
		out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
		out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		out.println("							<input name=\'controls\' type=\'hidden\' value=\'" + controls + "\'>" );
		out.println("							<input name=\'controlsToShow\' type=\'hidden\' value=\'" + controlsToShow + "\'>" );
		out.println("							<input name=\'approver\' type=\'hidden\' value=\'" + isApprover + "\'>" );
		out.println("							<input name=\'wantsNotification\' type=\'hidden\' value=\'" + WantsSLOApprovalNotification + "\'>" );

		if ((!allApproved && (isAssessing || isApproved)) || (isApproving && enableSaveButton))
			out.println("<input type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'inputsmallgray\' onClick=\"return checkForm('s')\">" );

		if (isApproving && enableSaveButton)
			out.println("<input type=\'submit\' name=\'aseSubmitApprove\' value=\'Save & Approve\' class=\'inputsmallgray\' onClick=\"return checkForm('as')\">" );

		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );

		if (isApproving && enableSaveButton){
			out.println("				<tr>" );
			out.println("					 <td class=\'dataColumn\' colspan=\"2\">" );
			out.println("					 Click 'Save' to update your changes<br/>" );
			out.println("					 Click 'Save & Approve' to update your changes & notify proposer of approval<br/>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
		}
		out.println("			</table>" );
		out.println("		</form>" );

		campus = Encrypter.encrypter(campus);
		session.setAttribute("aseCampus", campus);
		session.setAttribute("aseAlpha", alpha);
		session.setAttribute("aseNum", num);
		session.setAttribute("aseType", type);
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
