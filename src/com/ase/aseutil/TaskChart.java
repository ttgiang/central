/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// TaskChart.java
//

package com.ase.aseutil;

public class TaskChart {

	private int id = 0;

	private String task = null;
	private boolean status = false;

	private String message = null;
	private String progress = null;
	private String source = null;

	public TaskChart() {
	}

	public TaskChart(String task, String message, String progress,String source, boolean status) {
		this.task = task;
		this.message = message;
		this.progress = progress;
		this.source = source;
		this.status = status;
	}

	public String getTask() {
		return this.task;
	}

	public void setTask(String value) {
		this.task = value;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String value) {
		this.message = value;
	}

	public String getProgress() {
		return this.progress;
	}

	public void setProgress(String value) {
		this.progress = value;
	}

	public String getSource() {
		return this.source;
	}

	public void setSource(String value) {
		this.source = value;
	}

	public boolean getStatus() {
		return this.status;
	}

	public void setStatus(boolean value) {
		this.status = value;
	}

	public String toString(){
		return 	"Task: " + getTask() + "\n" +
					"Message: " + getMessage() + "\n" +
					"Progress: " + getProgress() + "\n" +
					"Source: " + getSource() + "\n" +
					"Status: " + getStatus() + "\n" +
					"";
	}

}
