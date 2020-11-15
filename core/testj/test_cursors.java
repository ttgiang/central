import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import oracle.jdbc.driver.*;
import java.util.Calendar;
import java.util.Vector;
import java.util.Iterator;

public class Cursors {

	/**
	*  Class name of Oracle JDBC driver
	*/
	private String driver = "oracle.jdbc.driver.OracleDriver";

	/**
	*  Initial url fragment
	*/
	private String url = "jdbc:oracle:thin:@";


	/**
	*  Standard Oracle listener port
	*/
	private String port = "1521";

	/**
	*  Connection to database
	*/
	private Connection conn = null;


	/**
	*  Constructor. Loads the JDBC driver and establishes a connection
	*
	*  @param  host        the host the db is on
	*  @param  db          the database name
	*  @param  user        user's name
	*  @param  password    user's password
	*/
	public Cursors(String host, String db, String user, String password)
		throws ClassNotFoundException, SQLException {

		// construct the url
		url = url + host + ":" + port + ":" + db;

		// load the Oracle driver and establish a connection
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		}
		catch (ClassNotFoundException ex) {
			System.out.println("Failed to find driver class: " + driver);
			throw ex;
		}
		catch (SQLException ex) {
			System.out.println("Failed to establish a connection to: " + url);
			throw ex;
		}
	}

	private Vector execute()
		throws SQLException {

		String sql = "{ call ASE_REFCURSORS.GetCampusQuestions(?,?) }";
		System.out.println("sql: " + sql + "\n");
		CallableStatement stmt = conn.prepareCall(sql);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, "LEECC");
		stmt.executeQuery();

		Vector vector = new Vector();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		while ( rs.next() ){
			vector.addElement(new String (rs.getString(2)));
		}

		rs.close();
		stmt.close();

		return vector;
	}

	private void execute1()
		throws SQLException {

		String query = "{ call sp_CancelProposedCourse(?,?,?,?,?) }";
		System.out.println("Query: " + query + "\n");
		conn.setAutoCommit(false);
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setDate(4, java.sql.Date.valueOf( "2010-01-31" ));
		stmt.setString(5, "THANHG");
		stmt.executeQuery();
		stmt.close();
		conn.commit();
		conn.close();
	}

	/**
	*  Cleanup the connection
	*/
	private void cleanup() throws SQLException {
		if (conn != null)
			conn.close();
	}

	/**
	*  Prints usage statement on stdout
	*/
	static private void usage() {
		System.out.println("java com.enterprisedt.demo.oracle.Cursors " +
			" host db user password price");
	}

	/**
	*  Runs the class
	*/
	public static void main(String[] args) throws Exception {
		try {
			// assign the args to sensible variables for clarity
			String host = "127.0.0.1";
			String db = "xe";
			String user = "central";
			String password = "tr1gger";

			// and execute the stored proc
			Cursors jdbc = new Cursors(host, db, user, password);
			Vector vector = jdbc.execute();

			if ( vector != null ){
				for (Enumeration e = vector.elements(); e.hasMoreElements();){
					String myString = (String) e.nextElement();
					System.out.println(myString);
				}
			}

			jdbc.cleanup();
		}
		catch (ClassNotFoundException ex) {
			System.out.println("Demo failed");
		}
		catch (SQLException ex) {
			System.out.println("Demo failed: " + ex.getMessage());
		}
	}
}

