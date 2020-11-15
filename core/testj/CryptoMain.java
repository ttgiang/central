import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.security.Key;

public class CryptoMain {

  public static void main(String[] args) throws Exception {

    String mode = "Blowfish/CBC/PKCS5Padding";
    String algorithm = "Blowfish";

    String secretStr = "8326554161EB30EFBC6BF34CC3C832E7CF8135C1999603D4022C031FAEED5C40";

    byte secret[] = fromString(secretStr);

    Cipher encCipher = null;
    Cipher decCipher = null;

    byte[] encoded = null;
    byte[] decoded = null;

    encCipher = Cipher.getInstance(mode);
    decCipher = Cipher.getInstance(mode);

    Key key = new SecretKeySpec(secret, algorithm);
    byte[] ivBytes = new byte[] { 00, 00, 00, 00, 00, 00, 00, 00 };
    IvParameterSpec iv = new IvParameterSpec(ivBytes);

    encCipher.init(Cipher.ENCRYPT_MODE, key, iv);
    decCipher.init(Cipher.DECRYPT_MODE, key, iv);

    encoded = encCipher.doFinal(new byte[] {1, 2, 3, 4, 5});

    // THIS IS THE ENCODED STRING I USE IN THE PERL SCRIPT
    System.out.println("encoded: " + toString(encoded));

    decoded = decCipher.doFinal(encoded);
    System.out.println("decoded: " + toString(decoded));

    encoded = encCipher.doFinal(new byte[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20});
    System.out.println("encoded: " + toString(encoded));
    decoded = decCipher.doFinal(encoded);
    System.out.println("decoded: " + toString(decoded));

  }


  ///////// some hex utilities below....

  private static final char[] hexDigits = {
    '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
  };


  /**
   * Returns a string of hexadecimal digits from a byte array. Each
   * byte is converted to 2 hex symbols.
   * <p>
   * If offset and length are omitted, the complete array is used.
   */
  public static String toString(byte[] ba, int offset, int length) {
    char[] buf = new char[length * 2];
    int j = 0;
    int k;

    for (int i = offset; i < offset + length; i++) {
      k = ba[i];
      buf[j++] = hexDigits[(k >>> 4) & 0x0F];
      buf[j++] = hexDigits[ k        & 0x0F];
    }
    return new String(buf);
  }

  public static String toString(byte[] ba) {
    return toString(ba, 0, ba.length);
  }

  /**
   * Returns the number from 0 to 15 corresponding to the hex digit <i>ch</i>.
   */
  private static int fromDigit(char ch) {
    if (ch >= '0' && ch <= '9')
      return ch - '0';
    if (ch >= 'A' && ch <= 'F')
      return ch - 'A' + 10;
    if (ch >= 'a' && ch <= 'f')
      return ch - 'a' + 10;

    throw new IllegalArgumentException("invalid hex digit '" + ch + "'");
  }