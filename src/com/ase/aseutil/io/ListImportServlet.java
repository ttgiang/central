/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.io;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.DebugDB;
import com.ase.aseutil.DivisionDB;
import com.ase.aseutil.Msg;
import com.ase.aseutil.Util;
import com.ase.aseutil.Values;
import com.ase.aseutil.ValuesDB;
import com.ase.aseutil.WebSite;
import com.ase.aseutil.uploads.DefaultFileTypePolicy;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * A class to perform file upload and retrieve associated parms
 * <p>
 *
 * @author <b>ASE</b>, Copyright &#169; 2011
 *
 * @version 1.0, 2011/04/01
 */
public class ListImportServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(ListImportServlet.class.getName());

	static boolean debug = false;

	private String dirName;

	private AsePool connectionPool;

	MultipartRequest multi = null;

	/*
	 * init
	 */
	public void init() throws ServletException {}

	public void init(ServletConfig config) throws ServletException {

		super.init(config);

		connectionPool = AsePool.getInstance();

		// read the uploadDir from the servlet parameters
		dirName = config.getInitParameter("uploadDir");
		if (dirName == null) {
			throw new ServletException("Please supply uploadDir parameter");
		}
		else{

			// should point to drive:\tomcat\webapps\centraldocs\docs\temp\

			dirName = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps" + dirName.replace("/","\\") + "\\";
		}
	}

	/*
	 * destroy
	 */
	public void destroy() {
		connectionPool.destroy();
	}

	/*
	 * doGet
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		int rowsAffected = 0;

		String rtn = null;
		String itm = null;
		String kix = null;
		String src = null;

		try {
			// Use an advanced form of the constructor that specifies a character
			// encoding of the request (not of the file contents), a file
			// rename policy and a type policy.

			// at this point, uploads are all done. The code below is for show and tell only

			logger.info("ListImportServlet ------------- START");

			multi = new MultipartRequest(request,
													dirName,
													10*1024*1024,
													"ISO-8859-1",
													new DefaultFileRenamePolicy(),
													new DefaultFileTypePolicy());

			if (multi != null){
				rtn = multi.getParameter("rtn",Constant.BLANK);
				itm = multi.getParameter("itm",Constant.BLANK);
				kix = multi.getParameter("kix",Constant.BLANK);
				src = multi.getParameter("src",Constant.BLANK);

				if (rtn.equals(Constant.BLANK)){
					rtn = "index";
				}

			}

			rowsAffected = quickListEntries(request,response);

			logger.info("ListImportServlet ------------- END");

		}
		catch (IOException lEx) {
			logger.fatal(lEx);
		}

		String url;

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/"+rtn+".jsp");
		} else {
			url = response.encodeURL("/core/"+rtn+".jsp?rtn="+src+"&kix="+kix+"&itm="+itm);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);

		dispatcher.forward(request, response);
	}

	/*
	 * processImportOptions
	 *	<p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * @param	currentStep	int
	 *	<p>
	 * @return String
	 */
	public static String processImportOptions(HttpServletRequest request, HttpServletResponse response,int currentStep){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String[] staticText = com.ase.aseutil.io.ImportConstant.IMPORT_TEXT.split(",");

		String selected = "";

		int applicationID = 0;

		String maxSteps = "" + com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION;
		String inputType = "text";

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

		int i = 0;

		// determines whether the next button should be set
		// if not all data collected, then button should be false
		boolean enable = true;

		com.ase.aseutil.io.ImportMap im = null;
		com.ase.aseutil.io.Import imp = null;

		String importText = "";
		String frequencyText = "";
		int importTypeAsInt = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			String campus = Util.getSessionMappedKey(session,"aseCampus");

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

			imp = com.ase.aseutil.io.ImportDB.getImport(importTypeAsInt);
			if (imp != null){
				importText = "," + imp.getApplication() + ",";
				frequencyText = imp.getFrequency();
			}

			// title
			String title = "List Import";
			String subTitle = staticText[currentStep];

			// adjust for last step
			int lastStep = currentStep - 1;
			if (lastStep == 0){
				lastStep = 1;
			}

			// adjust for next step
			int iMaxSteps = Integer.parseInt(maxSteps);
			String nextStep = "" + (currentStep + 1);

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
			buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" enctype=\"multipart/form-data\" action=\"/central/servlet/opihi?s=lstmprt\">");
			//buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" action=\"?\">");
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
					buf.append(" <td class=\"textblackth\" valign=\"top\" width=\"20%\">Datafile*:</td>");
					buf.append(" <td valign=\"top\"><input type=\"file\" value=\"" + fileName + "\" name=\"fileName\" size=\"50\" id=\"fileName\" class=\"upload\" /></td>");
					buf.append("</tr>");

					// command buttons
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// samples
					buf.append("<tr>");
					buf.append(" <td colspan=\"2\" class=\"tutheader\">");
					buf.append("<h4 class=\"tutheader\">Sample file formats</h4>");
					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">");
					buf.append("<tr>");
					buf.append(" <td valign=\"top\">");
					buf.append("<ul>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/coreq.txt\" class=\"linkcolumn\" target=\"_blank\">Co-Req</a><br/><br/></li>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/xlist.txt\" class=\"linkcolumn\" target=\"_blank\">Cross Listed</a><br/><br/></li>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/prereq.txt\" class=\"linkcolumn\" target=\"_blank\">Pre Req</a><br/><br/></li>");
					buf.append("</ul>");
					buf.append("</td>");
					buf.append("</tr>");
					buf.append("</table>");
					buf.append("*Files may not exceed 10MB in size</td>");
					buf.append("</tr>");

					// for validation
					inputType = "text";

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
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// for validation
					inputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION :

					// allocating array to hold output. array size and usage is based on index
					// where the particular item is found. which means that there will be empty or null
					// cells with the exception of the element where a valid index is located.
					String[] rows = new String[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+1];

					// application
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application:</td>");
					buf.append("<td valign=\"top\">");

					buf.append("<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
					buf.append("<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );

					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">");

					selected = ""; if (application.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alpha_hidden\" name=\"alphaID\"><br>"
						+ "<input type=\"text\" class=\'inputajax\' id=\"number\" name=\"number\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alphaID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')\">"
						+ "<input type=\"hidden\" id=\"number_hidden\" name=\"numberID\">"
						+ "</td></tr>";

					selected = ""; if (application.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alphaOnly\" name=\"alphaOnly\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alphaOnly_hidden\" name=\"alphaOnlyID\">"
						+ "</td></tr>";

					selected = ""; if (application.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT] = "<tr><td valign=\"top\" nowrap>"
					+ "<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT]+"</input></td>"
					+ "<td valign=\"top\">"
					+ "<input type=\"text\" class=\'inputajax\' id=\"department\" name=\"department\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DEPARTMENT + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
					+ "<input type=\"hidden\" id=\"department_hidden\" name=\"departmentID\">"
					+ "</td></tr>";

					selected = ""; if (application.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM] = "<tr><td valign=\"top\" nowrap>"
					+ "<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM]+"</input></td>"
					+ "<td valign=\"top\">"
					+ "<input type=\"text\" class=\'inputajax\' id=\"program\" name=\"program\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.PROGRAM + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
					+ "<input type=\"hidden\" id=\"program_hidden\" name=\"programID\">"
					+ "</td></tr>";

					selected = ""; if (application.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE] = "<tr><td valign=\"top\" nowrap>"
					+ "<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE]+"</input></td>"
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

					buf.append("</table>");

					buf.append(" </td></tr>");

					// command buttons
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// for validation
					inputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION_TYPE :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application type:</td>");
					buf.append("<td valign=\"top\">");

					String applicationTypeData = "Add,Delete";
					applicationTypeData = "Add,Delete";
					String[] aApplicationTypeData = applicationTypeData.split(",");

					for (i=0;i<aApplicationTypeData.length;i++){

						selected = "";
						if (applicationType.equals(aApplicationTypeData[i])){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+aApplicationTypeData[i]+"\">"+aApplicationTypeData[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// for validation
					inputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_FREQUENCY :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Frequency:</td>");
					buf.append("<td valign=\"top\">");

					String frequencyData = frequencyText;
					String[] aFrequencyData = frequencyData.split(",");

					for (i=0;i<aFrequencyData.length;i++){

						selected = "";
						if (frequency.equals(aFrequencyData[i])){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+aFrequencyData[i]+"\">"+aFrequencyData[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					// for validation
					inputType = "radio";

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
					buf.append(com.ase.aseutil.io.ImportDB.drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(com.ase.aseutil.io.ImportDB.drawHelpText(currentStep));

					break;

			} // switch


			buf.append(com.ase.aseutil.io.ImportDB.drawProgress(iMaxSteps,currentStep,im));

			// footer
			buf.append("</table>");

			// inputType used for validation
			buf.append("<input type=\"hidden\" value=\""+inputType+"\" name=\"inputType\">");

			buf.append("<input type=\"hidden\" value=\""+currentStep+"\" name=\"currentStep\">");

			// do this here to avoid making JS coding
			buf.append("<input type=\"hidden\" value=\""+lastStep+"\" name=\"lastStep\">");

			// next step
			buf.append("<input type=\"hidden\" value=\""+nextStep+"\" name=\"nextStep\">");

			buf.append("</form>");
			buf.append("</td>");
			buf.append("</tr>");
			buf.append("</table>");

		}
		catch(Exception ex){
			logger.fatal("listImport - " + ex.toString());
		}

		return buf.toString();

	} // processImportOptions

	/*
	 * quickListEntries
	 * <p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public int quickListEntries(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		session.setAttribute("aseException", "");

		WebSite website = new WebSite();

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		String formAction = "";
		String formName = "";

		String alpha = "";
		String itm = "";
		String kix = "";
		String type = "";
		String listType = "";
		String message = "";
		String fileName = null;	// default as null is important
		String divisionCode = "";
		String lst = "";

		int division = 0;
		int rowsAffected = 0;

		Msg msg = new Msg();

		Connection conn = connectionPool.getConnection();

		try {
			debug = DebugDB.getDebug(conn,"OutlineServlet");

debug = true;

			// retrieve form parameters
			if (multi != null){

				if (multi.getParameterNameCount() > 0){
					formAction = multi.getParameter("formAction","");
					formName = multi.getParameter("formName","");
					alpha = multi.getParameter("alpha","");
					itm = multi.getParameter("type","");
					division = multi.getParameter("division",0);
					type = multi.getParameter("type","");
					lst = multi.getParameter("lst","");

					listType = Constant.GetLinkedDestinationFullName(itm);

					// when division name is missing, alpha it is. or reverse
					divisionCode = DivisionDB.getDivisonCodeFromID(conn,campus,division);
					if (divisionCode == null || divisionCode.length() == 0){
						divisionCode = alpha;
					}
					else if (alpha == null || alpha.length() == 0){
						alpha = divisionCode;
					}

				} // multi.getParameterNameCount()

 				if (multi.getFileNameCount() > 0){
 					logger.info("getFileNameCount: " + multi.getFileNameCount());
				}

				if (multi.getFileNameCount() > 0){
					fileName = multi.getFileName("file1");
				}
				else{
					fileName = "";
				} // multi.getFileNameCount()

				if (debug){
					logger.info("formAction: " + formAction);
					logger.info("formName: " + formName);
					logger.info("alpha: " + alpha);
					logger.info("itm: " + itm);
					logger.info("division: " + division);
					logger.info("type: " + type);
					logger.info("fileName: " + fileName);
					logger.info("listType: " + listType);
					logger.info("lst: " + lst);
				}

			} // multi

			if (fileName != null && fileName.length() > 0){

				if (debug) logger.info("file import: " + listType);

				message = ImportDB.importListFromFile(conn,
																	campus,
																	user,
																	listType,
																	fileName,
																	divisionCode,
																	alpha,
																	itm);


				com.ase.aseutil.util.FileUtils fu = new com.ase.aseutil.util.FileUtils();

				fu.deleteFile(fileName,user);

				fu = null;
			}
			else{

				if (debug) logger.info("user data import");

				if (lst != null && lst.length() > 0){
					int i = 0;
					String[] arr;
					Values values = null;

					arr = lst.split("//");

					for(i=0;i<arr.length;i++){

						if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){

							ValuesDB.insertValues(conn,
														new Values(0,campus,listType + " - " + divisionCode,alpha,arr[i],null,user,itm));
							++rowsAffected;
						}
					}

					message = "Import completed successfully. " + rowsAffected + " row(s) update";
				} // lst

			} // fileName

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception ie) {
			rowsAffected = -1;
			session.setAttribute("aseApplicationMessage", ie.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(ie);
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/*
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}