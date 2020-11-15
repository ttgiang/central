<%
	/**
	*	ASE
	*	dfqstx.jsp
	*	2007.09.01	define course questions
	**/

	String chromeWidth = "70%";
	String pageTitle = "Course Item Maintenance";
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="../inc/crsquestx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%@ include file="ase.jsp" %>

<%
	String formSeq = website.getRequestParameter(request,"formSeq");
	String formName = website.getRequestParameter(request,"formName");
	String formAction = website.getRequestParameter(request,"formAction");
	String code = website.getRequestParameter(request,"code", "");

	if ( ( formSeq == null || formSeq.equals("") ) && ( formName == null || formName.equals("") )){
		showForm_1(request, response, session, out, conn, website, code);
	}
	else {
		if ( !formAction.equals("c" ) ) {
			if ( formName != null && formName.equals("aseForm") ){
				if ( formSeq.equals("sc2") )
					showForm_2(request, response, session, out, conn, website, code);
				else if ( formSeq.equals("sc3") )
					showForm_3(request, response, session, out, conn, website, code);
			}
		}
	}

	asePool.freeConnection(conn);

	// flows this way so that the connection is closed first
	if ( formAction.equals("c" ) ) {
		response.sendRedirect( "dfqst.jsp?code=" + code );
	}
%>

<%!
	//
	// show this form with data
	//
	void showForm_1(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						WebSite website,
						String code) throws java.io.IOException {

		int numberOfColumns = 9;
		String[] sFieldLabel = new String[numberOfColumns];
		String[] sColumnValue = new String[numberOfColumns];
		String[] sFieldName = new String[numberOfColumns];
		String[] sEdit = new String[numberOfColumns];
		String[] sType = new String[numberOfColumns];
		String sql;

		try{
			int lid = 0;
			int i = 0;
			int j;

			sFieldLabel = "ID,Question Number,Question,Question Friendly Name,Question Type,Length,Maximum,Updated By,Updated Date".split(",");
			sFieldName = "id,questionnumber,question,question_friendly,question_type,question_len,question_max,auditby,auditdate".split(",");
			sEdit = "0,1,1,1,1,1,1,0,0".split(",");
			sType = "0,t,a,t,l,t,t,t,t".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			lid = website.getRequestParameter(request,"lid", 0);
			if ( lid > 0 ){
				PreparedStatement stmt = conn.prepareStatement("SELECT id,questionnumber,question,question_friendly,question_type,question_len,question_max,auditby,auditdate FROM tblCourseQuestions WHERE id=?");
				stmt.setInt(1,lid);
				ResultSet rs = stmt.executeQuery();
				rs.next();

				for ( j = 0; j < numberOfColumns; j++){
					sColumnValue[j] = aseUtil.getValue( rs, sFieldName[j] );
				}

				rs.close();
				rs = null;
				stmt.close();
				stmt = null;
			}
			else{
				lid = 0;
				sql = "0,,,," + (String)session.getAttribute("aseUserName") + "," +
					(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
				sColumnValue = sql.split(",");
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'dfqstx.jsp\'>" );
			out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			for ( j = 0; j < numberOfColumns; j++){
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );

				if ( sEdit[j].equals("1") ){
					if ( sType[j].equals("a") )
						out.println("					 <td><textarea cols=\'60\' rows=\'6\' class=\'input\'  name=\'" + sFieldName[j] + "\'>"  + sColumnValue[j] + "</textarea></td>" );
					else if ( sType[j].equals("d") )
						out.println("					 <td><input size=\'10\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
					else if ( sType[j].equals("l") ){
						sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = 'QuestionType'" );
						out.println( "<td>" + aseUtil.createStaticSelectionBox( sql, sql, sFieldName[j], sColumnValue[j], null, null, "BLANK", null ) + "</td>" );
					}
					else if ( sType[j].equals("t") )
						out.println("					 <td><input size=\'40\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
				}
				else{
					out.println("					 <td>" + sColumnValue[j] + "</td>" );
				}

				out.println("				</tr>" );
			}

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td>" + (String)session.getAttribute("aseCampus") + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
			out.println("							<input name=\'formSeq\' type=\'hidden\' value=\'sc2\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'code\' value=\'" + code + "\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );

			aseUtil = null;
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	//
	// show this form with data
	//
	void showForm_2(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						WebSite website,
						String code) throws java.io.IOException {

		try{
			int lid = 0;
			int i = 0;
			int j;
			int numberOfColumns = 10;
			String[] sFieldLabel = new String[numberOfColumns];
			String[] sColumnValue = new String[numberOfColumns];
			String[] sFieldName = new String[numberOfColumns];
			String[] sEdit = new String[numberOfColumns];
			String[] sType = new String[numberOfColumns];
			String sql;

			sFieldLabel = "ID,Question Number,Question,Question Friendly Name,Question Type,Length,Maximum,Question Ref,Updated By,Updated Date".split(",");
			sFieldName = "id,questionnumber,question,question_friendly,question_type,question_len,question_max,question_ini,auditby,auditdate".split(",");
			sEdit = "0,0,0,0,0,0,0,1,0,0".split(",");
			sType = "0,t,t,t,l,t,t,l,t,t".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			lid = website.getRequestParameter(request,"lid", 0);
			if ( lid > 0 ){

				i = -1;
				sColumnValue[++i] = request.getParameter("lid");
				sColumnValue[++i] = request.getParameter("questionnumber");
				sColumnValue[++i] = request.getParameter("question");
				sColumnValue[++i] = request.getParameter("question_friendly");
				sColumnValue[++i] = request.getParameter("question_type");
				sColumnValue[++i] = request.getParameter("question_len");
				sColumnValue[++i] = request.getParameter("question_max");
				sColumnValue[++i] = "";
				sColumnValue[++i] = (String)session.getAttribute("aseUserName");
				sColumnValue[++i] = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
			}
			else{
				lid = 0;
				sql = "0,,,," + (String)session.getAttribute("aseUserName") + "," +
					(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
				sColumnValue = sql.split(",");
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'dfqstx.jsp\'>" );
			out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			for ( j = 0; j < numberOfColumns; j++){
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );

				if ( sEdit[j].equals("1") ){
					if ( sType[j].equals("d") )
						out.println("					 <td><input size=\'10\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
					else if ( sType[j].equals("l") ){
						sql = "SELECT kid, kid FROM tblINI WHERE campus = 'SYS' ORDER BY kid";
						out.println( "<td>" + aseUtil.createSelectionBox( conn, sql, sFieldName[j], sColumnValue[j] ) + "</td>" );
					}
					else if ( sType[j].equals("t") )
						out.println("					 <td><input size=\'40\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
				}
				else{
					out.println("<td><input type=\'hidden\' name=\'" + sFieldName[j] + "\' value=\'" + sColumnValue[j] + "\'>" );
					out.println( sColumnValue[j] + "</td>" );
				}

				out.println("				</tr>" );
			}

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td>" + (String)session.getAttribute("aseCampus") + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
			out.println("							<input name=\'formSeq\' type=\'hidden\' value=\'sc3\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'code\' value=\'" + code + "\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );

			aseUtil = null;
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	//
	// show this form with data
	//
	void showForm_3(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						WebSite website,
						String code) throws java.io.IOException {

		try{
			int lid = 0;
			int i = 0;
			int j;
			int numberOfColumns = 10;
			String[] sFieldLabel = new String[numberOfColumns];
			String[] sColumnValue = new String[numberOfColumns];
			String[] sFieldName = new String[numberOfColumns];
			int questionnumber = 0;
			String question = null;
			String question_friendly = null;
			String question_type = null;
			int question_len = 0;
			int question_max = 0;
			String question_ini = null;
			String auditby = null;
			String auditdate = null;
			String campus = null;
			String message = null;

			sFieldLabel = "ID,Question Number,Question,Question Friendly Name,Question Type,Length,Maximum,Question Ref,Updated By,Updated Date".split(",");
			sFieldName = "id,questionnumber,question,question_friendly,question_type,question_len,question_max,question_ini,auditby,auditdate".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			lid = website.getRequestParameter(request,"lid", 0);
			if ( lid > 0 ){
				i = -1;
				sColumnValue[++i] = request.getParameter("lid");
				sColumnValue[++i] = request.getParameter("questionnumber");
				sColumnValue[++i] = request.getParameter("question");
				sColumnValue[++i] = request.getParameter("question_friendly");
				sColumnValue[++i] = request.getParameter("question_type");
				sColumnValue[++i] = request.getParameter("question_len");
				sColumnValue[++i] = request.getParameter("question_max");
				sColumnValue[++i] = request.getParameter("question_ini");
				sColumnValue[++i] = (String)session.getAttribute("aseUserName");
				sColumnValue[++i] = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());

				questionnumber = Integer.parseInt(request.getParameter("questionnumber"));
				question = request.getParameter("question");
				question_friendly = request.getParameter("question_friendly");
				question_type = request.getParameter("question_type");
				question_len = Integer.parseInt(request.getParameter("question_len"));
				question_max = Integer.parseInt(request.getParameter("question_max"));
				question_ini = request.getParameter("question_ini");
				campus = (String)session.getAttribute("aseCampus");
				auditby = (String)session.getAttribute("aseUserName");
				auditdate = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());

				com.ase.aseutil.QuestionDB questionDB = new com.ase.aseutil.QuestionDB();
				int rowsAffected = questionDB.updateQuestion(conn,
											question,question_friendly,question_type,question_len,question_max,
											question_ini,lid,auditby,auditdate);
				questionDB = null;
				aseUtil = null;

				if ( rowsAffected == 1 ){
					message = "Question was updated successfully.";
				}
				else{
					message = "Update failed!!!";
				}


				out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

				for ( j = 0; j < numberOfColumns; j++){
					out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
					out.println("					 <td class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );
					out.println("<td><input type=\'hidden\' name=\'" + sFieldName[j] + "\' value=\'" + sColumnValue[j] + "\'>" + sColumnValue[j] + "</td>" );
					out.println("				</tr>" );
				}

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
				out.println("					 <td>" + (String)session.getAttribute("aseCampus") + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'>" );
				out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
				out.println("							<input name=\'formSeq\' type=\'hidden\' value=\'sc4\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'code\' value=\'" + code + "\'>" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td colspan=\'2\' align=\'center\'><br><p align=\'center\'>" + message + "</p><p align=\'center\'><a href=\'dfqst.jsp\'>return to question listing</a></p></td>" );
				out.println("				</tr>" );

				out.println("			</table>" );
			}
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
