/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 * public static boolean isNumeric(String number)
 * public static boolean isValidEmail(String email)
 * public static boolean isValidPhoneNumber(String phoneNumber)
 * public static boolean isValidSSN(String ssn)
 * public static boolean validateAddress(String address)
 * public static boolean validateCity(String city)
 * public static boolean validateEmail(String email)
 * public static boolean validateFirstName(String firstName)
 * public static boolean validateLastName(String lastName)
 * public static boolean validatePhone(String phone)
 * public static boolean validateState( String state )
 * public static boolean validateZip(String zip)
 * public static boolean validateSSN(String SSN)
 * public static boolean validateURL( String URL )
 *
 */

package com.ase.aseutil;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation{

   public static boolean validateAddress(String address){
      return address.matches("\\d+\\s+([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" );
   }

   public static boolean validateCity(String city){
      return city.matches( "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" );
   }

   public static boolean validateEmail(String email){
      return email.matches( ".+@.+\\.[a-z]+" );
   }

   public static boolean validateFirstName(String firstName){
      return firstName.matches( "[A-Z][a-zA-Z]*" );
   }

   public static boolean validateLastName(String lastName){
      return lastName.matches( "[a-zA-z]+([ '-][a-zA-Z]+)*" );
   }

   public static boolean validatePhone(String phone){
      return phone.matches( "[1-9]\\d{2}-[1-9]\\d{2}-\\d{4}" );
   }

   public static boolean validateState( String state ){
      return state.matches("([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" ) ;
   }

   public static boolean validateZip(String zip){
      //return zip.matches("\\d{5}");
      return zip.matches("^\\d{5}(-\\d{4})?$");
   }

   public static boolean validateSSN(String SSN){
      return SSN.matches("\\d{3}-\\d{2}-\\d{4}");
   }

   public static boolean validateURL( String URL ){
      //return URL.matches("^[A-Za-z]+://[A-Za-z0-9-_]+\\.[A-Za-z0-9-_%&\?\/.=]+$");
      return URL.matches("^[A-Za-z]+://[A-Za-z0-9-_]+\\.[A-Za-z0-9-_%&\\?\\/.=]+$");
   }

	/**
	* This method  checks if the input email address is a valid email addrees.
	* @param email String. Email adress to validate
	* @return boolean: true if email address is valid, false otherwise.
	*/
	public static boolean isValidEmail(String email){

		boolean isValid = false;
		/*
		Email format: A valid email address will have following format
		[\\w\\.-]+ : Begins with word characters, (may include periods and hypens).
		@: It must have a '@' symbol after initial characters.
		([\\w\\-]+\\.)+ : @ must follow by more alphanumeric characters (may include hypens.). This part must also have a "." to separate domain and subdomain names.
		[A-Z]{2,4}$: Must end with two to four alaphabets. (This will allow domain names with 2, 3 and 4 characters e.g pa, com, net, wxyz)
		*/

		String expression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
		CharSequence inputStr = email;

		Pattern pattern = Pattern.compile(expression,Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(inputStr);

		if(matcher.matches()){
			isValid = true;
		}

		return isValid;
	}

	/**
	* This method  checks if the input phone number is a valid phone number.
	* @param phoneNumber String. Phone number to validate
	* @return boolean: true if phone number is valid, false otherwise.
	*/
	public static boolean isValidPhoneNumber(String phoneNumber){

		boolean isValid = false;

		/* Phone Number format:
		^\\(? : May start with an option "(" .
		(\\d{3}): Followed by 3 digits.
		\\)? : May have an optional ")"
		[- ]? : May have an optional "-" after the first 3 digits or after optional ) character.
		(\\d{3}) : Followed by 3 digits.
		[- ]? : May have another optional "-" after numeric digits.
		(\\d{4})$: ends with four digits.
		Matches following:
		(123)456-7890, 123-456-7890, 1234567890, (123)-456-7890
		*/

		String expression = "^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$";
		CharSequence inputStr = phoneNumber;
		Pattern pattern = Pattern.compile(expression);
		Matcher matcher = pattern.matcher(inputStr);

		if(matcher.matches()){
			isValid = true;
		}

		return isValid;
	}

	/**
	* This method  checks if the input social security number is valid.
	* @param ssn String. Social Security number to validate
	* @return boolean: true if social security number is valid, false otherwise.
	*/
	public static boolean isValidSSN(String ssn){

		boolean isValid = false;
		//SSN format:
		/*
		^\\d{3} : Starts with three numeric digits.
		[- ]?   : Followed by an optional - and space
		\\d{2}: Two numeric digits after the optional "-"
		[- ]? : May contains an optional second "-" character.
		\\d{4}:  ends with four numeric digits.
		*/
		String expression = "^\\d{3}[- ]?\\d{2}[- ]?\\d{4}$";
		CharSequence inputStr = ssn;
		Pattern pattern = Pattern.compile(expression);
		Matcher matcher = pattern.matcher(inputStr);

		if(matcher.matches()){
			isValid = true;
		}

		return isValid;
	}

	/**
	* This method  checks if the input text contains all numeric characters.
	* @param number String. Number to validate
	* @return boolean: true if the input is all numeric, false otherwise.
	*/
	public static boolean isNumeric(String number){

		boolean isValid = false;
		//Number:
		/*
		^\\d{3} : Starts with three numeric digits.
		[- ]?   : Followed by an optional - and space
		\\d{2}: Two numeric digits after the optional "-"
		[- ]? : May contains an optional second "-" character.
		\\d{4}:  ends with four numeric digits.
		*/
		String expression = "[-+]?[0-9]*\\.?[0-9]+$";
		CharSequence inputStr = number;
		Pattern pattern = Pattern.compile(expression);
		Matcher matcher = pattern.matcher(inputStr);

		if(matcher.matches()){
			isValid = true;
		}

		return isValid;
	}

} // end class Validation
