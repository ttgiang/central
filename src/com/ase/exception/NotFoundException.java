/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

//
//  NotFoundException.java
//
package com.ase.exception;

/**
 * Thrown if a nonexistant ForumMessage was attempting to be loaded.
 */
public class NotFoundException extends CentralException {

	private static final long serialVersionUID = 12L;

	/**
	 * Constructor for NotFoundException.
	 */
	public NotFoundException() {
		super();
		mistake = "unknown";
	}

	/**
	 * Constructor for NotFoundException.
	 *
	 * @param message
	 */
	public NotFoundException(String message) {
		super(message);
		mistake = message;
	}

	/**
	 * Constructor for NotFoundException.
	 *
	 * @param message
	 * @param cause
	 */
	public NotFoundException(String message, Throwable cause) {
		super(message, cause);
		mistake = message;
	}

	/**
	 * Constructor for NotFoundException.
	 *
	 * @param cause
	 */
	public NotFoundException(Throwable cause) {
		super(cause);
	}

}
