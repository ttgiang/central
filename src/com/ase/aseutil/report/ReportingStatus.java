/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @proposer ttgiang
 */

//
// ReportingStatus.java
//
package com.ase.aseutil.report;

public class ReportingStatus {

	/**
	* userid varchar
	**/
	private String userid = null;

	/**
	* links varchar
	**/
	private String links = null;

	/**
	* type varchar
	**/
	private String type = null;

	/**
	* outline varchar
	**/
	private String outline = null;

	/**
	* progress varchar
	**/
	private String progress = null;

	/**
	* proposer varchar
	**/
	private String proposer = null;

	/**
	* current varchar
	**/
	private String current = null;

	/**
	* next char
	**/
	private String next = null;

	/**
	* dateproposed varchar
	**/
	private String dateproposed = null;

	/**
	* lastupdated varchar
	**/
	private String lastupdated = null;

	/**
	* route varchar
	**/
	private String route = null;

	private String historyid = null;

	public ReportingStatus(){}

	public ReportingStatus(String userid,String links){

		// this version is currently used by com.ase.aseutil.jquery.JQueryServlet for JSONObject
		// doing this because we needed 2 items for a return object
		this.userid = userid;
		this.links = links;
	}

	public ReportingStatus(
								String userid,
								String links,
								String outline,
								String progress,
								String proposer,
								String current,
								String next,
								String dateproposed,
								String lastupdated,
								String route,
								String type){

		this.userid = userid;
		this.links = links;
		this.outline = outline;
		this.progress = progress;
		this.proposer = proposer;
		this.current = current;
		this.next = next;
		this.dateproposed = dateproposed;
		this.lastupdated = lastupdated;
		this.route = route;
		this.type = type;
	}

	public ReportingStatus(
								String userid,
								String links,
								String outline,
								String progress,
								String proposer,
								String current,
								String next,
								String dateproposed,
								String lastupdated,
								String route,
								String type,
								String kix){

		this.userid = userid;
		this.links = links;
		this.outline = outline;
		this.progress = progress;
		this.proposer = proposer;
		this.current = current;
		this.next = next;
		this.dateproposed = dateproposed;
		this.lastupdated = lastupdated;
		this.route = route;
		this.type = type;
		this.historyid = kix;
	}

	/**
	*
	**/
	public String getUserId(){ return this.userid; }
	public void setUserId(String value){ this.userid = value; }

	/**
	*
	**/
	public String getOutline(){ return this.outline; }
	public void setOutline(String value){ this.outline = value; }

	/**
	*
	**/
	public String getProgress(){ return this.progress; }
	public void setProgress(String value){ this.progress = value; }

	/**
	*
	**/
	public String getProposer(){ return this.proposer; }
	public void setProposer(String value){ this.proposer = value; }

	/**
	*
	**/
	public String getCurrent(){ return this.current; }
	public void setCurrent(String value){ this.current = value; }

	/**
	*
	**/
	public String getNext(){ return this.next; }
	public void setNext(String value){ this.next = value; }

	/**
	*
	**/
	public String getDateProposed(){ return this.dateproposed; }
	public void setDateProposed(String value){ this.dateproposed = value; }

	/**
	*
	**/
	public String getLastUpdated(){ return this.lastupdated; }
	public void setLastUpdated(String value){ this.lastupdated = value; }

	/**
	*
	**/
	public String getRoute(){ return this.route; }
	public void setRoute(String value){ this.route = value; }

	/**
	*
	**/
	public String getLinks(){ return this.links; }
	public void setLinks(String value){ this.links = value; }

	/**
	*
	**/
	public String getType(){ return this.type; }
	public void setType(String value){ this.type = value; }

	/**
	*
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	public String toString(){
		return "userid: " + getUserId() +
		"type: " + getType() +
		"outline: " + getOutline() +
		"links: " + getLinks() +
		"progress: " + getProgress() +
		"proposer: " + getProposer() +
		"current: " + getCurrent() +
		"next: " + getNext() +
		"date proposed: " + getDateProposed() +
		"last updated: " + getLastUpdated() +
		"route: " + getRoute() +
		"historyid: " + getHistoryid() +
		"";
	}
}
