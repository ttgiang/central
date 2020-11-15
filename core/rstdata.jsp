<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "tasks";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Task Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>

	<style type="text/css">

		/* Not Just a Grid v1.1 - June 2011 - (c) 2011 Al Redpath / Outrageous Creations! Licenced under an MIT Licence */
		/* ---------------------------------------------------------------------------- */
		/* vertical form styling ------------------------------------------------------ */
		/* ---------------------------------------------------------------------------- */
		.vertical_form {font: 12px "Trebuchet MS", Arial, Helvetica, sans-serif;letter-spacing:1px;}
		.vertical_form fieldset{border:1px solid #888;margin:10px 0;padding:10px 20px 10px 20px;-moz-border-radius:10px;-webkit-border-radius: 10px;border-radius:10px;}
		.vertical_form fieldset.fieldsetbuttons {padding:10px 10px 10px 20px;}
		.vertical_form fieldset.fieldsetbuttons div {text-align:right;}
		.vertical_form legend {margin:0;border:1px solid #888;padding:3px 6px;background:#eee url(../images/misc/transoverlay-matte.png) repeat-x;-moz-border-radius:5px;-webkit-border-radius: 5px;border-radius:5px;text-transform:uppercase;	letter-spacing:2px;}
		.vertical_form label {display:block;margin:10px 0 5px 0; width:200px; }
		.vertical_form ul {margin:0; padding:0;}
		.vertical_form li {list-style:none; margin:0; padding:0;}
		.vertical_form div.form_input_notes {font-size:12px; margin:0 0 10px 10px;}
		/* ---------------------------------------------------------------------------- */
		/* Horizontal form styling ---------------------------------------------------- */
		/* ---------------------------------------------------------------------------- */
		.horizontal_form {font: 12px "Trebuchet MS", Arial, Helvetica, sans-serif;letter-spacing:1px;}
		#.horizontal_form fieldset{border:1px solid #888;margin:10px 0;padding:10px 20px 10px 20px;-moz-border-radius:10px;-webkit-border-radius: 10px;border-radius:10px;}
		.horizontal_form fieldset.fieldsetbuttons {padding:10px 10px 10px 20px;}
		.horizontal_form fieldset.fieldsetbuttons div {text-align:right;}
		.horizontal_form legend {margin:0;border:1px solid #888;padding:3px 6px;background:#eee url(../images/misc/transoverlay-matte.png) repeat-x;-moz-border-radius:5px;-webkit-border-radius: 5px;border-radius:5px;text-transform:uppercase;	letter-spacing:2px;}
		#.horizontal_form label {float:left;margin:0 5px 0 0; width:200px; text-align:right;}
		.horizontal_form ul {margin:0; padding:0;}
		.horizontal_form li {list-style:none; vertical-align:middle; margin:10px 0;clear:left;}
		.horizontal_form div.form_input_notes {font-size:12px; display:inline;}
		/* ---------------------------------------------------------------------------- */
		/* Input field styling -------------------------------------------------------- */
		/* ---------------------------------------------------------------------------- */
		.normalfield, .requiredfield {border: 1px solid #ccc;border-top: 1px solid #444;border-left: 1px solid #444;font: 12px "Trebuchet MS", Arial, Helvetica, sans-serif;letter-spacing:1px;padding:3px 2px 3px 2px;}
		.normalfield {background: #ffffff url(../images/misc/formgreyback_not_valid_file.gif) repeat-x;}
		.requiredfield {background: #fafad8 url(../images/misc/formyellowback_not_valid_file.gif) repeat-x top right;}
		.fielderror {border: 1px solid #ff4444;background: #fee9eb url(../images/misc/formredback_not_valid_file.gif) repeat-x top right;}
		.fieldgood {background: #e0ffc7 url(../images/misc/formgreenback_not_valid_file.gif) repeat-x;}
		.requiredfield:focus, .fielderror:focus, .normalfield:forus {border: 1px solid #444444;-webkit-box-shadow: 0 0 7px rgba(0, 144, 255, .7);-moz-box-shadow: 0 0 7px rgba(0, 144, 255, .7);box-shadow: 0 0 7px rgba(0, 144, 255, .7);}
		.requiredfield:focus {background: #fafad8 url(../images/misc/formyellowback_not_valid_file.gif) repeat-x top right;}
		.normalfield:focus {background: #e0ffc7 url(../images/misc/formgreenback_not_valid_file.gif) repeat-x;}
		.fielderror:focus {border: 1px solid #ff4444;background: #fee9eb url(../images/misc/formredback_not_valid_file.gif) repeat-x top right;}
		.smallfield {font:10px;padding:2px 1px 2px 1px;}
		.largefield {font:16px}
		/* ---------------------------------------------------------------------------- */
		/* Styled Buttons ------------------------------------------------------------- */
		/* ---------------------------------------------------------------------------- */
		.styled_button, .styled_button:visited {background: #222 url(../images/misc/transoverlay-matte.png) repeat-x;font: bold 12px "Trebuchet MS", Arial, Helvetica,sans-serif;text-transform:uppercase;text-decoration: none;line-height:30px;letter-spacing:1px;color: #fff;padding: 0 10px 0 10px;margin:0 3px;height:30px;border: 1px solid rgba(0,0,0,0.4);border-top: 1px solid rgba(255,255,255,0.4);border-left: 1px solid rgba(255,255,255,0.4);border-radius:15px;-moz-border-radius:15px;-webkit-border-radius: 15px;box-shadow: 0 1px 5px rgba(0,0,0,0.7);-moz-box-shadow: 0 1px 5px rgba(0,0,0,0.7);-webkit-box-shadow: 0 1px 5px rgba(0,0,0,0.7);text-shadow: 0 -1px 1px rgba(0,0,0,0.25);position: relative;cursor: pointer;}
		a.styled_button, a.styled_button:visited {color:#fff;height:30px;line-height:30px;padding:5px 10px;}
		a.styled_button:hover, a.styled_button:active {color:#fff;white-space:nowrap;}
		.cancel_button.styled_button:after, .confirm_button.styled_button:after, .question_button.styled_button:after, .delete_button.styled_button:after, .edit_button.styled_button:after, .view_button.styled_button:after  {position:absolute;padding-top:7px;right:5px;}
		.cancel_button.styled_button, .confirm_button.styled_button, .question_button.styled_button, .delete_button.styled_button, .edit_button.styled_button, .view_button.styled_button {padding-right:25px;}
		.cancel_button.styled_button:after {content: url(../images/icons/icon-cancel.png);}
		.confirm_button.styled_button:after {content: url(../images/icons/icon-success.png);}
		.question_button.styled_button:after {content: url(../images/icons/icon-question.png);}
		.delete_button.styled_button:after {content: url(../images/icons/icon-delete.png);}
		.edit_button.styled_button:after {content: url(../images/icons/icon-edit.png);}
		.view_button.styled_button:after {content: url(../images/icons/icon-view.png);}

		.incomplete_button.styled_button:after {content: url(../images/icons/icon-warning.png);}

		.green.styled_button {background-color:#98a83a;}
		.red.styled_button {background-color: #e33100;}
		.blue.styled_button {background-color:#6c93b3;}
		.grey.styled_button, .grey.styled_button:visited {background-color:#ddd; color:#666;	text-shadow: 0 1px 1px rgba(255,255,255,0.8);}

		.green.styled_button:hover {background-color:#afc243;}
		.red.styled_button:hover {background-color: #bf2900;}
		.blue.styled_button:hover {background-color:#5c7d98;}
		.grey.styled_button:hover {background-color:#ccc;color:#666; text-shadow: 0 1px 1px rgba(255,255,255,0.8);}

		@-moz-document url-prefix() {button.delete_button.styled_button:after, button.question_button.styled_button:after, button.confirm_button.styled_button:after, button.cancel_button.styled_button:after, button.edit_button.styled_button:after, button.view_button.styled_button:after  {padding-top:1px;right:15px;}}

		.horizontal_form fieldset
		{
			display: block;
			margin: 0 0 3em 0;
			padding: 0 1em 1em 1em;
			border:1px solid #888;margin:10px 0;padding:10px 20px 10px 20px;-moz-border-radius:10px;-webkit-border-radius: 10px;border-radius:10px;
		}

		.horizontal_form label
		{
			float: left;
			display: block;
			margin: 1em 1em 0 0;

		}

		.horizontal_form input
		{
			display: block;
			width: 18em;
		}

		.horizontal_form .wideinputbox{
			border: 1px solid #ccc;
			border-top: 1px solid #444;
			border-left: 1px solid #444;
			font: 12px "Trebuchet MS", Arial, Helvetica, sans-serif;
			letter-spacing:1px;
			padding:3px 2px 3px 2px;
			width: 40em;
		}

		.horizontal_form select
		{
			display: block;
			width: 17em;
		}

		.horizontal_form input[type="radio"] {
			display: inline-block;
			width: 1em;
		 }

		.horizontal_form input[type="checkbox"] {
			display: inline-block;
			width: 1em;
		 }

		.new_line{ clear: left; }

		 .fieldsetx { border:none; width:90%; text-align: left}

		 .labelx {display: block; margin-top: 1em; margin-bottom: 0.25em;};

	</style>

	<%@ include file="ase2.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage && !user.equals(Constant.BLANK)){

		String[] info = null;
		String program = "";
		int route = 0;

		boolean isProgramReviewer = false;
		boolean reviewExpired = false;
		boolean isNextApprover = false;
		boolean okToProcess = true;
		boolean showSaveNext = false;

		String faculty = website.getRequestParameter(request,"faculty", "");
		String kix = website.getRequestParameter(request,"kix", "");

		String buttonName = "";
		String reviewdate = "";

		String[] icons = new String[3];
		icons[0] = "<img src=\"../images/icons/icon-error.png\" alt=\"is program reviewer\">";
		icons[1] = "<img src=\"../images/icons/icon-error.png\" alt=\"is program reviewer\">";
		icons[2] = "<img src=\"../images/icons/icon-error.png\" alt=\"is program reviewer\">";

		if(faculty.equals(Constant.BLANK)){
			buttonName = "Next";
			showSaveNext = true;
		}
		else if(!faculty.equals(Constant.BLANK) && kix.equals(Constant.BLANK)){
			buttonName = "Next";
		}
		else if(!faculty.equals(Constant.BLANK) && !kix.equals(Constant.BLANK)){

			showSaveNext = true;

			buttonName = "Submit";

			info = helper.getKixInfo(conn,kix);
			program = info[Constant.KIX_PROGRAM_TITLE];
			route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			isProgramReviewer = ProgramsDB.isProgramReviewerNoDateCheck(conn,campus,kix,faculty);

			reviewdate = ProgramsDB.getItem(conn,kix,"reviewdate");
			reviewdate = aseUtil.ASE_FormatDateTime(reviewdate,Constant.DATE_DATETIME);
			if(!reviewdate.equals(Constant.BLANK)){

				com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();
				int hours24 = dt.getHour24();
				int minutes = dt.getMinutes();
				String today = dt.getCurrentDate();

				int daysDiff = DateUtility.compare2Dates(reviewdate,today);

				//
				// cann't run this procedure if daysDiff is >
				//
				if (daysDiff >= 0){
					reviewExpired = false;
				}
				else{
					reviewExpired = true;

					// if we have the same day, don't allow the removal until after midnight
					if(reviewdate.equals(today)){
						if(hours24 < 24 && minutes < 60){
							reviewExpired = false;
						}
					}

				} // daysDiff
			}

			isNextApprover = ProgramsDB.isNextApprover(conn,campus,kix,faculty,route);

			if(isProgramReviewer==false || reviewExpired==false || isNextApprover==false){
				okToProcess = false;
			}

		}

		String saveDisabled = "";
		String saveButton = "confirm_button";

		String saveValue = website.getRequestParameter(request,"cmdSave", "");
		if(saveValue.equals("Submit")){
			showSaveNext = false;
		}

		//
		// do the reset
		//
		String progress = "";
		if(!faculty.equals(Constant.BLANK) && !kix.equals(Constant.BLANK) && okToProcess && saveValue.equals("Submit")){
			progress = com.ase.aseutil.util.ResetDB.resetReviewToApproval(conn,campus,kix,faculty);
		}

%>

	Note: This procedure is used to correct approvals held back by expired review processing.

	<form class="horizontal_form" name="aseForm" method="post" action="?">

		<fieldset class="fieldsetx">
			<legend>1. Faculty</legend>
			<label class="labelx" for="faculty">Select faculty: </label>
			<%
				out.println(aseUtil.createSelectionBox(conn,SQL.campusUsers(campus),"faculty",faculty,"","1",false));
			%>
		</fieldset>

		<%
			if(!faculty.equals(Constant.BLANK)){
			%>
				<fieldset class="fieldsetx">
					<legend>2. Tasks</legend>

					  <p>Note: Click the task to correct.</p>

					  <div id="container90">
							<div id="demo_jui">
							  <table id="jquery" class="display">
									<thead>
										 <tr>
											  <th align="left">Submitted For</th>
											  <th align="left">Submitted By</th>
											  <th align="left">Progress</th>
											  <th align="left">Outline/Program</th>
											  <th align="left">Task</th>
											  <th align="left">Date</th>
										 </tr>
									</thead>
									<tbody>
										<%
											TaskDB.showUserTasksJQ(conn,campus,faculty);

											for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.COURSE,faculty)){

												boolean showTasks = false;

												String task = o.getCurrent();

												String taskKix = o.getHistoryid();

												//
												// progress is not empty only when the final is executed to reset
												//
												if(!progress.equals(Constant.BLANK) && !kix.equals(Constant.BLANK)){

													if(kix.equals(taskKix)){
														showTasks = true;
													}

												}
												else if(task.toLowerCase().contains("review")){

													showTasks = true;

													if(!kix.equals(Constant.BLANK) && !kix.equals(taskKix)){
														showTasks = false;
													}

												} // review tasks

												if(showTasks){
													task = task.replace("prgrvwer.jsp?","rstdata.jsp?faculty="+faculty+"&");
												%>
												  <tr>
													 <td align="left"><%=o.getLinks()%></td>
													 <td align="left"><%=o.getOutline()%></td>
													 <td align="left"><%=o.getProgress()%></td>
													 <td align="left"><%=o.getProposer()%></td>
													 <td align="left"><%=task%></td>
													 <td align="left"><%=o.getNext()%></td>
												  </tr>
												<%
												} // showTasks

										%>
									<% } // for %>
									</tbody>
							  </table>
						 </div>
					  </div>

				</fieldset>
			<%
			}
		%>

		<%
			if(!faculty.equals(Constant.BLANK) && !kix.equals(Constant.BLANK)){
			%>
				<fieldset class="fieldsetx">
					<legend>3. Confirm</legend>
					Note: All of the following must be true (<img src="../images/icons/icon-success.png" alt="is program reviewer">) to run this procedure:
					<br>
					<br>
					<%
						if(isProgramReviewer){
							icons[0] = "<img src=\"../images/icons/icon-success.png\" alt=\"is program reviewer\">";
						}

						if(reviewExpired){
							icons[1] = "<img src=\"../images/icons/icon-success.png\" alt=\"expired review date\">";
						}

						if (isNextApprover){
							icons[2] = "<img src=\"../images/icons/icon-success.png\" alt=\"is program reviewer\">";
						}

						if(!okToProcess){
							saveDisabled = "disabled";
							saveButton = "incomplete_button";
						}

					%>
					<ul>
						<li><%=icons[0]%> <font class="goldhighlightsbold"><%=faculty%></font> is a reviewer for program <font class="goldhighlightsbold">'<%=program%>'</font></li>
						<li><%=icons[1]%> program review date has expired (<font class="goldhighlightsbold"><%=reviewdate%></font>)</li>
						<li><%=icons[2]%> <font class="goldhighlightsbold"><%=faculty%></font> is next to approve program <font class="goldhighlightsbold">'<%=program%>'</font></li>
					</ul>

				</fieldset>
			<%
			}
		%>

		<%
			if(!faculty.equals(Constant.BLANK) && !kix.equals(Constant.BLANK) && okToProcess && saveValue.equals("Submit")){
		%>
				<fieldset class="fieldsetx">
					<legend>4. Progress</legend>
					<%
						out.println(progress);

						// clear now that we are done.
						kix = "";
					%>
				</fieldset>
		<%
			}
		%>

		<fieldset class="fieldsetx">
			<div>

				<input type="hidden" name="kix" id="kix" value="<%=kix%>">

				<%
					if(showSaveNext){
				%>
						<button type="submit" value="<%=buttonName%>" name="cmdSave" id="cmdSave" class="<%=saveButton%> grey styled_button" <%=saveDisabled%>><%=buttonName%></button>
				<%
					}
				%>
				<button type="submit" value="reset" name="cmdReset" id="cmdReset" class="confirm_button grey styled_button">Reset</button>
				<button type="submit" value="cancel" name="cmdCancel" id="cmdCancel" class="cancel_button grey styled_button">Cancel</button>
			</div>
		</fieldset>

	</form>

<%
	} // processPage

	asePool.freeConnection(conn,"tasks",user);
%>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">

		$(document).ready(function () {

			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 999,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false
			});


			$("#cmdCancel").click( function(){
					aseForm.action = "tasks.jsp";
					aseForm.submit();
				}
			);

			$("#cmdReset").click( function(){
					document.aseForm.kix.value = "";
					aseForm.action = "rstdata.jsp";
					aseForm.submit();
				}
			);

		});
	</script>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

