/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// FileUploadListener.java
//
package com.ase.aseutil;

import org.apache.commons.fileupload.ProgressListener;

public class FileUploadListener implements ProgressListener {

	private volatile long bytesRead = 0L, contentLength = 0L, item = 0L;

	public FileUploadListener(){
		super();
	}

	public void update(long aBytesRead, long aContentLength, int anItem){
		bytesRead = aBytesRead;
		contentLength = aContentLength;
		item = anItem;
	}

	public long getBytesRead(){
		return bytesRead;
	}

	public long getContentLength(){
		return contentLength;
	}

	public long getItem(){
		return item;
	}
}
