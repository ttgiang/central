<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	appr.jsp
	*	2007.09.01	names of approvers listing
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "70%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approver Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="../inc/calendar01.jsp" %>
	<script language="JavaScript" src="js/appr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){

		int lid = 0;
		int route = website.getRequestParameter(request,"rte",0);
		String sid = website.getRequestParameter(request,"lid");

		String college = website.getRequestParameter(request,"college","");
		String level = website.getRequestParameter(request,"level","");

		int i = 0;
		String sql;
		String approver_seq = "";
		String approver = "";
		String delegated = "";
		String addedby = "";
		String addeddate = "";
		String checked = "";
		String temp = "";

		String availableDate = "";
		String startDate = "";
		String endDate = "";

		// are there outlines going through the approval process and using this route?
		// if yes, do not allow delete or change in sequence to take place.
		long countRecords = ApproverDB.countApprovalsByRoute(conn,campus,route);

		if (sid != null && sid.length() > 0){
			lid = Integer.parseInt(sid);
			try{
				if (lid > 0){
					Approver apprvr = ApproverDB.getApprover(conn,lid,route);
					approver_seq = apprvr.getSeq();
					approver = apprvr.getApprover();
					delegated = apprvr.getDelegated();
					addedby = apprvr.getLanid();
					addeddate = apprvr.getDte();
					if ( apprvr.getExcludeFromExperimental() )
						checked = "checked";

					availableDate = apprvr.getAvailableDate();
					startDate = apprvr.getStartDate();
					endDate = apprvr.getEndDate();
				}
				else{
					lid = 0;
					int maxId = ApproverDB.maxApproverSeqID(conn,campus,route);
					approver_seq = Integer.toString(++maxId);
					addedby = user;
					addeddate = aseUtil.getCurrentDateTimeString();
				}

				out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/aps\'>" );
				out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='5' align=\'center\'  border=\'0\' class=\'reference\'>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Sequence:&nbsp;</td>" );

				// if routing is in use, don't permit change of sequence. allow change of approver only
				if (countRecords==0)
					out.println("					 <td><input class=\'input\' size=\'4\' maxlength=\'2\' name=\'seq\' type=\'text\' value=\'" + approver_seq + "\'></td>" );
				else{
					out.println("<td class=\"datacolumn\"><input name=\'seq\' type=\'hidden\' value=\'" + approver_seq + "\'>"
						+ approver_seq
						+ "</td>" );
				}

				out.println("				</tr>" );

				sql = aseUtil.getPropertySQL(session,"appr2");

				if (!approver.equals("DIVISIONCHAIR")){
					out.println("				<tr>" );
					out.println("					 <td class=\'textblackTH\' width=\"40%\">Approver:&nbsp;</td>" );
					out.println("					 <td>" );
					out.println(UserDB.getCampusUsersAndDistribution(conn,campus,approver));
					out.println("				</td>" );
					out.println("				</tr>" );

					out.println("				<tr>" );
					out.println("					 <td class=\'textblackTH\' width=\"40%\">Delegate:&nbsp;</td>" );
					out.println("					 <td>" + aseUtil.createSelectionBox( conn, sql, "delegated", delegated,false) + "</td>" );
					out.println("				</tr>" );
				}
				else{
					out.println("				<tr>" );
					out.println("					 <td class=\'textblackTH\' width=\"40%\">Approver:&nbsp;</td>" );
					out.println("					 <td>" + approver );
					out.println("<input type=\"hidden\" name=\"approver\" value=\"" + approver + "\">");
					out.println("<input type=\"hidden\" name=\"delegated\" value=\"" + delegated + "\">");
					out.println("					 </td></tr>" );
				}

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">End Date:&nbsp;</td>" );
				out.println("					 <td>"
					+ "<input class=\'input\' size=\'10\' maxlength=\'10\' name=\'endDate\' type=\'text\' value=\'" + endDate + "\'>"
					+ "&nbsp;<A HREF=\"#\" onClick=\"dateCal.select(document.aseForm.endDate,'anchorDate','MM/dd/yyyy'); return false;\" NAME=\"anchorDate\" ID=\"anchorDate\" class=\"linkcolumn\">"
					+ "<img src=\"../images/images/calendar.gif\" border=\"0\" alt=\"\" title=\"\"></A>&nbsp;(approval must be completed on or before End Date)"
					+ "<br/><br/><input type=\'checkbox\' value=\'1\' name=\'applyDate\'> Use this date for all approvals by this approver "
					+ "&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\">"
					+ "</td>");

				out.println("				</tr>" );
%>
<tr><td colspan="2">
				<div id="crshlp" style="width: 100%; display:none;">
					<TABLE class=page-help border=0 cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD class=title-bar width="50%"><font class="textblackth">Course Help</font></TD>
								<td class=title-bar width="50%" align="right">
									<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('crshlp');">
								</td>
							</TR>
							<TR>
								<TD colspan="2">
									Place a check mark in the box to apply the above date for all approvals by selected approver.
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</div>
</td></tr>
<%
				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Exclude from Experimental Approval:&nbsp;</td>" );
				out.println("					 <td><input type=\'checkbox\' value=\'1\' name=\'experimental\' " + checked + "></td>" );
				out.println("				</tr>" );

				String HTMLFormField = ApproverDB.getRoutingFullNameByID(conn,campus,route);

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Routing:&nbsp;</td>" );
				out.println("					 <td><input type=\"hidden\" value=\""+route+"\" name=\"route\">" + HTMLFormField + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Campus:&nbsp;</td>" );
				out.println("					 <td class=\"datacolumn\">" + campus + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Added By:&nbsp;</td>" );
				out.println("					 <td class=\"datacolumn\">" + addedby + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"40%\">Added Date:&nbsp;</td>" );
				out.println("					 <td class=\"datacolumn\">" + addeddate + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
				out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
				out.println("							<input name=\'route\' type=\'hidden\' value=\'" + route + "\'>" );

				if ( lid > 0 ){
					out.println("							<input title=\'save entered data\' type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

					if (countRecords == 0)
						out.println("							<input title=\'delete selected data\' type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );

					out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
				}
				else{
					out.println("							<input title=\'insert entered data\' type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
					out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
				}

				out.println("<input type=\"hidden\" name=\"college\" value=\"" + college + "\">");
				out.println("<input type=\"hidden\" name=\"level\" value=\"" + level + "\">");

				out.println("							<input title=\'abort selected operation\' type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTHLeft\' colspan=\'2\'><hr size=\'1\'>" );
				out.println("NOTE: modifications are not permitted when outline approvals are in progress using this approver sequence.");
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("			</table>" );
				out.println("		</form>" );

				aseUtil = null;
			}
			catch( Exception e ){
				out.println(e.toString());
			}
		}
		else{
			out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
		}
	}

	asePool.freeConnection(conn,"appr",user);
%>

<%@ include file="../inc/calendar02.jsp" %>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
