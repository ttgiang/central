<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crstpl.jsp
	*	2007.09.01
	**/

	String alpha = "ICS";
	String num = "241";
	String type = "PRE";
	String campus = "LEE";
	String user = "THANHG";

		int i = 0;				// counter
		int lid = 0;			// accjc id
		int controls = 7;		// total SLO questions

		String[] question = new String[controls];
		String[] content = new String[controls];
		StringBuffer slo = new StringBuffer();
		String campusName = "";

		CourseACCJC accjc = new CourseACCJC();
		Vector vector = new Vector();

		try{
			vector = AssessedDataDB.getAssessedQuestions(conn,campus);
			if ( vector != null ){
				i = 0;
				for (Enumeration e = vector.elements(); e.hasMoreElements();){
					question[i++] = (String)e.nextElement();
				}
			}

			String sql = "SELECT id FROM tblCourseACCJC WHERE campus=? AND coursealpha=? AND coursenum=? and coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet rs = ps.executeQuery();

			slo.append("<table border=\"0\" width=\"100%\">");

			while (rs.next()){
				lid = rs.getInt(1);
				accjc = CourseACCJCDB.getACCJC(conn,campus,lid,true);

//out.println(accjc);

				content = AssessedDataDB.getAssessedData(conn,lid);

				slo.append("<tr bgcolor=#e1e1e1><td height=\"8\" colspan=\"2\"></td></tr>");

				slo.append("<tr>");
				slo.append("<td height=\"20\" class=\"textblackTH\" width=\"25%\">Content:</td>");
				slo.append("<td class=\"dataColumn\">" + accjc.getContent() + "</td>");
				slo.append("</tr>");

				slo.append("<tr>");
				slo.append("<td height=\"20\" class=\"textblackTH\">Competency:</td>");
				slo.append("<td class=\"dataColumn\">" + accjc.getComp() + "</td>");
				slo.append("</tr>");

				slo.append("<tr>");
				slo.append("<td height=\"20\" class=\"textblackTH\">Assessment Method:</td>");
				slo.append("<td class=\"dataColumn\">" + accjc.getAssessment() + "</td>");
				slo.append("</tr>");

				slo.append("<tr><td height=\"20\" colspan=\"2\"><hr size=\"1\"></td></tr>");

				for(i=0;i<controls;i++){
					slo.append("<tr><td height=\"20\" colspan=\"2\" class=\"textblackTH\">" + (i+1) + ".&nbsp;" + question[i] + "</td></tr>");
					slo.append("<tr><td height=\"20\" colspan=\"2\" class=\"dataColumn\">" + content[i*3] + "<p>&nbsp;</p></td></tr>");
				}
			}

			slo.append("</table>");

			rs.close();
			ps.close();
		}
		catch( SQLException e ){
			out.println("CourseDB: viewOutlineSLO\n" + e.toString());
		}
		catch( Exception ex ){
			out.println("CourseDB: viewOutlineSLO\n" + ex.toString());
		}

		out.println(slo);
%>