/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.io;

import java.util.Locale;

public class ImportConstant {

	public final static int IMPORT_EMPTY 					= 0;
	public final static int IMPORT_FILE 					= 1;
	public final static int IMPORT_TYPE 					= 2;
	public final static int IMPORT_APPLICATION 			= 3;
	public final static int IMPORT_APPLICATION_TYPE 	= 4;
	public final static int IMPORT_FREQUENCY 				= 5;
	public final static int IMPORT_CONFIRMATION			= 6;
	public final static int IMPORT_PROCESS					= 7;

	// this ordering has to do with the full text and not the abbreviated version
	public final static int IMPORT_COREQ 					= 8;
	public final static int IMPORT_XLIST 					= 9;
	public final static int IMPORT_GESLO 					= 10;
	public final static int IMPORT_ILO						= 11;
	public final static int IMPORT_PREREQ					= 12;
	public final static int IMPORT_PLO						= 13;
	public final static int IMPORT_SLO 						= 14;

	public final static int IMPORT_COURSE_OUTLINE		= 15;
	public final static int IMPORT_COURSE_ALPHA			= 16;
	public final static int IMPORT_DIV_DEPT				= 17;
	public final static int IMPORT_PROGRAM					= 18;
	public final static int IMPORT_DEGREE					= 19;

	public final static String IMPORT_COREQ_DATA			= "COREQ";
	public final static String IMPORT_XLIST_DATA			= "XLIST";
	public final static String IMPORT_PREREQ_DATA		= "PREREQ";
	public final static String IMPORT_GESLO_DATA			= "GESLO";
	public final static String IMPORT_ILO_DATA			= "ILO";
	public final static String IMPORT_PLO_DATA			= "PSLO";
	public final static String IMPORT_SLO_DATA			= "SLO";

	public final static String IMPORT_IMMEDIATE			= "Immediate";
	public final static String IMPORT_ON_CREATE			= "On Create";

	public final static String IMPORT_TEXT =
					"0,"														// 0
					+ "File Upload,"										// 1
					+ "Import Type,"										// 2
					+ "Application,"										// 3
					+ "Application Type,"								// 4
					+ "Frequency,"											// 5
					+ "Confirmation,"										// 6
					+ "Process,"											// 7

					+ "Co-Requisite,"										// 8
					+ "Cross Listed,"										// 9
					+ "General Education SLO (GESLO),"				// 10
					+ "Institution Learning Outcomes (ILO),"		// 11
					+ "Pre-Requisite,"									// 12
					+ "Program Learning Outcomes (PLO)," 			// 13
					+ "Student Learning Outcomes (SLO),"			// 14

					+ "Course Outline,"									// 15
					+ "Course Alpha,"										// 16
					+ "Division/Department,"							// 17
					+ "Program,"											// 18
					+ "Degree";												// 19

	public ImportConstant() throws Exception {}

}