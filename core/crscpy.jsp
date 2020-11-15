<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscpy.jsp	copy outline
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","crscpy");

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Copy Outline";
	fieldsetTitle = pageTitle;

	String type = website.getRequestParameter(request,"type");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");

	/*
		target must be false to make copy work properly. a value of true
		is for viewing of outlines only.
	*/
	boolean target = false;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crscpy.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		if (processPage){
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) Outline Type:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' width=\"85%\" >");

			int thisCounter = 0;
			int thisTotal = 2;

			String[] thisType = new String[thisTotal];
			String[] thisTitle = new String[thisTotal];

			thisType[0] = "CUR"; thisTitle[0] = "Approved";
			thisType[1] = "PRE"; thisTitle[1] = "Proposed";

			for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
				if (type.equals(thisType[thisCounter]))
					out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
				else
					out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
			}

			if(!type.equals("")){
				String sql = aseUtil.getPropertySQL(session,"alphas3");
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>2) Select Outline:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
				out.println("<form name=\"aseForm\" method=\"post\" action=\"crscpy.jsp\">");
				out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
				out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
				out.println("<input name=\"type\" type=\"hidden\" value=\""+type+"\">");
				out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
				out.println("</form>");
				out.println("			</td></tr>" );
			} // type

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );

			if (type.equals(Constant.BLANK) && "".equals(alpha))
				out.println("				<p align=\"center\"><br/><br/>Select outline type (Archived,Approved,Proposed) to display (#1)</p>" );
			else
				if (alpha.equals(Constant.BLANK))
					out.println("				<p align=\"center\"><br/>Select outline to display (#2)</p>"
						+ "<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
						+ "<p align=\"center\"><img src=\"../images/spinner.gif\" alt=\"loading...\" border=\"0\"></p>"
						+ "</div>");
				else{
					/*
						target must be false to make copy work properly. a value of true
						is for viewing of outlines only.
					*/
					out.println(helper.listOutlinesToDisplayX(conn,type,0,alpha,num,"crscpyxx",target));
				}

			out.println("				</div>" );
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"crscpy",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
