<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String campus = "LEE";
	String alpha = "ACC";
	String num = "201";
	String user = "THANHG";
	String type = "CUR";
	int rowsAffected = 0;

	String kix = helper.getKix(conn,campus,alpha,num,type);
	msg = viewOutline(conn,kix,Constant.COURSETYPE_CUR);
	out.println(msg);

	asePool.freeConnection(conn);
%>

<%!

	/*
	 * viewOutline
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String 		kix
	 *	@param	int			section
	 *	<p>
	 * @return Msg
	 */
	public static Msg viewOutline(Connection conn,String kix,int section) throws Exception {

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";
		String hid = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
		hid = info[5];

		Logger logger = Logger.getLogger("test");

		logger.info("----------------------------------- viewOutline starts");
		logger.info("alpha: " + alpha);
		logger.info("num: " + num);
		logger.info("campus: " + campus);
		logger.info("hid: " + hid);

		StringBuffer contents = new StringBuffer();			// contents of print template

		String line = "";												// input line
		String question = "";										// item question
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";

		AseUtil aseUtil = new AseUtil();

		String[] aFieldNames = null;
		java.util.Hashtable rsHash = null;

		String explainSQL = "";

		Msg msg = new Msg();
		int i = 0;

		boolean newOutline = !CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");

		try {
			// use buffering, reading one line at a time
			// FileReader always assumes default encoding is OK!
			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);
			String templateName = currentDrive + ":\\tomcat\\webapps\\central\\core\\templates\\" + campus + "_outline.tpl";

			if ("LEE".equals(campus)){
				if (newOutline)
					templateName = currentDrive + ":\\tomcat\\webapps\\central\\core\\templates\\" + campus + "_outline_new.tpl";
				else
					templateName = currentDrive + ":\\tomcat\\webapps\\central\\core\\templates\\" + campus + "_outline_old.tpl";
			}

			File aFile = new File(templateName);
			BufferedReader input = new BufferedReader(new FileReader(aFile));

			try {
				/*
				 * readLine is a bit quirky : it returns the content of a line
				 * MINUS the newline. it returns null only for the END of the
				 * stream. it returns an empty String if two newlines appear in
				 * a row.
				 */
				while ((line = input.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}

				/*
					with template read in, go through and replace holders with data
				*/
				if (contents != null){

					explainSQL = "campus=" + aseUtil.toSQL(campus,1) +
							" AND coursealpha=" + aseUtil.toSQL(alpha,1) +
							" AND coursenum=" + aseUtil.toSQL(num,1) +
							" AND coursetype=" + aseUtil.toSQL(type,1);

					line = contents.toString();

					switch (section) {
						case Constant.COURSETYPE_ARC:
							table = "tblCourseARC";
							break;
						case Constant.COURSETYPE_CAN:
							table = "tblCourseCAN";
							break;
						case Constant.COURSETYPE_CUR:
						case Constant.COURSETYPE_PRE:
							if (newOutline){
								temp = CourseDB.getFieldsForNewOutlines(conn,campus);
							}
							break;
					} // switch

					sql = "SELECT * FROM " + table + " WHERE historyid=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,hid);
					ResultSet rs = ps.executeQuery();
					if (rs.next()){
						rsHash = new java.util.Hashtable();
						aFieldNames = aseUtil.getFieldNames(rs);
						aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
						for (i=0; i<aFieldNames.length; i++) {
							temp = aseUtil.nullToBlank(rs.getString(aFieldNames[i]));
							if (aFieldNames[i].indexOf("date") > -1) {
								temp = aseUtil.ASE_FormatDateTime(temp, 6);
							} else if ("crosslisted".equals(aFieldNames[i])) {
								if ("1".equals(temp))	temp = ""; 		else temp = "NO";
								temp = temp + "<br/>" + CourseDB.getCrossListing(conn,campus,alpha,num);
							} else if ("excluefromcatalog".equals(aFieldNames[i])) {
								if ("1".equals(temp))	temp = "YES";	else	temp = "NO";
							} else if ("effectiveterm".equals(aFieldNames[i]) && temp != null && temp.length() > 0) {
								temp = TermsDB.getTermDescription(conn, temp);
							} else if ("repeatable".equals(aFieldNames[i])) {
								if ("1".equals(temp))
									temp = "YES";
								else
									temp = "NO";
							} else if ("gradingoptions".equals(aFieldNames[i])) {
								temp = IniDB.getIniByCategory(conn,campus,"Grading",temp,true);
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c16", explainSQL);
							} else if ("X15".equals(aFieldNames[i])) {
								temp = temp + "<br/>" + CourseDB.getRequisites(conn,campus,alpha,num,type,1,hid);
							} else if ("X16".equals(aFieldNames[i])) {
								temp = temp + "<br/>" + CourseDB.getRequisites(conn,campus,alpha,num,type,2,hid);
							} else if ("X18".equals(aFieldNames[i])) {
								temp = temp + "<br/>" + CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,hid,true);
							} else if ("X19".equals(aFieldNames[i])) {
								temp = temp + "<br/>" + CourseDB.getCourseContent(conn,campus,alpha,num,type,hid);
							} else if ("X23".equals(aFieldNames[i])) {
								temp = IniDB.getIniByCategory(conn,campus,"MethodEval",temp,true);
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c11", explainSQL);
							} else if ("X24".equals(aFieldNames[i])) {
								temp = IniDB.getIniByCategory(conn,campus,"MethodInst",temp,true);
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c10", explainSQL);
							} else if ("X56".equals(aFieldNames[i])) {
								temp = IniDB.getIniByCategory(conn,campus,"Expectations",temp,true);
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c12", explainSQL);
							} else if ("X65".equals(aFieldNames[i])) {
								if ("1".equals(temp))	temp = ""; 		else temp = "NO";
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c13", explainSQL);
							} else if ("X66".equals(aFieldNames[i])) {
								if ("1".equals(temp))	temp = ""; 		else temp = "NO";
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c14", explainSQL);
							} else if ("X67".equals(aFieldNames[i])) {
								if ("1".equals(temp))	temp = ""; 		else temp = "NO";
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c15", explainSQL);
							} else if ("X68".equals(aFieldNames[i])) {
								temp = IniDB.getIniByCategory(conn,campus,"MethodDelivery",temp,true);
								temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData","c17", explainSQL);
							}

							question = aseUtil.lookUp(conn, "vw_CourseReportItems", "question", "field_name = '" + aFieldNames[i] + "'" );
							line = line.replace("@Q@"+aFieldNames[i],question);
							line = line.replace("@A@"+aFieldNames[i],temp);
						}

					}	// if
					rs.close();
					ps.close();

					sql = "SELECT * FROM tblCampusData WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,hid);
					rs = ps.executeQuery();
					if (rs.next()){
						rsHash = new java.util.Hashtable();
						aFieldNames = aseUtil.getFieldNames(rs);
						aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
						for (i=0; i<aFieldNames.length; i++) {
							question = aseUtil.lookUp(conn, "vw_CampusReportItems", "question", "field_name = '" + aFieldNames[i] + "'" );
							line = line.replace("@Q@"+aFieldNames[i],question);
							line = line.replace("@A@"+aFieldNames[i],aseUtil.nullToBlank(rs.getString(aFieldNames[i])));
						}
					}
					rs.close();
					ps.close();

					msg.setErrorLog(line);
				}

			} finally {
				input.close();
			}
		} catch (IOException ex) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: viewOutline\n" + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: viewOutline\n" + e.toString());
		}

		logger.info("----------------------------------- viewOutline ends");

		return msg;
	} // viewOutline

%>
