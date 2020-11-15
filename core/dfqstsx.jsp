<%
	/**
	*	ASE
	*	dfqstsx.jsp
	*	2007.09.01	define course questions
	*	TODO: crsquestx.js ?
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String chromeWidth = "70%";
	String pageTitle = "Outline Item Maintenance";
	fieldsetTitle = pageTitle;
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
			if ( formName != null && formName.equals("aseForm") && formSeq.equals("sc2") ){
				showForm_2(request, response, session, out, conn, website, code);
			}
		}
	}

	asePool.freeConnection(conn);

	// flows this way so that the connection is closed first
	if ( formAction.equals("c" ) ) {
		response.sendRedirect( "dfqsts.jsp?code=" + code );
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

		int numberOfColumns = 6;
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

			sFieldLabel = "ID,Field Name,Question Type,Length,Maximum,Reference".split(",");
			sFieldName = "id,question_friendly,question_type,question_len,question_max,question_ini".split(",");
			sEdit = "0,0,1,1,1,1".split(",");
			sType = "0,t,l,t,t,l2".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			lid = website.getRequestParameter(request,"lid", 0);
			if ( lid > 0 ){
				CCCM6100 cccm = CCCM6100DB.getCCCM6100ByID(conn,lid);
				sColumnValue[0] = String.valueOf(cccm.getId());
				sColumnValue[1] = cccm.getQuestion_Friendly();
				sColumnValue[2] = cccm.getQuestion_Type();
				sColumnValue[3] = String.valueOf(cccm.getQuestion_Len());
				sColumnValue[4] = String.valueOf(cccm.getQuestion_Max());
				sColumnValue[5] = cccm.getQuestion_Ini();
			}
			else{
				lid = 0;
				sql = "0,,,,," + user + "," + aseUtil.getCurrentDateTimeString();
				sColumnValue = sql.split(",");
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'dfqstsx.jsp\'>" );
			out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			for ( j = 0; j < numberOfColumns; j++){
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );

				if ( sEdit[j].equals("1") ){
					if ( sType[j].equals("a") )
						out.println("					 <td><textarea cols=\'50\' rows=\'6\' class=\'input\'  name=\'" + sFieldName[j] + "\'>"  + sColumnValue[j] + "</textarea></td>" );
					else if ( sType[j].equals("d") )
						out.println("					 <td><input size=\'10\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
					else if ( sType[j].equals("l") ){
						sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = 'QuestionType'" );
						out.println( "<td>" + aseUtil.createStaticSelectionBox( sql, sql, sFieldName[j], sColumnValue[j], null, null, "BLANK", null ) + "</td>" );
					}
					else if ( sType[j].equals("l2") ){
						sql = "SELECT kid, kid FROM tblINI WHERE campus = 'SYS' ORDER BY kid";
						out.println( "<td>" + aseUtil.createSelectionBox( conn, sql, sFieldName[j], sColumnValue[j],false ) + "</td>" );
					}
					else if ( sType[j].equals("t") )
						out.println("					 <td><input size=\'40\' class=\'input\'  name=\'" + sFieldName[j] + "\' type=\'text\' value=\'" + sColumnValue[j] +"\'></td>" );
				}
				else{
					out.println("					 <td>" + sColumnValue[j] );
					out.println("					 <input name=\'" + sFieldName[j] + "\' type=\'hidden\' value=\'" + sColumnValue[j] +"\'>" );
					out.println("					 </td>" );
				}

				out.println("				</tr>" );
			}

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
			int numberOfColumns = 6;
			String[] sFieldLabel = new String[numberOfColumns];
			String[] sColumnValue = new String[numberOfColumns];
			String[] sFieldName = new String[numberOfColumns];
			int questionnumber = 0;
			int questionseq = 0;
			String question_friendly = null;
			String question_type = null;
			int question_len = 0;
			int question_max = 0;
			String question_ini = null;
			String message = null;

			sFieldLabel = "ID,Field Name,Question Type,Length,Maximum,Reference".split(",");
			sFieldName = "id,question_friendly,question_type,question_len,question_max,question_ini".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			lid = website.getRequestParameter(request,"lid", 0);
			if ( lid > 0 ){
				i = -1;
				sColumnValue[++i] = website.getRequestParameter(request,"lid");
				sColumnValue[++i] = website.getRequestParameter(request,"question_friendly");
				sColumnValue[++i] = website.getRequestParameter(request,"question_type");
				sColumnValue[++i] = website.getRequestParameter(request,"question_len");
				sColumnValue[++i] = website.getRequestParameter(request,"question_max");
				sColumnValue[++i] = website.getRequestParameter(request,"question_ini");

				question_type = website.getRequestParameter(request,"question_type");
				question_len = Integer.parseInt(website.getRequestParameter(request,"question_len"));
				question_max = Integer.parseInt(website.getRequestParameter(request,"question_max"));
				question_ini = website.getRequestParameter(request,"question_ini");
				com.ase.aseutil.QuestionDB questionDB = new com.ase.aseutil.QuestionDB();
				int rowsAffected = questionDB.cccm6100Question(conn,lid,question_type,question_len,question_max,question_ini);
				questionDB = null;
				aseUtil = null;

				if ( rowsAffected == 1 ){
					message = "Item was updated successfully.";
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
				out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'>" );
				out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
				out.println("							<input name=\'formSeq\' type=\'hidden\' value=\'sc4\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'code\' value=\'" + code + "\'>" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td colspan=\'2\' align=\'center\'><br><p align=\'center\'>" + message + "</p><p align=\'center\'><a href=\'dfqsts.jsp\'>return to question listing</a></p></td>" );
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
