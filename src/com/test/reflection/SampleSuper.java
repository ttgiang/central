package com.test.reflection;

import java.awt.Button;

public class SampleSuper {

  public static void main(String[] args) {
    Button b = new Button();
    printSuperclasses(b);
  }

  static void printSuperclasses(Object o) {
    Class subclass = o.getClass();
    Class superclass = subclass.getSuperclass();
    while (superclass != null) {
      String className = superclass.getName();
      System.out.println(className);
      subclass = superclass;
      superclass = subclass.getSuperclass();
    }
  }
}

