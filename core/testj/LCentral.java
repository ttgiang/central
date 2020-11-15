import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import java.io.*;

import com.javaexchange.dbConnectionBroker.*;
import com.ase.aseutil.*;

public class LCentral extends JFrame {

	private static DefaultListModel model;

	private JList list;

	private static JLabel label;

	private static String port = "1433";
	private static String driver = "net.sourceforge.jtds.jdbc.Driver";
	private static String url = "jdbc:jtds:sqlserver";
	private static String db = "ccv2";
	private static String user = null;
	private static String password = null;

	private static boolean debug = false;

	private static boolean killJob = false;

	// only items needing adjustments
	private static String host = "talin";

	private static String campuses = "'HIL','LEE','KAP'";
	//private static String campuses = "'WIN'";

	public LCentral() {

        setTitle("Curriculum Central");

        model = new DefaultListModel();
        //model.addElement("Schindler list");

        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));

        JPanel leftPanel = new JPanel();
        JPanel rightPanel = new JPanel();

        leftPanel.setLayout(new BorderLayout());
        rightPanel.setLayout(new BoxLayout(rightPanel, BoxLayout.Y_AXIS));

        list = new JList(model);
        list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        list.setBorder(BorderFactory.createEmptyBorder(2, 2, 2, 2));

        list.addMouseListener(new MouseAdapter() {

        public void mouseClicked(MouseEvent e) {
        	    if(e.getClickCount() == 2){
                  int index = list.locationToIndex(e.getPoint());
                  Object item = model.getElementAt(index);
                  String text = JOptionPane.showInputDialog("Rename item", item);
                  String newitem = null;
                  if (text != null)
                     newitem = text.trim();
                  else
                     return;

                  if (newitem != null) {
                    model.remove(index);
                    model.add(index, newitem);
                    ListSelectionModel selmodel = list.getSelectionModel();
                    selmodel.setLeadSelectionIndex(index);
                  }
                }
            }

        });

			JScrollPane pane = new JScrollPane();
			pane.getViewport().add(list);
			leftPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

			leftPanel.add(pane);

			JButton removeall = new JButton("Remove All");

			JButton add = new JButton("Add");
			add.setMaximumSize(removeall.getMaximumSize());

			JButton rename = new JButton("Rename");
			rename.setMaximumSize(removeall.getMaximumSize());

			JButton delete = new JButton("Delete");
			delete.setMaximumSize(removeall.getMaximumSize());

			JButton start = new JButton("Start");
			start.setMaximumSize(removeall.getMaximumSize());

			JButton stop = new JButton("stop");
			stop.setMaximumSize(removeall.getMaximumSize());

			label = new JLabel ("progress...", JLabel.CENTER);
			label.setMaximumSize(removeall.getMaximumSize());

			add.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					String text = JOptionPane.showInputDialog("Add a new item");
					String item = null;

					if (text != null)
						item = text.trim();
					else
						return;

					if (item != null)
						model.addElement(item);
				}
			});

			delete.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent event) {
					ListSelectionModel selmodel = list.getSelectionModel();
					int index = selmodel.getMinSelectionIndex();
					if (index >= 0)
					model.remove(index);
				}
			});

			rename.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					ListSelectionModel selmodel = list.getSelectionModel();
					int index = selmodel.getMinSelectionIndex();
					if (index == -1) return;
					Object item = model.getElementAt(index);
					String text = JOptionPane.showInputDialog("Rename item", item);
					String newitem = null;

					if (text != null) {
						newitem = text.trim();
					} else
						return;

					if (newitem != null) {
						model.remove(index);
						model.add(index, newitem);
					}
				}
			});

			removeall.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {

					model.clear();

				}
			});

			start.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {

					killJob = false;

					process();
				}
			});

			stop.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					model.addElement("process aborted");

					model.addElement(AseUtil.getCurrentDateTimeString());

					killJob = true;
				}
			});

			rightPanel.add(add);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(rename);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(delete);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(removeall);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(start);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(stop);
			rightPanel.add(Box.createRigidArea(new Dimension(0,4)));

			rightPanel.add(label);
			rightPanel.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 20));

			panel.add(leftPanel);
			panel.add(rightPanel);

			add(panel);

			setSize(500, 500);

			setLocationRelativeTo(null);

			setDefaultCloseOperation(EXIT_ON_CLOSE);

			setVisible(true);
    }

	/**
	*
	*
	**/
	public static void main(String[] args) {

		new LCentral();

		model.addElement("");

		process();

	}

	/**
	*
	*
	**/
	public static void process() {

		try{

			model.addElement(AseUtil.getCurrentDateTimeString());

			model.addElement("START OF PROGRAM");

			createOutlines(null,null,null,null,"frce","");

			model.addElement("END OF PROGRAM");

			model.addElement(AseUtil.getCurrentDateTimeString());

		} // main try
		catch(Exception e){
			model.addElement(e.toString());
		} // main catch

	}

	/**
	*
	*
	**/
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

      //Connection conn = null;

		String type = "CUR";
		String sql = "";
		String holdCampus = "";
		String documents = "";

		int rowsAffected = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		int rows = 0;

		Connection conn = null;

		try {
			model.addElement("-------------------- CREATEOUTLINES - START");

			conn = createLongConnection();

			if (conn != null){

				rows = getDocumentCount();

				model.addElement("got connection");

				String htmlHeader = Util.getResourceString("header.ase");
				String htmlFooter = Util.getResourceString("footer.ase");
				model.addElement("obtained HTML template");

				documents = SysDB.getSys(conn,"documents");

				model.addElement("obtained document folder");

				/*
					campus is null when running as a scheduled job (CreateOulinesJob.java).
					otherwise, campus is available for creation of a single outline
				*/
				if (campus == null){

					// prepare the table for process (delete jobs first)
					deleteJob(conn,"CreateOutlines");

					// tasks are htm or html. htm is for all outlines and html is differential from a certain date
					if ("frce".equals(task)){
						model.addElement("creating outlines: force");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE campus IN ("+campuses+") "
							+ "AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "frce".equals(task)
					else if ("diff".equals(task)){
						model.addElement("creating outlines: differential");

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
					else if ("all".equals(task)){
						model.addElement("creating outlines: all");

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND c.campus IN ("+campuses+") "
							+ "AND (NOT c.historyid IS NULL) "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // "htm".equals(task)
					else if ("idx".equals(task)){
						model.addElement("creating outlines: index");

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

					model.addElement("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num "
							+ "FROM tbljobs "
							+ "WHERE campus IN ("+campuses+") "
							+ "ORDER BY campus,alpha, num";

					ps = conn.prepareStatement(sql);
				}
				else{

					model.addElement("creating outline for " + campus + " - " + alpha + " - " + num);

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
				while (rs.next() && killJob == false) {
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
							model.addElement("processing outlines for: " + holdCampus);
						}

						output = new BufferedWriter(fstream);

						output.write(htmlHeader);

						output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>\n");

						output.write(CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type) + "</p>");

						try{
							msg = Outlines.viewOutline(conn,kix,"",compressed);

							output.write(msg.getErrorLog());

							Html.updateHtml(conn,Constant.COURSE,kix);

							if (rowsAffected % 100 == 0){
								label.setText("remaining... " + (rows - rowsAffected));
							}
						}
						catch(Exception e){
							model.addElement("Tables: createOutlines - fail to create outline - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						}

						output.write(htmlFooter);
					}
					catch(Exception e){
						model.addElement("Tables: createOutlines - fail to open/create file - "
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

				model.addElement("connection closed");

			} // if conn != null

			model.addElement("-------------------- CREATEOUTLINES - END");

		} catch (Exception e) {
			model.addElement("Tables: createOutlines FAILED3 - "
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
				model.addElement("Tables: createOutlines - " + e.toString());
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
			} // host != null;
		}
		catch(Exception e){
			model.addElement("Central: createLongConnection - " + e.toString());
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
	public  static void deleteJob(Connection conn,String jobName){

		try{
			model.addElement("JobsDB: deleteJob - START");

			if (conn != null){
				String sql = "DELETE FROM tblJobs WHERE job=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				ps.executeUpdate();
				ps.close();
			}
			else
				model.addElement("FAILED - " + jobName);

			model.addElement("JobsDB: deleteJob - END");
		}
		catch(SQLException se){
			model.addElement("JobsDB: deleteJob - " + se.toString());
		}
		catch(Exception e){
			model.addElement("JobsDB: deleteJob - " + e.toString());
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
				model.addElement(e.toString());
			} // try-catch for release of connection


		} // main try
		catch(SQLException e){
			model.addElement(e.toString());
		} // main catch
		catch(Exception e){
			model.addElement(e.toString());
		} // main catch

		return documentCount;
	}

}