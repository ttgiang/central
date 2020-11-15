package com.test.reflection;

import java.awt.Rectangle;
import java.lang.reflect.Constructor;

public class SampleConstructor {

  public static void main(String[] args) {
    Rectangle r = new Rectangle();
    showConstructors(r);
  }

  static void showConstructors(Object o) {
    Class c = o.getClass();
    Constructor[] theConstructors = c.getConstructors();
    for (int i = 0; i < theConstructors.length; i++) {
      System.out.print("( ");
      Class[] parameterTypes = theConstructors[i].getParameterTypes();
      for (int k = 0; k < parameterTypes.length; k++) {
        String parameterString = parameterTypes[k].getName();
        System.out.print(parameterString + " ");
      }
      System.out.println(")");
    }
  }
}