<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	/**
	*	ASE
	*	questionx.jsp
	*	2007.09.01	questions maintenance
	**/

	String questionType = request.getParameter("questionType");
	String chromeWidth = "80%";
	String pageTitle = questionType + " Question Maintenance";
	session.setAttribute("aseApplicationMessage","");
%>

<%@ include file="ase.jsp" %>

<html>
<head>
	<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>
	<script language="JavaScript" src="js/questions.js"></script>
	<link type=text/css rel=stylesheet href="styles/tabs.css">
	<link type=text/css rel=stylesheet href="../inc/style.css">
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TBODY>
		<%
			String questions = "";
			int rowsAffected = 0;
			int maxNo = Integer.parseInt(request.getParameter( "maxNo" ));
			String campus = (String)session.getAttribute("aseCampus");

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();
			for ( int i = 1; i <= maxNo; i++ ){
				questions = request.getParameter( "questions_" + (i));

				rowsAffected = aseUtil.updateQuestionRecords(conn, String.valueOf(i), questionType, campus, questions);

				if ( rowsAffected == 1 ){
					out.println( "<tr><td class=textblue>" );
					out.println( "<br>Question " + i + "<br><br>" );
					out.println( "</td></tr>" );
					out.println( "<tr><td>" );
					out.println( questions );
					out.println( "</td></tr>" );
				}
			}
			aseUtil = null;
			asePool.freeConnection(conn);
		%>
	</TBODY>
</TABLE>
<br />
<br />
<hr size="1"><p align="center"><a class="linkcolumn" href="questions.jsp">continue editing</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="linkcolumn" href="index.jsp">return to main</a></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
