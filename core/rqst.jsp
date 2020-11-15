<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rqst.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String chromeWidth = "68%";
	String pageTitle = "User Request";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/rqst.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			int lid = website.getRequestParameter(request,"lid",0);

			String descr = "";
			String auditDate = "";
			String userid = "";
			String status = "";
			String userRequest = "";
			String submitted = "";

			Request rqst = new Request();
			if (lid>0){
				rqst = RequestDB.getRequest(conn, lid);
				if ( rqst != null ){
					descr = rqst.getDescr();
					userRequest = rqst.getRequest();
					status = rqst.getStatus();
					userid = rqst.getUserid();
					auditDate = rqst.getAuditDate();
					submitted = rqst.getSubmittedDate();
				}
			}
			else{
				lid = 0;
				status = "Open";
				auditDate = aseUtil.getCurrentDateTimeString();
				userid = user;
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/duku\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Campus:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + campus + "<input name=\'campus\' type=\'hidden\' value=\'" + campus +"\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">User ID:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + user + "<input name=\'userid\' type=\'hidden\' value=\'" + user +"\'></td>" );
			out.println("				</tr>" );

			if (lid==0)
				status = "NEW";

			String statusList = aseUtil.createStaticSelectionBox("CLOSE,INPROGRESS,NEW,RESEARCH","CLOSE,INPROGRESS,NEW,RESEARCH","status",status,null,null,"BLANK",null);

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Status:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + statusList + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Short Description:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\"><input name=\'descr\' type=\'text\' class=\'input\' size=\"80\" maxlength=\"100\" value=\'" + descr +"\'></td>" );
			out.println("				</tr>" );

			String ckName = "userRequest";
			String ckData = userRequest;

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Request:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">");

%>
<%@ include file="ckeditor02.jsp" %>
<%

			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Submitted Date:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + submitted + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Update By:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + user + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Updated Date:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\' valign=\"top\">" + auditDate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );

			if (lid>0){
				out.println("							<input title=\"save user data\" type=\'submit\' name=\'aseSave\' value=\'Save\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input title=\"save user data\" type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"rqst",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
