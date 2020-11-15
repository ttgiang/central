<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.io.BufferedWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileWriter"%>

<%!

	/*
	 * sampleData
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static void sampleData(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		try {
			int counter = 0;
			int type = 0;
			int thanh = 0;
			String fndtype = "";
			PreparedStatement ps = null;

			String sql = "delete from tblfnd";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();

			sql = "delete from tblfnddata";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();

			sql = "SELECT historyid, campus, CourseAlpha, CourseNum, proposer FROM tblCourse WHERE (CourseType = 'CUR') ORDER BY campus, CourseAlpha, CourseNum";

			//sql = "SELECT historyid, campus, CourseAlpha, CourseNum, proposer FROM tblCourse WHERE (CourseType = 'CUR' and historyid = 'a51h22j111881227') ORDER BY campus, CourseAlpha, CourseNum";

			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				++counter;

				//
				// create a sample record for every xx we find in course
				//
				if(counter % 25 == 0){
					++type;
					if(type==1){
						fndtype = "FG";
					}
					else if(type==2){
						fndtype = "FS";
					}
					else if(type==3){
						fndtype = "FW";
						type = 0;
					}

					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					String alpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
					String num = AseUtil.nullToBlank(rs.getString("CourseNum"));
					String proposer = AseUtil.nullToBlank(rs.getString("proposer"));

					if(!proposer.equals("")){
						//
						// fake data for me to work with
						//
						++thanh;
						if(thanh % 10 == 0){
							proposer = "THANHG";
						}

						String fakeKix = "FND" + type + thanh + campus + fndtype;

						int id = createSampleFoundationCourse(conn,campus,proposer,kix,fndtype,proposer,fakeKix);

						//System.out.println(id + " - " + campus + " - " + fndtype);
					}

				}

			} // while
			rs.close();
			ps.close();


		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		}

	}

	/*
	 * createFoundationCourse
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	kix			String
	 * @param	foundation	String
	 * @param	authors		String
	 * <p>
	 * @return 	int
	 */
	public static int createSampleFoundationCourse(Connection conn,String campus,String user,String kix,String foundation,String authors,String fakeKix) throws Exception {

Logger logger = Logger.getLogger("test");

		int id = 0;
		int counter = 0;
		String sql = "";
		String junk = "";

		try {

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String coursetitle = info[Constant.KIX_COURSETITLE];

			String type = "PRE";

			if(!com.ase.aseutil.fnd.FndDB.isMatch(conn,campus,alpha,num,foundation,type)){

				String fndKix = fakeKix;

				AseUtil.logAction(conn, user, "ACTION","Foundation course created ("+ alpha + " " + num + ")",alpha,num,campus,fndKix);

				//
				// insert into main table (tlbfndf
				//
				sql = "INSERT INTO tblfnd(campus,historyid,fndtype,created,coursealpha,coursenum,coursedate,coursetitle,coursedescr,proposer,coproposer,auditby,auditdate,type,progress,edit,edit0,edit1,edit2) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,'','1','1')";
				PreparedStatement ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
				ps.setString(1,campus);
				ps.setString(2,fndKix);
				ps.setString(3,foundation);
				ps.setString(4,AseUtil.getCurrentDateTimeString());
				ps.setString(5,alpha);
				ps.setString(6,num);
				ps.setString(7,CourseDB.getCourseItem(conn,kix,"coursedate"));
				ps.setString(8,coursetitle);
				ps.setString(9,CourseDB.getCourseItem(conn,kix,"coursedescr"));
				ps.setString(10,user);
				ps.setString(11,authors);
				ps.setString(12,user);
				ps.setString(13,AseUtil.getCurrentDateTimeString());
				ps.setString(14,type);
				ps.setString(15,"MODIFY");
				ps.executeUpdate();

				//
				// get the id just added for use here
				//
				ResultSet rs = null;
				try{
					rs = ps.getGeneratedKeys();
					if(rs.next()){
						id = rs.getInt(1);
					}
					rs.close();
					ps.close();
				} catch (Exception e){
					logger.fatal("FndDB.createFoundationCourse - " + e.toString());
					rs.close();
					ps.close();
				}

				//
				// use created key to insert into data table (fnddata)
				//
				if(id > 0){
					sql = "SELECT fld, en, qn FROM tblfnditems where type=? order by seq, en, qn";
					ps = conn.prepareStatement(sql);
					ps.setString(1,foundation);
					rs = ps.executeQuery();
					while (rs.next()) {
						String fld = AseUtil.nullToBlank(rs.getString("fld"));
						int en = rs.getInt("en");
						int qn = rs.getInt("qn");
						String data = "";

						if(en == 1 && qn == 0){
							data = CourseDB.getCourseItem(conn,kix,"coursedescr");
							counter = 1;
						}

						sql = "insert into tblfnddata (id,fld,data) values(?,?,?);";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setInt(1,id);
						ps2.setString(2,fld);
						ps2.setString(3,data);
						ps2.executeUpdate();
						ps2.close();

					} // while
					rs.close();
					ps.close();

					//
					//
					//
					int rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															Constant.FND_CREATE_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.TASK_PROPOSER,
															Constant.TASK_PROPOSER,
															fndKix,
															Constant.FOUNDATION,
															"NEW");

					//
					// update foundation outline
					//
					com.ase.aseutil.fnd.FndDB.updateFndOutline(conn,fndKix,campus,alpha,num,type);

				} // valid id

			} // not match


		} catch (SQLException e) {
			logger.fatal("FndDB.createFoundationCourse - " + kix + "\n" + sql + "\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.createFoundationCourse - " + kix + "\n" + sql + "\n" + e.toString());
		}

		return id;

	}

	/*
	 * testData
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static void testData01(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		try {

			String sql = "SELECT fld FROM tblfnditems where type='FG' order by seq, en, qn";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String fld = AseUtil.nullToBlank(rs.getString("fld"));

				sql = "insert into tblfnddata (id,fld,data) values(?,?,?);";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,1);
				ps2.setString(2,fld);
				ps2.setString(3,fld);
				ps2.executeUpdate();
				ps2.close();

			} // while
			rs.close();
			ps.close();


		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		}

	}

	/*
	 * testData
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static void testData02(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		try {

			//
			// fill fnd and fnddata with empty rows with proper keys
			//

			int i = 0;
			String foundation = "";

			String sql = "SELECT campus, proposer, historyid from tblcourse where coursetype='CUR' AND (NOT (coursedate IS NULL)) AND  (NOT (effectiveterm IS NULL)) AND (effectiveterm > '')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				try{

					++i;

					if(i == 1){
						foundation = "FG";
					}
					else if(i == 2){
						foundation = "FS";
					}
					else if(i == 3){
						foundation = "FW";

						i = 0;
					}

					//com.ase.aseutil.fnd.FndDB.createFoundationCourse(conn,campus,proposer,kix,foundation,"");

				} catch (Exception e) {
					logger.fatal("FndDB.getFoundations - " + e.toString());
				}

			} // while
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		}

	}

	/*
	 * testData
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static void testData03(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		try {

			//
			// fill fnddata with fake data
			//

			int i = 0;

			String sql = "select seq from tblfnddata where id > 1 order by id, seq";
			PreparedStatement ps2 = conn.prepareStatement(sql);
			ResultSet rs2 = ps2.executeQuery();

			sql = "select comments from customer_comments";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String comments = AseUtil.nullToBlank(rs.getString("comments"));

				if(rs2.next()){
					int seq = rs2.getInt("seq");

					sql = "update tblfnddata set data = ? where seq = ?";
					PreparedStatement ps3 = conn.prepareStatement(sql);
					ps3.setString(1,comments);
					ps3.setInt(2,seq);
					ps3.executeUpdate();
					ps3.close();

				}

			} // while
			rs.close();
			ps.close();

			rs2.close();
			ps2.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		}

	}

	// table finddata has id and fld as key

%>