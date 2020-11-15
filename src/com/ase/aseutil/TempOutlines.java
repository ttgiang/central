/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

//
// ApproverDB.java
//
package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

public class TempOutlines {

	static Logger logger = Logger.getLogger(TempOutlines.class.getName());

	/*
	 * TempOutlines
	 *	<p>
	 */
	public TempOutlines() throws Exception {}

	public static Msg compareOutline(Connection conn,
												String kixSRC,
												String kixDST,
												String user,
												boolean compressed,
												boolean show) throws Exception {

		Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH bgcolor=\"<| counterColor |>\" width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorSRC |>\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"<| paddedColor |>\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorDST |>\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		String paddedColor = "#e1e1e1";
		String colorSRC = Constant.COLOR_LEFT;
		String colorDST = Constant.COLOR_RIGHT;
		String notMatchedColor = "#D2A41C";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";

		//SRC
		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfo(conn,kixSRC);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[Constant.KIX_CAMPUS];

		//DST
		int td = 0;
		String cd = "";
		String[] id = Helper.getKixInfo(conn,kixDST);
		td = ConstantDB.getConstantTypeFromString(id[2]);
		cd = id[Constant.KIX_CAMPUS];

		String alpha = is[Constant.KIX_ALPHA];
		String num = is[Constant.KIX_NUM];
		String type = is[Constant.KIX_TYPE];

		String alphaDST = id[Constant.KIX_ALPHA];
		String numDST = id[Constant.KIX_NUM];

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,cs).split(",");

		String headerSRC = "";
		String headerDST = "";

		String typeSRC = "";
		String typeDST = "";

		try {

			typeSRC = Outlines.getCourseType(conn,kixSRC);
			typeDST = Outlines.getCourseType(conn,kixDST);

			// source is on the left and destination is on the right
			// depending on what the source is, the title may change
			// for example, if source is PRE, the title is modified
			// if CUR, the current
			// if ARC, existing

			String termSRC = CourseDB.getCourseItem(conn,kixSRC,"effectiveterm");
			String termDST = CourseDB.getCourseItem(conn,kixDST,"effectiveterm");

			termSRC = BannerDataDB.getBannerDescr(conn,"bt",termSRC);
			termDST = BannerDataDB.getBannerDescr(conn,"bt",termDST);

			headerSRC = cs
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixSRC))
							+ " ("+termSRC+"_PDF_)";

			headerDST = cd
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixDST))
							+ " ("+termDST+"_PDF_)";

			//
			// enableCCLab
			//
			String userCampus = UserDB.getUserCampus(conn,user);
			String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,userCampus,"System","EnableCCLab");
			if (enableCCLab.equals(Constant.ON)){
				headerSRC = headerSRC.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixSRC+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);

				headerDST = headerDST.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixDST+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);
			}
			else{
				headerSRC = headerSRC.replace("_PDF_","");
				headerDST = headerDST.replace("_PDF_","");
			} // enableCCLab

			boolean same = true;

			//-----------------------------------------------------
			// course
			//-----------------------------------------------------
			int dataSRC = 0;
			int dataDST = 0;

			//
			// how many columns are we comparing
			//
			dataSRC = CourseDB.countCourseQuestions(conn,cs,"Y","",1);
			if(cs.equals(cd)){
				dataDST = dataSRC;
			}
			else{
				dataDST = CourseDB.countCourseQuestions(conn,cd,"Y","",1);
			}

			String src = "";
			String dst = "";

			//
			// always display as many as there are questions on SRC outline
			//
			for(i=0; i<dataSRC;i++){
				t1 = row1;
				t2 = row2;

				same = true;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				// get data for the column. if the dst has fewer columns, don't get data
				src = CourseDB.getCourseItem(conn,kixSRC,columns[i]);
				src = Outlines.formatOutline(conn,columns[i],cs,alpha,num,typeSRC,kixSRC,src,true,user);

				if(dataDST > i){
					dst = CourseDB.getCourseItem(conn,kixDST,columns[i]);
					dst = Outlines.formatOutline(conn,columns[i],cd,alphaDST,numDST,typeDST,kixDST,dst,true,user);
				}
				else{
					dst = "";
				}

				// compare for display
				if (!src.equals(dst)){
					same = false;
				}

				// do we show?
				if(show || (!show && !same)){

					t1 = t1.replace("<| counter |>",(""+(i+1)));

					if (!same){
						t1 = t1.replace("<| counterColor |>",notMatchedColor);
					}
					else{
						t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
					}

					t1 = t1.replace("<| question |>",question+"<br><br>");

					t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
							.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
							.replace("<| paddedColor |>",paddedColor)
							.replace("<| colorSRC |>",colorSRC)
							.replace("<| colorDST |>",colorDST);

					buf.append(t1).append(t2);

				} // show

			} // for

			//
			// now we print campus tab data
			// if the campus SRC = DST, then we compare campus questions for SRC and DSt
			// if campuses are different, we only display SRC data since campus data are
			// not meant to be similar
			//
			if(i < columns.length){

				for(int j=i; j<columns.length; j++){

					t1 = row1;
					t2 = row2;

					same = true;

					question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[j] + "'" );

					dst = "";

					// get data for the column. if the dst has fewer columns, don't get data
					src = CampusDB.getCampusItem(conn,kixSRC,columns[j]);
					src = Outlines.formatOutline(conn,columns[j],cs,alpha,num,typeSRC,kixSRC,src,true,user);

					// for same campus compare, get dst
					if(cs.equals(cd)){
						dst = CampusDB.getCampusItem(conn,kixDST,columns[j]);
						dst = Outlines.formatOutline(conn,columns[j],cd,alphaDST,numDST,typeDST,kixDST,dst,true,user);
					}

					//
					// compare for display
					// if the src not equals data and the campuses are different, we compare
					//
					if (!src.equals(dst)){
						same = false;
					}

					// do we show?
					if(show || (!show && !same)){

						t1 = t1.replace("<| counter |>",(""+(j+1)));

						if (!same){
							t1 = t1.replace("<| counterColor |>",notMatchedColor);
						}
						else{
							t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
						}

						t1 = t1.replace("<| question |>",question+"<br><br>");

						t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
								.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
								.replace("<| paddedColor |>",paddedColor)
								.replace("<| colorSRC |>",colorSRC)
								.replace("<| colorDST |>",colorDST);

						buf.append(t1).append(t2);

					} // show

				} // for

			}

			//
			// output
			//
			String campusTitle = "";

			cs = CampusDB.campusDropDownWithKix(conn,alpha,num,typeSRC,"ks",cs);
			cd = CampusDB.campusDropDownWithKix(conn,alphaDST,numDST,typeDST,"kd",cd);

			msg.setErrorLog("<table summary=\"\" id=\"tableCompareOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
								+ campusTitle
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorSRC+"\" valign=\"top\" width=\"47%\">"+headerSRC+"</td>"
								+"<td align=\"center\" bgcolor=\""+paddedColor+"\" valign=\"top\" width=\"02%\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorDST+"\" valign=\"top\" width=\"47%\">"+headerDST+"</td>"
								+"</tr>"
								+ buf.toString()
								+ "</table>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines.compareOutline ("+kixSRC+"/"+kixDST+"): " + e.toString());
		}

		return msg;
	} // compareOutline

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}