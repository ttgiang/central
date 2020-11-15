<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "MARIAB";
	String task = "Modify_outline";
	String kix = "k23a27k9188";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(getLinkedMaxtrixContent(request,conn,kix,user,false,true));
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String getLinkedMaxtrixContent(HttpServletRequest request,
																Connection conn,
																String kix,
																String user,
																boolean print,
																boolean compressed) throws SQLException {

Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		String temp = "";
		String sql = "";
		StringBuffer buf = new StringBuffer();

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String campus = info[4];

		// linked items
		String[] linked = LinkedUtil.GetLinkedItems(conn,campus);
		String[] linkedItem = linked[0].split(",");
		String[] linkedKey = linked[1].split(",");

		int linkedItemCount = 0;
		int i = 0;

		String src = website.getRequestParameter(request,"src","",false);
		String dst = website.getRequestParameter(request,"dst","",false);

		String srcName = "";
		String dstName = "";

		String dstFromSrc = null;
		String linkedDst = null;
		String[] aLinkedDst = null;

		try{
			MiscDB.deleteStickyMisc(conn,kix,user);

			HttpSession session = request.getSession(true);

			String currentTab = (String)session.getAttribute("aseCurrentTab");
			String currentNo = (String)session.getAttribute("asecurrentSeq");

			// print out header line (items for linking)
			buf.append("<form name=\"aseForm\" method=\"post\" action=\"/central/servlet/linker?arg=lnk3\">");
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=\"0\" cellpadding=\"8\">");
			buf.append("<tr><td class=\"textblackTHNoAlignment\" width=\"15%\">Based Outline Items:</td>");
			buf.append("<td class=\"textblackTHNoAlignment\" width=\"65%\">");
			for (i=0;i<linkedItem.length;i++){
				if (src.equals(linkedKey[i])){
					buf.append(linkedItem[i]);
					srcName = linkedItem[i];
				}
				else
					buf.append("<a href=\"?src="+linkedKey[i]+"&kix="+kix+"\" class=\"linkcolumn\">" + linkedItem[i] + "</a>");

				if (i < linkedItem.length - 1)
					buf.append("&nbsp;&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;&nbsp;");
			}
			buf.append("</td>");
			buf.append("<td width=\"20%\" nowrap align=\"right\"><a href=\"crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>&nbsp;&nbsp;</td></tr>");
			buf.append("</table>");

			// items that are linked to src
			linkedDst = LinkedUtil.GetLinkedKeys(conn,campus,src);
			if (linkedDst != null && linkedDst.length() > 0){
				aLinkedDst = linkedDst.split(",");
				buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=\"0\" cellpadding=\"8\">");
				buf.append("<tr><td class=\"textblackTHNoAlignment\" width=\"15%\">Linked Outline Items:</td>");
				buf.append("<td class=\"textblackTHNoAlignment\">");
				for (i=0;i<aLinkedDst.length;i++){
					dstFromSrc = LinkedUtil.GetKeyNameFromDst(conn,aLinkedDst[i]);

					if (dst.equals(aLinkedDst[i])){
						buf.append(dstFromSrc);
						dstName = dstFromSrc;
					}
					else
						buf.append("<a href=\"?kix="+kix+"&src="+src+"&dst="+aLinkedDst[i]+"\" class=\"linkcolumn\">" + dstFromSrc + "</a>");

					if (i < aLinkedDst.length - 1)
						buf.append("&nbsp;&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;&nbsp;");
				}
				buf.append("</td></tr>");
				buf.append("</table>");

				buf.append("<fieldset class=\"FIELDSET100\">"
					+ "<legend>Linking "+dstName+" to "+srcName+"</legend>"
					+ showLinkedMatrixContents(request,conn,kix,src,srcName,dst,dstName,print,compressed)
					+ "</fieldset>");

			} // linkedDst

			buf.append("</form>");

			temp = buf.toString() + MiscDB.getStickyNotes(conn,kix,user);

		} catch (Exception e) {
			logger.fatal("LinkedUtil: getLinkedMaxtrixContent - " + e.toString());
		}

		return temp;
	}

	/**
	 * showLinkedMatrixContents - returns sql for linked src
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	src			String
	 * @param	srcName		String
	 * @param	dst			String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	compressed	boolean
	 * <p>
	 * @return	String
	 */
	public static String showLinkedMatrixContents(HttpServletRequest request,
																	Connection conn,
																	String kix,
																	String src,
																	String srcName,
																	String dst,
																	String dstName,
																	boolean print,
																	boolean compressed) throws Exception {

Logger logger = Logger.getLogger("test");

		String temp = "";
		StringBuffer buffer = new StringBuffer();

		HttpSession session = request.getSession(true);

		String currentTab = (String)session.getAttribute("aseCurrentTab");
		String currentNo = (String)session.getAttribute("asecurrentSeq");

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try {
			session.setAttribute("aseLinker", Encrypter.encrypter("kix="+kix+","+"src="+src+","+"dst="+dst+","+"user="+user));

			buffer.append(showLinkedMatrixContentsX(conn,campus,kix,src,srcName,dst,dstName,print,currentTab,currentNo,user,compressed));

		} catch (SQLException ex) {
			logger.fatal("LinkedUtil: showLinkedMatrixContents - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("LinkedUtil: showLinkedMatrixContents - " + e.toString());
		}

		temp = buffer.toString();
		temp = temp.replace("border=\"0\"","border=\"1\"");

		return temp;
	}

	/**
	 * showLinkedMatrixContentsX - returns sql for linked src
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	src			String
	 * @param	srcName		String
	 * @param	dst			String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	currentTab	String
	 * @param	currentNo	String
	 * @param	user			boolean
	 * @param	compressed	boolean
	 * <p>
	 * @return	String
	 */
	public static String showLinkedMatrixContentsX(Connection conn,
																	String campus,
																	String kix,
																	String src,
																	String srcName,
																	String dst,
																	String dstName,
																	boolean print,
																	String currentTab,
																	String currentNo,
																	String user,
																	boolean compressed) throws Exception {

Logger logger = Logger.getLogger("test");

		String rowColor = "";
		String sql = "";
		String temp = "";
		String img = "";
		String dstFullName = "";
		String longcontent = "";
		StringBuffer buffer = new StringBuffer();
		StringBuffer connected = new StringBuffer();

		int ix = 0;
		int jy = 0;

		int i = 0;
		int j = 0;
		int rowsAffected = 0;

		String columnTitle = "";
		String stickyName = "";
		String tempSticky = "";
		String stickyRow = null;
		StringBuilder stickyBuffer = new StringBuilder();

		boolean found = false;
		boolean foundLink = false;

		String linked = "";
		String checked = "";
		String field = "";
		String selected = "";
		String thisKey = "";

		/*
			variables for use with creating legend. the top most row will be like excel where
			columns start with A-Z then AA, AB, and so on. To make this happen, a loop
			runs for as many items to display. with each 26 count, the start character will
			be the next in the series of alphabet. For example, for the first 26, they are shown
			as they are (A-Z). The second round starts of with aALPHABETS[iteration] where
			iteration = 0 or the letter A (AA-AZ). The next round or third round follows the
			same pattern by getting aALPHABETS[iteration+1] or BA - BZ.
		*/
		int alphaCounter = 0;
		int iteration = 0;
		String chars = "";

		try {
			AseUtil aseUtil = new AseUtil();

			stickyName = "sticky"+src + "_" + dst;

//HERE
String[] xAxis = getSrcData(conn,campus,kix,src,"descr");
			String[] xiAxis = SQLValues.getSrcData(conn,campus,kix,src,"key");

String[] yAxis = getDstData(conn,campus,kix,dst,"descr");
			String[] yiAxis = SQLValues.getDstData(conn,campus,kix,dst,"key");

			// used for popup help
			columnTitle = dstName;
			stickyRow = "<div id=\""+stickyName+"<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br/><| DESCR |></div>";

			String[] aALPHABETS = (Constant.ALPHABETS).split(",");

if (xAxis == null) System.out.println("1");
if (xiAxis == null) System.out.println("2");
if (yAxis == null) System.out.println("3");
if (yiAxis == null) System.out.println("4");

			if (xAxis!=null && yAxis!=null && yiAxis != null){

				found = true;

				buffer.append("<br/>");
				buffer.append(Constant.TABLE_START);

				// print header row
				buffer.append("<tr height=\"20\" bgcolor=\"#e1e1e1\">");
				buffer.append("<td class=\"textblackth\" valign=\"top\">");
				buffer.append("&nbsp;"+srcName+"/"+dstName+"");
				buffer.append("</td>");

				for(i=0;i<yAxis.length;i++){

					if (i > 25 && alphaCounter > 25){
						alphaCounter = 0;
						chars = aALPHABETS[iteration++];
					}

					if (compressed)
						buffer.append("<td class=\"dataColumnCenter\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" +  chars + aALPHABETS[alphaCounter] + Constant.TABLE_CELL_END);
					else
						buffer.append("<td class=\"dataColumnCenter\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" + yAxis[i] + Constant.TABLE_CELL_END);

					tempSticky = stickyRow;
					tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
					tempSticky = tempSticky.replace("<| STICKY |>",""+i);
					stickyBuffer.append(tempSticky);

					++alphaCounter;
				}

				buffer.append(Constant.TABLE_ROW_END);

				// print detail row
				for(i=0;i<xAxis.length;i++){
					connected.setLength(0);

					ix = Integer.parseInt(xiAxis[i]);

					dstFullName = LinkedUtil.GetLinkedDestinationFullName(dst);
					if ("Objectives".equals(dstFullName))
						dstFullName = "SLO";

					// retrieve values saved to db
					if ((Constant.COURSE_OBJECTIVES).equals(dst)){
						if ((Constant.COURSE_COMPETENCIES).equals(src))
							selected = CompetencyDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else if ((Constant.COURSE_CONTENT).equals(src))
							selected = ContentDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else
							selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);
					}
					else
						selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);

					// make into CSV for proper indexOf search
					selected = "," + selected + ",";

					for(j=0;j<yAxis.length;j++){

						foundLink = false;

						thisKey = "," + yiAxis[j] + ",";

						if (selected.indexOf(thisKey) > -1)
							foundLink = true;

						if (print)
							if (foundLink)
								img = "<p align=center><img src='/central/images/images/checkmarkG.gif' border=\"0\" data-tooltip=\""+stickyName+""+j+"_"+i+"\"></p>";
							else
								img = "<p align=center>&nbsp;</p>";
						else{
							checked = "";
							if (foundLink)
								checked = "checked";

							field = ""+yiAxis[j]+"_"+xiAxis[i];

							img = "<p align=center>&nbsp;<input type=\"checkbox\" "+checked+" name=\""+field+"\" value=\"1\" data-tooltip=\""+stickyName+""+j+"_"+i+"\">&nbsp;</p>";
						}

						connected.append(Constant.TABLE_CELL_DATA_COLUMN
											+ img
											+ Constant.TABLE_CELL_END);

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br/><br/><b><u>Content</u></b><br/><br/>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);
						stickyBuffer.append(tempSticky);
					}

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					buffer.append(Constant.TABLE_CELL_DATA_COLUMN
										+ 	xAxis[i]
										+ 	Constant.TABLE_CELL_END);

					buffer.append(connected.toString());

					buffer.append(Constant.TABLE_ROW_END);
				} // for i;

				buffer.append(
					Constant.TABLE_END
					+ temp.replace("border=\"0\"","border=\"1\"")
					);

				if (!print){
					buffer.append(
						"<p align=\"right\">"
						+ "<input type=\"submit\" class=\"input\" name=\"aseSubmit\" value=\"Submit\" title=\"save data\">&nbsp;&nbsp;"
						+ "<input type=\"submit\" class=\"input\" name=\"aseCancel\" value=\"Cancel\" title=\"abort selected operation\" onClick=\"return cancelMatrixForm('"+kix+"','"+currentTab+"','"+currentNo+"')\">"
						+ "</p><hr size=\"1\" noshade>"
						);
				}

				if (compressed)
					buffer.append(Outlines.showLegend(yAxis));

				MiscDB.insertSitckyNotes(conn,kix,user,stickyBuffer.toString());
			} // xAxis!=null
			else{
				// there is data but not yet linked
				if (xAxis!=null){
					found = true;

					buffer.append("<br/>");
					buffer.append(Constant.TABLE_START);

					// print header row
					buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
					buffer.append(Constant.TABLE_CELL_HEADER_COLUMN);
					buffer.append(srcName);
					buffer.append(Constant.TABLE_CELL_END);
					buffer.append(Constant.TABLE_ROW_END);

					// print detail row
					for(i=0;i<xAxis.length;i++){
						if (i % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
						buffer.append("<td class=\"datacolumn\" valign=\"top\">"
											+ 	xAxis[i]
											+ 	Constant.TABLE_CELL_END);

						buffer.append(Constant.TABLE_ROW_END);
					} // for i;

					buffer.append(
						Constant.TABLE_END
						+ temp.replace("border=\"0\"","border=\"1\"")
						);
				}
			} // if data exists

		} catch (SQLException ex) {
			logger.fatal("LinkedUtil: showLinkedMatrixContentsX - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("LinkedUtil: showLinkedMatrixContentsX - " + e.toString());
		}

		if (found){
			temp = buffer.toString();
			temp = temp.replace("border=\"0\"","border=\"1\"");
		}

		return temp;
	}

	/*
	 * getSrcData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	item		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getSrcData(Connection conn,String campus,String kix,String src,String item) throws Exception {

Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;
		try {
			if (item.equals("descr")){
				if (src.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,"descr");
				else if (src.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = getTCompetency(conn,campus,kix,"descr");
				else if (src.equals(Constant.COURSE_GESLO))
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,"descr");
				else if (src.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,"descr");
				else if (src.equals(Constant.COURSE_METHODEVALUATION))
					returnedValues = SQLValues.getTINIMethodEval(conn,campus,kix,"descr");
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,src,"descr");
			}
			else{
				if (src.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,"key");
				else if (src.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = getTCompetency(conn,campus,kix,"key");
				else if (src.equals(Constant.COURSE_GESLO))
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,"key");
				else if (src.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,"key");
				else if (src.equals(Constant.COURSE_METHODEVALUATION))
					returnedValues = SQLValues.getTINIMethodEval(conn,campus,kix,"key");
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,src,"key");
			}

		} catch (SQLException ex) {
			logger.fatal("SQLValues: getSrcData - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getSrcData - " + e.toString());
		}

		return returnedValues;
	}

	public static String[] getTCompetency(Connection conn,String campus,String kix,String item) throws Exception {

Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			if ("key".equals(item))
				field = "seq";
			else
				field = "content";

			String sql = "SELECT " + field + " "
				+ "FROM tblCourseCompetency "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "ORDER BY rdr";
			String yprms[] = {campus,kix};
			String ydt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTCompetency - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTCompetency - " + e.toString());
		}

		return returnedValues;
	}

	/*
	 * getDstData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	item		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getDstData(Connection conn,String campus,String kix,String dst,String item) throws Exception {

Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

System.out.println(dst);

		try {
			if (item.equals("descr")){
				if (dst.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = SQLValues.getTCompetency(conn,campus,kix,"descr");
				else if (dst.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,"descr");
				else if (dst.equals(Constant.COURSE_GESLO))
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,"descr");
				else if (dst.equals(Constant.COURSE_METHODEVALUATION))
returnedValues = getTINIMethodEval(conn,campus,kix,"descr");
				else if (dst.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,"descr");
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,dst,"descr");
			}
			else{
				if (dst.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = SQLValues.getTCompetency(conn,campus,kix,"key");
				else if (dst.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,"key");
				else if (dst.equals(Constant.COURSE_GESLO))
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,"key");
				else if (dst.equals(Constant.COURSE_METHODEVALUATION))
					returnedValues = SQLValues.getTINIMethodEval(conn,campus,kix,"key");
				else if (dst.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,"key");
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,dst,"key");
			}

		} catch (SQLException ex) {
			logger.fatal("SQLValues: getDstData - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getDstData - " + e.toString());
		}

		return returnedValues;
	}

	public static String[] getTINIMethodEval(Connection conn,String campus,String kix,String item) throws Exception {

Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			AseUtil aseUtil = new AseUtil();

			// if method of evaluation has been selected, limit this list to only what was selected;
			// otherwise, show the entire list.
			String sql = "historyid=" + aseUtil.toSQL(kix,1);
			String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

			String field = "";

			if ("key".equals(item))
				field = "id";
			else
				field = "kdesc";

			if (methodEvaluation != null && methodEvaluation.length() > 0){

				if (methodEvaluation.startsWith(","))
					methodEvaluation = methodEvaluation.substring(1);

				sql = "SELECT " + field + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='MethodEval' "
					+ "AND id IN ("+methodEvaluation+") "
					+ "ORDER BY kdesc";
			}
			else{
				sql = "SELECT " + field + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='MethodEval' "
					+ "ORDER BY kdesc";
			}

System.out.println(sql);

			String yprms[] = {campus};
			String ydt[] = {"s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTINIMethodEval - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTINIMethodEval - " + e.toString());
		}

		return returnedValues;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>