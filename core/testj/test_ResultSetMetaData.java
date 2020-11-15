import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import oracle.jdbc.driver.*;
import java.util.Calendar;
import java.util.Vector;
import java.util.Iterator;

public class test {

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
	public test(String host, String db, String user, String password)
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

	private void execute() throws SQLException {

		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM tblCourse");
		ResultSetMetaData rsMetaData = rs.getMetaData();

		int numberOfColumns = rsMetaData.getColumnCount();
		System.out.println("resultSet MetaData column Count=" + numberOfColumns);

		for (int i = 1; i <= numberOfColumns; i++) {
			System.out.println("column MetaData");
			System.out.println("---------------");
			System.out.println("column number: " + i);

			// indicates the designated column's normal maximum width in characters
			System.out.println("getColumnDisplaySize: " + rsMetaData.getColumnDisplaySize(i));

			// gets the designated column's suggested title
			// for use in printouts and displays.
			System.out.println("getColumnLabel: " + rsMetaData.getColumnLabel(i));
			// get the designated column's name.
			System.out.println("getColumnName: " + rsMetaData.getColumnName(i));

			// get the designated column's SQL type.
			System.out.println("getColumnType: " + rsMetaData.getColumnType(i));

			// get the designated column's SQL type name.
			System.out.println("getColumnTypeName: " + rsMetaData.getColumnTypeName(i));

			// get the designated column's class name.
			System.out.println("getColumnClassName: " + rsMetaData.getColumnClassName(i));

			// get the designated column's table name.
			System.out.println("getTableName: " + rsMetaData.getTableName(i));

			// get the designated column's number of decimal digits.
			System.out.println("getPrecision: " + rsMetaData.getPrecision(i));

			// gets the designated column's number of
			// digits to right of the decimal point.
			System.out.println("getScale: " + rsMetaData.getScale(i));

			// indicates whether the designated column is
			// automatically numbered, thus read-only.
			System.out.println("isAutoIncrement: " + rsMetaData.isAutoIncrement(i));

			// indicates whether the designated column is a cash value.
			System.out.println("isCurrency: " + rsMetaData.isCurrency(i));

			// indicates whether a write on the designated
			// column will succeed.
			System.out.println("isWritable: " + rsMetaData.isWritable(i));

			// indicates whether a write on the designated
			// column will definitely succeed.
			System.out.println("isDefinitelyWritable: " + rsMetaData.isDefinitelyWritable(i));

			// indicates the nullability of values
			// in the designated column.
			System.out.println("isNullable: " + rsMetaData.isNullable(i));

			// Indicates whether the designated column
			// is definitely not writable.
			System.out.println("isReadOnly: " + rsMetaData.isReadOnly(i));

			// Indicates whether a column's case matters
			// in the designated column.
			System.out.println("isCaseSensitive: " + rsMetaData.isCaseSensitive(i));

			// Indicates whether a column's case matters
			// in the designated column.
			System.out.println("isSearchable: " + rsMetaData.isSearchable(i));

			// indicates whether values in the designated
			// column are signed numbers.
			System.out.println("isSigned: " + rsMetaData.isSigned(i));

			// Gets the designated column's table's catalog name.
			System.out.println("getCatalogName: " + rsMetaData.getCatalogName(i));

			// Gets the designated column's table's schema name.
			System.out.println("getSchemaName: " + rsMetaData.getSchemaName(i));
		}

		rs.close();
		stmt.close();
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
		System.out.println("java com.enterprisedt.demo.oracle.test " +
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
			test jdbc = new test(host, db, user, password);
			jdbc.execute();
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

