/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// Approver.java
//
package com.ase.aseutil;

public class Approver implements Comparable {

	private String id = null;

	private String seq = null;
	private String approver = null;
	private String delegated = null;
	private boolean multiLevel = false;
	private String lanid = null;
	private String dte = null;
	private String campus = null;
	private boolean excludeFromExperimental = false;

	private String firstApprover = null;
	private String firstDelegate = null;
	private String firstExperiment = null;

	private String previousApprover = null;
	private String previousDelegate = null;
	private String previousExperiment = null;

	private String nextApprover = null;
	private String nextDelegate = null;
	private String nextExperiment = null;

	private String lastApprover = null;
	private String lastDelegate = null;
	private String lastExperiment = null;

	private String firstSequence = null;
	private String previousSequence = null;
	private String nextSequence = null;
	private String lastSequence = null;

	private String allApprovers = null;
	private String allDelegates = null;
	private String allSequences = null;
	private String allExperiments = null;
	private String allCompleteList = null;

	// indicator of whether all sequences were found
	private boolean completeList = false;
	private boolean distributionList = false;
	private String distributionName = "";

	private String availableDate = null;
	private String startDate = null;
	private String endDate = null;

	private int route = 0;

	public Approver() {
		this.id = null;
		this.seq = "";
		this.approver = "";
		this.delegated = "";
		this.lanid = "";
		this.dte = "";
		this.campus = "";

		this.firstApprover = "";
		this.previousApprover = "";
		this.nextApprover = "";
		this.lastApprover = "";

		this.firstDelegate = "";
		this.previousDelegate = "";
		this.nextDelegate = "";
		this.lastDelegate = "";

		this.firstSequence = "";
		this.previousSequence = "";
		this.nextSequence = "";
		this.lastSequence = "";

		this.allApprovers = "";
		this.allDelegates = "";
		this.allSequences = "";
		this.allCompleteList = "";

		this.route = 0;
	}

	public Approver(String id,String seq,String approver,String delegated,
						boolean multiLevel,boolean excludeFromExperimental,String lanid,
						String dte, String campus, int route) {
		this.id = id;
		this.seq = seq;
		this.approver = approver;
		this.delegated = delegated;
		this.multiLevel = multiLevel;
		this.excludeFromExperimental = excludeFromExperimental;
		this.lanid = lanid;
		this.dte = dte;
		this.campus = campus;
		this.route = route;
	}

	public Approver(String id,String seq,String approver,String delegated,
						boolean multiLevel,boolean excludeFromExperimental,String lanid,
						String dte, String campus, int route,String availableDate,String startDate,String endDate) {
		this.id = id;
		this.seq = seq;
		this.approver = approver;
		this.delegated = delegated;
		this.multiLevel = multiLevel;
		this.excludeFromExperimental = excludeFromExperimental;
		this.lanid = lanid;
		this.dte = dte;
		this.campus = campus;
		this.route = route;
		this.availableDate = availableDate;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public String getId() { return this.id; }
	public void setId(String value) { this.id = value; }

	public String getSeq() { return this.seq;}
	public void setSeq(String value) { this.seq = value; }

	public String getApprover() { return this.approver; }
	public void setApprover(String value) { this.approver = value; }

	public String getDelegated() { return this.delegated; }
	public void setDelegated(String value) { this.delegated = value;}

	public String getLanid() {return this.lanid;}
	public void setLanid(String value) {this.lanid = value;}

	public String getDte() {return this.dte;}
	public void setDte(String value) {this.dte = value;}

	public String getCampus() {return this.campus;}
	public void setCampus(String value) {this.campus = value;}

	public String getFirstSequence() {return this.firstSequence;}
	public void setFirstSequence(String value) {this.firstSequence = value;}

	public String getPreviousSequence() {return this.previousSequence;}
	public void setPreviousSequence(String value) {this.previousSequence = value;}

	public String getNextSequence() {return this.nextSequence;}
	public void setNextSequence(String value) {this.nextSequence = value;}

	public String getLastSequence() {return this.lastSequence;}
	public void setLastSequence(String value) {this.lastSequence = value;}

	public String getFirstApprover() {return this.firstApprover;}
	public void setFirstApprover(String value) {this.firstApprover = value;}

	public String getPreviousApprover() {return this.previousApprover;}
	public void setPreviousApprover(String value) {this.previousApprover = value;}

	public String getNextApprover() {return this.nextApprover;}
	public void setNextApprover(String value) {this.nextApprover = value;}

	public String getLastApprover() {return this.lastApprover;}
	public void setLastApprover(String value) {this.lastApprover = value;}

	public String getFirstDelegate() {return this.firstDelegate;}
	public void setFirstDelegate(String value) {this.firstDelegate = value;}

	public String getPreviousDelegate() {return this.previousDelegate;}
	public void setPreviousDelegate(String value) {this.previousDelegate = value;}

	public String getNextDelegate() {return this.nextDelegate;}
	public void setNextDelegate(String value) {this.nextDelegate = value;}

	public String getLastDelegate() {return this.lastDelegate;}
	public void setLastDelegate(String value) {this.lastDelegate = value;}

	public String getFirstExperiment() {return this.firstExperiment;}
	public void setFirstExperiment(String value) {this.firstExperiment = value;}

	public String getPreviousExperiment() {return this.previousExperiment;}
	public void setPreviousExperiment(String value) {this.previousExperiment = value;}

	public String getNextExperiment() {return this.nextExperiment;}
	public void setNextExperiment(String value) {this.nextExperiment = value;}

	public String getLastExperiment() {return this.lastExperiment;}
	public void setLastExperiment(String value) {this.lastExperiment = value;}

	public String getAllApprovers() {return this.allApprovers;}
	public void setAllApprovers(String value) {this.allApprovers = value;}

	public String getAllDelegates() {return this.allDelegates;}
	public void setAllDelegates(String value) {this.allDelegates = value;}

	public String getAllSequences() {return this.allSequences;}
	public void setAllSequences(String value) {this.allSequences = value;}

	public String getAllCompleteList() {return this.allCompleteList;}
	public void setAllCompleteList(String value) {this.allCompleteList = value;}

	public String getAllExperiments() {return this.allExperiments;}
	public void setAllExperiments(String value) {this.allExperiments = value;}

	public boolean getMultiLevel() {return this.multiLevel;}
	public void setMultiLevel(boolean value) {this.multiLevel = value;}

	public boolean getExcludeFromExperimental() {return this.excludeFromExperimental;}
	public void setExcludeFromExperimental(boolean value) {this.excludeFromExperimental = value;}

	public boolean getCompleteList() {return this.completeList;}
	public void setCompleteList(boolean value) {this.completeList = value;}

	public boolean getDistributionList() {return this.distributionList;}
	public void setDistributionList(boolean value) {this.distributionList = value;}

	public String getDistributionName() {return this.distributionName;}
	public void setDistributionName(String value) {this.distributionName = value;}

	public int getRoute() {return this.route;}
	public void setRoute(int value) {this.route = value;}

	public String getAvailableDate() {return this.availableDate;}
	public void setAvailableDate(String value) {this.availableDate = value;}

	public String getStartDate() {return this.startDate;}
	public void setStartDate(String value) {this.startDate = value;}

	public String getEndDate() {return this.endDate;}
	public void setEndDate(String value) {this.endDate = value;}

	public String toString() {

		return "Campus: " + getCampus() + "<br>\n"
				+ "Current: " + getApprover() + "/" + getSeq() + "<br>\n"
				+ "First: " + getFirstApprover() + "/" + getFirstSequence() + "/" + getFirstDelegate() + "<br>\n"
				+ "Next: " + getNextApprover() + "/" + getNextSequence() + "/" + getNextDelegate() + "<br>\n"
				+ "Previous: " + getPreviousApprover() + "/" + getPreviousSequence() + "/" + getPreviousDelegate() + "<br>\n"
				+ "Last: " + getLastApprover() + "/" + getLastSequence() + "/" + getLastDelegate() + "<br>\n"
				+ "Complete list: " + getCompleteList() + "<br>\n"
				+ "Route: " + getRoute() + "<br>\n"
				+ "Distribution list: " + getDistributionList() + "<br>\n"
				+ "Distribution name: " + getDistributionName() + "<br>\n"
				+ "All Approvers: " + getAllApprovers() + "<br>\n"
				+ "All Delegates: " + getAllDelegates() + "<br>\n"
				+ "All Experiments: " + getAllExperiments() + "<br>\n"
				+ "All Complete List: " + getAllCompleteList() + "<br>\n"
				+ "All Sequences: " + getAllSequences() + "<br>\n"
				+ "Available Date: " + getAvailableDate() + "<br>\n"
				+ "Start Date: " + getStartDate() + "<br>\n"
				+ "End Date: " + getEndDate() + "<br>\n"
				+ "<br>\n";
	}

	public int compareTo(Object object) {
		return 0;
	}

}