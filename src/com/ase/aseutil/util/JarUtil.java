/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.util;

import com.ase.aseutil.*;

import java.util.*;
import java.io.*;
import java.lang.reflect.*;
import java.util.jar.*;

import org.apache.log4j.Logger;

public class JarUtil {

	static Logger logger = Logger.getLogger(JarUtil.class.getName());

	static final int      MAX_DEPTH  = 20;  							// Max 20 levels (directory nesting)
	static final String   INDENT_STR = "   ";                 	// Single indent.
	static final String[] INDENTS    = new String[MAX_DEPTH]; 	// Indent array.

	static final String jarDir = "C://tomcat//webapps//central//WEB-INF//lib//";

	/*
	 * traverseFolders - the starting folder to traverse to create the reflection API data
	 *	<p>
	 * @param	rootFolder String
	 */
	public static void traverseFolders(String rootFolder) {

		INDENTS[0] = INDENT_STR;

		for (int i = 1; i < MAX_DEPTH; i++) {
			INDENTS[i] = INDENTS[i-1] + INDENT_STR;
		}

		File root = new File(rootFolder);

		if (root != null && root.isDirectory()) {
			traverse(root, 0);
		}
		else {
			logger.fatal("Not a directory: " + root);
		}
	}

	/*
	 * traverse
	 *	<p>
	 * @param	fdir		File
	 * @param	depth		int
	 */
	public static void traverse(File fdir, int depth) {

		try{
			if (fdir.getName().toLowerCase().indexOf("central.jar") > -1){

				System.out.println(INDENTS[depth] + fdir.getName());

				String jarFile = fdir.getName().toLowerCase();

				ArrayList list =  getClasseNamesInPackage(jarDir + jarFile, "com.ase.aseutil");
				if (list != null){

					for (int i = 0; i<list.size(); i++){

						String klass = (String)list.get(i);

						System.out.println("<span class=\"textblackth\">" + klass + "</span>" + Html.BR());

						Class c = Class.forName(klass.replace(".class",""));

						Method[] metheds = c.getMethods();

						for(Method m : metheds ){
							System.out.println("&nbsp;&nbsp;&nbsp;<span class=\"datacolumn\">" + m + "</span>" + Html.BR());
						}

						System.out.println(Html.BR());

					} // for
				} // if
			} // jar file?
		}
		catch(NoClassDefFoundError e){
			//logger.fatal(e.toString());
		}
		catch(Exception e){
			//logger.fatal(e.toString());
		}

		if (fdir.isDirectory() && depth < MAX_DEPTH) {

			for (File f : fdir.listFiles()) {

				traverse(f, depth+1);

			} // for

		} // if

	}

	/*
	 * getClasseNamesInPackage
	 *	<p>
	 * @param	jarName		String
	 * @param	packageName	String
	 */
	@SuppressWarnings("unchecked")
	public static ArrayList getClasseNamesInPackage(String jarName, String packageName){

		ArrayList arrayList = new ArrayList ();

		packageName = packageName.replaceAll("\\." , "/");

		try{
			JarInputStream jarFile = new JarInputStream(new FileInputStream (jarName));

			JarEntry jarEntry;

			while(true) {
				jarEntry = jarFile.getNextJarEntry ();

				if(jarEntry == null){
					break;
				}

				if((jarEntry.getName ().startsWith (packageName)) && (jarEntry.getName ().endsWith (".class")) ) {
					arrayList.add(jarEntry.getName().replaceAll("/", "\\."));
				}
			}
		}
		catch( Exception e){
			e.printStackTrace ();
		}

		return arrayList;
	}

	/*
	 * invoke
	 *	<p>
	 * @param	className	String
	 * @param	methodName	String
	 * @param	params		Class[]
	 * @param	args			Object[]
	 */
	static void invoke(String className, String methodName, Class[] params, Object[] args) {

		/*
		String klass = "com.ase.aseutil.jobs.JobNameDB";
		String methed = "resetJobNames";

		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,methed,new Class[] {},new Object[]{});

		methed = "resetJobName";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class},
				new Object[]{new String("SearchData")});

		methed = "updateJobStats";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,String.class,int.class},
				new Object[]{new String("SearchData"),new String("THANHG"),0});

		methed = "updateJobTotal";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,int.class},
				new Object[]{new String("SearchData"),0});

		klass = "com.ase.aseutil.util.SearchDB";
		methed = "createSearchData";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,String.class},
				new Object[]{new String(""),new String("")});

      Class c = Class.forName(klass);
      Method[] metheds = c.getMethods();
      for(Method m : metheds ){
         out.println(m  + Html.BR());
      }

		*/

		try {
			Class c = Class.forName(className);
			Method m = c.getDeclaredMethod(methodName, params);
			Object i = c.newInstance();
			Object r = m.invoke(i,args);
		}
		catch (Exception e) {
			System.out.println(e.toString());
		}

	}

	/*
	 * createJavaDoc - create documentation for ASE use
	 *	<p>
	 */
	public static void createJavaDoc() throws Exception {

		Logger logger = Logger.getLogger("test");

		String klass = "";

		Class c = null;

		try{
			ArrayList list =  getClasseNamesInPackage(
									AseUtil.getCurrentDrive() + "://tomcat//webapps//central//WEB-INF//lib//central.jar",
									"com.ase.aseutil");

			if (list != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				fstream = new FileWriter(AseUtil.getCurrentDrive() + "://tomcat//webapps//central//javadoc.xml");

				if (fstream != null){
					output = new BufferedWriter(fstream);
					output.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
					output.write("<?xml-stylesheet type=\"text/css\" href=\"javadoc.css\"?>\n");
					output.write("<JAVADOCS>\n");
				} // fstream != null

				for (int i = 0; i<list.size(); i++){

					klass = (String)list.get(i);

					output.write("\t<CLASSES>\n");

					output.write("\t\t<CLASSNAME>" + klass + "</CLASSNAME>\n");

					try{
						c = Class.forName(klass.replace(".class",""));
					}
					catch(NoClassDefFoundError e){
						//
					}
					catch(Exception e){
						//
					}

					Method[] metheds = c.getMethods();

					for(Method m : metheds ){

						Method methlist[] = c.getDeclaredMethods();

						for (int ii = 0; ii < methlist.length;ii++) {

							output.write("\t\t<METHODS>\n");

							Method ml = methlist[ii];

							output.write("\t\t\t<METHODNAME>" + ml.getName() + "</METHODNAME>\n");

							output.write("\t\t\t<DECLARATIONS>\n");

							Class pvec[] = ml.getParameterTypes();

							for (int j = 0; j < pvec.length; j++)
								output.write("\t\t\t\t<PARMS>" + pvec[j] + "</PARMS>\n");

							Class evec[] = ml.getExceptionTypes();

							for (int j = 0; j < evec.length; j++)
								output.write("\t\t\t\t<EXCEPTIONS>" + evec[j] + "</EXCEPTIONS>\n");

							output.write("\t\t\t\t<RETURNTYPE>" + ml.getReturnType() + "</RETURNTYPE>\n");

							output.write("\t\t\t</DECLARATIONS>\n");

							output.write("\t\t</METHODS>\n");
						} // ii
					} // method m

					output.write("\t</CLASSES>\n");

				} // for


				if (fstream != null){
					output.write("</JAVADOCS>\n");
					output.close();
				} // fstream != null

			} // if

		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

	}

	/*
	 * createClassMethodSignatures - create documentation for ASE use
	 *	<p>
	 */
	public static void createClassMethodSignatures(String className,boolean includeExceptions) throws Exception {

		Logger logger = Logger.getLogger("test");

		String klass = "";

		Class c = null;

		try{
			ArrayList list =  getClasseNamesInPackage(
									AseUtil.getCurrentDrive() + "://tomcat//webapps//central//WEB-INF//lib//central.jar",
									"com.ase.aseutil");

			if (list != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				fstream = new FileWriter(AseUtil.getCurrentDrive() + "://tomcat//webapps//central//javadoc.xml");

				if (fstream != null){
					output = new BufferedWriter(fstream);
				} // fstream != null

				int k = list.size();

				//k = 1;

				for (int i = 0; i<k; i++){

					klass = (String)list.get(i);

					try{
						c = Class.forName(klass.replace(".class",""));

						output.write("----------------------------------\n");
						output.write(klass.replace(".class","") + "\n");
						output.write("----------------------------------\n");

						Method[] metheds = c.getMethods();

						if(metheds != null){

							Method methlist[] = c.getDeclaredMethods();

							for (int ii = 0; ii < methlist.length;ii++) {

								Method ml = methlist[ii];

								output.write(ml.getReturnType() + " " + ml.getName() + "(");

								Class parameters[] = ml.getParameterTypes();

								for (int j = 0; j < parameters.length; j++){

									if(j > 0){
										output.write(",");
									}

									String junk = (parameters[j]+"").toString()
											.replace("class java.lang.String","String")
											.replace("interface java.sql.Connection","Connection")
											.replace("class com.ase.aseutil.","")
											;

									output.write(junk);
								}

								output.write(") ");

								if(includeExceptions){
									Class exceptions[] = ml.getExceptionTypes();

									for (int j = 0; j < exceptions.length; j++){
										if(j > 0){
											output.write(",");
										}

										output.write(exceptions[j] + "");
									}
								}

								output.write("\n");

							} // ii

						} // if

					}
					catch(NoClassDefFoundError e){
						System.out.println("1");
					}
					catch(Exception e){
						System.out.println("2");
					}

					output.write("\n");

				} // for i


				if (fstream != null){
					output.close();
				} // fstream != null

			} // if

		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

	}

}