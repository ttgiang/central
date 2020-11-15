<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	appr.jsp
	*	2007.09.01	names of approvers listing
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "40%";
	String pageTitle = "Approver Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/appr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String lid = request.getParameter("lid");
	if ( lid == null ) {
		showMessage(request, response, out);
	}
	else{
		showForm(request, response, session, out, conn);
	}

	asePool.freeConnection(conn);
%>

<%!
	//
	// show this form with data
	//
	void showForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn) throws java.io.IOException {

		try{
			int lid = 0;
			int i = 0;
			int numberOfApprovers = 10;
			String[] sFieldLabel = new String[numberOfApprovers];
			String[] sColumnValue = new String[numberOfApprovers];
			String[] sTemp = new String[numberOfApprovers];
			String sql;
			String approver_seq = "";
			String approver = "";
			String addedby = "";
			String addeddate = "";

			sFieldLabel = "Approver 1,Approver 2,Approver 3,Approver 4,Approver 5,Approver 6,Approver 7,Approver 8,Approver 9,Approver 10".split(",");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if ( request.getParameter("lid") != null ){
				lid = Integer.parseInt(request.getParameter("lid"));
				if ( lid > 0 ){
					Approver apprvr = ApproverDB.getApprover(conn,String.valueOf(lid));
					approver_seq = apprvr.getSeq();
					approver = apprvr.getApprover();
					addedby = apprvr.getLanid();
					addeddate = apprvr.getDte();

					sTemp = approver.split(",");

					// because the split method doesn't fill up remaining
					// array elements when there are fewer entries,
					// we have to append junk values to make it the length
					// we want. We put the junk in temp, then finish
					// properly in sColumnValue
					if ( sTemp.length < numberOfApprovers ){
						for ( i = sTemp.length; i <= numberOfApprovers; i++ )
							approver = approver + ",_";
					}

					sColumnValue = approver.split(",");
				}
				else{
					lid = 0;
					int maxId = aseUtil.dbMaxValue(conn,"tblApprover","approver_seq",session.getAttribute("aseCampus").toString() );
					approver_seq = Integer.toString(++maxId);
					addedby = (String)session.getAttribute("aseUserName");
					addeddate = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
				}
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/aps\'>" );
			out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Sequence:&nbsp;</td>" );
			out.println("					 <td><input class=\'input\' size=\'4\' maxlength=\'2\' name=\'seq\' type=\'text\' value=\'" + approver_seq + "\'></td>" );
			out.println("				</tr>" );

			int j;
			for ( j = 0; j < numberOfApprovers; j++){
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );
				sql = "SELECT userid, userid FROM tblUsers WHERE campus = " + aseUtil.toSQL(session.getAttribute("aseCampus").toString(),1);
				out.println("					 <td>" + aseUtil.createSelectionBox( conn, sql, "approver_" + j, sColumnValue[j],false ) + "</td>" );
				out.println("				</tr>" );
			}

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td>" + session.getAttribute("aseCampus").toString() + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Added By:&nbsp;</td>" );
			out.println("					 <td>" + addedby + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Added Date:&nbsp;</td>" );
			out.println("					 <td>" + addeddate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );

			if ( lid > 0 ){
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
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
	// showMessage
	//
	void showMessage(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.jsp.JspWriter out) throws java.io.IOException {

		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );

	}

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
