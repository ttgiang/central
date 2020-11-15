package com.devdaily.log4jdemo;

import org.apache.log4j.Category;
import org.apache.log4j.PropertyConfigurator;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;

public class Log4JDemo
{
  static final Category log = Category.getInstance(Log4JDemo.class);
  static final String LOG_PROPERTIES_FILE = "lib/Log4J.properties";

  public static void main(String[] args)
  {
    // call our constructor
    new Log4JDemo();
    // Log4J is now loaded; try it
    log.info("leaving the main method of Log4JDemo");
  }

  public Log4JDemo()
  {
    initializeLogger();
    log.info( "Log4JDemo - leaving the constructor ..." );
  }

  private void initializeLogger()
  {
    Properties logProperties = new Properties();

    try
    {
      logProperties.load(new FileInputStream(LOG_PROPERTIES_FILE));
      PropertyConfigurator.configure(logProperties);
      log.info("Logging initialized.");
    }
    catch(IOException e)
    {
      throw new RuntimeException("Unable to load logging property " + LOG_PROPERTIES_FILE);
    }
  }
}
