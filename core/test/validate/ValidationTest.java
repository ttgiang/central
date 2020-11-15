public class ValidationTest {
  public static void main(String[] args) {
    String candidate = "I love Java and Java2s";
    String pattern = "Java";
    System.out.println(candidate.matches(pattern));
  }
}
