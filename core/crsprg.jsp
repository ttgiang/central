<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsprg.jsp - For what program was the course designed?
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String kix = website.getRequestParameter(request,"kix","");
	String src = website.getRequestParameter(request,"src","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy") || caller.equals("crsprg")){
		validCaller = true;
	}

	String pageTitle = "For what program was the course designed?";
	fieldsetTitle = pageTitle;

	// lid exists only after a select has been made of a program
	// when that happens, send the user back to the editing screen
	String lid = website.getRequestParameter(request,"lid","");
	if (processPage && lid != null && lid.length() > 0){

		int id = website.getRequestParameter(request,"id",0);
		String action = website.getRequestParameter(request,"ack","a");

		int rowsAffected = ExtraDB.addRemoveExtraX(conn,
																kix,
																action,
																src,
																alpha,
																num,
																lid,
																user,
																id);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsprg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage){
		int degree = website.getRequestParameter(request,"degree",0);
		int division = website.getRequestParameter(request,"division",0);

		String sql = aseUtil.getPropertySQL(session,"prgdegrees");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);
		}

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");
		out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
		out.println("					<input type=\'hidden\' name=\'src\' value=\'" + src + "\'>" );
		out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
		out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("<p align=\"left\">");

		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">Select Program:&nbsp;&nbsp;</td><td>"
						+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
						+ "</td></tr>");

		if (degree > 0){
			sql = aseUtil.getPropertySQL(session,"prgdivision");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
			}

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">Select Division:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"division",""+division,false)
							+ "</td></tr>");
		}

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">&nbsp;</td><td>"
						+ "<br/><input type=\"submit\" name=\"cmdSubmit\" value=\"Submit\" class=\"input\">"
						+ "&nbsp;<input title=\"abort selected operation\" type=\'submit\' name=\'aseClose\' value=\'Close\' class=\'input\' onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"','"+campus+"')\">"
						+ "</td></tr>");

		if (degree > 0 && division > 0){
			paging = new com.ase.paging.Paging();
			sql = aseUtil.getPropertySQL(session,"prgidx6");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
				sql = aseUtil.replace(sql, "_type1_", "CUR");
				sql = aseUtil.replace(sql, "_type2_", "PRE");
				sql = aseUtil.replace(sql, "_id_", ""+degree);
				sql = aseUtil.replace(sql, "_divid_", ""+division);
			}
			paging.setSQL( sql );
			paging.setScriptName("/central/core/crsprg.jsp");
			paging.setDetailLink("/central/core/crsprg.jsp?kix="+kix);
			paging.setUrlKeyName("src="+src+"&lid");
			paging.setTableColumnWidth("0,45,15,15,15");
			paging.setRecordsPerPage(999);
			paging.setNavigation(false);
			out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("<td class=\"\" width=\"20%\" colspan=\"2\">&nbsp;"
							+ Html.BR()
							+ "NOTE: click a link under the Title column to select a program title for which this course was designed."
							+ Html.BR()
							+ paging.showRecords( conn, request, response )
							+ "</td></tr>");
			paging = null;
		}

		boolean enableDelete = true;
		boolean showPending = true;

		out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"\" width=\"20%\" colspan=\"2\">&nbsp;"
						+ Html.BR()
						+ "Selected Titles"
						+ listProgramsOutlinesDesignedFor(conn,campus,kix,enableDelete,showPending)
						+ Html.BR()
						+ "</td></tr>");

		out.println("</table>");
		out.println("</form><br/>");
	}

	asePool.freeConnection(conn,"crsprg",user);

%>
</p>

<p align="left">
<table border="0" width="100%" id="table1">
	<tr>
		<td align="left">
			Instructions:
			<br/><br/>
			<ul>
			<li>Select Program, click 'Submit'</li>
			<li>Select Division, click 'Submit'</li>
			<li>Review listing of availalbe titles.</li>
			<li>Cick the linked title to indentify it as the program which this outline was designed for.</li>
			<li>To delete linked program from this outline, click the title of the program listed under 'Selected Titles' table</li>
			</ul>
		</td>
	</tr>
</table>
</p>

<%@ include file="../inc/footer.jsp" %>

<%!

	/**
	 * listProgramsOutlinesDesignedFor - use outline kix to collect all program kix for which the outline
	 *													was designed for.
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * @param	enableDelete
	 * @param	showPending
	 * <p>
	 * @return	String
	 */
	public static String listProgramsOutlinesDesignedFor(Connection conn,
																			String campus,
																			String kix,
																			boolean enableDelete,
																			boolean showPending){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String programKix = "";
		String rowColor = "";
		String historyid = "";

		String deleteColumn = "";
		String aHrefStart = "";
		String aHrefEnd = "";
		String link = "";

		boolean pending = false;
		String sPending = "";

		boolean found = false;

		int j = 0;
		int id = 0;

		try{
			 String ProgramLinkedToOutlineRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ProgramLinkedToOutlineRequiresApproval");

			if (enableDelete){
				deleteColumn = ",historyid,id ";
				aHrefStart = "<a href=\"crsprg.jsp?lid=_LINK_&src="+Constant.COURSE_PROGRAM+"\" class=\"linkcolumn\">";
				aHrefEnd = "</a>";
			}

			String sql = "SELECT grading,pending " + deleteColumn +
					" FROM tblExtra" +
					" WHERE campus=? " +
					" AND historyid=? " +
					" AND src='"+Constant.COURSE_PROGRAM+"'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				link = "";

				programKix = AseUtil.nullToBlank(rs.getString("grading"));
				pending = rs.getBoolean("pending");

				if (enableDelete){
					historyid = AseUtil.nullToBlank(rs.getString("historyid"));
					id = rs.getInt("id");
					link = aHrefStart.replace("_LINK_",historyid + "&id=" + id + "&ack=r&kix=" + kix);
				}

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				Programs program = ProgramsDB.getProgram(conn,campus,programKix);
				if (program != null){
					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\">" + program.getDegreeDescr() + "</td>");
					listings.append("<td class=\"datacolumn\">" + program.getDivisionDescr() + "</td>");
					listings.append("<td class=\"datacolumn\">" + link + program.getTitle() + aHrefEnd + "</td>");

					if (showPending && (Constant.ON).equals(ProgramLinkedToOutlineRequiresApproval))
						listings.append("<td class=\"datacolumn\">" + sPending + "</td>");

					listings.append("</tr>");
				}
				program = null;
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr height=\"30\" bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">" +
					"<td class=\"textblackTH\">Program</td>" +
					"<td class=\"textblackTH\">Division</td>" +
					"<td class=\"textblackTH\">Title</td>";

				if (showPending && (Constant.ON).equals(ProgramLinkedToOutlineRequiresApproval))
					listing += "<td valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>";

				listing += "</tr>" +
								listings.toString() +
								"</table>";
			}
			else{
				listing = "";
			}
		}
		catch( SQLException e ){
			//logger.fatal("Helper: listProgramsOutlinesDesignedFor - " + e.toString());
		}
		catch( Exception ex ){
			//logger.fatal("Helper: listProgramsOutlinesDesignedFor - " + ex.toString());
		}

		return listing;
	}

%>

</body>
</html>