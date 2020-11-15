<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsbk.jsp	course content
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
	}

	if ((alpha == null || alpha.length() == 0) && (num == null || num.length() == 0)){
		response.sendRedirect("sltcrs.jsp?cp=crsbk&viewOption=PRE");
	}

	// where to return
	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy")){
		validCaller = true;
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Text and Material";

	int seq = website.getRequestParameter(request,"seq",0);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script type="text/javascript" src="js/crsbk.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage && validCaller){
		try{
			String author = "";
			String edition = "";
			String title = "";
			String publisher = "";
			String yeer = "";
			String isbn = "";

			Text text;

			if (seq > 0){
				text = TextDB.getText(conn,kix,seq);
				if (text!=null){
					author = text.getAuthor();
					edition = text.getEdition();
					title = text.getTitle();
					publisher = text.getPublisher();
					yeer = text.getYeer();
					isbn = text.getIsbn();
				}
			}

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/txt\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Outline:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>"
					+  pageTitle
					+ "&nbsp;&nbsp;<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Title:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"title\" name=\"title\" size=100 maxlength=100 value=\""+title+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Edition:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"edition\" name=\"edition\" size=100 maxlength=20 value=\""+edition+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Author:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"author\" name=\"author\" size=100 maxlength=100 value=\""+author+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Publisher:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"publisher\" name=\"publisher\" size=100 maxlength=100 value=\""+publisher+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Year Published:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"yeer\" name=\"yeer\" size=100 maxlength=4 value=\""+yeer+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>ISBN:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' id=\"isbn\" name=\"isbn\" size=100 maxlength=30 value=\""+isbn+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td><td>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'seq\' value=\'" + seq + "\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"save content\" type=\'submit\' name=\'aseSave\' value=\'Save\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseClose\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"','"+campus+"')\">" );
			out.println("			</td></tr>" );

			out.println("		</form>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );
			out.println(TextDB.getContentForEdit(conn,kix));
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"crsbk",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
