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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";
	String[] users = "JITO,BERNER,ABUSH,ADORADO,ANGELANI,ANITTA,ANNEC,ARCHER,ASAILIM,SPOPE,WALBRITT,GOODMANJ,MPECSOK".split(",");
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";
	String kix = "k19k22f9156 ";
	String separator = "<br/>---------------------<br/>";
	int t = 0;

	out.println("Start<br/>");


	try{
		Approver approver = new Approver("7", "7","THANHG","THANHG",false,false,"THANHG",
				(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()),
				campus,1);

		// no need to do more
		//- need to do more

		out.println("insertApprover: " + ApproverDB.insertApprover(conn,approver) + separator);
		out.println("isMatch: " + ApproverDB.isMatch(conn,"7",user,campus,1) + separator);
		out.println("maxApproverSeqID: " + ApproverDB.maxApproverSeqID(conn, campus) + separator);

		approver = new Approver("123", "7","THANHG","SPOPE",false,false,"THANHG",
				(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()),
				campus,1);

		out.println("updateApprover: " + ApproverDB.updateApprover(conn,approver) + separator);
		out.println("deleteApprover: " + ApproverDB.deleteApprover(conn,"123",1) + separator);
		out.println("getApprover: " + ApproverDB.getApprover(conn,124,1) + separator);
		out.println("getApprover: " + ApproverDB.getApprover(conn,"THANHG",1) + separator);
		out.println("getApproverCount: " + ApproverDB.getApproverCount(conn,campus,7,1) + separator);
		out.println("getApproverSequence: " + ApproverDB.getApproverSequence(conn,"THANHG",1) + separator);
		out.println("getDelegateByApproverName: " + ApproverDB.getDelegateByApproverName(conn,campus,"THANHG",1) + separator);
		out.println("getApproverByDelegateName: " + ApproverDB.getApproverByDelegateName(conn,campus,"HOTTA",1) + separator);
		out.println("getApproverByName: " + ApproverDB.getApproverByName(conn,campus,alpha,num,user,1) + separator);
		out.println("getApprovers: " + ApproverDB.getApprovers(conn,campus,alpha,user,false,1) + separator);
		out.println("getApproverNames: " + ApproverDB.getApproverNames(conn,campus,alpha,1) + separator);
		out.println("getApproverNamesByAlpha: " + ApproverDB.getApproverNamesByAlpha(conn,campus,alpha,1) + separator);
		out.println("getLastPersonToApprove: " + ApproverDB.getLastPersonToApprove(conn,campus,alpha,num,1) + separator);
		out.println("getMaxApproverSeq: " + ApproverDB.getMaxApproverSeq(conn,campus,1) + separator);
		out.println("getNextPersonToApprove: " + ApproverDB.getNextPersonToApprove(conn,campus,alpha,num,1) + separator);
		out.println("showApprovalProgress: " + ApproverDB.showApprovalProgress(conn,campus,user,65) + separator);
		out.println("showApprovers: " + ApproverDB.showApprovers(conn,campus,1) + separator);
		out.println("showApproversByDivisions: " + ApproverDB.showApproversByDivisions(conn,campus)  + separator);
		out.println("getDivisionChairApprover: " + ApproverDB.getDivisionChairApprover(conn,campus,alpha) + separator);
		out.println("showCompletedApprovals: " + ApproverDB.showCompletedApprovals(conn,campus,alpha,num) + separator);
		out.println("showPendingApprovals: " + ApproverDB.showPendingApprovals(conn,campus,alpha,"true") + separator);
		out.println("countApprovalHistory: " + ApproverDB.countApprovalHistory(conn,kix) + separator);
		out.println("getApprovalHistory: " + ApproverDB.getApprovalHistory(conn,kix) + separator);
		out.println("getApproversBySeq: " + ApproverDB.getApproversBySeq(conn,campus,7,1) + separator);
		out.println("displayFastTrackApprovers: " + ApproverDB.displayFastTrackApprovers(conn,campus,kix,1) + separator);
		out.println("displayApproversBySeq: " + ApproverDB.displayApproversBySeq(conn,campus,7,1) + separator);
		out.println("displayApproversBySeq: " + ApproverDB.fastTrackApprovers(conn,campus,kix,7,6,1) + separator);
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

