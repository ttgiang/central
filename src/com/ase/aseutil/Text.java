/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Text.java
//
package com.ase.aseutil;

public class Text {

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* Seq int identity
	**/
	private int seq = 0;

	/**
	* Title varchar
	**/
	private String title = null;

	/**
	* Edition varchar
	**/
	private String edition = null;

	/**
	* Author varchar
	**/
	private String author = null;

	/**
	* Publisher varchar
	**/
	private String publisher = null;

	/**
	* Yeer char
	**/
	private String yeer = null;

	/**
	* Isbn varchar
	**/
	private String isbn = null;

	public Text(){}

	public Text(String historyid,int seq,String title,String edition,String author,String publisher,String yeer,String isbn){
		this.historyid = historyid;
		this.seq = seq;
		this.title = title;
		this.edition = edition;
		this.author = author;
		this.publisher = publisher;
		this.yeer = yeer;
		this.isbn = isbn;
	}

	/**
	*
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/**
	*
	**/
	public int getSeq(){ return this.seq; }
	public void setSeq(int value){ this.seq = value; }

	/**
	*
	**/
	public String getTitle(){ return this.title; }
	public void setTitle(String value){ this.title = value; }

	/**
	*
	**/
	public String getEdition(){ return this.edition; }
	public void setEdition(String value){ this.edition = value; }

	/**
	*
	**/
	public String getAuthor(){ return this.author; }
	public void setAuthor(String value){ this.author = value; }

	/**
	*
	**/
	public String getPublisher(){ return this.publisher; }
	public void setPublisher(String value){ this.publisher = value; }

	/**
	*
	**/
	public String getYeer(){ return this.yeer; }
	public void setYeer(String value){ this.yeer = value; }

	/**
	*
	**/
	public String getIsbn(){ return this.isbn; }
	public void setIsbn(String value){ this.isbn = value; }

	public String toString(){
		return "Historyid: " + getHistoryid() +
		"Seq: " + getSeq() +
		"Title: " + getTitle() +
		"Edition: " + getEdition() +
		"Author: " + getAuthor() +
		"Publisher: " + getPublisher() +
		"Yeer: " + getYeer() +
		"Isbn: " + getIsbn() +
		"";
	}
}
