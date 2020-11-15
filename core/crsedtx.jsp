<%@ include file="ase.jsp" %>
<%@ page import="org.owasp.validator.html.*"%>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

	String sURL = "";
	String message = "";
	String temp = "";
	String junk = "";

	boolean debug = false;
	boolean messagePage = false;

	session.setAttribute("aseCallingPage","");

	int action = 0;
	int loopCounter = 0;
	int endOfThisTab = website.getRequestParameter(request,"endOfThisTab", 0);
	int recyclePage = website.getRequestParameter(request,"recyclePage", 0);
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String kix = website.getRequestParameter(request,"kix");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Update Outline Content";

	// outline audit stamp
	String lastUpdated = courseDB.getCourseItem(conn,kix,"auditdate");
	String[] taskText = TaskDB.getTaskMenuText(conn,"Work on New Course Outline",campus,alpha,num,"PRE",kix);
	String outlineStatus = taskText[Constant.TASK_MESSAGE];

	if (processPage && formName != null && formName.equals("aseForm") ){

		// clear out index expand/collaspe
		// force user to expand/collaspe at start of every modification
		if(endOfThisTab==1){
			session.setAttribute("aseEditIndex",null);
		}

		String currentNo = website.getRequestParameter(request,"lastNo");
		String data = website.getRequestParameter(request,"questions");
		String explain = website.getRequestParameter(request,"explain");

		int nextNo = website.getRequestParameter(request,"no",0);
		int currentTab = website.getRequestParameter(request,"currentTab",0);

		final int APPROVAL = 1;
		final int FINISH = 2;
		final int REVIEW = 3;
		final int SUBMIT = 4;

		if ( formAction.equalsIgnoreCase("a") ) action = APPROVAL;
		if ( formAction.equalsIgnoreCase("f") ) action = FINISH;
		if ( formAction.equalsIgnoreCase("r") ) action = REVIEW;
		if ( formAction.equalsIgnoreCase("s") ) action = SUBMIT;

		String column = website.getRequestParameter(request,"column");
		String question_explain = website.getRequestParameter(request,"question_explain");
		String selectedCheckBoxes = website.getRequestParameter(request,"selectedCheckBoxes");
		String lock = website.getRequestParameter(request,"lock","false");

		//
		//	a message should not be saved
		//
		if (column.indexOf(Constant.MESSAGE_PAGE) > -1){
			messagePage = true;
		}

		if (!messagePage){
			data = AntiSpamy.spamy(kix,column,data);

			//
			// ckeditor places <br /> when nothing is in the input box
			// causing validation to think that it's ok to get by
			// here, we remove the problem by getting rid of BR.
			// if after removal and there is content, then we can
			// leave things alone
			//
			String ckEditorBR = explain;
			if(ckEditorBR.startsWith("<br />") || ckEditorBR.startsWith("<br/>")){
				ckEditorBR = ckEditorBR.replace("<br />","")
												.replace("<br/>","")
												.replace("&nbsp;","")
												.trim();
				if(ckEditorBR.length() == 0){
					explain = "";
				}
			}

			explain = AntiSpamy.spamy(kix,column,explain);

			if (column.equals(Constant.COURSE_FUNCTION_DESIGNATION)){
				int maxFD = 10;
				String[] aFD = new String[maxFD];
				aFD[0] = website.getRequestParameter(request,"LAprogram","0");
				aFD[1] = website.getRequestParameter(request,"CA1category","0");
				aFD[2] = website.getRequestParameter(request,"CA2category","0");
				aFD[3] = website.getRequestParameter(request,"ASprogram","0");
				aFD[4] = website.getRequestParameter(request,"AScategory","0");
				aFD[5] = website.getRequestParameter(request,"AASprogram","0");
				aFD[6] = website.getRequestParameter(request,"AAScategory","0");
				aFD[7] = website.getRequestParameter(request,"BASprogram","0");
				aFD[8] = website.getRequestParameter(request,"BAScategory","0");
				aFD[9] = website.getRequestParameter(request,"XXprogram","0");

				data = "";
				for (loopCounter=0; loopCounter<maxFD; loopCounter++){
					if (loopCounter==0)
						data = aFD[loopCounter];
					else
						data = data + "," + aFD[loopCounter];
				}
			}
			else{
				//
				//	numberOfControls exits when working with checks or radios or other
				//	instances where a list of similar items is drawn. in this case
				//	we want to iterate the number of controls and collect their values.
				//
				// CHANGES HERE IMPACT raw edit also (OutlineServlet)
				//
				int numberOfControls = website.getRequestParameter(request,"numberOfControls",0,false);
				String fieldRefConsent = website.getRequestParameter(request,"fieldRefConsent","",false);
				if (numberOfControls > 0){
					data = "";
					// 1 or consent means that we have a radio or greater than 1 means check marks
					if (fieldRefConsent.equals("CONSENTPREREQ") && numberOfControls==3){
						String junkData = "";
						junkData = 	website.getRequestParameter(request,"questions_0", "0") + "," +
										website.getRequestParameter(request,"questions_1", "0") + "," +
										website.getRequestParameter(request,"questions_2", "0");
						data = junkData;
					}
					else if (numberOfControls==1)
						data = website.getRequestParameter(request,"questions_0", "0");
					else {

						int junkInt = 0;
						String junkData = "";

						selectedCheckBoxes = "";

						for (junkInt = 0; junkInt < numberOfControls; junkInt++){

							junkData = website.getRequestParameter(request,"questions_" + junkInt, "");

							if (!junkData.equals(Constant.BLANK)){
								if (junkInt==0 || selectedCheckBoxes.equals(Constant.BLANK))
									selectedCheckBoxes = junkData;
								else
									selectedCheckBoxes = selectedCheckBoxes + "," + junkData;
							}
						} // for

						data = selectedCheckBoxes;

						//
						//	when dealing with contact hours and there are drop down list, we combine
						//	each selected checked item with a separator with the hour
						//
						boolean includeRange = IniDB.showItemAsDropDownListRange(conn,campus,"NumberOfContactHoursRangeValue");
						if (includeRange){
							String[] tempString = data.split(",");
							int tempInt = tempString.length;
							data = "";
							for (junkInt = 0; junkInt < tempInt; junkInt++){
								junkData = website.getRequestParameter(request,tempString[junkInt] + "_ddl", "0");
								tempString[junkInt] = tempString[junkInt] + Constant.SEPARATOR + junkData;

								if (junkInt==0)
									data = tempString[junkInt];
								else
									data = data + "," + tempString[junkInt];
							}
						} // includeRange

					} // selectedCheckBoxes

				} // numberOfControls

			} // COURSE_FUNCTION_DESIGNATION

			//debug = true;

			if (debug){
				out.println( "kix: " + kix + "<br>");
				out.println( "alpha: " + alpha + "<br>");
				out.println( "num: " + num + "<br>");
				out.println( "campus: " + campus + "<br>");
				out.println( "currentNo: " + currentNo + "<br>");
				out.println( "currentTab: " + currentTab + "<br>");
				out.println( "data: " + data + "<br>");
				out.println( "explain: " + explain + "<br>");
				out.println( "question_explain: " + question_explain + "<br>");
				out.println( "formAction: " + formAction + "<br>");
				out.println( "action: " + action + "<br>");
				out.println( "msg code: " + msg.getCode() + "<br>");
				out.println( "column: " + column + "<br>");
				out.println( "selectedCheckBoxes: " + selectedCheckBoxes + "<br>");

				out.println( "---------------------------------<br>");
				out.println( "data 1: " + data + "<br>");
				out.println( "data 2: " + AntiSpamy.spamy(kix,column,data) + "<br>");
				out.println( "---------------------------------<br>");
			}
			else{
				msg.setMsg("");

				if (action==SUBMIT){
					// tab 0 or the banner tab does not have updatable fields
					if ((	currentTab==Constant.TAB_COURSE ||
							currentTab==Constant.TAB_CAMPUS ||
							currentTab==Constant.TAB_FORMS) && "false".equals(lock)){

						String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
						if (column.equals(Constant.COURSE_GESLO) && useGESLOGrid.equals(Constant.ON)){
							if(campus.equals(Constant.CAMPUS_HON)){
								msg = GESLODB.processGESLO_HON(conn,request,kix);
							}
							else{
								msg = GESLODB.processGESLO(conn,request,kix);
							}
						}
						else if (column.equals(Constant.COURSE_CCOWIQ)){
							CowiqDB.updateCowiq(conn,request,campus,kix,column,user);
						}
						else{
							msg = courseDB.updateCourse(conn,
																currentNo,
																campus,
																alpha,
																num,
																column,
																data,
																explain,
																question_explain,
																session.getId().toString(),
																currentTab,
																user);
						}

					} // currentTab = TAB_COURSE,TAB_CAMPUS,TAB_FORMS
					else{
						// to enter the next if condition. we know that on tab 0, it wouldn't matter
						// for tabs 1 and 2, rowsAffected is determine by the if of this else
						msg.setCode(0);
						msg.setMsg("");
					}
				} // action==SUBMIT

				if (!msg.getMsg().equals("Exception")){

					// if not desired to recycle back to item #1 at end of tab, end.
					if (endOfThisTab==1 && recyclePage==0 && action != APPROVAL && action != REVIEW){
						action = FINISH;
					}

					switch (action){
						case APPROVAL :
							// validate screen data before processing approval.
							String validation = null;
							String enableOutlineValidation = Util.getSessionMappedKey(session,"EnableOutlineValidation");
							if (enableOutlineValidation.equals(Constant.ON)){
								validation = outlines.validate(conn,campus,kix);
							}

							if (validation != null && validation.length() > 0)
								message = "Approval request is not permitted until the following item(s) are completed:<br/><br/>"
									+ validation
									+ "<p align=\"center\"><a href=\"crsedt.jsp?kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a></p>";
							else{
								//NOTE: Code here is identical to REVIEW accept for PROGRESS
								session.setAttribute("aseAlpha", alpha);
								session.setAttribute("aseNum", num);

								session.setAttribute("aseModificationMode", "");
								session.setAttribute("aseWorkInProgress", "0");
								session.setAttribute("aseProgress", "APPROVAL");

								sURL = "crsedt6.jsp?kix="+kix;

								// create the outline for easy and fast access
								Tables.createOutlines(campus,kix,alpha,num);
							}

							break;
						case FINISH :
							// log user action
							session.setAttribute("aseModificationMode", "");
							aseUtil.logAction(conn,user,"ACTION","Course edit completed",alpha,num,campus,kix);

							//"<a href=\"vwhtml.jsp?cps="+campus+"&kix="+kix+"&t=PRE\" class=\"linkcolumn\" target=\"_blank\">View outline</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +

							message = "Outline modification has ended. You may return to make more modifications at any time.<br/><br/>" +
								"<a href=\"crsedt.jsp?kix="+kix+"\" class=\"linkcolumn\">Modify outline</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +
								"<a href=\"vwcrsx.jsp?kix="+kix+"&t=PRE\" class=\"linkcolumn\">View outline</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +
								"<a href=\"tasks.jsp\" class=\"linkcolumn\">View my tasks</a>";

							// create the outline for easy and fast access
							Tables.createOutlines(campus,kix,alpha,num);

							// enable allowed only during modifications but not through approval process
							if (courseDB.enableOutlineItems(conn,campus,alpha,num,user))
								message += "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"shwfld.jsp?cmnts=0&edit=1&kix="+kix+"&t=PRE\" class=\"linkcolumn\">Enable outline items</a>";

							String enableCCLab = Util.getSessionMappedKey(session,"EnableCCLab");
							if (enableCCLab.equals(Constant.ON)){
								message += "<fieldset class=\"FIELDSET90\"><legend>CC Lab</legend>"
										+ "View <a href=\"vwpdf.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">"
										+ alpha + " " + num + " - " + courseDB.getCourseItem(conn,kix,"coursetitle")
										+ "</a> in Adobe PDF format."
										+ "<br><br><font class=\"goldhighlights\">Note: CC Lab is a work in progress. Web to PDF conversion should be reviewed for accuracy prior to use/distribution.</font>"
										+ "</fieldset>";

							}

							session.setAttribute("aseWorkInProgress", "0");
							break;
						case REVIEW :
							//NOTE: Code here is identical to APPROVAL accept for PROGRESS
							session.setAttribute("aseAlpha", alpha);
							session.setAttribute("aseNum", num);

							session.setAttribute("aseModificationMode", "");
							session.setAttribute("aseWorkInProgress", "0");
							session.setAttribute("aseProgress", "REVIEW");
							sURL = "crsedt6.jsp?kix="+kix;

							// create the outline for easy and fast access
							Tables.createOutlines(campus,kix,alpha,num);

							break;
						case SUBMIT :

							// create the outline for easy and fast access
							Tables.createOutlines(campus,kix,alpha,num);

							// DIVERSIFICATION
							// has rules and rules form are used elsewhere to determine program flow.
							// data is saved under session since it's passed forward for used
							// depending on rules and other criterion.
							String hasRules = website.getRequestParameter(request,"hasRules","0");
							String rulesForm = website.getRequestParameter(request,"rulesForm","");

							session.setAttribute("aseQuestions", data);

							// if for diversification and they already completed the form, don't forward.
							// there is a button on the screen for them to use
							boolean hasDiversification = ValuesDB.hasDiversification(conn,campus,kix,column);

							if (hasRules.equals(Constant.ON) && rulesForm.equals("diversification") && !hasDiversification){
								sURL = "crsrules.jsp?kix=" + kix + "&rls=" + hasRules + "&frm=" + rulesForm;
							}
							else{
								sURL = "crsedt.jsp?ts=" + currentTab + "&no=" + nextNo + "&kix=" + kix;
							}

							break;
					}	// switch
				}
				else{
					message = "Outline update failed.<br>";
				}	// if (!"Exception".equals(msg.getMsg()))

			}	// if debug
		} // mesage page
		else{
			sURL = "crsedt.jsp?ts=" + currentTab + "&no=" + nextNo + "&kix=" + kix;
		} // mesage page
	}	// processPage && valid form

	asePool.freeConnection(conn,"crsedtx",user);

	// clear these values when done
	if (formAction.equalsIgnoreCase("f")){
		session.setAttribute("aseAlpha", null);
		session.setAttribute("aseNum", null);
	}

	//
	//	redirects to the correct URL
	//
	//	if endOfThisTab == 1 then it's likely that we are on the last question for
	//	the tab. Also, if we are in add mode, then push to the third tab.
	//
	if (endOfThisTab==1){

		int maxNoCampus = 0;
		String modificationMode = Util.getSessionMappedKey(session,"aseModificationMode");
		String advanceToCampusTab = Util.getSessionMappedKey(session,"AdvanceCourseEditToCampusTab");

		if(advanceToCampusTab.equals(Constant.ON)){
			maxNoCampus = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
		}

		if (modificationMode.equals("A") || maxNoCampus > 0){
			response.sendRedirect("crsedt.jsp?ts=" + Constant.TAB_CAMPUS + "&kix="+kix);
		}
	}
	else{
		if (!debug && message.length() == 0){
			response.sendRedirect(sURL);
		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheaderx.jsp" %>

<%
	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

