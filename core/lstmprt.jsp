<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstmprt.jsp	- generic import
	*	2007.09.01
	**/

	// when doing mass import, cannot have PENDING APPROVAL on CUR. That's after the fact.

	// importGenericData uses input to values. what is the last argument supposed to be? PSLO or X??

	/*
		import should not bother with email approval for pre/co reqs

		if (itm.equals(Constant.COURSE_GESLO))
			listType = "GESLO";
		else if (itm.equals(Constant.COURSE_INSTITUTION_LO))
			listType = "ILO";
		else if (itm.equals(Constant.COURSE_PROGRAM_SLO))
			listType = "PLO"; OR IS IT PSLO
		else if (itm.equals(Constant.COURSE_OBJECTIVES))
			listType = "SLO"; OR IS IT objectives

		should clear from table if import is scheduled for on create. can't append and cause list to grow on


// for an alpha (VIET), locate the division where it belongs and if found, add the PLO for that division to a newly created outline
SELECT     tblChairs.id, tblChairs.programid, tblChairs.coursealpha, tblDivision.divisioncode, tblDivision.divisionname, tblDivision.campus
FROM         tblChairs INNER JOIN
                      tblDivision ON tblChairs.programid = tblDivision.divid
WHERE     (tblChairs.coursealpha = 'VIET') AND (tblDivision.campus = 'KAP')

	*/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","lstmprt");

	// this is in case the form doesn't know how to return here from submission processing
	session.setAttribute("aseCallingPage","lstmprt");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "List Import";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="js/lstmprt.js"></script>

	<link rel="stylesheet" href="/central/inc/helppopup.css">
	<link rel="stylesheet" href="/central/inc/upload.css">

	<style type="text/css">

		table.example{
			color:#000000;
			background-color:#e5eecc;
			padding-top:8px;
			padding-bottom:8px;
			padding-left:10px;
			padding-right:10px;
			border:1px solid #d4d4d4;
			background-image:url('bgfadegreen.gif');
			background-repeat:repeat-x;
		}

		table.example_code{
			background-color:#ffffff;
			padding:4px;
			border:1px solid #d4d4d4;
		}

		table.example_code td{
			font-size:110%;
		}

		table.example_result{
			background-color:#ffffff;
			padding:4px;
			border:1px solid #d4d4d4;
		}

		table.code{
			outline:1px solid #d4d4d4;
			border:5px solid #e5eecc;
		}

		table.code td{
			font-size:100%;
			background-color:#FFFFFF;
			border:0px solid #d4d4d4;
			padding:4px;
		}

		h1 {font-size:200%;margin-top:0px;font-weight:normal}
		h2 {font-size:160%;margin-top:10px;margin-bottom:10px;font-weight:normal}
		h3 {font-size:120%;font-weight:normal}
		h4 {font-size:100%;}
		h5 {font-size:90%;}
		h6 {font-size:80%;}

		h4.tutheader{
			margin:0px;
			margin-top:30px;
			padding-top:2px;
			padding-bottom:2px;
			padding-left:4px;
			color:#303030;
			border:1px solid #d4d4d4;
			background-color:#ffffff;
			background-image:url('../images/gradientfromtop.gif');
			background-repeat:repeat-x;
			background-position:0px -50px;
		}

	</style>

	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;	/* Never change this one */
			width:320px;	/* Width of box */
			height:250px;	/* Height of box */
			overflow:auto;	/* Scrolling features */
			border:1px solid #317082;	/* Dark green border */
			background-color:#FFF;		/* White background color */
			text-align:left;
			font-size:.9em;
			z-index:100;
		}
		#ajax_listOfOptions div{	/* General rule for both .optionDiv and .optionDivSelected */
			margin:1px;
			padding:1px;
			cursor:pointer;
			font-size:0.9em;
		}
		#ajax_listOfOptions .optionDiv{	/* Div for each item in list */

		}
		#ajax_listOfOptions .optionDivSelected{ /* Selected item in the list */
			background-color:#317082;
			color:#FFF;
		}
		#ajax_listOfOptions_iframe{
			background-color:#F00;
			position:absolute;
			z-index:5;
		}

		form{
			display:inline;
		}
	</style>

	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%

	if (processPage){
		out.println(process(request,response));
	}

	asePool.freeConnection(conn,"lstmprt",user);
%>

<%!
	public static String process(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		WebSite website = new WebSite();

		String message = "";

		String cmdNext = website.getRequestParameter(request,"aseUpload","");
		String cmdPrev = website.getRequestParameter(request,"asePrev","");

		// when called from a menu selection, start clean to prevent session corruption
		String mnu = website.getRequestParameter(request,"mnu","0");
		if (mnu.equals(Constant.ON)){
			session.setAttribute("aseListImportHashMap",null);
			session.setAttribute("aseListImportNextStep",null);
			session.setAttribute("aseListImportMessage",null);
		}

		// retrieve saved progress
		HashMap hashMap = null;
		if ((HashMap)session.getAttribute("aseListImportHashMap") != null){
			hashMap = (HashMap)session.getAttribute("aseListImportHashMap");
		}
		else{
			hashMap = new HashMap();
		} // hashmap

		int nextStep = website.getRequestParameter(request,"aseListImportNextStep",1,true);
		int prevStep = website.getRequestParameter(request,"aseListImportPrevStep",1,true);

		// don't allow null or no step
		// if not null, make sure data was entered before allowing to move on. If not, keep to same step
		// with nextStep held in session, an F5 to refresh causes nextStep t0 go up by 1 and move
		// to the next screen in error
		if (nextStep == 0){
			nextStep = 1;
		}

		if (prevStep == 0){
			prevStep = 1;
		}

		// depending on direction, set the driving variable for switch statement
		String direction = "";
		int formDirection = 1;
		if (!cmdNext.equals(Constant.BLANK)){
			direction = "next";
			formDirection = nextStep;
		}
		else if (!cmdPrev.equals(Constant.BLANK)){
			direction = "back";
			formDirection = prevStep;
		}
		else{
			direction = "next";
			formDirection = nextStep;
		}

		session.setAttribute("aseListImportDirection",direction);

		// do not combine with above if statement for next step
		if (nextStep > 0){

			// type of input from form submission
			String frmInputType = website.getRequestParameter(request,"frmInputType","");

			// data from form submission
			String aseListImportField = website.getRequestParameter(request,"aseListImportField","");

			if (nextStep == 2){
				String aseUserUploadFilename = website.getRequestParameter(request,"aseUserUploadFilename","",true);
				aseListImportField = aseUserUploadFilename;
			}

			// make sure data was entered and it's not the last screen or here for the first time.
			// missing input data before allowing to move on
			if (	aseListImportField.equals(Constant.BLANK) &&
					((nextStep-1) != com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION) &&
					!direction.equals("back") &&
					!mnu.equals(Constant.ON)){

				--nextStep;

				// prevent out of bounds
				if (nextStep < 1){
					nextStep = 1;
				}

				// update session data
				setMessage(session,nextStep,prevStep);
			}
			else{

				// -1 because this is after form submission and we need to save data
				switch(nextStep-1){

					case com.ase.aseutil.io.ImportConstant.IMPORT_FILE:
						hashMap.put("filename",aseListImportField);
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_TYPE:
						hashMap.put("importType",aseListImportField);
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION:
						String alphaID = website.getRequestParameter(request,"alphaID","");
						String numberID = website.getRequestParameter(request,"numberID","");
						String alphaOnlyID = website.getRequestParameter(request,"alphaOnlyID","");
						String departmentID = website.getRequestParameter(request,"departmentID","");
						String programID = website.getRequestParameter(request,"programID","");
						String degreeID = website.getRequestParameter(request,"degreeID","");
						String allInputKeys = alphaID + numberID + alphaOnlyID + departmentID + programID + degreeID;

						if (allInputKeys.equals(Constant.BLANK)){
							--nextStep;

							// prevent out of bounds
							if (nextStep < 1){
								nextStep = 1;
							}

							setMessage(session,nextStep,prevStep);
						}
						else{
							hashMap.put("application",aseListImportField);
							hashMap.put("alphaID",website.getRequestParameter(request,"alphaID",""));
							hashMap.put("numberID",website.getRequestParameter(request,"numberID",""));
							hashMap.put("alphaOnlyID",website.getRequestParameter(request,"alphaOnlyID",""));
							hashMap.put("departmentID",website.getRequestParameter(request,"departmentID",""));
							hashMap.put("programID",website.getRequestParameter(request,"programID",""));
							hashMap.put("degreeID",website.getRequestParameter(request,"degreeID",""));
						}

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION_TYPE:
						hashMap.put("applicationType",aseListImportField);
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_FREQUENCY :
						hashMap.put("frequency",aseListImportField);
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION:
						hashMap.put("confirm",aseListImportField);
						break;

					default:
						break;

				} // switch

				// update session data
				session.setAttribute("aseListImportHashMap",(HashMap)hashMap);

			} // aseListImportField == blank

			// only process up to the confirmation screen
			if (nextStep <= com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION){
				message = processImportOptions(request,response);
			}
			else{

				AsePool connectionPool = null;

				Connection conn = null;

				try{
					connectionPool = connectionPool = AsePool.getInstance();

					conn = connectionPool.getConnection();

					com.ase.aseutil.util.HashUtil hashUtil = new com.ase.aseutil.util.HashUtil();
					int importType = hashUtil.getHashMapParmValue(hashMap,"importType",0);
					hashUtil = null;

					if (importType == com.ase.aseutil.io.ImportConstant.IMPORT_COREQ){
						message = importSimpleData(conn,Constant.IMPORT_COREQ,session);
					}
					else if (importType == com.ase.aseutil.io.ImportConstant.IMPORT_PREREQ){
						message = importSimpleData(conn,Constant.IMPORT_PREREQ,session);
					}
					else if (importType == com.ase.aseutil.io.ImportConstant.IMPORT_XLIST){
						message = importSimpleData(conn,Constant.IMPORT_XLIST,session);
					}
					else{
						message = importGenericData(request,response);
					} // importType

					message = "<p align=\"left\">"
						+ message
						+ "<br><br>"
						+ "<a href=\"/central/core/lstmprt.jsp?mnu=1\" class=\"linkcolumn\">import more data</a>"
						+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
						+ "<a href=\"/central/core/tasks.jsp\" class=\"linkcolumn\">return to task listing</a>"
						+ "<br/>"
						+ "</p>";
				}
				catch(Exception e){
					logger.fatal("Process: " + e.toString());
				}
				finally {
					connectionPool.freeConnection(conn);
				} // try

			} // nextStep <= IMPORT_CONFIRMATION

		} // if nextStep

		return message;
	}

	/*
	 * setMessage
	 * <p>
	 * @param	session	HttpSession
	 * @param	nextStep	int
	 * <p>
	 * @return
	 */
	public static void setMessage(HttpSession session,int nextStep,int prevStep) {
		session.setAttribute("aseListImportMessage",
									"<img src=\"../images/err_alert.gif\" border=\"0\">Please make a valid selection or provide appropriate input <br>before proceeding to the next step!");

		session.setAttribute("aseListImportNextStep",""+nextStep);
		session.setAttribute("aseListImportPrevStep",""+prevStep);
	}

	/*
	 * importSimpleData - for input of xlist, co and pre requisites
	 * <p>
	 * @param	conn			Connection
	 * @param	importType	String
	 * @param	session		HttpSession
	 * <p>
	 * @return String
	 */
	public static String importSimpleData(Connection conn,String importType,HttpSession session) {

Logger logger = Logger.getLogger("test");

		String temp = "";

		try {

			String campus = Util.getSessionMappedKey(session,"aseCampus");
			String user = Util.getSessionMappedKey(session,"aseUserName");

			// get session data and determine what type of import as well as where to apply
			com.ase.aseutil.io.ImportMap im = new com.ase.aseutil.io.ImportMap(session);

			if (im != null){
				String frequency = im.getFrequency();
				String alpha = im.getAlphaID();
				String filename = im.getFilename();

				// At this time, Pre, Co-requisites and XList are allowed for immediate import only
				if (frequency.equalsIgnoreCase(com.ase.aseutil.io.ImportConstant.IMPORT_IMMEDIATE)){
					temp = importSimpleData01(conn,importType,session);
				}
				else if (frequency.equalsIgnoreCase(com.ase.aseutil.io.ImportConstant.IMPORT_ON_CREATE)){
					//
				} // frequency

			} // im != null

			im = null;

		} catch (Exception e) {
			logger.fatal("Import Exception: importSimpleData - " + e.toString());
		}

		return temp;
	}

	/*
	 * importSimpleData01 - for input of xlist, co and pre requisites
	 * <p>
	 * @param	conn			Connection
	 * @param	importType	String
	 * @param	session		HttpSession
	 * <p>
	 * @return String
	 */
	public static String importSimpleData01(Connection conn,String importType,HttpSession session) {

Logger logger = Logger.getLogger("test");

boolean debug = true;

		String temp = "";

		int rowsAffected = 0;

		String kix = null;
		String progress = null;

		// for log file
		FileWriter fstream = null;
		BufferedWriter output = null;

		int applicationID = 0;
		String applicationX = "";
		String alphaOnlyID = "";
		String frequency = "";
		String fileName = "";

		String campus = Util.getSessionMappedKey(session,"aseCampus");
		String user = Util.getSessionMappedKey(session,"aseUserName");

		// get session data and determine what type of import as well as where to apply
		com.ase.aseutil.io.ImportMap im = new com.ase.aseutil.io.ImportMap(session);

		try {

			String logFileName = user + "_" + SQLUtil.createHistoryID(1);

			if (im != null){
				applicationID = im.getApplicationAsInt();
				applicationX = im.getApplicationX();
				alphaOnlyID = im.getAlphaOnlyID();
				frequency = im.getFrequency();
				fileName = im.getFilename();
			}

			// where to find the file
			String currentDrive = AseUtil.getCurrentDrive() + ":";
			String documents = SysDB.getSys(conn,"documents");
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			// actual file name - all written to centraldocs/temp folder
			String logFile = logFileName + ".htm";
			String logFileURL = logFileName + ".htm";

			// file variables
			File aFile = null;
			BufferedReader input = null;

			// for data processing
			String line = null;
			String[] aLine = null;

			// stats
			int recordsRead = 0;
			int recordsSuccess = 0;
			int recordsFailed = 0;

			String type = "CUR";

			// number of columns
			int numberOfColumns = 0;

			try {
				com.ase.aseutil.io.Tables tables = new com.ase.aseutil.io.Tables();
				tables = com.ase.aseutil.io.TablesDB.getTable(conn,importType);
				if (tables != null){
					numberOfColumns = tables.getImportColumns();
				}

				// link to log file
				logFileURL = documentsURL + "temp/" + logFile;

				// log file
				logFile = currentDrive + documents + "temp\\" + logFile;

				if (debug) {
					logger.info("Import - importSimpleData ("+importType+"): " + fileName);
					logger.info("Import - logFileURL: " + logFileURL);
					logger.info("Import - logFile: " + logFile);
				}

				// open file for processing
				aFile = new File(fileName);

				if (aFile.exists()){
					if (debug) logger.info("Import - file opened for processing");

					// create file to write progress
					fstream = new FileWriter(logFile);

					if (fstream != null){
						output = new BufferedWriter(fstream);

						output.write("User name: " + user + Html.BR() + "\n");
						output.write("Campus: " + campus + Html.BR() + "\n");
						output.write("Import Type: " + importType + Html.BR() + "\n\n");
						output.write("Applies To: " + applicationX + Html.BR() + "\n\n");

						output.write(Html.BR() + importType + ": processing started..." + Html.BR() + Html.BR() + "\n\n");
					} // fstream

					// read in input file
					input = new BufferedReader(new FileReader(aFile));

					if (input != null){

						/*
						 * readLine is a bit quirky : it returns the content of a line
						 * MINUS the newline. it returns null only for the END of the
						 * stream. it returns an empty String if two newlines appear in
						 * a row.
						 */

						while ((line = input.readLine()) != null) {

							++recordsRead;

							// read 1 line at a time
							if (line != null && line.length() > 0){

								line = line.replace("NULL",Constant.SPACE);
								aLine = line.split(",");

								// must have correct number of columns read in
								if (aLine.length == numberOfColumns){

									try{

										rowsAffected = importSimpleData02(conn,campus,user,importType,line,im);

										// output started as null
										if (output != null){

											if (rowsAffected >= 1){
												progress = "SUCCESS";
												++recordsSuccess;
											}
											else{
												progress = "FAILED";
												++recordsFailed;
											}

											output.write(importType + ": " + aLine[2] + " - " + aLine[3] + " - " + progress + Html.BR() + "\n");

										} // output

									}
									catch(ArrayIndexOutOfBoundsException a){
										if (output != null){
											output.write(importType + ": ArrayIndexOutOfBoundsException\n" + a.toString() + Html.BR() + "\n");
										}
									}
									catch(Exception a){
										if (output != null){
											output.write(importType + ": Exception\n" + a.toString() + Html.BR() + "\n");
										}
									} // try-catch

								} // if aLine
								else{
									if (output != null){
										output.write(importType + ": number of columns do not match. Expected: " + numberOfColumns + "; Found: " + aLine.length + Html.BR() + "\n");
									}
								} // if aLine

							}	// if line
							else{
								if (output != null){
									output.write(importType + ": empty line was encounterd" + Html.BR() + "\n");
								}
							} // if line

						}	// while

						if (debug) logger.info("Import - processing completed");

						temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ "<tr><td>"
								+ "<b>Import type</b><br/>"
								+ "<ul>" + importType + "</ul>"
								+ "<b>Frequency</b><br/>"
								+ "<ul>" + frequency + "</ul>"
								+ "<b>Records read</b><br/>"
								+ "<ul>" + recordsRead + "</ul>"
								+ "<b>Records Imported Successfully</b><br/>"
								+ "<ul>" +  recordsSuccess + "</ul>"
								+ "<b>Records Failed Import </b><br/>"
								+ "<ul>" +  recordsFailed + "</ul>"
								+ "<br>"
								+ "<a href=\""+logFileURL+"\" target=\"_blank\" class=\"linkcolumn\">view log file</a>"
								+ "</td></tr>"
								+ "</table>";

						AseUtil.logAction(conn,user,"ACTION","Data upload (user: " + user
									+ "; import type: " + importType
									+ "; read: " + recordsRead
									+ "; success: " + recordsSuccess
									+ "; failed: " + recordsFailed + ")","","",campus,"");
					}
					else{
						if (output != null){
							output.write(importType + ": file open error (" + fileName + ")" + Html.BR() + "\n");
						}
					} // input not null

				} // file exists
				else{
					if (output != null){
						output.write(importType + ": file not found (" + fileName + ")" + Html.BR() + "\n");
					}
				} // file exists

			} finally {
				input.close();
				input = null;

				if (output != null){
					output.write(Html.BR() + "\n" + importType + ": processing completed..." + Html.BR() + "\n\n");
					output.write(Html.BR() + "\nRecords read: " + recordsRead + Html.BR() +  "\n\n");
					output.write(Html.BR() + "\nRecords Imported Successfully: " + recordsSuccess + Html.BR() +  "\n\n");
					output.write(Html.BR() + "\nRecords Failed Import: " + recordsFailed + Html.BR() +  "\n\n");
					output.close();
					output = null;
				}

				fstream = null;
			}

			// delete the file after processing
			com.ase.aseutil.util.FileUtils fu = new com.ase.aseutil.util.FileUtils();
			fu.deleteFile(fileName,user);
			fu = null;

		} catch (IOException e) {
			logger.fatal("Import IOException: importSimpleData - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Import Exception: importSimpleData - " + e.toString());
		}

		return temp;
	} // importSimpleData01

	/*
	 * importSimpleData02 - for input of xlist, co and pre requisites
	 * <p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	user				String
	 * @param	importType		String
	 * @param	applicationID	int
	 * @param	alphaOnlyID		String
	 * @param	line				String
	 * @param	im					com.ase.aseutil.io.ImportMap
	 * <p>
	 * @return int
	 */
	public static int importSimpleData02(Connection conn,
													String campus,
													String user,
													String importType,
													String line,
													com.ase.aseutil.io.ImportMap im) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String reqType = "";

		String[] aLine = line.split(",");

		String alpha = "";
		String num = "";
		String toAlpha = "";
		String toNum = "";

		String action = "";

		int applicationID = 0;

		String alphaOnlyID = "";

		try {

			alpha = aLine[0];
			num = aLine[1];
			toAlpha = aLine[2];
			toNum = aLine[3];

			if (im != null){
				if ("Add".equals(im.getApplicationType())){
					action = "a";
				}
				else if ("Delete".equals(im.getApplicationType())){
					action = "r";
				}

				applicationID = im.getApplicationAsInt();
				alphaOnlyID = im.getAlphaOnlyID();

			}
			else{
				action = "a";
			}

			String kix = Helper.getKix(conn,campus,alpha,num,Constant.CUR);

			boolean debug = true;
			if(debug){
				logger.info("importSimpleData02");
				logger.info("------------------");
				logger.info("action: " + action);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("toAlpha: " + toAlpha);
				logger.info("toNum: " + toNum);
				logger.info("kix: " + kix);
				logger.info("alphaOnlyID: " + alphaOnlyID);
				logger.info("applicationID: " + applicationID);
			}

			if (importType.equals(Constant.IMPORT_COREQ) || importType.equals(Constant.IMPORT_PREREQ)){

				logger.info("importing pre/coreq");

				if (importType.equals(Constant.IMPORT_PREREQ)){
					reqType = "1";
				}
				else{
					reqType = "2";
				}

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:

								logger.info("import to course outline");

								if (kix != null && kix.length() > 0){

									rowsAffected = RequisiteDB.addRemoveRequisites(conn,
																									kix,
																									action,
																									campus,
																									alpha,
																									num,
																									toAlpha,
																									toNum,
																									Constant.BLANK,
																									reqType,
																									user,
																									0,
																									false);
								}

								break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

								logger.info("import to course alpha");

								rowsAffected = com.ase.aseutil.io.ImportDB.importRequisitesByAlpha(conn,
																														campus,
																														user,
																														importType,
																														alphaOnlyID,
																														reqType,
																														toAlpha,
																														toNum,
																														action);

								break;

				} // switch

			} // pre/co req
			else if (importType.equals(Constant.IMPORT_XLIST)){

				logger.info("importing xlist");

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:

								logger.info("import to course outline");

								if (kix != null && kix.length() > 0){

									if (!XRefDB.isMatch(conn,campus,alpha,num,Constant.CUR,toAlpha,toNum)){

										rowsAffected = XRefDB.addRemoveXlist(conn,
																							kix,
																							action,
																							campus,
																							alpha,
																							num,
																							toAlpha,
																							toNum,
																							user,
																							0);

									} // xlist

								}

								break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

								logger.info("import to course alpha");

								rowsAffected = com.ase.aseutil.io.ImportDB.importRequisitesByAlpha(conn,
																														campus,
																														user,
																														importType,
																														alphaOnlyID,
																														reqType,
																														toAlpha,
																														toNum,
																														action);

								break;

				} // switch

			} // importType

			if(debug){
				logger.info("rowsAffected: " + rowsAffected);
				logger.info("==================");
			}

		}
		catch(Exception e){
			logger.fatal("Import - importSimpleData02 - Exception: " + e.toString());
		}

		return rowsAffected;

	} // importSimpleData02

	/*
	 * importGenericData - for input of data to values table (geslo, ilo, plo, slo)
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * <p>
	 * @return String
	 */
	public static String importGenericData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);

		session.setAttribute("aseException", "");

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		String alpha = "";
		String num = "";
		String kix = "";
		String importType = "";
		String listType = null;
		String message = "";
		String fileName = null;	// default as null is important

		String alphaOnly = null;
		String program = null;
		String degree = null;

		String application = null;
		String applicationX = null;
		String applicationType = null;
		String frequency = null;

		String divisionCode = "";

		int applicationID = 0;
		int division = 0;
		int rowsAffected = 0;

		int recordsRead = 0;
		int recordsSuccess = 0;
		int recordsFailed = 0;

		Msg msg = new Msg();

		// for log file
		FileWriter fstream = null;
		BufferedWriter output = null;
		String logFile = "";
		String logFileURL = "";

		BufferedReader inputStream = null;

		boolean debug = true;

		AsePool connectionPool = AsePool.getInstance();

		Connection conn = connectionPool.getConnection();

		try {

			if (debug) logger.info("---------------------------- importGenericData - START");

			com.ase.aseutil.io.ImportMap im = new com.ase.aseutil.io.ImportMap(session);
			if (im != null){
				fileName = im.getFilename();
				importType = im.getImportType();
				application = im.getApplication();
				applicationX = im.getApplicationX();
				applicationID = im.getApplicationAsInt();
				applicationType = im.getApplicationType();
				frequency = im.getFrequency();
				alpha = im.getAlphaID();
				num = im.getNumberID();
				alphaOnly = im.getAlphaOnlyID();
				division = im.getDepartmentIDAsInt();
				divisionCode = DivisionDB.getDivisonCodeFromID(conn,campus,division);
				program = im.getProgramID();
				degree = im.getDegreeID();
			}

			if (debug) logger.info(im);

			switch(applicationID){
				case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE :
					//-----------------------------------------------
					// not needed
					//-----------------------------------------------
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA :
					alpha = alphaOnly;
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :

					if (NumericUtil.isInteger(im.getDepartmentID())){
						alpha = divisionCode;
					}
					else{
						alpha = im.getDepartmentID();
					}

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :
					alpha = program;
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
					alpha = degree;
					break;
			} // switch

			// get full text for import type
			listType = com.ase.aseutil.io.ImportDB.getListType(importType);

			if (debug) logger.info("listType: " + listType);

			// make sure we have a valid file
			String currentDrive = AseUtil.getCurrentDrive() + ":";
			String documents = SysDB.getSys(conn,"documents");
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			String logFileName = user + "_" + SQLUtil.createHistoryID(1);

			// log file
			logFile = currentDrive + documents + "temp\\" + logFileName + ".htm";

			// link to log file
			logFileURL = documentsURL + "temp/" + logFileName + ".htm";

			if (debug) {
				logger.info("currentDrive: " + currentDrive);
				logger.info("documents: " + documents);
				logger.info("documentsURL: " + documentsURL);
				logger.info("logFile: " + logFile);
				logger.info("logFileURL: " + logFileURL);
			}

			if (fileName != null && listType != null){

				if (debug) logger.info("fileName: " + fileName);

				File target = new File(fileName);

				if (target.exists()){

					if (debug) logger.info("target exists");

					// create file to write progress
					fstream = new FileWriter(logFile);

					if (fstream != null){
						output = new BufferedWriter(fstream);

						output.write("User name: " + user + Html.BR() + "\n");
						output.write("Campus: " + campus + Html.BR() + "\n");
						output.write("Import Type: " + listType + Html.BR() + "\n\n");
						output.write("Applies To: " + applicationX + Html.BR() + "\n\n");

						output.write(Html.BR() + listType + ": processing started..." + Html.BR() + Html.BR() + "\n\n");
					} // fstream

					String line;

					inputStream = new BufferedReader(new FileReader(fileName));

					if (inputStream != null){
						while ((line = inputStream.readLine()) != null){

							rowsAffected = 0;

							++recordsRead;

							// need to process on frequency
							if (frequency.equalsIgnoreCase(com.ase.aseutil.io.ImportConstant.IMPORT_IMMEDIATE)){
								rowsAffected = importGenericData02(conn,campus,user,line,im);
							}
							else{
								if (applicationType.equalsIgnoreCase("add")){
									rowsAffected = ValuesDB.insertValues(conn,
																			new Values(0,
																					campus,
																					listType + " - " + alpha,
																					alpha,
																					line,
																					null,
																					user,
																					listType));
								}
								else{
									rowsAffected = ValuesDB.deleteValues(conn,
																			new Values(0,
																					campus,
																					listType + " - " + alpha,
																					alpha,
																					line,
																					null,
																					user,
																					listType));
								}

							} // frequency

							if (rowsAffected == -99){
								output.write("Not coded yet\n\n");
								recordsSuccess = -99;
							}
							else if (rowsAffected > 0){
								output.write("Update successful: " + line + Html.BR() + "\n\n");
								++recordsSuccess;
							}
							else{
								output.write("Update failed: " + line + Html.BR() + "\n\n");
								++recordsFailed;
							} // rowsAffected

						} // while

						message = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ "<tr><td>"
								+ "<b>Import type</b><br/>"
								+ "<ul>" + listType + "</ul>"
								+ "<b>Frequency</b><br/>"
								+ "<ul>" + frequency + "</ul>"
								+ "<b>Records read</b><br/>"
								+ "<ul>" + recordsRead + "</ul>"
								+ "<b>Records successfully imported</b><br/>"
								+ "<ul>" +  recordsSuccess + "</ul>"
								+ "<b>Records failed import</b><br/>"
								+ "<ul>" +  recordsFailed + "</ul>"
								+ "<br>"
								+ "<a href=\""+logFileURL+"\" target=\"_blank\" class=\"linkcolumn\">view log file</a>"
								+ "</td></tr>"
								+ "</table>";

					} // inputStream != null

				} // target
				else{
					if (debug) logger.info("target not exists");
				}

			}
			else{
				message = "Invalid file name or file does not exist";
			} // fileName

			session.setAttribute("aseApplicationMessage", message);

		} catch (Exception ie) {
			session.setAttribute("aseApplicationMessage", ie.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(ie);
		} finally {
			connectionPool.freeConnection(conn);

			inputStream.close();
			inputStream = null;

			// delete the file after processing
			com.ase.aseutil.util.FileUtils fu = new com.ase.aseutil.util.FileUtils();
			fu.deleteFile(fileName,user);
			fu = null;

			if (output != null){
				output.write(Html.BR() + "\n" + listType + ": processing completed..." + Html.BR() + "\n\n");
				output.write(Html.BR() + "\nRecords read: " + recordsRead + Html.BR() +  "\n\n");
				output.write(Html.BR() + "\nRecords successfully imported: " + recordsSuccess + Html.BR() +  "\n\n");
				output.write(Html.BR() + "\nRecords failed import: " + recordsFailed + Html.BR() +  "\n\n");
				output.close();
				output = null;
			}

			fstream = null;

			if (debug) logger.info("---------------------------- importGenericData - END");
		}

		return message;

	} // importGenericData

	/*
	 * importGenericData02 - import immediately for generic data means to apply to CUR data ASAP
	 * <p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	user				String
	 * @param	line				String
	 * @param	im					com.ase.aseutil.io.ImportMap
	 * <p>
	 * @return int
	 */
	public static int importGenericData02(Connection conn,
														String campus,
														String user,
														String line,
														com.ase.aseutil.io.ImportMap im) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String reqType = "";

		String[] aLine = line.split(",");

		String alpha = "";
		String num = "";
		String toAlpha = "";
		String toNum = "";

		String action = "";

		int applicationID = 0;

		String importType = "";

		int importTypeAsInt = 0;

		String alphaOnlyID = "";
		String departmentID = "";

		Msg msg = new Msg();

boolean debug = true;

		String sql = "";
		GenericContent gc = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			if (debug) logger.info("---------------------------- importGenericData02 - START");

			if (im != null){
				// is it add or remove
				if (im.getApplicationType().equals("Add")){
					action = "a";
				}
				else if (im.getApplicationType().equals("Delete")){
					action = "r";
				}

				// get applicationID
				applicationID = im.getApplicationAsInt();
				if (applicationID == com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE){
					alpha = im.getAlphaID();
					num = im.getNumberID();
				}

				alphaOnlyID = im.getAlphaOnlyID();

				importTypeAsInt = im.getImportTypeAsInt();

			}
			else{
				action = "a";
			}

			// each import considtion is different so we pull data based on the import type
			//alpha = aLine[0];
			//num = aLine[1];
			//toAlpha = aLine[2];
			//toNum = aLine[3];

			String kix = Helper.getKix(conn,campus,alpha,num,Constant.CUR);

// this tells me that the import taking place has not been coded
rowsAffected = -99;

			if (debug){
				logger.info("--------------------------------------");
				logger.info(im);
				logger.info("importTypeAsInt: " + importTypeAsInt);
				logger.info("applicationID: " + applicationID);
				logger.info("kix: " + kix);
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("action: " + action);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("line: " + line);
			}

			if (importTypeAsInt == com.ase.aseutil.io.ImportConstant.IMPORT_GESLO){

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:

						if (kix != null && kix.length() > 0){
							//
						}

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
						break;
				} // switch

			} // importType
			else if (importTypeAsInt == com.ase.aseutil.io.ImportConstant.IMPORT_ILO){

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:
						if (kix != null && kix.length() > 0){

							rowsAffected = GenericContentDB.insertContent(conn,
																						new GenericContent(0,
																												kix,
																												campus,
																												alpha,
																												num,
																												Constant.CUR,
																												Constant.COURSE_INSTITUTION_LO,
																												line,
																												Constant.BLANK,
																												user,
																												0));

						}

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
						break;
				} // switch

			} // importType
			else if (importTypeAsInt == com.ase.aseutil.io.ImportConstant.IMPORT_PLO){

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:

						if (kix != null && kix.length() > 0){

							rowsAffected = GenericContentDB.insertContent(conn,
																						new GenericContent(0,
																												kix,
																												campus,
																												alpha,
																												num,
																												Constant.CUR,
																												Constant.COURSE_PROGRAM_SLO,
																												line,
																												Constant.BLANK,
																												user,
																												0));

						}

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

						if (im != null){
							alphaOnlyID = im.getAlphaOnlyID();

							// read through and add data to all course alphas matching this import selected. only
							// appplicable to CUR only
							try{
								sql = "SELECT DISTINCT coursealpha,coursenum,historyid "
												+ "FROM tblcourse "
												+ "WHERE campus=? AND coursealpha=? AND coursetype=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								ps.setString(2,alphaOnlyID);
								ps.setString(3,Constant.CUR);
								rs = ps.executeQuery();
								while (rs.next()) {
									kix = rs.getString("historyid");
									num = rs.getString("coursenum");
									gc = new GenericContent(0,kix,campus,alphaOnlyID,num,Constant.CUR,Constant.COURSE_PROGRAM_SLO,line,Constant.BLANK,user,0);
									rowsAffected = GenericContentDB.insertContent(conn,gc);
								}
								rs.close();
								ps.close();
							}
							catch(SQLException e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}
							catch(Exception e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}
						} // im

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :

						if (im != null){
							departmentID = im.getDepartmentID();

							// read through and add data to all course alphas matching this import selected. only
							// appplicable to CUR only
							try{
								gc = null;
								sql = "SELECT DISTINCT coursealpha,coursenum,historyid "
												+ "FROM tblcourse "
												+ "WHERE campus=? AND division=? AND coursetype=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								ps.setString(2,departmentID);
								ps.setString(3,Constant.CUR);
								rs = ps.executeQuery();
								while (rs.next()) {
									kix = rs.getString("historyid");
									num = rs.getString("coursenum");
									alpha = rs.getString("coursealpha");
									gc = new GenericContent(0,kix,campus,alpha,num,Constant.CUR,Constant.COURSE_PROGRAM_SLO,line,Constant.BLANK,user,0);
									rowsAffected = GenericContentDB.insertContent(conn,gc);
								}
								rs.close();
								ps.close();
							}
							catch(SQLException e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}
							catch(Exception e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}

						} // im

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :
						rowsAffected = -99;
						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
						rowsAffected = -99;
						break;
				} // switch

			} // importType
			else if (importTypeAsInt == com.ase.aseutil.io.ImportConstant.IMPORT_SLO){

				switch(applicationID){

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE:

						if (kix != null && kix.length() > 0){
							msg = CompDB.addRemoveCourseComp(conn,action,campus,alpha,num,line,0,user,kix);
							rowsAffected = 1;
						}

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA:

						if (im != null){
							alphaOnlyID = im.getAlphaOnlyID();

							// read through and add data to all course alphas matching this import selected. only
							// appplicable to CUR only
							try{
								sql = "SELECT DISTINCT coursealpha,coursenum,historyid "
												+ "FROM tblcourse "
												+ "WHERE campus=? AND coursealpha=? AND coursetype=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								ps.setString(2,alphaOnlyID);
								ps.setString(3,Constant.CUR);
								rs = ps.executeQuery();
								while (rs.next()) {
									kix = rs.getString("historyid");
									num = rs.getString("coursenum");
									msg = CompDB.addRemoveCourseComp(conn,action,campus,alphaOnlyID,num,line,0,user,kix);
								}
								rs.close();
								ps.close();
							}
							catch(SQLException e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}
							catch(Exception e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}

							rowsAffected = 1;

						} // im

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :

						if (im != null){
							departmentID = im.getDepartmentID();

							// read through and add data to all course alphas matching this import selected. only
							// appplicable to CUR only
							try{
								gc = null;
								sql = "SELECT DISTINCT coursealpha,coursenum,historyid "
												+ "FROM tblcourse "
												+ "WHERE campus=? AND division=? AND coursetype=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								ps.setString(2,departmentID);
								ps.setString(3,Constant.CUR);
								rs = ps.executeQuery();
								while (rs.next()) {
									kix = rs.getString("historyid");
									num = rs.getString("coursenum");
									alpha = rs.getString("coursealpha");
									msg = CompDB.addRemoveCourseComp(conn,action,campus,alpha,num,line,0,user,kix);
								}
								rs.close();
								ps.close();
							}
							catch(SQLException e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}
							catch(Exception e){
								logger.fatal("lstmprt - importGenericData02: " + e.toString());
							}

							rowsAffected = 1;

						} // im

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :

						break;

					case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
						break;
				} // switch

			} // importType

			if (debug) logger.info("---------------------------- importGenericData02 - END");

		}
		catch(Exception e){
			logger.fatal("Import - importGenericData02 - Exception: " + e.toString());
		}

		return rowsAffected;

	} // importGenericData02

	/*
	 * processImportOptions
	 *	<p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * @param	currentStep	int
	 *	<p>
	 * @return String
	 */
	public static String processImportOptions(HttpServletRequest request, HttpServletResponse response){

Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String[] staticText = com.ase.aseutil.io.ImportConstant.IMPORT_TEXT.split(",");

		String selected = "";

		int applicationID = 0;

		String maxSteps = "" + com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION;
		String frmInputType = "text";

		String fileName = "";
		String importType = "";
		String application = "";
		String applicationType = "";
		String frequency = "";

		String alphaID = "";
		String numberID = "";
		String alphaOnlyID = "";

		String departmentID = "";
		String programID = "";
		String degreeID = "";
		String temp;

		int i = 0;

		// determines whether the next button should be set
		// if not all data collected, then button should be false
		boolean enable = true;

		com.ase.aseutil.io.ImportMap im = null;
		com.ase.aseutil.io.Import imp = null;

		String importText = "";
		String applicationTypeText = "";
		String frequencyText = "";
		int importTypeAsInt = 0;

		int currentStep = 0;

		int numberOfRadiosItems = 0;

		String[] rows = null;

		try{
			AseUtil aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			String campus = Util.getSessionMappedKey(session,"aseCampus");

			String aseListImportMessage = AseUtil.nullToBlank((String)session.getAttribute("aseListImportMessage"));

			// clear before form submission goes back to driver
			session.setAttribute("aseListImportMessage",null);

			// where are we in the sequence of steps?

			if ((String)session.getAttribute("aseListImportDirection") != null){
				temp = (String)session.getAttribute("aseListImportDirection");
				if (temp.equals("next")){
					if ((String)session.getAttribute("aseListImportNextStep") != null){
						temp = (String)session.getAttribute("aseListImportNextStep");
						currentStep = Integer.parseInt(temp);
					}
					else{
						currentStep = 1;
					}
				}
				else{
					if ((String)session.getAttribute("aseListImportPrevStep") != null){
						temp = (String)session.getAttribute("aseListImportPrevStep");
						currentStep = Integer.parseInt(temp);
					}
					else{
						currentStep = 1;
					}
				}
			}

			// get latest session data
			im = new com.ase.aseutil.io.ImportMap(session);
			if (im != null){
				fileName = im.getFilename();
				importType = im.getImportType();
				importTypeAsInt = im.getImportTypeAsInt();
				application = im.getApplication();
				applicationID = im.getApplicationAsInt();
				applicationType = im.getApplicationType();
				frequency = im.getFrequency();
				alphaID = im.getAlphaID();
				numberID = im.getNumberID();
				alphaOnlyID = im.getAlphaOnlyID();
				departmentID = im.getDepartmentID();
				programID = im.getProgramID();
				degreeID = im.getDegreeID();
			}

			// data reflecting the type that is permitted for this import data type
			imp = com.ase.aseutil.io.ImportDB.getImport(importTypeAsInt);
			if (imp != null){
				// place the comma before to ensure we select the right values as we go through
				// since this is a list of numeric values
				importText = "," + imp.getApplication() + ",";

				// not needing comma because this is text only
				applicationTypeText = imp.getApplicationType();
				frequencyText = imp.getFrequency();
			}

			// title
			String title = "List Import";
			String subTitle = staticText[currentStep];

			// adjust for next step
			int iMaxSteps = Integer.parseInt(maxSteps);
			String nextStep = "" + (currentStep + 1);
			String prevStep = "" + (currentStep - 1);

			// command button on first screen is different
			String cmdButton = "Next";
			if (currentStep == 1){
				cmdButton = "Upload";
			}
			else if (currentStep == iMaxSteps){
				cmdButton = "Submit";
			}

			// for start
			buf.append("");
			buf.append("<table class=\"example_code notranslate\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"60%\">");
			buf.append("<tr>");
			buf.append("<td>");

			// upload of forms is different
			if (currentStep == 1){
				buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" enctype=\"multipart/form-data\" action=\"/central/servlet/digdig\">");
			}
			else{
				buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" action=\"?\">");
			}

			buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" class=\"code\" align=\"center\"  border=\"0\">");

			// steps and title
			buf.append("<tr height=\"40\"><td colspan=\"2\" class=\"dataColumnCenter\"><strong>");
			buf.append(title);
			buf.append("&nbsp;-&nbsp;");
			buf.append(subTitle);
			buf.append("&nbsp;(step ");
			buf.append(currentStep);
			buf.append(" of ");
			buf.append(maxSteps);
			buf.append(")</strong></td></tr>");

			// body
			switch(currentStep){

				case com.ase.aseutil.io.ImportConstant.IMPORT_FILE :
					// upload
					buf.append("<tr height=\"30\">");
					buf.append(" <td class=\"textblackth\" valign=\"top\" width=\"20%\">Datafile:</td>");
					buf.append(" <td valign=\"top\"><input type=\"file\" value=\"" + fileName + "\" name=\"fileName\" size=\"50\" id=\"fileName\" class=\"upload\" /></td>");
					buf.append("</tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// samples
					buf.append("<tr>");
					buf.append(" <td colspan=\"2\" class=\"tutheader\">");

					buf.append("<h4 class=\"tutheader\">Note</h4>");
					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">");
					buf.append("<tr>");
					buf.append(" <td valign=\"top\">");
					buf.append("<ul>");
					buf.append("<li>Files may not exceed 10MB in size</li>");
					buf.append("<li><a href=\"/centraldocs/docs/help/prereq.txt\" class=\"linkcolumn\" target=\"_blank\">Pre-requisites</a>,"
								+ "<a href=\"/centraldocs/docs/help/coreq.txt\" class=\"linkcolumn\" target=\"_blank\">corequisites</a> and "
								+ "<a href=\"/centraldocs/docs/help/xlist.txt\" class=\"linkcolumn\" target=\"_blank\">cross listed</a> "
								+ "uploads directly into APPROVED outlines</li>");
					buf.append("</ul>");
					buf.append("</td>");
					buf.append("</tr>");
					buf.append("</table>");

					buf.append("</td>");
					buf.append("</tr>");

					// for validation
					frmInputType = "text";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_TYPE :
					// import type
					buf.append("<tr height=\"30\">");
					buf.append(" <td class=\"textblackth\" valign=\"top\" width=\"20%\">Import Type:</td>");
					buf.append(" <td valign=\"top\">");

					int start = com.ase.aseutil.io.ImportConstant.IMPORT_COREQ;
					int end = com.ase.aseutil.io.ImportConstant.IMPORT_SLO;

					for (i=start;i<=end;i++){

						selected = "";
						if (importType.equals(""+i)){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+i+"\">"+staticText[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// for validation
					frmInputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION :

					// allocating array to hold output. array size and usage is based on index
					// where the particular item is found. which means that there will be empty or null
					// cells with the exception of the element where a valid index is located.
					rows = new String[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+1];

					// application
					buf.append("<tr height=\"30\">\n\n");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application:</td>\n");
					buf.append("<td valign=\"top\">\n");

					buf.append("<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
					buf.append("<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );

					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">\n");

					// check to see if this is the one and only available radio button. If so, auto check by default
					String applicationTemp = application;

					frmInputType = "radio";

					temp = importText;
					if (temp.startsWith(",")){
						temp = temp.substring(1);
					}

					if (temp.endsWith(",")){
						temp = temp.substring(0,temp.length()-1);
					}

					// if we don't find a comma in the string, then it's only 1 radio available
					// check to checkbox if it's the one and only item
					if (temp.indexOf(",") < 0){
						applicationTemp = temp;
						frmInputType = "checkbox";
					}

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alpha_hidden\" name=\"alphaID\"><br>"
						+ "<input type=\"text\" class=\'inputajax\' id=\"number\" name=\"number\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alphaID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')\">"
						+ "<input type=\"hidden\" id=\"number_hidden\" name=\"numberID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alphaOnly\" name=\"alphaOnly\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alphaOnly_hidden\" name=\"alphaOnlyID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"department\" name=\"department\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DIVISION_BANNER + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"department_hidden\" name=\"departmentID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"program\" name=\"program\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.PROGRAM + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"program_hidden\" name=\"programID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"degree\" name=\"degree\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DEGREE + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"degree_hidden\" name=\"degreeID\">"
						+ "</td></tr>";

					// loop through available import to location and only display what this import type should use.
					// for example, pre, co, and xlist should only import to course outline
					int start2 = com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE;
					int end2 = com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE;

					for (i=start2;i<=end2;i++){
						if (importText.indexOf(","+i+",")>-1){
							buf.append(rows[i]);
						}

					} // for

					buf.append("</table>\n");

					buf.append(" </td></tr>\n");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION_TYPE :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application type:</td>");
					buf.append("<td valign=\"top\">");

					frmInputType = "radio";

					// when working with application type of course outline, only ADD is permitted
					if (applicationID==com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE){
						applicationTypeText = "Add";
					}

					// if we don't find a comma in the string, then it's only 1 radio available
					// check to checkbox if it's the one and only item
					if (applicationTypeText.indexOf(",") < 0){
						frmInputType = "checkbox";
						buf.append("<input type=\""+frmInputType+"\" disabled=\"disabled\" checked name=\"aseListImportFieldX\" value=\""+applicationTypeText+"\">"+applicationTypeText+"</input><br>");
						buf.append("<input type=\"hidden\" name=\"aseListImportField\" value=\""+applicationTypeText+"\"></input><br>");
					}
					else{
						buf.append("<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\"Add\">Add</input><br>");
						buf.append("<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\"Delete\">Delete</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_FREQUENCY :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Frequency:</td>");
					buf.append("<td valign=\"top\">");

					frmInputType = "radio";

					// when working with application type of course outline, only ADD is permitted
					if (applicationID==com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE){
						frequencyText = com.ase.aseutil.io.ImportConstant.IMPORT_IMMEDIATE;
					}

					// if we don't find a comma in the string, then it's only 1 radio available
					// check to checkbox if it's the one and only item
					// another inclusion is if we are deleting, it goes immediately.
					if (applicationType.equalsIgnoreCase("delete")){
						frequencyText = "Immediately";
					}

					if (frequencyText.indexOf(",") < 0){
						frmInputType = "checkbox";
						buf.append("<input type=\""+frmInputType+"\" disabled=\"disabled\" checked name=\"aseListImportFieldX\" value=\""+frequencyText+"\">"+frequencyText+"</input><br>");
						buf.append("<input type=\"hidden\" name=\"aseListImportField\" value=\""+frequencyText+"\"></input><br>");
					}
					else{
						buf.append("<input type=\""+frmInputType+"\" "
										+ selected
										+ " name=\"aseListImportField\" value=\""
										+ com.ase.aseutil.io.ImportConstant.IMPORT_IMMEDIATE
										+ "\">"
										+ com.ase.aseutil.io.ImportConstant.IMPORT_IMMEDIATE
										+ "</input><br>");

						buf.append("<input type=\""+frmInputType+"\" "
										+ selected
										+ " name=\"aseListImportField\" value=\""
										+ com.ase.aseutil.io.ImportConstant.IMPORT_ON_CREATE
										+ "\">"
										+ com.ase.aseutil.io.ImportConstant.IMPORT_ON_CREATE
										+ "</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION :
					// confirmation
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" colspan=\"2\">Confirm your import options:</td>");
					buf.append("<td valign=\"top\">&nbsp;</td>");
					buf.append("</tr>");

					// validation - cannot contain blanks or 0 (we have no 0 value option)
					if (	fileName.equals(Constant.BLANK) || importType.equals(Constant.BLANK) ||
							application.equals(Constant.BLANK) || applicationType.equals(Constant.BLANK) ||
							frequency.equals(Constant.BLANK)){

						enable = false;
					}

					buf.append("<tr>");
					buf.append(" <td colspan=\"2\" class=\"tutheader\">");
					buf.append("<ul>");
					buf.append("<li>File Name: <span class=\"datacolumn\">" + fileName + "</span><br/><br/></li>");
					buf.append("<li>Import Type: <span class=\"datacolumn\">" + staticText[Integer.parseInt(importType)] + "</span><br/><br/></li>");
					buf.append("<li>Application: <span class=\"datacolumn\">" + staticText[applicationID] + " (" + application + ")</span><br/><br/></li>");
					buf.append("<li>Application Type: <span class=\"datacolumn\">" + applicationType + "</span><br/><br/></li>");
					buf.append("<li>Frequency: <span class=\"datacolumn\">" + frequency + "</span><br/><br/></li>");
					buf.append("</ul>");
					buf.append("</tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					break;

			} // switch

			buf.append("");

			if (!aseListImportMessage.equals(Constant.BLANK)){
				buf.append("<tr>");
				buf.append("<td align=\"center\" colspan=\"3\">" + aseListImportMessage + "</td>");
				buf.append("</tr>");
			}

			buf.append(drawProgress(iMaxSteps,currentStep,im));

			// footer
			buf.append("</table>");

			// frmInputType used for validation
			buf.append("<input type=\"hidden\" value=\""+frmInputType+"\" name=\"frmInputType\">");

			// previous step
			buf.append("<input type=\"hidden\" value=\""+prevStep+"\" name=\"prevStep\">");

			// next step
			buf.append("<input type=\"hidden\" value=\""+nextStep+"\" name=\"nextStep\">");

			// where to return to
			buf.append("<input type=\"hidden\" value=\""+"lstmprt"+"\" name=\"rtn\">");

			buf.append("</form>");
			buf.append("</td>");
			buf.append("</tr>");
			buf.append("</table>");

			session.setAttribute("aseListImportPrevStep",""+prevStep);
			session.setAttribute("aseListImportNextStep",""+nextStep);

		}
		catch(Exception ex){
			logger.fatal("listImport - " + ex.toString());
		}

		return buf.toString();

	} // processImportOptions

	/*
	 * drawProgress
	 *	<p>
	 * @param	iMaxSteps	int
	 * @param	currentStep	int
	 * @param	session		HttpSession
	 *	<p>
	 * @return String
	 */
	public static String drawProgress(int iMaxSteps, int currentStep,com.ase.aseutil.io.ImportMap im){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		// represents progress data
		String[] clss = new String[iMaxSteps];
		String[] img = new String[iMaxSteps];

		// clear out data
		for (i=1;i<iMaxSteps;i++){
			clss[i] = "copyright";
			img[i] = "";
		}

		// set accordingly
		for (i=1;i<currentStep;i++){
			clss[i] = "datacolumn";
			img[i] = "<img src=\"../images/success-sm.gif\" alt=\"\" border=\"0\">";
		}

		// im.getFilename() has complete file location so we want to mask that and not show all
		String filename = "";
		if (im.getFilename() != null && im.getFilename().length() > 0){
			filename = im.getFilename().substring(im.getFilename().lastIndexOf("\\")+1);
		}

		String data = "";

		if (im != null){
			int applicationID = im.getApplicationAsInt();
			String alpha = im.getAlphaID();
			String num = im.getNumberID();
			String alphaOnly = im.getAlphaOnlyID();
			int division = im.getDepartmentIDAsInt();
			String program = im.getProgramID();
			String degree = im.getDegreeID();

			switch(applicationID){
				case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE :
					data = alpha + " " + num;
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA :
					data = alphaOnly;
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT :

					if (NumericUtil.isInteger(im.getDepartmentID())){
						data = "" + division;
					}
					else{
						data = im.getDepartmentID();
					}

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM :
					data = program;
					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE :
					data = degree;
					break;
			} // switch
		}

		buf.append("<tr>");
		buf.append(" <td colspan=\"2\" class=\"tutheader\">");
		buf.append("<h4 class=\"tutheader\">Upload Selection Progress</h4>");
		buf.append("<table width=\"100%\" border=\"0\">");
		buf.append("<tr><td>" + img[1]+ "</td><td class=\"" + clss[1]+ "\">File uploaded</td><td class=\"" + clss[1]+"\">"+filename+"</td></tr>");
		buf.append("<tr><td>" + img[2]+ "</td><td class=\"" + clss[2]+ "\">Import type identified</td><td class=\"" + clss[1]+"\">"+im.getImportTypeX()+"</td></tr>");
		buf.append("<tr><td>" + img[3]+ "</td><td class=\"" + clss[3]+ "\">Application selected</td><td class=\"" + clss[1]+"\">"+im.getApplicationX()+" - "+data+"</td></tr>");
		buf.append("<tr><td>" + img[4]+ "</td><td class=\"" + clss[4]+ "\">Application type selected</td><td class=\"" + clss[1]+"\">"+im.getApplicationType()+"</td></tr>");
		buf.append("<tr><td>" + img[5]+ "</td><td class=\"" + clss[5]+ "\">Frequency</td><td class=\"" + clss[1]+"\">"+im.getFrequency()+"</td></tr>");
		buf.append("</table>");
		buf.append("</td>");
		buf.append("</tr>");

		return buf.toString();
	}

	/*
	 * drawCommandButton
	 *	<p>
	 * @param	cmdButton	String
	 * @param	enable		boolean
	 *	<p>
	 * @return String
	 */
	public static String drawCommandButton(boolean enable, String cmdButton, int step){

		StringBuffer buf = new StringBuffer();

		String enableButton = "";
		String off = "";

		buf.append("<tr align=\"right\">");
		buf.append(" <td colspan=\"2\">");
		buf.append("<br><input type=\"hidden\" name=\"formName\" value=\"aseForm\">");

		if (!enable){
			enableButton = "disabled";
			off = "off";
		}

		buf.append("<div class=\"post\">");

		if (step>1){
			//buf.append("<input title=\"process previous\" type=\"submit\" name=\"asePrev\" id=\"asePrev\" value=\"Previous\" class=\"inputsmallgray\" onclick=\"return aseSubmitClick('a')\">&nbsp;");
		}

		buf.append("<input title=\"process next\" type=\"submit\" name=\"aseUpload\" id=\"aseUpload\" " + enableButton + " value=\""+cmdButton+"\" class=\"inputsmallgray"+off+"\" onclick=\"return aseSubmitClick('a')\">&nbsp;");

		buf.append("<input title=\"abort selected operation\" type=\"submit\" name=\"aseClose\" value=\"Close\" class=\"inputsmallgray\" onClick=\"return cancelForm()\">&nbsp;");

		buf.append("<a href=\"#?w=500\" rel=\"helpPopup\" class=\"poplight\">");
		buf.append("<img src=\"images/helpicon.gif\" border=\"0\" alt=\"help with this screen\" title=\"help with this screen\">");
		buf.append("</a>");

		buf.append("</div>");

		buf.append("&nbsp;&nbsp;&nbsp;</td></tr>");

		buf.append("<tr align=\"right\">");
		buf.append("<td colspan=\"2\">");

		buf.append("<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">");
		buf.append("<p align=\"center\"><img src=\"../images/spinner.gif\" alt=\"processing...\" border=\"0\"><br/>processing...</p>");
		buf.append("</div>");

		buf.append("</td></tr>");

		return buf.toString();
	}

%>

<%@ include file="../inc/footer.jsp" %>

<script type="text/javascript" src="js/jquery.min.popup.js"></script>
<script type="text/javascript" src="js/helppopup.js"></script>

</body>
</html>
