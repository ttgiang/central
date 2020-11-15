/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// AseProgressListener.java
//

package com.ase.aseutil;

import org.apache.commons.fileupload.ProgressListener;
import org.apache.log4j.Logger;

/**
 * AseProgressListener implementation sample.
 */
public class AseProgressListener implements ProgressListener {

	static Logger logger = Logger.getLogger(AseProgressListener.class.getName());

	private long megaBytes = -1;
	private String user = "";
	private String kix = "";

	private volatile long bytesRead = 0L, contentLength = 0L, item = 0L;

	/**
	* AseProgressListener
	*/
	public AseProgressListener(){
		super();
	}

	/**
	* AseProgressListener
	*/
	public AseProgressListener(String user){
		this.user = user;
	}

	/**
	* AseProgressListener
	*/
	public AseProgressListener(String user,String kix){
		this.user = user;
		this.kix = kix;
	}

	/**
	* getBytesRead
	*/
	public long getBytesRead(){
		return bytesRead;
	}

	/**
	* getContentLength
	*/
	public long getContentLength(){
		return contentLength;
	}

	/**
	* getItem
	*/
	public long getItem(){
		return item;
	}

	/**
	* update
	*/
	public void update(long aBytesRead, long aContentLength, int anItem){
		bytesRead = aBytesRead;
		contentLength = aContentLength;
		item = anItem;
	}

	/**
	* AseProgressListener
	*/
	public void updateOBSOLETE(long pBytesRead, long pContentLength, int pItems) {

		long mBytes = pBytesRead / 4000000;

		if (megaBytes == mBytes) {
			return;
		}

		megaBytes = mBytes;

		logger.info("User: " + user);
		logger.info("We are currently reading item " + pItems);

		if (pContentLength == -1) {
			logger.info("So far, " + pBytesRead + " bytes have been read.");
		} else {
			logger.info("So far, " + pBytesRead + " of " + pContentLength + " bytes have been read.");
		}
	}

}