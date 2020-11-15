/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.uploads;

/**
 * Implements a file type policy to check if the file type (extension) is valid.
 *
 * @author A.S.E.
 * @version 1.0, 2011/03/30, initial revision
 */
public class DefaultFileTypePolicy implements FileTypePolicy {

	public boolean isValidFileType(String filename) {

		boolean valid = false;

		if (filename != null){

			int dot = filename.lastIndexOf(".");

			if (dot != -1) {
				// including the dot
				String extension = filename.substring(dot);

				String aseBlackList = com.ase.aseutil.Upload.getBlackList();

				if (aseBlackList.indexOf(extension) < 0 ){
					valid = true;
				}

			} // dot

		} // filename

		return valid;

	}
}
