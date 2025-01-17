/*
 * Copyright (c) 2007-2008, Arshan Dabirsiaghi, Jason Li
 * 
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of OWASP nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package org.owasp.validator.html.model;

import java.util.regex.Pattern;

/**
 * 
 * An extension of the Pattern to give it a "lookup name" that we can use from a
 * centralized store.
 * 
 * @author Arshan Dabirsiaghi
 *
 */
public class AntiSamyPattern {
	
	private String name;
	private Pattern pattern;
	
	/**
	 * Constructor for AntiSamyPattern. The "name" parameter is a lookup name for retrieving the Pattern parameter
	 * passed in later.
	 * @param name The lookup name by which we will retrieve this Pattern later.
	 * @param pattern The Pattern to lookup based on the "name".
	 */
	public AntiSamyPattern(String name, Pattern pattern) {
		this.name = name;
		this.pattern = pattern;
	}

	/**
	 * 
	 * @return Return the name of the <code>AntiSamyPattern</code>.
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * @param name Set the name of the <code>AntiSamyPattern</code>.
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return Return the Pattern of the <code>AntiSamyPattern</code>.
	 */
	public Pattern getPattern() {
		return pattern;
	}

	/**
	 * @param pattern Set the Pattern of the <code>AntiSamyPattern</code>.
	 */
	public void setPattern(Pattern pattern) {
		this.pattern = pattern;
	}
}
