<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crstpl.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "ICS";
	String num = "100";
	String type = "CUR";
	String sql = "";
	String temp = "";
	String campus = Constant.CAMPUS_KAP;

	StringBuffer html = new StringBuffer();
	int i = 0;

	String t2 = "";
	String t3 = "";
	String question = "";

	/* print template */
	String s1 = "<!-- line print -->";
	String s2 = "<tr><td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\">@@COUNTER@@.&nbsp;</td><td class=\"textblackTH\" valign=\"top\">@Q@@@Q000@@</td></tr>";
	String s3 = "<tr><td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td><td class=\"dataColumn\" valign=\"top\">@A@@@D000@@<br/><br/></td></tr>";

	/* columns to print */
	String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
	String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

	String[] c1 = f1.split(",");
	String[] c2 = f2.split(",");

	if ("CUR".equals(type)){
		temp = CourseDB.getFieldsForNewOutlines(conn,campus);
		f1 = temp;
		c1 = temp.split(",");
	}

	/* read columsn from database and print */
	sql = "SELECT " + f1 + " FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1,campus);
	ps.setString(2,alpha);
	ps.setString(3,num);
	ps.setString(4,type);
	ResultSet rs = ps.executeQuery();
	if (rs.next()){
		html.append("<table border=\"0\" width=\"100%\">"+"\n");
		for(i=0;i<c1.length;i++){
			html.append(s1+"\n");
			t2 = s2.replace("@@COUNTER@@",String.valueOf(i+1));
			//question = aseUtil.lookUp(conn, "vw_CourseReportItems", "question", "field_name = '" + c1[i] + "'" );
			t2 = t2.replace("@@Q000@@",c1[i]);
			//t3 = s3.replace("@@D000@@",aseUtil.nullToBlank(rs.getString(c1[i])));
			t3 = s3.replace("@@D000@@",c1[i]);
			html.append(t2+"\n");
			html.append(t3+"\n");
		}
	}
	rs.close();
	ps.close();

	sql = "SELECT " + f2 + " FROM tblCampusData WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
	ps = conn.prepareStatement(sql);
	ps.setString(1,campus);
	ps.setString(2,alpha);
	ps.setString(3,num);
	ps.setString(4,type);
	rs = ps.executeQuery();
	if (rs.next()){
		for(i=0;i<c2.length;i++){
			html.append(s1+"\n");
			t2 = s2.replace("@@COUNTER@@",String.valueOf(i+1));
			question = aseUtil.lookUp(conn, "vw_CampusReportItems", "question", "field_name = '" + c2[i] + "'" );
			t2 = t2.replace("@@Q000@@",c2[i]);
			//t3 = s3.replace("@@D000@@",aseUtil.nullToBlank(rs.getString(c2[i])));
			t3 = s3.replace("@@D000@@",c2[i]);
			html.append(t2+"\n");
			html.append(t3+"\n");
		}
	}
	rs.close();
	ps.close();

	html.append("</table>"+"\n");

	out.println(html.toString());

	asePool.freeConnection(conn);

%>