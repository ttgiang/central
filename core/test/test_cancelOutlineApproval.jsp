<%@ include file="ase.jsp" %>

<%
	String pageTitle = "";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%

	try{
		String alpha = "ICS";
		String num = "241";
		String campus = "LEE";
		String user = "THANHG";
		String type = "PRE";
		String message = "";

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in approval process
		 * 1) Must be proposer
		 * 2) Cannot have any comments in the system (tblApprovalHist)
		 * 3) Remove tasks
		 * 4) Notify approvers
		 */
		StringBuffer errorLog = new StringBuffer();

		try{
			if ("APPROVAL".equals(courseDB.getCourseProgress(conn,campus,alpha,num,"PRE")) ){
				String proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
				if (proposer.equals(user)){
					if (!HistoryDB.approvalStarted(conn,campus,alpha,num,user) ){
						String SQL = "UPDATE tblCourse SET edit=1,progress='MODIFY',edit1='1',edit2='1' " +
							"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
						PreparedStatement ps = conn.prepareStatement(SQL);
						ps.setString(1, campus);
						ps.setString(2, alpha);
						ps.setString(3, num);
						int rowsAffected = ps.executeUpdate();
					}
					else{
						msg.setMsg("OutlineApprovalStarted");
					}
				}
				else{
					msg.setMsg("OutlineProposerCanCancel");
				}
			}
			else{
				msg.setMsg("OutlineNotInApprovalStatus");
			}
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			out.println("CourseDB: cancelOutlineApproval\n" + ex.toString() + "\n" + errorLog.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			out.println("CourseDB: cancelOutlineApproval\n" + e.toString() + "\n" + errorLog.toString());
		}

		if ("Exception".equals(msg.getMsg())){
			message = "Outline approval cancellation failed.<br><br>" + msg.getErrorLog();
		}
		else if ( !"".equals(msg.getMsg()) ){
			message = "Unable to cancel outline approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
		}
		else{
			message = "Outline approval cancelled successfully<br>";
		}

		out.println(message);

	}
	catch(Exception e){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);

%>
</body>
</html>
