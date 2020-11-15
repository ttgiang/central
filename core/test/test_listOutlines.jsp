<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/

	String alpha = "ICS";
	String num = "241";
	String type = "CUR";
	String sql = "";

	int idx = 84;
	out.println(listOutlines(conn,type,idx));
	asePool.freeConnection(conn);
%>

<%!
	public static String listOutlines(Connection conn,String type,int idx){

		StringBuffer listings = new StringBuffer();
		String[] campuses = new String[20];
		String listing = "";
		String alpha = "";
		String num = "";
		String title = "";
		String campus = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				campus = CampusDB.getCampusNames(conn);
				if (!"".equals(campus))
					campuses = campus.split(",");

				campus = "";

				sql = "SELECT coursealpha,coursenum,coursetitle " +
					"FROM tblCourse " +
					"WHERE coursealpha like '" + (char)idx + "%' AND " +
					"coursetype=? " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();

					if (!"".equals(title)){
						if (j++ % 2 == 0)
							rowColor = "#e1e1e1";
						else
							rowColor = "#ffffff";

						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"\" width=\"50%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;-&nbsp;" + title + "</td>");
						for (i=0;i<campuses.length;i++){
							if (CourseDB.courseExistByTypeCampus(conn,campuses[i],alpha,num,type)){
								if ("PRE".equals(type))
									title = CourseDB.getCourseDescriptionByType(conn,campuses[i],alpha,num,"PRE");
								else
									title = CourseDB.getCourseDescription(conn,alpha,num,campuses[i]);

								link = "vwcrsx.jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
								listings.append("<td class=\"linkcolumn\" align=\"center\" width=\"6%\"><a href=\"" + link + "\" class=\"linkcolumn\">" + campuses[i] + "</a></td>");
							}
							else{
								listings.append("<td align=\"center\" valign=\"middle\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>");
							}
						}
						listings.append("</tr>");
					}

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
				}
				else{
					listing = "Outline not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			//logger.fatal("Helper: listOutlines\n" + e.toString());
		}
		catch( Exception ex ){
			//logger.fatal("Helper: listOutlines\n" + ex.toString());
		}

		return listing;
	}

%>