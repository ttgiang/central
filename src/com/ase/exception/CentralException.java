/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// CentralException.java
//
package com.ase.exception;

public class CentralException extends Exception {

	private static final long serialVersionUID = 12L;

	String mistake;

	public CentralException() {
		super();
		mistake = "unknown";
	}

	public CentralException(String message) {
		super(message);
		mistake = message;
	}

	public CentralException(String message, Throwable cause) {
		super(message, cause);
		mistake = message;
	}

	public CentralException(Throwable cause) {
		super(cause);
	}

	public String getError(){
		return mistake;
	}
}
