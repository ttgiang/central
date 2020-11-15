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
package com.ase.aseutil.doc;

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

  static FileWriter fstream = null;
  static BufferedWriter out = null;
  static String aseClassDir = null;

  /**
  * Demonstrate use.
  *
  * @param aArgs - <tt>aArgs[0]</tt> is the full name of an existing
  * directory that can be read.
  */
	public static void main(String... aArgs) {

		String currentDrive = com.ase.aseutil.AseUtil.getCurrentDrive();

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
			fstream = new FileWriter(currentDrive + ":\\tomcat\\webapps\\central\\javadoc\\asedoc.txt");

			out = new BufferedWriter(fstream);

			File startingDirectory = new File(userFolder);

			List<File> files = AseDoc.getAseDoc(startingDirectory);

			for(File file : files ){
				//out.write(file);
			}
		}
		catch(FileNotFoundException e){
			//
		}
		catch(Exception e){
			//
		}
		finally{
			try{
				if(out!=null){
					out.close();
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
			out.write("class " + name + "\n");

			for(int i=0; i<(name.length()+6); i++){
				out.write("-");
			}
			out.write("\n");

			Class cl = Class.forName(name);

			Class supercl = cl.getSuperclass();

			printMethods(cl);

			out.write("\n");

		} catch (NoClassDefFoundError e) {
			System.out.println("writeDoc.NoClassDefFoundError: " + name);
		} catch (ClassNotFoundException e) {
			System.out.println("writeDoc.ClassNotFoundException: " + name);
		} catch (IOException e) {
			System.out.println("writeDoc.IOException: " + name);
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
					packageName = file.getParent().replace("d:\\tomcat\\webapps\\central\\src\\com\\ase\\aseutil\\","") + ".";
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
	public static void printMethods(Class cl) {

		try{
			Method[] methods = cl.getDeclaredMethods();

			for (int i = 0; i < methods.length; i++) {

				Method m = methods[i];

				Class retType = m.getReturnType();

				Class[] paramTypes = m.getParameterTypes();

				String name = m.getName();

				out.write(Modifier.toString(m.getModifiers()));

				out.write(" " + retType.getName() + " " + name + "(");

				for (int j = 0; j < paramTypes.length; j++) {

					if (j > 0)
						out.write(", ");

					out.write(paramTypes[j].getName());
				}

				out.write(");" + "\n");
			}
		}
		catch(IOException e){
			System.out.println("printMethods.IOException");
		}
		catch(Exception e){
			System.out.println("printMethods.Exception");
		}
	}


}