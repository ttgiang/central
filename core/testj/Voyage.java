import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import java.io.*;

import com.javaexchange.dbConnectionBroker.*;
import com.ase.aseutil.*;

import java.applet.Applet;
import java.awt.*;          // Imports Button, Canvas, TextArea, TextField
import java.awt.event.*;    // Imports ActionEvent, ActionListener

public class Voyage extends Applet {

	private static String port = "1433";
	private static String driver = "net.sourceforge.jtds.jdbc.Driver";
	private static String url = "jdbc:jtds:sqlserver";
	private static String db = "ccv2";
	private static String user = null;
	private static String password = null;

	private static boolean debug = true;

	private static String host = "talin";

	private static String type = "CUR";

	private static String kix = "";
	private static String campus = "";
	private static String alpha = "";
	private static String num = "";
	private static String task = "";

	private static String campuses = "'HIL','LEE','KAP'";

   TextField kixText		= new TextField(20);
   TextField alphaText	= new TextField(20);
   TextField numText		= new TextField(20);
   TextField hostText	= new TextField(20);
   TextField typeText	= new TextField(20);
   TextField taskText	= new TextField(20);
   TextField campusText	= new TextField(20);
   Button    start		= new Button("START!");
   static TextArea  progress		= new TextArea(
                    							"Click START to create HTML",
                           				60,
                                       60,
                                       TextArea.SCROLLBARS_NONE
                                       );

   public void init( ){

      addHorizontalLine(Color.orange);
      addNewLine( );

 		this.setLayout(new FlowLayout());

      add(hostText);
      add(new Label("Host"));
      addNewLine( );

      add(campusText);
      add(new Label("Campus"));
      addNewLine( );

      add(kixText);
      add(new Label("Kix"));
      addNewLine( );

      add(alphaText);
      add(new Label("Alpha"));
      addNewLine( );

      add(numText);
      add(new Label("num"));
      addNewLine( );

      add(typeText);
      add(new Label("Type"));
      addNewLine( );

      add(taskText);
      add(new Label("Task"));
      addNewLine( );

      add(start);
      addNewLine( );

      progress.setEditable(false);
      add(progress);
      addNewLine( );

      addHorizontalLine(Color.orange);

      start.addActionListener(new StartListener( ));
   }

   class StartListener implements ActionListener {

      public void actionPerformed(ActionEvent event) {

			host = hostText.getText();
			type = typeText.getText();
			kix = kixText.getText();
			campus = campusText.getText();
			alpha = alphaText.getText();
			num = numText.getText();
			task = taskText.getText();

			try{
				progress.append("");
				progress.append("\nstarting...");
				createOutlines(campus,kix,alpha,num,"frce","");
				progress.append("\nending...");
			}
			catch(Exception e){
				progress.append(e.toString());
			}
      }
   }

   private void addHorizontalLine(Color c) {
      // Add a Canvas 10000 pixels wide but only 1 pixel high, which acts as
      // a horizontal line to separate one group of components from the next.
      Canvas line = new Canvas( );
      line.setSize(10000,1);
      line.setBackground(c);
      add(line);
   }


   private void addNewLine( ) {
      // Add a horizontal line in the background color. The line itself is
      // invisible, but it serves to force the next Component onto a new line.
      addHorizontalLine(getBackground( ));
   }

	private void createOutlines(String campus,
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

				progress.append("got connection");

				String htmlHeader = Util.getResourceString("header.ase");
				String htmlFooter = Util.getResourceString("footer.ase");
				progress.append("obtained HTML template");

				documents = SysDB.getSys(conn,"documents");

				progress.append("obtained document folder");

				/*
					campus is null when running as a scheduled job (CreateOulinesJob.java).
					otherwise, campus is available for creation of a single outline
				*/
				if (campus == null){

					// prepare the table for process (delete jobs first)
					deleteJob(conn,"CreateOutlines");

					// tasks are htm or html. htm is for all outlines and html is differential from a certain date
					if ("frce".equals(task)){
						progress.append("creating outlines: force");

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
						progress.append("creating outlines: differential");

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
						progress.append("creating outlines: all");

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
						progress.append("creating outlines: index");

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

					progress.append("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num "
							+ "FROM tbljobs "
							+ "WHERE campus IN ("+campuses+") "
							+ "ORDER BY campus,alpha, num";
					ps = conn.prepareStatement(sql);
				} // campus = null
				else{

					progress.append("creating outline for " + campus + " - " + alpha + " - " + num);

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
							progress.append("\nprocessing outlines for: " + holdCampus);
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
								progress.append("" + rowsAffected + " of " + rows + " processed");
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
							progress.append("Central: createOutlines - fail to create outline - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						}

						output.write(htmlFooter);
					}
					catch(Exception e){
						progress.append("Central: createOutlines - fail to open/create file - "
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

				if (debug) progress.append("connection closed");

			} // if conn != null
			else{
				if (debug) progress.append("unable to obtain connection");
			}

		} catch (SQLException e) {
			progress.append("Central: createOutlines FAILED3 - "
					+ campus + " - " + kix  + " - " + alpha  + " - " + num
					+ "\n"
					+ e.toString());
		} catch (Exception e) {
			progress.append("Central: createOutlines FAILED3 - "
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
				progress.append("Central: createOutlines - " + e.toString());
			}
		}

		return;
	}

	/*
	 * createLongConnection
	 */
	private Connection createLongConnection() {

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
					if (debug) progress.append("missing creditials");

			} // host != null;
			else
				if (debug) progress.append("host is null");

		}
		catch(Exception e){
			progress.append("Central: createLongConnection - " + e.toString());
		}

		return conn;
	}

	/*
	 * getDBCredentials
	 *	<p>
	 *	@return String
	 */
	private void getDBCredentials() {

		if ("b6400".equals(host)){
			user = "ccusr";
			password = "c0mp1ex";
		}
		else if ("fih-05045".equals(host)){
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
	private void deleteJob(Connection conn,String jobName){

		try{
			if (debug) progress.append("JobsDB: deleteJob - START");

			if (conn != null){
				String sql = "DELETE FROM tblJobs WHERE job=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				ps.executeUpdate();
				ps.close();
			}
			else
				if (debug) progress.append("FAILED - " + jobName);

			if (debug) progress.append("JobsDB: deleteJob - END");
		}
		catch(SQLException se){
			progress.append("JobsDB: deleteJob - " + se.toString());
		}
		catch(Exception e){
			progress.append("JobsDB: deleteJob - " + e.toString());
		}

		return;
	}

	/**
	 * getDocumentCount
	 * <p>
	 */
	private int getDocumentCount(){

		int documentCount = 0;

		try{

			Connection conn = createLongConnection();

			if (conn != null){

				String sql = "SELECT count(historyid) "
								+ "FROM tblCourse "
								+ "WHERE campus IN ("+campuses+") "
								+ "AND (NOT historyid IS NULL) "
								+ "AND coursetype=? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,type);
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
				progress.append(e.toString());
			} // try-catch for release of connection


		} // main try
		catch(SQLException e){
			progress.append(e.toString());
		} // main catch
		catch(Exception e){
			progress.append(e.toString());
		} // main catch

		return documentCount;
	}

}

