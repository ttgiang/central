/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static int populateTestData(Connection conn,String campus,String kix,String user) throws Exception {
 *
 */

//
// Outlines.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.exception.CentralException;
import com.ase.paging.Paging;

import java.util.LinkedList;
import java.util.List;

public class Outlines {

	static Logger logger = Logger.getLogger(Outlines.class.getName());

	public Outlines() throws Exception {}

	/**
	 * createOutlineTemplate - create outline template
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	area		String
	 * @param	type		String
	 * @param	user		String
	 */
	public static void createOutlineTemplate(Connection conn,String campus,String area,String type,String user){

		StringBuffer html = new StringBuffer();
		String outline = "";
		int i = 0;
		int j = 1;
		int rowsAffected = 0;

		String t2 = "";
		String t3 = "";

		/* print template */
		String s1 = "<!-- line print -->";
		String s2 = "<tr><td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\">@@COUNTER@@&nbsp;</td><td class=\"textblackTH\" valign=\"top\">@Q@@@Q000@@</td></tr>";
		String s3 = "<tr><td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td><td class=\"datacolumn\" valign=\"top\">@A@@@A000@@<br><br></td></tr>";

		try{
			AseUtil aseUtil = new AseUtil();

			String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
			String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
			String indent = "0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0";

			String x1 = "c." + f1.replace(",",",c.");
			String x2 = "s." + f2.replace(",",",s.");

			String[] c1 = (f1 + "," + f2).split(",");

			html.append("<table summary=\"\" id=\"tableCreateOutlineTemplate\" border=\"0\" width=\"100%\">\n");
			for(i=0;i<c1.length;i++){
				html.append(s1+"\n");

				t2 = s2.replace("@@COUNTER@@",String.valueOf(j++)+".");
				t2 = t2.replace("@@Q000@@",c1[i]);
				t3 = s3.replace("@@A000@@",c1[i]);

				html.append(t2+"\n");
				html.append(t3+"\n");
			}
			html.append("</table>"+"\n");

			outline = html.toString();

			String sql = "DELETE FROM tblTemplate WHERE campus=? AND area=? AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,area);
			ps.setString(3,type);
			rowsAffected = ps.executeUpdate();

			sql = "INSERT INTO tblTemplate (campus,area,type,content,auditby) VALUES(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,area);
			ps.setString(3,type);
			ps.setString(4,outline);
			ps.setString(5,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Outlines: createOutlineTemplate - " + ex.toString());
		}
	}

	/**
	 * getOutlineTemplate
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	area		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String getOutlineTemplate(Connection conn,String campus,String area,String type){

		String outline = "";

		try{
			String sql = "SELECT content "
				+ "FROM tblTemplate "
				+ "WHERE campus=? AND "
				+ "area=? AND "
				+ "type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,area);
			ps.setString(3,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				outline = AseUtil.nullToBlank(rs.getString("content"));
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Outlines: getOutlineTemplate - " + ex.toString());
		}

		return outline;
	}

	/**
	 * showOutlines - display outlines by progress
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	progress		String
	 * @param	reportName	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesJQUERY(Connection conn,
												String campus,
												String user,
												String progress,
												String reportName){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String num = "";
		String title = "";
		String sql = "";
		boolean found = false;
		String temp = "";

		try{
			AseUtil aseUtil = new AseUtil();

			sql = SQL.outlinesShowOutlines;

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();

				String alphaIdx = alpha.substring(0,1).toLowerCase();

				if (user.equals(Constant.SYSADM_NAME)){
					listing.append("<li class=\"ln-"+alphaIdx+"\"><a target=\"_blank\" href=\"/central/servlet/jspr?campus="+campus+"&kix="+kix+"&rpt=outline&tp="+Constant.REPORT_TO_PDF
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				}
				else{
					listing.append("<li class=\"ln-"+alphaIdx+"\"><a href=\"vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=CUR"
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				}

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = listing.toString();
			}

		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlines - " + ex.toString());
		}

		return temp;
	}

	public static String showOutlines(Connection conn,String campus,String user,String progress,String reportName){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String alphaIdx = "";
		String firstIdx = "";
		String holdIdx = "";
		String holdAlpha = "";
		String num = "";
		String title = "";
		String bookmark = "";
		String sql = "";
		boolean found = false;
		String temp = "";

		try{
			AseUtil aseUtil = new AseUtil();

			sql = SQL.outlinesShowOutlines;

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();

				if (!holdAlpha.equals(alpha)){

					holdAlpha = alpha;

					alphaIdx = holdAlpha.substring(0,1);

					// this is the top most index to display
					if(firstIdx.equals("")){
						firstIdx = alphaIdx;
					}

					bookmark = "";
					if (!holdIdx.equals(alphaIdx)){
						bookmark = "<table summary=\"\" id=\"tableShowOutlines1\" width=\"50%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ "<tr bgcolor=#e1e1e1>"
							+ "<td width=\"50%\"><a id=\"" + alphaIdx + "\" name=\"" + alphaIdx + "\" class=\"linkcolumn\">[" + alphaIdx + "]</a></td>"
							+ "<td width=\"50%\" align=\"right\"><a href=\"#top\" class=\"linkcolumn\">back to top</a></td>"
							+ "</tr></table>";
						holdIdx = alphaIdx;
					}

					if (found)
						listing.append("</ul>" + bookmark + "<ul>");
				}

				listing.append("<li><a href=\"vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=CUR"
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				bookmark = "<a id=\""+firstIdx+"\" name=\""+firstIdx+"\" class=\"linkcolumn\">["+firstIdx+"]</a>";

				temp = "<table summary=\"\" id=\"tableShowOutlines2\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td align=\"center\">"
					+ Helper.drawAlphaIndexBookmark(0,reportName)
					+ "</td></tr>"
					+ "<tr><td>"
					+ bookmark
					+ "<ul>" + listing.toString() + "</ul>"
					+ "</td></tr>"
					+ "</table>";
			}
			else
				temp = "";
		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlines - " + ex.toString());
		}

		return temp;
	}

	/*
	 * viewOutline
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	kix			String
	 *	@param	user			String
	 * @param	compressed	boolean
	 *	<p>
	 * @return Msg
	 */
	public static Msg viewOutline(Connection conn,String kix,String user,boolean compressed) throws Exception {

		return viewOutline(conn,kix,user,compressed,false);
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											int section,
											String user,
											String reportName,
											boolean compressed) throws Exception {

		String[] info = Helper.getKixInfo(conn,kix);
		String type = info[2];

		Msg msg = viewOutline(conn,kix,section,user,compressed,false,false);

		return msg;
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											int section,
											String user,
											String reportName,
											boolean compressed,
											boolean print) throws Exception {

		String[] info = Helper.getKixInfo(conn,kix);
		String type = info[2];

		Msg msg = viewOutline(conn,kix,section,user,compressed,print,false);

		return msg;
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											String user,
											boolean compressed,
											boolean print) throws Exception {

		return viewOutline(conn,kix,user,compressed,print,false);
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											String user,
											boolean compressed,
											boolean print,
											boolean html) throws Exception {

		return viewOutline(conn,kix,user,compressed,print,html,false);
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											int section,
											String user,
											boolean compressed,
											boolean print,
											boolean html) throws Exception {

		return viewOutline(conn,kix,section,user,compressed,print,html,false);

	}

	public static Msg viewOutline(Connection conn,
											String kix,
											String user,
											boolean compressed,
											boolean print,
											boolean html,
											boolean detail) throws Exception {

		int section = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String type = info[2];

		if (type.equals("ARC"))
			section = Constant.COURSETYPE_ARC;
		else if (type.equals("CAN"))
			section = Constant.COURSETYPE_CAN;
		else if (type.equals("CUR"))
			section = Constant.COURSETYPE_CUR;
		else if (type.equals("PRE"))
			section = Constant.COURSETYPE_PRE;

		Msg msg = viewOutline(conn,kix,section,user,compressed,print,html,detail);

		return msg;
	}

	public static Msg viewOutline(Connection conn,
											String kix,
											int section,
											String user,
											boolean compressed,
											boolean print,
											boolean html,
											boolean detail) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String row1 = "<tr>"
			+"<td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" valign=\"top\"><| answer |></td>"
			+"</tr>";

		String xml = "<item>\n"
			+"<counter><| counter |>.</counter>\n"
			+"<question><| question |></question>\n"
			+"<answer><| answer |></answer>\n"
			+"</item>\n";

		StringBuffer buf = new StringBuffer();
		Msg msg = new Msg();

		//
		// for xml output
		//
		//StringBuffer xbuf = new StringBuffer();

		int i = 0;

		String t1 = "";
		String t2 = "";
		String x = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		String question = "";										// item question
		String temp = "";												// date for processing

		AseUtil aseUtil = new AseUtil();

		int step = 1;

		String[] columns = QuestionDB.getCampusColumms(conn,campus).split(",");
		String[] data = null;

		step = 2;

		String history = "";

		try {

			int courseItems = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			// which question to display
			String headerText = 	IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableHeaderText");

			if(headerText.equals(Constant.ON)){
				headerText = "headertext";
			}
			else{
				headerText = "question";
			}

			// clear any old reported data
			// not using at this time since we are not able to generate pdfs
			//PDFDB.delete(conn,user,"Outline");
			step = 3;

			// any sticky notes added
			MiscDB.deleteStickyMisc(conn,kix,user);
			step = 4;

			// collect outline questions and answers
			data = getOutlineData(conn,kix,section,user,false,compressed);
			step = 5;

			if (data != null){
				step = 6;

				// used for detail display of comments
				int loopCounter = 0;
				int table = 1;

				// clear place holder or items without any data from the template
				for(i=0;i<data.length;i++){
					t1 = row1;
					t2 = row2;

					x = xml;

					if(detail){

						++loopCounter;

						int questionNumber = QuestionDB.getQuestionNumber(conn,campus,table,loopCounter);

						history = "<table summary=\"\" style=\"border: 1px solid #fad163\" width=\"98%\"><tr><td>"
							+ ReviewerDB.getReviewHistory(conn,kix,questionNumber,campus,table,0)
							+ "</td></tr></table><br><br>";

						//
						// at max course items, reset and go to campus items
						//
						if(loopCounter == courseItems){
							table = 2;
							loopCounter = 0;
						}
					}

					question = aseUtil.lookUp(conn, "vw_AllQuestions", headerText, "campus='" + campus + "' AND question_friendly = '" + columns[i] + "'" );
					if (question != null){
						t1 = t1.replace("<| counter |>",(""+(i+1)));
						t1 = t1.replace("<| question |>",question+"<br><br>");
						t2 = t2.replace("<| answer |>",data[i]+"<br><br>" + history);

						buf.append(t1);
						buf.append(t2);

						//
						// for xml output
						//
						//x = x.replace("<| counter |>",(""+(i+1)));
						//x = x.replace("<| question |>",question+"<br><br>");
						//x = x.replace("<| answer |>",data[i]+"<br><br>");
						//xbuf.append(x);

						step = 7;
					}
				}

				if (AttachDB.attachmentExists(conn,kix)){
					step = 8;

					t1 = "<tr>"
						+"<td height=\"20\" colspan=\"2\" class=\"textblackTH\" valign=\"top\">Attachments<br><br></td>"
						+"</tr>";
					t2 = row2;

					t2 = t2.replace("<| answer |>",AttachDB.getAttachmentAsHTMLList(conn,kix)+"<br><br>");

					buf.append(t1);
					buf.append(t2);
					step = 9;
				}

				temp = "<table summary=\"\" id=\"tableViewOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ buf.toString() + "</table>";

				// if not printing, and not creating HTML don't do sticky notes
				if (!print && !html){
					temp += MiscDB.getStickyNotes(conn,kix,user);
				}

				// determine whether we want ease of reading or crunched up HTML
				String appendNewLineToHTML = SysDB.getSys(conn,"appendNewLineToHTML");
				if (appendNewLineToHTML.equals(Constant.ON)){
					temp = temp.replace("</table>","\n</table>\n");
					temp = temp.replace("</tr>","</tr>\n");
					temp = temp.replace("</td>","</td>\n");

					temp = temp.replace("<ul>","\n<ul>\n");
					temp = temp.replace("</ul>","\n</ul>\n");

					temp = temp.replace("</li>","</li>\n");
				}

				// this is the returned data
				msg.setErrorLog(temp);

				// any sticky notes added
				MiscDB.deleteStickyMisc(conn,kix,user);
				step = 10;

			} // if (data != null)

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: viewOutline - " + e.toString() + "\nStep = " + step);
		}

		return msg;
	}

	/*
	 * reviewOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	kix		String
	 * @param	int		mode
	 * @param	user		String
	 * @param	hide		boolean
	 *	<p>
	 *	@return Msg
	 */
	public static Msg reviewOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String kix,
												int mode) throws Exception {

		return reviewOutline(conn,campus,alpha,num,kix,mode,"",false);
	}

	public static Msg reviewOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String kix,
												int mode,
												String user) throws Exception {

		return reviewOutline(conn,campus,alpha,num,kix,mode,user,false);
	}

	public static Msg reviewOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String kix,
												int mode,
												String user,
												boolean hide) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		AseUtil aseUtil = new AseUtil();
		StringBuffer outline = new StringBuffer();

		String sql = "";
		String temp = "";
		String tempCampus = "";

		String[] questions = new String[100];
		int[] question_number = new int[100];

		int columnCount = 0;
		int columnCountCampus = 0;
		int j = 0;

		Question question;
		String outputData = "";
		String bgcolor = "";
		HashMap hashMap = null;

		HttpSession session = null;

		// allow viewing of approval process.
		boolean allowToComment = true;

		// used for jquery popup links
		String linkedKey = "";

		int fid = 0;
		int mid = 0;

		boolean display = true;
		boolean courseNumAlpha = false;

		String headerText = "";

		// ER00019 - allows user to return to item in progress
		String bookmark = "";

		long totalReviewerComments = 0;

		try{

			String caller = "rvw";
			if(mode == Constant.APPROVAL){
				caller = "apr";
			}

			// this works. just not in use.
			//allowToComment = canCommentOnOutline(conn,kix,user);

			// retrieve questions for GUI
			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			columnCount = list.size();

			ArrayList listCampus = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			columnCountCampus = listCampus.size();

			// tack on history to the end and up the column count by 1
			temp = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'");
			tempCampus = aseUtil.lookUp(conn, "tblCampus", "campusitems", "campus='" + campus + "'");

			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				fid = ForumDB.getForumID(conn,campus,kix);
			}

			// which question to display
			String enableHeaderText = 	IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableHeaderText");

			// with field names, get data for the course in question
			if (temp.length() > 0){
				// put field names into an array for later use
				String[] aFieldNames = new String[columnCount];
				long reviewerComments = 0;
				aFieldNames = temp.split(",");

				sql = "SELECT " + temp + " FROM tblCourse WHERE historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				java.util.Hashtable rsHash = new java.util.Hashtable();

				String enc = "";

				outline.append( "<table id=\"tableReviewOutlines\" border=\"0\" width=\"100%\" cellspacing=2 cellpadding=8><tbody>");

				String goldHighlightsBox = "";

				if ( rs.next() ) {

					hashMap = MiscDB.getEnabledItems(conn,kix,Constant.TAB_COURSE);

					aseUtil.getRecordToHash(rs,rsHash,aFieldNames);

					for(j=0; j<list.size(); j++) {

						display = true;
						courseNumAlpha = false;

						question = (Question)list.get(j);

						if(enableHeaderText.equals(Constant.ON)){
							headerText = question.getHeaderText();
						}
						else{
							headerText = question.getQuestion();
						}

						// if the item was enabled for modification, highlight
						bgcolor = "";
						if(hashMap != null && hashMap.containsValue(""+(j+1))){
							bgcolor="bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"";
						}

						// if item enabled, make sure not alpha or number
						if (	QuestionDB.isCourseNumFromNumber(conn,campus,NumericUtil.getInt(question.getNum(),0)) ||
								QuestionDB.isCourseAlphaFromNumber(conn,campus,NumericUtil.getInt(question.getNum(),0)) ){
							bgcolor = "";
							courseNumAlpha = true;
						}

						// do we show or hide the highlights
						if (hide && bgcolor.equals("")){
							display = false;
						}

						// do we show or hide coure alpha and number
						if (hide && courseNumAlpha){
							display = false;
						}

						if (display){

							if (enableMessageBoard.equals(Constant.OFF)){
								reviewerComments = ReviewerDB.countReviewerComments(conn,kix,Integer.parseInt(question.getNum()),Constant.TAB_COURSE,0);
							}
							else{
								mid = ForumDB.getTopLevelPostingMessage(conn,fid,j+1);
								reviewerComments = ForumDB.countPostsToForum(conn,kix,j+1);
							}

							totalReviewerComments = totalReviewerComments + reviewerComments;

							goldHighlightsBox = "";
							if (!bgcolor.equals("")){
								goldHighlightsBox = "goldhighlightsbox";
							}

							bookmark = "c1-" + question.getNum();

							outline.append("<tr "+bgcolor+"><td align=\"left\" valign=\"top\" width=\"05%\" nowrap><font class=\""+goldHighlightsBox+"\"><a name=\""+bookmark+"\" class=\"bookmark\">" + (j+1) + ".</a></font> ");

							if (allowToComment){

								if (enableMessageBoard.equals(Constant.OFF)){
									outline.append("<a href=\"crscmnt.jsp?c=1&md=" + mode + "&kix=" + kix + "&qn=" + question.getNum() + "&qseq=" + (j+1) + "\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
								}
								else{
									//outline.append("<a href=\"forum/displayusrmsg.jsp?rtn=rvw&t=1&fid="+fid+"&mid="+mid+"&item="+(j+1)+"&kix="+kix+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
									outline.append("<a href=\"forum/post.jsp?src=USR&rtn="+caller+"&tab=1&fid="+fid+"&mid="+mid+"&item="+(j+1)+"&kix="+kix+"&level=2&bookmark="+bookmark+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
								}

								//TTG - popup for quick comment
								// linkedKey 1 is campus item
								int allowEdit = 1;
								if(courseNumAlpha){
									allowEdit = 0;
								}
								linkedKey = "1_" + question.getNum() + "_" + (j+1) + "_" + bookmark + "_" + allowEdit;
								outline.append("<a class=\"popupItem\" id=\""+linkedKey+"\" href='##'><img src=\"../images/flash.gif\" title=\"quick comments\" alt=\"quick comments\" id=\"quick_comments\" /></a>&nbsp;");
							}

							if (reviewerComments > 0){
								if (enableMessageBoard.equals(Constant.OFF)){
									outline.append("<a href=\"crsrvwcmnts.jsp?c=1&md=0&kix=" + kix + "&qn=" + question.getNum() + "&fd=" + (j+1) + "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;(" + reviewerComments + ")</td>");
								}
								else{
									outline.append("<a href=\"./forum/prt.jsp?fid="+fid+"&mid=0&itm="+(j+1)+"\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;(" + reviewerComments + ")</td>");
								}
							}
							else{
								outline.append("<img src=\"images/no-comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" />&nbsp;(" + reviewerComments + ")</td>");
							}

							outputData = (String) rsHash.get(aFieldNames[j]);
							outputData = Outlines.formatOutline(conn,aFieldNames[j],campus,alpha,num,"PRE",kix,outputData,false,user);

							outline.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + headerText + "</td></tr>" +
								"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + outputData + "</td></tr>");

						} // hide or show

					}	// for
				}	// if rs.next
				rs.close();
				rs = null;
				ps.close();

				if (tempCampus.length() > 0){
					reviewerComments = 0;
					aFieldNames = tempCampus.split(",");

					sql = "SELECT " + tempCampus + " FROM tblCampusData WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					rsHash = new java.util.Hashtable();
					if ( rs.next() ) {

						hashMap = MiscDB.getEnabledItems(conn,kix,Constant.TAB_CAMPUS);

						aseUtil.getRecordToHash(rs,rsHash,aFieldNames);
						for(j = 0; j<listCampus.size(); j++) {

							display = true;

							question = (Question)listCampus.get(j);

							if(enableHeaderText.equals(Constant.ON)){
								headerText = question.getHeaderText();
							}
							else{
								headerText = question.getQuestion();
							}

							// if the item was enabled for modification, highlight
							bgcolor = "";
							if(hashMap != null && hashMap.containsValue(""+(j+columnCount+1))){
								bgcolor="bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"";
							}

							if (hide && bgcolor.equals("")){
								display = false;
							}

							if (display){
								if (enableMessageBoard.equals(Constant.OFF)){
									reviewerComments = ReviewerDB.countReviewerComments(conn,kix,Integer.parseInt(question.getNum()),Constant.TAB_CAMPUS,0);
								}
								else{
									mid = ForumDB.getTopLevelPostingMessage(conn,fid,(j+columnCount+1));
									reviewerComments = ForumDB.countPostsToForum(conn,kix,j+columnCount+1);
								}

								totalReviewerComments = totalReviewerComments + reviewerComments;

								goldHighlightsBox = "";
								if (!bgcolor.equals("")){
									goldHighlightsBox = "goldhighlightsbox";
								}

								bookmark = "c2-" + question.getNum();

								outline.append("<tr "+bgcolor+"><td align=\"left\" valign=\"top\" width=\"05%\" nowrap><font class=\""+goldHighlightsBox+"\"><a name=\""+bookmark+"\" class=\"bookmark\">" + (j+columnCount+1) + ".</a></font> ");

								if (allowToComment){

									if (enableMessageBoard.equals(Constant.OFF)){
										outline.append("<a href=\"crscmnt.jsp?c=2&md=" + mode + "&kix=" + kix + "&qn=" + question.getNum() + "&qseq=" + (j+columnCount+1) + "\"><img src=\"../images/comment.gif\" alt=\"add comments\" id=\"add_comments\" /></a>&nbsp;");
									}
									else{
										//outline.append("<a href=\"forum/displayusrmsg.jsp?rtn=rvw&t=2&fid="+fid+"&mid="+mid+"&item="+(j+columnCount+1)+"&kix="+kix+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
										outline.append("<a href=\"forum/post.jsp?src=USR&rtn="+caller+"&tab=2&fid="+fid+"&mid="+mid+"&item="+(j+columnCount+1)+"&kix="+kix+"&level=2&bookmark="+bookmark+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
									}

									//TTG - popup for quick comment
									// linkedKey 2 is campus item
									linkedKey = "2_" + question.getNum() + "_" + (j+columnCount+1) + "_" + bookmark + "_1";
									outline.append("<a class=\"popupItem\" id=\""+linkedKey+"\" href='##'><img src=\"../images/flash.gif\" title=\"quick comments\" alt=\"quick comments\" id=\"quick_comments\" /></a>&nbsp;");
								}

								if (reviewerComments > 0){
									if (enableMessageBoard.equals(Constant.OFF)){
										outline.append("<a href=\"crsrvwcmnts.jsp?c=2&md=" + mode + "&kix=" + kix + "&qn=" + question.getNum() + "&fs=" + (j+columnCount+1) + "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;(" + reviewerComments + ")</td>");
									}
									else{
										outline.append("<a href=\"./forum/prt.jsp?fid="+fid+"&mid=0&itm="+(j+columnCount+1)+"\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;(" + reviewerComments + ")</td>");
									}
								}
								else{
									outline.append("<img src=\"images/no-comment.gif\" alt=\"view comments\" id=\"review_comments\" />&nbsp;(" + reviewerComments + ")</td>");
								}

								outputData = (String) rsHash.get(aFieldNames[j]);
								outputData = Outlines.formatOutline(conn,aFieldNames[j],campus,alpha,num,"PRE",kix,outputData,false,user);

								outline.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + headerText + "</td></tr>" +
									"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + outputData + "</td></tr>");
							} // hide or show

						}	// for
					}	// if rs.next
					rs.close();
					rs = null;
					ps.close();
				}

				hashMap = null;

				if (AttachDB.attachmentExists(conn,kix)){
					outline.append("<tr>"
						+ "<td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\" class=\"textblackth\">Attachments:<br>"
						+ AttachDB.getAttachmentAsHTMLList(conn,kix)
						+ "</td></tr>");
				}

				outline.append("</tbody></table>");

				outline.append("<p align=\"left\">&nbsp;&nbsp;");

				// compare items
				if (kix != null) {
					//outline.append("<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>approval comments</span></a>");

					if (totalReviewerComments > 0){
						if (fid > 0){
							outline.append("&nbsp;&nbsp;<a href=\"./forum/prt.jsp?fid=" + fid + "\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>view comments ("+totalReviewerComments+")</span></a>");
						}
						else{
							outline.append("&nbsp;&nbsp;<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>view comments ("+totalReviewerComments+")</span></a>");
						}
					}
					else{
						outline.append("&nbsp;&nbsp;<a href=\"./forum/prt.jsp?fid=" + fid + "\" disabled class=\"buttonDisabled\"><span>view comments</span></a>");
					}

					outline.append("&nbsp;&nbsp;<a href=\'crscmpry.jsp?kix=" + kix + "\' class=\'button\' target=\'_blank\'><span>compare outlines</span></a>");

					outline.append("&nbsp;&nbsp;<a href=\"crsrsn.jsp?kix=" + kix + "\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrsn','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>reason for course actions</span></a>");
				}

				//
				// for REVIEW_IN_REVIEW, show appropriate buttons
				//
				int reviewerLevel = 0;
				int inviterLevel = 0;
				String allowReviewInReview = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowReviewInReview");
				if(allowReviewInReview.equals(Constant.ON)){
					reviewerLevel = ReviewerDB.getReviewerLevel(conn,kix,user);
					inviterLevel = ReviewerDB.getInviterLevel(conn,kix,user);
				}

				// during proposer requested review, we only display link to say finish.
				// during approver requested review, we have buttons for voting only if the system setting is on.
				String subProgress = Outlines.getSubProgress(conn,kix);
				String reviewerWithinApprovalCanVote = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ReviewerWithinApprovalCanVote");
				if (	(mode==Constant.REVIEW && !(Constant.COURSE_REVIEW_IN_APPROVAL).equals(subProgress))
						||
						(	mode==Constant.REVIEW_IN_APPROVAL
							&& (Constant.COURSE_REVIEW_IN_APPROVAL).equals(subProgress)
							&& (Constant.OFF).equals(reviewerWithinApprovalCanVote)
						)
				){

					//
					// if this is REVIEW_IN_REVIEW and there are reviews remaining, don't allow the inviter to finish
					//
					if(allowReviewInReview.equals(Constant.ON) && inviterLevel > 1){
						outline.append("&nbsp;&nbsp;<a href=\'crsrvwerx.jsp?f=1&kix=" + kix + "\' disabled class=\'buttonDisabled\'><span>I'm finished</span></a>");
					}
					else{
						outline.append("&nbsp;&nbsp;<a href=\'crsrvwerx.jsp?f=1&kix=" + kix + "\' class=\'button\'><span>I'm finished</span></a>");
					}

				}

				//
				// if this is REVIEW_IN_REVIEW turn on invite button for reviewers only.
				// proposer must use the menu option
				//
				String proposer = CourseDB.getCourseItem(conn,kix,"proposer");

				if(allowReviewInReview.equals(Constant.ON) && !user.equals(proposer)){

					String originalReviewByDate = CourseDB.getCourseItem(conn,kix,"reviewdate");

					// add 1 to indicate this is the next level up for reviewers inviting people to review
					outline.append("&nbsp;&nbsp;<a href=\'crsrvw.jsp?kix=" + kix + "&rl="+(reviewerLevel+1)+"\' class=\'button\'><span>Invite reviewers</span></a>")
						.append("<br><br><br>The following is applicable to review within review:<br>")
						.append("<ul>")
						.append("<li>Proposers may not invite reviewers from this screen</li>")
						.append("<li>'I'm finished' is availalbe only after all your reviewers have completed their reviews</li>")
						.append("<li>Review due date may not be later than " + originalReviewByDate + " </li>")
						.append("<ul>");
				}

				outline.append("</p>");

				msg.setErrorLog(outline.toString());
			}
		}
		catch( SQLException e ){
			msg.setMsg("Exception");
			logger.fatal("Outlines.reviewOutline ("+kix+"): " + e.toString());
		}
		catch( Exception e ){
			msg.setMsg("Exception");
			logger.fatal("Outlines.reviewOutline ("+kix+"): " + e.toString());
		}

		return msg;
	} // Outlines: reviewOutline

	/*
	 * cleansData
	 * <p>
	 * @param	column	String
	 * @param	data		String
	 * <p>
	 * @return String
	 */
	public static String cleansData(String column,String data){

		// data cleansing
		if(column.equals(Constant.COURSE_PREREQ) || column.equals(Constant.COURSE_COREQ)){
			if(data.equals("0~~0") || data.equals("~~0")){
				data = "";
			}
		}

		return data;

	}

	/*
	 * formatOutline
	 *	<p>
	 * @param	conn			Connection
	 * @param	column		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * @param	kix			String
	 * @param	temp			String
	 * @param	compressed	boolean
	 * @param	user			String
	 * @param	catalog		boolean
	 *	<p>
	 * @return StringBuffer
	 */
	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp,
													boolean compressed,
													String user) throws Exception {

		return formatOutline(conn,column,campus,alpha,num,type,kix,temp,compressed,user,false);

	}

	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp,
													boolean compressed,
													String user,
													boolean catalog) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		int j = 0;
		String junk = "";
		String line = "";
		String[] reuse;

		String lookupData[] = new String[2];
		String questionData[] = new String[2];
		String lookUpCampus = "campus='"+campus+"' AND type='Campus' AND question_friendly='__'";
		String lookUpSys = "campus='SYS' AND type='Course' AND question_friendly='__'";
		String explainField = "";
		String explainSQL = "historyid=" + aseUtil.toSQL(kix,1);

		String department = "";

		boolean debug = false;

		String formattedText = "";

		String textToAppend = "";

		try{

			String fieldRef = "";
			//
			// clean up what we know as bad data
			//
			temp = cleansData(column,temp);

			// look up the reference for retrieval of checklist/radio data.
			// if not found as a campus item, then it's likely to be a system item
			junk = lookUpCampus;
			junk = junk.replace("__",column);
			questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
			if (questionData[0].equals("NODATA")){
				junk = lookUpSys;
				junk = junk.replace("__",column);
				questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
				if(questionData != null && questionData.length > 1){
					fieldRef = questionData[1];
				}
			}

			// for items with an explanation, look up the column holding the explanation
			// and print after the content.
			explainField = CCCM6100DB.getExplainColumnValue(conn,column);

			if (debug){
				logger.info("-------------------- formatOutline");
				logger.info("column: " + column);
				logger.info("explainField: " + explainField);
				logger.info("questionData[0]: " + questionData[0]);
				logger.info("questionData[1]: " + questionData[1]);
				logger.info("fieldRef: " + fieldRef);
				logger.info("temp: " + temp);
			}

			// ----------------------------------------------------
			// primary data
			// ----------------------------------------------------
			if (column.indexOf("date") > -1) {
				formattedText = aseUtil.ASE_FormatDateTime(temp, 6);
			}
			else if (questionData[0].equals("check")) {

				// take apart semester from CSV format and lookup actual value
				// using campus, category and id

				if (	column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_1) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_2) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_CHECKBOX_3) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_1) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_2) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_CHECKBOX_3) ||
						fieldRef.contains("UserDefinedControl_X")
					){

					if(temp != null && temp.length() > 0){

						questionData[0] = "";

						//
						// the ~~0 exists when working with multi-value but does
						// not apply to these puppies
						//
						reuse = temp.replace("~~0","").split(",");

						// retrive system settings with values saved as ids
						if (NumericUtil.isInteger(reuse[j])){

							for(j=0;j<reuse.length;j++){

								if (NumericUtil.getInt(reuse[j],0) > 0){
									junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
									lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
									junk = lookupData[1];
									if (junk != null && junk.length() > 0){
										if (questionData[0].equals(Constant.BLANK))
											questionData[0] = "<li class=\"datacolumn\">" + junk + "</li>";
										else
											questionData[0] = questionData[0] + "<li class=\"datacolumn\">" + junk + "</li>";
									} // if

								} // valid number

							} // for

						} // if reuse

						formattedText = "<ul>" + questionData[0] + "</ul>";

					}
					else{
						formattedText = "";
					}
					// we have data

				}
				else if (column.equals(Constant.COURSE_CCOWIQ)) {
					formattedText = CowiqDB.drawCowiq(conn,campus,kix,true);
				}
				else if (column.equals(Constant.COURSE_FUNCTION_DESIGNATION)) {
					formattedText = FunctionDesignation.drawFunctionDesignation(conn,campus,temp,true);
				}
				else if (column.equals(Constant.COURSE_GENCORE)) {
					formattedText = temp;
				}
				else{
					/*
						if we find ~~ in the fieldValue, it's because we are storing
						double values between commas.

						for example, 869~~5,870~~10,871~~15,872~~3 is similar to

						869,5
						870,10
						871,15
						872,3

						four sets of data as CSV

						this section of code breaks CSV into sub CSV and assign
						accordingly.

						for contact hours, we include a drop down list of hours for selection.

						lookupX returns array of 2 values. in this case, the start and ending
						values for the list range
					*/

					formattedText = com.ase.aseutil.util.CCUtil.removeDoubleCommas(temp);

					if (formattedText != null && !formattedText.equals(Constant.BLANK)){

						String dropDownValues = "";
						String[] aDropDownValues = null;
						boolean includeRange = IniDB.showItemAsDropDownListRange(conn,campus,"NumberOfContactHoursRangeValue");
						if(formattedText.indexOf(Constant.SEPARATOR)>-1 || includeRange){

							int junkInt = 0;
							int tempInt = 0;
							String[] tempString = null;
							String[] junkString = null;

							// if statement splits when there is data. else statement sets all to zero.
							if(formattedText.indexOf(Constant.SEPARATOR)>-1){

								String[] split = SQLValues.splitMethodEval(formattedText);
								if (split != null){
									formattedText = split[0];
									dropDownValues = split[1];
								}

							}
							else{
								tempString = formattedText.split(",");
								tempInt = tempString.length;

								for(junkInt = 0; junkInt<tempInt; junkInt++){
									if (junkInt == 0)
										dropDownValues = "0";
									else
										dropDownValues = dropDownValues + ",0";
								} // for
							}

							aDropDownValues = dropDownValues.split(",");

						} // (formattedText.indexOf(Constant.SEPARATOR)>-1)

						questionData[0] = "";
						reuse = formattedText.split(",");

						// retrive system settings with values saved as ids
						if (NumericUtil.isInteger(reuse[j])){

							for(j=0;j<reuse.length;j++){

								if (NumericUtil.getInt(reuse[j],0) > 0){

									junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
									lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
									junk = lookupData[1];
									if (junk != null && junk.length() > 0){

										if (includeRange && aDropDownValues[j] != null)
											junk = junk + " (" + aDropDownValues[j] + ")";

										if ("".equals(questionData[0]))
											questionData[0] = "<li class=\"datacolumn\">" + junk + "</li>";
										else
											questionData[0] = questionData[0] + "<li class=\"datacolumn\">" + junk + "</li>";
									} // if

								} // valid number

							} // for

						} // if reuse

						formattedText = "<ul>" + questionData[0] + "</ul>";

						if (column.equals(Constant.COURSE_METHODEVALUATION)){

							// TO DO - hard coding
							if (campus.equals(Constant.CAMPUS_UHMC)){
								formattedText = formattedText + "<br>" + Outlines.showMethodEval(conn,campus,kix);
							}

							formattedText = formattedText
								+ "<br>"
								+ LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
						}

					} // formattedText != null

				} // ccowiq

			} // check
			else if (questionData[0].equals("radio")) {

				if (	column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_1) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_2) ||
						column.equalsIgnoreCase(Constant.CAMPUS_USER_RADIO_LIST_3) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_1) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_2) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_3) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_4) ||
						column.equalsIgnoreCase(Constant.COURSE_USER_RADIO_LIST_5) ||
						fieldRef.contains("UserDefinedControl_X")
						){
					formattedText = IniDB.getKdesc(conn,temp);
				}
				else if (column.equalsIgnoreCase(Constant.COURSE_REASONSFORMODS)){
					formattedText = IniDB.getKdesc(conn,temp);
				}
				else if (questionData[1].indexOf("CONSENT") > -1){

					//
					// pre req consent
					//
					String displayOrConsentForPreReqs = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");
					if (questionData[1].equals("CONSENTPREREQ") && displayOrConsentForPreReqs.equals(Constant.ON)){
						formattedText = Outlines.drawPrereq(kix,temp,"",true);
					}
					else if (questionData[1].equals("CONSENTCOREQ")){
						if (debug) logger.info("CONSENTCOREQ");

						// does not exist for coreq
						//formattedText = AseUtil.expandText(temp,"Consent: YES","Consent: NO","");
					}

					//
					// course mod consent
					//
					String displayConsentForCourseMods = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayConsentForCourseMods");
					if (displayConsentForCourseMods.equals(Constant.OFF)){
						formattedText = "";
					}
					if (debug) logger.info("displayConsentForCourseMods: " + displayConsentForCourseMods);

					//
					// pre cor/req
					//
					if (column.equals(Constant.COURSE_PREREQ)){
						formattedText = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,kix);
						textToAppend = AseUtil.expandText(temp,"YES","NO","");
					}
					else if (column.equals(Constant.COURSE_COREQ)){
						formattedText = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,kix);

						if(formattedText != null && formattedText.length() > 0){
							textToAppend = "YES";
						}
						else{
							textToAppend = AseUtil.expandText(temp,"YES","NO","");
						}
					}

					if (debug) logger.info("formattedText: " + formattedText);
				}
				else if (questionData[1].equalsIgnoreCase("status")){
					formattedText = AseUtil.expandText(temp,"Active","Inactive","Inactive");
				}
				else if (questionData[1].equalsIgnoreCase("YESNO")){
					formattedText = AseUtil.expandText(temp,"YES","NO","");

					// if cross listed and there is data, just display data without yes/no
					if (column.equalsIgnoreCase("crosslisted")){
						junk = CourseDB.getCrossListing(conn,kix);

						if (junk != null && junk.length() > 0)
							formattedText = junk;
						else
							formattedText = formattedText + "<br>" + junk;
					}
				}
			} // radio
			else if (column.equals("division")) {
				formattedText = DivisionDB.getDivision(conn,campus,temp);
			}
			else if (column.equals("excluefromcatalog")) {
				formattedText = AseUtil.expandText(temp,"YES","NO","NO");
			}
			else if (column.equals("effectiveterm") && temp != null && temp.length() > 0) {
				formattedText = TermsDB.getTermDescription(conn, temp);
			}
			else if (column.equals(Constant.COURSE_OBJECTIVES)) {
				formattedText = LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_CONTENT)) {
				if(catalog){
					textToAppend = "";
					formattedText = temp + ContentDB.getContentAsHTMLList(conn,campus,alpha,num,Constant.CUR,kix,false,false);
				}
				else{
					formattedText = LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
					textToAppend = temp;
				}
			}
			else if (column.equals(Constant.COURSE_COMPETENCIES)) {
				if(catalog){
					textToAppend = "";
					formattedText = temp + CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
				}
				else{
					formattedText = LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
					textToAppend = temp;
				}
			}
			else if (column.equals(Constant.COURSE_EXPECTATIONS)) {
				formattedText = IniDB.getIniByCategory(conn,campus,"Expectations",temp,true);
			}
			else if (column.equals(Constant.COURSE_GESLO)) {

				String gesloText = "";
				String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
				if(useGESLOGrid.equals(Constant.ON)){
					gesloText = GESLODB.getGESLO(conn,campus,kix,true) + "<br>";
				}

				formattedText = gesloText
						+ LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);

			}
			else if (column.equals(Constant.COURSE_RECPREP)) {
				formattedText = ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_OTHER_DEPARTMENTS)) {

				String enableOtherDepartmentLink = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOtherDepartmentLink");
				if (enableOtherDepartmentLink.equals(Constant.ON)){
					formattedText = ExtraDB.getOtherDepartments(conn,
																				Constant.COURSE_OTHER_DEPARTMENTS,
																				campus,
																				kix,
																				false,
																				false);
					textToAppend = temp;
				}

			}
			else if (column.equals(Constant.COURSE_PROGRAM)) {
				formattedText = ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,false);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_PROGRAM_SLO)) {
				formattedText = LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_INSTITUTION_LO)) {
				formattedText = LinkedUtil.printLinkedMaxtrixContent(conn,kix,column,user,true,compressed);
				textToAppend = temp;
			}
			else if (column.equals(Constant.COURSE_TEXTMATERIAL)) {
				formattedText = TextDB.getTextAsHTMLList(conn,kix);
				textToAppend = temp;
			}
			else{
				formattedText = temp;
			} // column

			// ----------------------------------------------------
			// explained data
			// ----------------------------------------------------
			if(explainField != null && explainField.length() > 0 && CCCM6100DB.displayCommentsBox(conn,campus,column)){

				junk = AseUtil.nullToBlank(aseUtil.lookUp(conn,"tblCampusData",explainField,explainSQL));
				if (junk != null && junk.length() > 0){

					if(catalog){

						// FCKEditor tacks on <p> & </p> around content so we remove here
						if(junk.toLowerCase().startsWith("<p>") && junk.toLowerCase().endsWith("</p>")){
							junk = junk.substring(3);
							junk = junk.substring(0,junk.length()-4);
						}
					}

					if(formattedText != null && formattedText.length() > 0){
						formattedText = formattedText + "<br>" + junk;
					}
					else{
						formattedText = junk;
					}

				}
			}

			// ----------------------------------------------------
			// combined data
			// only pre/coreq had explain appearing before data
			// ----------------------------------------------------
			if (column.equals(Constant.COURSE_PREREQ) || column.equals(Constant.COURSE_COREQ)){
				if(textToAppend != null && textToAppend.length() > 0){

					if(formattedText != null && formattedText.length() > 0){
						formattedText = formattedText + "<br>" + textToAppend ;
					}
					else{
						formattedText = textToAppend ;
					}

				}
			}
			else{
				if(!catalog){
					if(textToAppend != null && textToAppend.length() > 0){

						if(formattedText != null && formattedText.length() > 0){
							formattedText = textToAppend + "<br>" + formattedText;
						}
						else{
							formattedText = textToAppend ;
						}

					}

				} // catalog

			} // prereq

			// ----------------------------------------------------
			// default text
			// ----------------------------------------------------

			// we got here not knowing the tab we're on so use the column name to
			// determine the tab

			int tab = 1;

			if(CampusDB.getCourseItems(conn,campus).indexOf(column) > -1){
				tab = Constant.TAB_COURSE;
			}
			else{
				tab = Constant.TAB_CAMPUS;
			}

			if(QuestionDB.isDefaultTextPermanent(conn,campus,tab,column)){

				String defaultText = QuestionDB.getDefaultText(conn,campus,tab,column);

				if(QuestionDB.defaultTextAppends(conn,campus,tab,column,"A")){
					formattedText = formattedText + "<br>" + defaultText ;
				}
				else if(QuestionDB.defaultTextAppends(conn,campus,tab,column,"B")){
					formattedText = defaultText + "<br>" + formattedText;
				}

			} // default text

		}
		catch(SQLException e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}
		catch(Exception e){
			logger.fatal("Outlines: formatOutline - "
							+ e.toString()
							+ "\ncolumn: " + column
							+ "\nexplainField: " + explainField
							+ "\nexplainSQL: " + explainSQL
							);
		}

		return formattedText;
	} // Outlines.formatOutline

	/*
	 * viewOutlineSLO
	 *	<p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		type
	 *	<p>
	 * @return StringBuffer
	 */
	public static StringBuffer viewOutlineSLO(Connection conn,
															String campus,
															String alpha,
															String num,
															String type) throws Exception {

		int i = 0;				// counter
		int lid = 0;			// accjc id
		int controls = 7;		// total SLO questions

		String[] question = new String[controls];
		StringBuffer slo = new StringBuffer();
		String campusName = "";
		String kix = "";

		CourseACCJC accjc = new CourseACCJC();
		Vector vector = new Vector();
		Vector v;
		String[] getQuestions = new String[controls];

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			vector = AssessedDataDB.getAssessedQuestions(conn,campus);
			if (vector != null){
				i = 0;
				for (Enumeration e = vector.elements(); e.hasMoreElements();){
					question[i++] = (String)e.nextElement();
				}
			}

			String sql = "SELECT id,historyid FROM tblCourseACCJC " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();

			while (rs.next()){
				if (!found)
					slo.append("<table summary=\"\" id=\"tableViewOutlineSLO\" border=\"0\" width=\"100%\">");

				lid = rs.getInt("id");
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				accjc = CourseACCJCDB.getACCJC(conn,campus,lid,kix,true);

				i = 0;
				v = AssessedDataDB.getAssessedDataVector(conn,lid);
				if (v != null){
					for (Enumeration e = v.elements(); e.hasMoreElements();){
						AssessedData ad = (AssessedData) e.nextElement();
						getQuestions[i++] = AseUtil.nullToBlank(ad.getQuestion());
					}
				}

				slo.append("<tr bgcolor=#e1e1e1><td height=\"8\" colspan=\"2\"></td></tr>");

				if (accjc.getContent()!=null && accjc.getContent().length()>0){
					slo.append("<tr>");
					slo.append("<td height=\"20\" class=\"textblackTH\" width=\"25%\">Content:</td>");
					slo.append("<td class=\"datacolumn\">" + accjc.getContent() + "</td>");
					slo.append("</tr>");
				}

				slo.append("<tr>");
				slo.append("<td height=\"20\" class=\"textblackTH\">Competency:</td>");
				slo.append("<td class=\"datacolumn\">" + accjc.getComp() + "</td>");
				slo.append("</tr>");

				if (accjc.getAssessment()!=null && accjc.getAssessment().length()>0){
					slo.append("<tr>");
					slo.append("<td height=\"20\" class=\"textblackTH\">Assessment Method:</td>");
					slo.append("<td class=\"datacolumn\">" + accjc.getAssessment() + "</td>");
					slo.append("</tr>");
				}

				slo.append("<tr><td height=\"20\" colspan=\"2\"><hr size=\"1\"></td></tr>");

				for(i=0;i<controls;i++){
					slo.append("<tr><td height=\"20\" colspan=\"2\" class=\"textblackTH\">" + (i+1) + ".&nbsp;" + question[i] + "</td></tr>");
					slo.append("<tr><td height=\"20\" colspan=\"2\" class=\"datacolumn\">" + AseUtil.nullToBlank(getQuestions[i]) + "<p>&nbsp;</p></td></tr>");
					// clear this out for the next iteration
					getQuestions[i] = "";
				}

				found = true;
			}	// while

			rs.close();
			ps.close();

			if (found){
				slo.append("</table>");
			}
			else{
				slo.append("<br>SLO does not exist for " + alpha + " " + num + ".");
			}
		}
		catch( SQLException e ){
			logger.fatal("Outlines: viewOutlineSLO\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Outlines: viewOutlineSLO - " + ex.toString());
		}

		return slo;
	}

	/*
	 * showOutlineProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 * @return String
	 */
	public static String showOutlineProgress(Connection conn,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String type = "";
		String campus = "";
		String progress = "";
		String proposer = "";
		String dateproposed = "";
		String auditdate = "";
		boolean found = false;
		int i = 0;
		int j = 0;
		int route = 0;
		String rowColor = "";
		String temp = "";
		String status = "";
		String[] outlineApprovers;

		boolean isSysAdmin = false;
		boolean isCampusAdmin = false;

		Msg msg = new Msg();

		try{
			isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			if(isSysAdmin || isCampusAdmin){
				AseUtil aseUtil = new AseUtil();
				String sql = "SELECT id,campus,CourseAlpha,CourseNum,proposer,progress,dateproposed,auditdate,coursetype " +
					"FROM tblCourse WHERE historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					proposer = aseUtil.nullToBlank(rs.getString("proposer"));
					campus = aseUtil.nullToBlank(rs.getString("campus"));
					type = aseUtil.nullToBlank(rs.getString("coursetype"));

					dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
					if (!"".equals(dateproposed))
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);

					auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
					if (!"".equals(auditdate))
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

					kix = AseUtil.nullToBlank(rs.getString("id"));
					String[] info = Helper.getKixInfo(conn,kix);
					route = Integer.parseInt(info[6]);

					// outline detail
					listing.append("<fieldset class=\"FIELDSET90\">" +
						"<legend>Outline Detail</legend>" +
						"<table summary=\"\" id=\"tableShowOutlineProgress1\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">Outline</td>" +
						"<td class=\"textblackTH\">Progress</td>" +
						"<td class=\"textblackTH\">Proposer</td>" +
						"<td class=\"textblackTH\">Date Proposed</td>" +
						"<td class=\"textblackTH\">Last Updated</td></tr>" +
						"<tr bgcolor=\"#ffffff\">" +
						"<td class=\"datacolumn\">" + alpha + " " + num + "</td>" +
						"<td class=\"datacolumn\">" + progress + "</td>" +
						"<td class=\"datacolumn\">" + proposer + "</td>" +
						"<td class=\"datacolumn\">" + dateproposed + "</td>" +
						"<td class=\"datacolumn\">" + auditdate + "</td>" +
						"</tr></table>" +
						"</fieldset><br><br>");

					// Approvers
					listing.append("<fieldset class=\"FIELDSET90\">"
						+ "<legend>Approvers</legend>"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress2\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Approvers (<font class=\"datacolumn\">click on the approver ID to add an outline approval task</font>)</td></tr>");

					Approver approver = ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);
					outlineApprovers = approver.getAllApprovers().split(",");
					for(i=0;i<outlineApprovers.length;i++){
						listing.append("<tr bgcolor=\"#ffffff\">" +
							"<td class=\"datacolumn\" ><a href=\"/central/servlet/sa?c=ctsk&kix="+kix+"&usr="+outlineApprovers[i]+"\" class=\"linkcolumn\">" + outlineApprovers[i] + "</a></td>" +
							"</tr>");
					}

					listing.append("</table></fieldset><br><br>");

					// Approval History
					listing.append("<fieldset class=\"FIELDSET90\">"
						+ "<legend>Approval History</legend>"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress3\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr height=\"30\" bgcolor=\"#e1e1e1\"><td>Approval History "
						+ "<ul><li>click <img border=\"0\" src=\"../images/undo1.gif\" title=\"recall comment\" /> to recall outline approval(s) back to and including the selected user ID.</li> "
						+ "<li>click <img border=\"0\" src=\"../images/del.gif\" title=\"delete comment\" /> to delete outline approval(s) back to and including the selected user ID.</li> "
						+ "</ul>"
						+ "<br><font class=\"normaltext\">When a user ID is select, CC continues processing with the following steps:"
						+ "<ul><li>remove existing outline approval task (see following section)</li><li>add outline approval task for selected user</li><li>notify completed approvers that the outline has been recalled</li></ul></font></td></tr>");

					if (!"".equals(kix)){
						ArrayList list = HistoryDB.getHistories(conn,kix,type);
						if (list != null){
							History history;
							temp = "";
							for (i=0; i<list.size(); i++){
								history = (History)list.get(i);

								String recallUrl = "";

								if (history.getApproved()){
									status = "Approved";
								}
								else{
									if ((Constant.COURSE_RECALLED).equals(history.getProgress()))
										status = "Recalled";
									else
										status = "Revise";
								}

								if(status.equals("Recalled")){
									recallUrl = "<img border=\"0\" src=\"../images/undo1x.gif\" title=\"recalled comment\" />&nbsp;&nbsp;";
								}
								else{
									recallUrl = "<a href=\"/central/servlet/sa?c=rclhst&kix="+kix+"&id="+history.getID()+"\" class=\"linkcolumn\"><img border=\"0\" src=\"../images/undo1.gif\" title=\"recall comment\" /></a>&nbsp;&nbsp;";
								}

								temp += "<tr>"
									+ "<td valign=\"top\" width=\"20%\">"
									+ "<a href=\"edtcmmnt.jsp?kix="+kix+"&id="+history.getID()+"\" class=\"linkcolumn\"><img border=\"0\" src=\"../images/edit.gif\" title=\"edit comment\" /></a>&nbsp;&nbsp;"
									+ recallUrl
									+ "<a href=\"/central/servlet/sa?c=dlthst&kix="+kix+"&id="+history.getID()+"\" class=\"linkcolumn\"><img border=\"0\" src=\"../images/del.gif\" title=\"delete comment\" /></a>&nbsp;&nbsp;"
									+ history.getDte() + " - " + history.getApprover()
									+ "</td>"
									+ "<td valign=\"top\" width=\"10%\">"
									+ status
									+ "</td>"
									+ "<td valign=\"top\">"
									+ history.getComments()
									+ "</td>"
									+ "</tr>";
							}
						}
					}

					listing.append("<tr height=\"30\" bgcolor=\"#ffffff\">" +
						"<td class=\"datacolumn\" >"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress4\" border=\"0\" cellpadding=\"2\" width=\"100%\">"
						+ temp
						+ "</table>"
						+ "</td>"
						+ "</tr>"
						+ "</table></fieldset><br><br>");

					// user tasks
					listing.append("<fieldset class=\"FIELDSET90\">"
						+ "<legend>User Tasks</legend>"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress5\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr height=\"20\"><td class=\"textblackTH\" >&nbsp;</td></tr>"
						+ "<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Tasks (<font class=\"datacolumn\">click faculty ID to delete the outline approval task</font>)</td></tr>"
						+ "<tr height=\"30\" bgcolor=\"#ffffff\">"
						+ "<td class=\"datacolumn\" >"
						+ TaskDB.showTaskByOutlineSA(conn,campus,alpha,num,kix)
						+ "</td>"
						+ "</tr>"
						+ "</table></fieldset><br><br>");

					// Approved
					listing.append("<fieldset class=\"FIELDSET90\">"
						+ "<legend>Completed Approvals</legend>"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress6\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr height=\"20\"><td class=\"textblackTH\" >&nbsp;</td></tr>"
						+ "<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Approved</td></tr>");

						msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);

					listing.append("<tr height=\"30\" bgcolor=\"#ffffff\">"
						+ "<td class=\"datacolumn\" >" + msg.getErrorLog() + "</td>"
						+ "</tr>"
						+ "</table></fieldset><br><br>");

					// Pending
					listing.append("<fieldset class=\"FIELDSET90\">"
						+ "<legend>Pending Approvals</legend>"
						+ "<table summary=\"\" id=\"tableShowOutlineProgress7\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr height=\"20\"><td class=\"textblackTH\" >&nbsp;</td></tr>"
						+ "<tr height=\"30\" bgcolor=\"#e1e1e1\"><td class=\"textblackTH\" >Pending</td></tr>"
						+ "<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
						+ "<td class=\"datacolumn\" >"
						+ ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route) + "</td>"
						+ "</tr>"
						+ "</table></fieldset>");

					found = true;
				}
				rs.close();
				ps.close();
			} // if admin
		}
		catch(SQLException sx){
			logger.fatal("Outlines: showOutlineProgress - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlineProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = listing.toString();
		else
			temp = "Outline not found";

		return temp;

	} // showOutlineProgress

	/**
	 * showOutlinesModifiedByYear
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesModifiedThisYear(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String num = "";
		String title = "";
		String val = "";
		String sql = "";
		String temp = "";
		String link = "";
		int year = Calendar.getInstance().get(Calendar.YEAR);
		boolean found = false;
		int row = 0;

		PreparedStatement ps;
		ResultSet rs;
		ResultSet rsd;

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT c.historyid,c.coursealpha,c.coursenum,c.coursetitle,val "
				+ "FROM tblCourse c, tblMisc m "
				+ "WHERE c.campus=? AND c.historyid=m.historyid AND "
				+ "YEAR(coursedate)=? ORDER BY c.coursealpha,c.coursenum";

			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,year);
			rs = ps.executeQuery();
			while (rs.next()){

				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				val = aseUtil.nullToBlank(rs.getString("val"));

				temp = "";

				if (val.equals("1"))
					temp = "ALL";
				else{
					sql = "SELECT questionseq, question "
						+ "FROM tblCourseQuestions WHERE campus=? AND "
						+ "questionnumber IN (" + val + ") ORDER BY questionseq";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					rsd = ps.executeQuery();
					while (rsd.next()){
						if ("".equals(temp))
							temp = rsd.getString("question");
						else
							temp = temp + "<br>" + rsd.getString("question");
					}
					rsd.close();
				}

				if (++row % 2 == 0)
					listing.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				else
					listing.append(Constant.TABLE_ROW_START);

				link = "<a href=\"vwcrsy.jsp?kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a>";

				listing.append(Constant.TABLE_CELL_LINK_COLUMN + link + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_DATA_COLUMN + title + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_DATA_COLUMN + temp + Constant.TABLE_CELL_END
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = Constant.TABLE_START
					+ Constant.TABLE_ROW_START_HIGHLIGHT
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Outline" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Title" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Modified Items" + Constant.TABLE_CELL_END
					+ "</tr>"
					+ listing.toString()
					+ Constant.TABLE_END;
			}
			else
				temp = "";
		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlinesModifiedByYear - " + ex.toString());
		}

		return temp;
	}

	/**
	 * outlineEffectiveTerms
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	term		String
	 * <p>
	 * @return	String
	 */
	public static String outlineEffectiveTerms(Connection conn,String campus,String term) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuilder buf = new StringBuilder();

		try{
			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">")
				.append("<div id=\"demo_jui\">")
				.append("<table summary=\"\" id=\"crsrpt_6\" class=\"display\">")
				.append("<thead>")
				.append("<tr>")
				.append("<th align=\"left\">Outline</th>")
				.append("<th align=\"left\">Title</th>")
				.append("<th align=\"left\">Date</th>")
				.append("<th align=\"left\">Proposer</th>")
				.append("<th align=\"left\">Compare</th>")
			 	.append("</tr></thead><tbody>");

			String sql = SQL.EffectiveTerms;
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,term);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("courseAlpha"));
				String num = AseUtil.nullToBlank(rs.getString("courseNum"));
				String title = AseUtil.nullToBlank(rs.getString("courseTitle"));
				String proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				String dateValue = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_SHORT);

				String link = "<a href=\"vwcrsy.jsp?kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a>";

				String compare = "";
				String archived = getMostRecentArchivedCourse(conn,campus,alpha,num);
				if(!archived.equals(Constant.BLANK)){
					compare = "<a href=\"crscmpry.jsp?kix="+kix+"&arc="+archived+"\" class=\"linkcollumn\" target=\"_blank\">"
							+ "<img src=\"../images/archive01.gif\" width=\"18\" height=\"18\" title=\"compare outlines\" alt=\"compare outlines\" border=\"0\">"
							+ "</a>";
				}

				buf.append("<td>").append(link).append("</td>")
					.append("<td>").append(title).append("</td>")
					.append("<td>").append(dateValue).append("</td>")
					.append("<td>").append(proposer).append("</td>")
					.append("<td>").append(compare).append("</td>")
					.append("</tr>");

			}
			rs.close();
			ps.close();

			aseUtil = null;

			buf.append("</tbody></table></div></div>");

		}catch(Exception e){
			logger.fatal("Outline - outlineEffectiveTerms - " + e.toString());
		}

		return buf.toString();

	} // Outline - outlineEffectiveTerms

	/**
	 * outlinePassesValidation
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	boolean
	 */
	public static boolean outlinePassesValidation(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String questionFriendly = "";

		PreparedStatement ps;
		ResultSet rs;
		ResultSet rsValidation;

		boolean passValidation = true;

		/*
			validation of an outline means to check for fields that are required and make
			sure they are there. to do so, take these steps:

			1) read data from the outline in questions (tblcourse)
			2) read data from the table containing required item (vw_OutlineValidation)
			3) for each item found in vw_OutlineValidation, there should be date
				for the column in tblcourse. if not, it does not pass validation

		*/

		try{
			sql = "SELECT * FROM tblcourse WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				sql = "SELECT * FROM vw_OutlineValidation WHERE campus=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				rsValidation = ps.executeQuery();
				while(rsValidation.next()){
					questionFriendly = rsValidation.getString("question_friendly");
					questionFriendly = AseUtil.nullToBlank(rs.getString(questionFriendly));
					if ("".equals(questionFriendly))
						passValidation = false;
				}
				rsValidation.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("Outlines: outlinePassesValidation - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("Outlines: outlinePassesValidation - " + e.toString());
		}

		return passValidation;
	}

	/*
	 * listMyOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	type		String
	 * @param	cllr		String
	 * @param	src		String
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * <p>
	 * @return String
	 */
	public static String listMyOutlines(Connection conn,
														String campus,
														String user,
														String type,
														String cllr,
														String src,
														HttpServletRequest request,
														HttpServletResponse response) throws Exception {

		String temp = "";

		AseUtil aseUtil = new AseUtil();
		HttpSession session = request.getSession(true);

		String sql = "SELECT historyid,CourseAlpha AS [Alpha],CourseNum AS [Number],coursetitle AS [Title] "
			+ "FROM tblCourse "
			+ "WHERE campus='"+ campus + "' AND "
			+ "Proposer='" + user + "' AND "
			+ "CourseType='" + type + "' "
			+ "ORDER BY CourseAlpha, CourseNum";

		Paging paging = new com.ase.paging.Paging();
		paging.setSQL(sql);
		paging.setScriptName("/central/core/" + cllr + ".jsp");
		paging.setDetailLink("/central/core/" + src + ".jsp?x=yda");
		paging.setUrlKeyName("kix");
		paging.setRecordsPerPage(999);
		paging.setNavigation(false);
		temp = paging.showRecords(conn, request, response);
		paging = null;

		return temp;
	}

	/*
	 * countTableItems
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	 public static String countTableItems(Connection conn,String kix)throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String[] mailSQL = new String[20];
		String[] manualSQL = new String[20];

		mailSQL = (Constant.MAIN_TABLES).split(",");
		manualSQL = (Constant.MANUAL_TABLES).split(",");

		int i = 0;
		int counter = 0;

		String sql = "";
		String table = "";

		ResultSet rs = null;
		PreparedStatement ps = null;

		try {
			for(i=0;i<mailSQL.length;i++){
				sql = "SELECT count(historyid) counter "
					+ "FROM " + mailSQL[i] + " "
					+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()){
					counter = rs.getInt("counter");
					buf.append(i + " - " + mailSQL[i] + ": " + counter + "<br>");
				}
				rs.close();
				ps.close();
			}

			for(i=0;i<manualSQL.length;i++){
				sql = "SELECT count(historyid) counter "
					+ "FROM " + manualSQL[i] + " "
					+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()){
					counter = rs.getInt("counter");
					buf.append(i + " - " + manualSQL[i] + ": " + counter + "<br>");
				}
				rs.close();
				ps.close();
			}

		} catch (Exception e) {
			logger.fatal("Outlines: countTableItems - " + e.toString());
		}

		return buf.toString();
	}

	/*
	 * deleteTempOutline
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String deleteTempOutline(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		// identical to the same version below for alpha/num, this code does the same using KIX as the primary driver
		// with kix, there is the ability to use TYPE as part of the delete

		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String rtn = "";

		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";

		boolean debug = false;

		PreparedStatement ps = null;

		try{
			debug = DebugDB.getDebug(conn,"Outlines");

			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];
			campus = info[4];

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");
			totalTables = sql.length;

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
			totalTablesManual = sqlManual.length;

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				// not all tables will have a/n/t so we trap and ignore
				try{
					thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kix + " - deleteTempOutline: DELETE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");

					thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kix + " - deleteTempOutline: DELETE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				catch(SQLException se){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQL[i]+") - " + se.toString());
				}
				catch(Exception e){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQL[i]+") - " + e.toString());
				}
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				// not all tables will have a/n/t so we trap and ignore
				try{
					thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kix + " - deleteTempOutline: DELETE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");

					thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kix + " - deleteTempOutline: DELETE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				catch(SQLException se){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQLManual[i]+") - " + se.toString());
				}
				catch(Exception e){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQLManual[i]+") - " + e.toString());
				}
			}

			thisSQL = "delete from tbltemptext where historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			if (debug) logger.info("Outlines - deleteTempOutline temp text table " + rowsAffected + " row");

			deleteTempOutline(conn,campus,alpha,num);

		} catch (SQLException ex) {
			rtn = "Exception";
			logger.fatal("Outlines - deleteTempOutline: " + ex.toString());
		} catch (Exception e) {
			rtn = "Exception";
			logger.fatal("Outlines - deleteTempOutline: " + e.toString());
		}

		return rtn;
	}

	/*
	 * deleteTempOutline
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String deleteTempOutline(Connection conn,String campus,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String rtn = "";

		boolean debug = false;

		PreparedStatement ps = null;

		try{
			debug = DebugDB.getDebug(conn,"Outlines");

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");
			totalTables = sql.length;

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
			totalTablesManual = sqlManual.length;

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				// not all tables will have a/n/t so we trap and ignore
				try{
					thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("deleteTempOutline: DELETE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");

					thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("deleteTempOutline: DELETE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				catch(SQLException se){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQL[i]+") - " + se.toString());
				}
				catch(Exception e){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQL[i]+") - " + e.toString());
				}
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				// not all tables will have a/n/t so we trap and ignore
				try{
					thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE  campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("deleteTempOutline: DELETE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");

					thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("deleteTempOutline: DELETE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				catch(SQLException se){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQLManual[i]+") - " + se.toString());
				}
				catch(Exception e){
					if (debug) logger.fatal("Outlines - deleteTempOutline table without alpha/num/type ("+tempSQLManual[i]+") - " + e.toString());
				}
			}

		} catch (SQLException ex) {
			rtn = "Exception";
			logger.fatal("Outlines - deleteTempOutline: " + ex.toString());
		} catch (Exception e) {
			rtn = "Exception";
			logger.fatal("Outlines - deleteTempOutline: " + e.toString());
		}

		return rtn;
	}

	/*
	 * insertIntoTemp
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String insertIntoTemp(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select;

		String thisSQL = "";
		String rtn = "";
		String temp = "";

		boolean debug = false;

		PreparedStatement ps = null;

		try{
			debug = DebugDB.getDebug(conn,"Outlines");

			debug = false;

			Outlines.deleteTempOutline(conn,kix);

			sql = Constant.MAIN_TABLES.split(",");
			tempSQL = Constant.TEMP_TABLES.split(",");
			totalTables = sql.length;

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String campus = info[Constant.KIX_CAMPUS];

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				temp = sql[i].toLowerCase();
				if (temp.indexOf("attach") == -1){

					// if we can't copy with full key, use kix
					try{
						thisSQL = "INSERT INTO "
								+ tempSQL[i]
								+ " SELECT * FROM "
								+ sql[i]
								+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info(kix + " - insertIntoTempA ("+temp.replace("tbl","")+") " + (i+1) + " of " + tableCounter + " copies - " + rowsAffected + " rows");
					}
					catch(SQLException e){
						thisSQL = "INSERT INTO "
								+ tempSQL[i]
								+ " SELECT * FROM "
								+ sql[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kix);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info(kix + " - insertIntoTempA ("+temp.replace("tbl","")+") " + (i+1) + " of " + tableCounter + " copies - " + rowsAffected + " rows");
					}

				}
				else{
					if (debug) logger.info(kix + " - insertIntoTempA ("+temp.replace("tbl","")+") " + (i+1) + " of " + tableCounter + " copies - " + rowsAffected + " rows");
				}

			} // for

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				temp = sqlManual[i].toLowerCase();
				if (temp.indexOf("attach") == -1){

					try{
						thisSQL = "INSERT INTO "
								+ tempSQLManual[i]
								+ " SELECT " + select[i] + " FROM "
								+ sqlManual[i]
								+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info(kix + " - insertIntoTempB ("+temp.replace("tbl","")+") " + " of " + tableCounter + " copies - " + rowsAffected + " rows");
					}
					catch(SQLException e){
						thisSQL = "INSERT INTO "
								+ tempSQLManual[i]
								+ " SELECT " + select[i] + " FROM "
								+ sqlManual[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kix);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info(kix + " - insertIntoTempB ("+temp.replace("tbl","")+") " + (i+1) + " of " + tableCounter + " copies - " + rowsAffected + " rows");
					}

				}
				else{
					if (debug) logger.info(kix + " - insertIntoTempB ("+temp.replace("tbl","")+") " + (i+1) + " of " + tableCounter + " copies - " + rowsAffected + " rows");
				}

			} // for

		} catch (SQLException e) {
			rtn = "Exception";
			logger.fatal("Outlines - insertIntoTemp: ("+temp+") " + e.toString());
		} catch (Exception e) {
			rtn = "Exception";
			logger.fatal("Outlines - insertIntoTemp: ("+temp+") " + e.toString());
		}

		return rtn;
	}

	/*
	 * updateTempOutlineType
	 * <p>
	 * @param	conn		Connection
	 * @param	kixNew	String
	 * @param	kixOld	String
	 * @param	type		String
	 * <p>
	 * @return String
	 */
	public static String updateTempOutlineType(Connection conn,String kixNew,String kixOld,String type){

		//Logger logger = Logger.getLogger("test");

		StringBuffer userLog = new StringBuffer();

		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";

		PreparedStatement ps = null;

		try{
			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");
			totalTables = sql.length;

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
			totalTablesManual = sqlManual.length;

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQL[i]
						+ " SET historyid=?,coursetype=?,auditdate=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				ps.setString(2,type);
				ps.setString(3,AseUtil.getCurrentDateTimeString());
				ps.setString(4,kixOld);
				thisSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixNew+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append(thisSQL+"<br>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logger.info(kixOld + " - Outlines - updateTempOutlineType: - UPDATE2A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQLManual[i]
						+ " SET historyid=?,coursetype=?,auditdate=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				ps.setString(2,type);
				ps.setString(3,AseUtil.getCurrentDateTimeString());
				ps.setString(4,kixOld);
				thisSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixNew+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append(thisSQL+"<br>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logger.info(kixOld + " - Outlines - updateTempOutlineType: UPDATE2B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
		} catch (SQLException ex) {
			userLog.append("Outlines - updateTempOutlineType: " + ex.toString() + "<br>");
			logger.fatal("Outlines - updateTempOutlineType: " + ex.toString());
		} catch (Exception e) {
			userLog.append(e.toString() + "<br>");
			logger.fatal("Outlines - updateTempOutlineType: " + e.toString());
		}

		return userLog.toString();
	}

	/*
	 * insertTempToCourse
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return String
	 */
	public static String insertTempToCourse(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		StringBuffer userLog = new StringBuffer();

		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];
		String[] select;
		String thisSQL = "";

		PreparedStatement ps = null;

		try{
			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ tempSQL[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kix);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
				userLog.append(thisSQL+"<br>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logger.info(kix + " -Outlines - insertTempToCourse: INSERT2A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sqlManual[i]
						+ " SELECT " + select[i] + " FROM "
						+ tempSQLManual[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kix);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
				userLog.append(thisSQL+"<br>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logger.info(kix + " - Outlines - insertTempToCourse: INSERT2B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
		} catch (SQLException ex) {
			userLog.append("Outlines - insertTempToCourse: " + ex.toString() + "<br>");
			logger.fatal("Outlines - insertTempToCourse: " + ex.toString());
		} catch (Exception e) {
			userLog.append(e.toString() + "<br>");
			logger.fatal("Outlines - insertTempToCourse: " + e.toString());
		}

		return userLog.toString();
	}

	/*
	 * showDebugProgress
	 * <p>
	 * @param	sql			String
	 * @param	counter		int
	 * @param	step			String
	 * @param	kix			String
	 * @param	historyID	String
	 * <p>
	 * @return String
	 */
	public static void showDebugProgress(String sql,int counter,String step,String kix,String historyID) {

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;
		int type = 1;

		try{
			if (debug){
				sql = sql.replace("SET historyid=?","SET historyid='" + historyID + "'");
				sql = sql.replace("WHERE historyid=?","WHERE historyid='" + kix + "'");

				if (sql.indexOf("id=?")>0)
					sql = sql.replace("SET id=?","SET id='" + historyID + "'");

				if (sql.indexOf("proposer=?")>0)
					sql = sql.replace("proposer=?","proposer='"+Constant.SYSADM_NAME+"'");

				if (sql.indexOf("jsid=?")>0)
					sql = sql.replace("jsid=?","jsid='"+Constant.SYSADM_NAME+"'");

				if (sql.indexOf("assessmentdate=?")>0)
					sql = sql.replace("assessmentdate=?","assessmentdate='"+AseUtil.getCurrentDateTimeString()+"'");

				if (sql.indexOf("coursedate=?")>0)
					sql = sql.replace("coursedate=?","coursedate='"+AseUtil.getCurrentDateTimeString()+"'");

				if (sql.indexOf("dateproposed=?")>0)
					sql = sql.replace("dateproposed=?","dateproposed='"+AseUtil.getCurrentDateTimeString()+"'");

				if (sql.indexOf("auditdate=?")>0)
					sql = sql.replace("auditdate=?","auditdate='"+AseUtil.getCurrentDateTimeString()+"'");

				//if (type==0)
					//out.println(counter + ". " + step + " - " + sql + "<br>");
				//else
					//out.println(sql + "<br>");
			}
		}
		catch(Exception e){
			logger.fatal("showDebugProgress - " + e.toString());
		}
	}

	/*
	 * getTempTableSelects
	 * <p>
	 * @return String[]
	 */
	public static String[] getTempTableSelects() {

		String[] select = new String[5];
		select[Constant.TBLTEMPCOURSEACCJC_INDEX] 		= Constant.TBLTEMPCOURSEACCJC;
		select[Constant.TBLTEMPCOURSECOMPETENCY_INDEX] 	= Constant.TBLTEMPCOURSECOMPETENCY;
		select[Constant.TBLCOURSELINKED_INDEX] 			= Constant.TBLCOURSELINKED;
		select[Constant.TBLCOURSELINKED2_INDEX] 			= Constant.TBLCOURSELINKED2;
		select[Constant.TBLGESLO_INDEX] 						= Constant.TBLGESLO;

		return select;
	}

	/*
	 * showContentAndCompetencies
	 * <p>
	 * @param conn			Connection
	 * @param kix			String
	 * @param compressed boolean
	 * <p>
	 * @return String
	 */
	public static String showContentAndCompetencies(Connection conn,String kix,boolean compressed,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean found = false;
		boolean isConnected = false;
		String sql = "";
		String temp = "";
		String img = "";
		String longcontent = "";
		StringBuffer buffer = new StringBuffer();
		StringBuffer connected = new StringBuffer();

		int i = 0;
		int j = 0;

		String columnTitle = "";
		String tempSticky = "";
		String stickyRow = null;
		StringBuilder stickyBuffer = new StringBuilder();

		try {

			String server = SysDB.getSys(conn,"server");

			String[] info = Helper.getKixInfo(conn,kix);
			String campus = info[Constant.KIX_CAMPUS];
			String linked = "";

			// colect data for rows (going down the left most column)
			String[] xAxis = SQLValues.getTContent(conn,campus,kix,"descr");
			String[] xiAxis = SQLValues.getTContent(conn,campus,kix,"key");

			// colect data for columns
			String[] yAxis = SQLValues.getTCompetency(conn,campus,kix,"descr");
			String[] yiAxis = SQLValues.getTCompetency(conn,campus,kix,"key");

			// used for popup help
			columnTitle = "Competency";
			stickyRow = "<div id=\"stickyComps<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br><| DESCR |></div>";

			if (xAxis!=null && yAxis!=null && yiAxis != null){

				String[] aALPHABETS = (Constant.ALPHABETS).split(",");

				found = true;

				buffer.append(Constant.TABLE_START);

				// print header row
				buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				buffer.append(Constant.TABLE_CELL_HEADER_COLUMN);
				buffer.append("&nbsp;Content/Competency");
				buffer.append(Constant.TABLE_CELL_END);
				for(i=0;i<yAxis.length;i++){
					if (compressed)
						buffer.append("<td class=\"datacolumn\" valign=\"top\" width=\"03%\" data-tooltip=\"stickyComps"+i+"\">" + aALPHABETS[i] + Constant.TABLE_CELL_END);
					else
						buffer.append("<td class=\"datacolumn\" valign=\"top\" width=\"03%\" data-tooltip=\"stickyComps"+i+"\">" + yAxis[i] + Constant.TABLE_CELL_END);

					tempSticky = stickyRow;
					tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
					tempSticky = tempSticky.replace("<| STICKY |>",""+i);
					stickyBuffer.append(tempSticky);
				}
				buffer.append("</tr>");

				// print detail row
				for(i=0;i<xAxis.length;i++){
					connected.setLength(0);
					isConnected = false;

					for(j=0;j<yAxis.length;j++){
						if (Outlines.isCompetencyLinked2Content(conn,kix,xiAxis[i],yiAxis[j])){
							img = "<p align=\"center\"><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" data-tooltip=\"stickyComps"+j+"_"+i+"\" /></p>";
							isConnected = true;
						}
						else
							img = "&nbsp;";

						connected.append(Constant.TABLE_CELL_DATA_COLUMN
							+ img
							+ Constant.TABLE_CELL_END);

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br><br><b><u>Content</u></b><br><br>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);
						stickyBuffer.append(tempSticky);
					}

					if (isConnected)
						linked = "&nbsp;<a href=\"crslnkdxw.jsp?src="
									+ Constant.COURSE_CONTENT
									+ "&kix="+kix
									+ "&level1="+xiAxis[i]+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\"><img src=\"../images/ed_link2.gif\" alt=\"selected\" border=\"0\" /></a>";
					else
						linked = "";

//LINKED ITEM
linked = "";

					buffer.append(Constant.TABLE_ROW_START);
					buffer.append(
								Constant.TABLE_CELL_DATA_COLUMN
							+ 	xAxis[i]
							+ linked
							+ 	Constant.TABLE_CELL_END);

					buffer.append(connected.toString());

					buffer.append("</tr>");
				}

				buffer.append(Constant.TABLE_END);

				if (compressed)
					buffer.append(showLegend(yAxis));

			}

		} catch (SQLException ex) {
			logger.fatal("Outlines: showContentAndCompetencies - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: showContentAndCompetencies - " + e.toString());
		}

		MiscDB.insertSitckyNotes(conn,kix,user,stickyBuffer.toString());

		if (found){
			temp = buffer.toString();
			temp = temp.replace("border=\"0\"","border=\"1\"");
		}

		return temp;
	}

	/*
	 * showLegend - shown as a matrix when connected with competency and more
	 * <p>
	 * @param yAxis	String[]
	 * <p>
	 * @return String
	 */
	public static String showLegend(String[] yAxis) throws Exception {

		String temp = "";

		if (yAxis != null && yAxis.length > 0){
			StringBuffer buffer = new StringBuffer();

			buffer.append("<br><font class=\"textblackth\">LEGEND</font><br>");
			buffer.append("<ol class=\"upper-alpha\">");
			for(int i=0;i<yAxis.length;i++){
				buffer.append("<li class=\"normaltext\">" + yAxis[i] + "</li>");
			}
			buffer.append("</ol>");

			temp = buffer.toString();
		}

		return temp;
	}

	/*
	 * showProgramSLO - shown as a matrix when connected with competency and more
	 * <p>
	 * @param conn			Connection
	 * @param kix			String
	 * @param src			String
	 * @param compressed	boolean
	 * <p>
	 * @return String
	 */
	public static String showProgramSLO(Connection conn,String kix,String src,boolean compressed,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean found = false;
		boolean isConnected = false;
		String sql = "";
		String temp = "";
		String img = "";

		StringBuffer buffer = new StringBuffer();
		StringBuffer connected = new StringBuffer();
		int i = 0;
		int j = 0;

		String columnTitle = "";
		String tempSticky = "";
		String stickyRow = null;
		StringBuilder stickyBuffer = new StringBuilder();

		try {
			String server = SysDB.getSys(conn,"server");

			String[] info = Helper.getKixInfo(conn,kix);
			String campus = info[Constant.KIX_CAMPUS];

			String linked = "";

			// colect data for rows (going down the left most column)
			String[] xAxis = SQLValues.getTGenericContent(conn,campus,kix,src,"descr");
			String[] xiAxis = SQLValues.getTGenericContent(conn,campus,kix,src,"key");

			// colect data for columns
			String[] yAxis = SQLValues.getTCompetency(conn,campus,kix,"descr");
			String[] yiAxis = SQLValues.getTCompetency(conn,campus,kix,"key");

			// used for popup help
			columnTitle = "Competency";
			stickyRow = "<div id=\"sticky"+src+"<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br><| DESCR |></div>";

			if (xAxis!=null && xiAxis!=null && yAxis!=null && yiAxis!=null){

				String[] aALPHABETS = (Constant.ALPHABETS).split(",");

				found = true;

				// print header row
				buffer.append(Constant.TABLE_START);
				buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				buffer.append(Constant.TABLE_CELL_HEADER_COLUMN);
				buffer.append("&nbsp;ProgramSLO/Competency");
				buffer.append(Constant.TABLE_CELL_END);

				for(i=0;i<yAxis.length;i++){
					if (compressed)
						buffer.append("<td class=\"datacolumn\" valign=\"top\" width=\"03%\" data-tooltip=\"sticky"+src+""+i+"\">" + aALPHABETS[i] + Constant.TABLE_CELL_END);
					else
						buffer.append("<td class=\"datacolumn\" valign=\"top\" width=\"03%\" data-tooltip=\"sticky"+src+""+i+"\">" + yAxis[i] + Constant.TABLE_CELL_END);

					tempSticky = stickyRow;
					tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
					tempSticky = tempSticky.replace("<| STICKY |>",""+i);
					stickyBuffer.append(tempSticky);
				}
				buffer.append("</tr>");

				// print detail row
				for(i=0;i<xAxis.length;i++){
					connected.setLength(0);
					isConnected = false;

					for(j=0;j<yAxis.length;j++){

						if (Outlines.isProgramSLOLinked(conn,kix,src,src,xiAxis[i],yiAxis[j])){
							img = "<p align=\"center\"><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" data-tooltip=\"sticky"+src+""+j+"_"+i+"\" /></p>";
							isConnected = true;
						}
						else
							img = "&nbsp;";

						connected.append(Constant.TABLE_CELL_DATA_COLUMN
							+ img
							+ Constant.TABLE_CELL_END);

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br><br><b><u>Program SLO</u></b><br><br>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);
						stickyBuffer.append(tempSticky);
					}

					if (isConnected)
						linked = "&nbsp;<a href=\"crslnkdxw.jsp?src="
							+ Constant.COURSE_PROGRAM_SLO
							+ "&kix="+kix
							+ "&level1="+xiAxis[i]+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\"><img src=\"../images/ed_link2.gif\" alt=\"selected\" border=\"0\" /></a>";
					else
						linked = "";

//LINKED ITEM
linked = "";

					buffer.append(Constant.TABLE_ROW_START);
					buffer.append(
								Constant.TABLE_CELL_DATA_COLUMN
							+ 	xAxis[i]
							+ linked
							+ 	Constant.TABLE_CELL_END);

					buffer.append(connected.toString());

					buffer.append("</tr>");
				}
				buffer.append(Constant.TABLE_END);

				if (compressed)
					buffer.append(showLegend(yAxis));
			}

		} catch (SQLException ex) {
			logger.fatal("Outlines: showProgramSLO - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: showProgramSLO - " + e.toString());
		}

		MiscDB.insertSitckyNotes(conn,kix,user,stickyBuffer.toString());

		if (found){
			temp = buffer.toString();
			temp = temp.replace("border=\"0\"","border=\"1\"");
		}
		else{
			temp = Outlines.showProgramSLOX(conn,kix,src);
		}

		return temp;
	}

	/*
	 * showProgramSLOX - shown as a list when not connection with other items
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param src	String
	 * <p>
	 * @return String
	 */
	public static String showProgramSLOX(Connection conn,String kix,String src) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean found = false;
		String sql = "";
		String temp = "";
		String comments = "";
		StringBuffer buffer = new StringBuffer();

		try {
			sql = "SELECT comments "
				+ "FROM tblGenericContent "
				+ "WHERE historyid=? "
				+ "AND src=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,Constant.COURSE_PROGRAM_SLO);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				comments = AseUtil.nullToBlank(rs.getString("comments"));
				buffer.append("<li>" + comments + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				temp = "<ul>" + buffer.toString() + "</ul>";

		} catch (SQLException ex) {
			logger.fatal("Outlines: showProgramSLOX - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: showProgramSLOX - " + e.toString());
		}

		return temp;
	}

	/*
	 * isCompetencyLinked2Content
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param x			String
	 * @param y			String
	 * <p>
	 * @return boolean
	 */
	public static boolean isCompetencyLinked2Content(Connection conn,String kix,String x, String y) throws SQLException {

		// when y is 0, we are only looking at the high level link.
		// when y is a value, we want to know whether if there are linked items

		int ix = 0;
		int iy = 0;

		String sql = "";
		PreparedStatement ps = null;
		boolean exists = false;

		try{

			ix = Integer.parseInt(x);
			iy = Integer.parseInt(y);

			if (iy>0){
				sql = "SELECT linkedid FROM vw_LinkedContent2Compentency "
					+ "WHERE historyid=? AND contentid=? AND linked2item=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,ix);
				ps.setInt(3,iy);
			}
			else{
				sql = "SELECT linkedid "
					+ "FROM vw_LinkedContent2Compentency "
					+ "WHERE historyid=? "
					+ "AND contentid=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,ix);
			}

			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();

		}
		catch(SQLException se){
			logger.fatal("");
		}
		catch(Exception e){
			logger.fatal("");
		}

		return exists;
	}

	/*
	 * isProgramSLOLinked
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param fromSrc	String
	 * @param toSrc	String
	 * @param x			String
	 * @param y			String
	 * <p>
	 * @return boolean
	 */
	public static boolean isProgramSLOLinked(Connection conn,String kix,String fromSrc,String toSrc,String x, String y) throws SQLException {

		// when y is 0, we are only looking at the high level link.
		// when y is a value, we want to know whether if there are linked items

		int ix = 0;
		int iy = 0;

		String sql = "";
		PreparedStatement ps = null;
		boolean exists = false;

		try{

			ix = Integer.parseInt(x);
			iy = Integer.parseInt(y);

			if (iy>0){
				sql = "SELECT id FROM vw_LinkedCompetency2PSLO "
					+ "WHERE historyid=? AND fromSrc=? AND toSrc=? AND seq=? AND item=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,fromSrc);
				ps.setString(3,toSrc);
				ps.setInt(4,ix);
				ps.setInt(5,iy);
			}
			else{
				sql = "SELECT id FROM vw_LinkedCompetency2PSLO "
					+ "WHERE historyid=? AND fromSrc=? AND toSrc=? AND seq=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,fromSrc);
				ps.setString(3,toSrc);
				ps.setInt(4,ix);
			}

			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("Outlines - isProgramSLOLinked: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("Outlines - isProgramSLOLinked: " + e.toString());
		}

		return exists;
	}

	/*
	 * isProgramSLOLinked
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param src	String
	 * @param x		String
	 * @param y		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isProgramSLOLinked(Connection conn,String kix,String src,String x, String y) throws SQLException {

		String sql = "SELECT id FROM vw_GenericContent2Linked "
			+ "WHERE historyid=? AND src=? AND seq=? AND item=? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,src);
		ps.setString(3,x);
		ps.setString(4,y);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * listAssignedTasks
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	fromName	String
	 *	@param	toName	String
	 * <p>
	 *	@return String
	 */
	public static String listAssignedTasks(Connection conn,String campus,String fromName,String toName) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int i = 0;

		boolean found = false;

		String outline = "";
		String formKey = "";
		String bgColor = "";
		StringBuffer buf = new StringBuffer();

		try{
			buf.append("<form name=\"aseForm\" method=\"post\" action=\"crsrssy.jsp\">" );
			buf.append("<table summary=\"\" width=\"60%\" cellspacing='0' cellpadding='4' border=\"0\">" );
			buf.append("<tr class=\"even\"><td valign=\"top\" width=\"5%\" height=\"30\">"
				+ "<input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\" title=\"select all/deselect all\" />"
				+ "</td>"
				+ "<td valign=\"top\" width=\"20%\" class=\"textblackth\">Outline</td>"
				+ "<td valign=\"top\" width=\"80%\" class=\"textblackth\">Title</td>"
				+ "</tr>");

			String sql = "SELECT historyid,coursealpha,coursenum,coursetitle "
				+ "FROM tblCourse WHERE campus=? AND proposer=? AND coursetype='PRE' "
				+ "ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,fromName);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				if (i++ % 2 == 0)
					bgColor = "odd";
				else
					bgColor = "even";

				outline = AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum"));
				formKey = outline.replace(" ","_");

				buf.append("<tr class=\"" + bgColor + "\"><td valign=\"top\" width=\"5%\" height=\"30\">"
					+ "<input type=\"checkbox\" name=\"box_" + i + "\" value=\"" + formKey + "\">"
					+ "</td>"
					+ "<td valign=\"top\" width=\"20%\" class=\"datacolumn\">" + outline + "</td>"
					+ "<td valign=\"top\" width=\"80%\" class=\"datacolumn\">" + rs.getString("coursetitle") + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				buf.append("<tr><td valign=\"top\" colspan=\"3\" height=\"30\">"
					+ "<input type=\"hidden\" name=\"controls\" value=\"" + i + "\">"
					+ "<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">"
					+ "<input type=\"hidden\" name=\"fromName\" value=\"" + fromName + "\">"
					+ "<input type=\"hidden\" name=\"toName\" value=\"" + toName + "\">"
					+ "<input type=\"hidden\" name=\"formName\" value=\"aseForm\">"
					+ "<input type=\"hidden\" name=\"formAction\" value=\"s\">"
					+ "</td>"
					+ "</tr>");

				buf.append("<tr><td align=\"right\" colspan=\"3\" height=\"30\">"
					+ "<input type=\"submit\" name=\"aseSubmit\" value=\"Reassign\" class=\"input\">&nbsp;"
					+ "<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"input\" onClick=\"return cancelForm();\">"
					+ "</td>"
					+ "</tr>");
			}

			buf.append( "</table></form>" );
		}
		catch( Exception ex ){
			logger.fatal("Outlines: listAssignedTasks - " + ex.toString());
		}

		return buf.toString();

	}

	/*
	 * reassignOwnership
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 *	@param	fromName	String
	 *	@param	toName	String
	 *	@param	alpha		String
	 *	@param	num		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg reassignOwnership(Connection conn,
													String campus,
													String user,
													String fromName,
													String toName,
													String alpha,
													String num) throws Exception {


		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		String kix = "";

		// we never would reassign once approved
		String type = "PRE";

		boolean debug = false;

		conn.setAutoCommit(false);

		try {
			debug = DebugDB.getDebug(conn,"Outlines");

			kix = Helper.getKix(conn,campus,alpha,num,type);

			if (debug) logger.info(kix + " - " + user + " - REASSIGNOWNERSHIP - STARTS");

			// change names for courses pending
			String sql = "UPDATE tblCourse SET proposer=? WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership course - " + rowsAffected + " row(s).");

			// change names for tasks pending
			sql = "UPDATE tblTasks SET submittedfor=?,submittedby=? "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND submittedfor=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,toName);
			ps.setString(3,campus);
			ps.setString(4,alpha);
			ps.setString(5,num);
			ps.setString(6,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership task created - " + rowsAffected + " row(s).");

			// change names for reviews pending
			sql = "UPDATE tblReviewers SET userid=? WHERE campus=? AND userid=? AND coursealpha=? AND coursenum=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,campus);
			ps.setString(3,fromName);
			ps.setString(4,alpha);
			ps.setString(5,num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership reviewer notes transferred - " + rowsAffected + " row(s).");
			ps.close();

			// change names for forum
			sql = "UPDATE forums SET creator=? WHERE historyid=? AND (status<>'Closed' AND status<>'Completed')";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forums - " + rowsAffected + " row(s).");
			ps.close();

			// forum members
			sql = "UPDATE forumsx SET userid=? WHERE userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum members - " + rowsAffected + " row(s).");
			ps.close();

			// update forum messagse
			sql = "UPDATE messages SET message_author=? WHERE message_author=? AND closed=0";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum messages - " + rowsAffected + " row(s).");
			ps.close();

			// delete from message notification to force new owner to read
			sql = "DELETE FROM messagesX WHERE author=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum notification - " + rowsAffected + " row(s).");
			ps.close();

			conn.commit();

			MailerDB mailerDB = new MailerDB(conn,
														fromName,
														toName,
														"",
														"",
														alpha,
														num,
														campus,
														"emailOutlineReassigned",
														kix,
														user);

			AseUtil.logAction(conn, user, "ACTION","Outline Reassigned ("+ fromName + " to " + toName + ")",alpha,num,campus,kix);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("Outlines: reassignOwnership - " + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
			logger.info("Outlines: reassignOwnership - Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("Outlines: reassignOwnership - " + e.toString());

			try {
				conn.rollback();
				logger.info("Outlines: reassignOwnership - Rolling back transaction\n");
			} catch (SQLException exp) {
				logger.fatal("Outlines: reassignOwnership - " + exp.toString());
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

	/*
	 * deleteLinkedItems
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	src		String
	 * <p>
	 *	@return int
	 */
	public static int deleteLinkedItems(Connection conn,String campus,String kix,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// tblCourseLinked2 is cleared with each save during maintenance so it is not
		// necessary to delete here.

		try{
			String sql = "DELETE FROM tblCourseLinked "
				+ "WHERE campus=? AND historyid=? AND src=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (src.equalsIgnoreCase(Constant.COURSE_OBJECTIVES))
				CompDB.deleteObjectives(conn,campus,kix);
			else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT))
				ContentDB.deleteContents(conn,campus,kix);
			else if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES))
				CompetencyDB.deleteCompetencies(conn,campus,kix);
			else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || src.equalsIgnoreCase(Constant.IMPORT_PLO))
				GenericContentDB.deleteContents(conn,campus,kix,src);
			else if (src.equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || src.equalsIgnoreCase(Constant.IMPORT_ILO))
				GenericContentDB.deleteContents(conn,campus,kix,src);
		}
		catch( Exception ex ){
			logger.fatal("Outlines: deleteLinkedItems - " + ex.toString());
		}

		return rowsAffected;

	}

	/**
	 * showOutlinesModifiedByAcademicYear
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	fromDate		String
	 * @param	toDate		String
	 * @param	showItems	boolean	(not used)
	 * @param	progress		String
	 * @param	semester		String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesModifiedByAcademicYear(Connection conn,
																				String campus,
																				String fromDate,
																				String toDate,
																				boolean showItems,
																				String progress){

		return showOutlinesModifiedByAcademicYear(conn,campus,fromDate,toDate,showItems,progress,"");

	}

	public static String showOutlinesModifiedByAcademicYear(Connection conn,
																				String campus,
																				String fromDate,
																				String toDate,
																				boolean showItems,
																				String progress,
																				String semester){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String val = "";
		String link = "";
		int year = Calendar.getInstance().get(Calendar.YEAR);

		String dateField = "";

		StringBuilder buf = new StringBuilder();

		try{
			AseUtil aseUtil = new AseUtil();

			String jqTable = "crsrpt_5";

			if (showItems){
				jqTable = "crsrpt_5x";
			}

			if (progress.equals(Constant.COURSE_DELETE_TEXT)){
				jqTable = "crsrpt_5y";
			}

			buf.append("<div id=\"container90\">")
				.append("<div id=\"demo_jui\">")
				.append("<table summary=\"\" id=\""+jqTable+"\" class=\"display\">")
				.append("<thead>")
				.append("<tr>")
				.append("<th align=\"left\">Outline</th>")
				.append("<th align=\"left\">Title</th>")
				.append("<th align=\"left\">Date</th>")
				.append("<th align=\"left\">Proposer</th>")
				.append("<th align=\"left\">Progress</th>")
				.append("<th align=\"left\">Term</th>");

			if (showItems){
				buf.append("<th>Modified Items</th>");
			}

			if (!progress.equals(Constant.COURSE_DELETE_TEXT)){
				buf.append("<th>Compare</th>");
			}

			buf.append("</tr></thead><tbody>");

			if (progress.equals(Constant.COURSE_APPROVED_TEXT)){
				dateField = "coursedate";
			}
			else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
				dateField = "coursedate";
			}
			else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
				dateField = "auditdate";
			}
			else{
				dateField = "auditdate";
			}

			String sql = SQL.showOutlinesModifiedByAcademicYear(progress,semester);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,fromDate);
			ps.setString(3,toDate);

			if(semester != null && semester.length() > 0){
				ps.setString(4,semester);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				String kix = aseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = aseUtil.nullToBlank(rs.getString("coursenum"));
				String title = aseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				String proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				String courseProgress = aseUtil.nullToBlank(rs.getString("progress"));
				String term = aseUtil.nullToBlank(rs.getString("effectiveterm"));
				term = BannerDataDB.getBannerDescr(conn,"bannerterms",term);

				String dateValue = aseUtil.ASE_FormatDateTime(rs.getString(dateField),Constant.DATE_SHORT);

				link = "<a href=\"/central/core/vwhtml.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a>";

				String compare = "";
				String archived = "";
				if (!progress.equals(Constant.COURSE_DELETE_TEXT)){
					archived = getMostRecentArchivedCourse(conn,campus,alpha,num);
					if(!archived.equals(Constant.BLANK)){
						compare = "<a href=\"crscmpry.jsp?kix="+kix+"&arc="+archived+"\" class=\"linkcollumn\" target=\"_blank\">"
								+ "<img src=\"../images/archive01.gif\"  width=\"18\" height=\"18\" title=\"compare outlines\" alt=\"compare outlines\" border=\"0\">"
								+ "</a>";
					}
				}

				buf.append("<tr>")
					.append("<td align=\"left\">" + link + "</a></td>")
					.append("<td align=\"left\">" + title + "</td>")
					.append("<td align=\"left\">" + dateValue + "</td>")
					.append("<td align=\"left\">" + proposer + "</td>")
					.append("<td align=\"left\">" + courseProgress + "</td>")
					.append("<td align=\"left\">" + term + "</td>");

				if (!progress.equals(Constant.COURSE_DELETE_TEXT)){
					buf.append("<td align=\"left\">" + compare + "</td>");
				}

				if (showItems){
					buf.append("<td>&nbsp;</td>");
				}

				buf.append("</tr>");

			}
			rs.close();
			ps.close();

			buf.append("</tbody></table></div></div>");

			aseUtil = null;

		}
		catch(SQLException ex){
			logger.fatal("Outlines: showOutlinesModifiedByAcademicYear - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlinesModifiedByAcademicYear - " + ex.toString());
		}

		return buf.toString();
	}

	/*
	 * showMethodEval
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param src	String
	 * <p>
	 * @return String
	 */
	public static String showMethodEval(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		boolean found = false;
		String sql = "";
		String temp = "";
		String img = "";

		StringBuffer buffer = new StringBuffer();
		int i = 0;
		int j = 0;

		try {
			String server = SysDB.getSys(conn,"server");

			AseUtil aseUtil = new AseUtil();

			String[] xAxis = SQLValues.getTComp(conn,campus,kix,"descr");
			String[] xiAxis = SQLValues.getTComp(conn,campus,kix,"key");

			String[] yAxis = SQLValues.getTINIMethodEval(conn,campus,kix,"descr");
			String[] yiAxis = SQLValues.getTINIMethodEval(conn,campus,kix,"key");

			String[] zAxis = SQLValues.getTCompetency(conn,campus,kix,"descr");
			String[] ziAxis = SQLValues.getTCompetency(conn,campus,kix,"key");

			if (yAxis!=null){

				// print header row
				buffer.append("<table summary=\"\" id=\"tableShowMethodEval\" width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");

				buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				buffer.append("<td class=\"textblackth\">Method of Evaluation</td>");
				for(i=0;i<yAxis.length;i++){
					buffer.append(Constant.TABLE_CELL_DATA_COLUMN
										+ yAxis[i]
										+ Constant.TABLE_CELL_END);
				}
				buffer.append("</tr>");

				if (xAxis!=null){
					buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
					buffer.append("<td class=\"textblackth\" colspan=\""+(yAxis.length+1)+"\">Course SLOs</td>");
					buffer.append("</tr>");

					for(i=0;i<xAxis.length;i++){
						buffer.append(Constant.TABLE_ROW_START);
						buffer.append(Constant.TABLE_CELL_DATA_COLUMN + xAxis[i] + Constant.TABLE_CELL_END);

						for(j=0;j<yAxis.length;j++){
							if (isMethodEvalLinked2SLO(conn,kix,xiAxis[i],yiAxis[j]))
								img = "<p align=\"center\"><br><br><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border='0' /></p>";
							else
								img = "&nbsp;";

							buffer.append(Constant.TABLE_CELL_DATA_COLUMN
								+ img
								+ Constant.TABLE_CELL_END);
						}
						buffer.append("</tr>");
					}
				} // xAxis!=null

				if (zAxis!=null){
					//showMethodEval
					buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
					buffer.append("<td class=\"textblackth\" colspan=\""+(yAxis.length+1)+"\">Course Competencies</td>");
					buffer.append("</tr>");

					for(i=0;i<zAxis.length;i++){
						buffer.append(Constant.TABLE_ROW_START);
						buffer.append(Constant.TABLE_CELL_DATA_COLUMN + zAxis[i] + Constant.TABLE_CELL_END);

						for(j=0;j<yAxis.length;j++){
							if (isMethodEvalLinked2Competency(conn,kix,ziAxis[i],yiAxis[j]))
								img = "<p align=\"center\"><br><br><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border='0' /></p>";
							else
								img = "&nbsp;";

							buffer.append(Constant.TABLE_CELL_DATA_COLUMN
								+ img
								+ Constant.TABLE_CELL_END);
						}
						buffer.append("</tr>");
					} // for
				}

				buffer.append("</table>");
			}

		} catch (SQLException e) {
			logger.fatal("Outlines.showMethodEval ("+kix+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("Outlines.showMethodEval ("+kix+"): " + e.toString());
		}

		temp = buffer.toString();

		temp = temp.replace("border=\"0\"","border=\"1\"");

		return temp;
	}

	/*
	 * isMethodEvalLinked2Competency
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param x			String
	 * @param y			String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMethodEvalLinked2Competency(Connection conn,String kix,String x, String y) throws SQLException {

		String sql = "SELECT seq "
			+ "FROM vw_LinkedCompetency2MethodEval "
			+ "WHERE historyid=? "
			+ "AND contentid=? "
			+ "AND seq=? ";

		String methodEvals = CourseDB.getCourseItem(conn,kix,Constant.COURSE_METHODEVALUATION);

		if (methodEvals != null && methodEvals.length() > 0){

			try{
				String[] split = SQLValues.splitMethodEval(methodEvals);
				if (split != null){
					methodEvals = split[0];
				}
			}
			catch(Exception e){
				//
			}

			sql += "AND iniID IN ("+methodEvals+") ";
		}

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setInt(2,Integer.parseInt(y));
		ps.setInt(3,Integer.parseInt(x));
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * isMethodEvalLinked2SLO
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param x			String
	 * @param y			String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMethodEvalLinked2SLO(Connection conn,String kix,String x, String y) throws SQLException {

		String sql = "SELECT seq FROM vw_LinkedSLO2MethodEval "
			+ "WHERE historyid=? AND contentid=? AND seq=? ";

		String methodEvals = CourseDB.getCourseItem(conn,kix,Constant.COURSE_METHODEVALUATION);

		if (methodEvals != null && methodEvals.length() > 0){

			try{
				String[] split = SQLValues.splitMethodEval(methodEvals);
				if (split != null){
					methodEvals = split[0];
				}
			}
			catch(Exception e){
				//
			}

			sql += "AND iniID IN ("+methodEvals+") ";
		}

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setInt(2,Integer.parseInt(y));
		ps.setInt(3,Integer.parseInt(x));
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * showOutlinesFastTracked
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	fromDate	String
	 * @param	toDate	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesFastTracked(Connection conn,String campus,String fromDate,String toDate){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String num = "";
		String title = "";
		String dte = "";
		String sql = "";
		String temp = "";
		String link = "";
		int year = Calendar.getInstance().get(Calendar.YEAR);
		boolean found = false;
		int row = 0;

		PreparedStatement ps;
		ResultSet rs;
		ResultSet rsd;

		try{
			AseUtil aseUtil = new AseUtil();

			sql = "SELECT * "
				+ "FROM (SELECT DISTINCT ta.campus, ta.historyid, ta.coursealpha, ta.coursenum, tblCourse.proposer,  "
				+ "tblCourse.Progress, tblCourse.coursedate, tblCourse.coursetitle "
				+ "FROM tblApprovalHist ta INNER JOIN "
				+ "tblCourse ON ta.historyid = tblCourse.historyid "
				+ "WHERE (ta.campus=? "
				+ "AND (YEAR(coursedate) BETWEEN ? AND ?) "
				+ "AND ta.comments LIKE '%Fast Track Approval%') "
				+ "UNION "
				+ "SELECT DISTINCT ta2.campus, ta2.historyid, ta2.coursealpha, ta2.coursenum, tblCourse.proposer,  "
				+ "tblCourse.Progress, tblCourse.coursedate, tblCourse.coursetitle "
				+ "FROM tblApprovalHist2 ta2 INNER JOIN "
				+ "tblCourse ON ta2.historyid = tblCourse.historyid "
				+ "WHERE (ta2.campus=? "
				+ "AND (YEAR(coursedate) BETWEEN ? AND ?) "
				+ "AND ta2.comments LIKE '%Fast Track Approval%')) DT "
				+ "ORDER BY campus, coursealpha, coursenum ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,fromDate);
			ps.setString(3,toDate);
			ps.setString(4,campus);
			ps.setString(5,fromDate);
			ps.setString(6,toDate);
			rs = ps.executeQuery();
			while (rs.next()){

				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				dte = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME);

				if (++row % 2 == 0)
					listing.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				else
					listing.append(Constant.TABLE_ROW_START);

				link = "<a href=\"vwcrsy.jsp?kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a>";

				listing.append(Constant.TABLE_CELL_LINK_COLUMN + link + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_DATA_COLUMN + title + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_DATA_COLUMN + dte + Constant.TABLE_CELL_END
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = Constant.TABLE_START
					+ Constant.TABLE_ROW_START_HIGHLIGHT
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Outline" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Title" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Approved Date" + Constant.TABLE_CELL_END
					+ "</tr>"
					+ listing.toString()
					+ Constant.TABLE_END;
			}
			else
				temp = "Outlines not found";
		}
		catch(Exception ex){
			logger.fatal("Outlines: showOutlinesFastTracked - " + ex.toString());
		}

		return temp;
	}

	/*
	 * isExperimental
	 * <p>
	 * @param num	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isExperimental(String num) throws SQLException {

		boolean experimental = false;

		if (num.indexOf("97") > -1 || num.indexOf("98") > -1)
			experimental = true;

		return experimental;
	}

	/**
	 * getRoute - returns the route for this outline
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int getRoute(Connection conn,String kix){

		int route = 0;

		try{
			String sql = "SELECT route FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				route = rs.getInt(1);
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("Outlines: getRoute - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("Outlines: getRoute - " + ex.toString());
		}

		return route;
	}

	/**
	 * setSubProgress
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	subProgress	String
	 * <p>
	 * @return	int
	 */
	public static int setSubProgress(Connection conn,String kix,String subProgress){

		int rowsAffected = 0;

		try{
			String sql = "UPDATE tblCourse SET subprogress=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,subProgress);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("Outlines: setSubProgress - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("Outlines: setSubProgress - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * getSubProgress
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * <p>
	 * @return	String
	 */
	public static String getSubProgress(Connection conn,String kix){

		String subProgress = "";

		try{
			String sql = "SELECT subProgress FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				subProgress = AseUtil.nullToBlank(rs.getString(1));
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("Outlines: getSubProgress - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("Outlines: getSubProgress - " + ex.toString());
		}

		return subProgress;
	}

	/**
	 * copyOutlineItems	- copy individual outline items
	 * <p>
	 * @param	conn		Connection
	 * @param	request	HttpServletRequest
	 * @param	user		String
	 * <p>
	 * @return	Msg
	 */
	public static Msg copyOutlineItems(Connection conn,HttpServletRequest request,String user){

		int rowsAffected = 0;
		int i = 0;
		String temp = "";

		WebSite ws = new WebSite();
		Msg msg = new Msg();

		try{
			AseUtil aseUtil = new AseUtil();

			String kixSource = ws.getRequestParameter(request,"kixSource","");
			String kixDestination = ws.getRequestParameter(request,"kixDestination","");
			String input = ws.getRequestParameter(request,"input","");

			String[] a_input = input.split(",");
			String sql = "SELECT " + input + " "
				+ "FROM tblCourseCC2 c, tblCampusDataCC2 s "
				+ "WHERE c.historyid = s.historyid "
				+ "AND c.historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kixSource);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				PreparedStatement ps2 = null;
				String table = "";
				String data = "";

				for(i=0; i<a_input.length; i++){
					// remove qualified column names before using field to retrieve
					// data from resultset. column names are c.NAME or s.NAME
					temp = a_input[i];
					temp = temp.substring(temp.indexOf(".")+1,temp.length());

					if (a_input[i].indexOf("c.")>-1)
						table = "tblCourse";
					else if (a_input[i].indexOf("s.")>-1)
						table = "tblCampusData";

					data = aseUtil.nullToBlank(rs.getString(temp));

					sql = "UPDATE " + table + " "
						+ "SET " + temp + "=? "
						+ "WHERE historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,data);
					ps2.setString(2,kixDestination);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
					logger.info(user + " - copying from " + kixSource + " to " + kixDestination + " for item: " + a_input[i]);
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			msg.setMsg("Exception");
			logger.fatal("Outlines: copyOutlineItems - " + se.toString());
		}
		catch(Exception ex){
			msg.setMsg("Exception");
			logger.fatal("Outlines: copyOutlineItems - " + ex.toString());
		}

		return msg;
	}

	/*
	 * showOutlineItems - compares source and destination kix. The source is the on to be copied from.
	 *	<p>
	 *	@param	conn				Connection
	 *	@param	kixSource		String
	 *	@param	kixDestination	String
	 *	@param	user				String
	 *	@param	compressed		boolean
	 *	<p>
	 * @return Msg
	 */
	public static Msg showOutlineItems(Connection conn,String kixSource,String kixDestination,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\""+Constant.COLOR_LEFT+"\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"#e1e1e1\" valign=\"top\">"
			+"<input type=\"checkbox\" value=\"1\" name=\"<| inputName |>\">"
			+"</td>"
			+"<td class=\"datacolumn\" bgcolor=\""+Constant.COLOR_RIGHT+"\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";

		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfoFromOldCC(conn,kixSource);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[4];

		int td = 0;
		String cd = "";
		String[] id = Helper.getKixInfo(conn,kixDestination);
		td = ConstantDB.getConstantTypeFromString(is[2]);
		cd = id[4];

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,cs).split(",");
		String[] dataSource = null;
		String[] dataDestination = null;

		try {
			dataSource = getOutlineData(conn,kixSource,ts,user,true,false);
			dataDestination = getOutlineData(conn,kixDestination,td,user,false,false);

			// clear place holder or items without any data from the template
			for(i=0;i<dataSource.length;i++){
				t1 = row1;
				t2 = row2;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				t1 = t1.replace("<| counter |>",(""+(i+1)));
				t1 = t1.replace("<| question |>",question+"<br><br>");
				t2 = t2.replace("<| answer1 |>",dataSource[i]+"<br><br>");
				t2 = t2.replace("<| answer2 |>",dataDestination[i]+"<br><br>");
				t2 = t2.replace("<| inputName |>",columnNames[i]);

				buf.append(t1);
				buf.append(t2);
			}

			msg.setErrorLog("<form name=\"aseForm\" action=\"cmpry.jsp\"  method=\"post\">"
								+ "<table summary=\"\" id=\"tableShowOutlineItems\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"4\">"
								+ "<tr>"
								+"<td height=\"20\" class=\"textblackTH\" align=\"left\" valign=\"top\" colspan=\"4\">"
								+"Instructions: place check marks on items you wish to have copied from SOURCE to DESTINATION outlines."
								+"<br><br></td>"
								+"</tr>"
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+Constant.COLOR_LEFT+"\" valign=\"top\" width=\"45%\">SOURCE</td>"
								+"<td align=\"center\" bgcolor=\"#e1e1e1\" valign=\"top\" width=\"08%\">COPY</td>"
								+"<td class=\"textblackth\" bgcolor=\""+Constant.COLOR_RIGHT+"\" valign=\"top\" width=\"45%\">DESTINATION</td>"
								+"</tr>"
								+ buf.toString()
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td colspan=\"4\" align=\"right\">"
								+ "<input type=\"hidden\" name=\"kixDestination\" value=\""+kixDestination+"\">"
								+ "<input type=\"hidden\" name=\"kixSource\" value=\""+kixSource+"\">"
								+ "<br><input title=\"transfer data\" type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\">"
								+ "&nbsp;&nbsp;<input title=\"cancel current operation\" type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return cancelForm()\">"
								+ "&nbsp;</td>"
								+"</tr>"
								+ "</table>"
								+ "</form>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: showOutlineItems - " + e.toString());
		}

		return msg;
	}

	/*
	 * compareOutline - compares source and destination kix.
	 *	<p>
	 *	@param	conn				Connection
	 *	@param	kixSource		String
	 *	@param	kixDestination	String
	 *	@param	user				String
	 * @param	compressed		boolean
	 * @param	show				boolean
	 *	<p>
	 * @return Msg
	 */
	public static Msg compareOutline(Connection conn,
													String kixSource,
													String kixDestination,
													String user,
													boolean compressed) throws Exception {

		return compareOutline(conn,kixSource,kixDestination,user,compressed,true);

	}

	public static Msg compareOutline(Connection conn,
												String kixSRC,
												String kixDST,
												String user,
												boolean compressed,
												boolean show) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH bgcolor=\"<| counterColor |>\" width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorSRC |>\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"<| paddedColor |>\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorDST |>\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		String paddedColor = "#e1e1e1";
		String colorSRC = Constant.COLOR_LEFT;
		String colorDST = Constant.COLOR_RIGHT;
		String notMatchedColor = "#D2A41C";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";

		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfo(conn,kixSRC);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[Constant.KIX_CAMPUS];

		int td = 0;
		String cd = "";
		String[] id = Helper.getKixInfo(conn,kixDST);
		td = ConstantDB.getConstantTypeFromString(id[2]);
		cd = id[Constant.KIX_CAMPUS];

		String alpha = is[Constant.KIX_ALPHA];
		String num = is[Constant.KIX_NUM];
		String type = is[Constant.KIX_TYPE];

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,cs).split(",");

		String headerSRC = "";
		String headerDST = "";

		String typeSRC = "";
		String typeDST = "";

		try {

			typeSRC = Outlines.getCourseType(conn,kixSRC);
			typeDST = Outlines.getCourseType(conn,kixDST);

			// source is on the left and destination is on the right
			// depending on what the source is, the title may change
			// for example, if source is PRE, the title is modified
			// if CUR, the current
			// if ARC, existing

			String termSRC = CourseDB.getCourseItem(conn,kixSRC,"effectiveterm");
			String termDST = CourseDB.getCourseItem(conn,kixDST,"effectiveterm");

			termSRC = BannerDataDB.getBannerDescr(conn,"bt",termSRC);
			termDST = BannerDataDB.getBannerDescr(conn,"bt",termDST);

			headerSRC = cs
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixSRC))
							+ " ("+termSRC+"_PDF_)";

			headerDST = cd
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixDST))
							+ " ("+termDST+"_PDF_)";

			//
			// enableCCLab
			//
			String userCampus = UserDB.getUserCampus(conn,user);
			String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,userCampus,"System","EnableCCLab");
			if (enableCCLab.equals(Constant.ON)){
				headerSRC = headerSRC.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixSRC+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);

				headerDST = headerDST.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixDST+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);
			}
			else{
				headerSRC = headerSRC.replace("_PDF_","");
				headerDST = headerDST.replace("_PDF_","");
			} // enableCCLab

			boolean same = true;

			//-----------------------------------------------------
			// course
			//-----------------------------------------------------
			int dataSRC = 0;
			int dataDST = 0;

			//
			// how many columns are we comparing
			//
			dataSRC = CourseDB.countCourseQuestions(conn,cs,"Y","",1);
			if(cs.equals(cd)){
				dataDST = dataSRC;
			}
			else{
				dataDST = CourseDB.countCourseQuestions(conn,cd,"Y","",1);
			}

			String src = "";
			String dst = "";

			//
			// always display as many as there are questions on SRC outline
			//
			for(i=0; i<dataSRC;i++){
				t1 = row1;
				t2 = row2;

				same = true;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				// get data for the column. if the dst has fewer columns, don't get data
				src = CourseDB.getCourseItem(conn,kixSRC,columns[i]);
				src = Outlines.formatOutline(conn,columns[i],cs,alpha,num,typeSRC,kixSRC,src,true,user);

				if(dataDST > i){
					dst = CourseDB.getCourseItem(conn,kixDST,columns[i]);
					dst = Outlines.formatOutline(conn,columns[i],cd,alpha,num,typeDST,kixDST,dst,true,user);

				}
				else{
					dst = "";
				}

				// compare for display
				if (!src.equals(dst)){
					same = false;
				}

				// do we show?
				if(show || (!show && !same)){

					t1 = t1.replace("<| counter |>",(""+(i+1)));

					if (!same){
						t1 = t1.replace("<| counterColor |>",notMatchedColor);
					}
					else{
						t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
					}

					t1 = t1.replace("<| question |>",question+"<br><br>");

					t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
							.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
							.replace("<| paddedColor |>",paddedColor)
							.replace("<| colorSRC |>",colorSRC)
							.replace("<| colorDST |>",colorDST);

					buf.append(t1).append(t2);

				} // show

			} // for

			//
			// now we print campus tab data
			// if the campus SRC = DST, then we compare campus questions for SRC and DSt
			// if campuses are different, we only display SRC data since campus data are
			// not meant to be similar
			//
			if(i < columns.length){

				for(int j=i; j<columns.length; j++){

					t1 = row1;
					t2 = row2;

					same = true;

					question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[j] + "'" );

					dst = "";

					// get data for the column. if the dst has fewer columns, don't get data
					src = CampusDB.getCampusItem(conn,kixSRC,columns[j]);
					src = Outlines.formatOutline(conn,columns[j],cs,alpha,num,typeSRC,kixSRC,src,true,user);

					// for same campus compare, get dst
					if(cs.equals(cd)){
						dst = CampusDB.getCampusItem(conn,kixDST,columns[j]);
						dst = Outlines.formatOutline(conn,columns[j],cd,alpha,num,typeDST,kixDST,dst,true,user);
					}

					//
					// compare for display
					// if the src not equals data and the campuses are different, we compare
					//
					if (!src.equals(dst)){
						same = false;
					}

					// do we show?
					if(show || (!show && !same)){

						t1 = t1.replace("<| counter |>",(""+(j+1)));

						if (!same){
							t1 = t1.replace("<| counterColor |>",notMatchedColor);
						}
						else{
							t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
						}

						t1 = t1.replace("<| question |>",question+"<br><br>");

						t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
								.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
								.replace("<| paddedColor |>",paddedColor)
								.replace("<| colorSRC |>",colorSRC)
								.replace("<| colorDST |>",colorDST);

						buf.append(t1).append(t2);

					} // show

				} // for

			}

			//
			// output
			//
			String campusTitle = "";

			cs = CampusDB.campusDropDownWithKix(conn,alpha,num,typeSRC,"ks",cs);
			cd = CampusDB.campusDropDownWithKix(conn,alpha,num,typeDST,"kd",cd);

			msg.setErrorLog("<table summary=\"\" id=\"tableCompareOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
								+ campusTitle
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorSRC+"\" valign=\"top\" width=\"47%\">"+headerSRC+"</td>"
								+"<td align=\"center\" bgcolor=\""+paddedColor+"\" valign=\"top\" width=\"02%\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorDST+"\" valign=\"top\" width=\"47%\">"+headerDST+"</td>"
								+"</tr>"
								+ buf.toString()
								+ "</table>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines.compareOutline ("+kixSRC+"/"+kixDST+"): " + e.toString());
		}

		return msg;
	} // compareOutline

	/*
	 * getCourseType
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseType(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String type = "";

		try {

			String table = "tblCourse";

			String[] info = Helper.getKixInfo(conn,kix);
			String tpe = info[Constant.KIX_TYPE];
			if(tpe.toLowerCase().equals("arc")){
				table = "tblcoursearc";
			}
			else if(tpe.toLowerCase().equals("can")){
				table = "tblcoursecan";
			}

			String query = "SELECT coursetype FROM "+table+" WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				type = rs.getString(1);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseType - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseType - " + ex.toString());
		}

		return type;
	}

	/*
	 * getCourseCompareHeader
	 *	@param	type	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseCompareHeader(String type) throws SQLException {

		String header = "";

		type = type.trim();

		if(type.equals(Constant.ARC)){
			header = "Archived Outline";
		}
		else if(type.equals(Constant.CUR)){
			header = "Approved Outline";
		}
		else if(type.equals(Constant.PRE)){
			header = "Modified Outline";
		}

		return header;
	}

	/*
	 * compareOutline - compares source and destination kix.
	 *	<p>
	 *	@param	conn				Connection
	 *	@param	kixSrc		String
	 *	@param	kixDst	String
	 *	@param	user				String
	 * @param	compressed		boolean
	 *	<p>
	 * @return Msg
	 */
	public static Msg compareOutlineWithDiff(Connection conn,String kixSrc,String kixDst,String user,boolean compressed) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH bgcolor=\"<| counterColor |>\" width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| sourceColor |>\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"<| paddedColor |>\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| destinationColor |>\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		String paddedColor = "#e1e1e1";
		String sourceColor = Constant.COLOR_LEFT;
		String destinationColor = Constant.COLOR_RIGHT;
		String notMatchedColor = "#D2A41C";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";

		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfo(conn,kixSrc);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[4];

		int td = 0;
		String cd = "";
		String[] id = Helper.getKixInfo(conn,kixDst);
		td = ConstantDB.getConstantTypeFromString(is[2]);
		cd = id[4];

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,cs).split(",");
		String[] dataSource = null;
		String[] dataDestination = null;

		try {
			dataSource = getOutlineData(conn,kixSrc,ts,user,false,compressed);
			dataDestination = getOutlineData(conn,kixDst,td,user,false,compressed);

			// clear place holder or items without any data from the template
			for(i=0;i<dataSource.length;i++){
				t1 = row1;
				t2 = row2;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				t1 = t1.replace("<| counter |>","<a href=\"##\" onClick=\"return compareItems('"+kixSrc+"','"+kixDst+"','"+columns[i]+"')\"  class=\"linkcolumn\">"+(""+(i+1))+"</a>");

				if (!(dataSource[i]).equals(dataDestination[i])){
					t1 = t1.replace("<| counterColor |>",notMatchedColor);
				}
				else{
					t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
				}

				t1 = t1.replace("<| question |>",question+"<br><br>");
				t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(dataSource[i])+"<br><br>");
				t2 = t2.replace("<| answer2 |>",aseUtil.nullToBlank(dataDestination[i])+"<br><br>");
				t2 = t2.replace("<| paddedColor |>",paddedColor);
				t2 = t2.replace("<| sourceColor |>",sourceColor);
				t2 = t2.replace("<| destinationColor |>",destinationColor);

				buf.append(t1);
				buf.append(t2);
			}

			msg.setErrorLog("<table summary=\"\" id=\"tableCompareOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"4\">"
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+destinationColor+"\" valign=\"top\" width=\"47%\">Existing Outline</td>"
								+"<td align=\"center\" bgcolor=\""+paddedColor+"\" valign=\"top\" width=\"02%\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+sourceColor+"\" valign=\"top\" width=\"47%\">Modified Outline</td>"
								+"</tr>"
								+ buf.toString()
								+ "</table>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: compareOutline - " + e.toString());
		}

		return msg;
	} // compareOutline

	/*
	 * getOutlineData - returns an outline data in a string array
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixSource	String
	 *	@param	section	int
	 *	@param	user		String
	 *	@param	compare	boolean
	 *	<p>
	 * @return Msg
	 */
	public static String[] getOutlineData(Connection conn,String kix,int section,String user,boolean compare,boolean compressed) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		if (campus == null || campus.length() == 0){
			info = Helper.getKixInfoFromOldCC(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}

		String line = "";												// input line
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";
		String tableCampus = "tblCampusData";

		// when comparing outlines side by side
		if (compare){
			table = "tblCourseCC2";
			tableCampus = "tblCampusDataCC2";
		}

		AseUtil aseUtil = new AseUtil();

		String[] data = null;

		int i = 0;

		try {
			String[] c1 = null;
			String[] c2 = null;

			String x1 = "";
			String x2 = "";

			String[] columns = null;

			// collect all columns from course and campus table
			String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
			f1 = AseUtil.nullToBlank(f1);

			String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
			f2 = AseUtil.nullToBlank(f2);

			// course items may not be empty
			if (!f1.equals(Constant.BLANK)){

				// combine columns (f1 & f2) into a single list
				c1 = f1.split(",");

				// make sure there is data
				if (!f2.equals(Constant.BLANK)){
					c2 = f2.split(",");
					columns = (f1 + "," + f2).split(",");
				}
				else{
					columns = f1.split(",");
				}

				// holder for resulting data from select statement
				data = new String[columns.length];

				// append to columns with aliasing for select statement below
				x1 = "c." + f1.replace(",",",c.");

				if (!f2.equals(Constant.BLANK)){
					x2 = "," + "s." + f2.replace(",",",s.");
				}

				temp = f1;

				switch (section) {
					case Constant.COURSETYPE_ARC:
						table = "tblCourseARC";
						break;
					case Constant.COURSETYPE_CAN:
						table = "tblCourseCAN";
						break;
					case Constant.COURSETYPE_CUR:
						break;
					case Constant.COURSETYPE_PRE:
						break;
				} // switch

				// select is now in proper format
				sql = "SELECT " + x1 + x2 + " "
					+ "FROM " + table + " c LEFT OUTER JOIN " + tableCampus + " s ON c.historyid = s.historyid "
					+ "WHERE c.historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					for(i=0;i<columns.length;i++){

						temp = AseUtil.nullToBlank(rs.getString(columns[i]));
						temp = Html.fixHTMLEncoding(temp);
						temp = formatOutline(conn,columns[i],campus,alpha,num,type,kix,temp,compressed,user);

						// data has faulty list tags should be removed
						temp = temp.replace("<ul></ul>","");

						if (temp != null && temp.length() > 0){
							data[i] = temp;
						}
						else{
							data[i] = "";
						}

					}	// for

				}	// if
				rs.close();
				ps.close();
			} // f1 != null && f2 != null

		} catch (SQLException se) {
			logger.fatal("Outlines: getOutlineData - " + se.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: getOutlineData - " + e.toString());
		}

		return data;
	} // getOutlineData

	/*
	 * validate - returns content if validation fails
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 * @return String
	 */
	public static String validate(Connection conn,String campus,String kix) throws CentralException {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String data = "";
		String explain = "";
		String extended = "";

		try {

			boolean found = false;
			StringBuffer validation = new StringBuffer();
			String[] aCols = null;

			PreparedStatement ps = null;
			ResultSet rs = null;

			int i = 0;

			// the total number of questions to adjust count for campus questions
			int courseQuestions = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			//------------------------------------------------------
			// validate courses
			//------------------------------------------------------

			// 1) get required table columns
			// 2) with required column names, get actual data for validation
			String sql = "SELECT c.Question_Friendly "
				+ "FROM tblCourseQuestions q INNER JOIN "
				+ "CCCM6100 c ON q.questionnumber = c.Question_Number "
				+ "WHERE c.campus='SYS' "
				+ "AND c.type='Course' AND q.questionseq>0 AND q.required='Y' "
				+ "AND q.campus=? ORDER BY q.questionseq";
			String cols = SQLUtil.resultSetToCSV(conn,sql,campus);
			if (cols != null && cols.length() > 0){

				found = false;
				aCols = cols.split(",");

				sql = "SELECT " + cols + " FROM tblCourse WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()) {
					// cycle through named columns to validate data
					// with data, is it valid (not null and not empty)
					// check data as well as the explained and extended data columns
					for (i=0; i<aCols.length; i++){
						data = AseUtil.nullToBlank(rs.getString(aCols[i]));
						explain = getExplainData(conn,kix,aCols[i]);
						extended = getExtendedData(conn,kix,aCols[i]);

						//logger.info(aCols[i] + "*" + data + "*" + explain + "*" + extended + "*");

						if (data.length() == 0 && explain.length() == 0 && extended.length() == 0){
							// retrieve actual question based on named column
							Question question = QuestionDB.getCourseQuestionByColumn(conn,campus,aCols[i],1);
							if (question != null){
								validation.append("<li>"
									+ question.getSeq()
									+ " - "
									+ question.getQuestion()
									+ "</li>");
								found = true;
							} // question not null
						}	// data is null
					}	// for
				}	// if resultset
				rs.close();
				ps.close();

			}	// validate coures - found required columns

			//------------------------------------------------------
			// validate campus
			//------------------------------------------------------
			sql = "SELECT c.Question_Friendly "
				+ "FROM tblCampusQuestions q INNER JOIN "
				+ "CCCM6100 c ON q.questionnumber = c.Question_Number "
				+ "WHERE c.campus='"+campus+"' "
				+ "AND c.type='Campus' AND q.questionseq>0 AND q.required='Y' "
				+ "AND q.campus=? ORDER BY q.questionseq";
			cols = SQLUtil.resultSetToCSV(conn,sql,campus);
			if (cols != null && cols.length() > 0){

				aCols = cols.split(",");

				sql = "SELECT " + cols + " FROM tblcampusdata WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()) {
					// cycle through named columns to validate data
					// with data, is it valid (not null and not empty)
					// check data as well as the explained and extended data columns
					for (i=0; i<aCols.length; i++){
						data = AseUtil.nullToBlank(rs.getString(aCols[i]));

						if (data.length() == 0){
							// retrieve actual question based on named column
							Question question = QuestionDB.getCourseQuestionByColumn(conn,campus,aCols[i],2);
							if (question != null){
								validation.append("<li>"
									+ (courseQuestions + NumericUtil.getInt(question.getSeq(),0))
									+ " - "
									+ question.getQuestion()
									+ "</li>");
								found = true;
							} // question not null
						}	// data is null
					}	// for
				}	// if resultset
				rs.close();
				ps.close();

			}	// found required columns

			//-----------------------------------------------------------------
			// complete list
			//-----------------------------------------------------------------
			if (found){
				temp = "<ul>" + validation.toString() + "</ul>";
			}
			else{
				temp = "";
			}

			//-----------------------------------------------------------------
			//	validate PENDING items (pre,coreq,xlist,program attachments)
			//-----------------------------------------------------------------
			String preReqRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","PreReqRequiresApproval");
			if (preReqRequiresApproval.equals(Constant.ON)){
				int preReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_PREREQ);

				if (preReqs > 0)
					temp = temp + "<ul><li>Approval not permitted while Pre-Requisite approval is pending.</li></ul>";
			}

			String coReqRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CoReqRequiresApproval");
			if (coReqRequiresApproval.equals(Constant.ON)){
				int coReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_COREQ);

				if (coReqs > 0)
					temp = temp + "<ul><li>Approval not permitted while Co-Requisite approval is pending.</li></ul>";
			}

			String crossListingRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CrossListingRequiresApproval");
			if (crossListingRequiresApproval.equals(Constant.ON)){
				int xref = XRefDB.crossListingRequiringApproval(conn,kix);

				if (xref > 0)
					temp = temp + "<ul><li>Approval not permitted while cross listing approval is pending.</li></ul>";
			}

			String ProgramLinkedToOutlineRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ProgramLinkedToOutlineRequiresApproval");
			if (ProgramLinkedToOutlineRequiresApproval.equals(Constant.ON)){
				int programs = ProgramsDB.programsRequiringApproval(conn,kix);

				if (programs > 0)
					temp = temp + "<ul><li>Approval not permitted while program attachment approval is pending.</li></ul>";
			}

		} catch (SQLException se) {
			logger.fatal("Outlines: validate - " + se.toString());
			throw new CentralException("Outlines: validate - " + se.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: validate - " + e.toString());
			throw new CentralException("Outlines: validate - " + e.toString());
		}

		return temp;
	} // Outlines: validate

	/*
	 * getExplainData - returns data stored in explain field for course
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	friendly	String
	 *	<p>
	 *	@return String
	 */
	public static String getExplainData(Connection conn,String kix,String friendly) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String explain = "";
		String sql = "SELECT question_explain FROM CCCM6100 WHERE question_friendly=?";
		try {
			// 1) get the friendly name
			// 2) get the data corresponding to the friendly name from campus data
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, friendly);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				explain = AseUtil.nullToBlank(rs.getString("question_explain"));
				rs.close();
				if (explain != null && explain.length() > 0){
					sql = "SELECT " + explain + " FROM tblCampusdata WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					if (rs.next())
						explain = AseUtil.nullToBlank(rs.getString(explain));
				}
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("OutlineDB: getExplainData - " + e.toString());
		}

		return explain;
	}

	/*
	 * getExtendedData - data stored as line item
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	friendly	String
	 *	<p>
	 *	@return String
	 */
	public static String getExtendedData(Connection conn,String kix,String friendly) throws CentralException {

		//Logger logger = Logger.getLogger("test");

		int count = 0;
		String rtn = "";
		try {
			PreparedStatement ps2 = null;
			ResultSet rs2 = null;

			// 1) get the table and column name that contains extended data
			// 2) once found, count the number of entries from the table
			String sql = "SELECT tab,key1,key2 FROM tblExtended WHERE friendly=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,friendly);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String tab = AseUtil.nullToBlank(rs.getString("tab"));
				String key1 = AseUtil.nullToBlank(rs.getString("key1"));
				String key2 = AseUtil.nullToBlank(rs.getString("key2"));

				if (key2.length()==0){
					sql = "SELECT count(*) "
						+ "FROM " + tab + " "
						+ "WHERE " + key1 + "=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
				}
				else{
					sql = "SELECT count(*) "
						+ "FROM " + tab + " "
						+ "WHERE " + key1 + "=? "
						+ "AND " + key2 + "=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setString(2,friendly);
				}
				rs2 = ps2.executeQuery();
				if (rs2.next()){
					count = rs2.getInt(1);
					if (count > 0){
						rtn = "data found";
					}
				}

				rs2.close();
				ps2.close();
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			throw new CentralException("Outlines - getExtendedData - SQLException: " + e.toString());
		} catch (Exception e) {
			throw new CentralException("Outlines - getExtendedData - Exception: " + e.toString());
		}

		return rtn;
	}

	/*
	 * enablingDuringApproval
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	friendly	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean enablingDuringApproval(Connection conn,String kix) throws Exception {

		boolean enabled = false;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String campus = info[4];
		String progress = info[7];

		 // enabling is when approver wishes to enable items for proposer to edit
		 // to be in enabling mode, the following must be true:
		 //	1) the approval process must be on
		 //	2) edit1 and edit2 must have commas to indicate that individual items have been enabled

		int courseEdit = CourseDB.getCourseEdit(conn,campus,alpha,num,type);
		String courseEdit1 = CourseDB.getCourseEdit1(conn,campus,alpha,num,type);

		if (progress.equals(Constant.COURSE_APPROVAL_TEXT) && courseEdit1.indexOf(",") > -1)
			enabled = true;

		return enabled;
	}

	/**
	 * drawPrereq
	 * <p>
	 * @param kix			String
	 * @param values		String
	 * @param fieldName	String
	 * @param display		boolean
	 * <p>
	 * @return String
	 */
	public static String drawPrereq(String values,String fieldName,boolean display) {

		String kix = "";

		return drawPrereq(kix,values,fieldName,display);

	}

	public static String drawPrereq(String kix,String values,String fieldName,boolean display) {

		String fieldLabel = "Instructor consent required,Program Director consent required,Admission to program required";
		StringBuffer temp = new StringBuffer();
		String tempFieldName = "";

		// defaults all to NO
		if (values == null || values.equals(Constant.BLANK))
			values = "0,0,0";

		// as of 1/12/10, prereq was a single values. after that, 2 more values
		// are added. we accommodate the additions by appending the extra
		// values here to cover for the data from database.
		if (values.length()==1)
			values = values + ",0,0";
		else if (values.length()==2)
			values = values + ",0";

		String[] aValue = values.split(",");
		String[] aFieldLabel = fieldLabel.split(",");

		try {
			if (aValue.length == aFieldLabel.length){
				for (int i=0;i<aValue.length; i++) {
					temp.append(aFieldLabel[i] + "? ");
					tempFieldName = fieldName + "_" + i;
					temp.append(AseUtil.radioYESNO(aValue[i],tempFieldName,display));
					temp.append("<br>");
				} // for
			}
		} catch (Exception e) {
			logger.fatal("Outlines: drawPrereq - " + e.toString() + "; kix: " + kix + "; values: " + kix);
		}

		return temp.toString();
	}

	/*
	 * updateReason - update reason field with timestamp
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	reason	String
	 *	@param	user		String
	 *	<p>
	 *	@return int
	 */
	public static int updateReason(Connection conn,String kix,String reason,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String currentReason = "";
		int rowsAffected = 0;

		String sql = "SELECT " + Constant.COURSE_REASON + " FROM tblCourse WHERE historyid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				// get current reason then append new
				currentReason = AseUtil.nullToBlank(rs.getString(Constant.COURSE_REASON));

				currentReason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br>"
									+ reason
									+ "<br><br>"
									+ currentReason;
				sql = "UPDATE tblCourse SET " + Constant.COURSE_REASON + "=? WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,currentReason);
				ps.setString(2,kix);
				rowsAffected = ps.executeUpdate();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("Outlines: updateReason - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * canCommentOnOutline - is the user allowed to comment on an outline
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean canCommentOnOutline(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean commentOnOutline = false;

		try{

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			boolean isReviewer = true;
			boolean isApprover = true;
			boolean isProposer = false;

			String reviewers = ReviewerDB.getReviewerNames(conn,campus,alpha,num);
			if (reviewers == null || reviewers.length() == 0 || reviewers.indexOf(user) < 0)
				isReviewer = false;

			Approver approver = ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);
			if (	approver != null
					&& approver.getAllApprovers() != null
					&& approver.getAllApprovers().length() > 0
					&& approver.getAllApprovers().indexOf(user) < 0)
				isApprover = false;

			if (proposer.equals(user))
				isProposer = true;

			// proposer may not comment on his/her own outline
			// reviewer and approver may comment
			if (isProposer || (!isReviewer && !isApprover))
				commentOnOutline = false;
			else
				commentOnOutline = true;

		}
		catch( SQLException e ){
			logger.fatal("Outlines: canCommentOnOutline\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Outlines: canCommentOnOutline - " + ex.toString());
		}

		return commentOnOutline;
	}

	/*
	 * identifyChanges - show changes to items in outlines (PRE vs CUR)
	 *	<p>
	 *	@param	conn
	 *	@param	kixSRC
	 *	@param	kixDST
	 *	@param	user
	 *	<p>
	 *	@return String
	 */
	public static String identifyChanges(Connection conn,String kixSRC,String kixDST,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String sourceColor = Constant.COLOR_LEFT;
		String destinationColor = Constant.COLOR_RIGHT;

		String row = "<tr bgcolor=\"<| bgcolor |>\">"
			+"<td height=\"20\" width=\"02%\" bgcolor=\"#ffffff\">&nbsp;</td>"
			+"<td height=\"20\" class=textblackTH width=\"10%\" align=\"right\" valign=\"top\"><| counter |></td>"
			+"<td class=\"<| class |>\" valign=\"top\"><| question |></td>"
			+"<td height=\"20\" width=\"02%\" bgcolor=\"#ffffff\">&nbsp;</td>"
			+"</tr>";

		int i = 0;

		String rtn = "";
		String tableRow = "";
		StringBuffer buf = new StringBuffer();

		String question = "";

		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfo(conn,kixSRC);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[4];

		int td = 0;
		String[] id = Helper.getKixInfo(conn,kixDST);
		td = ConstantDB.getConstantTypeFromString(is[2]);

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] dataSRC = null;
		String[] dataDST = null;

		boolean found = false;

		try {
			dataSRC = getOutlineData(conn,kixSRC,ts,user,false,true);
			dataDST = getOutlineData(conn,kixDST,td,user,false,true);

			for(i=0;i<dataSRC.length;i++){
				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				if (!(dataSRC[i]).equals(dataDST[i])){
					tableRow = row;
					tableRow = tableRow.replace("<| bgcolor |>",Constant.ODD_ROW_BGCOLOR);
					tableRow = tableRow.replace("<| counter |>",""+i+".&nbsp;");
					tableRow = tableRow.replace("<| class |>","textblackTH");
					tableRow = tableRow.replace("<| question |>",question);
					buf.append(tableRow);

					tableRow = row;
					tableRow = tableRow.replace("<| bgcolor |>",Constant.COLOR_RIGHT);
					tableRow = tableRow.replace("<| counter |>","BEFORE");
					tableRow = tableRow.replace("<| class |>","datacolumn");
					tableRow = tableRow.replace("<| question |>",aseUtil.nullToBlank(dataSRC[i]));
					buf.append(tableRow);

					tableRow = row;
					tableRow = tableRow.replace("<| bgcolor |>",Constant.COLOR_RIGHT);
					tableRow = tableRow.replace("<| counter |>","AFTER");
					tableRow = tableRow.replace("<| class |>","datacolumn");
					tableRow = tableRow.replace("<| question |>",aseUtil.nullToBlank(dataDST[i]));
					buf.append(tableRow);

					tableRow = row;
					tableRow = tableRow.replace("<| bgcolor |>",Constant.ODD_ROW_BGCOLOR);
					tableRow = tableRow.replace("<| counter |>","&nbsp");
					tableRow = tableRow.replace("<| class |>","&nbsp");
					tableRow = tableRow.replace("<| question |>","&nbsp");
					buf.append(tableRow);

					found = true;
				} // if
			} // for

			columns = null;
			dataSRC = null;
			dataDST = null;
			id = null;
			is = null;
			aseUtil = null;

			if (found){
				rtn = "<table summary=\"\" id=\"tableIdentifyChanges\" border=\"0\" width=\"90%\">"
						+ buf.toString()
						+ "</table>";
			}

		} catch (Exception e) {
			logger.fatal("Outlines: identifyChanges - " + e.toString());
		}

		return rtn;
	} // identifyChanges

	/*
	 * trackItemChanges
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kixPRE
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int trackItemChanges(Connection conn,String campus,String kixPRE,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String kixCUR = null;
		String changes = null;
		String courseChangeProposed = "";
		int rowsAffected = 0;

		try {

			boolean debug = DebugDB.getDebug(conn,"Outlines");

			if (debug) logger.info("------------------ trackItemChanges - START");

			String trackItemChanges = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","TrackItemChanges");
			if ((Constant.ON).equals(trackItemChanges)){

				if (debug) logger.info("track item changes is on");

				// retrieve outline specifics from KIX
				String[] info = Helper.getKixInfo(conn,kixPRE);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];

				// if a CUR exists and there is no data in the item at this time, do a compare with the PRE version
				// we check these conditions because we allow the track item changes to take place only when
				// nothing is there.
				if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,Constant.CUR)){

					if (debug) logger.info("CUR exists to perform compare");

					courseChangeProposed = CourseDB.getCourseItem(conn,kixPRE,Constant.COURSE_CHANGE_PROPOSED);
					if (courseChangeProposed.equals(Constant.BLANK)){
						kixCUR = Helper.getKix(conn,campus,alpha,num,Constant.CUR);
						changes = Outlines.identifyChanges(conn,kixCUR,kixPRE,user);

						if (debug) logger.info("track item changes found");

						String sql = "UPDATE tblCourse SET "
										+ Constant.COURSE_CHANGE_PROPOSED
										+ "=? WHERE campus=? AND historyid=?";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,changes);
						ps.setString(2,campus);
						ps.setString(3,kixPRE);
						rowsAffected = ps.executeUpdate();

						if (debug) logger.info("track item changes updated - " + rowsAffected + " row");
					}

				}
			} // trackItemChanges on?

			if (debug) logger.info("------------------ trackItemChanges - END");

		} catch (SQLException e) {
			logger.fatal("Outlines: trackItemChanges - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: trackItemChanges - " + e.toString());
		}

		return rowsAffected;
	} // trackItemChanges

	/*
	 * populateTestData
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int populateTestData(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String type = info[Constant.KIX_TYPE];

		int i = 0;

		String sql = "SELECT cq.campus, cq.questionseq, cq.questionnumber, cm.Question_Friendly, cm.Question_Explain "
					+ "FROM tblCourseQuestions cq INNER JOIN "
					+ "CCCM6100 cm ON cq.questionnumber = cm.Question_Number "
					+ "WHERE cm.campus='SYS' "
					+ "AND cm.type='Course' "
					+ "AND cq.include='Y' "
					+ "AND cq.campus=? "
					+ "ORDER BY cq.questionseq";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++i;

				String friendly = AseUtil.nullToBlank(rs.getString("Question_Friendly"));

				String explain = AseUtil.nullToBlank(rs.getString("Question_Explain"));

				try{
					if (friendly.indexOf("X") == 0){
						CourseDB.updateCourseRaw(conn,
														kix,
														friendly,
														""+i+" - "+AseUtil.getCurrentDateTimeString(),
														user,
														""+i+" - "+AseUtil.getCurrentDateTimeString(),
														explain,
														1);
					}
				} catch (Exception e) {
					logger.fatal("Outlines: populateTestData - " + e.toString());
				}

			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("Outlines: populateTestData - " + e.toString());
		}

		return 0;
	}

	/*
	 * getCancelledOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * @param	cid		String
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getCancelledOutlines(Connection conn,String campus,String alpha,String num,int idx) throws Exception {

		List<Banner> BannerData = null;

		try {
			if (BannerData == null){

            BannerData = new LinkedList<Banner>();

				String sql = "";

				PreparedStatement ps = null;

				AseUtil ae = new AseUtil();

				if (alpha != null && alpha.length() > 0){
					sql = "SELECT historyid,Coursealpha,Coursenum,coursedate,proposer,coursetitle "
						+ "FROM tblCourseCAN WHERE campus=? "
						+ "AND coursealpha=? AND coursenum=? ORDER BY Coursedate desc";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
				}
				else{
					sql = "SELECT DISTINCT Coursealpha,Coursenum,coursetitle,'' as proposer,'' as coursedate,'' as historyid "
									+ "FROM tblCourseCAN WHERE campus=? ";

					if (idx > 0){
						sql += " AND Coursealpha like '"+(char)idx+"%' ";
					}

					sql += " ORDER BY Coursealpha,Coursenum";

					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
				}

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerData.add(new Banner(
										AseUtil.nullToBlank(rs.getString("Coursealpha")),
										AseUtil.nullToBlank(rs.getString("Coursenum")),
										AseUtil.nullToBlank(rs.getString("coursetitle")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("historyid")),
										"",
										""
									));
				} // while
				rs.close();
				ps.close();

				ae = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("Outlines: getCancelledOutlines\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("Outlines: getCancelledOutlines\n" + e.toString());
			return null;
		}

		return BannerData;
	}

	/*
	 * getDeletedOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * @param	cid		String
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getDeletedOutlines(Connection conn,String campus,String alpha,String num,int idx) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Banner> BannerData = null;

		try {
			if (BannerData == null){

            BannerData = new LinkedList<Banner>();

				String sql = "";

				PreparedStatement ps = null;

				AseUtil ae = new AseUtil();

				if (alpha != null && alpha.length() > 0){
					//sql = "SELECT historyid,Coursealpha,Coursenum,coursedate,proposer,coursetitle "
					//	+ "FROM tblCourseARC WHERE campus=? "
					//	+ "AND coursealpha=? AND coursenum=? ORDER BY Coursedate desc";
					sql = "SELECT v.CourseAlpha, v.CourseNum, v.historyid, c.proposer, c.coursetitle, c.coursedate "
						+ "FROM vw_keeDEL v INNER JOIN tblCourseARC c ON v.historyid = c.historyid "
						+ "WHERE v.campus = ? AND v.coursealpha=? AND v.coursenum=?  ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
				}
				else{
					//sql = "SELECT DISTINCT Coursealpha,Coursenum,coursetitle,'' as proposer,'' as coursedate,'' as historyid FROM tblCourseARC WHERE campus=? ";
					sql = "SELECT v.CourseAlpha, v.CourseNum, v.historyid, c.proposer, c.coursetitle, c.coursedate "
						+ "FROM vw_keeDEL v INNER JOIN tblCourseARC c ON v.historyid = c.historyid "
						+ "WHERE v.campus = ? ";

					if (idx > 0){
						sql += " AND v.Coursealpha like '"+(char)idx+"%' ";
					}

					sql += " ORDER BY v.Coursealpha,v.Coursenum";

					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
				}

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerData.add(new Banner(
										AseUtil.nullToBlank(rs.getString("Coursealpha")),
										AseUtil.nullToBlank(rs.getString("Coursenum")),
										AseUtil.nullToBlank(rs.getString("coursetitle")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("historyid")),
										"",
										""
									));
				} // while
				rs.close();
				ps.close();

				ae = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("Outlines: getDeletedOutlines\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("Outlines: getDeletedOutlines\n" + e.toString());
			return null;
		}

		return BannerData;
	}

	/*
	 * getDeletedOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * @param	cid		String
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getDeletedOutlinesOBSOLETE(Connection conn,String campus,String alpha,String num,int idx) throws Exception {

		List<Banner> BannerData = null;

		try {
			if (BannerData == null){

            BannerData = new LinkedList<Banner>();

				String sql = "";

				PreparedStatement ps = null;

				AseUtil ae = new AseUtil();

				if (alpha != null && alpha.length() > 0){
					sql = "SELECT historyid,Coursealpha,Coursenum,coursedate,proposer,coursetitle "
						+ "FROM tblCourseARC WHERE campus=? "
						+ "AND coursealpha=? AND coursenum=? ORDER BY Coursedate desc";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
				}
				else{
					sql = "SELECT DISTINCT Coursealpha,Coursenum,coursetitle,'' as proposer,'' as coursedate,'' as historyid "
									+ "FROM tblCourseARC WHERE campus=? ";

					if (idx > 0){
						sql += " AND Coursealpha like '"+(char)idx+"%' ";
					}

					sql += " ORDER BY Coursealpha,Coursenum";

					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
				}

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerData.add(new Banner(
										AseUtil.nullToBlank(rs.getString("Coursealpha")),
										AseUtil.nullToBlank(rs.getString("Coursenum")),
										AseUtil.nullToBlank(rs.getString("coursetitle")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("historyid")),
										"",
										""
									));
				} // while
				rs.close();
				ps.close();

				ae = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("Outlines: getDeletedOutlines\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("Outlines: getDeletedOutlines\n" + e.toString());
			return null;
		}

		return BannerData;
	}

	/*
	 * getFriendlyData
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	column		String
	 * @param	temp			String
	 *	<p>
	 * @return String
	 */
	public static String getFriendlyData(Connection conn,String campus,String column,String temp) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		int j = 0;
		String junk = "";
		String[] reuse;

		String lookupData[] = new String[2];
		String questionData[] = new String[2];
		String lookUpCampus = "campus='"+campus+"' AND type='Campus' AND question_friendly='__'";
		String lookUpSys = "campus='SYS' AND type='Course' AND question_friendly='__'";

		String friendlyName = "";
		String data = "";

		try{

			// look up the reference for retrieval of checklist/radio data.
			// if not found as a campus item, then it's likely to be a system item
			junk = lookUpCampus;
			junk = junk.replace("__",column);
			questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
			if (questionData[0].equals("NODATA")){
				junk = lookUpSys;
				junk = junk.replace("__",column);
				questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);

				friendlyName = questionData[1];

				// with friendly name found, does it exist as a category in INI?

				if (IniDB.isValidCategory(conn,campus,friendlyName)){

					// split the list of data and process each id
					reuse = temp.split(",");

					j = 0;

					while (j < reuse.length && NumericUtil.isInteger(reuse[j])){

						junk = "campus='"+campus+"' AND category='"+friendlyName+"' AND id=" + reuse[j];

						lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);

						junk = lookupData[1];

						if (junk != null && junk.length() > 0){

							if (data.equals(Constant.BLANK)){
								data = "<li class=\"datacolumn\">" + junk + "</li>";
							}
							else{
								data = data + "<li class=\"datacolumn\">" + junk + "</li>";
							}

						} // if

						++j;

					} // while

					temp = "<ul>" + data + "</ul>";

				} //

			} // found friendly name

		}
		catch(Exception e){
			logger.fatal("Outlines: getFriendlyData - "
							+ e.toString()
							+ "\ncolumn: " + column
							);
		}

		return temp;
	} // Outlines: getFriendlyData

	/*
	 * getSystemWideItem
	 *	<p>
	 * @param	conn		Connection
	 * @param	user		String
	 * @param	kix		String
	 * @param	column	String
	 *	<p>
	 * @return String
	 */
	public static String getSystemWideItem(Connection conn,String user,String kix,String column) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer result = new StringBuffer();

		try{
			int i = 0;

			String rowColor = "";

			boolean foundSimilar = false;

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String campus = info[Constant.KIX_CAMPUS];

			String table = "tblcourse";

			if(!com.ase.aseutil.schema.Schema.doesColumnExistInTable(conn,table,column)){
				table = "tblcampusdata";
			}

			String sql = "select campus,"+column+" from " + table + " where coursealpha=? AND coursenum=? AND campus<>? order by campus ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ps.setString(3,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				foundSimilar = true;

				if (i++ % 2 == 0){
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				}
				else{
					rowColor = Constant.ODD_ROW_BGCOLOR;
				}

				campus = AseUtil.nullToBlank(rs.getString("campus"));

				String data = AseUtil.nullToBlank(rs.getString(column));

				if (data != null && data.length() > 0){

					data = Outlines.formatOutline(conn,column,campus,alpha,num,type,kix,data,false,user);

					result.append("<tr bgcolor=\""+rowColor+"\">"
							+ "<td class=\"textblackth\" width=\"05%\">"+campus+"</td>"
							+ "<td class=\"datacolumn\" width=\"95%\">"+data+"</td>"
							+ "</tr>");
				}
			}

			rs.close();
			ps.close();

			if(!foundSimilar){

				result.append("<tr bgcolor=\""+rowColor+"\">"
						+ "<td class=\"datacolumn\">Similar course outline not found in UH system</td>"
						+ "</tr>");

			}

		} catch (SQLException e) {
			logger.fatal("Outlines: getSystemWideItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: getSystemWideItem - " + e.toString());
		}

		return "<table summary=\"\" border=\"0\" cellpadding=\"4\" cellspacing=\"4\" width=\"98%\"><tbody>"
				+ result.toString()
				+ "</tbody></table>";

	}

	/**
	 * getMostRecentArchivedCourse
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String getMostRecentArchivedCourse(Connection conn,String campus,String alpha,String num) throws Exception {

		// returns the most recent archived course (if any)
		// if found, this is a mod of an existing. if not found
		// this is a new course

		//Logger logger = Logger.getLogger("test");

		String kix = "";

		try{
			String sql = "SELECT historyid FROM tblCourseARC "
				+ "WHERE campus=? AND CourseAlpha=? AND CourseNum=? "
				+ "ORDER BY coursedate DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
			}
			rs.close();
			ps.close();

		}catch(Exception e){
			logger.fatal("Outline - getMostRecentArchivedCourse - " + e.toString());
		}

		return kix;

	} // Outline - getMostRecentArchivedCourse

	/**
	 * outlineDates
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	endYear		String
	 * @param	endMonth		String
	 * @param	dateColumn	String
	 * <p>
	 * @return	String
	 */
	public static String outlineDates(Connection conn,String campus,String endYear,String endMonth,String dateColumn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuilder buf = new StringBuilder();

		try{
			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">")
				.append("<div id=\"demo_jui\">")
				.append("<table summary=\"\" id=\"crsrpt_8\" class=\"display\">")
				.append("<thead>")
				.append("<tr>")
				.append("<th align=\"left\">Outline</th>")
				.append("<th align=\"left\">Title</th>")
				.append("<th align=\"left\">Date</th>")
				.append("<th align=\"left\">Proposer</th>")
			 	.append("</tr></thead><tbody>");

			String sql = "";

			// default SQL includes year and month
			if(dateColumn.toLowerCase().equals("enddate")){
				sql = SQL.endDate;
			}
			else if(dateColumn.toLowerCase().equals("experimentaldate")){
				sql = SQL.experimentalDate;
			}
			else if(dateColumn.toLowerCase().equals("reviewdate")){
				sql = SQL.reviewDate;
			}

			// when month is not used
			if(endMonth == null || endMonth.length() == 0){

				if(dateColumn.toLowerCase().equals("enddate")){
					sql = SQL.endDateYY;
				}
				else if(dateColumn.toLowerCase().equals("experimentaldate")){
					sql = SQL.experimentalDateYY;
				}
				else if(dateColumn.toLowerCase().equals("reviewdate")){
					sql = SQL.reviewDateYY;
				}

			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,NumericUtil.getInt(endYear,0));

			if(endMonth != null && endMonth.length() > 0){
				ps.setInt(3,NumericUtil.getInt(endMonth,0));
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("courseAlpha"));
				String num = AseUtil.nullToBlank(rs.getString("courseNum"));
				String title = AseUtil.nullToBlank(rs.getString("courseTitle"));
				String proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				String dateValue = aseUtil.ASE_FormatDateTime(rs.getString(dateColumn),Constant.DATE_SHORT);

				String link = "<a href=\"vwcrsy.jsp?kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a>";

				buf.append("<td>").append(link).append("</td>")
					.append("<td>").append(title).append("</td>")
					.append("<td>").append(dateValue).append("</td>")
					.append("<td>").append(proposer).append("</td>")
					.append("</tr>");

			}
			rs.close();
			ps.close();

			aseUtil = null;

			buf.append("</tbody></table></div></div>");

		}catch(Exception e){
			logger.fatal("Outline - outlineDates - " + e.toString());
		}

		return buf.toString();

	} // Outline - outlineDates

	/*
	 * getOutlinesForExpeditedDeletes
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return Generic
	 */
	public static List<Generic> getOutlinesForExpeditedDeletes(Connection conn,String campus,String type) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {

			genericData = new LinkedList<Generic>();

			int id = IniDB.getIDByCampusCategoryKid(conn,campus,"ReasonsForMods","Delete");

			// make sure there is an ID for delete as reasons for mods

			if(id > 0){

				String sql = "";
				String dateField = "";

				PreparedStatement ps = null;

				AseUtil ae = new AseUtil();

				if(type.equals(Constant.CUR)){
					dateField = "coursedate";

					sql = "SELECT historyid, CourseAlpha, CourseNum, coursetitle, proposer, "+dateField+", effectiveterm "
						+ "FROM tblCourse "
						+ "WHERE progress='APPROVED' AND campus=? AND (NOT (coursedate IS NULL)) AND (X76 LIKE '%"+id+"%') "
						+ "ORDER BY CourseAlpha, CourseNum";
				}
				else{
					dateField = "auditdate";

					sql = "SELECT historyid, CourseAlpha, CourseNum, coursetitle, proposer, "+dateField+", effectiveterm "
						+ "FROM tblCourse "
						+ "WHERE coursetype='PRE' AND campus=? AND (NOT (auditdate IS NULL)) AND (X76 LIKE '%"+id+"%') "
						+ "ORDER BY CourseAlpha, CourseNum";
				}
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("Coursealpha")),
										AseUtil.nullToBlank(rs.getString("Coursenum")),
										AseUtil.nullToBlank(rs.getString("coursetitle")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString(dateField),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("historyid")),
										AseUtil.nullToBlank(rs.getString("effectiveterm")),
										"",
										""
									));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // id found

		} catch (SQLException e) {
			logger.fatal("Outlines: getOutlinesForExpeditedDeletes\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("Outlines: getOutlinesForExpeditedDeletes\n" + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * compareMatrix - compares source and destination kix.
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	user		String
	 *	<p>
	 * @return Msg
	 */
	public static Msg compareMatrix(Connection conn,String campus,String alpha,String num,String user,boolean advanced) throws Exception {

		//Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String rowTemplate = "<tr bgcolor=\"<| bgcolor |>\">"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" valign=\"top\"><| column |></td>"
			+"<td class=\"datacolumnLeftCell\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumnRightCell\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		String advancedTemplate = "<tr bgcolor=\"<| bgcolor |>\">"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" valign=\"top\"><| column |></td>"
			+"<td class=\"datacolumn\" valign=\"top\"><| answer1 |></td>"
			+"</tr>";

		String paddedColor = "#e1e1e1";
		String colorPre = Constant.COLOR_LEFT;
		String colorCur = Constant.COLOR_RIGHT;
		String notMatchedColor = "#D2A41C";

		int i = 0;

		Msg msg = new Msg();

		String template = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";
		String rowColor = "";

		String kixSrc = "";
		String kixDst = "";
		String type = "PRE";

		try {

			String headerSrc = "";
			String headerDst = "";

			//
			// by default, we start with PRE and CUR; however, PRE may not exist so
			// we go with CUR and ARC
			//
			kixSrc = Helper.getKix(conn,campus,alpha,num,type);
			if(kixSrc.equals(Constant.BLANK)){
				type = "CUR";
				kixSrc = Helper.getKix(conn,campus,alpha,num,type);
				if(!kixSrc.equals(Constant.BLANK)){
					headerSrc = "Approved or Current";
					headerDst = "Archived";
					type = "ARC";
					kixDst = Helper.getKix(conn,campus,alpha,num,type);
				}
			}
			else{
				headerSrc = "Modification";
				headerDst = "Approved or Current";
				type = "CUR";
				kixDst = Helper.getKix(conn,campus,alpha,num,type);
			}

			//
			// course terms
			//
			String termSrc = CourseDB.getCourseItem(conn,kixSrc,"effectiveterm");
			String termDst = CourseDB.getCourseItem(conn,kixDst,"effectiveterm");

			termSrc = TermsDB.getTermDescription(conn,termSrc);
			termDst = TermsDB.getTermDescription(conn,termDst);

			//
			// available column names
			//
			String[] columns = QuestionDB.getCampusColumms(conn,campus).split(",");

			String[] itemList = null;
			String[] itemNames = null;

			//
			// items to compare
			//
			int x = 0;

			String columnsToShow = "";

			int[] items = null;

			String[] itemsToShow = null;

			//
			//
			//
			String outlineSummary = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineSummary");
			if(outlineSummary.equals(Constant.ON)){

				//
				// value2 contains list of course sequence to display
				// value3 contains column names for items in value2
				//
				String value2 = IniDB.getItem(conn,campus,"OutlineSummary","kval2");
				String value3 = IniDB.getItem(conn,campus,"OutlineSummary","kval3");

				if(!value2.equals(Constant.BLANK) && !value3.equals(Constant.BLANK)){

					itemList = value2.split(",");
					itemNames = value3.split(",");

					if(itemList.length == itemNames.length){

						items = new int[itemNames.length];
						for(x = 0; x < itemNames.length; x++){
							items[x] = NumericUtil.getInt(itemList[x],0);
						}

						//
						// select items for display. columns contains all outline items.
						// loop through and isolate only the columns we want to show
						//
						for(x = 0; x < items.length; x++){
							if(x>0){
								columnsToShow += ",";
							}
							columnsToShow += columns[items[x]-1];
						}

						itemsToShow = columnsToShow.split(",");

						// work is here
					}
					else{
						msg.setErrorLog("Course summary view not properly configured. System setting 'OutlineSummary' must be configured by your CC administrator.");
					} // sequence and column names must be same

				}
				else{
					msg.setErrorLog("Course summary view not properly configured. System setting 'OutlineSummary' must be configured by your CC administrator.");
				} // values for course summary are available

			}
			else{

				itemsToShow = QuestionDB.getCampusColumms(conn,campus).split(",");

				items = new int[itemsToShow.length];
				itemNames = new String[itemsToShow.length];
				for(i=0; i<itemsToShow.length;i++){
					items[i] = i+1;
					itemNames[i] = "Item " + (i+1);
				}

			} // OutlineSummary is enabled

			//
			// compare and display
			//
			for(i=0; i<itemsToShow.length;i++){

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + campus + "' AND question_friendly = '" + itemsToShow[i] + "'" );

				String dataSrc = CourseDB.getCourseItem(conn,kixSrc,itemsToShow[i]);
				dataSrc = Outlines.formatOutline(conn,itemsToShow[i],campus,alpha,num,type,kixSrc,dataSrc,true,user);

				String dataDst = CourseDB.getCourseItem(conn,kixDst,itemsToShow[i]);
				if(!dataDst.equals(Constant.BLANK)){
					dataDst = Outlines.formatOutline(conn,itemsToShow[i],campus,alpha,num,type,kixDst,dataDst,true,user);
				}
				else{
					dataDst = "";
				}

				//
				// template selection
				//
				if(advanced){
					template = advancedTemplate;
				}
				else{
					template = rowTemplate;
				}

				//
				// zebra rows
				//
				if (i % 2 != 0){
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				}
				else{
					rowColor = Constant.ODD_ROW_BGCOLOR;
				}

				//
				// display type
				//
				if(advanced){
					com.ase.aseutil.util.DiffUtil du = new com.ase.aseutil.util.DiffUtil();
					du.Diff_Timeout = 0;

					// Execute one reverse diff as a warmup.
					du.diff(dataDst, dataSrc, false);
					System.gc();

					dataDst = du.showHtml(du.diff(dataDst, dataSrc, false));
					du = null;

					template = template.replace("<| counter |>",(""+items[i]))
							.replace("<| bgcolor |>",rowColor)
							.replace("<| column |>",itemNames[i])
							.replace("<| answer1 |>",dataDst+"<br><br>");
				}
				else{

					if(!dataSrc.equals(dataDst) && !kixDst.equals(Constant.BLANK)){
						template = template.replace("datacolumnLeftCell","highlightdiff");
					}

					template = template.replace("<| counter |>",(""+items[i]))
							.replace("<| bgcolor |>",rowColor)
							.replace("<| column |>",itemNames[i])
							.replace("<| answer1 |>",dataSrc+"<br><br>")
							.replace("<| answer2 |>",dataDst+"<br><br>");

				} // advanced

				buf.append(template);

			} // for

			if(advanced){
				msg.setErrorLog("<table summary=\"\" id=\"tablecompareMatrix\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
									+ "<tr bgcolor=\"#FFD763\">"
									+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">#</td>"
									+"<td class=\"textblackth\" valign=\"top\" width=\"28%\">Item</td>"
									+"<td class=\"textblackth\" valign=\"top\" width=\"70%\">Advanced Compare/Merge</td>"
									+"</tr>"
									+ buf.toString()
									+ "</table>");
			}
			else{
				if(termDst.equals(Constant.BLANK)){
					msg.setErrorLog("<table summary=\"\" id=\"tablecompareMatrix\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
										+ "<tr bgcolor=\"#FFD763\">"
										+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">#</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"28%\">Item</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"34%\">"+headerSrc+" ("+termSrc+")</td>"
										+"<td align=\"center\" valign=\"top\" width=\"02%\">&nbsp;</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"34%\">"+headerDst+"</td>"
										+"</tr>"
										+ buf.toString()
										+ "</table>");
				}
				else{
					msg.setErrorLog("<table summary=\"\" id=\"tablecompareMatrix\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
										+ "<tr bgcolor=\"#FFD763\">"
										+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">#</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"28%\">Item</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"34%\">"+headerSrc+" ("+termSrc+")</td>"
										+"<td align=\"center\" valign=\"top\" width=\"02%\">&nbsp;</td>"
										+"<td class=\"textblackth\" valign=\"top\" width=\"34%\">"+headerDst+" ("+termDst+")</td>"
										+"</tr>"
										+ buf.toString()
										+ "</table>");
				}
			} // advanced

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines.compareMatrix ("+kixSrc+"/"+kixDst+"): " + e.toString());
		}

		return msg;
	} // compareMatrix

	/**
	 * returns true if the String argument is empty
	 */
	public static String footerStatus(Connection conn,String kix,String type) {

		String footerStatus = "";

		try{
			if(type.equals("ARC")){
				footerStatus = "Archived on " + CourseDB.getCourseItem(conn,kix,"coursedate");
			}
			else if(type.equals("CUR")){
				footerStatus = "Approved on " + CourseDB.getCourseItem(conn,kix,"coursedate");
			}
			else if(type.equals("PRE")){
				footerStatus = "Last modified on " + CourseDB.getCourseItem(conn,kix,"auditdate");
			}
		}
		catch(Exception e){
			logger.fatal("Outlines.footerStatus ("+kix+"/"+type+"): " + e.toString());
		}

		return footerStatus;
	}

	/*
	 * close
	 *	<p>
	 */
	public void close() throws SQLException {}
}