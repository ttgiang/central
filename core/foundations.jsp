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
	fieldsetTitle = "Foundation Maintenance";
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

		// requires for generic upload
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

<body>
  <form method="post" name="aseForm" action="/central/servlet/amidala?ack=updt">
    <table width='80%' cellspacing='1' cellpadding='2' align='center' border='0'>
      <tr>
        <td class="textblackth" width="20%">Course Alpha & Number:&nbsp;</td>
        <td class="textblackth">
        	<input type="text" name="" value="" class='input'>
        	<input type="text" name="" value="" class='input'>
        </td>
      </tr>
      <tr>
        <td class="textblackth" width="20%">Course Title:&nbsp;</td>
        <td><input type="text" name="" value="" size='70' class='input'></td>
      </tr>

      <tr>
        <td class="textblackth" width="20%">Cross Listed?&nbsp;</td>
        <td class="textblackth">
        	<input type="text" name="" value="" class='input'>
        	<input type="text" name="" value="" class='input'>
        </td>
      </tr>

      <tr>
        <td class="textblackth" width="20%">Foundation Area Requested.</td>
        <td class="textblackth">
				<input type="radio" name="1" value="" class='input'><font class="normaltext">Written Communication</font><br>
				<input type="radio" name="1" value="" class='input'><font class="normaltext">Symbolic Reasoning</font><br>
				<input type="radio" name="1" value="" class='input'><font class="normaltext">Global & Multicultural Perspectives</font>
        </td>
      </tr>

      <tr><td class="textblackth" colspan="2">Official Course Description. Submit a copy of the course description from the current Catalog. The course description must be consistent with all Hallmarks of the desired Foundations area</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">How many instructors currently teach this course? It makes a difference if there are only one or two instructors teaching this course versus ten instructors teaching this course. This question is asked to get an idea of how many instructors the department needs to communicate with to discuss this foundation course.</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Hallmark Requirements. Provide an explanation of how each of the hallmarks for this proposed Foundation course will be satisfied. Try to completely answer how the course intends to meet each particular hallmark. Referencing assignments, tasks, and evaluations used in the course (as stated on the syllabus /syllabi being submitted) as supporting evidence would be very helpful.</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Syllabus. Submit a master syllabus. If multiple instructors teach the course and use varying texts and/or assignments, please include multiple representative syllabi for comparison. (Three is recommended.)</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Review Process. Provide a brief explanation of how the department will demonstrate in five years that this course has been meeting the Foundations Hallmarks.</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Course Outline. Submit the Course Outline approved by the Curriculum Committee.  Additional information, such as representative syllabi, may be requested by the Board.</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Assessment. Provide a brief explanation of how the department will demonstrate in five years that this course has been meeting the Foundations Hallmarks.  For example, what kinds of course materials will be provided to document adherence to the Hallmarks?</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr><td class="textblackth" colspan="2">Application Questions. Explain how this course will satisfy the Foundations criteria by answering all of the questions under each Hallmark.</td></tr>
      <tr>
        <td class="textblackth" colspan="2"><img src="../images/editor.gif"></td>
      </tr>

      <tr>
        <td colspan="2">
        	<h2 class="titlemessage18">Foundations Hallmarks & Application Questions</h2>
        	</td>
      </tr>

      <tr>
        <td colspan="2">
        	<h2 class="titlemessage">GLOBAL AND MULTICULTURAL PERSPECTIVES (FG): To satisfy the FG requirement, a course will</h2>
        	</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        1. provide students with a large-scale analysis of human development and change over time. (Note: the two FG courses will together cover the whole
        time period from pre-history to present. <font class="normaltext"><i>Where does your course best fit in this scheme: Group A - content primarily before 1500 CE;
        Group B - content primarily after 1500 CE; or Group C - pre-history to present?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        2. analyze the development of human societies and their cultural traditions through time in different regions (including Africa, the Americas,
        Asia, Europe, and Oceania) and using multiple perspectives. <font class="normaltext"><i>Which human societies and cultural traditions are analyzed? What perspectives are employed? What time periods are covered?</i></font>
			<img src="../images/editor.gif">
			</td>
		</tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        3. offer a broad, integrated analysis of cultural, economic, political, scientific, and/or social development that recognizes the diversity of
        human societies and their cultural traditions. <font class="normaltext"><i>Which of these aspects of development are analyzed? How does the course recognize diversity? In what ways are analyses integrated?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        4. examine processes of cross-cultural interaction and exchange that have linked the world's peoples through time while recognizing diversity. <font class="normaltext"><i>What processes of cross-cultural interaction are examined?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        5. include at least one component on Hawaiian, Pacific, or Asian societies and their cultural traditions. <font class="normaltext"><i>What components of Hawaiian, Pacific, or Asian societies and their cultural traditions are included in the course?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
        6. engage students in the study and analysis of writings, narratives, texts, artifacts, and/or practices that represent the perspectives of different societies and cultural traditions. <font class="normaltext"><i>List the items that students will analyze and briefly explain what perspectives they represent.</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr>
        <td colspan="2">
        	<h2 class="titlemessage">SYMBOLIC REASONING (FS): To satisfy the FS requirement, a course will</h2>
        	</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
		1. expose students to the beauty, power, clarity and precision of formal systems. <font class="normaltext"><i>How will the course meet this hallmark?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			2. help students understand the concept of proof as a chain of inferences. <font class="normaltext"><i>How will instructors help students understand this concept?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			3. teach students how to apply formal rules or algorithms. <font class="normaltext"><i>How will instructors meet this hallmark? </i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			4. require students to use appropriate symbolic techniques in the context of problem solving, and in the presentation and critical evaluation of evidence. <font class="normaltext"><i>What symbolic techniques will be required and in what contexts? How will presentations and evaluations of evidence be incorporated into the course?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			5. not focus solely on computational skills. <font class="normaltext"><i>What reasoning skills will be taught in the course?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			6. build a bridge from theory to practice and show students <font class="normaltext"><i>how to traverse this bridge. How will instructors help students make connections between theory and practice?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr>
        <td colspan="2">
        	<h2 class="titlemessage">WRITTEN COMMUNICATION (FW): To satisfy the FW requirement, a course will</h2>
        	</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			1. introduce students to different forms of college-level writing, including, but not limited to, academic discourse, and guide them in writing for different purposes and audiences. <font class="normaltext"><i>What forms of writing are taught in the course? What purposes and what audiences will students address?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			2. provide students with guided practice of writing processes-planning, drafting, critiquing, revising, and editing-making effective use of written and oral feedback from the faculty instructor and from peers. <font class="normaltext"><i>How will the instructors guide students and help them make effective use of instructor and peer feedback?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			3. require at least 5000 words of finished prose--equivalent to approximately 20 typewritten/printed pages. <font class="normaltext"><i>How many pages of finished prose will each student complete?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			4. help students develop information literacy by teaching search strategies, critical evaluation of information and sources, and effective selection of information for specific purposes and audiences; teach appropriate ways to incorporate such information, acknowledge sources and provide citations. <font class="normaltext"><i>How will instructors help students develop information literacy? How will students learn to incorporate and acknowledge sources appropriately?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

      <tr bgcolor="">
        <td colspan="2" class="textblackth">
			5. help students read texts and make use of a variety of sources in expressing their own ideas, perspectives, and/or opinions in writing. <font class="normaltext"><i>What reading strategies will be taught? How will students learn to make effective use of sources in their own writing?</i></font>
			<img src="../images/editor.gif">
			</td>
      </tr>

    </table>
  </form>
<%
	asePool.freeConnection(conn,"prgedt",user);
%>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
