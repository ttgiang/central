/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public boolean spamy(String str)
 *
 * @author ttgiang
 */

This document describes the process for creating a report properties file

The body of the file contains the following:

	reportType=ApprovalRouting
	reportTitle=CURRICULUM CENTRAL
	reportSubTitle=Approval Routing
	colsWidth=20f,10f,10f,60f
	headerColumns=Proposer,Alpha,Number,Title
	dataColumns=proposer,coursealpha,coursenum,coursetitle
	sql=SELECT proposer,coursealpha,coursenum,coursetitle FROM tblCourse
	where=
	grouping=
	order=CourseAlpha,CourseNum
	parm1=campus
	parm2=
	parm3=
	parm4=
	parm5=
	parm6=
	parm7=route
	parm8=
	parm9=
	footer=

PARMS
-----
parm1-parm9 are set as follows:

parm1 = campus; parm2 = alpha; parm3 = num; parm4 = type; parm5 = user;
parm6 = historyid; parm7 = route;
parm8 =
parm9 = is open for a single value; parm9 is used to hold a column name
	and when called by the report object, parm9 is set as part of the SQL build statement;
	the data from the URL is then used for the prepared statement.

WHERE
-----
	if a WHERE clause is required, use the following format
	
	category_EQUALS_'System' AND kedit_EQUALS_'Y' 
	
	