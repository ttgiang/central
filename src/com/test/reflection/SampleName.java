package com.test.reflection;

import java.awt.Button;

public class SampleName {

  public static void main(String[] args) {
    Button b = new Button();
    ;
    printName(b);
  }

  static void printName(Object o) {
    Class c = o.getClass();
    String s = c.getName();
    System.out.println(s);
  }
}
