<%@ include file="ase.jsp" %>

<%
	/**
		ASE
		shwfldx.jsp
		2007.09.01	saves editable fields
		TODO
			no longer using this. converted to servlet
			need to include campus tab

	**/

	String chromeWidth = "60%";

	String campus = website.getRequestParameter(request,"campus");
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");

	String pageTitle = "Editable Outline Items (" +
						alpha + " " + num + " - " +
						courseDB.getCourseDescription(conn,alpha,num,campus) + ")";

	String message = "";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	if ( formName != null && formName.equals("aseForm") ){
		if ( "c".equalsIgnoreCase(formAction) ){
			message = "Operation was cancelled successfully.<br/>You may return to approve this outline at any time.";
		}
		else if ( "s".equalsIgnoreCase(formAction) ){
			// how many checkboxes are there
			int fieldCountSystem = website.getRequestParameter(request,"fieldCountSystem",0);
			int fieldCountCampus = website.getRequestParameter(request,"fieldCountCampus",0);

			// allocate enough room to get back check marks
			// hiddenFieldSystem is a CSV hidden form field
			String[] hiddenFieldSystem = new String[fieldCountSystem];
			hiddenFieldSystem = website.getRequestParameter(request,"hiddenFieldSystem").split(",");

			String[] hiddenFieldCampus = new String[fieldCountCampus];
			hiddenFieldCampus = website.getRequestParameter(request,"hiddenFieldCampus").split(",");

			String editSystem = "";			// course item tab
			String editCampus = "";			// campus tab
			String temp = "";

			// for all fields, check to see if it was checked. if yes, set to 1, else 0;
			// the final result is CSV of 0's and 1's of items that can be edited.
			for ( int i = 0; i < fieldCountSystem ; i++ ){
				temp = website.getRequestParameter(request, "SYS_" + hiddenFieldSystem[i]);
				if ( temp != null && "1".equals(temp) )
					temp = "1";
				else
					temp = "0";

				if ( editSystem.length() == 0 )
					editSystem = temp;
				else
					editSystem += "," + temp;
			}

			for ( int i = 0; i < fieldCountCampus ; i++ ){
				temp = website.getRequestParameter(request, campus + "_" + hiddenFieldCampus[i]);

				if ( temp != null && "1".equals(temp) )
					temp = "1";
				else
					temp = "0";

				if ( editCampus.length() == 0 )
					editCampus = temp;
				else
					editCampus += "," + temp;
			}

			//out.println( "editSystem: " + editSystem + "<br>" );
			//out.println( "editCampus: " + editCampus + "<br>" );

			// if these fields don't contain a 1, that means nothing was selected for editing
			if ( editSystem.indexOf("1") > 0 || editCampus.indexOf("1") > 0 ) {
				try{
					// TODO use servlet? Would have to create servlet just for this.
					PreparedStatement stmt = conn.prepareStatement("UPDATE tblCourse SET edit0=?,edit1=?,edit2=? WHERE CourseAlpha=? AND coursenum=? AND CourseType=? AND campus=?");
					stmt.setString(1,"");
					stmt.setString(2,editSystem);
					stmt.setString(3,editCampus);
					stmt.setString(4,alpha);
					stmt.setString(5,num);
					stmt.setString(6,"PRE");
					stmt.setString(7,campus);
					stmt.executeUpdate();
					stmt.close();
					stmt = null;

					// aseApplicationComments saved to session from crsapprx to be processed
					// here
					String user = (String)session.getAttribute("aseUserName");
					String comments = (String)session.getAttribute("aseApplicationComments");

					int rowsAffected = courseDB.approveOutline(conn,campus,alpha,num,user,false,comments);

					com.ase.aseutil.MailerDB mailerDB = new com.ase.aseutil.MailerDB();
					com.ase.aseutil.Mailer mailer = new com.ase.aseutil.Mailer();
					mailer.setFrom("");
					mailer.setTo("");
					mailer.setAlpha(alpha);
					mailer.setNum(num);
					mailerDB.sendMail(conn, mailer, "emailRejectOutline" );
					message = "E-mail notification forwarded to author of outline.";
				}
				catch( SQLException ex ){
					message = ex.toString();
				}	// try-catch
			}
			else{
				message = "When rejecting an outline, you must enable items for the author to modify.<br>" +
					"Click the browser\'s back button to select items for modifications, or cancel this operation.";
			} // if editSystem
		}	// formAction
	}	// formName
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println( "<p align=center>" + message + "</p>");
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
