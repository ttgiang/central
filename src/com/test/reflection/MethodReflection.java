package com.test.reflection;

import java.lang.reflect.Method;

public class MethodReflection {
  public static void main(String[] args) throws Exception {
    printTable(10, MethodReflection.class.getMethod("square",
        new Class[] { double.class }));
    printTable( 10, java.lang.Math.class.getMethod("sqrt",
        new Class[] { double.class }));
  }

  public static double square(double x) {
    return x * x;
  }

  public static void printTable(int n, Method f) {
    System.out.println(f);
    try {
      Object[] args = { new Double(n) };
      Double d = (Double) f.invoke(null, args);
      double y = d.doubleValue();
      System.out.println(y);
    } catch (Exception e) {
      System.out.println(e);
    }
  }
}