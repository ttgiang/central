<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Data Conversion";
	fieldsetTitle = "Data Conversion";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	prod - use this to process any data adjustment in prod during upgrades
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAU";

	//
	// MAN = KRI; HAW = HTR
	//
	String historyCode = "SNG";

	System.out.println("Start<br/>");

	if (processPage){

		int opt = website.getRequestParameter(request,"opt",-1);

		// rerunning is OK
		boolean run = true;

		out.println("<ul>");
		out.println("<li>Prep");
		out.println("<ul>");
		out.println("<li>Campus code ("+campus+")</li>");
		out.println("<li>History Code ("+historyCode+")</li>");
		out.println("</ul>");
		out.println("</ul>");

		String[] spans = new String[201];
		for(int s=0; s<spans.length; s++){
			spans[s] = "";
		}
		if(opt>=0){
			spans[opt] = "highlights1";
		}

		String logImage = "<img src=\"../images/reviews2.gif\">";
		String configImage = "<img src=\"../images/config.gif\">";

		int idx = website.getRequestParameter(request,"idx",0);

		out.println("<li>Processing");
		out.println("<ul>");
		out.println("<li>"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;Reset Page</li>");
		out.println("<li><span class=\""+spans[97]+"\"><a href=\"../R97_cleanse.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=97\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R97 - Cleanse _bannermaster</span></li>");
		out.println("<li><span class=\""+spans[0]+"\">"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=0\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R00 - Clear course, campus, xref</span></li>");
		out.println("<li><span class=\""+spans[100]+"\">"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=100\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R100 - Insert course, campus data from Banner</span></li>");
		out.println("<li><span class=\""+spans[1]+"\"><a href=\"../R01_xlist.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=1\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R01 - Xlist</span></li>");
		out.println("<li><span class=\""+spans[3]+"\"><a href=\"../R03_catalog.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=3\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R03 - Catalog</span></li>");
		out.println("<li><span class=\""+spans[4]+"\"><a href=\"../R04_contacthours.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=4\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R04 - Contact Hours</span></li>");
		out.println("<li><span class=\""+spans[5]+"\"><a href=\"../R05_credits.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=5\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R05 - Credits</span></li>");
		out.println("<li><span class=\""+spans[6]+"\"><a href=\"../R06_repeatable.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=6\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R06 - Repeatable</span></li>");
		//out.println("<li><span class=\""+spans[9]+"\"><a href=\"../R09_attrcode.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=9\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R09 - Atribute Code</span></li>");
		out.println("<li><span class=\""+spans[14]+"\">"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=14\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R14 - Justifications</span></li>");
		out.println("<li><span class=\""+spans[90]+"\"><a href=\"../R90_coreqs.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=90\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R90 - CoReqs</span></li>");
		out.println("<li><span class=\""+spans[98]+"\"><a href=\"../R98_outlines.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=98\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R98 - Refresh Outlines</span></li>");
		out.println("<li><span class=\""+spans[99]+"\"><a href=\"../R99_html.txt\" target=\"_blank\">"+logImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"?opt=99\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R99 - Create Outlines</span></li>");
		//out.println("<li><span class=\""+spans[99]+"\">"+logImage+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"ccjobsX.jsp?j=CreateOutlines&job=3\" class=\"linkcolumn\">"+configImage+"</a>&nbsp;&nbsp;&nbsp;&nbsp;R99 - Create Outlines</span></li>");
		out.println("</ul>");
		out.println("</li>");
		out.println("<br>");

		out.println("<li>Reports");
		out.println("<ul>");
		out.println("<li><a href=\"?opt=200\" class=\"linkcolumn\">R200 - Banner Term Greater than CC</a></li>");
		out.println("</ul>");
		out.println("</li>");
		out.println("<br>");

		out.println("<li>Notes");
		out.println("<ul>");
		out.println("<li>R97 - Run only once to prepare original Banner data (OK to rerun)</a></li>");
		out.println("</ul>");
		out.println("</li>");
		out.println("<br>");

		out.println("</ul>");

		String result = "";

		spans = null;

		//
		// import
		//
		if(run){

			if(idx > 0){
				opt = 99;
			}

			switch(opt){

				case 0: result = R0_clear(conn,campus,historyCode); break;
				case 1: result = R1_R2_xlist(conn,campus); break;
				case 3: result = R3_catalog(conn,campus); break;
				case 4: result = R4_contactHours(conn,campus); break;
				case 5: result = R5_credits(conn,campus); break;
				case 6: result = R6_repeatable(conn,campus); break;

				case 9: result = R9_Attr_code(conn,campus); break;

				case 14: result = R14_Justifications(conn,campus); break;

				//
				// cc maintenance
				//

				case 90: result = R90_coreqs(conn,campus); break;

				//
				// this is where banner term course overlays cc term course
				//
				case 97: result = R97_cleanse(conn,campus,historyCode); break;

				case 98: result = R98_outlines(conn,campus,historyCode); break;

				case 99: result = R99_createHTML(campus,historyCode); break;

				case 100: result = R0_insert(conn,campus); break;

				case 200: result = R200_BannerTermGreaterThanCC(conn,campus); break;

			} // switch

			out.println("<span class=\"highlights1\">" + result + "</span>" + Html.BR());

		} // run

	} // process

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!
	/*
	 * R92_overlay
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R92_overlay(Connection conn,String campus,String historyCode){

		//
		// MUST change doIt to true to run this routine
		//
		// because courses from banner with matching CC alpha/num were deleted in R0_insert
		// this is no longer valid because there is no dup to overlay
		//

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int read = 0;
		int processed = 0;

		String bkix = "";
		String ckix = "";

		String alpha = "";
		String num = "";

		Writer out = null;

		ResultSet rs = null;

		String sql = "";

		String rtn = "";

		try{

			PreparedStatement ps = null;

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R92_overlay.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			//
			// make room before we start working
			//
			sql = "delete from _banner_overlay_cc";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nClearing _banner_overlay_cc - " + rowsAffected +" rows\n");

			sql = "delete from _banner_overlay_bn";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nClearing _banner_overlay_bn - " + rowsAffected +" rows\n");

			sql = "delete from _banner_overlay_combined";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nClearing _banner_overlay_combined - " + rowsAffected +" rows\n");

			//
			// insert data to get started -
			// _banner_overlay_cc are CC courses
			// _banner_overlay_bn are Banner courses
			// _banner_overlay_combined are courses where CC and BN are matching keys
			//
			sql = "insert INTO _banner_overlay_cc "
				+ "SELECT historyid as ckix, CourseAlpha, CourseNum, CourseType, Progress, effectiveterm as cterm "
				+ "FROM  tblCourse "
				+ "WHERE (campus = ?) AND (NOT (historyid LIKE '"+historyCode+"%'))";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nInsert to _banner_overlay_cc - " + rowsAffected +" rows\n");

			sql = "insert INTO _banner_overlay_bn "
				+ "SELECT historyid as bkix, CourseAlpha, CourseNum, CourseType, Progress, effectiveterm as bterm "
				+ "FROM tblCourse "
				+ "WHERE (campus = ?) AND (historyid LIKE '"+historyCode+"%')";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nInsert to _banner_overlay_bn - " + rowsAffected +" rows\n");

			sql = "insert into _banner_overlay_combined "
				+ "SELECT bkix, ckix, _banner_overlay_cc.CourseAlpha, _banner_overlay_cc.CourseNum, _banner_overlay_cc.CourseType, _banner_overlay_cc.Progress, cterm, bterm  "
				+ "FROM _banner_overlay_cc INNER JOIN "
				+ "_banner_overlay_bn ON _banner_overlay_cc.CourseAlpha = _banner_overlay_bn.CourseAlpha AND "
				+ "_banner_overlay_cc.CourseNum = _banner_overlay_bn.CourseNum ";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			out.write("\nInsert to _banner_overlay_combined - " + rowsAffected +" rows\n");

			//
			// remove course alpha and number to avoid ambiguous columns
			//
			String courseItems = CampusDB.getCourseItems(conn,campus);
			courseItems = courseItems.replace("coursealpha","").replace("coursenum","").replace(",,",",").replace(",,",",");
			String campusItems = CampusDB.getCampusItems(conn,campus);
			String combinedItems = courseItems + "," + campusItems;

			String[] crsItems = courseItems.split(",");
			String[] cpsItems = campusItems.split(",");
			String[] allItems = combinedItems.split(",");

			//
			// do not include for course alpha and number
			//
			String crsType = "s,s,s,s,s,s,s,s,s,i,s,s,s,s,s,s,s,s,s";
			String cpsType = "s,s,s,s,s";

			String[] courseDataType = crsType.split(",");
			String[] campusDataType = cpsType.split(",");
			String[] allDataType = (crsType+","+cpsType).split(",");

			//
			// copy
			//
			boolean goOn = false;
			boolean doIt = false;

			if(!doIt){

				rtn = "R92_overlay: " + 0 + " of " + 0 + " rows not processed";

			}
			else{

				//
				// loop through each course item and compare. if not matching, overlay
				//

				sql = "SELECT bkix, ckix, CourseAlpha as CRSE_SUBJ, CourseNum as CRSE_NUMBER, CourseType, Progress, cterm, bterm "
					+ "FROM _banner_overlay_combined WHERE bterm > cterm ORDER BY CourseAlpha, CourseNum ";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){

					++read;

					bkix = AseUtil.nullToBlank(rs.getString("bkix"));
					ckix = AseUtil.nullToBlank(rs.getString("ckix"));
					alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
					num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));

					out.write("------------------------\n");

					String[] ccOutline = null;
					String[] bnOutline = null;

					//
					// get course data
					//
					sql = "SELECT " + combinedItems + " FROM tblCourse AS c INNER JOIN tblCampusData AS cd ON c.historyid = cd.historyid WHERE c.campus=? AND c.historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,campus);
					ps2.setString(2,ckix);
					ResultSet rs2 = ps2.executeQuery();
					if(rs2.next()){
						ccOutline = SQLUtil.resultSetToArray(rs2,allDataType);
					}
					rs2.close();
					ps2.close();

					//
					// get the banner outline (kix)
					//
					sql = "SELECT " + combinedItems + " FROM tblCourse AS c INNER JOIN tblCampusData AS cd ON c.historyid = cd.historyid WHERE c.campus=? AND c.historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,campus);
					ps2.setString(2,bkix);
					rs2 = ps2.executeQuery();
					if(rs2.next()){
						bnOutline = SQLUtil.resultSetToArray(rs2,allDataType);
					}
					rs2.close();
					ps2.close();

					out.write("keys: " + bkix + "/" + ckix + " (" + alpha + " " +num + ")\n");

					//
					// do the compare and replace
					//
					boolean update = false;
					String crsSQL = "";
					String cpsSQL = "";

					//
					// this is effective term
					//
					int effectiveTerm = 0;
					for(int j = 0; j < allDataType.length; j++){
						if(allItems[j].toLowerCase().equals("effectiveterm")){
							effectiveTerm = j;
						}
					} // j

					crsSQL = allItems[effectiveTerm] + "='" + bnOutline[effectiveTerm] + "'";

					for(int i=0; i<allDataType.length; i++){

						if(bnOutline[i] != null){

							if (!bnOutline[i].equals(Constant.BLANK) && ccOutline[i].equals(Constant.BLANK)){

								out.write("item " + (i+1) + "\n\tBNR:" + ccOutline[i] + "\n\tCC: " + bnOutline[i] + "\n");

								ccOutline[i] = bnOutline[i];

								if(i < courseDataType.length){
									crsSQL += allItems[i] + "='" + bnOutline[i] + "'";
								}
								else{
									if(!cpsSQL.equals(Constant.BLANK)){
										cpsSQL += ",";
									}

									cpsSQL += allItems[i] + "='" + bnOutline[i] + "'";
								}

							} // not matching

						} // valid cc data

					} //  for

					//
					// always true because we have to update term
					//
					update = true;

					if(update){
						PreparedStatement ps3 = null;

						if(!crsSQL.equals(Constant.BLANK)){
							crsSQL = "update tblcourse set " + crsSQL + " where campus=? and historyid=?";
							out.write("\n" + crsSQL + "\n");
							ps3 = conn.prepareStatement(crsSQL);
							ps3.setString(1,campus);
							ps3.setString(2,ckix);
							rowsAffected = ps3.executeUpdate();
							ps3.close();
						}

						if(!cpsSQL.equals(Constant.BLANK)){
							cpsSQL = "update tblcampusdata set " + cpsSQL + " where campus=? and historyid=?";
							out.write("\n" + cpsSQL + "\n");
							ps3 = conn.prepareStatement(cpsSQL);
							ps3.setString(1,campus);
							ps3.setString(2,ckix);
							rowsAffected = ps3.executeUpdate();
							ps3.close();
						}

						++processed;

					}
					else{
						out.write("\nCC and Banner are identical\n");
					}

					//
					// remove the banner outline after overlay (or not)
					//
					// 1) start with rename of CC outline alpha and number.
					// 2) send the banner outline to delete permanent
					// 3) put the cc outline back in place
					//
					sql = "UPDATE tblCourse set coursealpha=?,coursenum=? where campus=? and historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,"T_"+alpha);
					ps2.setString(2,"T_"+num);
					ps2.setString(3,campus);
					ps2.setString(4,ckix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					if(rowsAffected > 0){

						out.write("Renamed CC course outline\n");

						sql = "UPDATE tblcampusdata set coursealpha=?,coursenum=? where campus=? and historyid=?";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,"T_"+alpha);
						ps2.setString(2,"T_"+num);
						ps2.setString(3,campus);
						ps2.setString(4,ckix);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						out.write("Renamed CC campus data\n");

						com.ase.aseutil.util.CCUtil.deleteFromAllTables("SYSADM",campus,alpha,num,"CUR");
						out.write("Deleted banner data\n");

						sql = "UPDATE tblCourse set coursealpha=?,coursenum=? where campus=? and historyid=?";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,alpha);
						ps2.setString(2,num);
						ps2.setString(3,campus);
						ps2.setString(4,ckix);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						out.write("Restored CC course outline\n");

						sql = "UPDATE tblcampusdata set coursealpha=?,coursenum=? where campus=? and historyid=?";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,alpha);
						ps2.setString(2,num);
						ps2.setString(3,campus);
						ps2.setString(4,ckix);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						out.write("Restored CC campus data\n");

					} // we were able to update/rename/delete

				} // while
				rs.close();
				ps.close();

				rtn = "R92_overlay: " + processed + " of " + read + " rows processed";

			} // doIt

		}
		catch(SQLException e){
			logger.fatal("extract - R92_overlay1: ("+ckix+")" + e.toString() + "\n" + sql);
		}
		catch(Exception e){
			logger.fatal("extract - R92_overlay2: ("+ckix+")" + e.toString() + "\n" + sql);
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - xlist3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - xlist4: " + e.toString());
			}

		}

		return rtn;

	}

	/*
	 * cleanse
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R97_cleanse(Connection conn,String campus,String historyCode){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int read = 0;
		int processed = 0;

		String[] alphas = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");

		int alphasIndex = 0;

		int id = 0;

		String key = "";

		Writer out = null;

		try{

			String sql = "";
			PreparedStatement ps = null;

			sql = "DELETE FROM _bannermaster";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "insert into _bannermaster select * from _bannermasterbak";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();

			removeDups(conn,campus);

			R0_CourseTitle(conn,campus);

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R97_cleanse.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			sql = "select * from _bannermaster order by crse_subj, crse_number";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				++id;

				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String term = AseUtil.nullToBlank(rs.getString("EFFECTIVE_TERM"));
				String alpha_num = alpha + num;
				String alpha_num_term = alpha + num + term;

				key = alpha + " " + num + " " + term;

				String repeatable = AseUtil.nullToBlank(rs.getString("REPEAT_LIMIT"));

				//
				// repeatable is either 0 or 1 for yes or no - column U
				//
				if(repeatable.equals("0")){
					repeatable = "0";
				}
				else{
					repeatable = "1";
				}

				//
				// R4 - column V
				//
				String CONT_LOW = AseUtil.nullToBlank(rs.getString("CONT_LOW"));
				String CONT_IND = AseUtil.nullToBlank(rs.getString("CONT_IND"));
				String CONT_HIGH = AseUtil.nullToBlank(rs.getString("CONT_HIGH"));
				String contacthours = CONT_LOW + " " + CONT_IND + " " + CONT_HIGH;

				//
				// R5 - column W
				//
				String CREDIT_LOW = AseUtil.nullToBlank(rs.getString("CREDIT_LOW"));
				String CREDIT_IND = AseUtil.nullToBlank(rs.getString("CREDIT_IND"));
				String CREDIT_HIGH = AseUtil.nullToBlank(rs.getString("CREDIT_HIGH"));
				String credits = CREDIT_LOW + " " + CREDIT_IND + " " + CREDIT_HIGH;

				//
				// bogus data to create kix
				//
				if(alphasIndex++ >= alphas.length-1){
					alphasIndex = 0;
				}

				String alphax = alpha;
				if(alpha.length() < 3){
					alphax = alpha + "123";
				}

				String numx = num;
				if(num.length() < 3){
					numx = num + "abcd";
				}

				String a = (alphax+numx).substring(0,4);
				String b = alphas[alphasIndex];
				String c = a + b + id + term;
				String d = historyCode+ c;
				int e = d.length();
				if(e > 16){
					e = 16;
				}

				//
				// kix is only 18 characters long
				//
				String kix = d.substring(0,e) + b;

				//
				// cc_type is either CUR or ARC based on effective terms
				//
				String cc_type = "CUR";

				sql = "update _bannermaster set HistoryID=?,repeatable=?,ID=?,A=?,B=?,C=?,D=?,E=?,alpha_num=?,alpha_num_term=?,CC_TYPE=?,contacthours=?,credits=? "
					+ "where CRSE_SUBJ=? AND CRSE_NUMBER=? AND EFFECTIVE_TERM=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.setString(2,repeatable);
				ps2.setString(3,""+id);
				ps2.setString(4,a);
				ps2.setString(5,b);
				ps2.setString(6,c);
				ps2.setString(7,d);
				ps2.setString(8,""+e);
				ps2.setString(9,alpha_num);
				ps2.setString(10,alpha_num_term);
				ps2.setString(11,cc_type);
				ps2.setString(12,contacthours);
				ps2.setString(13,credits);
				ps2.setString(14,alpha);
				ps2.setString(15,num);
				ps2.setString(16,term);
				processed += ps2.executeUpdate();
				ps2.close();

				out.write(kix + " - " + alpha + " - " + num + " - " + term + " - " + cc_type + "\n");

			} // while
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - R97_cleanse1: ("+key+")" + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R97_cleanse2: ("+key+")" + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R97_cleanse3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R97_cleanse4: " + e.toString());
			}

		}

		String junk = "R97_cleanse: " + processed + " rows processed";

		return junk;

	}

	/**
	 * isMinTerm
	 * <p>
	 * @param	conn		Connection
	 * @param	alpha		String
	 * @param	num		String
	 * @param	term		String
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMinTerm(Connection conn,String alpha,String num,String term){

		Logger logger = Logger.getLogger("test");

		boolean minTerm = false;

		try{
			String sql = "SELECT min_term FROM _bannermaster_min WHERE crse_subj=? AND crse_number=? AND min_term=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ps.setString(3,term);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				minTerm = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("Helper: isMinTerm - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("Helper: isMinTerm - " + ex.toString());
		}

		return minTerm;
	}

	/*
	 * clear
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R0_clear(Connection conn,String campus,String historyCode){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String junk = "";

		try{
			String sql = "delete from tblcourse where historyid like '"+historyCode+"%' and campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "course data (CUR): " + rowsAffected + " rows cleared<br>";

			sql = "delete from tblcoursearc where historyid like '"+historyCode+"%' and campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "campus data (ARC): " + rowsAffected + " rows cleared<br>";

			sql = "delete from tblcoursecan where historyid like '"+historyCode+"%' and campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "campus data (CAN): " + rowsAffected + " rows cleared<br>";

			sql = "delete from tblcampusdata where historyid like '"+historyCode+"%' and campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "campus data: " + rowsAffected + " rows cleared<br>";

			sql = "delete from tblxref where historyid like '"+historyCode+"%' and campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "xref data: " + rowsAffected + " rows cleared<br>";

		}
		catch(SQLException e){
			logger.fatal("extract - R0_clear1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R0_clear2: " + e.toString());
		}

		return junk;

	}

	/*
	 * clear
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R0_insert(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String junk = "";

		try{

			String sql = "";
			PreparedStatement ps = null;

			//
			// bannermaster only contains courses we want to import
			//

			//
			// course data with long title
			//
			sql = "insert into tblcourse(id, historyid, campus, coursealpha, coursenum, progress, effectiveterm, coursetitle, [repeatable],division, dispid, auditdate, maxcredit, X79, coursetype,reason) "
				+ "select HistoryID,HistoryID,'"+campus+"',CRSE_SUBJ, CRSE_NUMBER, 'APPROVED', EFFECTIVE_TERM, CRSE_LONG_TITLE, [repeatable], '', CRSE_SUBJ, getdate(), MAX_REPEAT_UNITS, CRSE_TITLE, cc_type,'Transferred from Banner' "
				+ "FROM _bannermaster";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "course data with long title: " + rowsAffected + " rows added<br>";

			//
			// campus data
			//
			sql = "insert into tblcampusdata(historyid, campus, coursealpha, coursenum, auditdate, auditby, coursetype) "
				+ "select HistoryID,'"+campus+"',CRSE_SUBJ, CRSE_NUMBER, getdate(), 'SYSADM', cc_type "
				+ "FROM _bannermaster";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
			junk += "campus data: " + rowsAffected + " rows added<br>";

		}
		catch(SQLException e){
			logger.fatal("extract - R0_insert: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R0_insert: " + e.toString());
		}

		return junk;

	}

	/*
	 * R0_CourseTitle
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R0_CourseTitle(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		Writer out = null;

		//
		// delete from master file all records found in CC
		//

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R0_CourseTitle.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT * FROM _CourseTitles";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String banner = AseUtil.nullToBlank(rs.getString("BANNER_TITLE"));
				String course = AseUtil.nullToBlank(rs.getString("CRSE_TITLE"));

				if(course == null || course.equals("")){
					course = banner;
				}

				sql = "UPDATE _bannermaster SET crse_long_title=? WHERE CRSE_SUBJ=? AND CRSE_NUMBER=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,course);
				ps2.setString(2,alpha);
				ps2.setString(3,num);
				ps2.executeUpdate();
				ps2.close();
				out.write(alpha + " - " + num + "\n");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("extract: R0_CourseTitle1 - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("extract: R0_CourseTitle2 - " + ex.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R0_CourseTitle3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R0_CourseTitle4: " + e.toString());
			}

		}

		return "";

	} // R0_CourseTitle

	/*
	 * xlist
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R1_R2_xlist(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		String xa = "";
		String xn = "";

		boolean debug = false;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R01_xlist.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			// append to where for testing
			//
			//. AND (dup.CRSE_SUBJ = 'ACM') AND (dup.CRSE_NUMBER = '215')

			String sql = "SELECT DISTINCT dup.CRSE_SUBJ, dup.CRSE_NUMBER, dup.EFFECTIVE_TERM, dup.CROSS_LST_CRSE, mstr.HistoryID , mstr.cc_type "
				+ "FROM _bannerdups AS dup INNER JOIN "
				+ "_bannermaster AS mstr ON dup.CRSE_SUBJ = mstr.CRSE_SUBJ AND dup.CRSE_NUMBER = mstr.CRSE_NUMBER AND  "
				+ "dup.EFFECTIVE_TERM = mstr.EFFECTIVE_TERM "
				+ "WHERE (NOT (dup.CROSS_LST_CRSE IS NULL)) "
				+ "ORDER BY dup.CRSE_SUBJ, dup.CRSE_NUMBER, dup.EFFECTIVE_TERM";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String xlist = AseUtil.nullToBlank(rs.getString("CROSS_LST_CRSE"));
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String term = AseUtil.nullToBlank(rs.getString("EFFECTIVE_TERM"));
				String hid = AseUtil.nullToBlank(rs.getString("HistoryID"));
				String type = AseUtil.nullToBlank(rs.getString("cc_type"));

				String output = "";

				if(debug){
					System.out.println("01 - xlist: " + xlist);
					System.out.println("01 - hid: " + hid);
				}

				// start by looking for space between alpha and number
				// if there, we can process further
				if(xlist.contains(" ")){

					int pos = xlist.indexOf(" ");
					if(pos > 0){
						xa = xlist.substring(0,pos);
						xn = xlist.substring(pos+1);

						output = alpha + " " + num + " --> " + xa + " " + xn + " (" + term + ")" + "\r\n";
						if(debug) System.out.println("02 - output: " + output);

						//
						// if number has "A" at the end, then it goes to honors
						//
						if(xn.contains("A")){		// R2
							// for Manoa only
						}
						else if(!xa.equals(alpha)){		// R1

							if(debug) System.out.println("03 - xlist");

							sql = "update tblcourse set " + Constant.COURSE_CROSSLISTED + "=1 where campus=? and coursealpha=? AND coursenum=? AND historyid=?";
							PreparedStatement ps3 = conn.prepareStatement(sql);
							ps3.setString(1,campus);
							ps3.setString(2,alpha);
							ps3.setString(3,num);
							ps3.setString(4,hid);
							rowsAffected = ps3.executeUpdate();
							ps3.close();

							//
							// addRemoveXlist is done here because we need to bypass DC approval
							//
							try{
								rowsAffected = addRemoveXlist(conn,hid,"a",campus,alpha,num,xa,xn,"",0,type);

								if(rowsAffected > 0){
									++processed;
									output = "XList (" + hid + ") " + output;
								}
								else{
									output = "*** XList update error (" + hid + "): " + output;
								}

							}
							catch(Exception e){
								//
							}

						}
						else{
							output = "R1 - not processed - SAME ALPHA: " + output;

							if(debug) System.out.println("04 - SAME ALPHA");

						} // cannot xlist to same alpha

						out.write(output);

					} // still valid


				} // valid

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - xlist1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - xlist2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - xlist3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - xlist4: " + e.toString());
			}

		}

		junk = "R01_xlist: " + processed + " of " + read + " rows processed";

		if(errorsFound){
			junk = junk + " (errors found)";
		}

		return junk;

	}

	/**
	 * getKix
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String getKix(Connection conn,String campus,String alpha,String num,String type,String term){

		Logger logger = Logger.getLogger("test");

		String kix = "";

		try{
			String sql = "SELECT historyid FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND effectiveterm=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,term);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}

		return kix;
	}

	/*
	 * addRemoveXlist
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlist(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID,
													String type) throws SQLException {

		int rowsAffected = 0;
		boolean added = true;

		String sql = "SELECT coursealphax FROM tblxref " +
							"WHERE campus=? AND coursealpha=?  AND coursenum=?  AND coursetype=? " +
							"AND coursealphax=? AND coursenumx=? AND historyid=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, campus);
		ps.setString(2, alpha);
		ps.setString(3, num);
		ps.setString(4, type);
		ps.setString(5, alphax);
		ps.setString(6, numx);
		ps.setString(7, kix);
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			added = false;
			rowsAffected = -1;
		}
		rs.close();
		ps.close();

		if (added){
			rowsAffected = addRemoveXlistX(connection,kix,action,campus,alpha,num,alphax,numx,user,reqID,type);
		}

		return rowsAffected;
	}

	/*
	 * addRemoveXlistX
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * @param	type			String
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlistX(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID,
													String type) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean debug = false;

		int rowsAffected = 0;

		String sql = "INSERT INTO tblXref"
				+ " (coursealpha,coursenum,campus,coursetype,historyid,coursealphax,coursenumx,auditby,id,pending)"
				+ " VALUES(?,?,?,?,?,?,?,?,?,?)";

		try {
			boolean pending = false;

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, campus);
			ps.setString(4, type);
			ps.setString(5, kix);
			ps.setString(6, alphax);
			ps.setString(7, numx);
			ps.setString(8, user);
			ps.setInt(9, XRefDB.getNextID(connection));
			ps.setBoolean(10, pending);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("XRefDB: addRemoveXlistX - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("XRefDB: addRemoveXlistX - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * catalog
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R3_catalog(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		String junk = "";

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		String desc = "";

		boolean errorsFound = false;

		Writer out = null;

		// course with alpha goes to different column (x87)
		// course without alpha goes to coursedescr

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R03_catalog.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "select CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM, CATALOG_DESC from _bannercat order by CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String term = AseUtil.nullToBlank(rs.getString("EFFECTIVE_TERM"));
				String descr = AseUtil.nullToBlank(rs.getString("CATALOG_DESC"));

				int courseNum = 0;
				try{
					courseNum = NumericUtil.getInt(num,0);
				}
				catch(Exception e){
					courseNum = 0;
				}

				rowsAffected = 0;

				sql = "update tblcourse set coursedescr=? where campus=? AND coursealpha=? AND coursenum=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,descr);
				ps2.setString(2,campus);
				ps2.setString(3,alpha);
				ps2.setString(4,num);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

				String output = alpha + " - " + num + "\r\n";

				if(rowsAffected > 0){
					++processed;
					output = "updated ("+desc+"): " + output;
				}
				else{
					errorsFound = true;
					output = "*** not updated ("+desc+"): " + output;
				}

				out.write(output);

			} // while
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - catalog1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - catalog2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - catalog3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - catalog4: " + e.toString());
			}

		}

		junk = "R03_catalog: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * R4_contactHours
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R4_contactHours(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		String junk = "";

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		boolean errorsFound = false;

		Writer out = null;

		try{

			String column = "X32";

			if(campus.equals("MAN")){
				column = "x55";
			}
			else{
				column = "X32";
			}

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R04_contacthours.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			if(courseItems.contains(column.toLowerCase())){

				out.write("Contact hours column ID: " + column + "\r\n\r\n");

				String sql = "select historyid,CONT_LOW,CONT_IND,CONT_HIGH,CRSE_SUBJ, CRSE_NUMBER from _bannermaster ORDER BY CRSE_SUBJ, CRSE_NUMBER";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					++read;

					String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
					String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String low = AseUtil.nullToBlank(rs.getString("CONT_LOW"));
					String ind = AseUtil.nullToBlank(rs.getString("CONT_IND"));
					String high = AseUtil.nullToBlank(rs.getString("CONT_HIGH"));

					rowsAffected = 0;

					String contactHours = "" + low + " " + ind + " " +  high;

					sql = "update tblcourse set "+column+"=? where campus=? AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,contactHours.trim());
					ps2.setString(2,campus);
					ps2.setString(3,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					String output = alpha + " - " + num;

					if(rowsAffected > 0){
						++processed;
						output = "updated (" + kix + ") " + output + ": " + contactHours + "\r\n";
					}
					else{
						errorsFound = true;
						output = "*** not updated: " + output + ": " + contactHours + "\r\n";
					}

					out.write(output);

				} // while
				rs.close();
				ps.close();

			}
			else{
				out.write("Contact hours not used\r\n");
			}

		}
		catch(SQLException e){
			logger.fatal("extract - contactHours1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - contactHours2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - contactHours3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - contactHours4: " + e.toString());
			}

		}

		junk = "R04_contactHours: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * R5_credit
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R5_credits(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		String junk = "";

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		boolean errorsFound = false;

		Writer out = null;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R05_credits.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			if(courseItems.contains("credits")){
				String sql = "select historyid,CREDIT_LOW,CREDIT_IND, CREDIT_HIGH,CRSE_SUBJ, CRSE_NUMBER from _bannermaster ORDER BY CRSE_SUBJ, CRSE_NUMBER";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					++read;

					String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
					String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String low = AseUtil.nullToBlank(rs.getString("CREDIT_LOW"));
					String ind = AseUtil.nullToBlank(rs.getString("CREDIT_IND"));
					String high = AseUtil.nullToBlank(rs.getString("CREDIT_HIGH"));

					rowsAffected = 0;

					String credits = "" + low + " " + ind + " " +  high;

					sql = "update tblcourse set credits=? where campus=? AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,credits.trim());
					ps2.setString(2,campus);
					ps2.setString(3,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					String output = alpha + " - " + num;

					if(rowsAffected > 0){
						++processed;
						output = "updated ("+kix+"): " + output + ": " + credits + "\r\n";
					}
					else{
						errorsFound = true;
						output = "*** not updated: " + output + ": " + credits + "\r\n";
					}

					out.write(output);

				} // while
				rs.close();
				ps.close();
			}
			else{
				out.write("Credit hours not used\r\n");
			}

		}
		catch(SQLException e){
			logger.fatal("extract - credits1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - credits2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - credits3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - credits4: " + e.toString());
			}

		}

		junk = "R05_credits: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * repeatable
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R6_repeatable(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		String junk = "";

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		boolean errorsFound = false;

		Writer out = null;

		// Constant.EXPLAIN_REPEATABLE_CREDITS = c19

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R06_repeatable.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			if(courseItems.contains("repeatable")){
				String sql = "select historyid,repeat_limit,CRSE_SUBJ,CRSE_NUMBER from _bannermaster where [repeatable] = 1 order by CRSE_SUBJ, CRSE_NUMBER, EFFECTIVE_TERM";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					++read;

					String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
					String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String repeat_limit = AseUtil.nullToBlank(rs.getString("repeat_limit"));

					rowsAffected = 0;

					sql = "update tblcampusdata set "+Constant.EXPLAIN_REPEATABLE_CREDITS+"=? where campus=? AND historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,repeat_limit);
					ps2.setString(2,campus);
					ps2.setString(3,kix);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					String output = alpha + " - " + num + " repeat limit " + repeat_limit + "\r\n";

					if(rowsAffected > 0){
						++processed;
						output = "updated ("+kix+"): " + output;
					}
					else{
						errorsFound = true;
						output = "*** not updated: " + output;
					}

					out.write(output);

				} // while
				rs.close();
				ps.close();
			}
			else{
				out.write("Repeatable not used\r\n");
			}

		}
		catch(SQLException e){
			logger.fatal("extract - repeatable1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - repeatable2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - repeatable3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - repeatable4: " + e.toString());
			}

		}

		junk = "R06_repeatable: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * R9_Attr_code(conn,campus)
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R9_Attr_code(Connection conn,String campus){

		//
		// this code selects properly but never writes due to complexity
		// of data and how it works
		//
		Logger logger = Logger.getLogger("test");

		int processed = 0;
		int read = 0;

		String junk = "";

		Writer out = null;

		try{
			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R09_attrcode.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT crse_subj,crse_number,historyid FROM _bannermaster";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String output = alpha + " - " + num + "\r\n";
				out.write(output);

				sql = "SELECT  DISTINCT id, ATTR_CODE FROM _bannercode WHERE crse_subj=? and crse_number=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,alpha);
				ps2.setString(2,num);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){
					String code = AseUtil.nullToBlank(rs2.getString("attr_code"));
					int id = rs2.getInt("id");
					out.write("--->" + code + " - " + id+"\r\n");
				}
				rs2.close();
				ps2.close();

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - R9_Attr_code1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R9_Attr_code2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R9_Attr_code3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R9_Attr_code4: " + e.toString());
			}

		}

		junk = "R9_Attr_code: " + processed + " of " + read + " rows processed";

		return junk;

	}

	/*
	 * R14_Justifications
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R14_Justifications(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int read = 0;
		int processed = 0;

		Writer out = null;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R14_Justifications.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String courseItems = CampusDB.getCourseItems(conn,campus).toLowerCase();

			if(courseItems.contains("x60")){
				String sql = "SELECT historyid,CRSE_SUBJ, CRSE_NUMBER from _bannermaster order by CRSE_SUBJ, CRSE_NUMBER";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					++read;

					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
					String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));

					sql = "update tblcourse set X60=? where campus=? and historyid=?";
					PreparedStatement ps3 = conn.prepareStatement(sql);
					ps3.setString(1,"Transferred from Banner");
					ps3.setString(2,campus);
					ps3.setString(3,kix);
					rowsAffected = ps3.executeUpdate();
					ps3.close();

					String output = kix + " - " + alpha + " - " + num + "\r\n";

					if(rowsAffected > 0){
						++processed;
						output = "updated: " + output;
					}
					else{
						output = "*** not updated: " + output;
					}

					out.write(output);
				}
				rs.close();
				ps.close();
			}
			else{
				out.write("R14_Justifications not used");
			}
		}
		catch(SQLException e){
			logger.fatal("extract - R14_Justifications1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - R14_Justifications2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R14_Justifications3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R14_Justifications4: " + e.toString());
			}

		}

		String junk = "R14_Justifications: " + processed + " of " + read + " rows processed";

		return junk;

	}

	/*
	 * R90_coreqs
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R90_coreqs(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R90_coreqs.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT DISTINCT dup.CRSE_SUBJ, dup.CRSE_NUMBER, dup.EFFECTIVE_TERM, dup.CO_REQ_CRSE, mstr.HistoryID "
				+ "FROM _bannerdups dup INNER JOIN "
				+ "_bannermaster mstr ON dup.CRSE_SUBJ = mstr.CRSE_SUBJ AND dup.CRSE_NUMBER = mstr.CRSE_NUMBER AND  "
				+ "dup.EFFECTIVE_TERM = mstr.EFFECTIVE_TERM "
				+ "WHERE (NOT (dup.CO_REQ_CRSE IS NULL)) "
				+ "ORDER BY dup.CRSE_SUBJ, dup.CRSE_NUMBER, dup.EFFECTIVE_TERM";

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String coreq = AseUtil.nullToBlank(rs.getString("CO_REQ_CRSE"));
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String term = AseUtil.nullToBlank(rs.getString("EFFECTIVE_TERM"));
				String kix = AseUtil.nullToBlank(rs.getString("HistoryID"));

				sql = "update tblcampusdata set " + Constant.EXPLAIN_COREQ + "=? where campus=? and coursealpha=? AND coursenum=? AND historyid=?";
				PreparedStatement ps3 = conn.prepareStatement(sql);
				ps3.setString(1,coreq);
				ps3.setString(2,campus);
				ps3.setString(3,alpha);
				ps3.setString(4,num);
				ps3.setString(5,kix);
				rowsAffected = ps3.executeUpdate();
				ps3.close();

				String output = alpha + " - " + num + "\r\n";

				if(rowsAffected > 0){
					++processed;
					output = "updated ("+kix+"): " + output;
				}
				else{
					output = "*** not updated ("+kix+"): " + output;
				}

				out.write(output);

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - coreqs1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - coreqs2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - coreqs3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - coreqs4: " + e.toString());
			}

		}

		junk = "R90_coreqs: " + processed + " of " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/*
	 * outlines
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String R98_outlines(Connection conn,String campus,String historyCode){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R98_outlines.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT historyid,coursealpha,coursenum,coursetitle from tblcourse where campus=? AND historyid like '"+historyCode+"%' order by coursealpha, coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));

				CampusDB.updateCampusOutline(conn,kix,campus);

				out.write("Refreshed outline ("+kix+"): " + alpha + " " + num + " - " + coursetitle + " ("+kix+")\n");

				++processed;

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - outlines1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - outlines2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - outlines3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - outlines4: " + e.toString());
			}

		}

		return "R98_outlines: " + processed + " of " + read + " rows processed";

	}

	/**
	*
	*	R99_createHTML
	*
	**/
	public static String R99_createHTML(String campus,String historyCode){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		Writer out = null;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R99_html.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			conn = AsePool.createLongConnection();

			if (conn != null){

				String sql = "select CourseAlpha, CourseNum, historyid, coursetitle from tblcourse where campus=? and historyid like '" + historyCode + "%' ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));

					Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

					out.write("Create outline view ("+kix+"): " + alpha + " " + num + " - " + coursetitle + " ("+kix+")\n");

					++rowsAffected;
				} // while
				rs.close();
				ps.close();

			}	// if conn

		}
		catch(SQLException sx){
			logger.fatal("extract: createHTML - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("extract: createHTML - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("extract: createHTML - " + e.toString());
			}

			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - outlines3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - outlines4: " + e.toString());
			}
		}

		return "R99_createHtml completed with " + rowsAffected + " rows";

	} // createHTML

	public static String R200_BannerTermGreaterThanCC(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String junk = "";
		String error = "***";
		boolean errorsFound = false;

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R200_BNR_GT_CC.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			out.write("ALPHA,NUM,BANNER,CC\r\n");

			String sql = "SELECT b.CRSE_SUBJ, b.CRSE_NUMBER, b.EFFECTIVE_TERM AS BNR, c.effectiveterm AS CC "
				+ "FROM  _bannermaster_done AS b INNER JOIN tblCourse AS c ON b.CRSE_SUBJ = c.CourseAlpha AND b.CRSE_NUMBER = c.CourseNum "
				+ "GROUP BY b.CRSE_SUBJ, b.CRSE_NUMBER, c.effectiveterm, c.campus, b.EFFECTIVE_TERM "
				+ "HAVING (c.campus=?) AND (b.EFFECTIVE_TERM > c.effectiveterm) "
				+ "ORDER BY b.CRSE_SUBJ, b.CRSE_NUMBER";

			sql = "SELECT bkix, ckix, CourseAlpha as CRSE_SUBJ, CourseNum as CRSE_NUMBER, CourseType, Progress, cterm, bterm "
				+ "FROM _banner_overlay_combined WHERE bterm > cterm ORDER BY CourseAlpha, CourseNum ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				String BNR = AseUtil.nullToBlank(rs.getString("bterm"));
				String CC = AseUtil.nullToBlank(rs.getString("cterm"));

				out.write(alpha + "," + num  + "," + BNR  + "," + CC + "\r\n");

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("extract - coreqs1: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("extract - coreqs2: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - coreqs3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - coreqs4: " + e.toString());
			}

		}

		junk = "R200_BannerTermGreaterThanCC: " + read + " rows processed";

		if(errorsFound)
			junk = junk + " (errors found)";

		return junk;

	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToValue(String val,String defalt) {

		if (val==null || val.equals("null") || val.length()== 0)
			val = defalt;

		if (val.length() > 0)
			val = val.trim();

		return val;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static int nullToValue(int val,int defalt) {

		int temp = 0;

		if (Integer.toString(val) == null)
			temp = defalt;
		else
			temp = val;

		return temp;
	}

	/**
	 * removeDups
	 */
	public static String removeDups(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		Writer out = null;

		//
		// delete from master file all records found in CC
		//

		try{

			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\R97_removeDups.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			PreparedStatement ps2 = null;

			String sql = "SELECT CRSE_SUBJ, CRSE_NUMBER FROM _bannermaster";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("CRSE_SUBJ"));
				String num = AseUtil.nullToBlank(rs.getString("CRSE_NUMBER"));
				if(!isMatch(conn,alpha,num)){
					sql = "DELETE FROM _bannermaster WHERE CRSE_SUBJ=? AND CRSE_NUMBER=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,alpha);
					ps2.setString(2,num);
					ps2.executeUpdate();
					ps2.close();

					sql = "DELETE FROM _bannercat WHERE CRSE_SUBJ=? AND CRSE_NUMBER=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,alpha);
					ps2.setString(2,num);
					ps2.executeUpdate();
					ps2.close();

					sql = "DELETE FROM _bannerdups WHERE CRSE_SUBJ=? AND CRSE_NUMBER=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,alpha);
					ps2.setString(2,num);
					ps2.executeUpdate();
					ps2.close();

					out.write(alpha + " - " + num + "\n");
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("extract: removeDups1 - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("extract: removeDups2 - " + ex.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("extract - R97_removeDups3: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("extract - R97_removeDups4: " + e.toString());
			}

		}

		return "";
	}

	/**
	 * isMatch
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String alpha,String num) throws SQLException {

		String sql = "SELECT CRSE_SUBJ FROM missingfromcc WHERE CRSE_SUBJ=? AND CRSE_NUMBER=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,alpha);
		ps.setString(2,num);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>