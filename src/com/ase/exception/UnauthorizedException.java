package com.ase.exception;

import javax.servlet.ServletException;

/**
 * Exception jeté lorsue le user n'est pas loggé, appelé par checkUser du controller
 * parent <code>BaseAction</code>
 *
 * @author dlaurent
 * 15:12:54
 *
 */
public class UnauthorizedException extends ServletException {

	/**
	 * Constructor for UserNotLoggedException.
	 */
	public UnauthorizedException() {
		super();
	}

	/**
	 * Constructor for UserNotLoggedException.
	 * @param arg0
	 */
	public UnauthorizedException(String arg0) {
		super(arg0);
	}




}

