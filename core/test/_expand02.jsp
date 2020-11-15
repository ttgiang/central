<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

http://localhost:8080/jquery/expand/expand00/expand3.htm#

<%
	//
	// NEED to work on collecting data from form submission
	// most are ok. need to collect check boxes, radios, and explain
	//

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

	String caller = "expand";
	String chromeWidth = "80%";
	fieldsetTitle = "Course Maintenance";
	String pageTitle = fieldsetTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix", "");

	//
	// for testing only
	//
	if(kix.equals(Constant.BLANK)){
		kix = helper.getKix(conn,"KAP","VIET","197F","CUR");
		campus = "KAP";
	}

	String ckEditors = "";
	String ckEditorsExplain = "";

	if (processPage){

		String editor = CampusDB.getCourseItems(conn,campus);
		String explain = website.getRequestParameter(request,"explain", "");

		if(!editor.equals(Constant.BLANK)){

			String[] editors = editor.split(",");
			String[] explains = explain.split(",");

			for(int i=0; i<editors.length; i++){
				//System.out.println((i+1) + "-" + editors[i] + ". " + website.getRequestParameter(request,"aseEditor"+editors[i], ""));
			} // i


		} // form submission took place

	}

%>

<html>
<head>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<%@ include file="ase2.jsp" %>

	<script language="JavaScript" src="js/CalendarPopup.js"></script>
	<link href="../inc/calendar.css" rel="stylesheet" type="text/css">
	<SCRIPT language="JavaScript" id="dateID">
		var dateCal = new CalendarPopup("dateDiv");
		dateCal.setCssPrefix("CALENDAR");
	</SCRIPT>

	<style type="text/css">
		/* --------
		  The CSS rules offered here are just an example, you may use them as a base.
		  Shape your 'expand/collapse' content so that it meets the style of your site.
		 --------- */
		* {margin:0; padding:0}
		/* --- Page Structure  --- */
		html {height:100%}
		body {
		  min-width:400px;
		  width:100%;
		  height:101%;
		  background:#fff;
		  color:#333;
		  font:76%/1.6 verdana,geneva,lucida,'lucida grande',arial,helvetica,sans-serif;
		  text-align:center
		}
		#wrapper{
		  width:100%;
		  margin:0 auto;
		  text-align:left
		}

		#content {
		  max-width:70em;
		  width:100%;
		  margin:0 auto;
		  padding-bottom:20px;
		  overflow:hidden
		}
		.demo {
		  margin:0;
		  padding:1.5em 1.5em 0.75em;
		  border:1px solid #ccc;
		  position:relative;
		  overflow:hidden
		}

		.commands div {
		  display: inline-block;
		  float: right;
			padding-left: 10px;
		}

		div.collapse {
			padding:0 10px 1em;
			border: solid 2px Transparent;
			padding-left: 15px;
			padding-right: 15px;
		}

		div.collapse:hover
		{
			border-color: #c0c0c0;
		}

		.collapse p {padding:0 10px 1em}
		.top{font-size:.9em; text-align:right}
		#switch, .switch {margin-bottom:5px; text-align:right}

		/* --- Headings  --- */
		h1 {
		  margin-bottom:.75em;
		  font-family:georgia,'times new roman',times,serif;
		  font-size:2.5em;
		  font-weight:normal;
		  color:#c30
		}
		h2{font-size:1em}

		.expand{padding-bottom:.75em}

		/* --- Links  --- */
		a:link, a:visited {
		  border:1px dotted #ccc;
		  border-width:0 0 1px;
		  text-decoration:none;
		  color:blue
		}
		a:hover, a:active, a:focus {
		  border-style:solid;
		  background-color:#f0f0f0;
		  outline:0 none
		}

		a:active, a:focus {
		  color:red;
		}

		.expand a {
		  display:block;
		  padding:3px 10px
		}

		.expand a:link, .expand a:visited {
		  border-width:1px;
		  background-image:url(img/arrow-down.gif);
		  background-repeat:no-repeat;
		  background-position:98% 50%;
		  color: #083772;
		}

		.expand a:hover, .expand a:active, .expand a:focus {
		  color: #E87B10;
		}

		.expand a.open:link, .expand a.open:visited {
		  border-style:solid;
		  background:#eee url(img/arrow-up.gif) no-repeat 98% 50%
		}
	</style>

	<style>
		#accordionExample {
			border : 1px solid #4f4f4f;
			width: 600px;
		}

		.panelheader{
			background-image: url('images/panelBG.png');
			height: 22px;
			color : #525252;
			font-weight : bold;
			padding-left: 5px;
		}

		.panelContent {
			background: #f8f8f8;
			overflow: auto;
		}
	</style>

	<style>
		#slidingDiv, #slidingDiv_2, #slidingDiv_X46{
			height:300px;
			background-color: #99CCFF;
			padding:20px;
			margin-top:10px;
			border-bottom:5px solid #3399FF;
			display:none;
		}
	</style>

	<!--[if lte IE 7]>
		<style type="text/css">
		h2 a, .demo {position:relative; height:1%}
		</style>
	<![endif]-->

	<!--[if lte IE 6]>
		<script type="text/javascript">
			try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
		</script>
	<![endif]-->
	<!--[if !lt IE 6]><!-->

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="./js/expand_collapse.js"></script>
	<link type="text/css" href="./js/plugins/jquery/css/ui-lightness/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />

	<script src="_showHide.js" type="text/javascript"></script>

	<script type="text/javascript">

		<!--//--><![CDATA[//><!--
		$(document).ready(function(){

			// --- Using the default options:
			//$("h2.expand").toggler();
    		$("h2.expand").toggler({initShow: "div.collapse:all"});
			// --- Other options:
			//$("h2.expand").toggler({method: "toggle", speed: 0});
			//$("h2.expand").toggler({method: "toggle"});
			//$("h2.expand").toggler({speed: "fast"});
			//$("h2.expand").toggler({method: "fadeToggle"});
			//$("h2.expand").toggler({method: "slideFadeToggle"});
			$("#content").expandAll({trigger: "h2.expand", ref: "div.demo", localLinks: "p.top a"});

			$('.show_hide').showHide({
				speed: 1000,  			// speed you want the toggle to happen
				easing: '',  			// the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
				changeText: 1, 		// if you dont want the button text to change, set this to 0
				showText: 'View',		// the button text to show when a div is closed
				hideText: 'Close' 	// the button text to show when a div is open
			});

			$( "#coursedate" ).datepicker();

		})(jQuery);
		//--><!]]>

	</script>
	<!--<![endif]-->

	<script type="text/javascript">
	//<![CDATA[

		var editor, html = '';

		//
		// item text value
		//
		var editorText = "";

		//
		// item text value
		//
		var editorCommand = "";
		var otherCommands = "";

		//
		// div holding editor
		//
		var editorDiv = "";


		/**
		*
		* setGlobalValues
		*
		**/
		function setGlobalValues(textOrExplain,editorName){

			editorText = textOrExplain+editorName;
			editorDiv = "aseEditorDiv"+editorName;
			editorCommand = "editorCommand"+editorName;
			otherCommands = "otherCommands"+editorName;

		}

		/**
		*
		* createEditor
		*
		**/
		function createEditor(textOrExplain,editorName,ckEditorControl){

			if (editor){
				return;
			}

			showEditor(editorName);

			setGlobalValues(textOrExplain,editorName);

			//
			// take the value from the displayed text and hold for later use
			// clear the display text div so we dont have large space take up room
			// hide display only text since it's going to show in the editor
			//
			var value = document.getElementById(editorText).innerHTML;
			document.getElementById(editorText).innerHTML = "";
			document.getElementById(editorText).style.visibility = "hidden";

			document.getElementById(editorCommand).style.visibility = "hidden";
			document.getElementById(otherCommands).style.visibility = "visible";

			// Create a new editor inside the <div id="editor">, setting its value to html
			CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
			CKEDITOR.config.shiftEnterMode = CKEDITOR.ENTER_P;
			CKEDITOR.config.toolbarCanCollapse = false;
			CKEDITOR.config.width = '100%';
			CKEDITOR.config.removePlugins = 'elementspath';
			CKEDITOR.config.toolbar =
			[
				 { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
				 { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
				 { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo', 'Source' ] }
			];
			editor = CKEDITOR.appendTo(editorDiv, null, html );

			//
			// Set editor contents (replace current contents).
			//
//editor.setData(value);

			hideEditor(editorName);

		}

		/**
		*
		* removeEditor
		*
		**/
		function removeEditor(textOrExplain,editorName,ckEditorControl,kix){

			if (ckEditorControl==1 && !editor){
				return;
			}

			var updateDate = 0;

			showEditor(editorName);

			if(ckEditorControl==1){
				setGlobalValues(textOrExplain,editorName);

				var dta = editor.getData();

				if(editor.checkDirty()){

					updateDate = 1;

					editor.resetDirty();
				} // dirty?

				document.getElementById(editorText).innerHTML = html = dta;

				document.getElementById(editorText).style.visibility = "visible";
				document.getElementById(editorCommand).style.visibility = "visible";
				document.getElementById(otherCommands).style.visibility = "hidden";

				// Destroy the editor.
				editor.destroy();
				editor = null;
			}
			else{
				var controlName = "aseEditor" + editorName;
				var dta = document.getElementById(controlName).value;
				updateDate = 1;
			} // ckEditorControl

			//
			// do we have to update our database
			//
			if(updateDate == 1){
				 $.ajax({
					  type:       "post",
					  url:        "expandx.jsp",
					  data:       {"kix":kix,"col":editorName,"dta":dta},
					  success:    function(msg) {
								document.getElementById("output").innerHTML = "OK";
							},
							error:function (xhr, ajaxOptions, thrownError){
								document.getElementById("output").innerHTML = xhr.status;
							}
				 });
			}

			hideEditor(editorName);

		}

		/**
		*
		* cancelEditor
		*
		**/
		function cancelEditor(textOrExplain,editorName,ckEditorControl){

			if (!editor){
				return;
			}

			showEditor(editorName);

			var dta = editor.getData();

			document.getElementById("output").innerHTML = "<img src=\"../images/loading-orange.gif\">";

			document.getElementById(editorText).innerHTML = html = dta;

			document.getElementById(editorText).style.visibility = "visible";
			document.getElementById(editorCommand).style.visibility = "visible";
			document.getElementById(otherCommands).style.visibility = "hidden";

			if(editor.checkDirty()){
				editor.resetDirty();
			}

			// Destroy the editor.
			editor.destroy();
			editor = null;

			hideEditor(editorName);

			document.getElementById("output").innerHTML = "";

		}

		/**
		*
		* showEditor
		*
		**/
		function showEditor(editorName){

			document.getElementById("progress_"+editorName).innerHTML = "<img src=\"../images/loading-orange.gif\">";

		}

		/**
		*
		* hideEditor
		*
		**/
		function hideEditor(editorName){

			document.getElementById("progress_"+editorName).innerHTML = "";

		}



	//]]>
	</script>


</head>

<body>
    <div id="wrapper">
      <div id="content">
          <div class="demo">
          	<div id="output"></div>
          	<form name="aseForm" method="post" action="expand.jsp">
				<%
					String[] rtn = drawHtmlForm(conn,campus,kix,session);
					out.println(rtn[0]);
					ckEditors = rtn[1];
					ckEditorsExplain = rtn[2];
				%>
				<input type="hidden" name="editor" value="<%=ckEditors%>">
				<input type="hidden" name="explain" value="<%=ckEditorsExplain%>">
				<input type="hidden" name="kix" value="<%=kix%>">
				<input type="submit" name="aseSubmit" value="submit" class="input">
				<br/><br/><br/>
				<ul>
					<li>editor set and get working properly</li>
					<li>issues with screen moving (sliding) up and down during expand/collapse</li>
					<li>too complicated to implement with all other controls in current form</li>
				</ul>
          	</form>
          </div>
        </div>
    </div>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

<%!

	/**
	*
	*/
	public static String[] drawHtmlForm(Connection conn,
													String campus,
													String kix,
													javax.servlet.http.HttpSession session){

		StringBuilder sb = new StringBuilder ();

		String ckEditors = "";
		String ckEditorsExplain = "";

		String alpha = "";
		String num = "";
		String courseTitle = "";

		boolean debug = false;

		try{

debug = true;

			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			courseTitle = info[Constant.KIX_COURSETITLE];

			int maxCourseItems = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			int maxCampusItems = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
			int totalItems = maxCourseItems + maxCampusItems;

			int itemCounter = 0;
			int pageCounter = 0;

			int table = Constant.TAB_COURSE;

totalItems = 8;

			for(int i=0; i<totalItems; i++){

				String HTMLFormField = "";
				String HTMLFormFieldExplain = "";

				// tell save button whether this is a CKEditor
				int ckEditorControl = 0;

				//
				// depending on the item, there may be a regular editor or an explain
				// this name is needed for the processing of CKEditor
				//
				String itemEditorName = "";

				boolean lock = false;
				boolean itemRequired = false;
				boolean showExplainEditor = false;

				++itemCounter;			// keeps track of actual sequence in table
				++pageCounter;			// keeps track of item printed to screen

				//
				// table to get data from course or campus
				//
				if(itemCounter > maxCourseItems){
					table = Constant.TAB_CAMPUS;
					itemCounter = 1;
				}


				CCCM6100 cccm6100 = CCCM6100DB.getCCCM6100(conn,itemCounter,campus,table);
				if ( cccm6100 != null ){

					//----------------------------------------------------
					// question specific data
					//----------------------------------------------------
					String question = cccm6100.getCCCM6100();
					String question_defalt = cccm6100.getDefalt();
					String question_friendly = cccm6100.getQuestion_Friendly();
					String question_type = cccm6100.getQuestion_Type();
					String question_ini = cccm6100.getQuestion_Ini();
					String question_explain = cccm6100.getQuestion_Explain();

					// make the input box a little bigger than the actual size
					// actual size is too small because of CSS
					int question_len = cccm6100.getQuestion_Len()+20;

					// for text area that is too big, it messes up screen display
					if (question_type.equals("textarea") && question_len>110){
						question_len = 110;
					}

					int question_max = cccm6100.getQuestion_Max();
					int question_userlen = cccm6100.getUserLen();

					String questionData[] = CourseDB.lookUpQuestion(conn,campus,alpha,num,type,question_friendly,table);

					String screenData = questionData[0];

					String extraData = "";
					String extraButton = "";
					String extraForm = "";
					String extraArg = "";
					String extraTitle = "";
					String extraCmdTitle = "";

					String[] xtra = getExtraData(conn,campus,kix,question_friendly,"expand",session);
					if(xtra != null){
						extraData = xtra[0];
						extraButton = xtra[1];
						extraForm = xtra[2];
						extraArg = xtra[3];
						extraTitle = xtra[4];
						extraCmdTitle = xtra[5];

						if (extraData != null && extraData.length() > 0){
							extraData = "<div id=\"accordionExample\"><div>"
								+ "<div class=\"panelheader\">"+extraTitle+"</div>"
								+ "<div class=\"panelContent\">"+extraData+"</div>"
								+ "</div></div><br>";
						}

					}

					//----------------------------------------------------
					// at no time do we allow editing of fields course alpha and number or editing on tab 1
					//----------------------------------------------------
					if (question_friendly.equals("coursealpha") || question_friendly.equals("coursenum")){
						lock = true;
					}
					else{
						// should we enable save button? -1 to account for array being 0-based
						//if (sEdits[currentSeq-1] != null && sEdits[currentSeq-1].equals(Constant.OFF)){
						//	submitDisabled = "disabled";
						//	submitClass = "off";
						//}
					}

					// proposed date is not editable
					if (question_friendly.indexOf("dateproposed")!=-1){
						lock = true;
					}

					if (cccm6100.getRequired().equals("Y")){
						itemRequired = true;
					}

					//----------------------------------------------------
					// draw GUI
					//----------------------------------------------------
					if (question_type.equals("wysiwyg")){

						HTMLFormField = questionData[0];

						// array of editors created
						if(ckEditors.equals(Constant.BLANK)){
							ckEditors = "" +question_friendly;
						}
						else{
							ckEditors += "," + question_friendly;
						}

						if(HTMLFormField.equals(Constant.BLANK)){
							HTMLFormField = "HTMLFormField - sample text";
						}

						itemEditorName = "aseEditorTextDiv";

						ckEditorControl = 1;
					}
					else{

						// add calendar select for date
						if (question_friendly.indexOf("date") > -1){
							question_type = "date";
						}

						HTMLFormField = aseUtil.drawHTMLField(conn,
																				question_type,
																				question_ini,
																				"aseEditor" + question_friendly,
																				screenData,
																				question_len,
																				question_max,
																				lock,
																				campus,
																				itemRequired,
																				question_friendly,
																				question_userlen);

						ckEditorControl = 0;

					} // question_type

					//----------------------------------------------------
					// do we display consent for pre/co req in its current state
					//----------------------------------------------------
					String displayConsentForCourseMods = Util.getSessionMappedKey(session,"DisplayConsentForCourseMods");
					if (	displayConsentForCourseMods.equals(Constant.OFF) &&
						(	question_friendly.equals(Constant.COURSE_PREREQ) ||
							question_friendly.equals(Constant.COURSE_COREQ) ||
							question_friendly.equals(Constant.COURSE_COMPARABLE) )
						) {
						HTMLFormField = "";
					} // DisplayConsentForCourseMods

					//----------------------------------------------------
					// get explanation. Most items have a column in campusdata for explain. For reasons for mods,
					//----------------------------------------------------
					if (question_friendly.equals(Constant.COURSE_CCOWIQ)){
						showExplainEditor = false;
					}
					else if (question_friendly.equals(Constant.COURSE_FUNCTION_DESIGNATION)){
						//HTMLFormField = FunctionDesignation.drawFunctionDesignation(conn,campus,questionData[0],false);
						showExplainEditor = true;
					}
					else{
						showExplainEditor = true;
					} // COURSE_CCOWIQ

					if (showExplainEditor && cccm6100.getComments().equals("Y")){

						if(question_explain != null && question_explain.length()>0){

							HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,alpha,num,type,question_explain);

							// set default value when there is something to set and the data
							// field to display is currently empty
							if (	(question_defalt != null && question_defalt.length() > 0) &&
									(HTMLFormFieldExplain == null || HTMLFormFieldExplain.length() == 0) ){

								if (question_friendly.indexOf("date") == -1){
									HTMLFormFieldExplain = question_defalt;
								}
							}

							if(HTMLFormFieldExplain.equals(Constant.BLANK)){
								HTMLFormFieldExplain = "HTMLFormFieldExplain - sample text";
							}

							// array of editors created
							if(ckEditorsExplain.equals(Constant.BLANK)){
								ckEditorsExplain = "" +question_explain;
							}
							else{
								ckEditorsExplain += "," + question_explain;
							}

							itemEditorName = "aseEditorExplainDiv";

							ckEditorControl = 1;

						}
					} // showExplainEditor

					//----------------------------------------------------
					// build output string
					//----------------------------------------------------
					String cmdEdit = "<img src=\"../images/edit.gif\" alt=\"edit\" title=\"edit\">";
					String cmdCancel = "<img src=\"../images/cancel.jpg\" alt=\"cancel\" title=\"cancel\" width=\"18\">";
					String cmdSave = "<img src=\"../images/save.png\" alt=\"save\" title=\"save\" width=\"18\">";
					String cmdTop = "<img src=\"../images/top.gif\" alt=\"back to top\" title=\"back to top\" width=\"18\">";

					sb.append("<h2 class=\"expand\">"+pageCounter+". "+question+"</h2>")
						.append("<div class=\"collapse\">")
						.append("<div id=\"aseEditorDiv"+question_friendly+"\"></div>")
						.append(extraData)
						.append("<div id=\"aseEditorTextDiv"+question_friendly+"\" style=\"visibility: show\">"
							+HTMLFormField
							+"</div>"
							+ "<p class=\"top\">"
							+ "<div id=\"editorCommand"+question_friendly+"\" class=\"commands\" style=\"visibility: show\">"
							+ "<div><a href=\"#content\" class=\"linkcolumn\">"+cmdTop+"</a></div>");

					if(ckEditorControl == 1){
						sb.append("<div><a href=\"#\" onClick=\"return createEditor('"+itemEditorName+"','"+question_friendly+"',"+ckEditorControl+",'"+kix+"');\">"+cmdEdit+"</a></div>");
					}

					sb.append("</p>");

					sb.append("</div>");

					sb.append("<div id=\"aseEditorExplainDiv"+question_friendly+"\" style=\"visibility: show\">"+HTMLFormFieldExplain+"</div>");

					sb.append("<p class=\"top\">");

					if(!lock){
							sb.append("<div id=\"otherCommands"+question_friendly+"\" class=\"commands\"  style=\"visibility: hidden\">");

							if(ckEditorControl == 1){
								sb.append("<div><a href=\"#\" onClick=\"return cancelEditor('"+itemEditorName+"','"+question_friendly+"',"+ckEditorControl+");\">"+cmdCancel+"</a></div>");
							}

							sb.append("<div><a href=\"#\" onClick=\"return removeEditor('"+itemEditorName+"','"+question_friendly+"',"+ckEditorControl+",'"+kix+"');\">"+cmdSave+"</a></div>");

							sb.append("<div id=\"progress_"+question_friendly+"\"></div>").append("</div>");
					}
					else{
						sb.append("this item is not editable");
					}

					sb.append("</p>");

					sb.append("</div>");
				}

			} // for i

			aseUtil = null;

		}
		catch(SQLException e){
			System.out.println("SQLException: " + e.toString());
		}
		catch(Exception e){
			System.out.println("Exception: " + e.toString());
		}

		String[] rtn = new String[3];

		rtn[0] = "<table width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\" id=\"warnmessage2\">"
					+ "<tbody><tr><td width=\"100%\">"
					+ alpha + " "
					+ num + " - "
					+ courseTitle + "</td></tr></tbody></table>"
					+ sb.toString();
		rtn[1] = ckEditors;
		rtn[2] = ckEditorsExplain;

		return rtn;

	}

	/**
	*
	*/
	public static String[] getExtraData(Connection conn,
														String campus,
														String kix,
														String friendly,
														String thisPage,
														javax.servlet.http.HttpSession session){

		String thisType = "PRE";

		String extraData = "";
		String extraButton = "";
		String extraForm = "";
		String extraArg = "";
		String extraTitle = "";
		String extraCmdTitle = "";

		try{

			AseUtil aseUtil = new AseUtil();

			String[] kixInfo = Helper.getKixInfo(conn,kix);
			String alpha = kixInfo[Constant.KIX_ALPHA];
			String num = kixInfo[Constant.KIX_NUM];
			String type = kixInfo[Constant.KIX_TYPE];

			if (friendly.equals(Constant.COURSE_ALPHA)){
				//
			}
			else if (friendly.equals(Constant.COURSE_CROSSLISTED)){
				extraData = CourseDB.getCrossListing(conn,kix);
				extraButton = "Cross-List";
				extraForm = "crsxrf";
				extraArg = "";
				extraTitle = "Cross List";
				extraCmdTitle = "enter additional cross listing";
			}
			else if (friendly.equals(Constant.COURSE_COMPETENCIES)){
				extraData = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
				extraButton = "Competencies";
				extraForm = "crslnks";
				extraArg = "src="+Constant.COURSE_COMPETENCIES+"&dst="+Constant.COURSE_COMPETENCIES;
				extraTitle = "Competencies";
				extraCmdTitle = "enter competencies";
			}
			else if (friendly.equals(Constant.COURSE_CONTENT)){
				extraData = ContentDB.getContentAsHTMLList(conn,campus,alpha,num,type,kix,false,false);
				extraButton = "Content";
				extraForm = "crscntnt";
				extraArg = "";
				extraTitle = "Content";
				extraCmdTitle = "enter additional Content";
			}
			else if (friendly.equals(Constant.COURSE_COREQ)){
				extraData = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,"");
				extraButton = "Co-Requisite";
				extraForm = "crsreq";
				extraArg = "";
				session.setAttribute("aseRequisite", "2");
				extraTitle = "Co-Requisite";
				extraCmdTitle = "enter additional Co-Requisites";
			}
			else if (friendly.equals(Constant.COURSE_GESLO)){
				String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
				if(useGESLOGrid.equals(Constant.OFF)){
					extraData = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_GESLO);
					extraButton = "GESLO";
					extraForm = "crsgen";
					extraArg = "src="+Constant.COURSE_GESLO+"&dst="+Constant.COURSE_GESLO;
					extraTitle = "GESLO";
					extraCmdTitle = "enter GESLO";
				}
			}
			else if (friendly.equals(Constant.COURSE_INSTITUTION_LO)){
				extraData = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_INSTITUTION_LO);
				extraButton = "ILO";
				extraForm = "crsgen";
				extraArg = "src="+Constant.COURSE_INSTITUTION_LO+"&dst="+Constant.COURSE_INSTITUTION_LO;
				extraTitle = "ILO";
				extraCmdTitle = "enter ILO";
			}
			else if (friendly.equals(Constant.COURSE_OTHER_DEPARTMENTS)){
				String enableOtherDepartmentLink = Util.getSessionMappedKey(session,"EnableOtherDepartmentLink");
				if ((Constant.ON).equals(enableOtherDepartmentLink)){
					extraData = ExtraDB.getOtherDepartments(conn,Constant.COURSE_OTHER_DEPARTMENTS,campus,kix,false,true);
					extraButton = "Other Department";
					extraForm = "crsX29";
					extraArg = "src="+Constant.COURSE_OTHER_DEPARTMENTS;
					extraTitle = "Other Department";
					extraCmdTitle = "Other Department";
				}
			}
			else if (friendly.equals(Constant.COURSE_OBJECTIVES)){
				extraData = CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,friendly);
				extraButton = "Course SLO";
				extraForm = "crscmp";
				extraArg = "s=c";
				extraTitle = "SLO";
				extraCmdTitle = "enter SLO";
			}
			else if (friendly.equals(Constant.COURSE_PREREQ)){
				extraData = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,"");
				extraButton = "Pre-Requisite";
				extraForm = "crsreq";
				extraArg = "";
				session.setAttribute("aseRequisite", "1");
				extraTitle = "Pre-Requisite";
				extraCmdTitle = "enter additional Pre-Requisites";
			}
			else if (friendly.equals(Constant.COURSE_PROGRAM)){
				extraData = ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,true);
				extraButton = "Program";
				extraForm = "crsprg";
				extraArg = "src="+Constant.COURSE_PROGRAM;
				extraTitle = "Program";
				extraCmdTitle = "For what program was the course designed?";
			}
			else if (friendly.equals(Constant.COURSE_PROGRAM_SLO)){
				extraData = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_PROGRAM_SLO);
				extraButton = "Program SLO";
				extraForm = "crsgen";
				extraArg = "src="+Constant.COURSE_PROGRAM_SLO+"&dst="+Constant.COURSE_PROGRAM_SLO;
				extraTitle = "Program SLO";
				extraCmdTitle = "enter Program SLO";
			}
			else if (friendly.equals(Constant.COURSE_RECPREP)){
				extraData = ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
				extraButton = "Rec Prep";
				extraForm = "crsxtr";
				extraArg = "src="+Constant.COURSE_RECPREP+"&dst="+Constant.COURSE_RECPREP;
				extraTitle = "Recommended Preparation";
				extraCmdTitle = "enter recommended preparation";
			}
			else if (friendly.equals(Constant.COURSE_TEXTMATERIAL)){
				extraData = TextDB.getTextAsHTMLList(conn,kix);
				extraButton = "Text";
				extraForm = "crsbk";
				extraTitle = "Text and Materials";
				extraCmdTitle = "enter text and materials";
			}

			aseUtil = null;

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		String[] xtra = new String[6];
		xtra[0] = extraData;
		xtra[1] = extraButton;
		xtra[2] = extraForm;
		xtra[3] = extraArg;
		xtra[4] = extraTitle;
		xtra[5] = extraCmdTitle;

		return xtra;

	}

%>

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

			CKEDITOR.replace('aseEditor'+editors[i],
				{
					toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
										],
					enterMode : CKEDITOR.ENTER_BR,
					shiftEnterMode: CKEDITOR.ENTER_P,
				});
		}

		// js ckEditors is set to jsp ckEditors content
		var ckEditorsExplain = "<%=ckEditorsExplain%>";

		// split to get each element
		var editorsExplain = ckEditorsExplain.split(",");

		// loop and create
		for(i=0;i<editorsExplain.length;i++){

			CKEDITOR.replace('aseEditorExplain'+editorsExplain[i],
				{
					toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
										],
					enterMode : CKEDITOR.ENTER_BR,
					shiftEnterMode: CKEDITOR.ENTER_P,
				});
		}


	//]]>
	</script>
<%
	}

%>

</body>
</html>

