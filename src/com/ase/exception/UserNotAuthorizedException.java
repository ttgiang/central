/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

//
//  UserNotAuthorizedException.java
//
package com.ase.exception;

/**
 * Thrown when a user record could not be loaded or does not exist.
 */
public class UserNotAuthorizedException extends NotFoundException {

	private static final long serialVersionUID = 12L;

	/**
	 *
	 */
	public UserNotAuthorizedException() {
		super();
		mistake = "unknown";
	}

	/**
	 * @param message
	 */
	public UserNotAuthorizedException(String message) {
		super(message);
		mistake = message;
	}

	/**
	 * @param message
	 * @param cause
	 */
	public UserNotAuthorizedException(String message, Throwable cause) {
		super(message, cause);
		mistake = message;
	}

	/**
	 * @param cause
	 */
	public UserNotAuthorizedException(Throwable cause) {
		super(cause);
	}

}
