/**
 * JSTemplate
 *@version 2.0.1 11/20/97
 *@author Marc A. Mnich
 *@Copyright Marc A. Mnich 1997
 */
package com.ase.temp;

import java.io.*;
import java.net.*;
import java.util.*;

/**
 * JSTemplate
 * A Java Servlet Template Engine.
 * Creates flexible templates from any URL source
 * and allows for user defined tags.
 *@version 2.0.1 11/20/97
 *@author Marc A. Mnich
 */
public class JSTemplate {

    private String content=null;
    private long timeLoaded;
    private String buffContent;
    private URL url;

/*  Creates a new Template for the given URL.  The template is
 *  reloaded only if the timestamp of the URL has changed since the last load.
 */
    public JSTemplate(URL url) throws IOException {
			this.url=url;
        loadURL(url);
    }


/* Load the template by getting the data from the URL.
 */
    public void loadURL(URL url) throws IOException {
        Date now = new Date();

	try {
            StringBuffer buffer = new StringBuffer();
            URLConnection uc = url.openConnection();
            uc.connect();
            InputStream in = uc.getInputStream();
            int i;

            while ( ( i = in.read() ) != -1 ) {
                buffer.append( ( char )i );
	    }

            content = buffer.toString();

	    timeLoaded = now.getTime();

	} catch (IOException e) {
	    throw new IOException("JSTemplate construction error --> " +  e);
	}

        buffContent = content;  // Local copy
    }

    public int replaceTagRange(String tag1, String tag2, String text,
			       int howMany) {
        int pointer=0, count=0, index1, index2;
        boolean done=false;

        while(!done) {
            index1 = buffContent.indexOf(tag1,pointer);
            if(index1 > -1) {
                index2 = buffContent.indexOf(tag2,pointer + tag1.length());
                if(index2 > -1) { //Found both tags, now replace
                    buffContent = buffContent.substring(0,index1) +
                              text +
                              buffContent.substring(index2 + tag2.length());
                    pointer = index1 + text.length();
                    count++;
                    if(howMany > 0 && count >= howMany) {
                        done=true;
                    }

                } else {
                    done=true;
                }
            } else {
                done=true;
            }
        }
        return count;
    }

    public int replaceTag(String tag, String text, int howMany) {
        int pointer=0, count=0, index;
        boolean done=false;

        while(!done) {
            index = buffContent.indexOf(tag,pointer);
            if(index > -1) {
                buffContent = buffContent.substring(0,index) +
                              text + buffContent.substring(index + tag.length());
                pointer = index + text.length();
                count++;
                if(howMany > 0 && count >= howMany) {
                    done=true;
                }
            } else {
                done=true;
            }
        }
        return count;
    }

    public int replaceTagRange(String tag1, String tag2, String text) {
        return replaceTagRange(tag1,tag2,text,-1);
    }

    public int replaceTag(String tag, String text) {
        return replaceTag(tag,text,-1);
    }

    public String toString() {
        return buffContent;
    }

/**
 ** Reload the template from the source only if it has changed.
 ** Use this only if you have created the template in the init section.
 */
    public void reloadOnChanged()  throws IOException {

        URLConnection conn = url.openConnection();
        long mod = conn.getLastModified(); // Not much traffic for this

        if((mod - timeLoaded) > 0) { // Reload if it has changed
	    loadURL(url);
        }
    }

    // Allow template to be reset without reloading from source
    public void reset() {
	buffContent = content;
    }
}
