/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// AseDoc.java
//
//package com.ase.aseutil.doc;

import java.util.*;
import java.io.*;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

import com.ase.aseutil.*;

/**
* Recursive file listing under a specified directory.
*
* @author javapractices.com
* @author Alex Wong
* @author anonymous user
*/
public final class AseDoc {

  static FileWriter fstreamIndex = null;
  static BufferedWriter index = null;

  static String aseClassDir = null;
  static String currentDrive = null;

  /**
  * Demonstrate use.
  *
  * @param aArgs - <tt>aArgs[0]</tt> is the full name of an existing
  * directory that can be read.
  */
	public static void main(String... aArgs) {

		currentDrive = com.ase.aseutil.AseUtil.getCurrentDrive();

		aseClassDir = currentDrive + ":\\tomcat\\webapps\\central\\src\\com\\ase\\aseutil";

		System.out.println(aseClassDir);

		String userFolder = "";

		if(aArgs != null && aArgs.length > 0){
			userFolder = aArgs[0];
		}
		else{
			userFolder = aseClassDir;
		}

		try{
			fstreamIndex = new FileWriter(currentDrive + ":\\tomcat\\webapps\\central\\javadoc\\frame.htm");
			index = new BufferedWriter(fstreamIndex);

			index.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"
				+ "<HTML>"
				+ "<HEAD>"
				+ "<TITLE>All Classes (Curriculum Central v2.0)</TITLE>"
				+ "<LINK REL =\"stylesheet\" TYPE=\"text/css\" HREF=\"stylesheet.css\" TITLE=\"Style\">"
				+ "</HEAD>"
				+ "<BODY BGCOLOR=\"white\">"
				+ "<FONT size=\"+1\" CLASS=\"FrameHeadingFont\">"
				+ "<B>All Classes</B></FONT>"
				+ "<BR>"
				+ "<TABLE BORDER=\"0\" WIDTH=\"100%\" SUMMARY=\"\">"
				+ "<TR>"
				+ "<TD NOWRAP>"
				+ "<FONT CLASS=\"FrameItemFont\">");

			File startingDirectory = new File(userFolder);

			List<File> files = AseDoc.getAseDoc(startingDirectory);

			for(File file : files ){
				//content.write(file);
			}

			index.write("</FONT></TD></TR></TABLE></BODY></HTML>");
		}
		catch(FileNotFoundException e){
			//
		}
		catch(Exception e){
			//
		}
		finally{
			try{
				if(index!=null){
					index.close();
					fstreamIndex = null;
				}
			}
			catch(IOException e){
				//
			}
			catch(Exception e){
				//
			}

		}

	}

  /**
  * writeDoc
  *
  * @param aStartingDir is a valid directory, which can be read.
  */
	static public void writeDoc(String packageName,String className) throws FileNotFoundException {

		String name = "com.ase.aseutil." + packageName + className;

		try {
			Class cl = Class.forName(name);

			Class supercl = cl.getSuperclass();

			printMethods(cl,className.toLowerCase());

		} catch (NoClassDefFoundError e) {
			System.out.println("writeDoc.NoClassDefFoundError: " + name);
		} catch (ClassNotFoundException e) {
			System.out.println("writeDoc.ClassNotFoundException: " + name);
		} catch (Exception e) {
			System.out.println("writeDoc.Exception: " + name);
		}

	}

	/**
	* Recursively walk a directory tree and return a List of all
	* Files found; the List is sorted using File.compareTo().
	*
	* @param aStartingDir is a valid directory, which can be read.
	*/
	static public List<File> getAseDoc(File aStartingDir) throws FileNotFoundException {

		validateDirectory(aStartingDir);

		List<File> result = getAseDocNoSort(aStartingDir);

		Collections.sort(result);

		return result;

	}

	// PRIVATE //
	static private List<File> getAseDocNoSort(File aStartingDir) throws FileNotFoundException {

		List<File> result = new ArrayList<File>();

		File[] filesAndDirs = aStartingDir.listFiles();

		List<File> filesDirs = Arrays.asList(filesAndDirs);

		for(File file : filesDirs) {
			result.add(file); //always add, even if directory
			if (!file.isFile()) {
				//must be a directory
				//recursive call!
				List<File> deeperList = getAseDocNoSort(file);
				result.addAll(deeperList);
			}
			else{

				// for subfolders, that indicates another package folder. create
				// accordingly so printing class objects work properly
				String packageName = "";

				if (file.getParent().endsWith("aseutil")){
				}
				else{
					packageName = file.getParent().replace(currentDrive + ":\\tomcat\\webapps\\central\\src\\com\\ase\\aseutil\\","") + ".";
				}

				try{
					index.write("<A HREF=\"./asedoc/"+file.getName().replace(".java","").toLowerCase()+".htm\" title=\"class in com.ase.aseutil.bundle\" target=\"classFrame\" class=\"linkcolumn\">"
							+ file.getName().replace(".java","")
							+ "</A><BR>\n");
				}
				catch(Exception e){
					System.out.println("getAseDocNoSort.Exception: " + e.toString());
				}

				writeDoc(packageName,file.getName().replace(".java",""));
			}
		}

		return result;
	}

	/**
	* Directory is valid if it exists, does not represent a file, and can be read.
	*/
	static private void validateDirectory (File aDirectory) throws FileNotFoundException {

		if (aDirectory == null) {
			throw new IllegalArgumentException("Directory should not be null.");
		}

		if (!aDirectory.exists()) {
			throw new FileNotFoundException("Directory does not exist: " + aDirectory);
		}

		if (!aDirectory.isDirectory()) {
			throw new IllegalArgumentException("Is not a directory: " + aDirectory);
		}

		if (!aDirectory.canRead()) {
			throw new IllegalArgumentException("Directory cannot be read: " + aDirectory);
		}
	}

  /**
  * printMethods
  */
	public static void printMethods(Class cl,String className) {

	  FileWriter fstream = null;
	  BufferedWriter content = null;

		try{

			String header = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"> "
					+ "<HTML><HEAD><TITLE>Curriculum Central v2.0</TITLE> "
					+ "<META NAME=\"keywords\" CONTENT=\"com.ase.aseutil.bundle.Bundle class\"> "
					+ "<LINK REL =\"stylesheet\" TYPE=\"text/css\" HREF=\"./resource/stylesheet.css\" TITLE=\"Style\"> "
					+ "</HEAD><BODY BGCOLOR=\"white\"> "
					+ "<A NAME=\"navbar_top\"> "
					+ "<A HREF=\"#skip-navbar_top\" title=\"Skip navigation links\"></A> "
					+ "<TABLE BORDER=\"0\" WIDTH=\"100%\" CELLPADDING=\"1\" CELLSPACING=\"0\" SUMMARY=\"\"> "
					+ "<TR> "
					+ "<TD ALIGN=\"right\" VALIGN=\"top\" ROWSPAN=3><EM> "
					+ "<b>Curriculum Central v2.0</b><!--  Licensed to the University of Hawaii under one or more      contributor license agreements.  See the NOTICE file distributed with      this work for additional information regarding copyright ownership.    --></EM> "
					+ "</TD></TR></TABLE> "
					+ "<A NAME=\"skip-navbar_top\"></A> "
					+ "<A NAME=\"method_detail\"><!-- --></A> "
					+ "<TABLE BORDER=\"1\" WIDTH=\"100%\" CELLPADDING=\"3\" CELLSPACING=\"0\" SUMMARY=\"\"> "
					+ "<TR BGCOLOR=\"#CCCCFF\" CLASS=\"TableHeadingColor\"> "
					+ "<TH ALIGN=\"left\" COLSPAN=\"1\"><FONT SIZE=\"+2\"> "
					+ "<B>Method Detail - " + className + "</B></FONT></TH> "
					+ "</TR> "
					+ "</TABLE>";

			fstream = new FileWriter(currentDrive + ":\\tomcat\\webapps\\central\\javadoc\\asedoc\\"+className+".htm");
			content = new BufferedWriter(fstream);
			if (content != null){

				content.write(header);

				Method[] methods = cl.getDeclaredMethods();

				for (int i = 0; i < methods.length; i++) {

					Method m = methods[i];

					Class retType = m.getReturnType();

					Class[] paramTypes = m.getParameterTypes();

					String name = m.getName();

					content.write("<H3>"+name+"</H3>");

					content.write("<PRE>" + Modifier.toString(m.getModifiers()) + " " + retType.getName() + " <B>" + name + "</B>(");

					for (int j = 0; j < paramTypes.length; j++) {

						if (j > 0)
							content.write(", ");

						if (paramTypes.length > 3){
							content.write("<br>\n");
						}

						content.write(paramTypes[j].getName());
					}

					content.write(")</PRE><HR>\n\n");
				} // for

				content.write("<HR><HR><em>Copyright (c) 1997-2012 Applied Software Engineering</em><br>All Rights Reserved</BODY></HTML>");

			} // content != null
		}
		catch(IOException e){
			System.out.println("printMethods.IOException");
		}
		catch(Exception e){
			System.out.println("printMethods.Exception");
		}
		finally{
			try{
				if(content!=null){
					content.close();
					fstream = null;
				}
			}
			catch(IOException e){
				//
			}
			catch(Exception e){
				//
			}

		}
	}


}