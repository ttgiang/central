<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	edtcmmnt.jsp
	*	2007.09.01	edit comments
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "70%";
	String pageTitle = "Edit Comments";
	fieldsetTitle = "Edit Comments";
	session.setAttribute("aseApplicationMessage","");

	String alpha = "";
	String num = "";
	String type = "";
	String proposer = "";

	String kix = website.getRequestParameter(request,"kix","");

	boolean isProgram = ProgramsDB.isAProgram(conn,kix);

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		if (isProgram){
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];
		}
		else{
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
		}

		type = info[Constant.KIX_TYPE];
		proposer = info[Constant.KIX_PROPOSER];
	}

	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/edtcmmnt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String comments = "";
			String approver = "";
			String sApproved = "";
			int voteAgainst = 0;
			int voteFor = 0;
			int voteAbstain = 0;

			boolean approved = false;

			int id = website.getRequestParameter(request,"id",0);
			if (id > 0){
				History h = HistoryDB.getHistoryById(conn,kix,id);
				if (h != null){
					approver = h.getApprover();
					approved = h.getApproved();

					if (approved)
						sApproved = "YES";
					else
						sApproved = "NO";

					comments = h.getComments();

					voteAgainst = h.getVoteAgainst();
					voteFor = h.getVoteFor();
					voteAbstain = h.getVoteAbstain();

				} // (h != null){
			}
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'edtcmmntx.jsp\'>" );
			out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' width=\"16%\">Approver:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + approver + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' width=\"16%\">Approved:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + sApproved + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Comment:&nbsp;</td>" );
			out.println("					 <td>" );

			FCKeditor fckEditor = new FCKeditor(request,"comments","650","300","ASE","","");
			fckEditor.setValue(comments);
			out.println(fckEditor);

			out.println("					</td>" );
			out.println("				</tr>" );

			String enableVotingButtons = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableVotingButtons");
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Voting:&nbsp;</td>" );
			out.println("					 <td>" );
%>
				For:&nbsp;&nbsp;<input type="input" value="<%=voteFor%>" class="input" maxlength="3" size="3" name="voteFor">
				&nbsp;&nbsp;Against:&nbsp;&nbsp;<input type="input" value="<%=voteAgainst%>" class="input" maxlength="3" size="3" name="voteAgainst">
				&nbsp;&nbsp;Abstain:&nbsp;&nbsp;<input type="input" value="<%=voteAbstain%>" class="input" maxlength="3" size="3" name="voteAbstain">

<%
			out.println("					</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'id\' type=\'hidden\' value=\'" + id + "\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"edtcmmnt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
