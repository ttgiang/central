package com.test.reflection;

import java.lang.reflect.Modifier;

public class SampleModifier {

  public static void main(String[] args) {
    String s = new String();
    printModifiers(s);
  }

  public static void printModifiers(Object o) {
    Class c = o.getClass();
    int m = c.getModifiers();
    if (Modifier.isPublic(m))
      System.out.println("public");
    if (Modifier.isAbstract(m))
      System.out.println("abstract");
    if (Modifier.isFinal(m))
      System.out.println("final");
  }
}