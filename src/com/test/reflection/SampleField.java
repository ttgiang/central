package com.test.reflection;

import java.awt.GridBagConstraints;
import java.lang.reflect.Field;

public class SampleField {

  public static void main(String[] args) {
    GridBagConstraints g = new GridBagConstraints();
    printFieldNames(g);
  }

  static void printFieldNames(Object o) {
    Class c = o.getClass();
    Field[] publicFields = c.getFields();
    for (int i = 0; i < publicFields.length; i++) {
      String fieldName = publicFields[i].getName();
      Class typeClass = publicFields[i].getType();
      String fieldType = typeClass.getName();
      System.out.println("Name: " + fieldName + ", Type: " + fieldType);
    }
  }
}
