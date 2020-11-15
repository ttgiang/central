<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfrms.jsp		additional forms
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	fieldsetTitle = "Additional Forms";
	String pageTitle = "";

	int lid = website.getRequestParameter(request,"lid",0);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script type="text/javascript" src="js/crsfrms.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String link = "";
	String descr = "";
	String title = "";

	if (processPage){
		Form form;

		if (lid > 0){
			form = FormDB.getForm(conn,lid);
			if (form!=null){
				link = form.getLink();
				descr = form.getDescr();
				title = form.getTitle();
			}
		}

		out.println("	<table width=\'50%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/frms\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Title:&nbsp;</td>" );
		out.println("				 <td><input type=\"text\" class=\'input\' id=\"title\" name=\"title\" size=85 maxlength=50 value=\""+title+"\">");
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Description:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'><textarea name=\'descr\' cols=\'80\' rows=\'10\' class=\'input\'>" + descr + "</textarea>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Web URL:&nbsp;</td>" );
		out.println("				 <td><input type=\"text\" class=\'input\' id=\"link\" name=\"link\" size=85 maxlength=250 value=\""+link+"\">");
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
		out.println("				 <td><br/><font class=\"textblackTH\">Enter a URL where additional forms may be found and downloaded for use.</font>");
		out.println("			</td></tr>" );

		out.println("			<tr align=\"right\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td><td>" );
		out.println("					<input type=\'hidden\' name=\'lid\' value=\'" + lid + "\'>" );
		out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
		out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					<input title=\"save content\" type=\'submit\' name=\'aseSave\' value=\'Save\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );

		if (lid>0){
			out.println("					<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\'>" );
		}

		out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseClose\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );

		out.println("			&nbsp;</td></tr>" );

		out.println("		</form>" );

		out.println("	</table>" );
	}

	asePool.freeConnection(conn,"crsfrms",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
