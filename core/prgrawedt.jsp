<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgrawedt.jsp - raw edit
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String caller = "prgrawedt";
	String chromeWidth = "80%";
	fieldsetTitle = "Edit Program Data";
	String pageTitle = fieldsetTitle;

	String kix = website.getRequestParameter(request,"kix", "");
	String type = website.getRequestParameter(request,"type", "");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String ckEditors = "";

	String auditby = "";
	String auditdate = "";
	String title = "";
	String effectiveDate = "";
	String year = "";
	String description = "";
	int degree = 0;
	int division = 0;
	int items = 0;
	String sql = "";
	String raw = "0";

	if (processPage){

		raw = "1";

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
			Programs program = new Programs();
			if (!(Constant.BLANK).equals(kix)){
				program = ProgramsDB.getProgramToModify(conn,campus,kix);
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
				}
			}
			else{
				kix = "";
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}
		}
		catch( Exception e ){
			System.out.println(e.toString());
		}

		session.setAttribute("aseCallingPage",caller);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/prgrawedt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" name="aseForm" action="/central/servlet/amidala?ack=updt">

<%
	if (processPage){
		try{
			String edit1 = "";

			out.println("			<table  width=\'100%\' cellspacing='1' cellpadding='2' border=\'0\'>" );

			sql = aseUtil.getPropertySQL(session,"prgdegrees");
			sql = aseUtil.replace(sql, "_campus_", campus);
			out.println("<tr><td class=\"textblackth\" width=\"15%\">Degree:&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
							+ "</td></tr>");

			sql = aseUtil.getPropertySQL(session,"prgdivision");
			sql = aseUtil.replace(sql, "_campus_", campus);
			out.println("<tr><td class=\"textblackth\">Division:&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"division",""+division,false)
							+ "</td></tr>");

			// title
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' width=\"15%\">Title:&nbsp;</td>" );
			out.println("					 <td><input size=\'70\' class=\'input\' name=\'title\' id=\'title\' type=\'text\' value=\'" + title +"\'></td>" );
			out.println("				</tr>" );

			// description
			out.println("<tr><td class=\"textblackth\">Description:&nbsp;&nbsp;</td><td>"
							+ "<textarea name=\'description\' cols=\'80\' rows=\'6\' class=\'input\'>"+description+"</textarea>"
							+ "</td></tr>");

			// effective date
			out.println("<tr><td class=\"textblackth\">Effective Date:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createStaticSelectionBox("Fall,Spring,Summer,Winter","Fall,Spring,Summer,Winter","effectiveDate",effectiveDate,"input","","BLANK","")
							+ "&nbsp;<input type=\"text\" class=\"input\" name=\"year\" size=\"10\" value=\""+year+"\">"
							+ "</td></tr>");

			ArrayList questions = ProgramsDB.getProgramQuestions(conn,campus);

			if (questions != null){

				// TO DO
				boolean debug = false;

				StringBuffer buf = new StringBuffer();

				ArrayList columns = ProgramsDB.getColumnNames(conn,campus);
				ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,type);

				if (answers != null && columns != null){
					FCKeditor fckEditor = null;

					String question = null;
					String answer = null;
					String column = null;
					int i = 0;

					items = questions.size();

					for (i=0; i<items; i++){
						question = (String)questions.get(i);
						answer = (String)answers.get(i);
						column = (String)columns.get(i);
						buf.append("<tr>" );
						buf.append("<td class=\'textblackTH\' colspan=\"2\"><br/>" + question + "<br/>" );
						buf.append("<textarea cols=\"80\" id=\"aseEditor"+i+"\" name=\"aseEditor"+i+"\" rows=\"10\">"+answer+"</textarea>");

						// array of editors created
						if(i==0){
							ckEditors = "0";
						}
						else{
							ckEditors += "," + i;
						}

						buf.append("</td>" );
						buf.append("</tr>" );
					}

					answers = null;
					columns = null;

					out.println(buf.toString());

				} // answers != null
			} // questions != null

			questions = null;

			out.println("				<tr>" );
			out.println("					 <td class=\'datacolumn\' colspan=\"2\"><fieldset class=\"FIELDSET90\">"
				+ "<legend>Attachments</legend>"
				+ Html.BR()
				+ ProgramsDB.listProgramAttachments(conn,campus,kix)
				+ "</fieldset><br/><br/></td>" );
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
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input name=\'raw\' type=\'hidden\' value=\'" + raw + "\'>" );
			out.println("							<input name=\'items\' type=\'hidden\' value=\'" + items + "\'>" );

			out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\'  title=\"save screen data\" class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input title=\"upload documents\" type=\'submit\' name=\'aseUpload\' value=\'Attachment\'  title=\"attach supporting documents\" class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'prgrawedt\');\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // if processPage

	asePool.freeConnection(conn,"prgrawedt",user);
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
