import java.util.*;
import java.io.*;

import java.lang.reflect.*;
import java.util.jar.*;

import com.ase.aseutil.*;

public class RecursiveList {

	static final int      MAX_DEPTH  = 20;  							// Max 20 levels (directory nesting)
	static final String   INDENT_STR = "   ";                 	// Single indent.
	static final String[] INDENTS    = new String[MAX_DEPTH]; 	// Indent array.

	static final String jarDir = "c://tomcat//webapps//central//WEB-INF//lib//";

	public static void main(String[] args) {

		INDENTS[0] = INDENT_STR;

		for (int i = 1; i < MAX_DEPTH; i++) {
			INDENTS[i] = INDENTS[i-1] + INDENT_STR;
		}

		File root = new File(jarDir);

		try{
			if (root != null && root.isDirectory()) {
				createDoc();
				//traverse(root, 0);
			}
			else {
				System.out.println("Not a directory: " + root);
			}
		}
		catch(Exception e){
			System.out.println("main\n" + e.toString());
		}
	}

	public static void createDoc() throws Exception {

		String klass = "";

		try{
			ArrayList list =  getClasseNamesInPackage("c://tomcat//webapps//central//WEB-INF/lib/central.jar", "com.ase.aseutil");
			if (list != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				fstream = new FileWriter(AseUtil.getCurrentDrive() + "://tomcat//webapps//central//javadoc.xml");

				if (fstream != null){
					output = new BufferedWriter(fstream);
					output.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
					output.write("<javadoc>\n");
				} // fstream != null

				for (int i = 0; i<list.size(); i++){

					klass = (String)list.get(i);

					try{
						output.write("<class>" + klass + "</class>\n");

						Class c = Class.forName(klass.replace(".class",""));

						Method[] metheds = c.getMethods();

						for(Method m : metheds ){
							output.write("<method>" + m + "</method>\n");
						}
					}
					catch(java.lang.NoClassDefFoundError e){
						System.out.println(klass + "\n" + e.toString());
					}
					catch(Exception e){
						System.out.println(klass + "\n" + e.toString());
					}

				} // for

				if (fstream != null){
					output.write("</javadoc>\n");
					output.close();
				} // fstream != null

			} // if

		}
		catch(Exception e){
			System.out.println(klass + "\n" + e.toString());
		}

	}

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
			System.out.println("traverse\n" + e.toString());
		}
		catch(Exception e){
			System.out.println("traverse\n" + e.toString());
		}

		if (fdir.isDirectory() && depth < MAX_DEPTH) {

			for (File f : fdir.listFiles()) {

				traverse(f, depth+1);

			} // for

		} // if

	}

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
			} // while
		}
		catch( Exception e){
			System.out.println("getClasseNamesInPackage\n" + e.toString());
		}

		return arrayList;
	}

	static void invoke(String className, String methodName, Class[] params, Object[] args) {

		try {
			Class c = Class.forName(className);
			Method m = c.getDeclaredMethod(methodName, params);
			Object i = c.newInstance();
			Object r = m.invoke(i,args);
		}
		catch (Exception e) {
			System.out.println("invoke\n" + e.toString());
		}

	}

}