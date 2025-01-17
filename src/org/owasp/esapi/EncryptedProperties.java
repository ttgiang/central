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
package org.owasp.esapi;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Set;

import org.owasp.esapi.errors.EncryptionException;


/**
 * The EncryptedProperties interface represents a properties file where all the data is
 * encrypted before it is added, and decrypted when it retrieved. This interface can be
 * implemented in a number of ways, the simplest being extending Properties and overloading
 * the getProperty and setProperty methods.
 * <P>
 * <img src="doc-files/EncryptedProperties.jpg">
 * <P>
 * 
 * @author Jeff Williams (jeff.williams .at. aspectsecurity.com) <a
 *         href="http://www.aspectsecurity.com">Aspect Security</a>
 * @since June 1, 2007
 */
public interface EncryptedProperties {

	/**
	 * Gets the property value from the encrypted store, decrypts it, and returns the plaintext value to the caller.
	 * 
	 * @param key
	 *      the name of the property to get 
	 * 
	 * @return 
	 * 		the decrypted property value
	 * 
	 * @throws EncryptionException
	 *      if the property could not be decrypted
	 */
	String getProperty(String key) throws EncryptionException;

	/**
	 * Encrypts the plaintext property value and stores the ciphertext value in the encrypted store.
	 * 
	 * @param key
	 *      the name of the property to set
	 * @param value
	 * 		the value of the property to set
	 * 
	 * @return 
	 * 		the encrypted property value
	 * 
	 * @throws EncryptionException
	 *      if the property could not be encrypted
	 */
	String setProperty(String key, String value) throws EncryptionException;
	
	/**
	 * Returns a Set view of properties. The Set is backed by a Hashtable, so changes to the 
	 * Hashtable are reflected in the Set, and vice-versa. The Set supports element 
	 * removal (which removes the corresponding entry from the Hashtable), but not element addition.
	 * 
	 * @return 
	 * 		a set view of the properties contained in this map.
	 */
	public Set keySet();
		
	/**
	 * Reads a property list (key and element pairs) from the input stream.
	 * 
	 * @param in
	 * 		the input stream that contains the properties file
	 * 
	 * @throws IOException
	 *      Signals that an I/O exception has occurred.
	 */
	public void load(InputStream in) throws IOException;
	
	/**
	 * Writes this property list (key and element pairs) in this Properties table to 
	 * the output stream in a format suitable for loading into a Properties table using the load method. 
	 * 
	 * @param out
	 * 		the output stream that contains the properties file
	 * @param comments
	 *            a description of the property list (ex. "Encrypted Properties File").
	 * 
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public void store(OutputStream out, String comments) throws IOException;	
	
	
}
