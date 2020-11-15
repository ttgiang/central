/*
 * NEMESIS-Course.
 * Copyright (C) 2002  David Laurent(lithium2@free.fr). All rights reserved.
 *
 * Copyright (c) 2000 The Apache Software Foundation. All rights reserved.
 *
 * Copyright (C) 2001 Yasna.com. All rights reserved.
 *
 * Copyright (C) 2000 CoolServlets.com. All rights reserved.
 *
 * NEMESIS-Course. is free software; you can redistribute it and/or
 * modify it under the terms of the Apache Software License, Version 1.1,
 * or (at your option) any later version.
 *
 * NEMESIS-Course core framework, NEMESIS-Course backoffice, NEMESIS-Course frontoffice
 * application are parts of NEMESIS-Course and are distributed under
 * same terms of licence.
 *
 *
 * NEMESIS-Course includes software developed by the Apache Software Foundation (http://www.apache.org/)
 * and software developed by CoolServlets.com (http://www.coolservlets.com).
 * and software developed by Yasna.com (http://www.yasna.com).
 *
 */
package com.ase.exception;

public class CourseNotFoundException extends CentralException {

	private static final long serialVersionUID = 12L;

	/**
	 *
	 */
	public CourseNotFoundException() {
		super();

	}

	/**
	 * @param message
	 */
	public CourseNotFoundException(String message) {
		super(message);

	}

	/**
	 * @param message
	 * @param cause
	 */
	public CourseNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * @param cause
	 */
	public CourseNotFoundException(Throwable cause) {
		super(cause);
	}

}
