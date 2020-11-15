import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class ValidationTestWithPatternAndMatcher {
  public static void main(String args[]) {
    Pattern p = null;
    try {
      p = Pattern.compile("Java \\d");
    } catch (PatternSyntaxException pex) {
      pex.printStackTrace();
      System.exit(0);
    }

    String candidate = "I love Java 5";
    Matcher m = p.matcher(candidate);

    System.out.println("result=" + m.find());
  }
}
