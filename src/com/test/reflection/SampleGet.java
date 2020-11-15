package com.test.reflection;

import java.awt.Rectangle;
import java.lang.reflect.Field;

public class SampleGet {

  public static void main(String[] args) {
    Rectangle r = new Rectangle(100, 325);
    printHeight(r);

  }

  static void printHeight(Rectangle r) {
    Field heightField;
    Integer heightValue;
    Class c = r.getClass();
    try {
      heightField = c.getField("height");
      heightValue = (Integer) heightField.get(r);
      System.out.println("Height: " + heightValue.toString());
    } catch (NoSuchFieldException e) {
      System.out.println(e);
    } catch (SecurityException e) {
      System.out.println(e);
    } catch (IllegalAccessException e) {
      System.out.println(e);
    }
  }
}
