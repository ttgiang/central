/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 */

package com.ase.aseutil.listeners;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSession;

import com.ase.aseutil.Encrypter;

public final class AseSessionListener implements HttpSessionAttributeListener, HttpSessionListener {

	public void sessionCreated(HttpSessionEvent event) {

		HttpSession session = event.getSession();
		
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
		
		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		
		System.out.println("HttpSession object has been created: " + user);

	}

	public void sessionDestroyed(HttpSessionEvent event) {

		HttpSession session = event.getSession();
		
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
		
		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		
		System.out.println("HttpSession object has been removed: " + user);

	}

	public void attributeAdded(HttpSessionBindingEvent event) {

		System.out.println("An attribute has been added to an HttpSession object");

	}

	public void attributeRemoved(HttpSessionBindingEvent event) {

		System.out.println("An attribute has been removed to an HttpSession object");

	}

	public void attributeReplaced(HttpSessionBindingEvent event) {

		System.out.println("An attribute has been replaced to an HttpSession object");

	}

}