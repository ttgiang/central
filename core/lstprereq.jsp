<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstprereq.jsp - outline pre reqs
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Outline Pre-Requisites";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/lstprereq.js"></script>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			int idx = website.getRequestParameter(request,"idx",0);

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"") );
			out.println("			</td></tr>" );

			String sql = aseUtil.getPropertySQL(session,"alphas2");
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>OR<br/><br/>Select Outline:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println("<form name=\"aseForm\" method=\"post\" action=\"lstprereq.jsp\">");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
			out.println("</form>");
			out.println("			</td></tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left><br/>" );

			if (idx > 0 || !alpha.equals(Constant.BLANK)){
				out.println(helper.listOutlinePrereqs(conn,"CUR","lstprereqx",idx,alpha,num));
			}
			else
				out.println("<p align=\"center\">Select alpha index to list available outlines</p>");

			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"lstprereq",user);

%>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>
