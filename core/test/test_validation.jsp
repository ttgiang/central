<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	test_validation.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";
	String kix = "y31b8h9176";
	int t = 0;

	out.println("Start<br/>");

	try{
		//out.println(approvalValidation(conn,kix));
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	public static boolean approvalValidation(Connection conn,String kix) throws SQLException {

		Logger logger = Logger.getLogger("test");

		String sql = "";

SELECT  DERIVEDTBL.*, CCCM6100.Question_Friendly AS [column]
FROM
	(
		SELECT     questionnumber, questionseq, type, campus, substring(question, 1, 250) AS question
		FROM tblCourseQuestions
		WHERE (campus=? AND (include = 'Y') AND (required = 'Y')) DERIVEDTBL INNER JOIN
		CCCM6100 ON DERIVEDTBL.questionnumber = CCCM6100.Question_Number
WHERE (DERIVEDTBL.campus=?) AND (CCCM6100.campus = 'SYS') AND (CCCM6100.type = 'Course')
UNION
SELECT DERIVEDTBL.*, CCCM6100.Question_Friendly AS [column]
FROM
	(
		SELECT     questionnumber, questionseq, type, campus, substring(question, 1, 250) AS question
		FROM tblCampusQuestions
		WHERE (campus=?) AND (include = 'Y') AND (required = 'Y')) DERIVEDTBL INNER JOIN
		CCCM6100 ON DERIVEDTBL.questionnumber = CCCM6100.Question_Number
WHERE (DERIVEDTBL.campus=?) AND (CCCM6100.campus=?) AND (CCCM6100.type = 'Campus')

	}
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

