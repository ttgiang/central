<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwoutline.jsp	view outline raw data
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","vwoutline");

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "View Outline";
	fieldsetTitle = "View Outline";

	String type = website.getRequestParameter(request,"type");
	String alpha = website.getRequestParameter(request,"alpha","");
	String searchTitle = website.getRequestParameter(request,"title","");
	String num = website.getRequestParameter(request,"num","");
	String st = website.getRequestParameter(request,"st","0");

	boolean showTitle = false;

	if (st.equals(Constant.ON)){
		showTitle = true;
	}

	boolean target = true;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="tooltip/tooltip.jsp" %>
	<script type="text/javascript" src="js/vwoutline.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Outline Type:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>");

			int thisCounter = 0;
			int thisTotal = 3;

			String[] thisType = new String[thisTotal];
			String[] thisTitle = new String[thisTotal];

			thisType[0] = "ARC"; thisTitle[0] = "Archived";
			thisType[1] = "CUR"; thisTitle[1] = "Approved";
			thisType[2] = "PRE"; thisTitle[2] = "Proposed";

			for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
				if (type.equals(thisType[thisCounter]))
					out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
				else
					out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
			}

			out.println("&nbsp;<a href=\"crsdocs.jsp?t=c\" class=\"linkcolumn\">Course Docs</a>&nbsp;&nbsp;");
			out.println("&nbsp;<a href=\"crsdocs.jsp?t=p\" class=\"linkcolumn\">Program Docs</a>&nbsp;&nbsp;");

			out.println("			</td></tr>" );

			if (!type.equals(Constant.BLANK)){
				String sql = aseUtil.getPropertySQL(session,"alphas3");
				out.println("<form name=\"aseForm\" method=\"post\" action=\"vwoutline.jsp\">");
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Outline:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
				out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
				out.println("<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
				out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
				out.println("			</td></tr>" );
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>OR Course Title:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
				out.println("<input name=\"title\" class=\"input\" type=\"text\" size=\"30\" maxlength=\"30\" value=\""+searchTitle+"\">");
				out.println("			</td></tr>" );
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
				out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\" onclick=\"return aseSubmitClick();\">");
				out.println("			</td></tr>" );
				out.println("</form>");
			}

			if (!type.equals(Constant.BLANK) && (!alpha.equals(Constant.BLANK) || !searchTitle.equals(Constant.BLANK))){
				out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");

				if (showTitle){
					out.println("show course title"
									+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
									+ "<a href=\"?st=0&type="+type+"&alpha="+alpha+"&title="+searchTitle+"\" class=\"linkcolumn\">hide course title</a>");
				}
				else{
					out.println("<a href=\"?st=1&type="+type+"&alpha="+alpha+"&num="+num+"&title="+searchTitle+"\" class=\"linkcolumn\">show course title</a>"
									+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
									+ "hide course title");
				}

				out.println("			</td></tr>" );
			}

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

			if (type.equals(Constant.BLANK)){
				out.println("<p align=\"center\"><br/>Select outline type (Archived,Approved or Proposed) to display<br/><br/></p>" );
			}
			else{
				if (alpha.equals(Constant.BLANK) && searchTitle.equals(Constant.BLANK))
					out.println("				<p align=\"center\"><br/>Select outline OR enter Course Title to display</p>"
						+ "<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
						+ "<p align=\"center\"><img src=\"../images/spinner.gif\" alt=\"loading...\" border=\"0\"></p>"
						+ "</div>");
				else{
					out.println(helper.listOutlinesToDisplayX(conn,type,0,alpha,num,"vwcrsx",target,showTitle,searchTitle,campus));
				}
			}

			out.println("				</div>" );
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("<div class=\"hr\"></div><ul>");
			out.println("<li>Archived - cancelled or deleted outlines are placed in ARCHIVED status</li>");
			out.println("<li>Approved - active outlines</li>");
			out.println("<li>Proposed - outlines being modified (proposed)</li>");
			out.println("</ul>");
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"vwoutline",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

