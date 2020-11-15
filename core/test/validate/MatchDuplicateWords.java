import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class MatchDuplicateWords {
  public static void main(String args[]) {

    hasDuplicate("pizza pizza");
    hasDuplicate("Faster pussycat kill kill");
    hasDuplicate("The mayor of of simpleton");
    hasDuplicate("Never Never Never Never Never");
    hasDuplicate("222 2222");
    hasDuplicate("sara sarah");
    hasDuplicate("Faster pussycat kill, kill");
    hasDuplicate(". .");
  }

  public static boolean hasDuplicate(String phrase) {
    boolean retval = false;
    String duplicatePattern = "\\b(\\w+) \\1\\b";
    Pattern p = null;
    try {
      p = Pattern.compile(duplicatePattern);
    } catch (PatternSyntaxException pex) {
      pex.printStackTrace();
      System.exit(0);
    }
    int matches = 0;
    Matcher m = p.matcher(phrase);
    String val = null;

    while (m.find()) {
      retval = true;
      val = ":" + m.group() + ":";
      System.out.println(val);
      matches++;
    }

    String msg = "   NO MATCH: pattern:" + phrase
        + "\r\n             regex: " + duplicatePattern;

    if (retval) {
      msg = " MATCH     : pattern:" + phrase + "\r\n         regex: "
          + duplicatePattern;
    }

    System.out.println(msg + "\r\n");
    return retval;
  }
}
