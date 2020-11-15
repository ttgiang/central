import java.util.regex.*;

class regexSample 
{
   public static void main(String args[]) 
   {
      //Input the string for validation
      String email = "xyz@hotmail.com";

      //Set the email pattern string
      Pattern p = Pattern.compile(".+@.+\\.[a-z]+");

      //Match the given string with the pattern
      Matcher m = p.matcher(email);

      //check whether match is found 
      boolean matchFound = m.matches();

      if (matchFound)
        System.out.println("Valid Email Id.");
      else
        System.out.println("Invalid Email Id.");
   }
}