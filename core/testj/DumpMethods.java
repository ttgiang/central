import java.lang.reflect.*;

public class DumpMethods {
	public static void main(String args[]){
		try {
			String cls = "com.ase.aseutil.CourseDB";

			Class c = Class.forName(cls);

			Method m[] = c.getDeclaredMethods();

			for (int i = 0; i < m.length; i++){
				System.out.println(m[i].toString());
			}

		}
		catch (Throwable e) {
			System.err.println(e);
		}
	}
}