/*
 * NEMESIS-FORUM.
 * Copyright (C) 2002  David Laurent(lithium2@free.fr). All rights reserved.
 *
 * Copyright (c) 2000 The Apache Software Foundation. All rights reserved.
 *
 * Copyright (C) 2001 Yasna.com. All rights reserved.
 *
 * Copyright (C) 2000 CoolServlets.com. All rights reserved.
 *
 * NEMESIS-FORUM. is free software; you can redistribute it and/or
 * modify it under the terms of the Apache Software License, Version 1.1,
 * or (at your option) any later version.
 *
 * NEMESIS-FORUM core framework, NEMESIS-FORUM backoffice, NEMESIS-FORUM frontoffice
 * application are parts of NEMESIS-FORUM and are distributed under
 * same terms of licence.
 *
 *
 * NEMESIS-FORUM includes software developed by the Apache Software Foundation (http://www.apache.org/)
 * and software developed by CoolServlets.com (http://www.coolservlets.com).
 * and software developed by Yasna.com (http://www.yasna.com).
 *
 */
package com.ase.aseutil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author dlaurent
 *
 * :TODO:passer en config
 */
public class CookieManager {

	private static final long SECOND = 1000;
	private static final long MINUTE = 60 * SECOND;
	private static final long HOUR = 60 * MINUTE;
	private static final long DAY = 24 * HOUR;
	private static final long WEEK = 7 * DAY;
	public static final int MAX_COOKIE_AGE = (int) (WEEK / 1000) * 8;

	private final static int ENCODE_XORMASK = 0x5A;
	private final static char ENCODE_DELIMETER = '\002';
	private final static char ENCODE_CHAR_OFFSET1 = 'A';
	private final static char ENCODE_CHAR_OFFSET2 = 'h';

	public static void setCookie(HttpServletResponse res, String name, String value, int maxAge) {
		Cookie oneCookie = new Cookie(name, value);
		oneCookie.setMaxAge(maxAge);
		oneCookie.setPath("/");
		res.addCookie(oneCookie);
	}

	/**
	 * Returns the specified Cookie object, or null if the cookie does not exist.
	 *
	 * @param request The HttpServletRequest object, known as "request" in a
	 *      JSP page.
	 * @param name the name of the cookie.
	 * @return the Cookie object if it exists, otherwise null.
	 */
	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie cookies[] = request.getCookies();
		if (cookies == null || name == null || name.length() == 0) {
			return null;
		}
		//Otherwise, we have to do a linear scan for the cookie.
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals(name)) {
				return cookies[i];
			}
		}
		return null;
	}

	/**
	 * Returns the value of the specified cookie as a String. If the cookie
	 * does not exist, the method returns null.
	 *
	 * @param request the HttpServletRequest object, known as "request" in a
	 *      JSP page.
	 * @param name the name of the cookie
	 * @return the value of the cookie, or null if the cookie does not exist.
	 */
	public static String getCookieValue(HttpServletRequest request, String name) {
		Cookie cookie = getCookie(request, name);
		if (cookie != null) {
			return cookie.getValue();
		}
		return null;
	}

	/**
	 * Invalidate the specified cookie and delete it from the response object.
	 *
	 * @param request The HttpServletRequest object, known as "request" in a JSP page.
	 * @param response The HttpServletResponse object, known as "response" in a JSP page.
	 * @param cookieName The name of the cookie you want to delete.
	 */
	public static void invalidateCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
		Cookie cookie = new Cookie(cookieName, null); // invalidate cookie
		cookie.setMaxAge(0); // deletes cookie
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	/**
	 * Builds a cookie string containing a username and password.<p>
	 *
	 * Note: with open source this is not really secure, but it prevents users
	 * from snooping the cookie file of others and by changing the XOR mask and
	 * character offsets, you can easily tweak results.
	 *
	 * @param username The username.
	 * @param password The password.
	 * @return String encoding the input parameters, an empty string if one of
	 *      the arguments equals <code>null</code>.
	 */
	public static String encodePasswordCookie(String username, String password) {
		StringBuffer buf = new StringBuffer();
		if (username != null && password != null) {
			byte[] bytes = (username + ENCODE_DELIMETER + password).getBytes();
			int b;

			for (int n = 0; n < bytes.length; n++) {
				b = bytes[n] ^ (ENCODE_XORMASK + n);
				buf.append((char) (ENCODE_CHAR_OFFSET1 + (b & 0x0F)));
				buf.append((char) (ENCODE_CHAR_OFFSET2 + ((b >> 4) & 0x0F)));
			}
		}
		return buf.toString();
	}

	/**
	 * Unrafels a cookie string containing a username and password.
	 *<p>
	 * @param cookieVal	String
	 *<p>
	 * @return String[] containing the username at index 0 and the password at
	 *      index 1, or <code>{ null, null }</code> if cookieVal equals
	 *      <code>null</code> or the empty string.
	 */
	public static String[] decodePasswordCookie(String cookieVal) {

		// check that the cookie value isn't null or zero-length
		if (cookieVal == null || cookieVal.length() <= 0) {
			return null;
		}

		// unrafel the cookie value
		char[] chars = cookieVal.toCharArray();
		byte[] bytes = new byte[chars.length / 2];
		int b;
		for (int n = 0, m = 0; n < bytes.length; n++) {
			b = chars[m++] - ENCODE_CHAR_OFFSET1;
			b |= (chars[m++] - ENCODE_CHAR_OFFSET2) << 4;
			bytes[n] = (byte) (b ^ (ENCODE_XORMASK + n));
		}
		cookieVal = new String(bytes);
		int pos = cookieVal.indexOf(ENCODE_DELIMETER);
		String username = (pos < 0) ? "" : cookieVal.substring(0, pos);
		String password = (pos < 0) ? "" : cookieVal.substring(pos + 1);

		return new String[] { username, password };
	}
}
