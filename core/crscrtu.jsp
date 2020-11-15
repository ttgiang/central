<%
	String junk = "";
	boolean dataIncluded = false;
	StringBuffer dataToInclude = new StringBuffer();

	//-----------------------------------------
	// IncludeGESLOOnCreate
	//-----------------------------------------
	if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_GESLO) &&
			Util.getSessionMappedKey(session,"IncludeGESLOOnCreate").equals(Constant.ON) ){

		junk = ValuesDB.getListByCampusSrcSubTopic(conn,campus,Constant.IMPORT_GESLO,alpha);
		if (junk != null && junk.length() > 0){
			dataIncluded = true;
			dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>General Education Learning Outcomes:</TD>");
			dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");

		} // if
	}

	//-----------------------------------------
	// IncludeILOOnCreate
	//-----------------------------------------
	if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_INSTITUTION_LO) &&
			Util.getSessionMappedKey(session,"IncludeILOOnCreate").equals(Constant.ON) ){

		junk = ValuesDB.getListByCampusSrcSubTopic(conn,campus,Constant.IMPORT_ILO,alpha);
		if (junk != null && junk.length() > 0){
			dataIncluded = true;
			dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Institution Learning Outcomes:</TD>");
			dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
		} // if
	}

	//-----------------------------------------
	// IncludePLOOnCreate
	//-----------------------------------------
	if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_PROGRAM_SLO) &&
			Util.getSessionMappedKey(session,"IncludePLOOnCreate").equals(Constant.ON) ){

			// by program
			//junk = ProgramsDB.getProgramsForCourseSelection(conn,campus,"divisionDDL");
			//if (junk != null && junk.length() > 0){
			//	dataIncluded = true;
			//	dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Program Learning Outcomes (by program):</TD>");
			//	dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
			//}

			// by alpha
			junk = ValuesDB.getListByCampusTopicSubTopic(conn,campus,Constant.IMPORT_PLO,alpha);
			if (junk != null && junk.length() > 0){
				dataIncluded = true;
				dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Program Learning Outcomes (by Alpha):</TD>");
				dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
			}

			// by division
			//String div = ChairProgramsDB.getDivisionFromCampusAlpha(conn,campus,alpha);
			//String topicDiv = Constant.GetLinkedDestinationFullName(Constant.COURSE_PROGRAM_SLO) + " - " + div;
			//junk = ValuesDB.getListByCampusTopicSubTopic(conn,campus,topicDiv,div);
			//if (junk != null && junk.length() > 0){
			//	dataIncluded = true;
			//	dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Program Learning Outcomes (by division):</TD>");
			//	dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
			//}
	}

	//-----------------------------------------
	// IncludeSLOOnCreate
	//-----------------------------------------
	if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_OBJECTIVES) &&
			Util.getSessionMappedKey(session,"IncludeSLOOnCreate").equals(Constant.ON)){

		// by alpha
		junk = ValuesDB.getListByCampusTopicSubTopic(conn,campus,Constant.IMPORT_SLO + " - " + alpha,alpha);
		if (junk != null && junk.length() > 0){
			dataIncluded = true;
			dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Student Learning Outcomes (by Alpha):</TD>");
			dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
		}

		//junk = DivisionDB.getDivisionDDL(conn,campus,"","sloDDL");
		//if (junk != null && junk.length() > 0){
		//	dataIncluded = true;
		//	dataToInclude.append("<tr><TD class=\"textblackTH\" nowrap>Student Learning Outcomes:</TD>");
		//	dataToInclude.append("<td class=\"dataColumn\">" + junk + "</td></tr>");
		//}
	}

	if(dataIncluded){

		out.println("<tr><TD class=\"textblackTH\" colspan=\"2\" nowrap>"
			+ "<br>"
			+ "<h3 class=\"subheader\">The following are additional data required for this course outline</h3>"
			+ "<br>"
			+ "</TD></tr>");

		out.println(dataToInclude.toString());

	} // dataIncluded

%>
