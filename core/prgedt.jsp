<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgedt.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String caller = "prgedt";
	String chromeWidth = "80%";
	fieldsetTitle = "Program Maintenance";
	String pageTitle = fieldsetTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix", "");
	String src = Constant.PROGRAM_RATIONALE;

	String message = "";

	String auditby = "";
	String auditdate = "";
	String title = "";
	String effectiveDate = "";
	String year = "";
	String description = "";
	int degree = 0;
	int division = 0;
	int items = 0;
	String ckEditors = "";
	String sql = "";

	// new programs gets 7 questions
	boolean isNewProgram = false;

	// reset
	session.setAttribute("aseProgress",null);

	if (processPage){

		//
		// requires for generic upload
		//
		session.setAttribute("aseKix",kix);
		session.setAttribute("aseCallingPage","prgedt");
		session.setAttribute("aseUploadTo",Constant.PROGRAMS);

		// screen has configurable item. setting determines whether
		// users are sent directly to news or task screen after login
		session.setAttribute("aseConfig","1");
		session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

		try{
			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if (!kix.equals(Constant.BLANK)){

				String progress = ProgramsDB.getProgramProgress(conn,campus,kix);

				if (progress.equals(Constant.PROGRAM_MODIFY_PROGRESS)){

					Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
					if ( program != null ){
						degree = program.getDegree();
						division = program.getDivision();
						title = program.getTitle();
						effectiveDate = program.getSemester();
						year = program.getYear();
						auditby = program.getAuditBy();
						auditdate = program.getAuditDate();
						description = program.getDescription();
						pageTitle = title + " - " + effectiveDate;

						isNewProgram = ProgramsDB.isNewProgram(conn,campus,title,degree,division);
					}

					program = null;

				}
				else{
					processPage = false;
					message = "Programs in REIVEW status may not be modified.";
				}
				// progress is not modify
			}
			else{
				kix = "";
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}
		}
		catch( Exception e ){
			//System.out.println(e.toString());
		}

		session.setAttribute("aseCallingPage",caller);
	}

%>

<html>
<head>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/prgedt.js"></script>
	<link rel="stylesheet" type="text/css" href="./forum/inc/forum.css">
	<%@ include file="ase2.jsp" %>

	<style type="text/css">

		table.mystyle{
			border-width: 1px;
			border-spacing: 0;
			border-collapse: collapse;
			border-style: solid;
			background-color:#FFF8C7;
			color:#083772;
		}

	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" name="aseForm" action="/central/servlet/amidala?ack=updt">

<%
	if (processPage){
		try{

			int fid = 0;
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				fid = ForumDB.getForumID(conn,campus,kix);
			}

			String edit1 = "";

			out.println("			<table width=\'96%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );

			sql = aseUtil.getPropertySQL(session,"prgdegrees");
			sql = aseUtil.replace(sql, "_campus_", campus);
			out.println("<tr><td class=\"textblackth\" width=\"15%\">Degree:&nbsp;</td><td colspan=\"2\">"
							+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
							+ "</td></tr>");

			sql = aseUtil.getPropertySQL(session,"prgdivision");
			sql = aseUtil.replace(sql, "_campus_", campus);
			out.println("<tr><td class=\"textblackth\">Division:&nbsp;</td><td colspan=\"2\">"
							+ aseUtil.createSelectionBox(conn,sql,"division",""+division,false)
							+ "</td></tr>");

			// title
			out.println("<tr>"
				+ "<td class=\'textblackTH\' width=\"15%\">Title:&nbsp;</td>"
				+ "<td colspan=\"2\"><input size=\'80\' maxlength=\"50\" class=\'input\' name=\'title\' id=\'title\' type=\'text\' value=\'" + title +"\'></td>"
				+ "</tr>" );

			// description
			out.println("<tr><td class=\"textblackth\">Description:&nbsp;&nbsp;</td><td colspan=\"2\">"
							+ "<textarea name=\'description\' cols=\'80\' rows=\'6\' class=\'input\'>"+description+"</textarea>"
							+ "</td></tr>");

			// effective date
			out.println("<tr><td class=\"textblackth\">Effective Date:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createStaticSelectionBox("Fall,Spring,Summer,Winter","Fall,Spring,Summer,Winter","effectiveDate",effectiveDate,"input","","BLANK","")
							+ "&nbsp;<input type=\"text\" class=\"input\" name=\"year\" size=\"10\" value=\""+year+"\">"
							+ "</td></tr>");

			String temp = "";

			if(ApproverDB.countApprovalHistory(conn,kix) > 0){
				temp = "<img src=\"images/comment.gif\" title=\"approval comments\" alt=\"approval comments\" id=\"approval comments\">&nbsp;<a href=\"prghst.jsp?kix="+kix+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','no','center');return false\" onfocus=\"this.blur()\">approval comments</a>";
			}

			if(fid > 0 && ForumDB.countPostsToForum(conn,fid) > 0){
				if(!temp.equals("")){
					temp = temp + "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";
				}
				temp += "<img src=\"images/comment.gif\" title=\"approval comments\" alt=\"review comments\" id=\"review comments\">&nbsp;<a href=\"./forum/prt.jsp?fid="+fid+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\">review comments</a>";
			}
			else{
				if(ReviewerDB.countComments(conn,kix) > 0){
					if(!temp.equals("")){
						temp = temp + "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";
					}
					temp += "<img src=\"images/comment.gif\" title=\"approval comments\" alt=\"review comments\" id=\"review comments\">&nbsp;<a href=\"prgrvwcmnts.jsp?c=-1&md=3&qn=0&kix="+kix+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\">review comments</a>";
				}
			}

			if(!temp.equals("")){
				temp = temp + "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";
			}

			out.println("<tr><td colspan=\"2\"><br>"
					+ temp
					+ "<img src=\"../images/clip.gif\"><a href=\"#attachment\" class=\"linkcolumnhighlights\">attachments</a></td></tr>"
					+ "<tr><td colspan=\"3\"><div class=\"hr\"></div></td><td></tr>");

			ArrayList questions = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");

			if (questions != null){

				Question question;

				StringBuffer buf = new StringBuffer();
				String[] edits = null;
				boolean enabledItems = false;
				boolean showEditor = false;

				long commentsCount = 0;

				ArrayList columns = ProgramsDB.getColumnNames(conn,campus);
				ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,"PRE");
				edit1 = ProgramsDB.getProgramEdit1(conn,campus,kix);

				// are there enabled items?
				if (edit1.indexOf(",") > -1){
					edits = edit1.split(",");
					enabledItems = true;
				}

				if (answers != null && columns != null){

					String answer = null;
					String column = null;
					String bgColor = null;
					int i = 0;

					items = questions.size();

					if (isNewProgram && campus.equals(Constant.CAMPUS_LEE)){
						items = Constant.PROGRAM_ITEMS_TO_PRINT_ON_CREATE;
					}

					try{

						for (i=0; i<items; i++){

							question = (Question)questions.get(i);
							answer = (String)answers.get(i);
							column = (String)columns.get(i);

							showEditor = true;
							bgColor = "";

							if (enabledItems && edits[i].equals(Constant.OFF)){
								showEditor = false;
								bgColor = "#e1e1e1";
							}

							buf.append("<tr bgcolor=\"" + bgColor + "\"><td colspan=\"3\" class=\"textblackth\"><br>");

							buf.append((i+1) + ". " + question.getQuestion() + "<br><br>");

							if (enableMessageBoard.equals(Constant.OFF)){
								commentsCount = ReviewerDB.countReviewerCommentsBySeq(conn,kix,(i+1),Constant.TAB_PROGRAM,0);
							}
							else{
								commentsCount = ForumDB.countPostsToForum(conn,kix,(i+1));
							}

							if (commentsCount > 0 && fid > 0){
								buf.append("&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"##\" onClick=\"return hidePost('reviewerComments"+(i+1)+"');\" class=\"linkcolumn\"><img src=\"./forum/images/du_arrow.gif\" title=\"hide reviewer comments\"></a>"
									+ "&nbsp;"
									+ "<a href=\"##\" onClick=\"return showPost("+fid+","+(i+1)+");\" class=\"linkcolumn\"><img src=\"./forum/images/dd_arrow.gif\" title=\"show reviewer comments\"></a>"
									+ "<div class=\"reviewerComments"+(i+1)+"\" id=\"reviewerComments"+(i+1)+"\"></div>"
								);

							}

							boolean debug = false;

							if (showEditor){

								if (debug){
									answer = answer + "\n" + (i+1) + ". " + question.getQuestion() + " ("+aseUtil.getCurrentDateTimeString()+")";
								}

								buf.append("<textarea cols=\"80\" id=\"aseEditor"+i+"\" name=\"aseEditor"+i+"\" rows=\"10\">"+answer+"</textarea>");

								// array of editors created
								if(ckEditors.equals(Constant.BLANK)){
									ckEditors = "" +i;
								}
								else{
									ckEditors += "," + i;
								}

							}
							else{
								buf.append("<table class=\"mystyle\" width=\"100%\"> "
								+ "<tr> "
								+ "<td>" + answer + "</td> "
								+ "</tr> "
								+ "</table>");
							}

							// other additional data
							String enableOtherDepartmentLink = Util.getSessionMappedKey(session,"EnableOtherDepartmentLink");
							if (enableOtherDepartmentLink.equals(Constant.ON)){

								if (column.indexOf(Constant.PROGRAM_RATIONALE) > -1){

									buf.append("<br/><fieldset class=\"FIELDSET100\"><legend><a class=\"linkcolumn\" href=\"crsX29.jsp?kix="+kix+"&src="+src+"\">Other Departments</a></legend>"
													+ ExtraDB.getOtherDepartments(conn,
																							src,
																							campus,
																							kix,
																							false,
																							true)
													+ "</fieldset><br/>"
													);
								} // PROGRAM_RATIONALE

							} // enableOtherDepartmentLink

							buf.append("</td></tr>" );
						} // for
					}
					catch(Exception e){
						//System.out.println(e.toString());
					} // catch

					answers = null;
					columns = null;

					out.println(buf.toString());

				} // answers != null
			} // questions != null

			questions = null;

			String attachments = ProgramsDB.listProgramAttachments(conn,campus,kix);
			out.println("<tr>" );
			out.println("<td class=\'datacolumn\' colspan=\"3\"><fieldset class=\"FIELDSET100\">"
				+ "<legend><a name=\"attachment\">Attachments</a></legend>"
				+ Html.BR()
				+ attachments
				+ "</fieldset><br/><br/></td>" );
			out.println("</tr>" );

			String outineSubmissionWithProgram = Util.getSessionMappedKey(session,"OutineSubmissionWithProgram");
			int counter = ProgramsDB.countPendingOutlinesForApproval(conn,campus,division);
			if (outineSubmissionWithProgram.equals(Constant.ON) && counter > 0){
				out.println("<tr>" );
				out.println("<td class=\'datacolumn\' colspan=\"3\"><fieldset class=\"FIELDSET100\">"
					+ "<legend>Outlines Associated with this Program</legend>"
					+ Html.BR()
				   + helper.listOutlinesForSubmissionWithProgram(conn,campus,division)
					+ "</fieldset><br/><br/></td>");
				out.println("</tr>" );
			}

			out.println("				<tr>" );
			out.println("					 <td colspan=\'3\'><div class=\"hr\"></div></td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + campus + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'3\'><hr size=\'1\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input name=\'src\' type=\'hidden\' value=\'" + src + "\'>" );
			out.println("							<input name=\'items\' type=\'hidden\' value=\'" + items + "\'>" );

			if (!kix.equals(Constant.BLANK)){
				out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\'  title=\"save screen data\" class=\'inputsmallgray\' onClick=\"return checkForm('s')\">" );
				out.println("							<input type=\'submit\' name=\'aseReview\' id=\'aseReview\' value=\'Review\' title=\"submit for review\" class=\'inputsmallgray\' onClick=\"return aseReviewClick('v')\">" );
				out.println("							<input type=\'submit\' name=\'aseApproval\' id=\'aseApproval\' value=\'Approval\' title=\"submit for approval\" class=\'inputsmallgray\' onClick=\"return aseApprovalClick('a')\">" );
				out.println("							<input title=\"upload documents\" type=\'submit\' id=\'aseUpload\' name=\'aseUpload\' value=\'Attachment\'  title=\"attach supporting documents\" class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'prgedt\');\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input type=\'submit\' name=\'aseInsert\' id=\'aseInsert\' value=\'Insert\'  title=\"save screen data\" class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input title=\"upload documents\" type=\'submit\' id=\'aseUpload\' name=\'aseUpload\' title=\"attach supporting documents\"  value=\'Attachment\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'prgedt\');\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
			out.println("					 <br/><br/><font class=\"goldhighlights\">Note: questions placed over gray backgrounds are not editable at this time.</font></td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}

	} // if processPage
	else{
		out.println(message
			+ "<p><a href=\"tasks.jsp\" class=\"linkcolumn\">return to task listing</a>"
			+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<a href=\"prgrvwsts.jsp\" class=\"linkcolumn\">check review status</a></p>");
	}

	asePool.freeConnection(conn,"prgedt",user);
%>

</form>

<%
	if (processPage){
%>
	<script type="text/javascript">
	//<![CDATA[

		// Create all editor instances at the end of the page, so we are sure
		// that the "bottomSpace" div is available in the DOM (IE issue).

		// take editors created from textarea and create ckeditors

		// js ckEditors is set to jsp ckEditors content
		var ckEditors = "<%=ckEditors%>";

		// split to get each element
		var editors = ckEditors.split(",");

		// loop and create
		for(i=0;i<editors.length;i++){
			CKEDITOR.replace( 'aseEditor'+editors[i],
				{
					toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
										],
					enterMode : CKEDITOR.ENTER_BR,
					shiftEnterMode: CKEDITOR.ENTER_P
				}
			);
		}

	//]]>
	</script>
<%
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
