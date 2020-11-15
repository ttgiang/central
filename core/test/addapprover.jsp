<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="com.ase.aseutil.*"%>
<%@ include file="ase.jsp" %>

<%

String id = request.getParameter("lid");
String seq = request.getParameter("seq");
int i;
String temp = "";
String approvers = "";
String message = "";
int rowsAffected = 0;

// there is a possible 10 approvers for each phase
// read from the form, and concat into a single CSV
for ( i = 0; i < 10; i++ ){
	temp = request.getParameter("approver_" + i);
	if ( temp != null && temp.length() > 0 ){

		if ( approvers.length() > 0 )
			approvers = approvers + ",";

		approvers = approvers + temp;
	}
}

Approver approverDB = new Approver
(
	id,
	seq,
	approvers,
	(String)session.getAttribute("aseUserName"),
	(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()),
	(String)session.getAttribute("aseCampus")
);

if ( !ApproverDB.isMatch( conn, seq, (String)session.getAttribute("aseCampus") ) ){
	PreparedStatement preparedStatement = conn.prepareStatement ("INSERT INTO tblApprover (approver_seq, approver, addedby, addeddate, campus) VALUES (?, ?, ?, ?, ?)");
	preparedStatement.setString (1, approverDB.getSeq());
	preparedStatement.setString (2, approverDB.getApprover());
	preparedStatement.setString (3, approverDB.getLanid());
	preparedStatement.setString (4, approverDB.getDte());
	preparedStatement.setString (5, approverDB.getCampus());
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();

	if ( rowsAffected == 1 )
		message = "Approver sequence <b>" + seq + "</b> inserted successfully";
	else
		message = "Unable to insert approver sequence <b>" + seq + "</b>";

}
else{
	rowsAffected = -1;
	message = "Approver sequence already <b>" + seq + "</b> exists in Curriculum Central";
}

out.println( message );

%>
