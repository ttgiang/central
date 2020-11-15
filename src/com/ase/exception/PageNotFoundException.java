/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

//
//  PageNotFoundException.java
//
package com.ase.exception;

/**
 * Thrown when a user record could not be loaded or does not exist.
 */
public class PageNotFoundException extends NotFoundException {

	private static final long serialVersionUID = 12L;

	/**
	 *
	 */
	public PageNotFoundException() {
		super();
		mistake = "unknown";
	}

	/**
	 * @param message
	 */
	public PageNotFoundException(String message) {
		super(message);
		mistake = message;
	}

	/**
	 * @param message
	 * @param cause
	 */
	public PageNotFoundException(String message, Throwable cause) {
		super(message, cause);
		mistake = message;
	}

	/**
	 * @param cause
	 */
	public PageNotFoundException(Throwable cause) {
		super(cause);

	}

}
