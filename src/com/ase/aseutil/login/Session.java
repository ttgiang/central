package com.ase.aseutil.login;

import java.util.Random;
import java.net.*;

public class Session {

	private String theuser;
	private int id;
	private long expires;

	public Session (String theuser) {
		this.theuser = URLEncoder.encode (theuser);
		id = Math.abs(new Random (System.currentTimeMillis()).nextInt());
		expires = 0;
	}

	synchronized public void setExpires (long e) {
		expires = e;
	}

	public long getExpires() {
		return expires;
	}

	public String key() {
		return String.valueOf (id);
	}

	public String getEncodedUser() {
		return theuser;
	}

	public String getUser() {
		try {
			return URLDecoder.decode (theuser);
		}catch (Exception e) {
			return null;
		}
	}

	public int getId() {
		return id;
	}
}
