/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

//
// Html2Text.java
//
package com.ase.aseutil.html;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.parser.ParserDelegator;

import org.apache.log4j.Logger;

public class Html2Text extends HTMLEditorKit.ParserCallback {

	static Logger logger = Logger.getLogger(Html2Text.class.getName());

	StringBuffer s;

	public Html2Text() {}

	public static String HTML2Text(String fileName) {

		// if we get a filename that exists, we read content from the file.
		// if not, we use the content as something already needing to be cleaned.
		// however, because we have to read in from a file, we have to write out
		// the HTML to a file first then read back in.
		String str = null;

		try {
			File target = new File(fileName);
			if (target.exists()){
				FileReader in = new FileReader(fileName);

				Html2Text parser = new Html2Text();

				parser.parse(in);

				in.close();

				str = parser.getText();
			} // target

		}
		catch (Exception e) {
			logger.fatal("HTML2Text - " + e.toString());
		}

		return str;
	}

	public void parse(Reader in) throws IOException {

		s = new StringBuffer();

		ParserDelegator delegator = new ParserDelegator();

		// the third parameter is TRUE to ignore charset directive
		delegator.parse(in, this, Boolean.TRUE);
	}

	public void handleText(char[] text, int pos) {
		s.append(text);
	}

	public String getText() {
		return s.toString();
	}

}