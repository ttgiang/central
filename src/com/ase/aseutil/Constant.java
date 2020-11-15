/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil;

import java.util.Locale;

public class Constant {

	// NOTE: make effort to keep works separated by underscore

	public static final int PROGRAM_ITEMS_TO_PRINT_ON_CREATE	= 7;

	// for antisamy use
	public static final Locale LOCALE_CHINESE 		= new Locale("zh", "CN");
	public static final Locale LOCALE_ENGLISH 		= new Locale("en", "US");
	public static final Locale LOCALE_ITALIAN 		= new Locale("it", "IT");
	public static final Locale LOCALE_GERMAN 			= new Locale("de", "DE");
	public static final Locale LOCALE_NORWEGIAN 		= new Locale("no", "NB");
	public static final Locale LOCALE_PORTUGUESE		= new Locale("pt", "PT");
	public static final Locale LOCALE_RUSSIAN 		= new Locale("ru", "RU");
	public static final Locale LOCALE_SPANISH 		= new Locale("es", "MX");

	// main ASE
	public static final String ASE_PROPERTIES	= "ase.central.Ase";
	public static final String PROD_SYSTEM		= "curriculumcentral.its.hawaii.edu";
	public static final String TEST_SYSTEM		= "cctest.its.hawaii.edu";
	public static final String LOCAL_SYSTEM	= "localhost";

	// ON/OFF
	public static final String ON						= "1";
	public static final String OFF					= "0";
	public static final String FALSE					= "false";
	public static final String TRUE					= "true";

	// split separator
	public static final String SEPARATOR			= "~~";

	public static final String ADD				= "a";
	public static final String ALL				= "ALL";
	public static final String ARC				= "ARC";
	public static final String BLANK				= "";
	public static final String CAN				= "CAN";
	public static final String CUR				= "CUR";
	public static final String NO					= "NO";
	public static final String PRE				= "PRE";
	public static final String REMOVE			= "r";
	public static final String SPACE				= " ";
	public static final String YES				= "YES";

	public static final String DEFECT			= "DEFECT";
	public static final String ENHANCEMENT		= "ENHANCEMENT";
	public static final String TODO				= "TODO";

	public static final String FORUM					= "forum";
	public static final String FORUM_COURSE		= "CR";
	public static final String FORUM_DEFECT		= "DF";
	public static final String FORUM_PROGRAM		= "PR";
	public static final String FORUM_ENHANCEMENT	= "ER";
	public static final String FORUM_USERNAME		= "USR";

	public static final String REPORT_JRXML				= "jrxml";
	public static final String REPORT_JASPER				= "jasper";
	public static final String REPORT_JPRINT				= "jprint";
	public static final String REPORT_DESIGN_FOLDER		= ":/tomcat/webapps/centraldocs/core/rpts/";
	public static final String REPORT_OUTPUT_FOLDER		= ":/tomcat/webapps/centraldocs/docs/urpts/";
	public static final String REPORT_LOGO_FOLDER		= ":/tomcat/webapps/centraldocs/images/logos/";

	// data type
	public static final int CC_TEXT				= 1;
	public static final int CC_DATE				= 2;
	public static final int CC_NUMBER			= 3;

	public static final int HORIZONTAL			= 4;
	public static final int VERTICAL				= 5;

	public static final String CC_DATE_FORMAT		= "MM/dd/yyyy";
	public static final String CC_DATE_FORMAT_SS	= "MM/dd/yyyy hh:mm:ss a";

	public static final String ALPHABETS 		= "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";

	// campus names
	public static final String CAMPUS_HAW		= "HAW";
	public static final String CAMPUS_HIL		= "HIL";
	public static final String CAMPUS_HON		= "HON";
	public static final String CAMPUS_KAP		= "KAP";
	public static final String CAMPUS_KAU		= "KAU";
	public static final String CAMPUS_LEE		= "LEE";
	public static final String CAMPUS_MAN		= "MAN";
	public static final String CAMPUS_UHMC		= "UHMC";
	public static final String CAMPUS_WIN		= "WIN";
	public static final String CAMPUS_WOA		= "WOA";
	public static final String CAMPUS_TTG		= "TTG";

	// course edits
	public static final int COURSE_ITEM_PREREQ				= 0;
	public static final int COURSE_ITEM_COREQ					= 1;
	public static final int COURSE_ITEM_CROSSLISTED			= 2;
	public static final int COURSE_ITEM_EXCLUEFROMCATALOG = 3;
	public static final int COURSE_ITEM_EFFECTIVETERM		= 4;
	public static final int COURSE_ITEM_REPEATABLE			= 5;
	public static final int COURSE_ITEM_SLO					= 6;
	public static final int COURSE_ITEM_CONTENT				= 7;
	public static final int COURSE_ITEM_METHODEVAL			= 8;
	public static final int COURSE_ITEM_METHODINST			= 9;
	public static final int COURSE_ITEM_EXPECTATIONS		= 10;
	public static final int COURSE_ITEM_DELIVERY				= 11;
	public static final int COURSE_ITEM_COMPETENCIES		= 12;
	public static final int COURSE_ITEM_COURSE_RECPREP		= 13;
	public static final int COURSE_ITEM_PROGRAM_SLO			= 14;
	public static final int COURSE_ITEM_ILO					= 15;
	public static final int COURSE_ITEM_GESLO					= 16;

	// course items
	public static final String COURSE								= "course";
	public static final String COURSE_ALPHA						= "coursealpha";
	public static final String COURSE_ASSESSMENT					= "Assess";
	public static final String COURSE_NUM							= "coursenum";
	public static final String COURSE_CREDITS						= "credits";
	public static final String COURSE_CROSSLISTED				= "crosslisted";
	public static final String COURSE_EFFECTIVETERM				= "effectiveterm";
	public static final String COURSE_REASON						= "Reason";
	public static final String COURSE_REPEATABLE					= "repeatable";
	public static final String COURSE_CAMPUS_ITEM				= "edit2";
	public static final String COURSE_COURSE_ITEM				= "edit1";
	public static final String COURSE_CCOWIQ						= "C31";
	public static final String COURSE_PREREQ						= "X15";
	public static final String COURSE_COREQ						= "X16";
	public static final String COURSE_RECPREP						= "X17";
	public static final String COURSE_OBJECTIVES					= "X18";
	public static final String COURSE_CONTENT						= "X19";
	public static final String COURSE_TEXTMATERIAL				= "X20";

	public static final String COURSE_METHODEVALUATION			= "X23";
	public static final String COURSE_METHODEVALUATION_X		= "MethodEval";

	public static final String COURSE_METHODINSTRUCTION		= "X24";
	public static final String COURSE_METHODINSTRUCTION_X		= "MethodInst";

	public static final String COURSE_PROGRAM						= "X27";
	public static final String COURSE_OTHER_DEPARTMENTS		= "X29";

	public static final String COURSE_CONTACT_HOURS	      	= "X32";
	public static final String COURSE_CONTACT_HOURS_X      	= "ContactHrs";

	public static final String COURSE_SEMESTER		      	= "semester";
	public static final String COURSE_SEMESTER_X		      	= "Semester";

	public static final String COURSE_GRADING_OPTIONS      	= "gradingoptions";
	public static final String COURSE_GRADING_OPTIONS_X      = "grading";

	public static final String COURSE_GENCORE		      		= "X40";
	public static final String COURSE_COMPARABLE	      		= "X41";
	public static final String COURSE_COMPETENCIES				= "X43";
	public static final String COURSE_CHANGE_PROPOSED			= "X46";

	public static final String COURSE_EXPECTATIONS				= "X56";
	public static final String COURSE_EXPECTATIONS_X			= "Expectations";

	public static final String COURSE_SPECIAL_FEES				= "X65";
	public static final String COURSE_SPECIAL_ROOM				= "X66";
	public static final String COURSE_SPECIAL_SCHEDULING		= "X67";

	public static final String COURSE_METHOD_DELIVERY			= "X68";
	public static final String COURSE_METHOD_DELIVERY_X		= "MethodDelivery";

	public static final String COURSE_GESLO						= "X71";
	public static final String COURSE_PROGRAM_SLO				= "X72";
	public static final String COURSE_FUNCTION_DESIGNATION	= "X73";
	public static final String COURSE_FORMS						= "X75";
	public static final String COURSE_REASONSFORMODS			= "X76";
	public static final String COURSE_GRADINGSCALE				= "X77";
	public static final String COURSE_STUDENT_TYPE				= "X78";
	public static final String COURSE_BANNER_TITLE				= "X79";
	public static final String COURSE_PROGRAM_MODIFICATION	= "X80";
	public static final String COURSE_HONORS_COURSES			= "X81";	// C70 for explain
	public static final String COURSE_OFFERING_STATUS			= "X85";
	public static final String COURSE_INSTITUTION_LO			= "X86";	// add this to CCCM table

	// course items
	public static final String CAMPUS_COMMENTS							= "C6";
	public static final String EXPLAIN_METHOD_INST						= "C10";	// x24
	public static final String EXPLAIN_METHOD_EVAL						= "C11";	// x23
	public static final String EXPLAIN_EXPECTATIONS						= "C12"; //	x56
	public static final String EXPLAIN_SPECIAL_FEES						= "C13";	// x65
	public static final String EXPLAIN_SPECIAL_ROOM						= "C14";	// x66
	public static final String EXPLAIN_SPECIAL_SCHEDULING				= "C15";	//	x67
	public static final String EXPLAIN_GRADING_OPTIONS					= "C16";	//	grading options
	public static final String EXPLAIN_METHOD_DELIVERY					= "C17";	// x68
	public static final String EXPLAIN_SEMESTER							= "C18";	// semester
	public static final String EXPLAIN_REPEATABLE_CREDITS				= "C19";	// repeatable for credits
	public static final String EXPLAIN_CONTACT_HOURS					= "C20";	// x32
	public static final String EXPLAIN_FUNCTIONDESIGNATION			= "C21";	// x73
	public static final String EXPLAIN_REASONSFORMODS					= "C22";	// x76
	public static final String EXPLAIN_NUMBER_CREDITS					= "C23";	// number of credits
	public static final String EXPLAIN_COMPARABLE						= "C24";	// comparable
	public static final String EXPLAIN_PREREQ								= "C25";	// pre req
	public static final String EXPLAIN_COREQ								= "C26";	// co req
	public static final String EXPLAIN_COURSE_ALPHA						= "C27";	// course alpha
	public static final String EXPLAIN_COURSE_NUMBER					= "C28";	// course number
	//public static final String COURSE_CCOWIQ							= "C31"; // C31 already taken (COWIQ)
	public static final String EXPLAIN_COURSE_PROGRAM					= "C32";	// course program (x27)
	public static final String EXPLAIN_COURSE_OTHER_DEPARTMENTS		= "C33";	// COURSE_MAJOR_MINOR (x29)
	public static final String EXPLAIN_GENEDCORE							= "C34";	// Gen Ed Core (x40)

	public static final String EXPLAIN_USER_COURSE_CHECKBOX1			= "C62";
	public static final String EXPLAIN_USER_COURSE_CHECKBOX2			= "C63";
	public static final String EXPLAIN_USER_COURSE_CHECKBOX3			= "C64";
	public static final String EXPLAIN_USER_COURSE_RADIOLIST1		= "C65";
	public static final String EXPLAIN_USER_COURSE_RADIOLIST2		= "C66";
	public static final String EXPLAIN_USER_COURSE_RADIOLIST3		= "C67";
	public static final String EXPLAIN_USER_COURSE_RADIOLIST4		= "C68";
	public static final String EXPLAIN_USER_COURSE_RADIOLIST5		= "C69";
	public static final String EXPLAIN_HONORS_COURSES					= "C70";

	public static final String COURSE_USER_WYSIWYG01					= "X92"; // UserList1
	public static final String COURSE_USER_WYSIWYG02					= "X93"; // UserList1
	public static final String COURSE_USER_WYSIWYG03					= "X94"; // UserList1

	public static final String COURSE_USER_CHECKBOX_1					= "X95"; // UserList1
	public static final String COURSE_USER_CHECKBOX_2					= "X96"; // UserList2
	public static final String COURSE_USER_CHECKBOX_3					= "X97"; // UserList3

	public static final String COURSE_USER_RADIO_LIST_1				= "X98"; // UserList1
	public static final String COURSE_USER_RADIO_LIST_2				= "X99"; // UserList2
	public static final String COURSE_USER_RADIO_LIST_3				= "X82"; // UserList3
	public static final String COURSE_USER_RADIO_LIST_4				= "X83"; // UserList4
	public static final String COURSE_USER_RADIO_LIST_5				= "X84"; // UserList5

	public static final String CAMPUS_USER_RADIO_LIST_1				= "C37"; // UserList1
	public static final String CAMPUS_USER_RADIO_LIST_2				= "C38"; // UserList2
	public static final String CAMPUS_USER_RADIO_LIST_3				= "C39"; // UserList3

	public static final String CAMPUS_USER_CHECKBOX_1					= "C47"; // UserList1
	public static final String CAMPUS_USER_CHECKBOX_2					= "C48"; // UserList2
	public static final String CAMPUS_USER_CHECKBOX_3					= "C49"; // UserList3

	public static final String COURSE_AAGEAREA_C40						= "C40"; // AAGEArea
	public static final String COURSE_AAGEAREA_C41						= "C41"; // AAGEArea
	public static final String COURSE_ASGEEXTRA_C42						= "C42"; // ASGEExtra
	public static final String COURSE_ASGEEXTRA_C43						= "C43"; // ASGEExtra

	// course status (must start with #1)
	public static final int APPROVAL 				= 1;
	public static final int MODIFY 					= 2;
	public static final int REVIEW 					= 3;
	public static final int REVIEW_IN_APPROVAL 	= 4;
	public static final int REVIEW_IN_REVIEW 		= 5;

	public static final int ALL_REVIEWERS			= 99;			// process all levels of reviewers

	public static final String REVIEWS								= "reviews";

	public static final String COURSE_APPROVE_TEXT				= "APPROVE";
	public static final String COURSE_APPROVAL_TEXT				= "APPROVAL";
	public static final String COURSE_APPROVAL_PENDING_TEXT	= "PENDING";
	public static final String COURSE_APPROVED_TEXT				= "APPROVED";
	public static final String COURSE_ASSESS_TEXT				= "ASSESS";
	public static final String COURSE_CREATE_TEXT				= "CREATE";
	public static final String COURSE_DELETE_TEXT				= "DELETE";
	public static final String COURSE_FAST_TRACKED 				= "FAST-TRACKED";
	public static final String COURSE_MODIFY_TEXT				= "MODIFY";
	public static final String COURSE_PENDING_TEXT				= "PENDING";
	public static final String COURSE_RECALLED 					= "RECALLED";
	public static final String COURSE_RENAME_TEXT				= "RENAME";
	public static final String COURSE_REVIEW_TEXT				= "REVIEW";
	public static final String COURSE_REVISE_TEXT				= "REVISE";
	public static final String COURSE_REVIEW_IN_APPROVAL 		= "REVIEW_IN_APPROVAL";
	public static final String COURSE_REVIEW_IN_DELETE 		= "REVIEW_IN_DELETE";
	public static final String COURSE_REVIEW_IN_REVIEW 		= "REVIEW_IN_REVIEW";

	public static final String MAIL_LOG						 		= "MAIL LOG";
	public static final String MAIL_LOG_TEXT						= "Mail Log";

	public static final String NOTIFICATION						= "NOTIFICATION";

	public static final String PROGRAM_RATIONALE					= "rationale";

	public static final String PROGRAM								= "program";
	public static final String PROGRAMS								= "programs";
	public static final String PROGRAM_APPROVAL_PENDING_TEXT	= "PENDING";
	public static final String PROGRAM_APPROVED_PROGRESS		= "APPROVED";
	public static final String PROGRAM_APPROVAL_PROGRESS		= "APPROVAL";
	public static final String PROGRAM_CREATE_PROGRESS			= "CREATE";
	public static final String PROGRAM_DELETE_PROGRESS			= "DELETE";
	public static final String PROGRAM_MODIFY_PROGRESS			= "MODIFY";
	public static final String PROGRAM_RECALLED 					= "RECALLED";
	public static final String PROGRAM_REVIEW_PROGRESS			= "REVIEW";
	public static final String PROGRAM_REVISE_PROGRESS			= "REVISE";
	public static final String PROGRAM_REVIEW_IN_APPROVAL 	= "REVIEW_IN_APPROVAL";
	public static final String PROGRAM_REVIEW_IN_DELETE 		= "REVIEW_IN_DELETE";
	public static final String PROGRAM_REVIEW_IN_REVIEW	 	= "REVIEW_IN_REVIEW";

	public static final String FND_APPROVAL_PENDING_TEXT		= "PENDING";
	public static final String FND_APPROVED_PROGRESS			= "APPROVED";
	public static final String FND_APPROVAL_PROGRESS			= "APPROVAL";
	public static final String FND_CANCEL_PROGRESS				= "CANCEL";
	public static final String FND_CREATE_PROGRESS				= "CREATE";
	public static final String FND_DELETE_PROGRESS				= "DELETE";
	public static final String FND_MODIFY_PROGRESS				= "MODIFY";
	public static final String FND_RECALLED 						= "RECALLED";
	public static final String FND_REVIEW_PROGRESS				= "REVIEW";
	public static final String FND_REVISE_PROGRESS				= "REVISE";
	public static final String FND_REVIEW_IN_APPROVAL 			= "REVIEW_IN_APPROVAL";
	public static final String FND_REVIEW_IN_DELETE 			= "REVIEW_IN_DELETE";
	public static final String FND_REVIEW_IN_REVIEW	 			= "REVIEW_IN_REVIEW";

	//
	// program messages
	//
	public static final String PROGRAM_APPROVAL_TEXT			= "Approve program";
	public static final String PROGRAM_APPROVAL_TEXT_NEW		= "Approve New Program";
	public static final String PROGRAM_APPROVAL_TEXT_EXISTING= "Approve Program Proposal";

	public static final String PROGRAM_APPROVED_TEXT			= "Program approved";
	public static final String PROGRAM_APPROVED_TEXT_NEW		= "New Program Approved";
	public static final String PROGRAM_APPROVED_TEXT_EXISTING= "Proposed Program Approved";

	public static final String PROGRAM_CREATE_TEXT				= "Create program";

	public static final String PROGRAM_DELETE_TEXT				= "Delete program";
	public static final String PROGRAM_DELETE_TEXT_EXISTING	= "Approve Program Delete";

	public static final String PROGRAM_MODIFY_TEXT				= "Modify program";
	public static final String PROGRAM_MODIFY_TEXT_NEW			= "Work on New Program";
	public static final String PROGRAM_MODIFY_TEXT_EXISTING	= "Modify Program Proposal";

	public static final String PROGRAM_REVIEW_TEXT				= "Review program";
	public static final String PROGRAM_REVIEW_TEXT_NEW			= "Review New Program";
	public static final String PROGRAM_REVIEW_TEXT_EXISTING	= "Review Program Proposal";

	public static final String PROGRAM_REVISE_TEXT				= "Revise program";
	public static final String PROGRAM_REVISE_TEXT_NEW			= "Revise New Program";
	public static final String PROGRAM_REVISE_TEXT_EXISTING	= "Revise Program Proposal";

	//
	// fnd messages
	//
	public static final String FOUNDATION							= "foundation";
	public static final String FND_APPROVAL_TEXT					= "Approve foundation course";
	public static final String FND_APPROVAL_TEXT_NEW			= "Approve New Foundation Course";
	public static final String FND_APPROVAL_TEXT_EXISTING		= "Approve Foundation Course Proposal";

	public static final String FND_APPROVED_TEXT					= "Foundation Course approved";
	public static final String FND_APPROVED_TEXT_NEW			= "New Foundation Course Approved";
	public static final String FND_APPROVED_TEXT_EXISTING		= "Proposed Foundation Course Approved";

	public static final String FND_CREATE_TEXT					= "Create foundation course";

	public static final String FND_DELETE_TEXT					= "Delete foundation course";
	public static final String FND_DELETE_TEXT_EXISTING		= "Approve Foundation Course Delete";

	public static final String FND_MODIFY_TEXT					= "Modify foundation course";
	public static final String FND_MODIFY_TEXT_NEW				= "Work on New Foundation Course";
	public static final String FND_MODIFY_TEXT_EXISTING		= "Modify Foundation Course Proposal";

	public static final String FND_REVIEW_TEXT					= "Review foundation course";
	public static final String FND_REVIEW_TEXT_NEW				= "Review New Foundation Course";
	public static final String FND_REVIEW_TEXT_EXISTING		= "Review Foundation Course Proposal";

	public static final String FND_REVISE_TEXT					= "Revise foundation course";
	public static final String FND_REVISE_TEXT_NEW				= "Revise New Foundation Course";
	public static final String FND_REVISE_TEXT_EXISTING		= "Revise Foundation Course Proposal";

	public static final String FND_MODIFICATION					= "Foundation Course Modification";

	//
	// course messages
	//
	public static final String APPROVAL_ROUTING					= "ApprovalRouting";
	public static final String FAST_TRACK_TEXT					= "Fast track approval";

	public static final String APPROVAL_PENDING_TEXT			= "Approval pending";
	public static final String DELETE_APPROVAL_PENDING_TEXT	= "Delete approval pending";

	public static final String APPROVAL_TEXT						= "Approve outline";
	public static final String APPROVAL_TEXT_NEW					= "Approve New Outline";
	public static final String APPROVAL_TEXT_EXISTING			= "Approve Outline Proposal";

	public static final String APPROVE_CROSS_LISTING_TEXT		= "Approve cross listing";
	public static final String APPROVE_REQUISITE_TEXT			= "Approve added requisite";
	public static final String APPROVE_PROGRAM_TEXT				= "Approve added program";
	public static final String APPROVE_FND_TEXT					= "Approve added foundation course";

	public static final String APPROVED_TEXT						= "Outline approved";
	public static final String APPROVED_TEXT_NEW					= "New Outline Approved";
	public static final String APPROVED_TEXT_EXISTING			= "Proposed Outline Approved";

	public static final String DELETE_TEXT							= "Delete outline";
	public static final String DELETE_TEXT_EXISTING				= "Delete Approved Outline";
	public static final String DELETED_TEXT						= "Outline deleted";

	public static final String MESSAGE_BOARD_TEXT				= "Message Board";

	public static final String MODIFY_TEXT							= "Modify outline";
	public static final String MODIFY_TEXT_NEW					= "Work on New Course Outline";
	public static final String MODIFY_TEXT_EXISTING				= "Modify Outline Proposal";

	public static final String METHODEVAL_TEXT					= "MethodEval";

	public static final String RENAME_REQUEST_TEXT				= "Rename/Renumber Pending Approval";
	public static final String RENAME_APPROVAL_TEXT				= "Approve Outline Rename/Renumber";

	public static final String REVIEW_TEXT							= "Review Outline";
	public static final String REVIEW_TEXT_NEW					= "Review New Outline";
	public static final String REVIEW_TEXT_EXISTING				= "Review Outline Proposal";

	public static final String REVISE_TEXT							= "Revise Outline";
	public static final String REVISE_TEXT_NEW					= "Revise New Outline";
	public static final String REVISE_TEXT_EXISTING				= "Revise Outline Proposal";

	public static final String APPROVE_SLO_TEXT					= "Approve SLO";
	public static final String REVIEW_SLO_TEXT					= "Review SLO";
	public static final String OUTLINE_MODIFICATION				= "Outline Modification";
	public static final String PROGRAM_MODIFICATION				= "Program Modification";
	public static final String SLO_ASSESSMENT_TEXT				= "SLO Assessment";

	public static final String MESSAGE_BOARD_REPLY				= "BOARD_REPLY";
	public static final String MESSAGE_BOARD_REPLY_TEXT		= "Message Board Reply";

	// alternating colors for table
	public static final String EVEN_ROW_BGCOLOR		= "#ffffff";
	public static final String ODD_ROW_BGCOLOR		= "#e5f1f4";
	public static final String HEADER_ROW_BGCOLOR	= "#e5f1f4";
	public static final String COLOR_STAND_OUT		= "#FFDC75";

	public static final String COLOR_LEFT				= "#F5F5F5";
	public static final String COLOR_RIGHT				= "#E4EFC7";

	// course type
	public static final int COURSETYPE_ARC = 0;
	public static final int COURSETYPE_CAN = 1;
	public static final int COURSETYPE_CUR = 2;
	public static final int COURSETYPE_PRE = 3;

	// FILE
	public static final String FILE_EXTENSIONS = "ai,asp,avi,bmp,com,csv,default.icon,dll,doc,exe,fla,gif,htm,html,jpg,js,jsp,mdb,mp3,pdf,php,png,ppt,rdp,swf,swt,sys,txt,vol,vsd,xls,xml,zip,docx,xlsx";

	// JOBS
	public static final String JOB_TITLES		= "Approval Status Reset,Campus Outlines Refresh,Create Outlines,Create Programs,Create Unmatched Course Records,Daily Jobs,Search Data,Table Refresh";
	public static final String JOB_NAMES 		= "ApprovalStatus,CampusOutlines,CreateOutlines,CreatePrograms,UnmatchedCourseRecord,DailyJob,SearchData,TableRefresh";
	public static final String JOB_FREQUENCY 	= "Non Stop,Non Stop,Once,Once,Non Stop,Non Stop,Once,Non Stop";

	// KIX index
	public static final int KIX_ALPHA 					= 0;
	public static final int KIX_NUM	 					= 1;
	public static final int KIX_TYPE 					= 2;
	public static final int KIX_PROPOSER 				= 3;
	public static final int KIX_CAMPUS 					= 4;
	public static final int KIX_HISTORYID 				= 5;
	public static final int KIX_ROUTE 					= 6;
	public static final int KIX_PROGRESS 				= 7;
	public static final int KIX_SUBPROGRESS			= 8;
	public static final int KIX_COURSETITLE			= 9;

	public static final int KIX_PROGRAM_TITLE 		= 0;
	public static final int KIX_PROGRAM_DIVISION	 	= 1;

	// course modifications has message page inserted between line items
	public static final String MESSAGE_PAGE = "MESSAGEPAGE0";

	// course must always be first
	public static final String MAIN_TABLES = "tblCourse,tblCampusData,tblCoreq,tblCourseComp,tblCourseCompAss,tblCourseContent,tblPreReq,tblXRef,tblCourseContentSLO,tblExtra,tblGenericContent,tblAttach";
	public static final String TEMP_TABLES = "tblTempCourse,tblTempCampusData,tblTempCoreq,tblTempCourseComp,tblTempCourseCompAss,tblTempCourseContent,tblTempPreReq,tblTempXRef,tblTempCourseContentSLO,tblTempExtra,tblTempGenericContent,tblTempAttach";

	// changing here requires change in Outlines.getTempTableSelects
	public static final String MANUAL_TABLES = "tblCourseACCJC,tblCourseCompetency,tblCourseLinked,tblCourseLinked2,tblGESLO";
	public static final String MANUAL_TEMP_TABLES = "tblTempCourseACCJC,tblTempCourseCompetency,tblTempCourseLinked,tblTempCourseLinked2,tblTempGESLO";

	// task roles
	public static final String TASK_ADD				= "ADD";
	public static final String TASK_ALL				= "ALL";
	public static final String TASK_APPROVAL		= "APPROVAL";
	public static final String TASK_APPROVE		= "APPROVE";
	public static final String TASK_APPROVER		= "APPROVER";
	public static final String TASK_CREATE			= "CREATE";
	public static final String TASK_DELETE			= "DELETE";
	public static final String TASK_EXISTING		= "EXISTING";
	public static final String TASK_MODIFY			= "MODIFY";
	public static final String TASK_NEW				= "NEW";
	public static final String TASK_PROPOSER		= "PROPOSER";
	public static final String TASK_REMOVE			= "REMOVE";
	public static final String TASK_REVIEWER		= "REVIEWER";
	public static final String TASK_REVIEW			= "REVIEW";
	public static final String TASK_REVISE			= "REVISE";

	public static final int		TASK_MESSAGE		= 0;
	public static final int		TASK_PROGRESS		= 1;
	public static final int		TASK_SRC				= 2;

	public static final String TASK_APPROVE_MODIFIED_OUTLINE		= "Approve modified outline";
	public static final String TASK_APPROVE_MODIFIED_PROGRAM		= "Approve modified program";
	public static final String TASK_APPROVE_MODIFIED_FND			= "Approve modified foundation course";

	public static final String TASK_APPROVE_PROPOSED_OUTLINE		= "Approve proposed outline";
	public static final String TASK_APPROVE_PROPOSED_PROGRAM		= "Approve proposed program";
	public static final String TASK_APPROVE_PROPOSED_FND			= "Approve foundation course";

	public static final String TASK_DELETE_PROPOSED_OUTLINE		= "Delete proposed outline";
	public static final String TASK_DELETE_PROPOSED_PROGRAM		= "Delete proposed program";
	public static final String TASK_DELETE_PROPOSED_FND			= "Delete proposed foundation course";

	public static final String TASK_DELETE_APPROVED_OUTLINE		= "Delete approved outline";
	public static final String TASK_DELETE_APPROVED_PROGRAM		= "Delete approved program";
	public static final String TASK_DELETE_APPROVED_FND			= "Delete foundation course";

	public static final String TASK_MODIFY_APPROVED_OUTLINE		= "Modify approved outline";
	public static final String TASK_MODIFY_APPROVED_PROGRAM		= "Modify approved program";
	public static final String TASK_MODIFY_APPROVED_FND			= "Modify approved foundation course";

	public static final String TASK_MODIFY_PROPOSED_OUTLINE		= "Modify proposed outline";
	public static final String TASK_MODIFY_PROPOSED_PROGRAM		= "Modify proposed program";
	public static final String TASK_MODIFY_PROPOSED_FND			= "Modify foundation course";

	public static final String TASK_REVIEW_APPROVED_OUTLINE		= "Review approved outline";
	public static final String TASK_REVIEW_APPROVED_PROGRAM		= "Review approved program";
	public static final String TASK_REVIEW_APPROVED_FND			= "Review approved foundation course";

	public static final String TASK_REVIEW_PROPOSED_OUTLINE		= "Review proposed outline";
	public static final String TASK_REVIEW_PROPOSED_PROGRAM		= "Review proposed program";
	public static final String TASK_REVIEW_PROPOSED_FND			= "Review foundation course";

	public static final String TASK_TEXT			= APPROVAL_TEXT
																+ "," + MODIFY_TEXT
																+ "," + REVIEW_SLO_TEXT
																+ "," + REVIEW_TEXT
																+ "," + SLO_ASSESSMENT_TEXT
																+ "," + APPROVE_SLO_TEXT
																+ "," + DELETE_TEXT
																+ "," + MAIL_LOG_TEXT
																+ "," + APPROVED_TEXT
																+ "," + MESSAGE_BOARD_TEXT
																+ "," + APPROVAL_PENDING_TEXT
																+ "," + APPROVE_REQUISITE_TEXT
																+ "," + APPROVE_CROSS_LISTING_TEXT
																+ "," + PROGRAM_MODIFY_TEXT
																+ "," + PROGRAM_CREATE_TEXT
																+ "," + PROGRAM_APPROVAL_TEXT
																+ "," + APPROVE_PROGRAM_TEXT
																+ "," + PROGRAM_APPROVED_TEXT
																+ "," + PROGRAM_REVIEW_TEXT
																+ "," + FND_MODIFY_TEXT
																+ "," + FND_CREATE_TEXT
																+ "," + FND_APPROVAL_TEXT
																+ "," + APPROVE_FND_TEXT
																+ "," + FND_APPROVED_TEXT
																+ "," + FND_REVIEW_TEXT
																;

	public static final String APPROVAL_TEXT_SRC						= "crsappr";
	public static final String MODIFY_TEXT_SRC						= "crsedt";
	public static final String REVIEW_SLO_TEXT_SRC					= "crsrwslo";
	public static final String REVIEW_TEXT_SRC						= "crsrvwer";
	public static final String SLO_ASSESSMENT_TEXT_SRC				= "crsslo";
	public static final String APPROVE_SLO_TEXT_SRC					= "crsslo";
	public static final String DELETE_TEXT_SRC						= "crsappr";
	public static final String MAIL_LOG_TEXT_SRC						= "mailq";
	public static final String APPROVED_TEXT_SRC						= "taskq";
	public static final String MESSAGE_BOARD_TEXT_SRC				= "forum/displaymsg";
	public static final String APPROVAL_PENDING_TEXT_SRC			= "crsapprpnd";
	public static final String APPROVE_REQUISITE_TEXT_SRC			= "apprrqst";
	public static final String APPROVE_CROSS_LISTING_TEXT_SRC	= "apprrqst";

	public static final String PROGRAM_MODIFY_TEXT_SRC				= "prgedt";
	public static final String PROGRAM_CREATE_TEXT_SRC				= "prgedt";
	public static final String PROGRAM_APPROVAL_TEXT_SRC			= "prgappr";
	public static final String APPROVE_PROGRAM_TEXT_SRC			= "apprrqst";
	public static final String PROGRAM_APPROVED_TEXT_SRC			= "taskq";
	public static final String PROGRAM_REVIEW_TEXT_SRC				= "prgrvwer";

public static final String FND_MODIFY_TEXT_SRC					= "fndedt";
public static final String FND_CREATE_TEXT_SRC					= "fndedt";
public static final String FND_APPROVAL_TEXT_SRC				= "fndappr";
public static final String APPROVE_FND_TEXT_SRC					= "apprrqst";
public static final String FND_APPROVED_TEXT_SRC				= "taskq";
public static final String FND_REVIEW_TEXT_SRC					= "fndrvwer";

	public static final String MESSAGE_BOARD_REPLY_SRC				= "msgbrd";
	public static final String RENAME_REQUEST_TEXT_SRC				= "rnm";
	public static final String RENAME_APPROVAL_TEXT_SRC			= "rnma";

	public static final String TASK_SOURCE			= "crsappr"
																+ ",crsedt"
																+ ",crsrwslo"
																+ ",crsrvwer"
																+ ",crsslo"
																+ ",crsslo"
																+ ",crsappr"
																+ ",mailq"
																+ ",taskq"
																+ ",forum/displaymsg"
																+ ",crsapprpnd"
																+ ",apprrqst"
																+ ",apprrqst"
																+ ",prgedt"
																+ ",prgedt"
																+ ",prgappr"
																+ ",apprrqst"
																+ ",taskq"
																+ ",prgrvwer"
+ ",fndedt"
+ ",fndedt"
+ ",fndappr"
+ ",apprrqst"
+ ",taskq"
+ ",fndrvwer"
																+ ",msgbrd"
																+ ",rnm"
																+ ",rnm_a"
																;

	public static final String TASK_TYPE			= "PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",CUR"
																+ ",CUR"
																+ ",PRE"
																+ ",PRE"
																+ ",CUR"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",CUR"
																+ ",PRE"
+ ",PRE"
+ ",PRE"
+ ",PRE"
+ ",PRE"
+ ",CUR"
+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																+ ",PRE"
																;

	public static final String TASK_KIX				= "0"
																+ ",1"
																+ ",0"
																+ ",0"
																+ ",1"
																+ ",1"
																+ ",1"
																+ ",1"
																+ ",1"
																+ ",0"
																+ ",0"
																+ ",0"
																+ ",0"
																+ ",1"
																+ ",1"
																+ ",1"
																+ ",0"
																+ ",1"
																+ ",1"
+ ",0"
+ ",1"
+ ",1"
+ ",1"
+ ",0"
+ ",1"
																+ ",1"
																+ ",0"
																+ ",0"
																;

	public static final String TBLTEMPCOURSEACCJC = "Campus,CourseAlpha,CourseNum,CourseType,ContentID,CompID,Assessmentid,ApprovedDate,AssessedDate,AssessedBy,AuditDate,auditby,historyid";
	public static final String TBLTEMPCOURSECOMPETENCY = "historyid,seq,campus,coursealpha,coursenum,coursetype,content,auditdate,auditby,rdr";
	public static final String TBLCOURSELINKED = "campus,historyid,src,seq,dst,coursetype,auditdate,auditby,ref";
	public static final String TBLCOURSELINKED2 = "historyid,id,item,coursetype,auditdate,auditby,item2";
	public static final String TBLGESLO = "campus,historyid,geid,slolevel,sloevals,auditby,auditdate,coursetype";

	public static final int TBLTEMPCOURSEACCJC_INDEX = 0;
	public static final int TBLTEMPCOURSECOMPETENCY_INDEX = 1;
	public static final int TBLCOURSELINKED_INDEX = 2;
	public static final int TBLCOURSELINKED2_INDEX = 3;
	public static final int TBLGESLO_INDEX = 4;

	// database type
	public static final int DATABASE_DRIVER_ACCESS			= 0;
	public static final int DATABASE_DRIVER_ACCESSSQL		= 1;
	public static final int DATABASE_DRIVER_ORACLE			= 2;
	public static final int DATABASE_DRIVER_SQL				= 3;

	public static final String DATABASE_DRIVER_ACCESS_NAME		= "Access";
	public static final String DATABASE_DRIVER_ACCESSSQL_NAME	= "Access";
	public static final String DATABASE_DRIVER_ORACLE_NAME		= "Oracle";
	public static final String DATABASE_DRIVER_SQL_NAME			= "SQL";

	// notification defaults. PROP_DEFAULTSX is matching order of PROP_DEFAULTS and comes
	// from tblCourse
	public static final String PROP_DEFAULTS = "ALPHA,CAMPUS,NUM,PROPOSER";
	public static final String PROP_DEFAULTSX = "coursealpha,campus,coursenum,proposer";

	// outline reject (revise) constant
	public static final String REJECT_START_WITH_REJECTER		= "0";
	public static final String REJECT_START_FROM_BEGINNING	= "1";
	public static final String REJECT_STEP_BACK_ONE				= "2";
	public static final String REJECT_APPROVER_SELECTS			= "3";

	// report type
	public static final int REPORT_TO_CSV						= 0;
	public static final int REPORT_TO_FILE						= 1;
	public static final int REPORT_TO_HTML						= 2;
	public static final int REPORT_TO_PDF						= 3;
	public static final int REPORT_TO_RTF						= 4;
	public static final int REPORT_TO_XLS						= 5;

	// requisites type
	public static final int REQUISITES_PREREQ					= 0;
	public static final int REQUISITES_COREQ					= 1;

	// SLO progress
	public static final String SLO_PROGRESS = "APPROVAL,APPROVED,ASSESS,ASSESSED,REVIEW,COMPLETED,FINALIZED";
	public static final int SLO_PROGRESS_REVIEW		= 0;
	public static final int SLO_PROGRESS_ASSESS		= 1;
	public static final int SLO_PROGRESS_ASSESSED	= 2;
	public static final int SLO_PROGRESS_APPROVAL	= 3;
	public static final int SLO_PROGRESS_APPROVED	= 4;
	public static final int SLO_PROGRESS_COMPLETED	= 5;
	public static final int SLO_PROGRESS_FINALIZED	= 6;

	public static final int SLO_QUESTION_COUNT 			= 7;
	public static final int SLO_ASSESS_QUESTION_COUNT 	= 4;
	public static final int SLO_FINAL_QUESTION_COUNT 	= 7;

	public static final int TAB_COUNT 			= 6;
	public static final int TAB_BANNER 			= 0;
	public static final int TAB_COURSE 			= 1;
	public static final int TAB_CAMPUS 			= 2;
	public static final int TAB_STATUS 			= 3;
	public static final int TAB_FORMS 			= 4;
	public static final int TAB_ATTACHMENT 	= 5;

	public static final int TAB_FOUNDATION		= 99;
	public static final int TAB_PROGRAM 		= -1;

	public static final String TABLE_START = "<table width=\"96%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
	public static final String TABLE_END = "</table>";

	public static final String TABLE_ROW_START_HIGHLIGHT = "<tr height=\"20\" bgcolor=\"#e1e1e1\">";
	public static final String TABLE_ROW_START = "<tr height=\"20\">";
	public static final String TABLE_ROW_END = "</tr>";

	public static final String TABLE_CELL_LINK_COLUMN 				= "<td class=\"linkcolumn\" valign=\"top\">";
	public static final String TABLE_CELL_DATA_COLUMN 				= "<td class=\"datacolumn\" valign=\"top\">";
	public static final String TABLE_CELL_DATA_COLUMN_RIGHT 		= "<td class=\"dataColumnRight\" valign=\"top\" align=\"right\">";
	public static final String TABLE_CELL_HEADER_COLUMN 			= "<td class=\"textblackth\" valign=\"top\">";
	public static final String TABLE_CELL_HEADER_COLUMN_RIGHT	= "<td class=\"textblackTHRight\" valign=\"top\" align=\"right\">";

	public static final String TABLE_CELL_END = "</td>";

	public static final String TABLE_CAMPUS 	= "c";
	public static final String TABLE_COURSE 	= "r";
	public static final String TABLE_PROGRAM 	= "p";

	// stmp
	public static final String SMTP_05045 = "mail.ficoh.net";
	public static final String SMTP_B6400 = "mail.hawaii.edu";
	public static final String SMTP_SZHI03 = "smtp-server.hawaii.rr.com";
	public static final String SMTP_DOMAIN = "@hawaii.edu";

	// date and time
	public static final int DATE_LONG			= 1;
	public static final int DATE_SHORT			= 2;
	public static final int DATE_DEFAULT		= 3;
	public static final int DATE_TIME			= 4;
	public static final int DATE_DATE_YMD		= 5;
	public static final int DATE_DATE_MDY		= 6;
	public static final int DATE_DATE_DMY		= 7;
	public static final int DATE_DATETIME		= 8;

	// user levels
	public static final int USER									= 0;
	public static final int FACULTY								= 1;
	public static final int CAMPADM								= 2;
	public static final int SYSADM								= 3;

	public static final String SYSADM_NAME						= "THANHG";
	public static final String ANONYMOUS						= "ANONYMOUS";

	// validation type
	public static final int VALIDATE_ADDRESS 		= 0;
	public static final int VALIDATE_EMAIL 		= 1;
	public static final int VALIDATE_CITY 			= 2;
	public static final int VALIDATE_FIRSTNAME 	= 4;
	public static final int VALIDATE_LASTNAME 	= 5;
	public static final int VALIDATE_NUMERIC 		= 6;
	public static final int VALIDATE_PASSWORD 	= 7;
	public static final int VALIDATE_PHONE 		= 8;
	public static final int VALIDATE_SSN 			= 9;
	public static final int VALIDATE_STATE 		= 10;
	public static final int VALIDATE_URL 			= 11;
	public static final int VALIDATE_ZIP 			= 12;

	public static final String IMPORT_COREQ		= "COREQ";
	public static final String IMPORT_GESLO		= "GESLO";
	public static final String IMPORT_ILO			= "ILO";
	public static final String IMPORT_PLO			= "PSLO";
	public static final String IMPORT_PREREQ		= "PREREQ";
	public static final String IMPORT_SLO			= "SLO";
	public static final String IMPORT_XLIST		= "XLIST";

	/**
	 * GetImportFriendlyName - returns the column equivalent of import values
	 * <p>
	 * @param	dst		String
	 * <p>
	 * @return	String
	 */
	public static String GetImportFriendlyName(String dst){

		if (dst.equals(Constant.IMPORT_COREQ))
			dst = Constant.COURSE_COREQ;
		else if (dst.equals(Constant.IMPORT_GESLO))
			dst = Constant.COURSE_GESLO;
		else if (dst.equals(Constant.IMPORT_ILO))
			dst = Constant.COURSE_INSTITUTION_LO;
		else if (dst.equals(Constant.IMPORT_PLO))
			dst = Constant.COURSE_PROGRAM_SLO;
		else if (dst.equals(Constant.IMPORT_PREREQ))
			dst = Constant.COURSE_PREREQ;
		else if (dst.equals(Constant.IMPORT_SLO))
			dst = Constant.COURSE_OBJECTIVES;
		else if (dst.equals(Constant.IMPORT_XLIST))
			dst = Constant.COURSE_CROSSLISTED;

		return dst;
	}

	/**
	 * GetLinkedDestinationFullName - 	returns destination name as for example,
	 * 											Assess,GESLO,Competency,Content,MethodEval,Objectives,PSLO
	 * <p>
	 * @param	dst		String
	 * <p>
	 * @return	String
	 */
	public static String GetLinkedDestinationFullName(String dst){

		if (dst.equals(Constant.IMPORT_COREQ))
			dst = Constant.IMPORT_COREQ;
		else if (dst.equals(Constant.COURSE_COMPETENCIES))
			dst = "Competency";
		else if (dst.equals(Constant.COURSE_CONTENT))
			dst = "Content";
		else if (dst.equals(Constant.COURSE_GESLO))
			dst = "GESLO";
		else if (dst.equals(Constant.COURSE_INSTITUTION_LO))
			dst = "ILO";
		else if (dst.equals(Constant.COURSE_METHODEVALUATION))
			dst = "MethodEval";
		else if (dst.equals(Constant.COURSE_OBJECTIVES))
			dst = "Objectives";
		else if (dst.equals(Constant.IMPORT_PREREQ))
			dst = Constant.IMPORT_PREREQ;
		else if (dst.equals(Constant.COURSE_PROGRAM_SLO) || dst.equals(Constant.IMPORT_PLO))
			dst = "PSLO";
		else if (dst.equals(Constant.IMPORT_XLIST))
			dst = Constant.IMPORT_XLIST;

		return dst;
	}

	/**
	 * getAlternateName - some src items started out with different names so we must accommodate
	 * <p>
	 * @param	src		String
	 * <p>
	 * @return	String
	 */
	public static String getAlternateName(String src){

		String src2 = src;

		if (src.equals(Constant.COURSE_PROGRAM_SLO)){
			src2 = Constant.IMPORT_PLO;
		}
		else if (src.equals(Constant.COURSE_INSTITUTION_LO)){
			src2 = Constant.IMPORT_ILO;
		}

		return src2;
	}

	public Constant() throws Exception {}

	public static String getMainTables(){
		return MAIN_TABLES;
	}

}