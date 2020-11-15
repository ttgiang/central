import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This class tests the environment to check if JDBC is configured and
 * connection to database is possible thru JDBC. Uses THIN driver to connect.
 *
 * @author Elangovan
 * @version 1.0
 */
public class JDBCCheck {

	public JDBCCheck(){}

	private Connection conn = null;

	private final int NO_DRIVER           = 1;
	private final int INVALID_URL         = 17002;
	private final int INVALID_CREDENTIALS = 1017;
	private final int NULL_URL            = 2;
	private final int DATABASE_DOWN       = 1034;

	public static void main(String[] args)  {
		JDBCCheck check = new JDBCCheck();
		check.dbconnect();
	}

	public void dbconnect(){
		if(loadDriver())
			if(connect())
				doSomething();
	}

	public boolean loadDriver(){

		boolean loadeddriver = false;
		String jdbcDriver = System.getProperty("jdbc.driver.class");

		// Use Oracle driver if nothing is set
		if(jdbcDriver == null) jdbcDriver = "oracle.jdbc.driver.OracleDriver";

		log("Loading JDBC Driver : class="+jdbcDriver+" ...");

		// try to load driver
		try  {
			Class.forName(jdbcDriver);
			log("Loaded JDBC Driver ");
			loadeddriver = true;
		} catch (ClassNotFoundException noclassEx)     {
			error(NO_DRIVER,noclassEx);
		}

		return loadeddriver;
	}

	public boolean connect(){

		boolean connected = false;
		String jdbcURL = System.getProperty("jdbc.url");
		String username = System.getProperty("jdbc.username");
		String password = System.getProperty("jdbc.password");

		if(username == null || password== null) {
			username = "central";
			password = "tr1gger";
		}

		if(jdbcURL == null) {
			jdbcURL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
		}

		if(jdbcURL == null)
			error(NULL_URL,new Exception(" jdbc.url cannot be null "));

		log("Connecting with URL="+jdbcURL+" as "+username+"/"+password);

		try {
			conn = DriverManager.getConnection(jdbcURL,username,password);
			log("Connected to Database");
			connected = true;
		} catch (SQLException sqlEx){
			error(sqlEx.getErrorCode(),sqlEx);
		}

		return connected;
	}

	public void doSomething()   {

		Statement stmt = null;
		ResultSet rset = null;
		try {
			stmt = conn.createStatement();
			log("Created Statement object");

			rset = stmt.executeQuery(" SELECT 'PASSED' FROM Dual ");
			log("Retrieved ResultSet object");

			if(rset.next())
				log("Connection :"+rset.getString(1));
		} catch (SQLException sqlEx){
		} finally{
			try {
				log("Closing Statment & ResultSet Objects");

				if (rset != null)
					rset.close();

				if (stmt != null)
					stmt.close();

				if (conn != null) {
					log("Disconnecting...");
					conn.close();
					log("Disconnected from Database");
				}
			} catch (Exception e){ }
		}
	}

	public void log(String logMsg)   {
		System.out.println("Log: "+logMsg);
	}

	public void error(int errcode, Exception ex){

		String jversion = System.getProperty("java.version").substring(0,3);
		String os = System.getProperty("os.name");
		String excp = ex.toString();

		// Driver not found in classpath
		if(errcode == NO_DRIVER){
			String jarname = "classes12.jar";
			String nlsjarname = "nls_charset12.jar";
			if(jversion.equals("1.1")) {
				jarname = "classes111.jar";
				nlsjarname = "nls_charset11.jar";
			}
			else
				if(jversion.equals("1.4"))
					jarname = "ojdbc14.jar";

			System.out.println(" Error: JDBC Drivers not present in CLASSPATH ");
			System.out.println("\n Your CLASSPATH is :"+
			System.getProperty("java.class.path"));
			System.out.println("\n To add Oracle JDBC Drivers to CLASSPATH ");

			// Windows
			if(os.indexOf("Windows") != -1)    {
				System.out.println(" >set CLASSPATH=<path-to-"+jarname+">;<path-to-"+
				nlsjarname+">;%CLASSPATH%;");
			} else   {
				System.out.println(" $CLASSPATH=<path-to-"+jarname+">:<path-to-"+
				nlsjarname+">:$CLASSPATH:");
				System.out.println(" $export CLASSPATH");
			}

			System.out.println(" Oracle JDBC Drivers can be found in "+
			"<ORACLE_HOME>/jdbc/lib directory or "+
			"downloaded from http://otn.oracle.com/software/");
		} else if (errcode == NULL_URL)  {
			System.out.println("Error: jdbc.url was not supplied");
			System.out.println("Usage: java -Djdbc.url=jdbc:oracle:thin:@<hostname>:<port>:<db_sid> JDBCCheck ");
		} else if (errcode == INVALID_URL) {
			// Check if Invalid Database SID
			if( excp.indexOf("ERR=12505") != -1)
				System.out.println("Error: Invalid Database SID was specified in jdbc.url ");
				System.out.println("Error: Invalid JDBC URL or DB Listener is down, refer " +
					"to http://myjdbc.tripod.com/basic/jdbcurl.html ");
		} else if (errcode == INVALID_CREDENTIALS) {
			System.out.println("Error: Invalid username/password was specified ");
			System.out.println("Try connecting to the database thru SQL Plus "+
				"using the same username/password");
		} else if (errcode == DATABASE_DOWN )     {
			System.out.println("Error: The Database you are tying to Connect is down ");
			System.out.println(" Start the Database and then try to connect ");
		} else {
			System.out.println("Error code not handled : "+errcode);
		}
			System.out.println("\nException Message :"+excp);
			System.exit(0);
	}
}