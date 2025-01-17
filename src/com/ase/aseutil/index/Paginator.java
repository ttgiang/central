/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// Paginator.java
//

package com.ase.aseutil.index;

/**
 * @author Nicholas Hrycan
 *
 */
public class Paginator {

	/**
	 * 18 totalHits, pageSize 5
	 *
	 * 1: 1-5
	 * 2: 6-10
	 * 3: 11-15
	 * 4: 16-18
	 *
	 * @param totalHits
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public ArrayLocation calculateArrayLocation(int totalHits, int pageNumber, int pageSize) {
		ArrayLocation al = new ArrayLocation();

		if (totalHits < 1 || pageNumber < 1 || pageSize < 1) {
			al.setStart(0);
			al.setEnd(0);
			return al;
		}

		int start = 1 + (pageNumber - 1) * pageSize;
		int end = Math.min(pageNumber * pageSize, totalHits);
		if (start > end) {
			start = Math.max(1, end - pageSize);
		}

		al.setStart(start);
		al.setEnd(end);
		return al;
	}
}
