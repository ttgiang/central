import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sun.misc.*;
import java.util.*;
import com.javaexchange.dbConnectionBroker.*;

/**
 * Basic example of the DbConnectionBroker.
 * Servlet simply queries a timestamp from an Oracle database and
 * displays it with the ID of the current connection from the pool.
 * It is invoked by the URL http://whatever-domain/servlet/DBConn
 */
public class DBConn extends HttpServlet
{
    DbConnectionBroker myBroker;

    public void init (ServletConfig config) throws ServletException {
        super.init(config);
        // The below statement sets up a Broker with a minimun pool size of 2 connections
        // and a maximum of 5.  The log file will be created in
        // D:\JavaWebServer1.1\DCB_Example.log and the pool connections will be
        // restarted once a day.
        try {myBroker = new DbConnectionBroker("sun.jdbc.odbc.JdbcOdbcDriver",
                                         "jdbc:odbc:ccv2",
                                         "root","",2,6,
                                         "c:\\tomcat\\DBConn\\DBConn.log",1.0);}
        catch (IOException e5)  { }
    }

    public void doGet (HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
        PrintStream out = new PrintStream (response.getOutputStream());
        Connection conn = null;
        Statement stmt = null;
        int thisConnection;
        response.setContentType ("text/html");

        try {
            // Get a DB connection from the Broker
            conn = myBroker.getConnection();

            thisConnection = myBroker.idOfConnection(conn);

            out.println("&amp;lth3&gt;DbConnectionBroker Example 1&lt;/h3&gt;" +
                        "Using connection " + thisConnection +
                        " from connection pool&amp;ltp&gt;");

            stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("select sysdate from dual");

            while (rset.next()) {
                out.println("Time queried from the Database is " + rset.getString(1));
            }
        }
        catch (SQLException e1) {
	        out.println("&amp;lti&gt;&amp;ltb&gt;Error code:&lt;/b&gt; " + e1 + "&lt;/i&gt;");
			}
			finally {
						try{if(stmt != null) {stmt.close();}} catch(SQLException e1){};

						// The connection is returned to the Broker
							myBroker.freeConnection(conn);
				  }

        out.close();
        response.getOutputStream().close();
    }

    public void destroy ()
    {
        myBroker.destroy();
        super.destroy();
    }

}
