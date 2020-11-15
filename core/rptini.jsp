<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rptini.jsp - system value report
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String sql = aseUtil.getPropertySQL(session,"iniCategoryReport");
	String category = website.getRequestParameter(request,"category", "");
	String props = "iniSystemReport";
	String pageTitle = "System Value Report";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/systemlistreport.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/rptini.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
		out.println("		<form method=\"post\" name=\"aseForm\" action=\"?\">" );
		out.println("			<table width=\"" + session.getAttribute("aseTableWidth") + "\" cellspacing='1' cellpadding='2' class=\"tableBorder" + session.getAttribute("aseTheme") + "\" align=\"center\"  border=\"0\">" );
		out.println("				<tr class=\"textblackTRTheme" + session.getAttribute("aseTheme") + "\">" );
		out.println("					<td>" + aseUtil.createSelectionBox(conn,sql,"category",category,false) );
		out.println( "						<input type=\"submit\" value=\"Go\" name=\"cmdGo\" class=\"inputsmallgray\">" );
		out.println( "						</td>" );
		out.println("				</tr>" );
		out.println("		</table>" );
		out.println("		</form>" );

		if (!"".equals(category)){
			out.println("<form name=\"aseForm2\" method=\"post\" action=\"rptinix.jsp\">");
			out.print(IniDB.listSystemValues(conn,category,props,request));
			out.println("<input type=\"hidden\" name=\"category\" value=\""+category+"\">");
			out.println("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">");
			out.println("<p align=\"left\"><input type=\"submit\" name=\"cmdSubmit\" class=\"input\" value=\"Submit\" onClick=\"return checkForm(this.form)\">");
			out.println("<input type=\"submit\" name=\"cmdCancel\" class=\"input\" value=\"Cancel\" onClick=\"return cancelForm(this.form)\"></p>");
			out.println("</form>");
			out.println("<p align=\"left\"><b>Note:</b> Place check marks beside items you wish to report on then click \'Submit\' to continue.</p>");
		}
	}

	asePool.freeConnection(conn,"rptini",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>