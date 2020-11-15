import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import java.io.*;

import com.javaexchange.dbConnectionBroker.*;
import com.ase.aseutil.*;

/**
 *
 * @author talin
 * @version 1.0
 */
public class Central {

	public Central(){}

	private static String port = "1433";
	private static String driver = "net.sourceforge.jtds.jdbc.Driver";
	private static String url = "jdbc:jtds:sqlserver";
	private static String db = "ccv2";
	private static String user = null;
	private static String password = null;

	private static boolean debug = true;

	private static String host = "talin";

	private static String type = "CUR";

	private static String campuses = "'HIL','LEE','KAP'";

	public static void main(String[] args)  {

		try{

			String kix = null;
			String campus = null;
			String alpha = null;
			String num = null;

			if (args.length == 2){
				host 		= args[0];
				campuses = args[1];
				campuses = "'" + campuses.replace(",","','") + "'";
			}
			else if (args.length == 3){
				host 		= args[0];
				campuses = args[1];
				type 		= args[2];			// type
				campuses = "'" + campuses.replace(",","','") + "'";
			}
			else if (args.length == 6){
				host 		= args[0];			// host
				campus 	= args[1];			// campus
				kix 		= args[2];			// kix
				alpha 	= args[3];			// alpha
				num 		= args[4];			// num
				type 		= args[5];			// type
			}

			System.out.println("-------------------- START: " + AseUtil.getCurrentDateTimeString());

			//System.out.println("host: " + host);
			//System.out.println("campuses: " + campuses);
			//System.out.println("campus: " + campus);
			//System.out.println("kix: " + kix);
			//System.out.println("alpha: " + alpha);
			//System.out.println("num: " + num);
			//System.out.println("type: " + type);

			createOutlines(campus,kix,alpha,num,"frce","");

			System.out.println("-------------------- END: " + AseUtil.getCurrentDateTimeString());

		} // main try
		catch(Exception e){
			System.out.println(e.toString());
		} // main catch

	}

	public static void createOutlines(String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;

		Msg msg = null;

		boolean compressed = true;

		FileWriter fstream = null;
		BufferedWriter output = null;

      Connection conn = null;

		String sql = "";
		String holdCampus = "";
		String documents = "";

		int rowsAffected = 0;
		int rows = 0;
		int dots = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		try {
			conn = createLongConnection();

			if (conn != null){

				rows = getDocumentCount();

				System.out.println("got connection");

				String htmlHeader = Util.getResourceString("header.ase");
				String htmlFooter = Util.getResourceString("footer.ase");
				System.out.println("obtained HTML template");

				documents = SysDB.getSys(conn,"documents");

				System.out.println("obtained document folder");

				/*
					campus is null when running as a scheduled job (CreateOulinesJob.java).
					otherwise, campus is available for creation of a single outline
				*/
				if (campus == null){

					// prepare the table for process (delete jobs first)
					deleteJob(conn,"CreateOutlines");

					// tasks are htm or html. htm is for all outlines and html is differential from a certain date
					if ("frce".equals(task)){
						System.out.println("creating outlines: force");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE campus IN ("+campuses+") "
							+ "AND (NOT historyid IS NULL) "
							+ "AND coursetype=? "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "frce".equals(task)
					else if ("diff".equals(task)){
						System.out.println("creating outlines: differential");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE campus IN ("+campuses+") "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND coursetype=? "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "html".equals(task)
					else if ("all".equals(task)){
						System.out.println("creating outlines: all");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND c.campus IN ("+campuses+") "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND coursetype=? "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "htm".equals(task)
					else if ("idx".equals(task)){
						System.out.println("creating outlines: index");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblHtml h "
							+ "WHERE  c.historyid=h.historyid "
							+ "AND c.campus IN ("+campuses+") "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND coursetype=? "
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "idx".equals(task)

					System.out.println("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num "
							+ "FROM tbljobs "
							+ "WHERE campus IN ("+campuses+") "
							+ "ORDER BY campus,alpha, num";
					ps = conn.prepareStatement(sql);
				} // campus = null
				else{

					System.out.println("creating outline for " + campus + " - " + alpha + " - " + num);

					if (kix !=null && kix.length() > 0){
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num "
								+ "FROM tblCourse "
								+ "WHERE campus=? "
								+ "AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
					else{
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num "
								+ "FROM tblCourse "
								+ "WHERE campus=? "
								+ "AND coursealpha=? "
								+ "AND coursenum=? "
								+ "AND coursetype=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
					}
				}

				rowsAffected = 0;

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					alpha = AseUtil.nullToBlank(rs.getString("alpha"));
					num = AseUtil.nullToBlank(rs.getString("num"));

					++rowsAffected;

					try {
						fstream = new FileWriter(currentDrive
															+ ":"
															+ documents
															+ "outlines\\"
															+ campus
															+ "\\"
															+ kix
															+ ".html");

						// display log of campus being processed
						if (!campus.equals(holdCampus)){
							holdCampus = campus;
							System.out.println("\nprocessing outlines for: " + holdCampus);
						}

						output = new BufferedWriter(fstream);

						output.write(htmlHeader);

						output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>\n");

						output.write(CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type) + "</p>");

						try{
							msg = Outlines.viewOutline(conn,kix,"",compressed);

							output.write(msg.getErrorLog());

							Html.updateHtml(conn,Constant.COURSE,kix);

							if (rowsAffected % 10 == 0){
								System.out.print("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b");
								System.out.print("" + rowsAffected + " of " + rows + " processed");
							}

							/*
							if (++dots % 10 == 0){
								System.out.print("\b\b\b\b\b\b\b\b\b\b");
								System.out.print("          ");
								System.out.print("\b\b\b\b\b\b\b\b\b\b");
								dots = 0;
							}
							else{
								System.out.print(".");
							}
							*/

						}
						catch(Exception e){
							System.out.println("Central: createOutlines - fail to create outline - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						}

						output.write(htmlFooter);
					}
					catch(Exception e){
						System.out.println("Central: createOutlines - fail to open/create file - "
								+ campus + " - " + kix  + " - " + alpha  + " - " + num
								+ "\n"
								+ e.toString());
					} finally {
						output.close();
					}

					JobsDB.deleteJobByKix(conn,kix);

				} // while

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				if (debug) System.out.println("connection closed");

			} // if conn != null
			else{
				if (debug) System.out.println("unable to obtain connection");
			}

		} catch (SQLException e) {
			System.out.println("Central: createOutlines FAILED3 - "
					+ campus + " - " + kix  + " - " + alpha  + " - " + num
					+ "\n"
					+ e.toString());
		} catch (Exception e) {
			System.out.println("Central: createOutlines FAILED3 - "
					+ campus + " - " + kix  + " - " + alpha  + " - " + num
					+ "\n"
					+ e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				System.out.println("Central: createOutlines - " + e.toString());
			}
		}

		return;
	}

	/*
	 * createLongConnection
	 */
	public static Connection createLongConnection() {

		Connection conn = null;

		try{

			// do not combine as else to above if. this needs to executed regardless.
			if (host != null){

				if (user == null || password == null)
					getDBCredentials();

				if (user != null && password != null){

					url = url + "://" + host + ":" + port + "/" + db;

					Class.forName(driver);

					conn = DriverManager.getConnection(url,user,password);
				}
				else
					if (debug) System.out.println("missing creditials");

			} // host != null;
			else
				if (debug) System.out.println("host is null");

		}
		catch(Exception e){
			System.out.println("Central: createLongConnection - " + e.toString());
		}

		return conn;
	}

	/*
	 * getDBCredentials
	 *	<p>
	 *	@return String
	 */
	private static void getDBCredentials() {

		if ("b6400".equals(host)){
			user = "ccusr";
			password = "c0mp1ex";
		}
		else if ("d-2020-101385".equals(host)){
			user = "sa";
			password = "msde";
		}
		else if ("nalo".equals(host)){
			user = "sa";
			password = "c0mp1ex";
		}
		else if ("szhi03".equals(host)){
			user = "sa";
			password = "tr1gger";
		}
		else if ("talin".equals(host)){
			user = "sa";
			password = "tr1gger";
		}

		return;
	}

	/**
	 * deleteJob
	 * <p>
	 * @param	jobName	String
	 * <p>
	 */
	public static void deleteJob(Connection conn,String jobName){

		try{
			if (debug) System.out.println("JobsDB: deleteJob - START");

			if (conn != null){
				String sql = "DELETE FROM tblJobs WHERE job=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				ps.executeUpdate();
				ps.close();
			}
			else
				if (debug) System.out.println("FAILED - " + jobName);

			if (debug) System.out.println("JobsDB: deleteJob - END");
		}
		catch(SQLException se){
			System.out.println("JobsDB: deleteJob - " + se.toString());
		}
		catch(Exception e){
			System.out.println("JobsDB: deleteJob - " + e.toString());
		}

		return;
	}

	/**
	 * getDocumentCount
	 * <p>
	 */
	public static int getDocumentCount(){

		int documentCount = 0;

		try{

			Connection conn = createLongConnection();

			if (conn != null){

				String sql = "SELECT count(historyid) "
								+ "FROM tblCourse "
								+ "WHERE campus IN ("+campuses+")";

				PreparedStatement ps = conn.prepareStatement(sql);

				ResultSet rs = ps.executeQuery();

				if (rs.next()){

					documentCount = rs.getInt(1);

				} // if rs

				rs.close();
				rs = null;

				ps.close();
				ps = null;

			} // conn != null

			try{
				if (conn != null){

					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				System.out.println(e.toString());
			} // try-catch for release of connection


		} // main try
		catch(SQLException e){
			System.out.println(e.toString());
		} // main catch
		catch(Exception e){
			System.out.println(e.toString());
		} // main catch

		return documentCount;
	}

}