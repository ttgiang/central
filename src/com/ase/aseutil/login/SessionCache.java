package com.ase.aseutil.login;

import java.util.Hashtable;
import java.util.Enumeration;

class SessionCache implements  Runnable {

    private Hashtable sessionCache;
    private long flush;
    private Thread reaper;

    SessionCache (long flush) {
       this.flush=flush;
       sessionCache=new Hashtable (100);
       reaper=new Thread (this);
       reaper.setPriority (Thread.MIN_PRIORITY);
       reaper.start();
    }

    public void run() {
        while (true) {
           try {
               Thread.sleep (flush);
               Enumeration sessions;
               Session s;
               long expire;
               expire=System.currentTimeMillis();
               sessions=sessionCache.elements();
               while ( sessions.hasMoreElements() ) {
                   s=(Session)sessions.nextElement();
                   if ( expire >= s.getExpires()) {
                       sessionCache.remove (s.key());
                   }
               }
           } catch (Exception e) {
               return;
           }
       }
    }

	@SuppressWarnings("unchecked")
		Session put (Session s) {
		return (Session)sessionCache.put (s.key(), s);
	}

	Session get (String key) {
		return (Session)sessionCache.get (key);
	}

	Enumeration elements () {
		return sessionCache.elements();
	}

	Enumeration keys () {
		return sessionCache.keys();
	}

	void remove (Session s) {
		sessionCache.remove (s.key());
	}
}

