import java.io.*;
import java.util.*;
import java.util.jar.*;

public class GetClassesInPackage {

	private static boolean getJar = true;

	public static ArrayList getClasseNamesInPackage(String jarName, String packageName){

		ArrayList arrayList = new ArrayList ();

		packageName = packageName.replaceAll("\\." , "/");

		if (getJar)
			System.out.println("Jar " + jarName + " for " + packageName + "\n");

		try{
			JarInputStream jarFile = new JarInputStream(new FileInputStream (jarName));

			JarEntry jarEntry;

			while(true) {
				jarEntry=jarFile.getNextJarEntry ();

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

	public static void main (String[] args){

		ArrayList list =  GetClassesInPackage.getClasseNamesInPackage("C://tomcat//webapps//central//WEB-INF/lib/central.jar", "com.ase.aseutil");

		System.out.println("Found: " + list);

	}
}