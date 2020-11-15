/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.NumericUtil;

/**
 * A class to easily retrieve haspmap keys
 * <p>
 *
 * @author <b>ASE</b>, Copyright &#169; 2011
 *
 * @version 1.0, 2011/04/01
 */
public final class HashUtil {

	static Logger logger = Logger.getLogger(HashUtil.class.getName());

	public HashUtil() {}

	public void init() throws Exception {}

	/*
	 * getHashMapParmValue
	 */
	public String getHashMapParmValue(HashMap hashMap,String key,String defalt){

		String value = defalt;

		try{
			if (hashMap != null && !hashMap.isEmpty() && key != null){

				if(hashMap.containsKey(key)){

					value = AseUtil.nullToBlank((String)hashMap.get(key));

				} // containsKey

			} // key is valid
			else{
				value = defalt;
			}
		}
		catch(ClassCastException e){
			logger.fatal("HashUtil - getHashMapParmValue ("+key+"): " + e.toString());
		}
		catch(Exception e){
			logger.fatal("HashUtil - getHashMapParmValue ("+key+"): " + e.toString());
		}

		return value;
	}

	/*
	 * getHashMapParmValue
	 */
	public int getHashMapParmValue(HashMap hashMap,String key,int defalt){

		int value = defalt;

		try{
			if (hashMap != null && !hashMap.isEmpty() && key != null){

				if(hashMap.containsKey(key)){

					String temp = (String)hashMap.get(key);
					if (NumericUtil.isInteger(temp)){
						value = NumericUtil.getInt(temp);
					}
					else{
						value = defalt;
					}

				} // containsKey

			} // key is valid
			else{
				value = defalt;
			}
		}
		catch(ClassCastException e){
			logger.fatal("HashUtil - getHashMapParmValue ("+key+"): " + e.toString());
		}
		catch(Exception e){
			logger.fatal("HashUtil - getHashMapParmValue ("+key+"): " + e.toString());
		}

		return value;
	}

}


