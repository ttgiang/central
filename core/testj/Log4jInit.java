/**
	* Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
	* You may not modify, use, reproduce, or distribute this software except
	* in compliance with the terms of the License made with Applied Software Engineernig
	* @author ttgiang
*/

import org.apache.log4j.PropertyConfigurator;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.IOException;

public class Log4jInit {

	public void init() {
		String prefix =  getRealPath("/");
		HttpServletRequest request;
		//String prefix = request.getContextPath();
		//String file = getInitParameter("log4jInitFile");

		String file = prefix + "\\WEB-INF\\log4jv3.xml";

		if ( file != null ) {
			PropertyConfigurator.configure( file );
		}
	}
}
