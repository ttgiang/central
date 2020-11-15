import java.io.*;
import java.util.*;
import java.util.logging.*;

public class HTMLLogging extends java.util.logging.Formatter{

	final static int handlerHTML = 0;
	final static int handlerTEXT = 1;
	final static int handlerXML = 2;

	static int handlerType = handlerHTML;

	public static void main(String[] args) {
		// Get a logger; the logger is automatically created if it doesn't already exist
		Logger logger = Logger.getLogger("com.mycompany.HTMLLogging");

		// Create a new handler that uses the simple formatter
		FileHandler fh;
		switch(handlerType){
			case handlerHTML:
				try {
					fh = new FileHandler("mylog.html");
					fh.setFormatter(new MyHtmlFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

				break;
			case handlerTEXT:
				try {
					fh = new FileHandler("mylog.txt");
					fh.setFormatter(new SimpleFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

				break;
			case handlerXML:
				try {
					fh = new FileHandler("mylog.xml");
					fh.setFormatter(new XMLFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

				break;
		}

		// Log a few messages
		/*
		logger.severe("my severe message");
		logger.warning("my warning message");
		logger.info("my info message");
		logger.config("my config message");
		logger.fine("my fine message");
		logger.finer("my finer message");
		logger.finest("my finest message");
		*/
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

	// This method is called just after the handler using this formatter is created
	public String getHead(Handler h) {
		return "<HTML><HEAD>"+(new Date())+"</HEAD><BODY><PRE>\n";
	}

	// This method is called just after the handler using this formatter is closed
	public String getTail(Handler h) {
		return "</PRE></BODY></HTML>\n";
	}
}

