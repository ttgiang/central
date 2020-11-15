/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import com.ase.aseutil.Constant;

public class ZipUtility {

	private String source = "";
	private String target = "";
	private String wildCard = "";
	private String user = "";
	private String campus = "";
	private String kix = "";

	private long size = 0;
	private int numOfFiles = 0;

	public ZipUtility() {
		this.campus = "";
		this.user = "";
		this.source = "";
		this.target = "";
		this.wildCard = "";
		this.kix = "";

		this.size = 0;
		this.numOfFiles = 0;
	}

	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	public String getUser(){ return this.user; }
	public void setUser(String value){ this.user = value; }

	public String getSource(){ return this.source; }
	public void setSource(String value){

		// when kix is available, we read from the attachment table
		if (this.kix != null && this.kix.length() > 0)
			this.source = Constant.BLANK;
		else
			this.source = value;
	}

	public String getTarget(){ return this.target; }
	public void setTarget(String value){ this.target = value; }

	public String getWildCard(){ return this.wildCard; }
	public void setWildCard(String value){ this.wildCard = value; }

	public long getSize(){ return this.size; }
	public void setSize(long value){ this.size = value; }

	public int getNumOfFiles(){ return this.numOfFiles; }
	public void setNumOfFiles(int value){ this.numOfFiles = value; }

	public String getKix(){ return this.kix; }
	public void setKix(String value){

		this.kix = value;

		setSource(Constant.BLANK);

	}

	public String toString(){
		return
			"Campus: " + getCampus() +  "\n" +
			"User: " + getUser() +  "\n" +
			"Kix: " + getKix() +  "\n" +
			"Source: " + getSource() +  "\n" +
			"Target: " + getTarget() +  "\n" +
			"Number of files: " + getNumOfFiles() +  "\n" +
			"Total size: " + getSize() +  "\n" +
			"";
	}
}


