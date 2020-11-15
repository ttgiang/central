<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgcrt.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Create Program";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgcrt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		String sql = "";
		int degree = 0;
		String division = "";
		String formAction = "?";
		String cmdSubmit = "Continue";

		degree = website.getRequestParameter(request,"degree",0);
		division = website.getRequestParameter(request,"division","");

		if (degree > 0 && !division.equals(Constant.BLANK)){
			formAction = "prgcrtx.jsp";
			cmdSubmit = "Submit";
		}

		if (userLevel>=Constant.CAMPADM){
			out.println("<a href=\"dgr.jsp?lid=0&rtn=crtpgr\" class=\"linkcolumn\">add degree</a>"
							+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
							+ "<a href=\"div.jsp?lid=0&rtn=crtpgr\" class=\"linkcolumn\">add division</a>");
		}

		out.println("<form name=\"aseForm\" action=\""+formAction+"\" method=\"post\" >");

		out.println("<p align=\"left\"><table border=\"0\" width=\"100%\" cellpadding=\"4\" cellspacing=\"4\">");

		// step 1 of 3 (degree)
		sql = aseUtil.getPropertySQL(session,"prgdegrees");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);

			out.println("<tr><td class=\"textblackth\" width=\"20%\">Select Degree:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
							+ "</td></tr>");

			// step 2 of 3 (division)
			if (degree > 0){
				sql = aseUtil.getPropertySQL(session,"prgdivision");
				if ( sql != null && sql.length() > 0 ){
					sql = aseUtil.replace(sql, "_campus_", campus);

					out.println("<tr><td class=\"textblackth\">Select Division:&nbsp;&nbsp;</td><td>"
									+ aseUtil.createSelectionBox(conn,sql,"division",division,false)
									+ "</td></tr>");

					// step 3 of 3 (title)
					if (!"".equals(degree) && !"".equals(division)){
						out.println("<tr><td class=\"textblackth\">Title:&nbsp;&nbsp;</td><td>"
										+ "<input type=\"text\" class=\"input\" name=\"title\" size=\"80\" maxlength=\"50\">"
										+ "</td></tr>");

						out.println("<tr><td class=\"textblackth\">Description:&nbsp;&nbsp;</td><td>"
										+ "<textarea name=\'description\' cols=\'80\' rows=\'6\' class=\'input\'></textarea>"
										+ "</td></tr>");

						out.println("<tr><td class=\"textblackth\">Effective Date:&nbsp;&nbsp;</td><td>"
										+ aseUtil.createStaticSelectionBox("Fall,Spring,Summer,Winter","Fall,Spring,Summer,Winter","effectiveDate","","input","","BLANK","")
										+ "&nbsp;<input type=\"text\" class=\"input\" name=\"year\" size=\"10\">"
										+ "</td></tr>");

						out.println("<tr><td class=\"textblackth\">Requires Regent's Approval:&nbsp;&nbsp;</td><td>"
										+ aseUtil.radioYESNO("0","regentApproval",false)
										+ "</td></tr>");

					} // degree and division not empty
				}  // sql for division
			}  // degree not empty
		} // sql for degree

		out.println("<tr><td class=\"textblackth\">&nbsp;</td><td>"
						+ "<br/><input type=\"submit\" name=\"cmdSubmit\" value=\""+cmdSubmit+"\" class=\"input\" onClick=\"return checkForm(this.form)\">"
						+ "&nbsp;<input type=\"submit\" name=\"cmdSubmit\" value=\"Cancel\" class=\"input\" onClick=\"return cancelForm()\">"
						+ "&nbsp;<input type=\"hidden\" name=\"formName\" value=\"aseForm\">"
						+ "&nbsp;<input type=\"hidden\" name=\"formAction\" value=\"s\">"
						+ "</td></tr>");

		out.println("</table>");
		out.println("</p></form>");
	}

	asePool.freeConnection(conn,"prgcrt",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>