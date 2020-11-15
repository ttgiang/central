/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import java.io.File;

import org.apache.log4j.Logger;

public class DirUtil {

	static Logger logger = Logger.getLogger(DirUtil.class.getName());

	static final int      MAX_DEPTH  = 20;  							// Max 20 levels (directory nesting)
	static final String   INDENT_STR = "   ";                 	// Single indent.
	static final String[] INDENTS    = new String[MAX_DEPTH]; 	// Indent array.

	public static void traverseFolders(String rootFolder) {

		INDENTS[0] = INDENT_STR;

		for (int i = 1; i < MAX_DEPTH; i++) {
			INDENTS[i] = INDENTS[i-1] + INDENT_STR;
		}

		File root = new File(rootFolder);

		if (root != null && root.isDirectory()) {
			traverse(root, 0);
		}
		else {
			logger.fatal("Not a directory: " + root);
		}
	}

	public static void traverse(File fdir, int depth) {

		System.out.println(INDENTS[depth] + fdir.getName());

		if (fdir.isDirectory() && depth < MAX_DEPTH) {

			for (File f : fdir.listFiles()) {

				traverse(f, depth+1);

			} // for

		} // if

	}
}