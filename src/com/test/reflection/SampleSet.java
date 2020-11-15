package com.test.reflection;

import java.awt.Rectangle;
import java.lang.reflect.Field;

public class SampleSet {

  public static void main(String[] args) {
    Rectangle r = new Rectangle(100, 20);
    System.out.println("original: " + r.toString());
    modifyWidth(r, new Integer(300));
    System.out.println("modified: " + r.toString());
  }

  static void modifyWidth(Rectangle r, Integer widthParam) {
    Field widthField;
    Integer widthValue;
    Class c = r.getClass();
    try {
      widthField = c.getField("width");
      widthField.set(r, widthParam);
    } catch (NoSuchFieldException e) {
      System.out.println(e);
    } catch (IllegalAccessException e) {
      System.out.println(e);
    }
  }
}
