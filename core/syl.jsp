<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	syl.jsp - syllabus maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "70%";
	String pageTitle = "Syllabus Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/syl.js"></script>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			int lid = 0;
			String auditby = "";
			String auditdate = "";
			String alpha = "";
			String num = "";
			String type = "CUR";
			String semester = "";
			String year = "";
			String textBooks = "";
			String objectives = "";
			String grading = "";
			String comments = "";
			String sql = "";
			String kix = "";
			String prereq = "";
			String coreq = "";
			String recprep = "";
			String attach = "";
			String link = "";

			/*
				make sure we have and id to work with. if one exists,
				it has to be greater than 0
			*/
			lid = website.getRequestParameter(request,"lid", 0);
			kix = website.getRequestParameter(request,"kix");
			alpha = website.getRequestParameter(request,"alpha");
			num = website.getRequestParameter(request,"num");
			type = website.getRequestParameter(request,"t");

			Syllabus syllabus = new Syllabus();
			if (lid > 0 ){
				syllabus = SyllabusDB.getSyllabus(conn,campus,lid);
				if ( syllabus != null ){
					alpha = syllabus.getAlpha();
					num = syllabus.getNum();

					if (kix == null || kix.length() == 0){
						kix = Helper.getKix(conn,campus,alpha,num,"CUR");
					}

					semester = syllabus.getSemester();
					year = syllabus.getYear();
					textBooks = syllabus.getTextBooks();
					objectives = syllabus.getObjectives();
					grading = syllabus.getGrading();
					comments = syllabus.getComments();
					auditby = syllabus.getUserID();
					auditdate = syllabus.getAuditDate();

					if (kix == null || kix.length() == 0)
						kix = helper.getKix(conn,campus,alpha,num,type);

					prereq = syllabus.getPrereq()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,kix);

					coreq = syllabus.getCoreq()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,kix);

					recprep = syllabus.getRecprep();
					attach = syllabus.getAttach();

					link = "/centraldocs/docs/uploads/"+campus+"/"+campus+"-SYL"+"-"+lid+"-"+attach;
				}
			}
			else{
				lid = 0;

				if (kix != null && kix.length() > 0){
					String[] info = helper.getKixInfo(conn,kix);
					alpha = info[0];
					num = info[1];
				}
				else{
					kix = helper.getKix(conn,campus,alpha,num,type);
				}

				syllabus = SyllabusDB.getSyllabusData(conn,kix);
				if (syllabus != null){
					textBooks = syllabus.getTextBooks();
					objectives = syllabus.getObjectives();
					grading = syllabus.getGrading();

					prereq = syllabus.getPrereq()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,kix);

					coreq = syllabus.getCoreq()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,kix);

					recprep = syllabus.getRecprep();
				}

				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}

			if (objectives != null && objectives.length() > 0){
				objectives += Html.BR();
			}

			objectives += CompDB.getCompsAsHTMLList(conn,alpha,num,campus,"CUR",kix,false,"");

			out.println("		<form method=\"post\" name=\"aseForm\" action=\"/central/servlet/at6tj\">" );
			//out.println("		<form method=\'post\' name=\'aseForm\' enctype=\"multipart/form-data\" action=\'/central/servlet/at6tj\'>" );
			out.println("			<table height=\"150\" width=\"100%\" cellspacing=\"1\" cellpadding=\"4\" class=\"tableBorder" + session.getAttribute("aseTheme") + "\" align=\"center\"  border=\"0\">" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\" width=\"20%\">Outline:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("					 <input size=\'6\' class=\'input\'  name=\'alpha\' type=\'text\' value=\'" + alpha +"\'>" );
			out.println("					 <input size=\'6\' class=\'input\'  name=\'num\' type=\'text\' value=\'" + num +"\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Semester:&nbsp;</td>" );
			out.println("					 <td>" );
			sql = IniDB.getIniByCampusCategory(conn,campus,"Semester");
			out.println( aseUtil.createStaticSelectionBox(sql,sql,"semester",semester,null,null,"BLANK", null ));
			out.println("					 <input size=\'4\' class=\'input\'  name=\'year\' type=\'text\' value=\'" + year +"\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			String HTMLFormField = aseUtil.drawHTMLField(conn,"wysiwyg","","textbooks",textBooks,0,0,false,"",false);

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Co-Requisites:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + coreq + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Pre-Requisites:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + prereq + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Recommended Preparations:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + recprep + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Textbooks:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + HTMLFormField + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">SLO:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + objectives + "</td>" );
			out.println("				</tr>" );

			HTMLFormField = aseUtil.drawHTMLField(conn,"wysiwyg","","grading",grading,0,0,false,"",false);

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Grading:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + HTMLFormField + "</td>" );
			out.println("				</tr>" );

			HTMLFormField = aseUtil.drawHTMLField(conn,"wysiwyg","","comments",comments,0,0,false,"",false);

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Comments:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + HTMLFormField + "</td>" );
			out.println("				</tr>" );

			//out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			//out.println("					 <td class=\"textblackTH\">Attachment:&nbsp;</td>" );
			//out.println("					 <td class=\"dataColumn\">"
			//	+ "<input size=\'70\' class=\'upload\' id=\"attach\" name=\'attach\' type=\'file\'>");
	//
			//if (lid>0){
			//	out.println("<img src=\"../images/ext/"+AseUtil2.getFileExtension(attach) + ".gif\" border=\"0\">&nbsp;"
			//	+ "<a href=\""+link+"\" target=\"_blank\" class=\"linkcolumn\">" + attach + "</a>");
			//}

			out.println("				</td></tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\">Updated By:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + auditby + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTH\" nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\"dataColumn\">" + auditdate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
			out.println("					 <td class=\"textblackTHRight\" colspan=\"2\"><div class=\"hr\"></div>" );
			out.println("							<input name=\"lid\" type=\"hidden\" value=\"" + lid + "\">" );

			if ( lid > 0 ){
				//out.println("							<input type=\"submit\" name=\"aseSave\" value=\"Save\" class=\"inputsmallgray\" onClick=\"return checkForm(this.form)\">" );
				//out.println("							<input type=\"submit\" name=\"aseSaveNew\" value=\"Save as New\" class=\"inputsmallgray\" onClick=\"return checkForm(this.form)\">" );
				//out.println("							<input type=\"submit\" name=\"aseDelete\" value=\"Delete\" class=\"inputsmallgray\" onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\"hidden\" name=\"formAction\" value=\"s\">" );
			}
			else{
				//out.println("							<input type=\"submit\" name=\"aseInsert\" value=\"Insert\" class=\"inputsmallgray\" onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\"hidden\" name=\"formAction\" value=\"i\">" );
			}

			out.println("							<input type=\"hidden\" name=\"uploadType\" value=\"SYL\">" );

			out.println("							<input type=\"submit\" name=\"aseCancel\" value=\"Close\" class=\"inputsmallgray\" onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\"hidden\" name=\"formName\" value=\"aseForm\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"syl",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
