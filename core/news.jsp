<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	news.jsp
	*	2007.09.01
	**/

	// mnu controls the action on this form. Either add the news or upload document

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String chromeWidth = "70%";

	String pageTitle = "News Maintenance";

	fieldsetTitle = pageTitle;

	int mnu = website.getRequestParameter(request,"mnu", 1);

	session.setAttribute("aseApplicationMessage","");
	session.setAttribute("aseCallingPage","NEWS");
	session.setAttribute("aseMnu",""+mnu);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/CalendarPopup.js"></script>
	<link href="../inc/calendar.css" rel="stylesheet" type="text/css">
	<SCRIPT language="JavaScript" id="dateID">
		var dateCal = new CalendarPopup("dateDiv");
		dateCal.setCssPrefix("CALENDAR");
	</SCRIPT>

	<script language="JavaScript" src="js/news.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	int lid = website.getRequestParameter(request,"lid", 0);

	try{
		String auditby = "";
		String auditdate = "";
		String sql = "";
		String attach = "";
		String link = "";

		// make sure we have and id to work with. if one exists,
		// it has to be greater than 0
		NewsDB newsDB = new NewsDB();
		News news = new News();

		// defafult values
		if (lid>0){
			news = newsDB.getNews(conn, lid);
			if ( news != null ){
				auditby = news.getAuditBy();
				auditdate = news.getAuditDate();
				attach = news.getAttach();
				link = "/centraldocs/docs/uploads/"+news.getCampus()+"/"+attach;
			}
		}
		else{
			lid = 0;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = user;
		}

		// how to process the form
		if (mnu==1){
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/ns\'>" );
		}
		else if (mnu==2){
			out.println("		<form method=\'post\' name=\'aseForm\' enctype=\"multipart/form-data\" action=\'/central/servlet/ns\'>" );
		}

		out.println("			<table width=\'100%\' cellspacing='4' cellpadding='2'  align=\'center\'  border=\'0\' class=asetable>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\' width=\"15%\">ID:&nbsp;</td>" );
		out.println("					 <td>" + lid + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>Title:&nbsp;</td>" );

		if (mnu==1)
			out.println("					 <td><input size=\'70\' class=\'input\' name=\'infotitle\' id=\'infotitle\' type=\'text\' value=\'" + news.getTitle() +"\'></td>" );
		else
			out.println("					 <td class=\"datacolumn\">" + news.getTitle() + "</td>" );

		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>Start Date:&nbsp;</td>" );

		if (mnu==1){
			out.println("					 <td><input onFocus=\"dateCal.select(document.forms[0].startdate,'anchorDate','MM/dd/yyyy'); return false;\" size=\'20\' class=\'input\'  name=\'startdate\' id=\'startdate\' type=\'text\' value=\'" + news.getStartDate() +"\'>&nbsp");
			out.println("					 <A HREF=\"#\" onClick=\"dateCal.select(document.forms[0].startdate,'anchorStartDate','MM/dd/yyyy'); return false;\" NAME=\"anchorStartDate\" ID=\"anchorStartDate\" class=\"linkcolumn\">(MM/DD/YYYY)</A></td>" );
		}
		else if (mnu==2){
			out.println("					 <td class=\"datacolumn\">" + news.getStartDate() + "</td>" );
		}

		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>End Date:&nbsp;</td>" );

		if (mnu==1){
			out.println("					 <td><input onFocus=\"dateCal.select(document.forms[0].enddate,'anchorDate','MM/dd/yyyy'); return false;\" size=\'20\' class=\'input\'  name=\'enddate\' id=\'enddate\' type=\'text\' value=\'" + news.getEndDate() +"\'>&nbsp" );
			out.println("					 <A HREF=\"#\" onClick=\"dateCal.select(document.forms[0].enddate,'anchorEndDate','MM/dd/yyyy'); return false;\" NAME=\"anchorEndDate\" ID=\"anchorEndDate\" class=\"linkcolumn\">(MM/DD/YYYY)</A></td>" );
		}
		else if (mnu==2){
			out.println("					 <td class=\"datacolumn\">" + news.getEndDate() + "</td>" );
		}

		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>Content:&nbsp;</td>" );

		if (mnu==1){
			out.println("					 <td>" );

			/*
			if ( session.getAttribute("aseRichEdit") != null && session.getAttribute("aseRichEdit").equals(Constant.ON) ) {
				out.println("				<textarea class=\"input\" id=\"content\" name=\"infocontent\" style=\"height: 200px; width: 500px;\"> ");
				out.println( news.getContent() );
				out.println("				</textarea>");
				out.println("				<script language=\"javascript1.2\">");
				out.println("					generate_wysiwyg('content');");
				out.println("				</script>");
			}
			else{
				out.println("<textarea cols=\'50\' class=\'input\' name=\'infocontent\' id=\'infocontent\' rows=\'10\'>" + news.getContent() +"</textarea>");
			}
			*/

			String ckName = "infocontent";
			String ckData = news.getContent();
%>
			<%@ include file="ckeditor02.jsp" %>
<%
			out.println("					</td>" );
		}
		else if (mnu==2){
			out.println("					 <td class=\"datacolumn\">" + news.getContent() + "</td>");
		}

		out.println("				</tr>" );

		// attachment available for upload only on second screen
		if (lid > 0 && mnu==2){

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Attachment:&nbsp;</td>" );
			out.println("					 <td class=\"datacolumn\">");

			if (mnu==2){
				out.println("<input size=\'70\' class=\'upload\' id=\"attach\" name=\'attach\' type=\'file\'><br/>");
			}

			if (lid > 0 && attach != null && attach.length() > 0){
				out.println("<img src=\"../images/ext/"+AseUtil2.getFileExtension(attach) + ".gif\" border=\"0\">&nbsp;"
				+ "<a href=\""+link+"\" target=\"_blank\" class=\"linkcolumn\">" + attach + "</a>");
			}

			out.println("				</td></tr>" );
		}

		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + campus + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditby + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
		out.println("					 <td class=\"datacolumn\">" + auditdate + "</td>" );
		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input name=\'lid\' id=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
		out.println("							<input name=\'mnu\' id=\'mnu\' type=\'hidden\' value=\'" + mnu + "\'>" );

		if (mnu==1){
			out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'s\'>" );

			if (lid == 0)
				//out.println("							<input type=\'submit\' name=\'aseInsert\' id=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			else
				//out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
		}
		else if (mnu==2){
			out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'u\'>" );
			//out.println("							<input type=\'submit\' name=\'aseUpload\' id=\'aseUpload\' value=\'Upload\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
		}

		if (lid > 0){
			//out.println("							<input type=\'submit\' name=\'aseDelete\' id=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return deleteNews("+lid+")\">" );
		}

		out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"news",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
