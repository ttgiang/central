<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Answers Answers!";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	Logger logger = Logger.getLogger("test");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<p>&nbsp;</p>
<p align="left">
<table width="30%" border="0">

<%
	if (processPage){
		try{
			int score = 0;
			String auditBy = "";
			String rowColor = "";

			ArrayList list = com.ase.aseutil.faq.AnswerDB.getScores(conn);

			if (list != null){

				out.println("<tr height=\"20\">"
								+ "<td width=\"40%\" class=\"textblackth\">High Scorer</td>"
								+ "<td width=\"60%\" class=\"textblackth\">Points Earned</td>"
								+ "</tr>");

				com.ase.aseutil.faq.Answer answer = null;

				for (int i = 0; i<list.size(); i++){

					answer = (com.ase.aseutil.faq.Answer)list.get(i);

					score = answer.getScore();
					auditBy = answer.getAuditBy();

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					out.println("<tr bgcolor=\""+rowColor+"\" height=\"20\">"
									+ "<td class=\"datacolumn\">" + auditBy + "</td>"
									+ "<td class=\"datacolumn\">" + score + "</td>"
									+ "</tr>");

				} // for
			} // if
		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

	} // processPage

	asePool.freeConnection(conn,"scores",user);
%>

</table>
</p>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
