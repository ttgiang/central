package com.test.reflection;

import java.lang.reflect.Method;

/**
 * Demonstrates how to get specific method information.
 *
 * @author <a href=mailto:kraythe@arcor.de>Robert Simmons jr. (kraythe)</a>
 * @version $Revision: 1.3 $
 */
public class SpecificMethodInfoDemo {
  public static void main(final String[] args) {
    final Method byteValueMeth;
    final Method waitMeth;
    final Method waitDetailMeth;

    try {
      byteValueMeth = Number.class.getMethod("byteValue", null);
      waitMeth = Number.class.getMethod("wait", new Class[] {});
      waitDetailMeth = Number.class.getMethod("wait", new Class[] { long.class, int.class });
    } catch (final NoSuchMethodException ex) {
      throw new RuntimeException(ex);
    }

    System.out.println("byteValueMeth = " + byteValueMeth.toString());
    System.out.println("waitMeth = " + waitMeth.toString());
    System.out.println("waitDetailMeth = " + waitDetailMeth.toString());
  }
}
