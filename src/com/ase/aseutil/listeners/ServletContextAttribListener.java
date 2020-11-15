/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

package com.ase.aseutil.listeners;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;

public class ServletContextAttribListener implements ServletContextAttributeListener {

  public void attributeAdded (ServletContextAttributeEvent scab) {

    System.out.println("An attribute was added to the  ServletContext object");

  }

  public void attributeRemoved (ServletContextAttributeEvent scab) {

    System.out.println("An attribute was removed from  the ServletContext object");

  }

  public void attributeReplaced (ServletContextAttributeEvent scab) {

    System.out.println("An attribute was replaced in the  ServletContext object");

  }

}