<%
	extraDataFound = false;

	switch (currentTab){
		case TAB_BANNER :
			// on banner tab, read data and show as is
			banner = BannerDB.getBanner(conn,courseAlpha,courseNum,campus);
			break;
		case TAB_COURSE :
		case TAB_CAMPUS :

			// currentTab is used on the campus tab to extend the counting from TAB_COURSE to TAB_CAMPUS
			if (currentTab==TAB_CAMPUS){
				courseTabCount = courseDB.countCourseQuestions(conn,campus,"Y","",TAB_COURSE);
			}

			// prevent overflow/out of bounds
			if ( nextNo > maxNo ){
				nextNo = minNo;
			}

			//
			//	this is used for adding a new question; stored for moving forward;
			//	could easily request from the database the max and add 1 to it.
			//	this is less work on the db side.
			//
			newNo = maxNo + 1;

			cccm6100 = CCCM6100DB.getCCCM6100(conn,currentSeq,campus,currentTab);
			if ( cccm6100 != null ){
				question = cccm6100.getCCCM6100();
				question_ini = cccm6100.getQuestion_Ini();
				question_type = cccm6100.getQuestion_Type();
				question_defalt = cccm6100.getDefalt();

				// make the input box a little bigger than the actual size
				// actual size is too small because of CSS
				question_len = cccm6100.getQuestion_Len()+20;

				// for text area that is too big, it messes up screen display
				if (question_type.equals("textarea") && question_len>110){
					question_len = 110;
				}

				question_max = cccm6100.getQuestion_Max();
				question_friendly = cccm6100.getQuestion_Friendly();
				question_explain = cccm6100.getQuestion_Explain();
				question_change = cccm6100.getChange();
				questionHelp = cccm6100.getHelpFile();
				questionAudio = cccm6100.getAudioFile();
				question_userlen = cccm6100.getUserLen();
				question_CountText = cccm6100.getCounter();
				question_Extra = cccm6100.getExtra();

				if (cccm6100.getRequired().equals("Y")){
					itemRequired = true;
				}
				else{
					itemRequired = false;
				}

				// DIVERSIFICATION
				hasRules = cccm6100.getRules()+"";
				if (hasRules.equals("true")){
					hasRules = "1";
				}
				else{
					hasRules = "0";
				}
				rulesForm = cccm6100.getRulesForm();

				commentsBox = cccm6100.getComments();

				//
				//	get the data for the course and number requested
				//	lookupx is used because we want the field and the edit code
				//	edit code is a string of CSV. 0 if not editable, and the question
				//	number if it is.
				//	questionData[0] is the value and questionData[1] contains the CSV
				//

				questionData = courseDB.lookUpQuestion(conn,campus,courseAlpha,courseNum,"PRE",question_friendly,currentTab);

				//System.out.println( "question_friendly: **" + question_friendly );
				//System.out.println( "Data: **" + questionData[0] );
				//System.out.println( "Edit" + currentTab + ": **" + questionData[1]);

				// for reference in additional or extra button calling programs
				session.setAttribute("aseQuestionFriendly", question_friendly);

				//System.out.println(cccm6100);

				// this is for data retrieval to display the exta button
				if (question_Extra.equals("Y")){
%>
	<%@ include file="crsedt14.jsp" %>
<%
				}
				else if (question_friendly.indexOf(Constant.MESSAGE_PAGE) > -1){
					messagePage = true;
				} // extra button

			} // cccm6100 != null

			//
			//	for message only pages, don't bother with data retrieval
			//
			if (!messagePage){
				// it makes sense to have cross list showing correctly when nothing is there.
				if (question_friendly.equals("crosslisted") && extraData != null && extraData.length() > 0)
					questionData[0] = "1";

				// set to good data
				if ("NODATA".equals(questionData[0]) || "ERROR".equals(questionData[0])) {
					questionData[0] = "";	// data
					questionData[1] = "";	// edit or not flag
				}
				else{
					if (	question_friendly.indexOf("date") > -1 ||
							question_friendly.equals(Constant.COURSE_GESLO) ){

						validate = "1";

						if (question_friendly.indexOf("date") > -1){
							questionData[0] = aseUtil.ASE_FormatDateTime(questionData[0],Constant.DATE_DATETIME);
							extraHelp = "<font class=\"datacolumn\">(MM/DD/YYYY)</font>";
						}
					}
				}
			}
			else{
				questionData[0] = "";	// data
				questionData[1] = "";	// edit or not flag
			} // !messagePage

			//
			//	questionData[1] = 1 for edit
			//	questionData[1] = 2 for review
			//	questionData[1] = 3 for approval
			//	questionData[1] = 1's and 0's for editable disapprovals
			//
			//
			// sEdits contain array of cccm6100 question numbers
			//

			if (questionData[1] == null || questionData[1].length() == 0){
				questionData[1] = "";
				for ( i=0; i<maxNo; i++ ){
					if ( i != 0 ){
						questionData[1] += ",";
					}

					questionData[1] += "0";
				}
			}
			else{
				//
				//	the only time a single character is in this field is when the content
				//	contains a 1 to indicate ok to edit all fields
				//		when editable, all fields are opened
				//	contains a 2 to indicate we are under review process; when route is not available,
				//		review button should not be turned off
				//	contains a 3 to indicate we are under approval process
				//
				if (questionData[1].equals(Constant.ON) && !approvalInProgress){
					bEdit = true;
				}
				else if ((questionData[1].equals("2") || approvalInProgress) && route > 0){
					reviewDisabled = "disabled";
					reviewClass = "off";
					bEdit = false;
					submitDisabled = "disabled";
					submitClass = "off";
				}
				else {

					if (route > 0){
						reviewDisabled = "disabled";
						reviewClass = "off";
					}

					bEdit = true;
					submitDisabled = "";
					bApproval = true;
					approvalDisabled = "true";

					//
					//	when the length is greater than 1, it's because we are in
					//	approval and the editable flags are turn on/off
					//
					//	extra button contains data that are filled out for an outline
					//	like pre/co req and cross listing. if not allowed to edit,
					//	turn off.
					//
					sEdits = questionData[1].split(",");
					if (sEdits[currentSeq-1].equals(Constant.OFF)){
						if (route > 0){
							bEdit = false;
							lock = true;
							submitDisabled = "disabled";
							submitClass = "off";
							extraDisabled	= "disabled";
							extraClass = "off";
						}
					}
					else{
						extraDisabled	= "";
						extraClass = "";
					}
				}
			} 	//	questionData[1] == null

			// at no time do we allow editing of fields course alpha and number or editing on tab 1
			if (question_friendly.equals("coursealpha") || question_friendly.equals("coursenum") || currentTab==0){
				submitDisabled = "disabled";
				submitClass = "off";
				lock = true;
			}
			else{
				// should we enable save button? -1 to account for array being 0-based
				if (sEdits[currentSeq-1] != null && sEdits[currentSeq-1].equals(Constant.OFF)){
					submitDisabled = "disabled";
					submitClass = "off";
				}
			}

			// proposed date is not editable
			if (question_friendly.indexOf("dateproposed")!=-1){
				submitDisabled = "disabled";
				submitClass = "off";
				lock = true;
			}

			//
			// for testing to fill data automatically. extract data to fit the length of the expected field.
			//
			if (tester.equals(faculty)) {
				if (questionData[0].equals(Constant.BLANK) && question_type.equals("wysiwyg")) {
					questionData[0] = currentSeq + ". " + question;
				}
				else{
					if (currentTab>0){
						if (question_friendly.indexOf("X")==0){
							questionData[0] = questionData[0] + aseUtil.getCurrentDateTimeString();
						}
						else if (question_friendly.indexOf("date") > -1 ){
							questionData[0] = aseUtil.getCurrentDateTimeString();
						}
					}
				}
			}

			// TO DO - for some reason, the encoded space is not good
			questionData[0] = Html.fixHTMLEncoding(questionData[0]);

			// set default value when there is something to set and the data
			// field to display is currently empty
			if (	(question_defalt != null && question_defalt.length() > 0) &&
					(questionData[0] == null || questionData[0].length() == 0) ){

				if (question_friendly.indexOf("date") == -1){
					questionData[0] = question_defalt;
				}
			}

			// draw the field on screen. get the explained data if available.
			if (!messagePage){

				//
				//	number of credits how offer as a drop down list
				//	start by determing if there are numbers in kval1 and kval2 of tblini
				//
				//	if there is number in kval2 and it's greater than 0, then we have
				//	request to use list box
				//
				if (question_friendly.equals(Constant.COURSE_CREDITS)){
					String[] listRange = Util.getINIKeyValues(conn,campus,"NumberOfCreditsRangeValue");
					if (listRange != null){
						if (	NumericUtil.isInteger(listRange[0]) &&
								NumericUtil.isInteger(listRange[1]) &&
								Integer.parseInt(listRange[1]) > 0){
							question_type = "listboxrange";
							question_len = Integer.parseInt(listRange[0]);
							question_max = Integer.parseInt(listRange[1]);
						}
					} // listRange != null
				} // Constant.COURSE_CREDITS
				else if (question_friendly.equals(Constant.COURSE_PROGRAM)){
					//question_type = "listboxrange";
				} // COURSE_PROGRAM

				if (question_type.equals("wysiwyg")){

					if(useCkEditor){

						HTMLFormField = "<textarea cols=\"80\" id=\""+controlName+"\" name=\""+controlName+"\" rows=\"10\">"+questionData[0]+"</textarea>";

						if(ckEditors.equals(Constant.BLANK)){
							ckEditors = controlName;
						}
						else{
							ckEditors += "," + controlName;
						}

					}
					else{
						fckEditor = new FCKeditor(request,controlName,fckEditorWidth,"200","ASE","","");
						fckEditor.setValue(questionData[0]);
						HTMLFormField = fckEditor.toString();
					}

				}
				else{

					// add calendar select for date
					if (question_friendly.indexOf("date") > -1){
						question_type = "date";
					}

					//----------------------------------------------------
					// handle rename display
					//----------------------------------------------------

					String screenData = questionData[0];

					if (question_friendly.equals(Constant.COURSE_ALPHA) || question_friendly.equals(Constant.COURSE_NUM) || currentTab==0){
						RenameDB renameDB = new RenameDB();
						screenData = screenData + renameDB.getRenameToOutline(conn,campus,kix);
						renameDB = null;
					}

					//----------------------------------------------------
					// draw GUI
					//----------------------------------------------------
					HTMLFormField = aseUtil.drawHTMLField(conn,
											question_type,
											question_ini,
											controlName,
											screenData,
											question_len,
											question_max,
											lock,
											campus,
											itemRequired,
											question_friendly,
											question_userlen);

				} // question_type

				// do we display consent for pre/co req in its current state
				String displayConsentForCourseMods = Util.getSessionMappedKey(session,"DisplayConsentForCourseMods");
				if (	displayConsentForCourseMods.equals(Constant.OFF) &&
					(	question_friendly.equals(Constant.COURSE_PREREQ) ||
						question_friendly.equals(Constant.COURSE_COREQ) ||
						question_friendly.equals(Constant.COURSE_COMPARABLE) )
					) {
					HTMLFormField = "";
				} // DisplayConsentForCourseMods

				//
				// not all items have an explanation
				//
				if (question_friendly.equals(Constant.COURSE_CCOWIQ)){
					HTMLFormField = CowiqDB.drawCowiq(conn,campus,kix,false);
					showExplainEditor = false;
				}
				else if (question_friendly.equals(Constant.COURSE_FUNCTION_DESIGNATION)){
					HTMLFormField = FunctionDesignation.drawFunctionDesignation(conn,campus,questionData[0],false);
					showExplainEditor = true;
				}
				else if (question_friendly.equals(Constant.COURSE_GESLO)){

					String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
					if(useGESLOGrid.equals(Constant.ON)){
						HTMLFormField = "";
						HTMLFormFieldExplain = GESLODB.getGESLO(conn,campus,kix,false);
						showExplainEditor = false;
					}
					else{
						showExplainEditor = true;
					}

				}
				else{
					showExplainEditor = true;
				} // COURSE_CCOWIQ

				//
				// get explanation. Most items have a column in campusdata for explain. For reasons for mods,
				//
				if (showExplainEditor && commentsBox.equals("Y")){

					if(question_explain!=null && question_explain.length()>0){

						HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,courseAlpha,courseNum,type,question_explain);

						// set default value when there is something to set and the data
						// field to display is currently empty
						if (	(question_defalt != null && question_defalt.length() > 0) &&
								(HTMLFormFieldExplain == null || HTMLFormFieldExplain.length() == 0) ){

							if (question_friendly.indexOf("date") == -1){
								HTMLFormFieldExplain = question_defalt;
							}
						}

						if(useCkEditor){

							if (tester.equals(faculty)){
								if(HTMLFormFieldExplain == null || HTMLFormFieldExplain.length()==0){
									HTMLFormFieldExplain = currentSeq + ". " + question;
								}
								else{
									HTMLFormFieldExplain += Html.BR() + aseUtil.getCurrentDateTimeString();
								}
							}

							HTMLFormFieldExplain = "<textarea cols=\"80\" id=\"explain\" name=\"explain\" rows=\"10\">"+HTMLFormFieldExplain+"</textarea>";

							if(ckEditors.equals(Constant.BLANK)){
								ckEditors = "explain";
							}
							else{
								ckEditors += ",explain";
							}

						}
						else{

							// set default value when there is something to set and the data
							// field to display is currently empty
							if (	(question_defalt != null && question_defalt.length() > 0) &&
									(HTMLFormFieldExplain == null || HTMLFormFieldExplain.length() == 0) ){

								if (question_friendly.indexOf("date") == -1){
									HTMLFormFieldExplain = question_defalt;
								}
							}

							fckEditorExplain = new FCKeditor(request,"explain",fckEditorWidth,"200","ASE","","");

							if (tester.equals(faculty)){
								if(HTMLFormFieldExplain == null || HTMLFormFieldExplain.length()==0){
									HTMLFormFieldExplain = currentSeq + ". " + question;
								}
								else{
									HTMLFormFieldExplain += Html.BR() + aseUtil.getCurrentDateTimeString();
								}
							}

							fckEditorExplain.setValue(HTMLFormFieldExplain);

							HTMLFormFieldExplain = fckEditorExplain.toString();

						} // useCkEditor

					}
				} // showExplainEditor

				// ER00024/25 - UH MANOA - ttg - 2011.10.22
				String systemCountText = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableTextCounter");
				if (systemCountText.equals(Constant.ON) && question_CountText.equals("Y")){
					if (HTMLFormField != null && HTMLFormField.length() > 0){
						HTMLFormField += "<div class=\"w3cbutton3short\" id=\"editorWordCount\"></div>";
					}

					if (HTMLFormFieldExplain != null && HTMLFormFieldExplain.length() > 0){
						HTMLFormFieldExplain += "<div class=\"w3cbutton3short\" id=\"editorWordCountExplain\"></div>";
					}
				} // countText

			} // if (!messagePage)
			else{
				HTMLFormField = QuestionDB.getCourseHelp(conn,campus,currentTab,currentSeq);
			}  // if (!messagePage)

			break;
		case TAB_STATUS :
			statusTab = courseDB.getCourseDates(conn,kix);
			break;
		case TAB_FORMS :
			questionData = courseDB.lookUpQuestion(conn,campus,courseAlpha,courseNum,"PRE",Constant.COURSE_FORMS,currentTab);
			extraData = FormDB.getTextAsHTMLList(conn,campus);
			extraForm = "crsattach";
			extraTitle = "Additional Forms";

			if(useCkEditor){
				HTMLFormField = "<textarea cols=\"80\" id=\""+controlName+"\" name=\""+controlName+"\" rows=\"10\">"+questionData[0]+"</textarea>";

				if(ckEditors.equals(Constant.BLANK)){
					ckEditors = controlName;
				}
				else{
					ckEditors += "," + controlName;
				}
			}
			else{
				fckEditorExplain = new FCKeditor(request,controlName,fckEditorWidth,"200","ASE","","");
				fckEditorExplain.setValue(questionData[0]);
				HTMLFormField = fckEditorExplain.toString();
			}

			break;
		case TAB_ATTACHMENT :
			extraData = AttachDB.getAttachmentAsHTMLList(conn,kix);
			extraTitle = "Attachments";
			extraButton = "Attachments";
			extraForm = "crsattach";
			extraArg = "";
			extraCmdTitle = "attachment documents";
			break;
	}	// switch

	//
	//	final catch for approval button
	//
	if (DateUtility.isTodayInRangeWith(conn,campus,"OutlineApprovalBlackOutDate")){
		if(!progress.equals(Constant.COURSE_REVISE_TEXT)){
			approvalClass = "off";
			approvalDisabled = "disabled";
		}
		else{
			if(!allowRevisionsDuringApprovalBlackout.equals(Constant.ON)){
				approvalClass = "off";
				approvalDisabled = "disabled";
			}
		}
	}

	/*
		button to collect additonal data
	*/
	if (extraData != null && extraData.length() > 0){
		extraDataFound = true;
	}

%>

