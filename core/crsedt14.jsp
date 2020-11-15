<%
				String thisType = "PRE";

				// make sure we only use the following code when not editing
				if(!thisPage.equals("crsedt")){
					String[] kixInfo = helper.getKixInfo(conn,kix);
					thisType = kixInfo[Constant.KIX_TYPE];
				}

				if (question_friendly.equals(Constant.COURSE_ALPHA)){
					//
				}
				else if (question_friendly.equals(Constant.COURSE_AAGEAREA_C40) ){
					// show the button only if there is data for the matrix. Otherwise,
					// when the correct entry is selected, CC will forward to the proper page
					long countRecords = aseUtil.countRecords(conn,"tblValues","WHERE campus='"
											+ campus
											+ "' AND topic='"
											+ questionData[0]
											+ "'");

					if (countRecords > 0){
						extraData = "";
						extraButton = "Diversification";
						extraForm = "crsrules";
						extraArg = "frm=diversification";
						extraTitle = "";
						extraCmdTitle = "enter diversification data";
					}
					else
						extraButton = "";
				}
				else if (question_friendly.equals(Constant.COURSE_CROSSLISTED)){
					extraData = courseDB.getCrossListing(conn,kix);
					extraButton = "Cross-List";
					extraForm = "crsxrf";
					extraArg = "";
					extraTitle = "Cross List";
					extraCmdTitle = "enter additional cross listing";
				}
				else if (question_friendly.equals(Constant.COURSE_COMPETENCIES)){
					extraData = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
					extraButton = "Competencies";
					extraForm = "crslnks";
					extraArg = "src="+Constant.COURSE_COMPETENCIES+"&dst="+Constant.COURSE_COMPETENCIES;
					extraTitle = "Competencies";
					extraCmdTitle = "enter competencies";
				}
				else if (question_friendly.equals(Constant.COURSE_CONTENT)){
					extraData = ContentDB.getContentAsHTMLList(conn,campus,courseAlpha,courseNum,thisType,kix,false,false);
					extraButton = "Content";
					extraForm = "crscntnt";
					extraArg = "";
					extraTitle = "Content";
					extraCmdTitle = "enter additional Content";
				}
				else if (question_friendly.equals(Constant.COURSE_COREQ)){
					extraData = RequisiteDB.getRequisites(conn,campus,courseAlpha,courseNum,thisType,Constant.REQUISITES_COREQ,"");
					extraButton = "Co-Requisite";
					extraForm = "crsreq";
					extraArg = "";
					session.setAttribute("aseRequisite", "2");
					extraTitle = "Co-Requisite";
					extraCmdTitle = "enter additional Co-Requisites";
				}
				else if (question_friendly.equals(Constant.COURSE_GESLO)){
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
				else if (question_friendly.equals(Constant.COURSE_INSTITUTION_LO)){
					extraData = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_INSTITUTION_LO);
					extraButton = "ILO";
					extraForm = "crsgen";
					extraArg = "src="+Constant.COURSE_INSTITUTION_LO+"&dst="+Constant.COURSE_INSTITUTION_LO;
					extraTitle = "ILO";
					extraCmdTitle = "enter ILO";
				}
				else if (question_friendly.equals(Constant.COURSE_OTHER_DEPARTMENTS)){
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
				else if (question_friendly.equals(Constant.COURSE_OBJECTIVES)){
					extraData = CompDB.getCompsAsHTMLList(conn,courseAlpha,courseNum,campus,thisType,kix,false,question_friendly);
					extraButton = "Course SLO";
					extraForm = "crscmp";
					extraArg = "s=c";
					extraTitle = "SLO";
					extraCmdTitle = "enter SLO";
				}
				else if (question_friendly.equals(Constant.COURSE_PREREQ)){
					extraData = RequisiteDB.getRequisites(conn,campus,courseAlpha,courseNum,thisType,Constant.REQUISITES_PREREQ,"");
					extraButton = "Pre-Requisite";
					extraForm = "crsreq";
					extraArg = "";
					session.setAttribute("aseRequisite", "1");
					extraTitle = "Pre-Requisite";
					extraCmdTitle = "enter additional Pre-Requisites";
				}
				else if (question_friendly.equals(Constant.COURSE_PROGRAM)){
					extraData = ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,true);
					extraButton = "Program";
					extraForm = "crsprg";
					extraArg = "src="+Constant.COURSE_PROGRAM;
					extraTitle = "Program";
					extraCmdTitle = "For what program was the course designed?";
				}
				else if (question_friendly.equals(Constant.COURSE_PROGRAM_SLO)){
					extraData = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_PROGRAM_SLO);
					extraButton = "Program SLO";
					extraForm = "crsgen";
					extraArg = "src="+Constant.COURSE_PROGRAM_SLO+"&dst="+Constant.COURSE_PROGRAM_SLO;
					extraTitle = "Program SLO";
					extraCmdTitle = "enter Program SLO";
				}
				else if (question_friendly.equals(Constant.COURSE_RECPREP)){
					extraData = ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
					extraButton = "Rec Prep";
					extraForm = "crsxtr";
					extraArg = "src="+Constant.COURSE_RECPREP+"&dst="+Constant.COURSE_RECPREP;
					extraTitle = "Recommended Preparation";
					extraCmdTitle = "enter recommended preparation";
				}
				else if (question_friendly.equals(Constant.COURSE_TEXTMATERIAL)){
					extraData = TextDB.getTextAsHTMLList(conn,kix);
					extraButton = "Text";
					extraForm = "crsbk";
					extraTitle = "Text and Materials";
					extraCmdTitle = "enter text and materials";
				}
				else if (question_friendly.indexOf(Constant.MESSAGE_PAGE) > -1){
					messagePage = true;
				}

%>