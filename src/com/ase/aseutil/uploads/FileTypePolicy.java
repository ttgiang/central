/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.uploads;

/**
 * An interface to provide a pluggable file type policy, particularly
 * useful to handle uploads of files we want (whitelist).
 *
 * @author A.S.E.
 * @version 1.0, 2011/03/30, initial revision
 */
public interface FileTypePolicy {

  /**
   * Returns boolean indicating whether the file type is valid or not
   *
   */
  public boolean isValidFileType(String filename);

}
