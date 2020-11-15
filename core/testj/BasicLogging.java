import java.io.*;
import java.util.*;
import java.util.logging.*;

public class BasicLogging extends java.util.logging.Formatter{
  public static void main(String[] args) {
		// Get a logger; the logger is automatically created if
		// it doesn't already exist
		Logger logger = Logger.getLogger("com.mycompany.BasicLogging");

		// logging a method entry
		if (logger.isLoggable(Level.FINER)) {
			int p1 = 5;
			int p2 = 5;
			//logger.entering(this.getClass().getName(), "myMethod", new Object[]{new Integer(p1), p2});
			logger.entering("com.mycompany.BasicLogging", "myMethod", new Object[]{new Integer(p1), p2});
		}

		boolean result = true;
		if (logger.isLoggable(Level.FINER)) {
			 //logger.exiting(this.getClass().getName(), "myMethod", new Boolean(result));
			 logger.exiting("com.mycompany.BasicLogging", "myMethod", new Boolean(result));

			 // Use the following if the method does not return a value
			 //logger.exiting(this.getClass().getName(), "myMethod");
			 logger.exiting("com.mycompany.BasicLogging", "myMethod");
		}

		// Set the level to a particular level
		logger.setLevel(Level.INFO);

		// Set the level to that of its parent
		logger.setLevel(null);

		// Turn off all logging
		logger.setLevel(Level.OFF);

		// Turn on all logging
		logger.setLevel(Level.ALL);

		// Log a few message at different severity levels
		logger.severe("my severe message");
		logger.warning("my warning message");
		logger.info("my info message");
		logger.config("my config message");
		logger.fine("my fine message");
		logger.finer("my finer message");
		logger.finest("my finest message");

		// Get a logger
		logger = Logger.getLogger("com.mycompany");

		// Create a new handler that uses the simple formatter
		try {
			// Create a file handler with a limit of 1 megabytes
			int limit = 1000000; // 1 Mb
			FileHandler fh = new FileHandler("my.log", limit, 1);
			fh.setFormatter(new SimpleFormatter());
			logger.addHandler(fh);
		} catch (IOException e) {}

		// Create a new handler that uses the XML formatter
		try {
			// Create a file handler that uses 3 logfiles, each with a limit of 1Mbyte
			String pattern = "my%g.xml";
			int limit = 1000000; // 1 Mb
			int numLogFiles = 3;
			FileHandler fh = new FileHandler(pattern, limit, numLogFiles);
			fh.setFormatter(new XMLFormatter());
			logger.addHandler(fh);
		} catch (IOException e) {}

    	logger = Logger.getLogger("com.mycompany");
		try {
			// Create a file handler that uses the custom formatter
			FileHandler fh = new FileHandler("mylog.html");
			fh.setFormatter(new MyHtmlFormatter());
			logger.addHandler(fh);
		} catch (IOException e) {}

		// Log a few messages
		logger.severe("my severe message");
		logger.warning("my warning message");
		logger.info("my info message");
		logger.config("my config message");
		logger.fine("my fine message");
		logger.finer("my finer message");
		logger.finest("my finest message");
	}

	// This method is called for every log records
	public String format(LogRecord rec) {
		StringBuffer buf = new StringBuffer(1000);

		// Bold any levels >= WARNING
		if (rec.getLevel().intValue() >= Level.WARNING.intValue()) {
			buf.append("<b>");
			buf.append(rec.getLevel());
			buf.append("</b>");
		} else {
			buf.append(rec.getLevel());
		}

		buf.append(' ');
		buf.append(rec.getMillis());
		buf.append(' ');
		buf.append(formatMessage(rec));
		buf.append('\n');
		return buf.toString();
	}

	// This method is called just after the handler using this
	// formatter is created
	public String getHead(Handler h) {
		return "<HTML><HEAD>"+(new Date())+"</HEAD><BODY><PRE>\n";
	}

	// This method is called just after the handler using this
	// formatter is closed
	public String getTail(Handler h) {
		return "</PRE></BODY></HTML>\n";
	}
}

