<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

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
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "MAU";
	String alpha = "ICS";
	String alphax = "ICS";
	String num = "101";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String compid = "50";
	Comp comp = new Comp();
	String kix = "y17h9e9228";
	String hid = "y17h9e9228";
	int i = 0;

	out.println("Start<br>");
	out.println("<br>---------------------------------------------getComp<br>");
	out.println(getGESLO(conn,campus,kix,true));
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

<%!

	public static String getGESLO(Connection conn,String campus,String kix,boolean lock) {

		Logger logger = Logger.getLogger("test");

		int id = 0;
		String sid = "";
		String kid = "";
		String kdesc = "";
		String slo = "";
		String sql = "";

		StringBuffer buf = new StringBuffer();

		int totalTopics = 10;
		String[] topic = new String[totalTopics];
		String[] color = new String[totalTopics];
		color[0] = "#e0e0e0";
		color[1] = "#ffffff";
		color[2] = "cyan";
		color[3] = "lightgreen";
		color[4] = "#ffffA8";
		color[5] = "#b0d8ff";
		color[6] = "#b5fbbf";
		color[7] = "#f4ffdd";
		color[8] = "#ffffff";
		color[9] = "#e0e0e0";

		String temp = "";

		boolean found = false;

		int cellWidth = 0;
		int tableWidth = 90;

		int i=0;		// row of table
		int j=0;		// col of table

		GESLO geslo;

		int countOfEvals = 0;
		String[] evals = new String[totalTopics];

		int checks = 4;
		int checkCounter = 0;
		String[] inputField = new String[checks];
		String[] checked = new String[checks];
		String[] levels = new String[checks];

		try {
			countOfEvals = IniDB.mumberOfItems(conn,campus,"MethodEval");

			i = 0;
			sql = "SELECT id, kid, kdesc "
						+ "FROM tblINI "
						+ "WHERE campus=? AND "
						+ "category='GESLO' "
						+ "ORDER BY kid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				kid = rs.getString("kid");
				kdesc = rs.getString("kdesc");

				topic[i] = kid;

				for(checkCounter=0;checkCounter<checks;checkCounter++){
					checked[checkCounter] = "&nbsp;";
					inputField[checkCounter] = "&nbsp;";
				}

				geslo = GESLODB.getGESLO(conn,campus,kix,id);
				if (geslo!=null){

					evals[i] = "," + geslo.getSloEvals() + ",";

					if (geslo.getGeid() > 0)
						checked[0] = "checked";

					switch(geslo.getSloLevel()){
						case 0 : checked[1] = "checked"; break;
						case 1 : checked[2] = "checked"; break;
						case 2 : checked[3] = "checked"; break;
					}
				}

				levels[0] = "";
				levels[1] = "Preparatory Level";
				levels[2] = "Level 1";
				levels[3] = "Level 2";

				if (lock){
					for(checkCounter=0;checkCounter<checks;checkCounter++){
						if ("checked".equals(checked[checkCounter]))
							inputField[checkCounter] = "<img src=\"../images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" title=\"selected\">" + levels[checkCounter];
					}
				}
				else{
					inputField[0] = "<input " + checked[0] + " type=\"checkbox\" value=\""+id+"\" name=\"slo_"+i+"\" class=\"input\">";
					inputField[1] = "<input " + checked[1] + " type=\"radio\" value=\"0\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[1] + "&nbsp;&nbsp;&nbsp;";
					inputField[2] = "<input " + checked[2] + " type=\"radio\" value=\"1\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[2] + "&nbsp;&nbsp;&nbsp;";
					inputField[3] = "<input " + checked[3] + " type=\"radio\" value=\"2\" name=\"level_"+id+"\" class=\"input\">" + "&nbsp;" + levels[3] + "&nbsp;&nbsp;&nbsp;";
				}

				buf.append("<tr bgcolor=\""+ color[i] +"\"><td valign=\"top\">" + inputField[0] + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\"><b>" + kid + "</b> - "
					+ kdesc
					+ "<br/><br/>"
					+ inputField[1]
					+ inputField[2]
					+ inputField[3]
					+ "</td></tr>");

				++i;
				found = true;
			} // while
			rs.close();
			ps.close();

			// actual topics
			totalTopics = i;

			if (found){
				slo = "<p align=\"center\"><table width=\"90%\" border=\"1\" width=\"0\" cellpadding=\"5\" cellspacing=\"0\">"
					+ buf.toString()
					+ "</table></p>";

				buf.setLength(0);
				found = false;

				sql = "SELECT id, kdesc "
					+ "FROM tblINI "
					+ "WHERE campus=? AND "
					+ "category='MethodEval' "
					+ "ORDER BY kdesc";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				rs = ps.executeQuery();

				/*
					sid is string representation of id with commas on each end. the commas were added
					to help in the use if indexOf to find the values within the CSV of values saved to DB.
				*/
				i = 0;
				while (rs.next()) {
					id = rs.getInt("id");
					sid = ","+id+",";
					kdesc = rs.getString("kdesc");

					buf.append("<tr><td class=\"textblackth\">" + kdesc + "</td>");

					for(j=0;j<totalTopics;j++){

						checked[0] = "&nbsp;";
						if (evals[j] != null && evals[j].length() > 0 && (evals[j].indexOf(sid)>=0)){
							checked[0] = "checked";
						}

						if (lock)
							if ("checked".equals(checked[0]))
								inputField[0] = "<img src=\"../images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" title=\"selected\">";
							else
								inputField[0] = "&nbsp;";
						else
							inputField[0] = "<input type=\"checkbox\" checked value=\"" + id + "\" name=\"item_"+i+""+j+"\" class=\"input\">";

						buf.append("<td bgcolor=\"" + color[j] + "\" valign=\"top\" class=\"datacolumn\">" + inputField[0] + "</td>");
					}

					buf.append("</tr>");

					++i;
					found = true;
				} // while
				rs.close();
				ps.close();

				if (found){

					cellWidth = (int)((tableWidth-25)/totalTopics);
					temp = "";
					for(j=0; j<totalTopics;j++){
						temp = temp + "<td bgcolor=\"" + color[j] + "\" valign=\"top\" class=\"textblackth\" width=\"" + cellWidth + "%\">" + topic[j] + "</td>";
					}

					slo = slo + "<p align=\"center\">"
						+ "<table width=\"" + tableWidth + "%\" border=\"1\" width=\"0\" cellpadding=\"5\" cellspacing=\"0\">"
						+ "<tr><td width=\"25%\">&nbsp;</td>" + temp + "</tr>"
						+ buf.toString()
						+ "</table></p>";
				}
			}

		} catch (Exception e) {
			logger.fatal("CompDB: getGESLO\n" + e.toString());
		}

		return slo;
	}

%>

