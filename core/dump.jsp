<%@ include file="ase.jsp" %>

<%
	/*
		dump the question data for a single course
	*/
	String pageTitle = "Outline Dump";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%

	String alpha = "ICS";
	String num = "241";
	String campus = Constant.CAMPUS_LEE;
	String type = "CUR";

	// taken from campus table using campus items
	String fields = "coursealpha,coursenum,credits,effectiveterm,reviewdate,coursetitle,X15,X16,X17,coursedescr,X18,X19,X60,X25,X27,X32,X33,X44,X50,X37,X41,X40,X56,X24,X23,X20,X46,X47,X48,X49,X52,excluefromcatalog,dateproposed,assessmentdate";
	String[] arr = new String[30];
	arr = fields.split(",");
	String sql = "SELECT " + fields + " FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
	StringBuffer buf = new StringBuffer();

	ResultSet rs;
	ResultSet rsx;

	PreparedStatement ps;
	PreparedStatement psx;

	String question = "";
	int i = 0;
	int counter = 1;

	try{
		ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		rs = ps.executeQuery();
		buf.append("<table border=\"1\" width=\"100%\">");
		if (rs.next()) {
			for(i=0; i<arr.length; i++){
				buf.append("<tr>");
				buf.append("<td valign=\"top\" width=\"2%\">" + (counter++) + ":</td>");
				buf.append("<td valign=\"top\" width=\"10%\">" + arr[i] + "</td>");

				question = "";
				sql = "SELECT question FROM vw_CourseQuestions WHERE Question_Friendly=?";
				psx = conn.prepareStatement(sql);
				psx.setString(1,arr[i]);
				rsx = psx.executeQuery();
				if (rsx.next()){
					question = rsx.getString(1);
				}
				rsx.close();

				buf.append("<td valign=\"top\" width=\"45%\">" + question + "</td>");
				buf.append("<td valign=\"top\" width=\"45%\">" + rs.getString(arr[i]) + "</td>");
				buf.append("</tr>");
			}
		}

		fields = "C1,C2,C3,C4,C5,C6,C7,C8,C10,C11,C12";
		String[] arr2 = new String[20];
		arr2 = fields.split(",");
		sql = "SELECT " + fields + " FROM tblCampusData WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";

		ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		rs = ps.executeQuery();
		if (rs.next()) {
			for(i=0; i<arr2.length; i++){
				buf.append("<tr>");
				buf.append("<td valign=\"top\" width=\"2%\">" + (counter++) + ":</td>");
				buf.append("<td valign=\"top\" width=\"10%\">" + arr2[i] + "</td>");

				question = "";
				sql = "SELECT question FROM vw_CampusQuestions WHERE Question_Friendly=?";
				psx = conn.prepareStatement(sql);
				psx.setString(1,arr2[i]);
				rsx = psx.executeQuery();
				if (rsx.next()){
					question = rsx.getString(1);
				}
				rsx.close();

				buf.append("<td valign=\"top\" width=\"45%\">" + question + "</td>");
				buf.append("<td valign=\"top\" width=\"45%\">" + rs.getString(arr2[i]) + "</td>");
				buf.append("</tr>");
			}
		}

		buf.append("</table>");
		rs.close();
		ps.close ();
		out.println(buf.toString());
	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);
%>

</body>
</html>