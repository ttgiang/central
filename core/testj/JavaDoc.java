import java.util.*;
import java.io.*;

import java.lang.reflect.*;
import java.util.jar.*;

import com.ase.aseutil.*;

public class JavaDoc {

	static final int      MAX_DEPTH  = 20;  							// Max 20 levels (directory nesting)
	static final String   INDENT_STR = "   ";                 	// Single indent.
	static final String[] INDENTS    = new String[MAX_DEPTH]; 	// Indent array.

	static final String jarDir = "c://tomcat//webapps//central//WEB-INF//lib//";

	public static void main(String[] args) {

		INDENTS[0] = INDENT_STR;

		for (int i = 1; i < MAX_DEPTH; i++) {
			INDENTS[i] = INDENTS[i-1] + INDENT_STR;
		}

		try{
			createDoc();
		}
		catch(Exception e){
			System.out.println(e.toString());
		}
	}

	public static void createDoc() throws Exception {

		String klass = "";

		try{
			ArrayList list =  getClasseNamesInPackage("c://tomcat//webapps//central//WEB-INF/lib/central.jar", "com.ase.aseutil");
			if (list != null){

				FileWriter fstream = null;
				BufferedWriter output = null;
				fstream = new FileWriter(AseUtil.getCurrentDrive() + "://tomcat//webapps//central//asedoc.xml");

				if (fstream != null){
					output = new BufferedWriter(fstream);
					output.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
					output.write("<asedoc>\n");
				} // fstream != null

				for (int i = 0; i<list.size(); i++){

					klass = (String)list.get(i);

					output.write("\t<class>\n");

					output.write("\t\t<classname>" + klass + "</classname>\n");

					try{
						Class c = Class.forName(klass.replace(".class",""));

						output.write("\t\t<superclass>" + c.getSuperclass() + "</superclass>\n");

						int mods = c.getModifiers();

						output.write("\t\t<public>" + Modifier.isPublic(mods) + "</public>\n");
						output.write("\t\t<final>" + Modifier.isFinal(mods) + "</final>\n");
						output.write("\t\t<abstract>" + Modifier.isAbstract(mods) + "</abstract>\n");

						// fields
						Field[] fields = c.getFields();
						for(Field f : fields ){
							output.write("\t\t<field>" + f.toString() + "</field>\n");
						}

						// methods
						Method[] metheds = c.getMethods();

						for(Method m : metheds ){
							output.write("\t\t<method>" + m.toString() + "</method>\n");
						}
					}
					catch(java.lang.NoClassDefFoundError e){
						System.out.println(klass + "\n" + e.toString());
					}
					catch(java.lang.IllegalStateException e){
						System.out.println(klass + "\n" + e.toString());
					}
					catch(Exception e){
						System.out.println(klass + "\n" + e.toString());
					}

					output.write("\t</class>\n");

				} // for

				if (fstream != null){
					output.write("</asedoc>\n");
					output.close();
				} // fstream != null

			} // if

		}
		catch(Exception e){
			System.out.println(klass + "\n" + e.toString());
		}

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
			e.printStackTrace ();
		}

		return arrayList;
	}

}