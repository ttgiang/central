/**
 * OWASP Enterprise Security API (ESAPI)
 * 
 * This file is part of the Open Web Application Security Project (OWASP)
 * Enterprise Security API (ESAPI) project. For details, please see
 * <a href="http://www.owasp.org/index.php/ESAPI">http://www.owasp.org/index.php/ESAPI</a>.
 *
 * Copyright (c) 2007 - The OWASP Foundation
 * 
 * The ESAPI is published by OWASP under the BSD license. You should read and accept the
 * LICENSE before you use, modify, and/or redistribute this software.
 * 
 * @author Jeff Williams <a href="http://www.aspectsecurity.com">Aspect Security</a>
 * @created 2007
 */
package org.owasp.esapi.reference;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

import org.owasp.esapi.AccessReferenceMap;
import org.owasp.esapi.ESAPI;
import org.owasp.esapi.Randomizer;
import org.owasp.esapi.errors.AccessControlException;

/**
 * Reference implementation of the AccessReferenceMap interface. This
 * implementation generates random 6 character alphanumeric strings for indirect
 * references. It is possible to use simple integers as indirect references, but
 * the random string approach provides a certain level of protection from CSRF
 * attacks, because an attacker would have difficulty guessing the indirect
 * reference.
 * 
 * @author Jeff Williams (jeff.williams@aspectsecurity.com)
 * @since June 1, 2007
 * @see org.owasp.esapi.AccessReferenceMap
 */
public class RandomAccessReferenceMap implements AccessReferenceMap {
	
	/** The itod (indirect to direct) */
	HashMap itod = new HashMap();

	/** The dtoi (direct to indirect) */
	HashMap dtoi = new HashMap();

	/** The random. */
	Randomizer random = ESAPI.randomizer();

	/**
	 * This AccessReferenceMap implementation uses short random strings to
	 * create a layer of indirection. Other possible implementations would use
	 * simple integers as indirect references.
	 */
	public RandomAccessReferenceMap() {
		// call update to set up the references
	}

	/**
	 * Instantiates a new access reference map with a set of direct references.
	 * 
	 * @param directReferences
	 *            the direct references
	 */
	public RandomAccessReferenceMap(Set directReferences) {
		update(directReferences);
	}

	/**
	* {@inheritDoc}
	*/
	public Iterator iterator() {
		TreeSet sorted = new TreeSet(dtoi.keySet());
		return sorted.iterator();
	}
	
	/**
	* {@inheritDoc}
	*/
	public String addDirectReference(Object direct) {
		if ( dtoi.keySet().contains( direct ) ) {
			return (String)dtoi.get( direct );
		}
		String indirect = getUniqueRandomReference();
		itod.put(indirect, direct);
		dtoi.put(direct, indirect);
		return indirect;
	}
	
	/**
	 * Create a new random reference that is guaranteed to be unique.
	 * 
	 *  @return 
	 *  	a random reference that is guaranteed to be unique
	 */
	private String getUniqueRandomReference() {
		String candidate = null;
		do {
			candidate = random.getRandomString(6, DefaultEncoder.CHAR_ALPHANUMERICS);
		} while (itod.keySet().contains(candidate));
		return candidate;
	}
	
	/**
	* {@inheritDoc}
	*/
	public String removeDirectReference(Object direct) throws AccessControlException {
		String indirect = (String)dtoi.get(direct);
		if ( indirect != null ) {
			itod.remove(indirect);
			dtoi.remove(direct);
		}
		return indirect;
	}

	/**
	* {@inheritDoc}
	*/
	final public void update(Set directReferences) {
		HashMap dtoi_old = (HashMap) dtoi.clone();
		dtoi.clear();
		itod.clear();

		Iterator i = directReferences.iterator();
		while (i.hasNext()) {
			Object direct = i.next();

			// get the old indirect reference
			String indirect = (String) dtoi_old.get(direct);

			// if the old reference is null, then create a new one that doesn't
			// collide with any existing indirect references
			if (indirect == null) {
				indirect = getUniqueRandomReference();
			}
			itod.put(indirect, direct);
			dtoi.put(direct, indirect);
		}
	}

	/**
	* {@inheritDoc}
	*/
	public String getIndirectReference(Object directReference) {
		return (String) dtoi.get(directReference);
	}

	/**
	* {@inheritDoc}
	*/
	public Object getDirectReference(String indirectReference) throws AccessControlException {
		if (itod.containsKey(indirectReference)) {
			return itod.get(indirectReference);
		}
		throw new AccessControlException("Access denied", "Request for invalid indirect reference: " + indirectReference);
	}
}
