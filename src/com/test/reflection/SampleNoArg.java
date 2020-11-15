package com.test.reflection;

import java.awt.Rectangle;

public class SampleNoArg {

   public static void main(String[] args) {
      Rectangle r = (Rectangle) createObject("java.awt.Rectangle");
      System.out.println(r.toString());
   }

   static Object createObject(String className) {
      Object object = null;
      try {
          Class classDefinition = Class.forName(className);
          object = classDefinition.newInstance();
      } catch (InstantiationException e) {
          System.out.println(e);
      } catch (IllegalAccessException e) {
          System.out.println(e);
      } catch (ClassNotFoundException e) {
          System.out.println(e);
      }
      return object;
   }
}
