<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slosplt.jsp	-	split slos into line items (LEE)
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";

	String thisPage = "slosplt";
	session.setAttribute("aseThisPage",thisPage);

	String message = "";
	String alpha = "";
	String num = "";
	String type = "";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix");

	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	String title = courseDB.getCourseDescription(conn,alpha,num,campus);
	String pageTitle = "Reformat SLO (" + alpha + " " + num + " - " + title + ")";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/slosplt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table border="0" width="60%" id="table1" height="100%">
	<tr>
		<td height="20%">&nbsp;
		<%
			out.println(CompDB.getObjectives(conn,kix));
			asePool.freeConnection(conn);
		%>
		</td>
	</tr>
</table>

<%
	out.println("	<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

	out.println("		<form method=\'post\' name=\'aseForm\' action=\'slospltx.jsp\'>" );
	out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
	out.println("				 <td class=\'textblackTH\' nowrap>SLO:&nbsp;</td>" );
	out.println("				 <td><textarea class=\'input\' id=\"comp\" name=\"comp\" cols=80 rows=5>" + "" + "</textarea>" );
	out.println("			</td></tr>" );

	out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
	out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
	out.println("				<td><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
	out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
	out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
	out.println("					<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
	out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
	out.println("					<input type=\'hidden\' name=\'compID\' value=\'" + "0" + "\'>" );
	out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
	out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );

	out.println("<input title=\'save SLO\' type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'input' onclick=\"return checkForm();\">" );
	out.println("<input title=\'abort selected operation\' type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'input\' onClick=\"return cancelForm()\">" );
	out.println("<input title=\'return to assessment\' type=\'submit\' name=\'aseAssessment\' value=\'Return to Assessment\' class=\'input\' onClick=\"returnToAssessment('" + campus + "','" + kix + "')\">" );

	out.println("			</td></tr>" );
	out.println("		</form>" );
	out.println("	</table>" );

	ArrayList list = new ArrayList();
	list = CompDB.getCompsByTypeX(conn,kix);
	if ( list != null ){
		Comp comp = new Comp();
		out.println("<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td><br/>" );
		out.println("<ul>");
		for (int i = 0; i<list.size(); i++){
			comp = (Comp)list.get(i);
			out.println("<li>" + comp.getComp() + "</li>");
		}
		out.println("</ul>");
		out.println("</td></tr>" );
		out.println("</table>" );
	}

%>

<p align="left">Instructions: The new assessment process requires SLOs separated into individual line items prior to assessment. Copy and paste your SLO into the text box and click 'Save'.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
