<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	appr.jsp
	*	2007.09.01	names of approvers listing
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "50%";
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
	int lid = 0;
	String sid = website.getRequestParameter(request,"lid");

	if (sid != null && sid.length() > 0){
		lid = Integer.parseInt(sid);
		try{
			int i = 0;
			String sql;
			String approver_seq = "";
			String approver = "";
			String delegated = "";
			String addedby = "";
			String addeddate = "";
			String checked = "";

			if ( lid > 0 ){
				Approver apprvr = ApproverDB.getApprover(conn,String.valueOf(lid));
				approver_seq = apprvr.getSeq();
				approver = apprvr.getApprover();
				delegated = apprvr.getDelegated();
				addedby = apprvr.getLanid();
				addeddate = apprvr.getDte();
				if ( apprvr.getMultiLevel() )
					checked = "checked";
			}
			else{
				lid = 0;
				int maxId = aseUtil.dbMaxValue(conn,"tblApprover","approver_seq",session.getAttribute("aseCampus").toString() );
				approver_seq = Integer.toString(++maxId);
				addedby = (String)session.getAttribute("aseUserName");
				addeddate = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/aps\'>" );
			out.println("			<table height=\'180\' width=\'100%\' cellspacing='1' cellpadding='5' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Sequence:&nbsp;</td>" );
			out.println("					 <td><input class=\'input\' size=\'4\' maxlength=\'2\' name=\'seq\' type=\'text\' value=\'" + approver_seq + "\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Approver:&nbsp;</td>" );
			sql = "SELECT userid, userid FROM tblUsers WHERE campus = " + aseUtil.toSQL(session.getAttribute("aseCampus").toString(),1) + " ORDER BY userid";
			out.println("					 <td>" + aseUtil.createSelectionBox( conn, sql, "approver", approver) + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Division Approver:&nbsp;</td>" );
			out.println("					 <td><input type=\'checkbox\' value=\'1\' name=\'multiLevel\' " + checked + "></td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Delegate:&nbsp;</td>" );
			sql = "SELECT userid, userid FROM tblUsers WHERE campus = " + aseUtil.toSQL(session.getAttribute("aseCampus").toString(),1) + " ORDER BY userid";
			out.println("					 <td>" + aseUtil.createSelectionBox( conn, sql, "delegated", delegated) + "</td>" );
			out.println("				</tr>" );

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
				out.println("							<input title=\'save entered data\' type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input title=\'delete selected data\' type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input title=\'insert entered data\' type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input title=\'abort selected operation\' type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
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
	else{
		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
