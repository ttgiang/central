<%@ page import="org.apache.log4j.Logger"%>
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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String src = "x43";
	String dst = "m55g17d9203";

	out.println("Start<br/>");

	boolean editable = false;
	String progress = "";
	long countApprovalHistory = 0;

	String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

	try {

	} catch (SQLException e) {
		out.println(kix + " - CourseDB: isEditable\n" + e.toString());
	} catch (Exception ex) {
		out.println(kix + " - CourseDB: isEditable\n" + ex.toString());
	}

	out.println("countApprovalHistory: " + countApprovalHistory);
	out.println("editable: " + editable);

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
