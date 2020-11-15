import java.lang.reflect.*;

public class testReflect2 {

	static void invoke(String className, String methodName, Class[] params, Object[] args) {

		try {
			Class c = Class.forName(className);
			Method m = c.getDeclaredMethod(methodName, params);
			Object i = c.newInstance();
			Object r = m.invoke(i,args);
		}
			catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {

		invoke(	"Class1",
					"say",
					new Class[] {String.class, String.class},
					new Object[]{new String("Hello"), new String("World")}
				);
	}
}

class Class1 {

	public void say( String s1, String s2) {
		System.out.println(s1 + " " + s2);
	}

}