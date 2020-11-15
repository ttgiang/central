<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rvwrcmnts.jsp	reviewer comments
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Display Comments";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String type = website.getRequestParameter(request,"type");
	int commentType = website.getRequestParameter(request,"commentType",0);

	String kix = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/dspcmnts.js"></script>
	<%@ include file="../inc/expand.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			out.println("<form name=\"aseForm\" method=\"post\" action=\"dspcmnts.jsp\">");
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" nowrap>Select" );
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;Outline Type:&nbsp;" );
			out.println(aseUtil.createStaticSelectionBox("Archived,Current,Proposed","ARC,CUR,PRE","type",type,"","","BLANK","1"));
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;Alpha:&nbsp;" );
			String sql = aseUtil.getPropertySQL(session,"alphas2");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;Number:&nbsp;" );
			out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\" onClick=\"return checkForm(this.form)\">");
			out.println("				</td>" );
			out.println("			</tr>" );
			if (type.length() > 0 && alpha.length() > 0 && num.length() > 0){
				kix = helper.getKix(conn,campus,alpha,num,type);
				if (kix != null && kix.length() > 0){
					out.println("			<tr>" );
					out.println("				 <td class=\"textblackTHCenter\" align=\"center\">" );
					out.println("<br/>" + courseDB.setPageTitle(conn,"",alpha,num,campus));
					out.println("				</td>" );
					out.println("			</tr>" );

					String temp = "<br/><fieldset class=\"FIELDSET700\">"
							+ "<legend>Outline comments</legend>"
							+ courseDB.getCourseItem(conn,kix,Constant.COURSE_REASON)
							+ "</fieldset>";

					out.println("			<tr>" );
					out.println("				 <td>" );
					out.println(temp);
					out.println("				</td>" );
					out.println("			</tr>" );
					out.println("			<tr>" );
					out.println("				 <td>" );
					out.println(ReviewerDB.getReviewHistory(conn,kix,0,campus,0,Constant.REVIEW));
					out.println("				</td>" );
					out.println("			</tr>" );
					out.println("			<tr>" );
					out.println("				 <td>" );
					out.println(ApproverDB.getApproverHistory(conn,kix,campus));
					out.println("				</td>" );
					out.println("			</tr>" );
				}
			}
			out.println("	</table>" );
			out.println("</form>");
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"dspcmnts",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
