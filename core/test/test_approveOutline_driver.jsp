<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/ase.css" />
</head>
<body>
<%
		String campus = "LEECC";
		String alpha = "ICS";
		String num = "241";
		String user = "ANIBER";

		int tableCounter = 0;
		int stepCounter = 0;
		int rowsAffected = 0;
		int i = -1;

		boolean DEBUG = true;

		StringBuffer errorLog = new StringBuffer();
		PreparedStatement ps;
		String[] sql = new String[60];
		String thisSQL = "";
		int idx = website.getRequestParameter(request,"x", -1);

		sql[++i]="DELETE FROM tblTempCourse WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCampusData WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCoreq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempPreReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseComp WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseContent WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseCompAss WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="INSERT INTO tblTempCourse SELECT * FROM tblCourse WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempCampusData SELECT * FROM tblCampusData WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempCoreq SELECT * FROM tblCoreq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempPreReq SELECT * FROM tblPreReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempCourseComp SELECT * FROM tblCourseComp WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempCourseContent SELECT * FROM tblCourseContent WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="INSERT INTO tblTempCourseCompAss SELECT * FROM tblCourseCompAss WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer='THANHG',coursedate='09/02/2008' WHERE coursealpha='ICS' AND coursenum='241' AND campus='LEECC'";
		sql[++i]="UPDATE tblTempCoreq SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="UPDATE tblTempPreReq SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="UPDATE tblTempCourseComp SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="UPDATE tblTempCourseContent SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="UPDATE tblTempCampusData SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="UPDATE tblTempCourseCompAss SET coursetype='ARC',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="INSERT INTO tblCourseARC SELECT * FROM tblTempCourse WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblCampusData SELECT * FROM tblTempCampusData WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblCoReq SELECT * FROM tblTempCoreq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblPreReq SELECT * FROM tblTempPreReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblCourseComp SELECT * FROM tblTempCourseComp WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblCourseContent SELECT * FROM tblTempCourseContent WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="INSERT INTO tblCourseCompAss SELECT * FROM tblTempCourseCompAss WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='ARC'";
		sql[++i]="DELETE FROM tblCourse WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblCampusData WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblCoReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblPreReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblCourseComp WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblCourseContent WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="DELETE FROM tblCourseCompAss WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='CUR'";
		sql[++i]="UPDATE tblCourse SET coursetype='CUR',progress='APPROVED',edit1='',edit2='' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblCampusData SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblCoReq SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblPreReq SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblCourseComp SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblCourseContent SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="UPDATE tblCourseCompAss SET coursetype='CUR',auditdate='09/02/2008' WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241' AND coursetype='PRE'";
		sql[++i]="DELETE FROM tblTempCourse WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCampusData WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCoreq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempPreReq WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseComp WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseContent WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblTempCourseCompAss WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, dte, campus, seq, approver, approved, comments ) SELECT tba.id, tba.historyid, '09/02/2008 10:05:32 AM', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq, tba.approver, tba.approved, tba.comments FROM tblApprovalHist tba WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";
		sql[++i]="DELETE FROM tblApprovalHist WHERE campus='LEECC' AND coursealpha='ICS' AND coursenum='241'";

		for(int j=0;j<i+1;j++){
			if (j==idx)
				out.println(j + "&nbsp;");
			else
				out.println("<a href=\"?x=" + j + "\">" + j + "</a>&nbsp;");

			if (j==25)
				out.println("<br>");
		}

		out.println("<br>");
		out.println("<br>");

		if (idx>=0){
			conn.setAutoCommit(false);
			try {
				thisSQL = sql[idx];
				out.println(thisSQL + "<br>");
				ps = conn.prepareStatement(thisSQL);
				rowsAffected = ps.executeUpdate();
				out.println("rowsAffected: " + rowsAffected + "<br>");
				ps.close();
			}
			catch(Exception e){
				out.println(e.toString());
			}

			conn.setAutoCommit(true);
		}
%>

</body>
</head>
</html>
