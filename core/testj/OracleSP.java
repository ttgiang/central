import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import oracle.jdbc.driver.*;
import java.util.Calendar;
import java.util.Vector;
import java.util.Iterator;

public class OracleSP {

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
	public OracleSP(String host, String db, String user, String password)
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

	private Vector getCampusQuestions()
		throws SQLException {

		String sql = "{ call ASE_REFCursors.GetCampusQuestions(?,?) }";
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

		System.out.println("GetCampusQuestions...");

		return vector;
	}

	/**
	*  cancelProposedCourse
	*/
	private void cancelProposedCourse()
		throws SQLException {

		String query = "{ call sp_CancelProposedCourse(?,?,?,?,?) }";
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

		System.out.println("cancelProposedCourse...");
	}

	/**
	*  setCourseForApproval
	*/
	private void setCourseForApproval()
		throws SQLException {

		String query = "{ call sp_SetCourseForApproval(?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setDate(4, java.sql.Date.valueOf( "2010-01-31" ));
		stmt.executeQuery();

		stmt.close();

		System.out.println("SetCourseForApproval...");
	}

	/**
	*  moveCurrentToArchived
	*/
	private void moveCurrentToArchived()
		throws SQLException {

		String query = "{ call sp_MoveCurrentToArchived(?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setString(4, "THANHG");
		stmt.executeQuery();

		stmt.close();

		System.out.println("moveCurrentToArchived...");
	}

	/**
	*  endReviewerTask
	*/
	private void endReviewerTask()
		throws SQLException {

		String query = "{ call sp_EndReviewerTask(?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setString(4, "THANHG");
		stmt.executeQuery();

		stmt.close();

		System.out.println("endReviewerTask...");
	}

	/**
	*  endReviewerTask
	*/
	private void approveOutline()
		throws SQLException {

		String query = "{ call sp_ApproveOutline(?,?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setString(4, "THANHG");
		stmt.setDate(5, java.sql.Date.valueOf( "2010-01-31" ));
		stmt.executeQuery();

		stmt.close();

		System.out.println("approveOutline...");
	}

	/**
	*  modifyApprovedOutline
	*/
	private void modifyApprovedOutline()
		throws SQLException {

		String query = "{ call sp_ModifyApprovedOutline(?,?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "LEECC");
		stmt.setString(4, "THANHG");
		stmt.setString(5, "HISTORY_ID");
		stmt.executeQuery();

		stmt.close();

		System.out.println("modifyApprovedOutline...");
	}

	/**
	*  copyCourseOutline
	*/
	private void copyCourseOutline()
		throws SQLException {

		String query = "{ call sp_CopyCourseOutline(?,?,?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "ICS");
		stmt.setString(4, "212");
		stmt.setString(5, "LEECC");
		stmt.setString(6, "THANHG");
		stmt.executeQuery();

		stmt.close();

		System.out.println("copyCourseOutline...");
	}

	/**
	*  renameCourseOutline
	*/
	private void renameCourseOutline()
		throws SQLException {

		String query = "{ call sp_RenameCourseOutline(?,?,?,?,?) }";
		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1, "ICS");
		stmt.setString(2, "218");
		stmt.setString(3, "ICS");
		stmt.setString(4, "212");
		stmt.setString(5, "LEECC");
		stmt.executeQuery();

		stmt.close();

		System.out.println("renameCourseOutline...");
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
		System.out.println("java com.enterprisedt.demo.oracle.OracleSP " +
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
			OracleSP cursor = new OracleSP(host, db, user, password);
			Vector vector = cursor.getCampusQuestions();

			//if ( vector != null ){
			//	for (Enumeration e = vector.elements(); e.hasMoreElements();){
			//		String myString = (String) e.nextElement();
			//		System.out.println(myString);
			//	}
			//}

			cursor.cancelProposedCourse();
			cursor.setCourseForApproval();
			cursor.moveCurrentToArchived();
			cursor.endReviewerTask();
			cursor.approveOutline();
			cursor.modifyApprovedOutline();
			cursor.copyCourseOutline();
			cursor.renameCourseOutline();

			cursor.cleanup();
		}
		catch (ClassNotFoundException ex) {
			System.out.println("Demo failed");
		}
		catch (SQLException ex) {
			System.out.println("Demo failed: " + ex.getMessage());
		}
	}
}

