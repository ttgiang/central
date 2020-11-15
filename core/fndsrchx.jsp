<%@ include file="ase.jsp" %>

<%

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String txt = website.getRequestParameter(request,"txt","");

	//
	// INLINE
	//
	out.println(search(conn,txt));

	asePool.freeConnection(conn,"fndsrchx",user);

%>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	/*
	 * search
	 *	<p>
	 * @param	conn			Connection
	 * @param	srch			String
	 *	<p>
	 * @return	String
	 */
	public static String search(Connection conn,String srch) throws Exception {

Logger logger = Logger.getLogger("test");

		StringBuffer result = new StringBuffer();

		boolean debug = false;

		try {

			result.append("<table id=\"one\" cellspacing=\"2\" cellpadding=\"6\">"
								+ "<thead>"
								+ "<tr>"
								+ "<th>&nbsp;</th>"
								+ "</tr>"
								+ "</thead>"
								+ "<tbody>"
								);

			PreparedStatement ps2 = null;
			ResultSet rs2 = null;

			if(debug) System.out.println("search: " + srch);

			//
			// there is a high possibility that multiple rows return for a single course, so we do the following:
			//
			//	1) select distinct IDs only
			// 2) using the ID, we select data but only focus on the first row returned
			//
			// when user clicks to go further down, additional data will be highlighted.
			//
			String masterSQL = "SELECT DISTINCT id FROM tblfnddata WHERE CONTAINS(data, \'"+srch+"\')";
			if(debug) System.out.println("masterSQL: " + masterSQL);
			PreparedStatement ps = conn.prepareStatement(masterSQL);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = NumericUtil.getInt(rs.getInt("id"),0);

				if(debug) System.out.println("id: " + id);

				String sql = "SELECT d.data, f.coursealpha, f.coursenum, f.coursetitle, f.fndtype "
					+ "FROM tblfnddata d INNER JOIN tblfnd f ON d.id = f.id "
					+ "WHERE (d.id IN ("+masterSQL+")) AND (d.id = ?) AND CONTAINS(d.data, \'"+srch+"\') ";

				if(debug) System.out.println("sql: " + sql);

				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,id);
				rs2 = ps2.executeQuery();
				if(rs2.next()){
					String data = AseUtil.nullToBlank(rs2.getString("data"));
					String alpha = AseUtil.nullToBlank(rs2.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs2.getString("coursenum"));
					String title = AseUtil.nullToBlank(rs2.getString("coursetitle"));
					String fndtype = AseUtil.nullToBlank(rs2.getString("fndtype"));

					if(debug) System.out.println("data: " + data);

					int pos = data.toUpperCase().indexOf(srch.toUpperCase());

					if(debug) System.out.println("pos: " + pos);

					if(pos > -1){

						title = alpha + " " + num + " - " + title + " (" + fndtype + ")";

						//
						// extract and display partial text
						//
						if(data.length() >= 150){
							data = data.substring(0,150) + "...";
						}

						result.append("<tr>"
										+ "<td><a href=\"fndvw.jsp?id="+id+"&srch="+srch+"\" class=\"linkcolumn\" target=\"_blank\">"+title+"</a><br>"+data+"</td>"
										+ "</tr>");
					}
				} // rs2

				rs2.close();
				ps2.close();

			}
			rs.close();
			ps.close();

			result.append("</tbody></table>");

		} catch (SQLException se) {
			logger.fatal("FndDB.search - " + se.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.search - " + e.toString());
		}

		return result.toString();

	} // search

%>

