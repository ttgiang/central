/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Forum.java
//
package com.ase.aseutil;

public class Forum {

	/**
	* forumID int identity
	**/
	private int forumID = 0;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* historyid varchar
	**/
	private String historyid = null;

	/**
	* creator varchar
	**/
	private String creator = null;

	/**
	* requestor varchar
	**/
	private String requestor = null;

	/**
	* forum varchar
	**/
	private String forum = null;

	/**
	* descr varchar
	**/
	private String descr = null;

	/**
	* startDate datetime
	**/
	private String startDate = null;

	/**
	* grouping char
	**/
	private String grouping = null;

	/**
	* src
	**/
	private String src = null;

	/**
	* counter numeric
	**/
	private int counter = 0;

	/**
	* status
	**/
	private String status = null;

	/**
	* priority numeric
	**/
	private int priority = 0;

	/**
	* auditDate datetime
	**/
	private String auditDate = null;

	/**
	* auditBy
	**/
	private String auditBy = null;

	/**
	* createdDate datetime
	**/
	private String createdDate = null;

	/**
	* edit
	**/
	private String edit = "1";

	/**
	* item numeric
	**/
	private int item = 0;

	/**
	* item numeric
	**/
	private String coursealpha = "";

	/**
	* item numeric
	**/
	private String coursenum = "";

	/**
	* item numeric
	**/
	private String program = "";

	/**
	* xref varchar
	**/
	private String xref = null;

	int views = 0;

	public Forum (){
		this.forumID = 0;
		this.campus = "";
		this.historyid = "";
		this.item = 0;
		this.creator = "";
		this.requestor = "";
		this.forum = "";
		this.descr = "";
		this.startDate = "";
		this.grouping = "";
		this.counter = 0;
		this.src = "";
		this.xref = "";
		this.coursealpha = "";
		this.coursenum = "";
		this.program = "";
		this.views = 0;
	}

	public Forum (int forumID,
						String campus,
						String historyid,
						int item,
						String creator,
						String requestor,
						String forum,
						String descr,
						String startDate,
						String grouping){

		this.forumID = forumID;
		this.campus = campus;
		this.historyid = historyid;
		this.item = item;
		this.creator = creator;
		this.requestor = requestor;
		this.forum = forum;
		this.descr = descr;
		this.startDate = startDate;
		this.grouping = grouping;
		this.status = "Created";
		this.views = 0;

	}

	public Forum (int forumID,
						String campus,
						String historyid,
						int item,
						String creator,
						String requestor,
						String forum,
						String descr,
						String startDate,
						String grouping,
						String src){

		this.forumID = forumID;
		this.campus = campus;
		this.historyid = historyid;
		this.item = item;
		this.creator = creator;
		this.requestor = requestor;
		this.forum = forum;
		this.descr = descr;
		this.startDate = startDate;
		this.grouping = grouping;
		this.src = src;
		this.counter = 0;
		this.views = 0;
	}

	public Forum (int forumID,
						String campus,
						String historyid,
						int item,
						String creator,
						String requestor,
						String forum,
						String descr,
						String startDate,
						String grouping,
						String src,
						String status,
						int priority){

		this.forumID = forumID;
		this.campus = campus;
		this.historyid = historyid;
		this.item = item;
		this.creator = creator;
		this.requestor = requestor;
		this.forum = forum;
		this.descr = descr;
		this.startDate = startDate;
		this.grouping = grouping;
		this.src = src;
		this.counter = 0;
		this.priority = priority;
		this.status = status;
		this.views = 0;
	}

	public Forum (int forumID,
			String campus,
			String historyid,
			int item,
			String creator,
			String requestor,
			String forum,
			String descr,
			String startDate,
			String grouping,
			String src,
			String status,
			int priority,
			String xref){

		this.forumID = forumID;
		this.campus = campus;
		this.historyid = historyid;
		this.item = item;
		this.creator = creator;
		this.requestor = requestor;
		this.forum = forum;
		this.descr = descr;
		this.startDate = startDate;
		this.grouping = grouping;
		this.src = src;
		this.counter = 0;
		this.priority = priority;
		this.status = status;
		this.xref = xref;
		this.views = 0;
	}

	public Forum (int forumID,
			String campus,
			String historyid,
			int item,
			String creator,
			String requestor,
			String forum,
			String descr,
			String startDate,
			String grouping,
			String src,
			String status,
			int priority,
			String xref,
			String program){

		this.forumID = forumID;
		this.campus = campus;
		this.historyid = historyid;
		this.item = item;
		this.creator = creator;
		this.requestor = requestor;
		this.forum = forum;
		this.descr = descr;
		this.startDate = startDate;
		this.grouping = grouping;
		this.src = src;
		this.counter = 0;
		this.priority = priority;
		this.status = status;
		this.xref = xref;
		this.views = 0;
		this.program = program;
	}

	/**
	** forumID int identity
	**/
	public int getForumID(){ return this.forumID; }
	public void setForumID(int value){ this.forumID = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** historyid varchar
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/**
	** item numeric
	**/
	public int getItem(){ return this.item; }
	public void setItem(int value){ this.item = value; }

	/**
	** counter numeric
	**/
	public int getCounter(){ return this.counter; }
	public void setCounter(int value){ this.counter = value; }

	/**
	** priority numeric
	**/
	public int getPriority(){ return this.priority; }
	public void setPriority(int value){ this.priority = value; }

	/**
	** creator varchar
	**/
	public String getCreator(){ return this.creator; }
	public void setCreator(String value){ this.creator = value; }

	/**
	** requestor varchar
	**/
	public String getRequestor(){ return this.requestor; }
	public void setRequestor(String value){ this.requestor = value; }

	/**
	** forum varchar
	**/
	public String getForum(){ return this.forum; }
	public void setForum(String value){ this.forum = value; }

	/**
	** descr varchar
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	/**
	** src varchar
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

	/**
	** startDate datetime
	**/
	public String getStartDate(){ return this.startDate; }
	public void setStartDate(String value){ this.startDate = value; }

	/**
	** auditDate datetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	** auditBy datetime
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** createdDDate datetime
	**/
	public String getCreatedDate(){ return this.createdDate; }
	public void setCreatedDate(String value){ this.createdDate = value; }

	/**
	** status
	**/
	public String getStatus(){ return this.status; }
	public void setStatus(String value){

		//if (!value.toLowerCase().equals(ForumDB.FORUM_CLOSED)){
		//	value = "Active";
		//}

		this.status = value;
	}

	/**
	** grouping char
	**/
	public String getGrouping(){ return this.grouping; }
	public void setGrouping(String value){ this.grouping = value; }

	/**
	** xref
	**/
	public String getXref(){ return this.xref; }
	public void setXref(String value){ this.xref = value; }

	/**
	** coursealpha
	**/
	public String getCourseAlpha(){ return this.coursealpha; }
	public void setCourseAlpha(String value){ this.coursealpha = value; }

	/**
	** coursenum
	**/
	public String getCourseNum(){ return this.coursenum; }
	public void setCourseNum(String value){ this.coursenum = value; }

	/**
	** program
	**/
	public String getProgram(){ return this.program; }
	public void setProgram(String value){ this.program = value; }

	/**
	** views
	**/
	public int getViews(){ return this.views; }
	public void setViews(int value){ this.views = value; }

	public String toString(){
		return "forumID: " + getForumID() +
		"campus: " + getCampus() +
		"historyid: " + getHistoryid() +
		"item: " + getItem() +
		"Counter: " + getCounter() +
		"creator: " + getCreator() +
		"requestor: " + getRequestor() +
		"forum: " + getForum() +
		"descr: " + getDescr() +
		"startDate: " + getStartDate() +
		"auditDate: " + getAuditDate() +
		"auditBy: " + getAuditBy() +
		"createdDate: " + getCreatedDate() +
		"status: " + getStatus() +
		"grouping: " + getGrouping() +
		"src: " + getSrc() +
		"xref: " + getXref() +
		"alpha: " + getCourseAlpha() +
		"num: " + getCourseNum() +
		"program: " + getProgram() +
		"views: " + getViews() +
		"";
	}

}
