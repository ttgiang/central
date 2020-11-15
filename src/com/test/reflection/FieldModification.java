package com.test.reflection;

import java.lang.reflect.Field;

/**
 * Demonstrates how to set public field objects.
 *
 * @author <a href=mailto:kraythe@arcor.de>Robert Simmons jr. (kraythe)</a>
 * @version $Revision: 1.3 $
 */
public class FieldModification {
  /**
   * Sets all int fields in an object to 0.
   *
   * @param obj The object to operate on.
   *
   * @throws RuntimeException If there is a reflection problem.
   */
  public static void initPublicIntFields(final Object obj) {
    try {
      Field[] fields = obj.getClass()
                        .getFields();
      for (int idx = 0; idx < fields.length; idx++) {
        if (fields[idx].getType() == int.class) {
          fields[idx].setInt(obj, 0);
        }
      }
    } catch (final IllegalAccessException ex) {
      throw new RuntimeException(ex);
    }
  }

  /**
   * Sets all int fields in an object to 0.
   *
   * @param obj The object to operate on.
   *
   * @throws RuntimeException If there is a reflection problem.
   */
  public static void initPublicIntFields2(final Object obj) {
    try {
      final Integer value = new Integer(0);
      Field[] fields = obj.getClass()
                        .getFields();
      for (int idx = 0; idx < fields.length; idx++) {
        if (fields[idx].getType() == int.class) {
          fields[idx].set(obj, value);
        }
      }
    } catch (final IllegalAccessException ex) {
      throw new RuntimeException(ex);
    }
  }

  /**
   * Demo Method.
   *
   * @param args Command line arguments.
   */
  public static final void main(final String[] args) {
    SomeNumbers value = new SomeNumbers();
    System.out.println("Before: " + value);
    initPublicIntFields(value);
    System.out.println("After: " + value);
  }
}


class SomeNumbers {
  /** A demo double. */
  public double a = 21.25d;

  /** A demo float. */
  public float b = 54.5f;

  /** A Demo int */
  public int c = 5665;

  /** Another demo int. */
  public int d = 2043;

  /** Another demo int. */
  protected int e = 3121;

  /** Another demo int. */
  private int f = 1019;

  /**
   * @see java.lang.Object#toString()
   */
  public String toString() {
    return new String("[a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", e=" + e
                      + ", f=" + f + "]");
  }
}
