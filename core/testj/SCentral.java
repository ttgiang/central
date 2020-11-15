import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.JToolBar;
import javax.swing.text.Style;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyledDocument;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import java.io.*;

import com.javaexchange.dbConnectionBroker.*;
import com.ase.aseutil.*;

public class SCentral extends JFrame {

	private static String port = "1433";
	private static String driver = "net.sourceforge.jtds.jdbc.Driver";
	private static String url = "jdbc:jtds:sqlserver";
	private static String db = "ccv2";
	private static String user = null;
	private static String password = null;

	private static boolean debug = false;

	// only items needing adjustments
	private static String host = "d-2020-101385";

	private static String campuses = "'HIL','LEE','KAP'";

	private StyledDocument doc;
	private JTextPane textpane;

	/**
	*
	*
	**/
   public SCentral() {

        setTitle("Curriculum Central");

        JToolBar toolbar = new JToolBar();

        ImageIcon bold = new ImageIcon("bold.png");
        ImageIcon italic = new ImageIcon("italic.png");
        ImageIcon strike = new ImageIcon("strike.png");
        ImageIcon underline = new ImageIcon("underline.png");

        JButton boldb = new JButton(bold);
        JButton italb = new JButton(italic);
        JButton strib = new JButton(strike);
        JButton undeb = new JButton(underline);

        toolbar.add(boldb);
        toolbar.add(italb);
        toolbar.add(strib);
        toolbar.add(undeb);

        add(toolbar, BorderLayout.NORTH);

        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        JScrollPane pane = new JScrollPane();
        textpane = new JTextPane();
        textpane.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));

        doc = textpane.getStyledDocument();

        Style style = textpane.addStyle("Bold", null);
        StyleConstants.setBold(style, true);

        style = textpane.addStyle("Italic", null);
        StyleConstants.setItalic(style, true);

        style = textpane.addStyle("Underline", null);
        StyleConstants.setUnderline(style, true);

        style = textpane.addStyle("Strike", null);
        StyleConstants.setStrikeThrough(style, true);

        boldb.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doc.setCharacterAttributes(textpane.getSelectionStart(),
                    textpane.getSelectionEnd() - textpane.getSelectionStart(),
                    textpane.getStyle("Bold"), false);
            }
        });

        italb.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doc.setCharacterAttributes(textpane.getSelectionStart(),
                    textpane.getSelectionEnd() - textpane.getSelectionStart(),
                    textpane.getStyle("Italic"), false);
            }

        });

        strib.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doc.setCharacterAttributes(textpane.getSelectionStart(),
                    textpane.getSelectionEnd() - textpane.getSelectionStart(),
                    textpane.getStyle("Strike"), false);
            }

        });

        undeb.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doc.setCharacterAttributes(textpane.getSelectionStart(),
                    textpane.getSelectionEnd() - textpane.getSelectionStart(),
                    textpane.getStyle("Underline"), false);
            }
        });

        pane.getViewport().add(textpane);
        panel.add(pane);

        add(panel);

        setSize(new Dimension(380, 320));
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setVisible(true);
    }

	/**
	*
	*
	**/
	public static void main(String[] args) {
		new SCentral();
	}


	/**
	*
	*
	**/
	public void process() {

		try{

			int rows = 0;

			if (debug) System.out.println("START OF PROGRAM");

			Connection conn = createLongConnection();

			if (debug) System.out.println("got connection");

			if (conn != null){

				String sql = "SELECT count(historyid) "
								+ "FROM tblCourse "
								+ "WHERE campus IN ("+campuses+")";

				PreparedStatement ps = conn.prepareStatement(sql);

				ResultSet rs = ps.executeQuery();

				if (rs.next()){

					rows = rs.getInt(1);

					if (debug) System.out.println("number of rows: " + rows);
				} // if rs

				if (debug) System.out.println("closing resultset and statement");

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				createOutlines(conn,rows,null,null,null,null,"frce","");

			} // conn != null

			try{
				if (conn != null){

					if (debug) System.out.println("releasing connection");

					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				System.out.println(e.toString());
			} // try-catch for release of connection

			if (debug) System.out.println("END OF PROGRAM");

		} // main try
		catch(Exception e){
			System.out.println(e.toString());
		} // main catch

	}

	/**
	*
	*
	**/
	public void createOutlines(Connection conn,
													int rows,
													String campus,
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

      //Connection conn = null;

		String type = "CUR";
		String sql = "";
		String holdCampus = "";
		String documents = "";

		int rowsAffected = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		try {
			if (debug) System.out.println("-------------------- CREATEOUTLINES - START");

			//conn = AsePool.createLongConnection();

			if (conn != null){

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
							+ "AND (NOT auditdate IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "frce".equals(task)
					else if ("html".equals(task)){
						System.out.println("creating outlines: differential");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE campus IN ("+campuses+") "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "html".equals(task)
					else if ("htm".equals(task)){
						System.out.println("creating outlines: all");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND c.campus IN ("+campuses+") "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND c.auditdate >= h.html "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
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
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "idx".equals(task)

					System.out.println("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num "
							+ "FROM tbljobs "
							+ "WHERE campus IN ("+campuses+") "
							+ "ORDER BY campus,alpha, num";

					ps = conn.prepareStatement(sql);
				}
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
							System.out.println("processing outlines for: " + holdCampus);
						}

						output = new BufferedWriter(fstream);

						output.write(htmlHeader);

						output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>\n");

						output.write(CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type) + "</p>");

						try{
							msg = Outlines.viewOutline(conn,kix,"",compressed);

							output.write(msg.getErrorLog());

							Html.updateHtml(conn,Constant.COURSE,kix);

							if (rowsAffected % 100 == 0)
								System.out.println("outlines remaining: " + (rows - rowsAffected));
						}
						catch(Exception e){
							System.out.println("Tables: createOutlines - fail to create outline - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						}

						output.write(htmlFooter);
					}
					catch(Exception e){
						System.out.println("Tables: createOutlines - fail to open/create file - "
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

				//conn.close();
				//conn = null;

				if (debug) System.out.println("connection closed");

			} // if conn != null

			if (debug) System.out.println("-------------------- CREATEOUTLINES - END");

		} catch (Exception e) {
			System.out.println("Tables: createOutlines FAILED3 - "
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
				System.out.println("Tables: createOutlines - " + e.toString());
			}
		}

		return;
	}

	/*
	 * createLongConnection
	 */
	public Connection createLongConnection() {

		Connection conn = null;

		try{

			// do not combine as else to above if. this needs to executed regardless.
			if (host != null){

				if (user == null || password == null)
					getDBCredentials();

				if (debug) System.out.println("user: " + user);

				if (user != null && password != null){
					url = url + "://" + host + ":" + port + "/" + db;

					if (debug) System.out.println("url: " + url);

					Class.forName(driver);

					conn = DriverManager.getConnection(url,user,password);
				}
			} // host != null;
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
	private void getDBCredentials() {

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
	public void deleteJob(Connection conn,String jobName){

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

}