import java.io.File;
 public class CurrentDir {
   public static void main (String args[]) {
     File dir1 = new File (".");
     File dir2 = new File ("..");
     try {
       System.out.println ("Current dir : " + dir1.getCanonicalPath());
       System.out.println ("Parent  dir : " + dir2.getCanonicalPath());
       }
     catch(Exception e) {
       e.printStackTrace();
       }
     }
}