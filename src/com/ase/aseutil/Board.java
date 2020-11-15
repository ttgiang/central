/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// Board.java
//
package com.ase.aseutil;

import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import org.apache.log4j.Logger;

public class Board {

	static Logger logger = Logger.getLogger(Board.class.getName());

	public static final String FORUM_CLOSED = "closed";

	public Board() throws Exception {}

	/*
	 * displayUserMessage
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 *	@return int
	 */
	public static String displayUserMessage(Connection conn,String user,int fid,int mid,int item,String sort,String rtnToBoard,String rtn) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();

			PreparedStatement ps = conn.prepareStatement("SELECT thread_id,thread_level,processed,message_id,message_author,sq,en,qn FROM messages WHERE message_id=?");
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				int threadID = rs.getInt("thread_id");
				int threadLevel = rs.getInt("thread_level") + 1;
				int processed = rs.getInt("processed");
				int messageID = rs.getInt("message_id");

				int sq = rs.getInt("sq");
				int en = rs.getInt("en");
				int qn = rs.getInt("qn");

				String author = AseUtil.nullToBlank(rs.getString("message_author"));

				if (processed == 0 && !user.equals(author)){
					ForumDB.setMessageToProcessed(conn,fid,mid,item);
				}

				ForumDB.updateViewCount(conn,fid);

				PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM forums WHERE forum_id=?");
				ps2.setInt(1,fid);
				ResultSet rs2 = ps2.executeQuery();
				if(rs2.next()){

					String kix = AseUtil.nullToBlank(rs2.getString("historyid"));

					String src = AseUtil.nullToBlank(rs2.getString("src"));
					String campus = AseUtil.nullToBlank(rs2.getString("campus"));

					String junk = AttachDB.listAttachmentsByCategoryKix(conn,campus,Constant.FORUM,kix+"_"+mid,sort);
					if (junk != null && junk.length() > 0){
						buf.append(Html.BR()
									+ junk
									+ Html.BR());
					}

					buf.append(showUserForumLine(conn,
															fid,
															"open",
															AseUtil.nullToBlank(rs2.getString("forum_name")),
															"",
															0,
															kix,
															ForumDB.getCampusFromMid(conn,mid),
															"",
															mid,
															item,
															rtnToBoard,
															rtn,
															user,
															threadID));

					// when we have an item, it's possible we are dealing with a course or program
					if (item > 0 && kix != null && src != null){

						String question = "";
						int tab = 0;

						if (src.equals(Constant.COURSE)){
							tab = Constant.TAB_COURSE;
							int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);
							if (item > courseTabCount){
								tab = Constant.TAB_CAMPUS;
							}

							question = QuestionDB.getCourseQuestionBySequence(conn,campus,tab,item);
						}
						else if (src.equals(Constant.FOUNDATION)){
							tab = Constant.TAB_FOUNDATION;
							question = com.ase.aseutil.fnd.FndDB.getFoundations(conn,
																							com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"fndtype"),
																							sq,
																							en,
																							qn);
						}
						else if (src.equals(Constant.PROGRAM)){
							tab = Constant.TAB_PROGRAM;
							question = QuestionDB.getCourseQuestionBySequence(conn,campus,Constant.TAB_PROGRAM,item);
						} // course or program

						buf.append("<div class=\"outlineitem\"><div class=\"questionnumber\">"
										+ item
										+ ":</div><div class=\"question\">"
										+ question
										+ "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"##\" onClick=\"return collapseResponse();\" class=\"linkcolumn\"><img src=\"./images/du_arrow.gif\" title=\"collapse response\"></a>"
										+ "&nbsp;"
										+ "<a href=\"##\" onClick=\"return expandResponse('"+kix+"',"+tab+","+item+");\" class=\"linkcolumn\"><img src=\"./images/dd_arrow.gif\" title=\"expand response\"></a>"
										+ "</div></div>"
										+ "<div class=\"outlineitem\"><div class=\"questionnumber\">&nbsp;</div><div class=\"response\"></div>"
										+ "<div class=\"proposerResponse\" id=\"proposerResponse\"></div>"
										+ "</div>");

					} // valid item

				}
				rs2.close();
				ps2.close();

				buf.append(showChildren(conn,fid,item,0,0,mid,user));

				buf.append(ForumDB.getLegend());

			} // rs
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("Board - displayUserMessage: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - displayUserMessage: " + e.toString());
		}

		return buf.toString();
	} // Board - displayUserMessage

	/**
	*
	*/
   public static String showChildren(Connection conn,int fid,int item,int pid,int depth,int mid,String user) {

		//Logger logger = Logger.getLogger("test");

		// mid is the root thread that got us here.
		// parentID is the message following or below the root thread

		//
		//	this is a recursive function call. with each turn, it goes to the next level
		//	of data. the next level reaches the end when the last reply to a post is found.
		//	saving data to the session is the only way to collect data continually since
		//	with each return, the data is lost.
		//

		StringBuffer buf = new StringBuffer();
		String subject = "";
		String author = "";
		String tme = "";

		int threadID = 0;
		int processed = 0;
		int messageID = 0;

		int parentMID = pid;

		try{
			AseUtil aseUtil = new AseUtil();

			String src = ForumDB.getForumSrc(conn,fid);

			String sql = "SELECT message_id,thread_id,message_subject,message_author,message_timestamp,processed "
							+ "FROM messages WHERE forum_id=? AND thread_parent=? AND thread_id=? AND item=? "
							+ "ORDER BY message_id";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,mid);
			ps.setInt(4,item);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				messageID = rs.getInt("message_id");
				threadID = rs.getInt("thread_id");
				processed = rs.getInt("processed");
				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				author = AseUtil.nullToBlank(rs.getString("message_author"));

				if (	src.equals(Constant.FORUM_USERNAME) ||
						src.equals(Constant.COURSE) ||
						src.equals(Constant.PROGRAM) ||
						src.equals(Constant.FOUNDATION)
					){
					buf.append(showUserMessageLineX(conn,
																fid,
																parentMID,
																mid,
																threadID,
																messageID,
																depth,
																item,
																user));
				}
				else{
					tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);

					buf.append(ForumDB.showMessageLine(depth,
																	messageID,
																	item,
																	subject,
																	author,
																	tme,
																	0,
																	"message",
																	mid,
																	fid,
																	processed));
				}

				buf.append(showChildren(conn,fid,item,messageID,depth + 1,mid,user));
			}
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("Board - showChildren: " + e.toString());
		}

		return buf.toString();

	} // Board - showChildren

	/*
	 * showUserMessageLineX
	 *	<p>
	 *	@return String
	 */
	public static String showUserMessageLineX(Connection conn,
															int fid,
															int pid,
															int mid,
															int tid,
															int messageID,
															int depth,
															int item,
															String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// *******************************************************
		//
		// changes here requires changes to showBoardChildrenThreaded
		//
		// *******************************************************

		StringBuffer output = new StringBuffer();

		String subject = "";
		String author = "";
		String tme = "";
		String message = "";

		int i = 0;
		int threadLevel = 0;
		int nextThreadLevel = 0;
		int notified = 0;
		int processed = 0;

		String temp = "";

		try{

			AseUtil aseUtil = new AseUtil();
			WebSite website = new WebSite();

			String sql = "SELECT message_id,message_subject,message_author,message_timestamp,processed,message_body,thread_level,notified "
							+ "FROM messages "
							+ "WHERE forum_id=? AND thread_parent=? AND message_id=? AND thread_id=? AND item=? "
							+ "ORDER BY message_id";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,messageID);
			ps.setInt(4,tid);
			ps.setInt(5,item);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				message = AseUtil.nullToBlank(rs.getString("message_body"));
				message = website.removeBlankChar(message);

				// for every item added to the forum, a root thread is created to
				// group similar items together. the root thread has no message
				// and is hidden
				boolean showMessage = true;

				if(depth==0 && (message == null || message.equals(Constant.BLANK))){
					showMessage = false;
				}

				if(showMessage){
					author = AseUtil.nullToBlank(rs.getString("message_author"));
					tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);
					threadLevel = rs.getInt("thread_level");
					nextThreadLevel = threadLevel + 1;

					notified = NumericUtil.getInt(rs.getInt("notified"),0);
					processed = NumericUtil.getInt(rs.getInt("processed"),0);

					int editMID = NumericUtil.getInt(rs.getInt("message_id"),0);

					int col1 = depth;			// basic info; col1 is the depth of the current message (indentation)
					int col2 = 90-depth;		// message; col2 contains the message posted
					int col3 = 10;				// icons; col3 is room for icons

					temp = "<IMG SRC=\"/central/core/images/message"+depth+".gif\" BORDER=\"0\" ALIGN=\"absmiddle\">"
								+ "&nbsp;&nbsp;&nbsp;"
								+ "<font class=\"goldhighlights\">" + author.replace(" ","&nbsp;") + "</font>"
								+ "&nbsp;&nbsp;"
								+ tme.replace(" ", "&nbsp;")
								+ "&nbsp;&nbsp;"
								+ "<font color=\"#909090\">" + subject.replace(" ","&nbsp;") + "</font>";

					String link = "fid="+fid+"&src="+Constant.FORUM_USERNAME+"&mid="+messageID+"&item="+item+"&tid="+tid+"&pid="+messageID+"&level="+nextThreadLevel;

					String reply = "";
					String notifiedText = "&nbsp;";
					String deleteText = "&nbsp;";
					String processedText = "&nbsp;";
					String kix = ForumDB.getKix(conn,fid);

					if(!ForumDB.isPostClosedFidMidItem(conn,fid,messageID,item)){
						reply = "<a href=\"post.jsp?"+link+"\"><img src=\"./images/reply.gif\" border=\"0\" title=\"reply to a post\"></a>&nbsp;&nbsp;&nbsp;";
					}

					String div = "" + fid + "_" + messageID;
					String piv = "" + fid + "_" + pid  + "_" + messageID + "_" + threadLevel;

					//
					// allow user to edit their post as long as they have not completed the review/approval
					// and no one replied to their posts
					//
					boolean hasResplies = postHasReplies(conn,fid,messageID,threadLevel,item);

					if (user.equals(author) && notified==0 && threadLevel > 1 && !hasResplies){
						notifiedText = "<a href=\"edit.jsp?fid="+fid+"&rmid="+mid+"&item="+item+"&emid="+editMID+"\"><img src=\"../../images/edit.gif\" border=\"0\" title=\"edit post\"></a>&nbsp;&nbsp;&nbsp;";
					}

					if (user.equals(author) && threadLevel > 1 && !hasResplies){
						deleteText = "<a href=\"dlt.jsp?fid="+fid+"&rmid="+mid+"&item="+item+"&emid="+editMID+"\"><img src=\"../../images/del.gif\" border=\"0\" title=\"edit post\"></a>&nbsp;&nbsp;&nbsp;";
					}

					if (!user.equals(author) && ForumDB.isMatch(conn,fid,messageID,pid,threadLevel,user)){
						processedText = "<a href=\"##\" onClick=\"return processedOff('processed_id_"+piv+"'); \"><img src=\"./images/new.png\" border=\"0\" title=\"new\"></a>&nbsp;&nbsp;&nbsp;";
					}

					// allowing full edit all the time removes this code
					//if (!ForumDB.canUserEditPost(conn,user,author,kix,processed,notified,fid,editMID)){
					//	reply = "&nbsp;";
					//}

					reply = "<div style=\"float: left;\" id=\"reply_id_"+div+"\">"
							+ reply
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"notified_id_"+div+"\">"
							+ notifiedText
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"delete_id_"+div+"\">"
							+ deleteText
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"processed_id_"+piv+"\">"
							+ processedText
							+ "</div>"
							;

					if (ForumDB.isPostClosed(conn,fid,mid)){
						reply = "&nbsp;";
					}

					int divID_1 = fid+mid+item;
					int divID_2 = divID_1 + 1;

					output.append("<div id=\"record-"+divID_1+"\" class=\"ase-table-row-detail\">"
									+ "<div class=\"col"+col1+"\">&nbsp;</div>"
									+ "<div class=\"col"+col2+"\">"+temp+"</div>"
									+ "<div class=\"col"+col3+"\">"
									+ reply
									+ "</div>"
									+ "<div id=\"ras\" class=\"space-line\"></div>"
									+ "</div>");

					output.append("<div id=\"record-"+divID_2+"\" class=\"ase-table-row-detail\">"
									+ "<div class=\"col"+col1+"\">&nbsp;</div>"
									+ "<div class=\"col"+col2+"\"><font class=\"datacolumn\">"+message+"</font></div>"
									+ "<div class=\"col"+col3+"\">&nbsp;</div>"
									+ "<div id=\"ras\" class=\"space-line\"></div>"
									+ "</div>");
				} // showMessage

			}
			rs.close();
			ps.close();

			aseUtil = null;
			website = null;

		}
		catch(Exception e){
			logger.fatal("Board - showUserMessageLineX: " + e.toString());
		}

		return output.toString();
	} // Board - showUserMessageLineX

	/**
	 * showUserForumLine
	 * <p>
	 * @return	String
	*/
	public static String showUserForumLine(Connection conn,
														int fid,
														String sFolderStatus,
														String sName,
														String sDescription,
														long iMessageCount,
														String kix,
														String campus,
														String xref,
														int mid,
														int item,
														String rtnToBoard,
														String rtn,
														String user,
														int threadID) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();

		int attachments = 0;


		try{
			String created = null;
			String updated = null;
			int priority = 0;
			int sq = 0;
			int en = 0;
			int qn = 0;

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			boolean isFoundation = false;
			if(!isAProgram){
				isFoundation = fnd.isFoundation(conn,kix);
			}

			String[] info = null;
			String coproposer = "";

			if(isFoundation){
				info = fnd.getKixInfo(conn,kix);
				coproposer = fnd.getFndItem(conn,kix,"coproposer");
				sq = MessagesDB.getNumericItem(conn,mid,"sq");
				en = MessagesDB.getNumericItem(conn,mid,"en");
				qn = MessagesDB.getNumericItem(conn,mid,"qn");
			}
			else{
				info = Helper.getKixInfo(conn,kix);
			}

			fnd = null;

			String proposer = info[Constant.KIX_PROPOSER];
			String progress = info[Constant.KIX_PROGRESS];
			String subprogress = info[Constant.KIX_SUBPROGRESS];

			String reviewerNames = ReviewerDB.getReviewerNames(conn,kix);
			String approverNames = ApproverDB.getApproverNames(conn,kix);

			//
			// rtn is set here to keep back.gif on at all times for the right person
			//
			if(rtn.equals(Constant.BLANK)){
				if(reviewerNames.contains(user)){
					rtn = "rvw";
				}
				else if(approverNames.contains(user)){
					rtn = "apr";
				}
				else if(user.contains(proposer)){
					if(isAProgram){
						rtn = Constant.PROGRAM;
					}
					else if(isFoundation){
						rtn = Constant.FOUNDATION;
					}
					else{
						rtn = Constant.COURSE;
					}
				}
			}

			//
			// figure out return point
			//
			String bookmarkTab = "c1-";
			int type = 1;
			int maxNoCourse = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			if(item > maxNoCourse){
				bookmarkTab = "c2-";
				type = 2;
			}
			String bookmarkSeq = bookmarkTab + QuestionDB.getQuestionNumber(conn,campus,type,item);

			//
			// attachments
			//
			if (!kix.equals(Constant.BLANK)){
				attachments = ForumDB.getAttachments(kix,"","","Forum");
			}

			String forumName = "";
			String forumDescr = "";

			Forum forum = ForumDB.getForum(conn,fid);
			if (forum != null){
				created = forum.getCreatedDate();
				updated = forum.getAuditDate();
				priority = forum.getPriority();
				forumName = forum.getForum();
				forumDescr = forum.getDescr();
			}
			forum = null;

			String status = "Active";
			boolean closed = ForumDB.isPostClosed(conn,fid,mid);
			if (closed){
				status = "Closed";
			}

			//
			// when coming from a review or modification screen, allow link to return there
			// however, return if they are part of the process.
			//
			if (rtn != null && rtn.length() > 0){

				if (rtn.equals("rvw")){

					if(isAProgram){
						rtn = "prgrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>&nbsp;&nbsp;&nbsp;";
					}
					else if(isFoundation){
						rtn = "fndrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>&nbsp;&nbsp;&nbsp;";
					}
					else{
						rtn = "crsrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>&nbsp;&nbsp;&nbsp;";
					}

				}
				else if (rtn.equals("apr")){

					if(isAProgram){
						rtn = "prgappr.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>&nbsp;&nbsp;&nbsp;";
					}
					if(isFoundation){
						rtn = "fndappr.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>&nbsp;&nbsp;&nbsp;";
					}
					else{
						rtn = "crsappr.jsp?kix="+kix+"#"+bookmarkSeq;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>&nbsp;&nbsp;&nbsp;";
					}

				}
				else if (rtn.equals(Constant.COURSE) && user.equals(proposer)){
					rtn = "crsedt.jsp?kix="+kix;
					rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>&nbsp;&nbsp;&nbsp;";
				}
				else if (rtn.equals(Constant.PROGRAM) && user.equals(proposer)){
					rtn = "prgedt.jsp?kix="+kix;
					rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>&nbsp;&nbsp;&nbsp;";
				}
				else if (rtn.equals(Constant.FOUNDATION) && (user.equals(proposer) || coproposer.contains("user"))){
					rtn = "fndedt.jsp?kix="+kix;
					rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>&nbsp;&nbsp;&nbsp;";
				}
				else{
					rtn = "";
				}
			} // rtn

			output.append(
							"<table width=\"100%\" border=\"0\">"
							+ "<tr id=\"warnmessage\"><td width=\"40%\">"
							+ "&nbsp;"
							+ forumName + " - " + forumDescr + " (Proposer: " + proposer + ")"
							+ "</td>"
							+ "<td align=\"center\">"
							+ status
							+ "</td>"
							+ "<td align=\"right\" width=\"40%\">"
							+ rtn
							+ "<a href=\"../"+rtnToBoard+".jsp\"><img src=\"./images/legend.png\" border=\"0\" alt=\"go to board listing\" title=\"go to board listing\"></a>&nbsp;&nbsp;&nbsp;"
							+ "&nbsp;"
							+ "<a href=\"./usrbrd.jsp?fid="+fid+"\"><img src=\"../../images/ed_list_num.gif\" border=\"0\" alt=\"go to post listing\" title=\"go to post listing\"></a>&nbsp;&nbsp;&nbsp;");

			// can't create unless it's open and that you are a reviewer or approver
			if (!closed && (reviewerNames.contains(user) || approverNames.contains(user))){
				output.append("&nbsp;"
				+ "<A class=\"linkcolumn\" HREF=\"./post.jsp?src="+Constant.FORUM_USERNAME+"&fid="+fid+"&item="+item+"&tid="+threadID+"&pid="+threadID+"&level=2\"><img src=\"./images/icon_post_message.png\" border=\"0\" title=\"new post\"></A>&nbsp;&nbsp;&nbsp;");
			}

			output.append("&nbsp;"
							+ "<a href=\"./prt.jsp?fid="+fid+"&mid="+mid+"&sq="+sq+"&en="+en+"&qn="+qn+"\" target=\"_blank\"><img src=\"../../images/printer.jpg\" border=\"0\" alt=\"printer friendly\" title=\"printer friendly\"></a>&nbsp;&nbsp;&nbsp;"
							+ "&nbsp;"
							);

			if (!kix.equals(Constant.BLANK)){
				if (isAProgram){
					output.append("<a href=\"/centraldocs/docs/programs/"+campus.toUpperCase()+"/"+kix+".html\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;");
				}
				else if (isFoundation){
					output.append("<a href=\"/centraldocs/docs/fnd/"+campus.toUpperCase()+"/"+kix+".html\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view foundation\" title=\"view foundation\"></a>&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;");
				}
				else{
					output.append("<a href=\"../vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;");
				}
			}

			String creator = ForumDB.getCreator(conn,fid,mid);
			if (	!closed
					&& creator.equals(user)
					&& (reviewerNames == null || reviewerNames.equals(Constant.BLANK))
					&& (approverNames == null || approverNames.equals(Constant.BLANK))
			){
				output.append("<a href=\"./clspst.jsp?fid="+fid+"&mid="+mid+"&item="+item+"\"><img src=\"./images/close_door.gif\" border=\"0\" alt=\"close this post\" title=\"close this post\"></a>&nbsp;&nbsp;&nbsp;"
					+ "&nbsp;");
			}

			output.append("<a href=#?w=500 rel=page_help class=poplight><img src=\"/central/core/images/helpicon.gif\" alt=\"page help\"></a>&nbsp;&nbsp;&nbsp;");

			output.append("</td></tr></table>");
		}
		catch(Exception e){
			logger.fatal("Board - showUserForumLine: " + e.toString());
		}

		return output.toString();
	} // Board: showUserForumLine

	/**
	* printChildren is silimar to showChilder above. just simpler in code for printing
	*/
   public static String printChildren(Connection conn,int fid,int item,int pid,int depth,int mid,String user) {

		//Logger logger = Logger.getLogger("test");

		// mid is the root thread that got us here.
		// parentID is the message following or below the root thread

		//
		//	this is a recursive function call. with each turn, it goes to the next level
		//	of data. the next level reaches the end when the last reply to a post is found.
		//	saving data to the session is the only way to collect data continually since
		//	with each return, the data is lost.
		//

		StringBuffer buf = new StringBuffer();
		String subject = "";
		String author = "";
		String tme = "";

		int threadID = 0;
		int processed = 0;
		int messageID = 0;

		int parentMID = pid;

		try{
			AseUtil aseUtil = new AseUtil();

			String src = ForumDB.getForumSrc(conn,fid);

			String sql = "SELECT message_id,thread_id,message_subject,message_author,message_timestamp,processed "
							+ "FROM messages "
							+ "WHERE forum_id=? AND thread_parent=? AND thread_id=? AND item=? "
							+ "ORDER BY message_id";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,mid);
			ps.setInt(4,item);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				messageID = rs.getInt("message_id");
				threadID = rs.getInt("thread_id");
				processed = rs.getInt("processed");
				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				author = AseUtil.nullToBlank(rs.getString("message_author"));

				buf.append(printUserMessageLineX(conn,
															fid,
															parentMID,
															mid,
															threadID,
															messageID,
															depth,
															item,
															user));

				buf.append(printChildren(conn,fid,item,messageID,depth + 1,mid,user));
			}
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("Board - printChildren: " + e.toString());
		}

		return buf.toString();

	}

	/*
	 * printUserMessageLineX
	 *	<p>
	 *	@return String
	 */
	public static String printUserMessageLineX(Connection conn,
															int fid,
															int pid,
															int mid,
															int tid,
															int messageID,
															int depth,
															int item,
															String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();

		String subject = "";
		String author = "";
		String tme = "";
		String message = "";

		int i = 0;
		int threadLevel = 0;
		String temp = "";

		try{

			AseUtil aseUtil = new AseUtil();
			WebSite website = new WebSite();

			String sql = "SELECT message_subject,message_author,message_timestamp,processed,message_body,thread_level,notified "
							+ "FROM messages "
							+ "WHERE forum_id=? AND thread_parent=? AND message_id=? AND thread_id=? AND item=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,messageID);
			ps.setInt(4,tid);
			ps.setInt(5,item);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				message = AseUtil.nullToBlank(rs.getString("message_body"));
				message = website.removeBlankChar(message);

				// for every item added to the forum, a root thread is created to
				// group similar items together. the root thread has no message
				// and is hidden
				boolean showMessage = true;

				if(depth==0 && (message == null || message.equals(Constant.BLANK))){
					showMessage = false;
				}

				if(showMessage){

					author = AseUtil.nullToBlank(rs.getString("message_author"));
					tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);
					threadLevel = rs.getInt("thread_level") + 1;

					int col1 = depth;			// basic info; col1 is the depth of the current message (indentation)
					int col2 = 95-depth;		// message; col2 contains the message posted

					temp = "<IMG SRC=\"/central/core/images/message"+depth+".gif\" BORDER=\"0\" ALIGN=\"absmiddle\">"
								+ "&nbsp;&nbsp;&nbsp;"
								+ "<font class=\"goldhighlights\">" + author.replace(" ","&nbsp;") + "</font>"
								+ "&nbsp;&nbsp;"
								+ tme.replace(" ", "&nbsp;")
								+ "&nbsp;&nbsp;"
								+ "<font color=\"#909090\">" + subject.replace(" ","&nbsp;") + "</font>";

					int divID_1 = fid+mid+item;
					int divID_2 = divID_1 + 1;

					String clss = "ase-table-row-detail";
					if (threadLevel-1==1){
						clss = "ase-table-row-detail-highlight";
					}

					output.append("<div id=\"record-"+divID_1+"\" class=\""+clss+"\">"
									+ "<div class=\"col"+col1+"\">&nbsp;</div>"
									+ "<div class=\"col"+col2+"\">"+temp+"</div>"
									+ "<div id=\"ras\" class=\"space-line\"></div>"
									+ "</div>");

					output.append("<div id=\"record-"+divID_2+"\" class=\""+clss+"\">"
									+ "<div class=\"col"+col1+"\">&nbsp;</div>"
									+ "<div class=\"col"+col2+"\"><font class=\"datacolumn\">"+message+"</font></div>"
									+ "<div id=\"ras\" class=\"space-line\"></div>"
									+ "</div>");

				} // showMessage

			}
			rs.close();
			ps.close();

			aseUtil = null;
			website = null;

		}
		catch(Exception e){
			logger.fatal("Board - printUserMessageLineX: " + e.toString());
		}

		return output.toString();
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	userid
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatch(Connection conn,int fid,String userid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try{
			String sql = "SELECT fid FROM forumsx WHERE fid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setString(2,userid);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Board - isMatch: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - isMatch: " + e.toString());
		}

		return exists;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * @param	userid
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatchMessagesX(Connection conn,int fid,int mid,String userid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try{
			String sql = "SELECT fid FROM messagesx WHERE fid=? AND mid=? AND author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setString(3,userid);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Board - isMatchMessagesX: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - isMatchMessagesX: " + e.toString());
		}

		return exists;
	}

	/**
	 * addBoardMember
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * @param	userid	String
	 * <p>
	 */
	public static void addBoardMember(Connection conn,int fid,String userid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try{
			if (!isMatch(conn,fid,userid)){
				String sql = "INSERT INTO forumsx(fid,userid) VALUES(?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setString(2,userid);
				ps.executeUpdate();
				ps.close();

				String forumName = "";
				String campus = "";
				String kix = "";

				Forum forum = ForumDB.getForum(conn,fid);
				if (forum != null){
					forumName = forum.getForum();
					kix = forum.getHistoryid();
					campus = forum.getCampus();

					String proposer = "";
					String alpha = "";
					String num = "";

					if(!kix.equals(Constant.BLANK)){
						String[] info = Helper.getKixInfo(conn,kix);
						proposer = info[Constant.KIX_PROPOSER];
						alpha = info[Constant.KIX_ALPHA];
						num = info[Constant.KIX_NUM];
					}

					new MailerDB(conn,
								proposer,
								userid,
								Constant.BLANK,
								Constant.BLANK,
								alpha,
								num,
								campus,
								"emailMessageBoardMember",
								kix,
								proposer);

					AseUtil.logAction(conn,
											userid,
											"ACTION",
											userid + " added to message board "+ forumName,
											alpha,
											num,
											campus,
											kix);
				}
				forum = null;

			}
		}
		catch(SQLException e){
			logger.fatal("Board: addBoardMember - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board: addBoardMember - " + e.toString());
		}

	} // Board: addBoardMember

	/**
	 * addBoardMember
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * @param	userid	String
	 * <p>
	 */
	public static void deleteBoardMember(Connection conn,int fid,String userid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try{
			String sql = "DELETE FROM forumsx WHERE fid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setString(2,userid);
			ps.executeUpdate();
			ps.close();

			String forumName = "";
			String campus = "";
			String kix = "";

			Forum forum = ForumDB.getForum(conn,fid);
			if (forum != null){
				forumName = forum.getForum();
				kix = forum.getHistoryid();
				campus = forum.getCampus();

				String alpha = "";
				String num = "";

				if(!kix.equals(Constant.BLANK)){
					String[] info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
				}

				AseUtil.logAction(conn,
										userid,
										"ACTION",
										userid + " removed from message board "+ forumName,
										alpha,
										num,
										campus,
										kix);
			}
			forum = null;

		}
		catch(SQLException e){
			logger.fatal("Board: deleteBoardMember - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board: deleteBoardMember - " + e.toString());
		}

	} // Board: deleteBoardMember

	/**
	 * displayBoardThreaded
	 * <p>
	 * @param	conn			Connection
	 * @param	user			String
	 * @param	fid			int
	 * @param	mid			int
	 * @param	item			int
	 * @param	sort			String
	 * @param	rtnToBoard	String
	 * <p>
	 */
	public static String displayBoardThreaded(Connection conn,String user,int fid,int mid,int item,String sort,String rtnToBoard,String rtn) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{

			int i = 1;

			int sq = 0;
			int en = 0;
			int qn = 0;

			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT thread_id,thread_level,processed,message_id,message_timestamp,message_author,message_subject,sq,en,qn FROM messages WHERE message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				int tid = rs.getInt("thread_id");
				int tl = rs.getInt("thread_level");
				int messageID = rs.getInt("message_id");
				String author = AseUtil.nullToBlank(rs.getString("message_author"));
				String subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				String tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);

				sq = rs.getInt("sq");
				en = rs.getInt("en");
				qn = rs.getInt("qn");

				String row = "odd";

				if (i % 2 == 0){
					row = "even";
				}

				boolean closed = ForumDB.isPostClosed(conn,fid,mid);

				// question question and response for display
				int tab = 0;

				String kix = "";
				String campus = "";
				String question = "";

				PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM forums WHERE forum_id=?");
				ps2.setInt(1,fid);
				ResultSet rs2 = ps2.executeQuery();
				if(rs2.next()){
					kix = AseUtil.nullToBlank(rs2.getString("historyid"));
					campus = AseUtil.nullToBlank(rs2.getString("campus"));
					String src = AseUtil.nullToBlank(rs2.getString("src"));
					if (src.equals(Constant.COURSE)){
						tab = Constant.TAB_COURSE;
						int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);
						if (item > courseTabCount){
							tab = Constant.TAB_CAMPUS;
						}

						question = QuestionDB.getCourseQuestionBySequence(conn,campus,tab,item);
					}
					else if (src.equals(Constant.FOUNDATION)){
						tab = Constant.TAB_FOUNDATION;
						question = com.ase.aseutil.fnd.FndDB.getFoundations(conn,
																						com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"fndtype"),
																						sq,
																						en,
																						qn);
					} // course or program
					else if (src.equals(Constant.PROGRAM)){
						tab = Constant.TAB_PROGRAM;
						question = QuestionDB.getCourseQuestionBySequence(conn,campus,Constant.TAB_PROGRAM,item);
					} // course or program
				} // if rs2
				rs2.close();
				ps2.close();

				String proposer = CourseDB.getCourseProposer(conn,kix);

				String reviewerNames = ReviewerDB.getReviewerNames(conn,kix);
				String approverNames = ApproverDB.getApproverNames(conn,kix);

				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

				com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

				proposer = "";
				String coproposer = "";

				boolean isFoundation = false;
				if(!isAProgram){
					isFoundation = fnd.isFoundation(conn,kix);
				}

				if(isFoundation){
					proposer = fnd.getFndItem(conn,kix,"proposer");
					coproposer = fnd.getFndItem(conn,kix,"coproposer");
					sq = MessagesDB.getNumericItem(conn,mid,"sq");
					en = MessagesDB.getNumericItem(conn,mid,"en");
					qn = MessagesDB.getNumericItem(conn,mid,"qn");
				}

				fnd = null;

				//
				// rtn is set here to keep back.gif on at all times for the right person
				//
				if(rtn.equals(Constant.BLANK)){
					if(reviewerNames.contains(user)){
						rtn = "rvw";
					}
					else if(approverNames.contains(user)){
						rtn = "apr";
					}
					else if(user.contains(proposer)){
						if(isAProgram){
							rtn = Constant.PROGRAM;
						}
						else if(isFoundation){
							rtn = Constant.FOUNDATION;
						}
						else{
							rtn = Constant.COURSE;
						}
					}
				}

				//
				// figure out return point
				//
				String bookmarkTab = "c1-";
				int type = 1;
				int maxNoCourse = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
				if(item > maxNoCourse){
					bookmarkTab = "c2-";
					type = 2;
				}
				String bookmarkSeq = bookmarkTab + QuestionDB.getQuestionNumber(conn,campus,type,item);

				// when coming from a review or modification screen, allow link to return there
				// however, return if they are part of the process.
				if (rtn != null && rtn.length() > 0){

					if (rtn.equals("rvw")){

						if(isAProgram){
							rtn = "prgrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>";
						}
						else if(isFoundation){
							rtn = "fndrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>";
						}
						else{
							rtn = "crsrvwer.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>";
						}

					}
					else if (rtn.equals("apr")){

						if(isAProgram){
							rtn = "prgappr.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>";
						}
						else if(isFoundation){
							rtn = "fndappr.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>";
						}
						else{
							rtn = "crsappr.jsp?kix="+kix+"#"+bookmarkSeq;
							rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>";
						}

					}
					else if (rtn.equals(Constant.COURSE) && user.equals(proposer)){
						rtn = "crsedt.jsp?kix="+kix;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>";
					}
					else if (rtn.equals(Constant.PROGRAM) && user.equals(ProgramsDB.getProgramProposer(conn,campus,kix))){
						rtn = "prgedt.jsp?kix="+kix;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>";
					}
					else if (rtn.equals(Constant.FOUNDATION) && (user.equals(proposer) || coproposer.contains(user))){
						rtn = "fndedt.jsp?kix="+kix;
						rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>";
					}
					else{
						rtn = "";
					}

					rtn = rtn + "&nbsp;&nbsp;";
				} // rtn

				buf.append(
					"<li class=\"comment "+row+" thread-alt thread-"+row+" depth-"+tl+"\" id=\"li-comment-"+mid+"\">"
					+ "<div class=\"comment-author vcard\">"
					+ "<span class=\"fn\">"+author+" "+ tme+"</span>"
					+ "&nbsp;&nbsp;&nbsp;" + rtn
					+ "<a href=\"../"+rtnToBoard+".jsp\"><img src=\"./images/legend.png\" border=\"0\" alt=\"go to board listing\" title=\"go to board listing\"></a>&nbsp;"
					+ "&nbsp;<a href=\"./usrbrd.jsp?fid="+fid+"\"><img src=\"../../images/ed_list_num.gif\" border=\"0\" alt=\"go to post listing\" title=\"go to post listing\"></a>&nbsp;");

				if(!closed && (reviewerNames.contains(user) || approverNames.contains(user))){
					buf.append("&nbsp;<a class=\"linkcolumn\" HREF=\"./post.jsp?src="+Constant.FORUM_USERNAME+"&fid="+fid+"&item="+item+"&tid="+mid+"&pid="+mid+"&level=2\"><img src=\"./images/icon_post_message.png\" border=\"0\" title=\"new post\"></A>&nbsp;");
				}

				buf.append("&nbsp;<a href=\"./prt.jsp?fid="+fid+"&mid="+mid+"&sq="+sq+"&en="+en+"&qn="+qn+"\" target=\"_blank\"><img src=\"../../images/printer.jpg\" border=\"0\" alt=\"printer friendly\" title=\"printer friendly\"></a>&nbsp;");

				if (isAProgram){
					buf.append("&nbsp;<a href=\"/centraldocs/docs/programs/"+campus.toUpperCase()+"/"+kix+".html\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;");
				}
				if (isFoundation){
					buf.append("&nbsp;<a href=\"/centraldocs/docs/fnd/"+campus.toUpperCase()+"/"+kix+".html\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view foundation\" title=\"view foundation\"></a>&nbsp;");
				}
				else{
					buf.append("&nbsp;<a href=\"../vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"/central/images/compare.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;");
				}

				String creator = ForumDB.getCreator(conn,fid,mid);
				if (	!closed
						&& creator.equals(user)
						&& (reviewerNames == null || reviewerNames.equals(Constant.BLANK))
						&& (approverNames == null || approverNames.equals(Constant.BLANK))
				){
					buf.append("&nbsp;<a href=\"./clspst.jsp?fid="+fid+"&mid="+mid+"&item="+item+"\"><img src=\"./images/close_door.gif\" border=\"0\" alt=\"close this post\" title=\"close this post\"></a>&nbsp;");
				}

				buf.append(
					"</div>"
					+ "<div class=\"comment-content\"></p>"
					+ item + ". " + question
					+ "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"##\" onClick=\"return collapseResponse();\" class=\"linkcolumn\"><img src=\"./images/du_arrow.gif\" title=\"collapse response\"></a>"
					+ "&nbsp;"
					+ "<a href=\"##\" onClick=\"return expandResponse('"+kix+"',"+tab+","+item+");\" class=\"linkcolumn\"><img src=\"./images/dd_arrow.gif\" title=\"expand response\"></a>"
					+ "</p>"
					+ "<div class=\"outlineitem\"><div class=\"questionnumber\">&nbsp;</div><div class=\"response\"></div>"
					+ "<div class=\"proposerResponse\" id=\"proposerResponse\"></div>"
					+ "</div>"
					+ "<div class=\"reply\"></div>"
					+ ""
				);

				++i;

				buf.append(showBoardChildrenThreaded(conn,fid,item,0,2,messageID,user));

				buf.append("</li>");

				buf.append(ForumDB.getLegend());

			} // rs
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("Board - displayBoardThreaded: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - displayBoardThreaded: " + e.toString());
		}

		return buf.toString();
	} // Board - displayBoardThreaded

	/**
	*
	*/
   public static String showBoardChildrenThreaded(Connection conn,int fid,int item,int pid,int tl,int mid,String user) {

		//Logger logger = Logger.getLogger("test");

		// *******************************************************
		//
		// changes here requires changes to showUserMessageLineX
		//
		// *******************************************************

		StringBuffer buf = new StringBuffer();

		try{
			int i = 1;

			AseUtil aseUtil = new AseUtil();

			String src = ForumDB.getForumSrc(conn,fid);

			buf.append("<ul class=\"children\">");

			String sql = "SELECT message_id,thread_id,message_body,message_author,message_timestamp,processed,thread_level,notified "
							+ "FROM messages "
							+ "WHERE forum_id=? AND thread_parent=? AND thread_id=? AND item=? "
							+ "ORDER BY message_id";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,mid);
			ps.setInt(4,item);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int messageID = rs.getInt("message_id");
				int tid = rs.getInt("thread_id");
				String body = AseUtil.nullToBlank(rs.getString("message_body"));
				String author = AseUtil.nullToBlank(rs.getString("message_author"));
				String tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);
				int threadLevel = rs.getInt("thread_level") + 1;

				// for every item added to the forum, a root thread is created to
				// group similar items together. the root thread has no message
				// and is hidden
				boolean showMessage = true;

				if(threadLevel==2 && (body == null || body.equals(Constant.BLANK))){
					showMessage = false;
				}

				if(showMessage){

					int notified = NumericUtil.getInt(rs.getInt("notified"),0);
					int processed = NumericUtil.getInt(rs.getInt("processed"),0);

					String row = "odd";

					if (i % 2 == 0){
						row = "even";
					}

					String reply = "";
					String notifiedText = "&nbsp;";
					String deleteText = "&nbsp;";
					String processedText = "&nbsp;";
					String kix = ForumDB.getKix(conn,fid);

					String link = "fid="+fid+"&src="+Constant.FORUM_USERNAME+"&mid="+messageID+"&item="+item+"&tid="+tid+"&pid="+messageID+"&level="+threadLevel;

					String div = "" + fid + "_" + messageID;
					String piv = "" + fid + "_" + pid  + "_" + messageID + "_" + (threadLevel-1);

					//
					// allow user to edit their post as long as they have not completed the review/approval
					// and no one replied to their posts
					//
					boolean hasResplies = postHasReplies(conn,fid,messageID,threadLevel-1,item);

					if (user.equals(author) && notified==0 && !hasResplies){
						notifiedText = "<a href=\"edit.jsp?fid="+fid+"&rmid="+mid+"&item="+item+"&emid="+messageID+"\"><img src=\"../../images/edit.gif\" border=\"0\" title=\"edit post\"></a>&nbsp;&nbsp;&nbsp;";
					}

					if (user.equals(author) && threadLevel > 1 && !hasResplies){
						deleteText = "<a href=\"dlt.jsp?fid="+fid+"&rmid="+mid+"&item="+item+"&emid="+messageID+"\"><img src=\"../../images/del.gif\" border=\"0\" title=\"edit post\"></a>&nbsp;&nbsp;&nbsp;";
					}

					if (!user.equals(author) && ForumDB.isMatch(conn,fid,messageID,pid,threadLevel-1,user)){
						processedText = "<a href=\"##\" onClick=\"return processedOff('processed_id_"+piv+"'); \"><img src=\"./images/new.png\" border=\"0\" title=\"new\"></a>&nbsp;&nbsp;";
					}

					if(!ForumDB.isPostClosedFidMidItem(conn,fid,messageID,item)){
						reply = "&nbsp;&nbsp;<a href=\"post.jsp?"+link+"\"><img src=\"./images/reply.gif\" border=\"0\" title=\"reply to a post\"></a>&nbsp;&nbsp;";
					}

					reply = "<div style=\"float: left;\" id=\"reply_id_"+div+"\">"
							+ reply
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"notified_id_"+div+"\">"
							+ notifiedText
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"delete_id_"+div+"\">"
							+ deleteText
							+ "</div>"
							+ "<div style=\"float: left;\" id=\"processed_id_"+piv+"\">"
							+ processedText
							+ "</div>"
							;

					if (ForumDB.isPostClosed(conn,fid,mid)){
						reply = "&nbsp;";
					}

					buf.append(
						"<li class=\"comment "+row+" thread-"+row+" depth-"+tl+"\" id=\"li-comment-"+mid+"\">"
						+ "<div class=\"comment-author vcard\">"
						+ "<span class=\"fnx\">"+author+" "+tme+"</span>"
						+ reply
						+ "</div>"
						+ "<br><br>"
						+ "<div class=\"comment-content\">"+body+"</div>"
						+ "<div class=\"reply\"></div>"
					);

					++i;

				} // showMessage

				buf.append(showBoardChildrenThreaded(conn,fid,item,messageID,tl + 1,mid,user));

				buf.append("</li>");

			}
			rs.close();
			ps.close();

			aseUtil = null;

			buf.append("</ul>");

		}
		catch(Exception e){
			logger.fatal("Board - showBoardChildrenThreaded: " + e.toString());
		}

		return buf.toString();

	} // Board - showBoardChildrenThreaded

	/**
	 * getRootPostMessageId - get the root or message id for outline item X
	 * <p>
	 * @param	conn	Connection
	 * @param	fid	int
	 * @param	item	int
	 * <p>
	 * @return	int
	 */
	public static int getRootPostMessageId(Connection conn,int fid,int item) throws SQLException {

		int mid = 0;

		try{
			String sql = "select message_id from messages where forum_id=? and item=? and thread_parent= 0 and thread_level=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				mid = NumericUtil.getInt(rs.getInt("message_id"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Board - getRootPostMessageId: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - getRootPostMessageId: " + e.toString());
		}

		return mid;
	}

	/**
	 * getMessageForEdit
	 * <p>
	 * @param	conn	Connection
	 * @param	fid	int
	 * @param	mid	int
	 * <p>
	 * @return	String[]
	 */
	public static String[] getMessageForEdit(Connection conn,int fid,int mid) throws SQLException {

		String[] brd = new String[3];

		try{
			String sql = "select message_subject,message_body,message_author_notify from messages where forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				brd[0] = AseUtil.nullToBlank(rs.getString("message_subject"));
				brd[1] = AseUtil.nullToBlank(rs.getString("message_body"));
				brd[2] = AseUtil.nullToBlank(rs.getString("message_author_notify"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Board - getMessageForEdit: " + e.toString());
			brd = null;
		}
		catch(Exception e){
			logger.fatal("Board - getMessageForEdit: " + e.toString());
			brd = null;
		}

		return brd;
	}

	/**
	 * updatePost
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * @param	mid		int
	 * @param	subject	String
	 * @param	body		String
	 * <p>
	 * @return	int
	 */
	public static int updatePost(Connection conn,int fid,int mid,String subject,String body) throws SQLException {

		return updatePost(conn,fid,mid,subject,body,false);

	}

	public static int updatePost(Connection conn,int fid,int mid,String subject,String body,boolean notify) throws SQLException {

		int rowsAffected = 0;

		try{
			String sql = "UPDATE messages SET message_subject=?,message_body=?,message_timestamp=?,message_author_notify=? where forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,subject);
			ps.setString(2,body);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setBoolean(4,notify);
			ps.setInt(5,fid);
			ps.setInt(6,mid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Board - updatePost: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - updatePost: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * endReviewProcess
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int endReviewProcess(Connection conn,String campus,String kix) throws SQLException {

		int rowsAffected = 0;

		try{
			int fid = ForumDB.getForumID(conn,campus,kix);
			if (fid > 0){

				// remove as member
				String sql = "DELETE FROM forumsx WHERE fid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// disable edit to old posts
				sql = "UPDATE messages set notified=1,processed=1,processeddate=? WHERE forum_id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setInt(2,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// ennding reviews deletes pending messages
				sql = "DELETE FROM messagesx WHERE fid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

			}
		}
		catch(SQLException e){
			logger.fatal("Board - endReviewProcess: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - endReviewProcess: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * endReviewProcess
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 * @return	int
	 */
	public static int endReviewProcess(Connection conn,String campus,String kix,String user) throws SQLException {

		int rowsAffected = 0;

		try{
			int fid = ForumDB.getForumID(conn,campus,kix);
			if (fid > 0){

				// remove as member
				String sql = "DELETE FROM forumsx WHERE fid=? AND userid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setString(2, user);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// disable edit to old posts
				sql = "UPDATE messages set notified=1,processed=1,processeddate=? WHERE forum_id=? AND message_author=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setInt(2,fid);
				ps.setString(3,user);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// ennding reviews deletes pending messages
				sql = "DELETE FROM messagesx WHERE fid=? AND author=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setString(2,user);
				rowsAffected = ps.executeUpdate();
				ps.close();

			}
		}
		catch(SQLException e){
			logger.fatal("Board - endReviewProcess: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board - endReviewProcess: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * displayBoardTimeLine
	 * <p>
	 * @param	conn			Connection
	 * @param	user			String
	 * @param	fid			int
	 * @param	mid			int
	 * @param	item			int
	 * @param	sort			String
	 * @param	rtnToBoard	String
	 * <p>
	 */
	public static String displayBoardTimeLine(Connection conn,String user,int fid,int mid,int item,String sort,String rtnToBoard) {


		// show the top level posting

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{

			int i = 1;

			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT thread_id,thread_level,processed,message_id,message_timestamp,message_author,message_subject FROM messages WHERE message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				int tid = rs.getInt("thread_id");
				int tl = rs.getInt("thread_level");
				int messageID = rs.getInt("message_id");
				String author = AseUtil.nullToBlank(rs.getString("message_author"));
				String subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				String tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);

				boolean closed = ForumDB.isPostClosed(conn,fid,mid);

				buf.append("<div class=\"item\"><a href='#' class='postbox'></a><div>"+subject+"</div></div>");

				buf.append(showBoardChildrenTimeLine(conn,fid,item,0,2,messageID,user));

			} // rs
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			System.out.println("Board - displayBoardTimeLine: " + e.toString());
		}
		catch(Exception e){
			System.out.println("Board - displayBoardTimeLine: " + e.toString());
		}

		return buf.toString();
	}

	/**
	*
	*/
   public static String showBoardChildrenTimeLine(Connection conn,int fid,int item,int pid,int tl,int mid,String user) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{

			int i = 1;

			AseUtil aseUtil = new AseUtil();

			String src = ForumDB.getForumSrc(conn,fid);

			String sql = "SELECT message_id,thread_id,message_body,message_author,message_timestamp,processed,thread_level,notified "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND thread_parent=? "
							+ "AND thread_id=? "
							+ "AND item=? "
							+ "ORDER BY message_timestamp";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,pid);
			ps.setInt(3,mid);
			ps.setInt(4,item);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int messageID = rs.getInt("message_id");
				int tid = rs.getInt("thread_id");
				String body = AseUtil.nullToBlank(rs.getString("message_body"));
				String author = AseUtil.nullToBlank(rs.getString("message_author"));
				String tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);
				int threadLevel = rs.getInt("thread_level") + 1;

				int notified = NumericUtil.getInt(rs.getInt("notified"),0);
				int processed = NumericUtil.getInt(rs.getInt("processed"),0);

				String piv = "" + fid + "_" + pid  + "_" + messageID + "_" + (threadLevel-1);

				String processedText = "&nbsp;";

				if (!user.equals(author) && ForumDB.isMatch(conn,fid,messageID,pid,threadLevel-1,user)){
					processedText = "<a href=\"##\" onClick=\"return processedOff('processed_id_"+piv+"'); \"><img src=\"./images/new.png\" border=\"0\" title=\"new\"></a>&nbsp;&nbsp;";
				}

				String reply = "<div style=\"float: left;\" id=\"processed_id_"+piv+"\">"
						+ processedText
						+ "</div>"
						;

				buf.append("<div class=\"item\"><a href='#' class='postbox'><img src=\"./images/reply.gif\"></a><div class=\"itemstamp\">"+author+" - "+tme+"</div><div>"+body+"</div></div>");

				buf.append(showBoardChildrenTimeLine(conn,fid,item,messageID,tl + 1,mid,user));

			}
			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException e){
			System.out.println("Board - showBoardChildrenThreaded: " + e.toString());
		}
		catch(Exception e){
			System.out.println("Board - showBoardChildrenThreaded: " + e.toString());
		}

		return buf.toString();

	} // Board - showBoardChildrenThreaded

	/**
	*
	*/
	public static String showBoardCommentsForItem(Connection conn,String user,int fid,int itm){

		//Logger logger = Logger.getLogger("test");

		StringBuilder comments = new StringBuilder();

		int i = 0;

		String clss = "";

		try{

			comments.append("<div id=\"boardcomments\"><table width=\"100%\" class=\"mystyle\" border=\"0\"><tbody>");

			for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPostedItem(conn,fid,itm)){

				if (i % 2 == 0){
					clss = "rankline1";
				}
				else{
					clss = "rankline2";
				}

				++i;

				int mid = Integer.parseInt(u.getString4());

				comments.append("<tr class=\""+clss+"\"><td>"
					+ printChildren(conn,fid,itm,0,0,mid,user)
					+ "</td></tr>");
			} // for

			comments.append("</tbody></table></div>");
		}
		catch(Exception e){
			logger.fatal("Board.showBoardCommentsForItem ("+user+"/"+fid+"/"+itm+"): " + e.toString());
		}

		return comments.toString();

	}

	/**
	*
	*/
	public static int countOfCommentsForItem(Connection conn,int fid,int itm){

		//Logger logger = Logger.getLogger("test");

		int rows = 0;

		try{
			String sql = "SELECT COUNT(message_id) AS counter FROM messages WHERE thread_parent > 0 AND forum_id=? AND item=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,itm);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				rows = rs.getInt("counter");
			}

		}
		catch(SQLException e){
			logger.fatal("Board.countOfCommentsForItem ("+fid+"/"+itm+"): " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Board.countOfCommentsForItem ("+fid+"/"+itm+"): " + e.toString());
		}

		return rows;

	}

	/**
	 * postHasReplies - are there replies to this message id
	 * <p>
	 * @param	conn	Connection
	 * @param	fid	int
	 * @param	mid	int
	 * @param	tid	int
	 * @param	itm	int
	 * <p>
	 * @return	boolean
	 * <p>
	 */
	public static boolean postHasReplies(Connection conn,int fid,int mid,int tl,int itm) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean hasReplies = false;

		try{

			String sql = "select message_id from messages where forum_id=? and thread_parent=? and item=? and thread_level > ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setInt(3,itm);
			ps.setInt(4,tl);
			ResultSet rs = ps.executeQuery();
			hasReplies = rs.next();
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("Board.postHasReplies - " + e.toString());
		}

		return hasReplies;

	} // Board. postHasReplies

	/**
	 */
	public void close() throws SQLException {}

}
