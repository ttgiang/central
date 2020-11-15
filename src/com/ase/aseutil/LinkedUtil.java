/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static String drawLinkedItemMatrix(Connection conn,String campus) throws SQLException {
 *	public static String GetDstFromSrc(Connection conn,String src){
 *	public static String GetDstFromKeyName(Connection conn,String fullName){
 *	public static String GetKeyNameFromDst(Connection conn,String dst){
 *	public static String GetLinkedDestinationFullName(String dst){
 *	public static String[] GetLinkedItems(Connection conn,String campus)
 *	public static String GetLinkedKeysDST(Connection conn,String campus,String src){
 *	public static int getLinkedItemCount(Connection conn,String campus) throws Exception {
 * public static String GetLinkedKeys(Connection conn,String campus,String src)
 *	public static ArrayList GetLinkedListByDst(Connection conn,String campus,String kix,String src,String dst){
 * public static ResultSet GetLinkedResultSet(Connection conn,PreparedStatement ps,String campus,String kix,String src,int level1)
 *	public static String GetLinkedSQL(Connection conn,String campus,String kix,String src){
 *	public static int saveLinkedData(HttpServletRequest request,Connection conn,String campus,String src,
 *												String dst,String kix)
 *	public static String showLinkedItemReport(Connection conn,String kix,String src,String dst,int level1,int level2)
 *	public static int updateLinkedItemMatrix(HttpServletRequest request,Connection conn,String campus)
 *
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class LinkedUtil {

	static Logger logger = Logger.getLogger(LinkedUtil.class.getName());

	/**
	 * GetLinkedSQL - returns sql for linked src
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String getContentForEdit(HttpServletRequest request,
														Connection conn,
														String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		int i = 0;
		int j = 0;
		int id = 0;
		boolean linkItemFound = false;

		String sql = "";
		String shortContent = "";
		String content = "";
		String rowColor = "";

		// output string
		StringBuffer buf = new StringBuffer();

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String campus = info[4];

		// retrieved values from SQL
		int thisID = 0;
		String thisDescr = "";
		String thisSrc = "";
		String folderType = "";
		String linkedDst = "";
		String dstFromSrc = "";

		// linked items
		String[] linked = LinkedUtil.GetLinkedItems(conn,campus);
		String[] linkedItem = linked[0].split(",");
		String[] linkedKey = linked[1].split(",");
		int linkedItemCount = 0;

		// url values
		int level1 = website.getRequestParameter(request,"level1",0,false);
		int level2 = website.getRequestParameter(request,"level2",-1,false);
		String src = website.getRequestParameter(request,"src","",false);
		String dst = website.getRequestParameter(request,"dst","",false);
		String dst2 = "";
		String hasLinked = "";

		try {
			AseUtil aseUtil = new AseUtil();

			// print out header line (items for linking)
			buf.append("<table summary=\"\" id=\"tableGetContentForEdit_" + src + "_" + dst + "1\" border=\"0\" width=\"100%\" cellspacing=0 cellpadding=8>");
			buf.append("<tr><td class=\"textblackTHNoAlignment\">Linked Items:&nbsp;&nbsp;");
			for (i=0;i<linkedItem.length;i++){
				if (src.equals(linkedKey[i])){
					thisSrc = linkedItem[i];
					buf.append("<img src=\"../images/folder-open.gif\" border=\"\" alt=\""+thisSrc+"\"> " + linkedItem[i].toUpperCase());
				}
				else
					buf.append("<a href=\"?src="+linkedKey[i]+"&kix="+kix+"\" class=\"linkcolumn\">" + linkedItem[i] + "</a>");

				if (i < linkedItem.length-1)
					buf.append("&nbsp;&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;&nbsp;");
			}
			buf.append("</td>");
			buf.append("<td>"
				+ "<a href=\"crsedt.jsp?kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/viewcourse.gif\" alt=\"return to outline modification\" title=\"return to outline modification\"></a>&nbsp;&nbsp;&nbsp;"
				+ "<a href=\"crslnkdxy.jsp?kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/printer.gif\" alt=\"printer linked item report\" title=\"printer friendly linked report\"></a>"
				+ "</td></tr>");
			buf.append("</table><hr size=\"1\">");

			if (!src.equals(Constant.BLANK)){

				buf.append("<table summary=\"\" id=\"tableGetContentForEdit_" + src + "_" + dst + "2\" border=\"0\" width=\"100%\" cellspacing=0 cellpadding=8>");

				PreparedStatement ps = null;
				ResultSet rs = LinkedUtil.GetLinkedResultSet(conn,ps,campus,kix,src,0);
				while (rs.next()) {
					linkItemFound = true;

					// these are based items (items that other items are linked to)
					thisID = rs.getInt("thisID");
					thisDescr = aseUtil.nullToBlank(rs.getString("thisDescr"));

					if (j++ % 2 != 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					if (level1 == thisID)
						folderType = "open";
					else
						folderType = "close";

					// draw top level linked item (src)
					buf.append("<tr bgcolor=\"" + rowColor + "\">"
						+ "<td width=\"02%\" valign=\"top\" class=\"class=\"datacolumn\"\">"
						+ "<a href=\"?src="+src+"&kix="+kix+"&level1="+thisID+"\" class=\"linkcolumn\">"
						+ "<img src=\"../images/folder-"+folderType+".gif\" border=\"\" alt=\"expand/collapse "+thisSrc+"\">"
						+ "</a>"
						+ "</td>"
						+ "<td valign=\"top\" class=\"class=\"datacolumn\"\" colspan=\"3\">"
						+ "<a href=\"crslnkdxw.jsp?src="+src+"&kix="+kix+"&level1="+thisID+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\">"+thisDescr+"</a>&nbsp;&nbsp;"
						+ "</td></tr>");

					// draw the linked to items (dst), however, do not including the src item (src=dst)
					// and that the dst is what the campus wants linked
					if (level1 == thisID){

						// items that are linked to SRC
						linkedDst = LinkedUtil.GetLinkedKeys(conn,campus,src);
						dstFromSrc = LinkedUtil.GetKeyNameFromDst(conn,dst);

						String[] linkedDstArray = linkedDst.split(",");
						linkedItemCount = linkedDstArray.length;

						for (i=0;i<linkedItemCount;i++){

							dst2 = LinkedUtil.GetLinkedDestinationFullName(linkedDstArray[i]);

							// if the id matches what we want, expand to lower level data
							if (i==level2){
								String[] rtn = new String[3];
								rtn = LinkerDB.getLinkedData(conn,campus,src,dst2,kix,thisID,true,false);

								if (rtn[2] != null && rtn[2].length() > 0){
									buf.append("<tr>"
										+ "<td width=\"02%\">&nbsp;</td>"
										+ "<td width=\"05%\">&nbsp;</td>"
										+ "<td width=\"02%\">"
										+ "<img src=\"../images/right-arrow.gif\" border=\"\" alt=\"expand\">"
										+ "</td>"
										+ "<td valign=\"top\" class=\"class=\"datacolumn\"\" colspan=\"2\">"
										+ dst2.replace("Objectives","Course SLO")
										+ "</td></tr>");

									buf.append("<tr>"
										+ "<td width=\"02%\">&nbsp;</td>"
										+ "<td width=\"05%\">&nbsp;</td>"
										+ "<td width=\"02%\">&nbsp;</td>"
										+ "<td style=\"border-collapse: collapse; border-style: solid; border-width: 1\" bgcolor=\"#e5f1f4\" valign=\"top\" class=\"class=\"datacolumn\"\" class=\"inputRequired\" colspan=\"2\">"
										+ "<form name=\"aseForm\" method=\"post\" action=\"/central/servlet/linker?arg=lnk2\">"
										+ rtn[2].replace("Objectives","Course SLO")
										+ "<hr size=\"1\">"
										+ "<input type=hidden value=\""+rtn[0]+"\" name=\"totalKeys\">"
										+ "<input type=hidden value=\""+rtn[1]+"\" name=\"allKeys\">"
										+ "<input type=hidden value=\""+kix+"\" name=\"kix\">"
										+ "<input type=hidden value=\""+src+"\" name=\"src\">"
										+ "<input type=hidden value=\""+dstFromSrc+"\" name=\"dst\">"
										+ "<input type=hidden value=\""+thisID+"\" name=\"keyid\">"
										+ "<input type=hidden value=\""+alpha+"\" name=\"alpha\">"
										+ "<input type=hidden value=\""+num+"\" name=\"num\">"
										+ "<input type=hidden value=\""+campus+"\" name=\"campus\">"
										+ "<input type=hidden value=\""+level1+"\" name=\"level1\">"
										+ "<input type=hidden value=\""+level2+"\" name=\"level2\">"
										+ "<input type=hidden value=\"c\" name=\"formAction\">"
										+ "<input type=hidden value=\"aseForm\" name=\"formName\">"
										+ "<input title=\"save selection(s)\" type=\"submit\" name=\"aseSubmit\" value=\"Save\" class=\"inputsmallgray\" onClick=\"return checkForm('s')\">&nbsp;"
										+ "</form>"
										+ "</td></tr>");
								}
								else
									buf.append("<tr>"
										+ "<td width=\"02%\">&nbsp;</td>"
										+ "<td width=\"05%\">&nbsp;</td>"
										+ "<td valign=\"top\" class=\"class=\"datacolumn\"\" class=\"inputRequired\" colspan=\"3\">"
										+ "<fieldset class=\"FIELDSETBLUE\">"
										+ "<legend>"+linkedItem[i]+"</legend>"
										+ "<form name=aseForm method=Post>"
										+ "<br/>linked item not available"
										+ "</forn>"
										+ "</fieldset>"
										+ "</td></tr>");
							}
							else{
								buf.append("<tr>"
									+ "<td width=\"02%\">&nbsp;</td>"
									+ "<td width=\"05%\">&nbsp;</td>"
									+ "<td width=\"02%\">"
									+ "<a href=\"?src="+src+"&dst="+linkedDstArray[i]+"&kix="+kix+"&level1="+thisID+"&level2="+i+"\" class=\"linkcolumn\">"
									+ "<img src=\"../images/right-arrow.gif\" border=\"\" alt=\"expand\">"
									+ "</a>"
									+ "</td>"
									+ "<td valign=\"top\" class=\"class=\"datacolumn\"\" colspan=\"2\">"
									+ dst2.replace("Objectives","Course SLO")
									+ "</td></tr>");
							}	// leve2 = id
						}	// for
					}	// level1 == thisID
				} // while

				if (!linkItemFound){
					buf.append("<tr>"
						+ "<td colspan=\"04\">linked item not available</td></tr>");
				}

				buf.append("</table>");

				rs.close();
			} // src not empty
		} catch (SQLException se) {
			logger.fatal("ContentDB: getContentForEdit - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ContentDB: getContentForEdit - " + e.toString());
		}

		return buf.toString();
	}

	/**
	 * getLinkedMaxtrixContent - returns sql for linked src
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	user			String
	 * @param	print			boolean
	 * @param	compressed	boolean
	 * <p>
	 * @return	String
	 */
	public static String getLinkedMaxtrixContent(HttpServletRequest request,
																Connection conn,
																String kix,
																String user,
																boolean print,
																boolean compressed) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		String temp = "";
		String sql = "";
		StringBuffer buf = new StringBuffer();

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String campus = info[4];

		// linked items
		String[] linked = LinkedUtil.GetLinkedItems(conn,campus);
		String[] linkedItem 	= linked[0].split(",");
		String[] linkedKey 	= linked[1].split(",");

		int linkedItemCount = 0;
		int i = 0;

		String src = website.getRequestParameter(request,"src","",false);
		String dst = website.getRequestParameter(request,"dst","",false);

		String srcName = "";
		String dstName = "";

		String dstFromSrc = null;
		String linkedDst = null;
		String[] aLinkedDst = null;

		boolean missionStatement = false;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"LinkedUtil");

			if (debug) logger.info("----------------- getLinkedMaxtrixContent - START");

			missionStatement = StmtDB.statementExists(conn,campus,"MissionStatement");

			MiscDB.deleteStickyMisc(conn,kix,user);

			HttpSession session = request.getSession(true);

			AseUtil aseUtil = new AseUtil();

			// do we return to raw edit or course edit
			String caller = aseUtil.getSessionValue(session,"aseCallingPage");
			if(!caller.equals("crsfldy")){
				caller = "crsedt";
			}

			aseUtil = null;

			String currentTab = (String)session.getAttribute("aseCurrentTab");
			String currentNo = (String)session.getAttribute("asecurrentSeq");

			// print out header line (items for linking)
			buf.append("<form name=\"aseForm\" method=\"post\" action=\"/central/servlet/linker?arg=lnk3\">");
			buf.append("<table summary=\"\" id=\"tableGetLinkedMaxtrixContent1\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"8\">");

			buf.append("<tr>"
						+ "<td colspan=\"2\" align=\"right\">");

			if (missionStatement){
				buf.append("<a href=\"vwstmt.jsp?id=MissionStatement\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin','620','600','yes','center');return false\" onfocus=\"this.blur()\">view mission statement</a><font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>");
			}

			if(caller.equals("crsedt")){
				buf.append("<a href=\"crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>");
			}
			else{
				buf.append("<a href=\"crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>");
			}

			buf.append("&nbsp;&nbsp;"
						+ "</td>"
						+ "</tr>");

			buf.append("<tr><td class=\"textblackTHNoAlignment\" width=\"20%\">Based Outline Items:</td>");
			buf.append("<td class=\"textblackTHNoAlignment\" width=\"80%\">");
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
			buf.append("</td></tr></table>");

			// items that are linked to src (matrix items)
			linkedDst = LinkedUtil.GetLinkedKeys(conn,campus,src);
			if (linkedDst != null && linkedDst.length() > 0){
				aLinkedDst = linkedDst.split(",");
				buf.append("<table summary=\"\" id=\"tableGetLinkedMaxtrixContent2\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"8\">");
				buf.append("<tr><td class=\"textblackTHNoAlignment\" width=\"20%\">Linked Outline Items:</td>");
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

			// after data is used (in line above), we can delete
			MiscDB.deleteStickyMisc(conn,kix,user);

			if (debug) logger.info("----------------- getLinkedMaxtrixContent - END");

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

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		StringBuffer buffer = new StringBuffer();

		HttpSession session = request.getSession(true);

		String currentTab = (String)session.getAttribute("aseCurrentTab");
		String currentNo = (String)session.getAttribute("asecurrentSeq");

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try {
			session.setAttribute("aseLinker", Encrypter.encrypter("kix="+kix+","+"src="+src+","+"dst="+dst+","+"user="+user));

			AseUtil aseUtil = new AseUtil();

			String caller = aseUtil.getSessionValue(session,"aseCallingPage");

			aseUtil = null;

			buffer.append(showLinkedMatrixContentsX(conn,
																campus,
																kix,
																src,srcName,
																dst,dstName,
																print,
																currentTab,currentNo,
																user,
																compressed,
																caller));

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
	 * @param	caller		String
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

		return showLinkedMatrixContentsX(conn,
													campus,
													kix,
													src,
													srcName,
													dst,
													dstName,
													print,
													currentTab,
													currentNo,
													user,
													compressed,
													"");
	}

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
																	boolean compressed,
																	String caller) throws Exception {

		//Logger logger = Logger.getLogger("test");

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

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"LinkedUtil");

			if (debug) {
				logger.info("------------------------- showLinkedMatrixContentsX - START");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("src: " + src + " - " + srcName);
				logger.info("dst: " + dst + " - " + dstName);
			}

			String server = SysDB.getSys(conn,"server");

			AseUtil aseUtil = new AseUtil();

			stickyName = "sticky"+src + "_" + dst;
			if (debug) logger.info("stickyName: " + stickyName);

			String[] xAxis = SQLValues.getSrcData(conn,campus,kix,src,"descr");
			String[] xiAxis = SQLValues.getSrcData(conn,campus,kix,src,"key");

			String[] yAxis = SQLValues.getDstData(conn,campus,kix,dst,"descr");
			String[] yiAxis = SQLValues.getDstData(conn,campus,kix,dst,"key");

			// used for popup help
			columnTitle = dstName;
			stickyRow = "<div id=\""+stickyName+"<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br/><| DESCR |></div>";

			String[] aALPHABETS = (Constant.ALPHABETS).split(",");

			if (xAxis!=null && yAxis!=null && yiAxis != null){

				if (debug) logger.info("valid data found - " + stickyName);

				found = true;

				buffer.append("<br/>");
				buffer.append("<table summary=\"\" id=\"tableShowLinkedMatrixContentsX_" + src + "_" + dst + "1\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");

				// print header row
				buffer.append("<tr height=\"20\" bgcolor=\"#e1e1e1\">");
				buffer.append("<td class=\"textblackth\" valign=\"top\">");
				buffer.append("&nbsp;"+srcName+"/"+dstName+"");
				buffer.append("</td>");

				// draw top row or column header (legend)
				for(i=0;i<yAxis.length;i++){

					if (i > 25 && alphaCounter > 25){
						alphaCounter = 0;
						chars = aALPHABETS[iteration++];
					}

					if (compressed){
						buffer.append("<td class=\"class=\"datacolumn\"Center\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" +  chars + aALPHABETS[alphaCounter] + "</td>");
					}
					else{
						buffer.append("<td class=\"class=\"datacolumn\"Center\" valign=\"top\" width=\"03%\" data-tooltip=\""+stickyName+""+i+"\">" + yAxis[i] + "</td>");
					}

					tempSticky = stickyRow;
					tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
					tempSticky = tempSticky.replace("<| STICKY |>",""+i);
					stickyBuffer.append(tempSticky);

					++alphaCounter;
				} // for

				buffer.append("</tr>");

				if (debug) logger.info("column header printed");

				// print detail row
				for(i=0;i<xAxis.length;i++){

					connected.setLength(0);

					ix = Integer.parseInt(xiAxis[i]);

					dstFullName = GetLinkedDestinationFullName(dst);
					if (dstFullName.equals("Objectives"))
						dstFullName = "SLO";

					// retrieve values saved to db
					if (dst.equals(Constant.COURSE_OBJECTIVES)){
						if (src.equals(Constant.COURSE_COMPETENCIES))
							selected = CompetencyDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else if (src.equals(Constant.COURSE_CONTENT))
							selected = ContentDB.getSelectedSLOs(conn,kix,xiAxis[i]);
						else
							selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);
					}
					else{
						selected = LinkerDB.getSelectedLinkedItem(conn,kix,src,dstFullName,ix);
					}

					// make into CSV for proper indexOf search
					selected = "," + selected + ",";

					for(j=0;j<yAxis.length;j++){

						foundLink = false;

						thisKey = "," + yiAxis[j] + ",";

						if (selected.indexOf(thisKey) > -1){
							foundLink = true;
						}

						if (print){
							if (foundLink)
								img = "<p align=\"center\"><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" data-tooltip=\""+stickyName+""+j+"_"+i+"\" /></p>";
							else
								img = "<p align=\"center\">&nbsp;</p>";
						}
						else{
							checked = "";
							if (foundLink)
								checked = "checked";

							field = ""+yiAxis[j]+"_"+xiAxis[i];

							img = "<p align=\"center\">&nbsp;<input type=\"checkbox\" "+checked+" name=\""+field+"\" value=\"1\" data-tooltip=\""+stickyName+""+j+"_"+i+"\">&nbsp;</p>";
						}

						connected.append(Constant.TABLE_CELL_DATA_COLUMN
											+ img
											+ "</td>");

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br/><br/><b><u>"+srcName+"</u></b><br/><br/>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);

						stickyBuffer.append(tempSticky);
					}

					if (debug) logger.info("append to output buffer");

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					buffer.append(Constant.TABLE_CELL_DATA_COLUMN
										+ 	xAxis[i]
										+ 	"</td>");

					buffer.append(connected.toString());

					buffer.append("</tr>");
				} // for i;

				buffer.append("</table>"
									+ temp.replace("border=\"0\"","border=\"1\"")
									);

				if (!print){
					buffer.append(
						"<p align=\"right\">"
						+ "<input type=\"submit\" class=\"input\" name=\"aseSubmit\" value=\"Submit\" title=\"save data\">&nbsp;&nbsp;"
						+ "<input type=\"submit\" class=\"input\" name=\"aseCancel\" value=\"Cancel\" title=\"abort selected operation\" onClick=\"return cancelMatrixForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"')\">"
						+ "</p><hr size=\"1\" noshade>"
						);
				}

				if (compressed){
					buffer.append(Outlines.showLegend(yAxis));
				}

				MiscDB.insertSitckyNotes(conn,kix,user,stickyBuffer.toString());
			} // if data exists
			else{
				// there is data but not yet linked
				if (debug) logger.info("no valid data found");

				if (xAxis!=null){

					if (debug) logger.info("printing x axis only");

					found = true;

					buffer.append("<br/>");
					buffer.append("<table summary=\"\" id=\"tableShowLinkedMatrixContentsX_" + src + "_" + dst + "2\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");

					// print header row
					buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT)
							.append(Constant.TABLE_CELL_HEADER_COLUMN)
							.append(srcName)
							.append("</td>")
							.append("</tr>");

					// print detail row
					for(i=0;i<xAxis.length;i++){
						if (i % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						buffer.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
						buffer.append("<td class=\"datacolumn\" valign=\"top\">" + xAxis[i] + "</td>");

						buffer.append("</tr>");
					} // for i;

					buffer.append(
						"</table>"
						+ temp.replace("border=\"0\"","border=\"1\"")
						);
				}
			} // if data exists

			if (debug) logger.info("------------------------- showLinkedMatrixContentsX - END");

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

	/**
	 * printLinkedMaxtrixContent - returns sql for linked src
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	src			String
	 * @param	user			String
	 * @param	print			boolean
	 * @param	compressed 	boolean
	 * <p>
	 * @return	String
	 */
	public static String printLinkedMaxtrixContent(Connection conn,
																	String kix,
																	String src,
																	String user,
																	boolean print,
																	boolean compressed) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String campus = info[4];

		int j = 0;

		int getDstDataCount = 0;

		String srcName = "";
		String dst = "";
		String dstName = "";
		String linkedDst = "";
		String temp = "";
		String[] aLinkedDst = null;
		StringBuffer buf = new StringBuffer();

		String hideIncompleteLinkedItems = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","hideIncompleteLinkedItems");

		try{
			srcName = LinkedUtil.GetLinkedItemDescr(conn,src);
			linkedDst = LinkedUtil.GetLinkedKeys(conn,campus,src);
			if (linkedDst != null && linkedDst.length() > 0){
				aLinkedDst = linkedDst.split(",");
				for (j=0;j<aLinkedDst.length;j++){
					dst = aLinkedDst[j];

						dstName = GetKeyNameFromDst(conn,dst);

						getDstDataCount = SQLValues.getDstDataCount(conn,campus,kix,src,dst);

					// when the dst linked to item has no selection, don't display empty grid
					if (hideIncompleteLinkedItems.equals(Constant.ON) && getDstDataCount == 0){
						buf.append(showNonEstablishedLinks(srcName,dstName,true,compressed));
					}
					else{
						buf.append(showLinkedMatrixContentsX(conn,campus,kix,src,srcName,dst,dstName,true,"","",user,compressed));
					}

				} // for j
			}	// if
			else{
				buf.append(showLinkedMatrixContentsX(conn,campus,kix,src,srcName,"","",print,"","",user,compressed));
			}

		} catch (Exception e) {
			logger.fatal("LinkedUtil: printLinkedMaxtrixContent - " + e.toString());
		}

		temp = buf.toString();

		return temp;
	}

	/**
	 * GetLinkedSQL - returns sql for linked src
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedSQL(Connection conn,String campus,String kix,String src){

		String sql = "";

		try{
			AseUtil aseUtil = new AseUtil();

			if (src.equals(Constant.COURSE_COMPETENCIES)){
				sql = "SELECT seq AS thisID,content AS thisDescr "
					+ "FROM tblCourseCompetency "
					+ "WHERE historyid=?";
			}
			else if (src.equals(Constant.COURSE_OBJECTIVES)){
				sql = "SELECT compid AS thisID,comp AS thisDescr "
					+ "FROM tblCourseComp "
					+ "WHERE historyid=? "
					+ "ORDER BY rdr";
			}
			else if (src.equals(Constant.COURSE_GESLO)){
				sql = "SELECT id AS thisID,kid + ' - ' + kdesc AS thisDescr "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='GESLO' "
					+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
					+ "ORDER BY seq";
			}
			else if (src.equals(Constant.COURSE_METHODEVALUATION)){
				sql = "historyid=" + aseUtil.toSQL(kix,1);

				String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

				methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

				if (methodEvaluation != null && methodEvaluation.length() > 0){
					sql = "SELECT id AS thisID,kdesc AS thisDescr "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "AND id IN ("+methodEvaluation+") "
						+ "ORDER BY seq, kdesc";
				}
				else{
					sql = "SELECT id AS thisID,kdesc AS thisDescr "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "ORDER BY seq, kdesc";
				}
			}
			else if (src.equals(Constant.COURSE_PROGRAM_SLO) || src.equals(Constant.IMPORT_PLO)){
				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND src=? "
					+ "AND historyid=?";
			}
			else if (src.equals(Constant.COURSE_INSTITUTION_LO) || src.equals(Constant.IMPORT_ILO)){
				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND src=? "
					+ "AND historyid=?";
			}
			else if (src.equals(Constant.COURSE_CONTENT)){
				sql = "SELECT contentID AS thisID,LongContent AS thisDescr "
						+ "FROM tblCourseContent "
						+ "WHERE historyid=? "
						+ "ORDER BY rdr";
			}
		}
		catch(Exception e){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + e.toString());
		}

		return sql;
	}

	/**
	 * GetLinkedResultSet - returns sql for linked src
	 * <p>
	 * @param	conn		Connection
	 * @param	ps			PreparedStatement
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	level1	int
	 * <p>
	 * @return	ResultSet
	 */
	public static ResultSet GetLinkedResultSet(Connection conn,
																PreparedStatement ps,
																String campus,
																String kix,
																String src,
																int level1){

		String sql = "";
		String sqlSelect = "";
		ResultSet rs = null;

		try{

			String displayDescription = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowKeyDescsription");

			AseUtil aseUtil = new AseUtil();

			if (src.equals(Constant.COURSE_COMPETENCIES)){
				sql = "SELECT seq AS thisID,content AS thisDescr "
					+ "FROM tblCourseCompetency "
					+ "WHERE historyid=?";

				if (level1 > 0)
					sql += " AND seq="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}
			else if (src.equals(Constant.COURSE_OBJECTIVES)){
				sql = "SELECT compid AS thisID,comp AS thisDescr "
					+ "FROM tblCourseComp "
					+ "WHERE historyid=? ";

				if (level1 > 0)
					sql += "AND compid="+level1;

				sql += "ORDER BY rdr";

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}
			else if (src.equals(Constant.COURSE_GESLO)){

				if (displayDescription.equals("1"))
					sqlSelect = "kid AS thisDescr ";
				else if (displayDescription.equals("2"))
					sqlSelect = "kdesc AS thisDescr ";
				else if (displayDescription.equals("3"))
					sqlSelect = "kid + ' - ' + kdesc AS thisDescr ";

				sql = "SELECT id AS thisID, " + sqlSelect + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='GESLO' "
					+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
					+ "ORDER BY seq";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
			}
			else if (src.equals(Constant.COURSE_METHODEVALUATION)){
				sql = "historyid=" + aseUtil.toSQL(kix,1);

				String methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

				methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

				if (displayDescription.equals("1"))
					sqlSelect = "kid AS thisDescr ";
				else if (displayDescription.equals("2"))
					sqlSelect = "kdesc AS thisDescr ";
				else if (displayDescription.equals("3"))
					sqlSelect = "kid + ' - ' + kdesc AS thisDescr ";

				if (methodEvaluation != null && methodEvaluation.length() > 0){
					sql = "SELECT id AS thisID, " + sqlSelect + " "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "AND id IN ("+methodEvaluation+") "
						+ "ORDER BY seq, kdesc";
				}
				else{
					sql = "SELECT id AS thisID, " + sqlSelect + " "
						+ "FROM tblIni "
						+ "WHERE campus=? "
						+ "AND category='MethodEval' "
						+ "ORDER BY seq, kdesc";
				}
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else if (src.equals(Constant.COURSE_PROGRAM_SLO) || src.equals(Constant.IMPORT_PLO)){

				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND (src=? OR src=?) "
					+ "AND historyid=? ";

				if (level1 > 0)
					sql += "AND id="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_PROGRAM_SLO);
				ps.setString(3,Constant.IMPORT_PLO);
				ps.setString(4,kix);
			}
			else if (src.equals(Constant.COURSE_INSTITUTION_LO) || src.equals(Constant.IMPORT_ILO)){

				sql = "SELECT id AS thisID,comments AS thisDescr "
					+ "FROM tblGenericContent "
					+ "WHERE campus=? "
					+ "AND (src=? OR src=?) "
					+ "AND historyid=? ";

				if (level1 > 0)
					sql += "AND id="+level1;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_INSTITUTION_LO);
				ps.setString(3,Constant.IMPORT_ILO);
				ps.setString(4,kix);
			}
			else if (src.equals(Constant.COURSE_CONTENT)){
				sql = "SELECT contentID AS thisID,LongContent AS thisDescr "
						+ "FROM tblCourseContent "
						+ "WHERE historyid=? ";

				if (level1 > 0)
					sql += "AND contentID="+level1;

				sql += "ORDER BY rdr";

				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
			}

			rs = ps.executeQuery();
		}
		catch(SQLException s){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + s.toString() + "\n kix: " + kix);
		}
		catch(Exception e){
			logger.fatal("LinkedUtil - aLinkedUtil: GetLinkedSQL - " + e.toString() + "\n kix: " + kix);
		}

		return rs;
	}

	/**
	 * GetLinkedItemDescr - returns linked item
	 * <p>
	 * @param	conn	Connection
	 * @param	item	String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedItemDescr(Connection conn,String item){

		//Logger logger = Logger.getLogger("test");

		String linkedItem = "";

		try{
			String sql = "SELECT linkedItem FROM tblLinkeditem WHERE linkedkey=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				linkedItem = AseUtil.nullToBlank(rs.getString("linkedItem"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetLinkedItemDescr - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetLinkedItemDescr - " + ex.toString());
		}

		return linkedItem;
	}

	/**
	 * GetLinkedKeys - returns linked keys (dst)
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedKeys(Connection conn,String campus,String src){

		//Logger logger = Logger.getLogger("test");

		String dst = "";

		try{
			String sql = "SELECT linkeddst "
							+ "FROM tblLinkedKeys "
							+ "WHERE campus=? AND "
							+ "linkedsrc=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				dst = AseUtil.nullToBlank(rs.getString("linkeddst"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - aGetLinkedKeys - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - aGetLinkedKeys - " + ex.toString());
		}

		return dst;
	}

	/**
	 * GetLinkedItems - returns CSV of available items for linking.
	 *							if campus is empty, list all. with campus,
	 *							list only what was selected for campus to use.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String[] GetLinkedItems(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		boolean first = true;
		String[] rtn = new String[4];

		try{
			PreparedStatement ps = null;
			String sql = "";

			if (campus != null && campus.length() > 0){
				sql = "SELECT tli.linkedkey, tli.linkeditem, tli.linkeddst, tli.linkedtable "
					+ "FROM tblLinkedKeys tlk, tblLinkedItem tli "
					+ "WHERE tlk.campus=? "
					+ "AND tlk.linkedsrc = tli.linkedkey "
					+ "ORDER BY tli.linkeditem";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else{
				sql = "SELECT tli.linkedkey, tli.linkeditem, tli.linkeddst, tli.linkedtable "
					+ "FROM tblLinkedItem tli "
					+ "ORDER BY tli.linkeditem";
				ps = conn.prepareStatement(sql);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				if (first){
					rtn[0] = AseUtil.nullToBlank(rs.getString("linkeditem"));
					rtn[1] = AseUtil.nullToBlank(rs.getString("linkedkey"));
					rtn[2] = AseUtil.nullToBlank(rs.getString("linkeddst"));
					rtn[3] = AseUtil.nullToBlank(rs.getString("linkedtable"));
				}
				else{
					rtn[0] = rtn[0] + "," + AseUtil.nullToBlank(rs.getString("linkeditem"));
					rtn[1] = rtn[1] + "," + AseUtil.nullToBlank(rs.getString("linkedkey"));
					rtn[2] = rtn[2] + "," + AseUtil.nullToBlank(rs.getString("linkeddst"));
					rtn[3] = rtn[3] + "," + AseUtil.nullToBlank(rs.getString("linkedtable"));
				}

				first = false;
			}

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetLinkedItems - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetLinkedItems - " + ex.toString());
		}

		return rtn;
	}

	/**
	 * GetLinkedListByDst - returns an arraylist of linked data. Dst is fully spelt out words.
	 *								for example, Assess,GESLO,Competency,Content,MethodEval,Objectives,PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	dst		String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList GetLinkedListByDst(Connection conn,String campus,String kix,String src,String dst){

		//Logger logger = Logger.getLogger("test");

		ArrayList list = null;

		try{
			if ("Assess".equalsIgnoreCase(dst)){
				list = AssessDB.getAssessments(conn,campus);
			}
			else if ("GESLO".equalsIgnoreCase(dst)){
				list = GESLODB.getGESLOAndDescByCampus(conn,campus,kix);
			}
			else if ("Competency".equalsIgnoreCase(dst)){
				list = CompetencyDB.getCompetencyListByKix(conn,kix);
			}
			else if ("Content".equalsIgnoreCase(dst)){
				list = ContentDB.getContentsListByKix(conn,kix);
			}
			else if ("MethodEval".equalsIgnoreCase(dst)){
				list = IniDB.getLinkedByMethodEval(conn,campus,kix);
			}
			else if ("Objectives".equalsIgnoreCase(dst)){
				list = CompDB.getCompsByKix(conn,kix);
			}
			else if ("PSLO".equalsIgnoreCase(dst)){
				list = GenericContentDB.getContentByCampusKix(conn,campus,Constant.COURSE_PROGRAM_SLO,kix);
			}
			else if ("ILO".equalsIgnoreCase(dst)){
				list = GenericContentDB.getContentByCampusKix(conn,campus,Constant.COURSE_INSTITUTION_LO,kix);
			}
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - aGetLinkedListByDst - " + ex.toString());
		}

		return list;
	}

	/**
	 * GetLinkedDestinationFullName - returns destination name as for example,
	 * Assess,GESLO,Competency,Content,MethodEval,Objectives,PSLO
	 * <p>
	 * @param	dst		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedDestinationFullName(String dst){

		return Constant.GetLinkedDestinationFullName(dst);
	}

	/**
	 * saveLinkedData
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	dst		String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int saveLinkedData(HttpServletRequest request,
												Connection conn,
												String campus,
												String src,
												String dst,
												String kix,
												String user) {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		String sql = "";
		String temp = "";

		int oldID = 0;
		int keyid = 0;
		int rowsAffected = -1;
		int totalKeys = 0;

		String[] hiddenID = null;
		String allKeys = "";
		String formField = "";

		boolean found = false;

		PreparedStatement ps = null;

		try {

			debug = DebugDB.getDebug(conn,"LinkedUtil");

			if (debug) logger.info("LinkedUtil.saveLinkedData - ENTER");

			WebSite website = new WebSite();

			// link to SLO does a little differently because
			// SLO linking was designed ealier in a different way
			totalKeys = website.getRequestParameter(request,"totalKeys", 0);		// 4
			hiddenID = new String[totalKeys];												// array of 4
			allKeys = website.getRequestParameter(request,"allKeys");				// 559,556,558,557
			hiddenID = allKeys.split(",");													// array of four holding 559,556,558,557
			keyid = website.getRequestParameter(request, "keyid", 0);				// 128
			formField = "link_";

			// kix = G51i13d1057
			// src = x43
			// dst = GESLO

			// 1) get the link between main table tblCourseLinked and tblCourseLinked2 (id)
			// 2a) create the link if not there
			// 2b) delete existing linked entries before applying new
			// 3) add the new entries

			// Step 1
			oldID = LinkerDB.getLinkedID(conn,campus,kix,src,dst,keyid);
			if (debug) logger.info("LinkedUtil.saveLinkedData - oldID: " + oldID);

			if (oldID == 0){
				// Step 2a
				sql = "INSERT INTO tblCourseLinked (campus,historyid,src,seq,dst,auditby,auditdate,coursetype) VALUES(?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,keyid);
				ps.setString(5,dst);
				ps.setString(6,user);
				ps.setString(7,AseUtil.getCurrentDateTimeString());
				ps.setString(8,"PRE");
				rowsAffected = ps.executeUpdate();
				ps.close();
				oldID = LinkerDB.getLinkedID(conn,campus,kix,src,dst,keyid);
				if (debug) logger.info("LinkedUtil.saveLinkedData - oldID - 2a: " + oldID);
			}
			else{
				// Step 2b
				sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,oldID);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("LinkedUtil.saveLinkedData - oldID - 2b: " + oldID);
			}

			// Step 3
			// for all fields, check to see if it was checked. if yes, set to 1, else 0;
			// the final result is CSV of 0's and 1's of items that can be edited.
			rowsAffected= 0;
			sql = "INSERT INTO tblCourseLinked2(historyid,id,item,auditby) VALUES(?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for (int i = 0; i < totalKeys; i++) {
				temp = website.getRequestParameter(request, formField + hiddenID[i]);
				if (temp != null && !"".equals(temp)) {
					ps.setString(1,kix);
					ps.setInt(2,oldID);
					ps.setString(3,temp);
					ps.setString(4,user);
					rowsAffected += ps.executeUpdate();
					found = true;
				}
			}
			ps.close();
			if (debug) logger.info("LinkedUtil.saveLinkedData - oldID - 3: " + oldID);

			// if nothing was saved, delete from the link table
			if (!found){
				sql = "DELETE FROM tblCourseLinked "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,oldID);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("LinkedUtil.saveLinkedData - oldID - 4: " + oldID);
			}

			rowsAffected = 1;

		} catch(SQLException se){
			logger.fatal("LinkedUtil - saveLinkedData - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("LinkedUtil - saveLinkedData - " + e.toString());
		}

		if (debug) logger.info("LinkedUtil.saveLinkedData - EXIT");

		return rowsAffected;
	}

	/**
	 * saveLinkedData2
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	dst		String
	 * @param	kix		String
	 * @param	allKeys	String
	 * @param	keyid		int
	 * <p>
	 * @return	int
	 */
	public static int saveLinkedData2(Connection conn,
													String campus,
													String src,
													String dst,
													String kix,
													String user,
													String allKeys,
													int keyid) {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		String sql = "";
		String temp = "";

		int oldID = 0;
		int rowsAffected = -1;
		int rowsUpdated = 0;
		int totalKeys = 0;

		boolean found = false;

		String[] hiddenID = null;

		PreparedStatement ps = null;

		try {
			debug = DebugDB.getDebug(conn,"LinkedUtil");

			// link to SLO does a little differently because
			// SLO linking was designed ealier in a different way
			if (allKeys != null && allKeys.length() > 0){
				hiddenID = allKeys.split(",");
				totalKeys = hiddenID.length;
			}

			if (debug) {
				logger.info("------------------ LINKEDUTIL.SAVELINKEDDATA2 - START");
				logger.info("campus: " + campus);
				logger.info("src: " + src);
				logger.info("dst: " + dst);
				logger.info("kix: " + kix);
				logger.info("allKeys: " + allKeys);
				logger.info("totalKeys: " + totalKeys);
			}

			// 1) get the link between main table tblCourseLinked and tblCourseLinked2 (id)
			// 2a) create the link if not there
			// 2b) delete existing linked entries before applying new
			// 3) add the new entries

			// Step 1
			oldID = LinkerDB.getLinkedID(conn,campus,kix,src,dst,keyid);
			if (debug) logger.info("saveLinkedData2 - oldID: " + oldID);

			if (oldID == 0){
				// Step 2a
				sql = "INSERT INTO tblCourseLinked (campus,historyid,src,seq,dst,auditby,auditdate,coursetype) VALUES(?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,keyid);
				ps.setString(5,dst);
				ps.setString(6,user);
				ps.setString(7,AseUtil.getCurrentDateTimeString());
				ps.setString(8,"PRE");
				rowsAffected = ps.executeUpdate();
				ps.close();
				oldID = LinkerDB.getLinkedID(conn,campus,kix,src,dst,keyid);
				if (debug) logger.info("saveLinkedData2 - oldID - 2a: " + oldID);
			}
			else{
				// Step 2b
				sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,oldID);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("saveLinkedData2 - oldID - 2b: " + oldID);
			}

			// Step 3
			// for all fields, check to see if it was checked. if yes, set to 1, else 0;
			// the final result is CSV of 0's and 1's of items that can be edited.
			rowsAffected= 0;
			sql = "INSERT INTO tblCourseLinked2(historyid,id,item,auditby) VALUES(?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for (int i = 0; i < totalKeys; i++) {
				temp = hiddenID[i];
				if (temp != null && !"".equals(temp)) {
					ps.setString(1,kix);
					ps.setInt(2,oldID);
					ps.setString(3,temp);
					ps.setString(4,user);
					rowsUpdated += ps.executeUpdate();
					found = true;
				}
			}
			ps.close();
			if (debug) logger.info("saveLinkedData2 - oldID - 3: " + oldID);

			// if nothing was saved, delete from the link table
			if (!found){
				sql = "DELETE FROM tblCourseLinked "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,oldID);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("saveLinkedData2 - oldID - 4: " + oldID);
			}

			rowsAffected = 1;

			if (debug) logger.info("------------------ LINKEDUTIL.SAVELINKEDDATA2 - END");

		} catch(SQLException se){
			logger.fatal("LinkedUtil - saveLinkedData2 - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("LinkedUtil - saveLinkedData2 - " + e.toString());
		}

		return rowsUpdated;
	}

	/**
	 * GetDstFromSrc - returns the DST name from the src
	 * <p>
	 * @param	conn	Connection
	 * @param	src	String
	 * <p>
	 * @return	String
	 */
	public static String GetDstFromSrc(Connection conn,String src){

		//Logger logger = Logger.getLogger("test");

		String dst = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT linkeddst FROM tblLinkedItem WHERE linkedkey=?");
			ps.setString(1,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				dst = AseUtil.nullToBlank(rs.getString("linkeddst"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetDstFromSrc - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetDstFromSrc - " + ex.toString());
		}

		return dst;
	}

	/**
	 * GetKeyNameFromDst - returns the DST full name from the database table column name
	 * <p>
	 * @param	conn	Connection
	 * @param	dst	String
	 * <p>
	 * @return	String
	 */
	public static String GetKeyNameFromDst(Connection conn,String dst){

		//Logger logger = Logger.getLogger("test");

		String keyName = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT linkeddst FROM tblLinkedItem WHERE linkedkey=?");
			ps.setString(1,dst);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				keyName = AseUtil.nullToBlank(rs.getString("linkeddst"));
				keyName = keyName.replace("Objectives","Course SLO");
			}

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetKeyNameFromDst - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetKeyNameFromDst - " + ex.toString());
		}

		return keyName;
	}

	/**
	 * GetDstFromKeyName - returns the short name from the full name
	 * <p>
	 * @param	conn		Connection
	 * @param	fullName	String
	 * <p>
	 * @return	String
	 */
	public static String GetDstFromKeyName(Connection conn,String fullName){

		//Logger logger = Logger.getLogger("test");

		String dst = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT linkedkey FROM tblLinkedItem WHERE linkeddst=?");
			ps.setString(1,fullName);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				dst = AseUtil.nullToBlank(rs.getString("linkedkey"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetDstFromKeyName - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetDstFromKeyName - " + ex.toString());
		}

		return dst;
	}

	/**
	 * GetDstFromKeyName - returns the short name from the full name
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	src			String
	 * @param	dst			String
	 * @param	level1		int
	 * @param	level2		int
	 * @param	matchSrc		boolean
	 * <p>
	 * @return	String
	 */
	public static String showLinkedItemReport(Connection conn,
															String kix,
															String src,
															String dst,
															int level1,
															int level2,
															boolean matchSrc) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int id = 0;
		boolean linkItemFound = false;

		String sql = "";
		String shortContent = "";
		String content = "";
		String rowColor = "";
		String temp = "";

		// output string
		StringBuffer buf = new StringBuffer();

		// output string
		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String campus = info[4];

		// retrieved values from SQL
		int thisID = 0;
		String thisDescr = "";
		String thisSrc = "";
		String folderType = "";
		String linkedDst = "";
		String[] rtn = new String[3];

		// linked items by campus
		String[] linked = LinkedUtil.GetLinkedItems(conn,campus);
		String[] linkedItem = linked[0].split(",");			// Competency,Content,Course SLO,Program SLO
		String[] linkedKey = linked[1].split(",");			// X43,X19,X18,X72
		int linkedItemCount = linkedItem.length;

		String dst2 = "";

		int srcCounter = 0;
		int dstCounter = 0;
		String[] dstArray = null;

		boolean found = false;
		boolean processSrc = false;

		String savedSrc = src;

		try {
			AseUtil aseUtil = new AseUtil();

			for (srcCounter=0;srcCounter<linkedKey.length;srcCounter++){

				// if it's a report, we list the entire structure. If it's for popups, we only
				// show the source we wish to match
				processSrc = false;

				if (!matchSrc || (linkedKey[srcCounter]).equals(savedSrc)) {
					processSrc = true;
				}

				if (processSrc){

					// the master linked item (base item)
					src = linkedKey[srcCounter];

					// items linked to the base item
					linkedDst = LinkedUtil.GetLinkedKeys(conn,campus,src);
					dstArray = linkedDst.split(",");

					if (srcCounter % 2 != 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					found = false;
					buf.setLength(0);

					PreparedStatement ps = null;
					ResultSet rs = LinkedUtil.GetLinkedResultSet(conn,ps,campus,kix,src,level1);
					while (rs.next()) {

						found = true;
						thisID = rs.getInt("thisID");
						thisDescr = aseUtil.nullToBlank(rs.getString("thisDescr"));

						buf.append("<tr bgcolor=\"" + rowColor + "\">"
							+ "<td colspan=\"02\" class=\"class=\"datacolumn\"\">"
							+ thisDescr
							+ "</td></tr>");

						for (dstCounter=0;dstCounter<dstArray.length;dstCounter++){
							dst = dstArray[dstCounter];
							dst2 = LinkedUtil.GetLinkedDestinationFullName(dst);
							rtn = LinkerDB.getLinkedData(conn,campus,src,dst2,kix,thisID,false,true);
							buf.append("<tr bgcolor=\"" + rowColor + "\">"
								+ "<td width=\"05%\" class=\"class=\"datacolumn\"\">&nbsp;</td>"
								+ "<td class=\"class=\"datacolumn\"\">"
								+ "<font class=\"textblackth\">" + dst2.replace("Objectives","Course SLO") + "</font><br/>"
								+ rtn[2]
								+ "</td></tr>");
						}
					}	// while
					rs.close();

					if (found){
						temp += "<fieldset class=\"FIELDSET90\">"
							+ "<legend>"+linkedItem[srcCounter]+"</legend>"
							+ "<table summary=\"\" id=\"tableShowLinkedItemReport\" border=\"0\" width=\"100%\" cellspacing=0 cellpadding=8>"
							+ buf.toString()
							+ "</table>"
							+ "</fieldset><br/>";
					}

				} // processSrc

			}	// for

		} catch (SQLException se) {
			System.out.println("LinkedUtil: showLinkedItemReport - " + se.toString());
		} catch (Exception e) {
			System.out.println("LinkedUtil: showLinkedItemReport - " + e.toString());
		}

		return temp;
	}

	/**
	 * drawLinkedItemMatrix - draw matrix for linking
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String drawLinkedItemMatrix(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;

		String sql = "";
		String temp = "";
		String rowColor = "";

		// output string
		StringBuffer buf = new StringBuffer();

		String[] linked = LinkedUtil.GetLinkedItems(conn,"");
		String[] linkedItem = linked[0].split(",");
		String[] linkedKey = linked[1].split(",");

		// setting up display width
		int totalItems = linkedKey.length;
		int cellWidth = (int)(100/(totalItems+1));

		String fieldName = "";
		String linkedKeysDST = "";

		try {

			buf.append("<form name=\"aseForm\" method=\"post\" action=\"crslnkdzz.jsp\">");
			buf.append("<table summary=\"\" id=\"tableDrawLinkedItemMatrix\" border=\"1\" width=\"80%\" cellspacing=0 cellpadding=8>");

			// print header row
			buf.append("<tr bgcolor=\"#e1e1e1\">");
			buf.append("<td width=\""+cellWidth+"%\" class=\"textblackth\">Based\\Linked</td>");

			for (j=0;j<totalItems;j++){
				buf.append("<td align=\"middle\" width=\""+cellWidth+"%\" bgcolor=\""+Constant.COLOR_STAND_OUT+"\">"
					+ linkedItem[j]
					+ "</td>");
			}
			buf.append("</tr>");

			// print following rows
			for (j=0;j<totalItems;j++){

				if (j % 2 != 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\"" + rowColor + "\">");

				buf.append("<td bgcolor=\"lightblue\">" + linkedItem[j] + "</td>");

				linkedKeysDST = LinkedUtil.GetLinkedKeysDST(conn,campus,linkedKey[j]);

				for (i=0;i<totalItems;i++){

					fieldName = linkedKey[j] + "_" + linkedKey[i];

					// shouldn't be allowed to linked same items
					if (linkedKey[j].equals(linkedKey[i]))
						temp = "<img src=\"../images/no.gif\" alt=\"not allowed to link to similar items\"  border=\"0\">";
					else
						if (campus != null && campus.length() > 0){
							if (linkedKeysDST.indexOf(linkedKey[i]) > -1)
								temp = "<input type=\"checkbox\" checked class=\"input\" name=\""+fieldName+"\">";
							else
								temp = "<input type=\"checkbox\" class=\"input\" name=\""+fieldName+"\">";
						}
						else
							temp = "<input type=\"checkbox\" class=\"input\" name=\""+fieldName+"\">";

					buf.append("<td align=\"middle\">"
					+ temp
					+ "</td>");
				}

				buf.append("</tr>");

			}	// for

			buf.append("<tr>");
			buf.append("<td colspan=\""+(1+totalItems)+"\" align=\"right\">");
			buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"input\">&nbsp;&nbsp;");
			buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"input\" onClick=\"return cancelForm()\">&nbsp;&nbsp;");
			buf.append("<input type=\"hidden\" name=\"linkedKeys\" value=\""+linked[1]+"\">");
			buf.append("</td>");
			buf.append("</tr>");

			buf.append("</form>");

			buf.append("</table>");

		} catch (Exception e) {
			logger.fatal("LinkedUtil: drawLinkedItemMatrix - " + e.toString());
		}

		return buf.toString();
	}

	/**
	 * updateLinkedItemMatrix - update linked matrix per campus
	 * <p>
	 * @param	conn			Connection
	 * <p>
	 * @return	int
	 */
	public static int updateLinkedItemMatrix(HttpServletRequest request,
															Connection conn,
															String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int rowsAffected = 0;

		String fieldName = "";
		String temp = "";
		String sql = "";
		String selected = "";

		try {

			WebSite website = new WebSite();

			String hiddenLinkedKeys = website.getRequestParameter(request,"linkedKeys","",false);
			String[] linkedKeys = hiddenLinkedKeys.split(",");
			int totalItems = linkedKeys.length;

			PreparedStatement ps = null;

			// delete old data
			sql = "DELETE FROM tblLinkedKeys WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("Linked Matrix - deleted " + rowsAffected + " rows from linked table");

			// process rows of data
			for (i=0;i<totalItems;i++){
				selected = "";

				// process columns of data
				for (j=0;j<totalItems;j++){
					fieldName = linkedKeys[i] + "_" + linkedKeys[j];

					temp = website.getRequestParameter(request,fieldName,"",false);

					if (temp != null && temp.length() > 0){
						if ("".equals(selected))
							selected = linkedKeys[j];
						else
							selected = selected + "," + linkedKeys[j];
					}
				}	// for

				if (selected != null && selected.length() > 0){
					sql = "INSERT INTO tblLinkedKeys (campus,linkedsrc,linkeddst,level) VALUES(?,?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,linkedKeys[i]);
					ps.setString(3,selected);
					ps.setInt(4,0);
					rowsAffected = ps.executeUpdate();
					ps.close();
					logger.info("Linked Matrix - inserted " + rowsAffected + " row for " + linkedKeys[i]);
				}
			}	// for

			rowsAffected = 1;

		} catch (Exception e) {
			logger.fatal("LinkedUtil: showLinkedItemReport - " + e.toString());
			rowsAffected = -1;
		}

		return rowsAffected;
	}

	/**
	 * getLinkedItemCount - returns the number of linked items
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int getLinkedItemCount(Connection conn,String campus) throws Exception {

		int count = 0;

		try {
			String sql = "SELECT COUNT(id) counter "
				+ "FROM tblLinkedKeys "
				+ "WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt("counter");
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("LinkedUtil: getLinkedItemCount - " + e.toString());
		}

		return count;
	}

	/**
	 * GetLinkedKeysDST - returns the values selected by campus as linked to items
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedKeysDST(Connection conn,String campus,String src){

		//Logger logger = Logger.getLogger("test");

		String linkeddst = "";

		try{
			String sql = "SELECT linkeddst "
				+ "FROM tblLinkedKeys "
				+ "WHERE campus=? "
				+ "AND linkedsrc=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				linkeddst = AseUtil.nullToBlank(rs.getString("linkeddst"));

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("LinkedUtil - GetLinkedKeysDST - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("LinkedUtil - GetLinkedKeysDST - " + ex.toString());
		}

		return linkeddst;
	}

	/**
	 * insertLinked
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	type
	 * @param	kixOld
	 * @param	kixNew
	 * @param	src
	 * @param	currentID
	 * @param	nextID
	 * <p>
	 * @return	String
	 */
	public static int copyLinked(Connection conn,
												String campus,
												String user,
												String type,
												String kixOld,
												String kixNew,
												String src,
												int currentID,
												int nextID) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int newID = 0;
		int id = 0;
		int item = 0;
		int item2 = 0;
		int ref = 0;
		String dst = "";

		boolean debug = false;

		try {
			// process all relevant links and linked to items for based items

			debug = DebugDB.getDebug(conn,"LinkedUtil");

			String[] info = Helper.getKixInfo(conn,kixNew);
			String toCampus = info[Constant.KIX_CAMPUS];

			if (debug) logger.info("LINKEDUTIL INSERTLINKED - STARTS");

			String sql = "SELECT id,dst,ref "
				+ "FROM tblCourseLinked "
				+ "WHERE historyid=? "
				+ "AND src=? "
				+ "AND seq=? ";
			PreparedStatement ps2 = conn.prepareStatement(sql);
			ps2.setString(1,kixOld);
			ps2.setString(2,src);
			ps2.setInt(3,currentID);
			ResultSet rs2 = ps2.executeQuery();
			while (rs2.next()){
				id = rs2.getInt("id");
				ref = rs2.getInt("ref");
				dst = rs2.getString("dst");

				sql = "INSERT INTO tblCourseLinked (campus,historyid,src,seq,dst,auditby,auditdate,coursetype,ref) VALUES(?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps3 = conn.prepareStatement(sql);
				ps3.setString(1,toCampus);
				ps3.setString(2,kixNew);
				ps3.setString(3,src);
				ps3.setInt(4,nextID);
				ps3.setString(5,dst);
				ps3.setString(6,user);
				ps3.setString(7,AseUtil.getCurrentDateTimeString());
				ps3.setString(8,type);
				ps3.setInt(9,ref);
				rowsAffected = ps3.executeUpdate();
				ps3.close();
				if (debug) logger.info(kixNew + " - course links copied");

				sql = "SELECT id FROM tblCourseLinked WHERE campus=? AND historyid=? AND src=? AND seq=? AND dst=?";
				ps3 = conn.prepareStatement(sql);
				ps3.setString(1,campus);
				ps3.setString(2,kixNew);
				ps3.setString(3,src);
				ps3.setInt(4,nextID);
				ps3.setString(5,dst);
				ResultSet rs3 = ps3.executeQuery();
				if (rs3.next()){
					newID = rs3.getInt("id");
				}
				rs3.close();
				ps3.close();

				rowsAffected = 0;

				sql = "SELECT item,item2 "
					+ "FROM tblCourseLinked2 "
					+ "WHERE historyid=? "
					+ "AND id=? "
					+ "ORDER BY item";
				ps3 = conn.prepareStatement(sql);
				ps3.setString(1,kixOld);
				ps3.setInt(2,id);
				rs3 = ps3.executeQuery();
				while (rs3.next()){
					item = rs3.getInt("item");
					item2 = rs3.getInt("item2");

					sql = "INSERT INTO tblCourseLinked2(historyid,id,item,auditby,item2) VALUES(?,?,?,?,?)";
					PreparedStatement ps4 = conn.prepareStatement(sql);
					ps4.setString(1,kixNew);
					ps4.setInt(2,newID);
					ps4.setInt(3,item);
					ps4.setString(4,user);
					ps4.setInt(5,item2);
					rowsAffected += ps4.executeUpdate();
					ps4.close();
				}
				rs3.close();
				ps3.close();

				if (debug) logger.info(kixNew + " - course links2 copied - " + rowsAffected + " rows");
			}
			rs2.close();
			ps2.close();

			if (debug) logger.info("LINKEDUTIL INSERTLINKED - ENDS");

		} catch (SQLException e) {
			logger.fatal("LinkedUtil: insertLinked - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("LinkedUtil: insertLinked - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * copyLinkedTables
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixOld	String
	 *	@param	kixNew	String
	 *	@param	toAlpha	String
	 *	@param	toNum		String
	 *	@param	user		String
	 *	<p>
	 *	@return int
	 */
	public static int copyLinkedTables(Connection conn,String kixOld,String kixNew,String toAlpha,String toNum,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean debug = false;

		if (debug) logger.info(user + " - COPYLINKEDTABLES - START");

		try{
			PreparedStatement ps = null;
			ResultSet rs = null;
			String copySQL = "";
			int copyID = 0;

			// Constant.COURSE_OBJECTIVES - same id for old and copy to
			copySQL = "SELECT compid FROM tblCourseComp WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("compid");
				CompDB.copyComp(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - objectives");

			// Constant.COURSE_CONTENT - same id for old and copy to
			copySQL = "SELECT contentid FROM tblCourseContent WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("contentid");
				ContentDB.copyContent(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - contents");

			// Constant.COURSE_COMPETENCIES - same id for old and copy to
			copySQL = "SELECT seq FROM tblCourseCompetency WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("seq");
				CompetencyDB.copyCompentency(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - competencies");

			// Constant.COURSE_PROGRAM_SLO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND (src=? OR src=?) ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_PROGRAM_SLO);
			ps.setString(3,Constant.IMPORT_PLO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_PROGRAM_SLO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (PSLO)");

			// Constant.COURSE_INSTITUTION_LO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND (src=? OR src=?) ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_INSTITUTION_LO);
			ps.setString(3,Constant.IMPORT_ILO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_INSTITUTION_LO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (ILO)");

			// Constant.COURSE_GESLO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND src=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_GESLO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_GESLO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (GESLO)");

			// Constant.COURSE_GESLO - same id for old and copy to
			copySQL = "SELECT geid FROM tblGESLO WHERE historyid=? ORDER BY geid";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("geid");
				GESLODB.copyGESLO(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - GESLO");

			// Constant.COURSE_AAGEAREA_C40 - new id
			copySQL = "SELECT id FROM tblValuesData WHERE historyid=? AND X=? ORDER BY ID";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_AAGEAREA_C40);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				ValuesDB.copyValues(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - diversifications");

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - LinkedUtil: ex - " + ex.toString());
			rowsAffected = -1;
			conn.rollback();
			if (debug) logger.info(user + " - LinkedUtil - copyLinkedTables: ex - Rolling back transaction");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			rowsAffected = -1;

			try {
				conn.rollback();
				if (debug) logger.info(user + " - LinkedUtil: copyLinkedTables - Rolling back transaction");
			} catch (SQLException exp) {
				rowsAffected = -1;
				logger.fatal(user + " - LinkedUtil: copyLinkedTables - " + exp.toString());
			}
		}

		if (debug) logger.info(user + " - COPYLINKEDTABLES - END");

		return rowsAffected;
	} // LinkedUtil.copyLinkedTables

	public static int copyLinkedTablesOBSOLETE(Connection conn,String kixOld,String kixNew,String toAlpha,String toNum,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean debug = false;

		if (debug) logger.info(user + " - COPYLINKEDTABLES - START");

		try{
			PreparedStatement ps = null;
			ResultSet rs = null;
			String copySQL = "";
			int copyID = 0;

			// Constant.COURSE_OBJECTIVES - same id for old and copy to
			copySQL = "SELECT compid FROM tblCourseComp WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("compid");
				CompDB.copyComp(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - objectives");

			// Constant.COURSE_CONTENT - same id for old and copy to
			copySQL = "SELECT contentid FROM tblCourseContent WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("contentid");
				ContentDB.copyContent(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - contents");

			// Constant.COURSE_COMPETENCIES - same id for old and copy to
			copySQL = "SELECT seq FROM tblCourseCompetency WHERE historyid=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("seq");
				CompetencyDB.copyCompentency(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - competencies");

			// Constant.COURSE_PROGRAM_SLO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND (src=? OR src=?) ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_PROGRAM_SLO);
			ps.setString(3,Constant.IMPORT_PLO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_PROGRAM_SLO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (PSLO)");

			// Constant.COURSE_INSTITUTION_LO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND (src=? OR src=?) ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_INSTITUTION_LO);
			ps.setString(3,Constant.IMPORT_ILO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_INSTITUTION_LO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (ILO)");

			// Constant.COURSE_GESLO - new id
			copySQL = "SELECT id FROM tblGenericContent WHERE historyid=? AND src=? ORDER BY rdr";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_GESLO);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				GenericContentDB.copyGenericContent(conn,kixOld,kixNew,Constant.COURSE_GESLO,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - generic content (GESLO)");

			// Constant.COURSE_GESLO - same id for old and copy to
			copySQL = "SELECT geid FROM tblGESLO WHERE historyid=? ORDER BY geid";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("geid");
				GESLODB.copyGESLO(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - GESLO");

			// Constant.COURSE_AAGEAREA_C40 - new id
			copySQL = "SELECT id FROM tblValuesData WHERE historyid=? AND X=? ORDER BY ID";
			ps = conn.prepareStatement(copySQL);
			ps.setString(1,kixOld);
			ps.setString(2,Constant.COURSE_AAGEAREA_C40);
			rs = ps.executeQuery();
			while (rs.next()){
				copyID = rs.getInt("id");
				ValuesDB.copyValues(conn,kixOld,kixNew,toAlpha,toNum,user,copyID);
			}
			rs.close();
			ps.close();
			if (debug) logger.info(kixNew + " - diversifications");

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - LinkedUtil: ex - " + ex.toString());
			rowsAffected = -1;
			conn.rollback();
			if (debug) logger.info(user + " - LinkedUtil - copyLinkedTables: ex - Rolling back transaction");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			rowsAffected = -1;

			try {
				conn.rollback();
				if (debug) logger.info(user + " - LinkedUtil: copyLinkedTables - Rolling back transaction");
			} catch (SQLException exp) {
				rowsAffected = -1;
				logger.fatal(user + " - LinkedUtil: copyLinkedTables - " + exp.toString());
			}
		}

		if (debug) logger.info(user + " - COPYLINKEDTABLES - END");

		return rowsAffected;
	} // copyLinkedTables

	/**
	 * showNonEstablishedLinks - outline items configured for linking but connections have not been established
	 * <p>
	 * @param	srcName		String
	 * @param	dstName		String
	 * @param	print			boolean
	 * @param	compressed 	boolean
	 * <p>
	 * @return	String
	 */
	public static String showNonEstablishedLinks(String srcName,String dstName,boolean print,boolean compressed) throws Exception {

		StringBuffer buffer = new StringBuffer();

		buffer.append("<br/>");
		buffer.append("<table summary=\"\" id=\"showNonEstablishedLinks\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
		buffer.append("<tr height=\"30\">");
		buffer.append("<td class=\"datacolumn\">");
		buffer.append("&nbsp;<img src=\"/central/images/reminder.gif\" border=\"0\">"+srcName+" to "+dstName+" has been configured but links have not been established.");
		buffer.append("</td>");
		buffer.append("</tr>");
		buffer.append("</table>");

		return buffer.toString();

	} // showNonEstablishedLinks

}