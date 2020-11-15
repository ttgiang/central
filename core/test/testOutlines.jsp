<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ICS";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "X20b18k10167";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			//out.println(showOutlineProgress(conn,kix,user));

			out.println(formatOutline(conn,"X41",campus,alpha,num,type,kix,"***",true,user));

		}
		catch(Exception ce){
			//System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp,
													boolean compressed,
													String user) throws Exception {

Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		int j = 0;
		String junk = "";
		String line = "";
		String[] reuse;

		String lookupData[] = new String[2];
		String questionData[] = new String[2];
		String lookUpCampus = "campus='"+campus+"' AND type='Campus' AND question_friendly='__'";
		String lookUpSys = "campus='SYS' AND type='Course' AND question_friendly='__'";
		String explainField = "";
		String explainSQL = "historyid=" + aseUtil.toSQL(kix,1);

		String department = "";

		boolean debug = true;

		try{

			// look up the reference for retrieval of checklist/radio data.
			// if not found as a campus item, then it's likely to be a system item
			junk = lookUpCampus;
			junk = junk.replace("__",column);
			questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
			if ("NODATA".equals(questionData[0])){
				junk = lookUpSys;
				junk = junk.replace("__",column);
				questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
			}

			// for items with an explanation, look up the column holding the explanation
			// and print after the content.
			explainField = CCCM6100DB.getExplainColumnValue(conn,column);

			if (debug) System.out.println("explainField: " + explainField);
			if (debug) System.out.println("questionData[0]: " + questionData[0]);
			if (debug) System.out.println("questionData[1]: " + questionData[1]);
			if (debug) System.out.println("temp: " + temp);

			if (column.indexOf("date") > -1) {
				temp = aseUtil.ASE_FormatDateTime(temp, 6);
			}
			else if ("check".equals(questionData[0])) {
				// take apart semester from CSV format and lookup actual value
				// using campus, category and id

				if ((Constant.COURSE_CCOWIQ).equals(column)) {
					temp = CowiqDB.drawCowiq(conn,campus,kix,true);
				}
				else if ((Constant.COURSE_FUNCTION_DESIGNATION).equals(column)) {
					temp = FunctionDesignation.drawFunctionDesignation(conn,campus,temp,true);
				}
				else{
					if (temp != null && !"".equals(temp)){

						/*
							if we find ~~ in the fieldValue, it's because we are storing
							double values between commas.

							for example, 869~~5,870~~10,871~~15,872~~3 is similar to

							869,5
							870,10
							871,15
							872,3

							four sets of data as CSV

							this section of code breaks CSV into sub CSV and assign
							accordingly.

							for contact hours, we include a drop down list of hours for selection.

							lookupX returns array of 2 values. in this case, the start and ending
							values for the list range
						*/
						String dropDownValues = "";
						String[] aDropDownValues = null;
						boolean includeRange = IniDB.showItemAsDropDownListRange(conn,campus,"NumberOfContactHoursRangeValue");
						if(temp.indexOf(Constant.SEPARATOR)>-1 || includeRange){

							int junkInt = 0;
							int tempInt = 0;
							String[] tempString = null;
							String[] junkString = null;

							/*
								if statement splits when there is data. else statement sets all to zero.
							*/
							if(temp.indexOf(Constant.SEPARATOR)>-1){
								tempString = temp.split(",");
								tempInt = tempString.length;
								temp = "";

								for(junkInt = 0; junkInt<tempInt; junkInt++){
									junkString = tempString[junkInt].split(Constant.SEPARATOR);

									if (junkInt == 0){
										temp = junkString[0];
										dropDownValues = junkString[1];
									}
									else{
										temp = temp + "," + junkString[0];
										dropDownValues = dropDownValues + "," + junkString[1];
									}
								} // for
							}
							else{
								tempString = temp.split(",");
								tempInt = tempString.length;

								for(junkInt = 0; junkInt<tempInt; junkInt++){
									if (junkInt == 0)
										dropDownValues = "0";
									else
										dropDownValues = dropDownValues + ",0";
								} // for
							}

							aDropDownValues = dropDownValues.split(",");

						} // (temp.indexOf(Constant.SEPARATOR)>-1)

						questionData[0] = "";
						reuse = temp.split(",");

						if (NumericUtil.isInteger(reuse[j])){
							for(j=0;j<reuse.length;j++){
								junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
								lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
								junk = lookupData[1];
								if (junk != null && junk.length() > 0){

									if (includeRange && aDropDownValues[j] != null)
										junk = junk + " (" + aDropDownValues[j] + ")";

									if ("".equals(questionData[0]))
										questionData[0] = "<li class=\"dataColumn\">" + junk + "</li>";
									else
										questionData[0] = questionData[0] + "<li class=\"dataColumn\">" + junk + "</li>";
								}
							}
						} // if reuse

						temp = "<ul>" + questionData[0] + "</ul>";

						if ((Constant.COURSE_METHODEVALUATION).equals(column)){
							// TO DO - hard coding
							if ((Constant.CAMPUS_UHMC).equals(campus))
								temp = temp + "<br/>" + Outlines.showMethodEval(conn,campus,kix);

							temp = temp
								+ "<br/>"
								+ LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
						}

					} // temp
				} // ccowiq
			}
			else if ("radio".equals(questionData[0])) {

				if ((Constant.COURSE_REASONSFORMODS).equalsIgnoreCase(column)){
					temp = AseUtil.expandText(temp,"Regular: YES","Other: Other","");
				}
				else if (questionData[1].indexOf("CONSENT") > -1){

					if ("CONSENTPREREQ".equals(questionData[1]))
						temp = Outlines.drawPrereq(temp,"",true);
					else if ("CONSENTCOREQ".equals(questionData[1]))
						temp = AseUtil.expandText(temp,"Consent: YES","Consent: NO","");

					String displayConsentForCourseMods = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayConsentForCourseMods");
					if ((Constant.OFF).equals(displayConsentForCourseMods))
						temp = "";

					if (debug) System.out.println("displayConsentForCourseMods: " + displayConsentForCourseMods);

					if ((Constant.COURSE_PREREQ).equals(column))
						temp = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,kix) + "<br/>" + temp;
					else if ((Constant.COURSE_COREQ).equals(column))
						temp = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,kix) + "<br/>" + temp;

					if (debug) System.out.println("temp: " + temp);
				}
				else if ("status".equalsIgnoreCase(questionData[1])){
					temp = AseUtil.expandText(temp,"Active","Inactive","Inactive");
				}
				else if ("YESNO".equalsIgnoreCase(questionData[1])){

					temp = AseUtil.expandText(temp,"YES","NO","");

					// if cross listed and there is data, just display data without yes/no
					if ("crosslisted".equalsIgnoreCase(column)){
						junk = CourseDB.getCrossListing(conn,kix);

						if (junk != null && junk.length() > 0)
							temp = junk;
						else
							temp = temp + "<br/>" + junk;
					}
				}
			}
			else if ("coursealpha".equals(column)) {
				department = DisciplineDB.getDisciplineFromAlpha(conn,campus,temp);
				line = line.replace("@A@department",department);
			}
			else if ("division".equals(column)) {
				temp = DivisionDB.getDivision(conn,campus,temp);
			}
			else if ("excluefromcatalog".equals(column)) {
				temp = AseUtil.expandText(temp,"YES","NO","NO");
			}
			else if ("effectiveterm".equals(column) && temp != null && temp.length() > 0) {
				temp = TermsDB.getTermDescription(conn, temp);
			}
			else if ((Constant.COURSE_OBJECTIVES).equals(column)) {
				temp = temp + "<br/>" + LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
			}
			else if ((Constant.COURSE_CONTENT).equals(column)) {
				temp = temp + "<br/>" + LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
			}
			else if ((Constant.COURSE_COMPETENCIES).equals(column)) {
				temp = temp + "<br/>" + LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
			}
			else if ((Constant.COURSE_EXPECTATIONS).equals(column)) {
				temp = IniDB.getIniByCategory(conn,campus,"Expectations",temp,true);
			}
			else if ((Constant.COURSE_GESLO).equals(column)) {
				temp = GESLODB.getGESLO(conn,campus,kix,true)
						+ "<br/>"
						+ LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
			}
			else if ((Constant.COURSE_RECPREP).equals(column)) {
				temp = temp + "<br/>" + ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
			}
			else if ((Constant.COURSE_OTHER_DEPARTMENTS).equals(column)) {

				String enableOtherDepartmentLink = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOtherDepartmentLink");
				if ((Constant.ON).equals(enableOtherDepartmentLink)){
					temp = temp + "<br/>" + ExtraDB.getOtherDepartments(conn,
																						Constant.COURSE_OTHER_DEPARTMENTS,
																						campus,
																						kix,
																						false,
																						false);
				}

			}
			else if ((Constant.COURSE_PROGRAM).equals(column)) {
				temp = temp + "<br/>" + ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,false);
			}
			else if ((Constant.COURSE_PROGRAM_SLO).equals(column)) {
				temp = temp + "<br/>" + LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
			}
			else if ((Constant.COURSE_TEXTMATERIAL).equals(column)) {
				temp = temp + "<br/>" + TextDB.getTextAsHTMLList(conn,kix);
			}
			else if ((Constant.COURSE_AAGEAREA_C40).equals(column)) {
				/*
				String competencies = ValuesDB.diversificationMatrix(conn,
																						kix,
																						temp,
																						"",
																						Constant.COURSE_AAGEAREA_C40,
																						Constant.COURSE_COMPETENCIES,
																						true,
																						true);

				String objectives = ValuesDB.diversificationMatrix(conn,
																						kix,
																						temp,
																						"",
																						Constant.COURSE_AAGEAREA_C40,
																						Constant.COURSE_OBJECTIVES,
																						true,
																						true);

				if (competencies != null && objectives != null){
					temp = temp
						+ "<br/><br/><table width=\"94%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr><td class=\"textblackth\">COMPETENCIES</td></tr>"
						+ "<tr><td>"
						+ competencies
						+ "</td></tr>"
						+ "<tr><td class=\"textblackth\">OBJECTIVES</td></tr>"
						+ "<tr><td>"
						+ objectives
						+ "</td></tr>"
						+ "</table>";
				}
				*/
			}

			if(explainField != null && explainField.length() > 0){
				junk = aseUtil.lookUp(conn,"tblCampusData",explainField,explainSQL);
				if (junk == null)
					junk = "";

				temp = temp + "<br/>" + junk;
			}
		}
		catch(SQLException e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}
		catch(Exception e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}

		return temp;
	}

	/*
	 * showOutlineProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 * @return String
	 */
	public static String showOutlineProgress(Connection conn,String kix,String user){

Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String type = "";
		String campus = "";
		String progress = "";
		String proposer = "";
		String dateproposed = "";
		String auditdate = "";
		boolean found = false;
		int i = 0;
		int j = 0;
		int route = 0;
		String rowColor = "";
		String temp = "";
		String status = "";
		String[] outlineApprovers;

		boolean isSysAdmin = false;
		boolean isCampusAdmin = false;

		Msg msg = new Msg();

		try{
			isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			if(isSysAdmin || isCampusAdmin){
				AseUtil aseUtil = new AseUtil();
				String sql = "SELECT id,campus,CourseAlpha,CourseNum,proposer,progress,dateproposed,auditdate,coursetype " +
					"FROM tblCourse " +
					"WHERE historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					proposer = aseUtil.nullToBlank(rs.getString("proposer"));
					campus = aseUtil.nullToBlank(rs.getString("campus"));
					type = aseUtil.nullToBlank(rs.getString("coursetype"));

					dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
					if (!"".equals(dateproposed))
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);

					auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
					if (!"".equals(auditdate))
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

					kix = AseUtil.nullToBlank(rs.getString("id"));
					String[] info = Helper.getKixInfo(conn,kix);
					route = Integer.parseInt(info[6]);

					// outline detail
					listing.append("<tr bgcolor=\"#ffffff\">" +
						"<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">Outline</td>" +
						"<td class=\"textblackTH\">Progress</td>" +
						"<td class=\"textblackTH\">Proposer</td>" +
						"<td class=\"textblackTH\">Date Proposed</td>" +
						"<td class=\"textblackTH\">Last Updated</td></tr>" +
						"<tr bgcolor=\"#ffffff\">" +
						"<td class=\"dataColumn\">" + alpha + " " + num + "</td>" +
						"<td class=\"dataColumn\">" + progress + "</td>" +
						"<td class=\"dataColumn\">" + proposer + "</td>" +
						"<td class=\"dataColumn\">" + dateproposed + "</td>" +
						"<td class=\"dataColumn\">" + auditdate + "</td>" +
						"</tr></table></td></tr>");

					// approvers
					listing.append("<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Approvers (<font class=\"datacolumn\">click faculty ID to add an outline approval task</font>)</td></tr>");

					Approver approver = ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);
					outlineApprovers = approver.getAllApprovers().split(",");
					for(i=0;i<outlineApprovers.length;i++){
						listing.append("<tr bgcolor=\"#ffffff\">" +
							"<td class=\"dataColumn\" ><a href=\"/central/servlet/sa?c=ctsk&kix="+kix+"&usr="+outlineApprovers[i]+"\" class=\"linkcolumn\">" + outlineApprovers[i] + "</a></td>" +
							"</tr>");
					}

					// approval history
					listing.append("<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Approval History (<font class=\"datacolumn\">click the link to recall outline approval up to and including the selected user ID).</font> "
						+ "<br/><br/><font class=\"normaltext\">When an ID is select, CC continues processing with the following steps:"
						+ "<ul><li>remove existing outline approval task (see following section)</li><li>add outline approval task for selected user</li><li>notify completed approvers that the outline has been recalled</li></ul></font></td></tr>");

					if (!"".equals(kix)){
						ArrayList list = HistoryDB.getHistories(conn,kix,type);
						if (list != null){
							History history;
							temp = "";
							for (i=0; i<list.size(); i++){
								history = (History)list.get(i);

								if (history.getApproved())
									status = "Approved";
								else
									if ((Constant.COURSE_RECALLED).equals(history.getProgress()))
										status = "Recalled";
									else
										status = "Revise";

								temp += "<tr>"
									+ "<td valign=top width=\"20%\">"
									+ "<a href=\"edtcmmnt.jsp?kix="+kix+"&id="+history.getID()+"\" class=\"linkcolumn\"><img border=\"0\" src=\"../images/edit.gif\" title=\"edit comment\"></a>&nbsp;&nbsp;"
									+ "<a href=\"/central/servlet/sa?c=rclhst&kix="+kix+"&id="+history.getID()+"\" class=\"linkcolumn\">" + history.getDte() + " - " + history.getApprover() + "</a>"
									+ "</td>"
									+ "<td valign=top width=\"10%\">"
									+ status
									+ "</td>"
									+ "<td valign=top>"
									+ history.getComments()
									+ "</td>"
									+ "</tr>";
							}
						}
					}

					listing.append("<tr height=\"30\" bgcolor=\"#ffffff\">" +
						"<td class=\"dataColumn\" >"
						+ "<table border=\"0\" cellpadding=\"2\" width=\"100%\">"
						+ temp
						+ "</table>"
						+ "</td>" +
						"</tr>");

					// user tasks
					listing.append("<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Tasks (<font class=\"datacolumn\">click faculty ID to delete the outline approval task</font>)</td></tr>");

					listing.append("<tr height=\"30\" bgcolor=\"#ffffff\">" +
						"<td class=\"dataColumn\" >"
						+ TaskDB.showTaskByOutlineSA(conn,campus,alpha,num,kix)
						+ "</td>" +
						"</tr>");

					// approved
					listing.append("<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Approved</td></tr>");

					msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
					listing.append("<tr height=\"30\" bgcolor=\"#ffffff\">" +
						"<td class=\"dataColumn\" >" + msg.getErrorLog() + "</td>" +
						"</tr>");

					// pending approvals
					listing.append("<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Pending</td></tr>");

					listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">" +
						"<td class=\"dataColumn\" >" + ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route) + "</td>" +
						"</tr>");

					found = true;
				}
				rs.close();
				ps.close();
			} // if admin
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showOutlineProgress - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showOutlineProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						listing.toString() +
						"</table>";
		else
			temp = "Outline not found";

		return temp;
	} // showOutlineProgress

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>