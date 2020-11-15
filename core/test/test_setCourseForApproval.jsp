<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Course Question Listing";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%

out.println( CourseDB.setCourseForApproval(conn,"LEECC","ICS","100","THANHG") );

/*
		String campus = "LEECC";
		String alpha = "TTG";
		String num = "100";
		String proposer = "THANHG";

		int rowsAffected = 0;

		try{

			String disableFromEditSQL = "UPDATE tblCourse SET edit=0,edit0='',edit1='',edit2='',progress='APPROVAL' WHERE coursetype='PRE' AND coursealpha=? AND coursenum=? AND campus=?";

			// disable from further editing
			PreparedStatement preparedStatement = conn.prepareStatement(disableFromEditSQL);
			preparedStatement.setString (1, alpha);
			preparedStatement.setString (2, num);
			preparedStatement.setString (3, campus);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close ();

			// create task for all approvers
			Approver approver = new Approver();
			approver = ApproverDB.getApprovers(conn,campus,"THANHG");
			if ( approver.getApprover() != null ){
				String[] tasks = new String[10];
				tasks = approver.getAllApprovers().split(",");
				for ( int i=0; i<tasks.length; i++)
					rowsAffected = TaskDB.logTask(conn,tasks[i],proposer,alpha,num,"Approve outline",campus,"crsedt.jsp","ADD");
			}

			// TODO: send mail
		}
		catch (Exception e)
		{
			out.println( e.toString() );
		}
*/

%>

</body>
</html>