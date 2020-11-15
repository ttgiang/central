/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 *	public static String drawFunctionDesignation(Connection conn,String campus,String input){
 *	public static String getFileExtension(String fileName){
 *	public static String getFunctionDesignation(Connection conn,String campus,String table,String program,String def){
 * public static String removeHTMLTags(String html,int numberOfDays)
 *	public static String showForm(Connection conn,String kix)
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

public class AseUtil2 {

	static Logger logger = Logger.getLogger(AseUtil2.class.getName());

	public AseUtil2(){}

	/**
	 * removeHTMLTags
	 * <p>
	 * @param	html			String
	 * @param	intWorkFlow	int
	 * <p>
	 * @return	String
	 */
	public static String removeHTMLTags(String html,int intWorkFlow){

		Pattern pattern = null;
		Matcher matcher = null;
		String tagLess = null;
		tagLess = html;
		String regex;

		try{
			if(intWorkFlow == -1){
				//removes all html tags
				regex = "<[^>]*>";
				pattern = pattern.compile(regex);
				tagLess = pattern.matcher(tagLess).replaceAll(" ");
			}

			if(intWorkFlow > 0 && intWorkFlow < 3){
				regex = "[<]";
				//matches a single <
				pattern = pattern.compile(regex);
				tagLess = pattern.matcher(tagLess).replaceAll("<");

				regex = "[>]";
				//matches a single >
				pattern = pattern.compile(regex);
				tagLess = pattern.matcher(tagLess).replaceAll(">");
			}
		}
		catch(Exception e){
			logger.fatal("AseUtil2: removeHTMLTags - " + e.toString());
		}

		return tagLess;
	}

	/**
	 * showForm - shows what a form would look like when displayed in full
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String
	 */
	public static String showForm(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		int question_len = 0;
		int question_max = 0;
		String question = "";
		String question_ini = "";
		String question_type = "";
		String question_friendly = "";
		String question_explain = "";
		String questionData[] = new String[2];
		String question_change = "N";					// determines whether a question should appear on create
		String questionTab = "";
		String extraData = "";							// these fields control what button text, class to show
		String temp = "";
		String HTMLFormField = "";
		String f;
		StringBuffer buf = new StringBuffer();

		int i = 0;
		int tab = 0;
		int counter = 0;

		CCCM6100 cccm6100;

		try{
			AseUtil aseUtil = new AseUtil();

			for (tab=1;tab<3;tab++){
				if (tab==1){
					f = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
				}
				else{
					f = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
				}

				String[] c1 = f.split(",");

				for(i=0;i<c1.length;i++){

					++counter;
					HTMLFormField = "";
					question = "";

					cccm6100 = CCCM6100DB.getCCCM6100(conn,(i+1),campus,tab);
					if ( cccm6100 != null ){
						question = cccm6100.getCCCM6100();
						question_ini = cccm6100.getQuestion_Ini();
						question_type = cccm6100.getQuestion_Type();
						question_len = cccm6100.getQuestion_Len() + 20;
						question_max = cccm6100.getQuestion_Max();
						question_friendly = cccm6100.getQuestion_Friendly();
						question_explain = cccm6100.getQuestion_Explain();
						question_change = cccm6100.getChange();

						questionData[0] = "";

						if ("wysiwyg".equals(question_type)){
							question_type = "textarea";
							question_len = 90;
							question_max = 5;
						}

						HTMLFormField = aseUtil.drawHTMLField(conn,
																			question_type,
																			question_ini,
																			"questions_"+counter,
																			questionData[0],
																			question_len,
																			question_max,
																			false,
																			campus,
																			false);

						buf.append("<tr><td class=\"textblackTH\"><br/>" + (counter) + ".&nbsp;" + question + "</td></tr>"
									+ "<tr><td class=\"datacolumn\" valign=\"top\">" + HTMLFormField + "</td></tr>");
					}	// if
				}	// for i
			} // for j

		} catch(Exception e){
			logger.fatal("AseUtil2: showForm - " + e.toString());
		}

		return buf.toString();
	}

	/**
	 * showFormX - this version displays actual data
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String
	 */
	public static String showFormX(Connection conn,String kix,int tab){

		//Logger logger = Logger.getLogger("test");

		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";

		// course to work with. Do not use session variables for alpha and num here
		if (!"".equals(kix)){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}

		// input fields
		int question_len = 0;
		int question_max = 0;
		String question = "";
		String question_ini = "";
		String question_type = "";
		String question_friendly = "";
		String question_explain = "";
		String questionData[] = new String[2];
		String question_change = "N";					// determines whether a question should appear on create
		String questionTab = "";
		String HTMLFormField = "";
		String HTMLFormFieldExplain = "";
		String temp = "";
		int i = 0;
		int counter = 1;

		String extraData = "";					// these fields control what button text, class to show
		String extraButton = "";				// when there are extra data to display
		String extraForm = "";
		String extraArg = "";
		String extraClass = "";
		String extraDisabled = "";
		String extraTitle = "";					// button title
		String extraCmdTitle = "";				// button tip
		String extraHelp = "";

		String f;
		StringBuffer buf = new StringBuffer();

		CCCM6100 cccm6100;

		try{
			AseUtil aseUtil = new AseUtil();

			if (tab==1)
				f = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
			else
				f = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

			String[] c1 = f.split(",");

			for(i=0;i<c1.length;i++){

				extraData = "";
				HTMLFormField = "";
				HTMLFormFieldExplain = "";
				question = "";

				cccm6100 = CCCM6100DB.getCCCM6100(conn,(i+1),campus,tab);
				if ( cccm6100 != null ){
					question = cccm6100.getCCCM6100();
					question_ini = cccm6100.getQuestion_Ini();
					question_type = cccm6100.getQuestion_Type();
					question_len = cccm6100.getQuestion_Len() + 20;
					question_max = cccm6100.getQuestion_Max();
					question_friendly = cccm6100.getQuestion_Friendly();
					question_explain = cccm6100.getQuestion_Explain();
					question_change = cccm6100.getChange();

					questionData = CourseDB.lookUpQuestion(conn,campus,alpha,num,type,question_friendly,tab);
					if ( "NODATA".equals(questionData[0]) || "ERROR".equals(questionData[0]) ) {
						questionData[0] = "";
						questionData[1] = "";
					}

					HTMLFormField = aseUtil.drawHTMLField(conn,
																		question_type,
																		question_ini,
																		"questions_"+i,
																		questionData[0],
																		question_len,
																		question_max,
																		false,
																		campus,
																		false);

					if ((Constant.COURSE_GESLO).equals(question_friendly)){
						HTMLFormField = "";
						HTMLFormFieldExplain = GESLODB.getGESLO(conn,campus,kix,false);
					}
					else{
						if(question_explain!=null && question_explain.length()>0){
							HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,alpha,num,type,question_explain);
							HTMLFormFieldExplain = aseUtil.drawHTMLField(conn,
													"wysiwyg",
													"",
													"explain_"+i,
													HTMLFormFieldExplain,
													0,
													0,
													false,
													"",
													false);
						}
					}

					if (tab==3){
						if ("crosslisted".equals(question_friendly)){
							extraData = CourseDB.getCrossListing(conn,kix);
						}
						else if ((Constant.COURSE_COMPETENCIES).equals(question_friendly)){
							extraData = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
						}
						else if ((Constant.COURSE_CONTENT).equals(question_friendly)){
							extraData = ContentDB.getContentAsHTMLList(conn,campus,alpha,num,"PRE",kix,true,false);
						}
						else if ((Constant.COURSE_COREQ).equals(question_friendly)){
							extraData = RequisiteDB.getRequisites(conn,campus,alpha,num,"PRE",Constant.REQUISITES_COREQ,"");
						}
						else if ((Constant.COURSE_PREREQ).equals(question_friendly)){
							extraData = RequisiteDB.getRequisites(conn,campus,alpha,num,"PRE",Constant.REQUISITES_PREREQ,"");
						}
						else if ((Constant.COURSE_OBJECTIVES).equals(question_friendly)){
							extraData = CompDB.getCompsAsHTMLList(conn,alpha,num,campus,"PRE",kix,true,question_friendly);
						}
						else if ((Constant.COURSE_TEXTMATERIAL).equals(question_friendly)){
							extraData = TextDB.getTextAsHTMLList(conn,kix);
						}
					}	// currentTab


					buf.append("<tr><td class=\"textblackTH\"><br/>" + (counter++) + ".&nbsp;" + question + "&nbsp;(" + question_friendly + ")</td></tr>");
					buf.append("<tr><td class=\"datacolumn\" valign=\"top\">" + HTMLFormField + "</td></tr>");

				}	// for

			}
		} catch(Exception e){
			System.out.println(e.toString());
		}

		return buf.toString();
	}

	/**
	 * getFileExtension
	 * <p>
	 * @param	fileName		String
	 * <p>
	 * @return	String
	 */
	public static String getFileExtension(String fileName){

		String ext = "";
		int nPos = 0;

		if (fileName == null){
			ext = "html";
		}
		else{
			ext = fileName.toLowerCase();

			nPos = ext.lastIndexOf(".");

			if (nPos > -1){
				// thanks to Microsoft, extensions are now 4 for docx and excel and more.
				// at this point, we get the extension and limit it to 3
				ext = ext.substring(nPos+1,ext.length());
				if (ext.length() > 3){
					ext = ext.substring(0,3);
				}

				nPos = Constant.FILE_EXTENSIONS.indexOf(ext);
				if (nPos == -1){
					ext = "html";
				}

			}
			else{
				ext = "html";
			} // not found in nPos
		}

		return ext.toLowerCase();
	}

	/**
	 * displayValues - system.out.println values
	 * <p>
	 * @param	values
	 */
	public static void displayValues(String values){

		String[] aValues = null;
		int i = 0;

		if (values != null && values.length() > 0){
			aValues = values.split(",");

			for (i=0;i<aValues.length;i++){
				System.out.println(aValues[i] + ": " + aValues[i]);
			}
		}

	}

}