<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sltcrs.jsp
	*	2007.09.01	driver to select course and table. Caller page contains
	*					name of page that called this driver. Once done, it will
	*					be sent back to the caller page with the course, num and view.
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "50%";
	String pageTitle = "";
	String screen = "1";
	String alpha = null;
	String courseNum = null;
	String viewOption = null;
	int setup = -1;

	String formName = website.getRequestParameter(request,"formName");
	String formDirection = website.getRequestParameter(request,"formDirection");
	String callerPage = website.getRequestParameter(request,"cp", "");

	if ( callerPage.length() > 0 ){
		if ( callerPage.equals("crscan") )
			pageTitle = "Cancel Proposed Course";
		else if ( callerPage.equals("crsappr") )
			pageTitle = "Course Approval";
		else if ( callerPage.equals("crssts") )
			pageTitle = "Course Approval Status";
		else if ( callerPage.equals("crsxrf") )
			pageTitle = "Course X-Ref with Banner";
		else if ( callerPage.equals("crsdlt") )
			pageTitle = "Delete Course Outline";
		else if ( callerPage.equals("crsedt") )
			pageTitle = "Modify Coure Outline";
		else if ( callerPage.equals("crsvw") )
			pageTitle = "View Coure Outline";
		else
			pageTitle = "";
	}

	/*
		at the start, there is no form name. setup is set to 0.
		with the first form submission, setup is now 1 (alpha selection done).
		when the course number has been selected, setup is 2 and we show
		the data for the course selected.
	*/
	viewOption = website.getRequestParameter(request,"viewOption");

	if ( formName != null && formName.equals("aseForm") ){
		alpha = website.getRequestParameter(request,"alpha");
		courseNum = website.getRequestParameter(request,"courseNum");
		pageTitle = "Select " + viewOption + " Course";

		if ( formDirection.equals("Back") ){
			setup = 0;
			screen = "1";
			pageTitle += " (screen " + screen + " of 2)";
		}
		else{
			if ( courseNum != null && courseNum.length() > 0 ){
				response.sendRedirect( callerPage + ".jsp?alpha=" + alpha + "&num=" + courseNum + "&view=" + viewOption );
			}
			else{
				setup = 1;
				screen = "2";
				pageTitle += " (screen " + screen + " of 2)";
			}
		}
	}
	else{
		pageTitle = "Select Course (screen " + screen + " of 2)";
		setup = 0;
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/sltcrs.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	switch ( setup )
	{
		case 0 :
		case 1:
			showForm(request,response,session,out,conn,screen,alpha,viewOption,setup,callerPage,website,aseUtil);
			break;
	}

	asePool.freeConnection(conn);
%>

<%!
	//
	// show this form with data
	//
	void showForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						String screen,
						String alpha,
						String viewOption,
						int setup,
						String callerPage,
						WebSite website,
						AseUtil aseUtil) throws java.io.IOException {

		try{
			String sql = "";
			String view = "";
			String editType = website.getRequestParameter(request,"edt");

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			// course by alpha or number
			if ( setup == 0 ){
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Select Course Alpha:&nbsp;</td>" );
				out.println("					 <td>" );
				out.println(aseUtil.drawHTMLField(conn,"listbox","DisciplineByAlpha","alpha",alpha,0,0) );
				out.println("				</td></tr>" );
			}
			else{
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Course Alpha:&nbsp;</td>" );
				out.println("					 <td>" );
				out.println( alpha );
				out.println("					<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
				out.println("				</td></tr>" );
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Select Course Number:&nbsp;</td>" );
				out.println("					 <td>" );

				if ( viewOption.equals("Approved") || viewOption.equals("CUR") ){
					view = "CUR";
					viewOption = "Approved";
				}
				else if ( viewOption.equals("Archived") || viewOption.equals("ARC")  ){
					view = "ARC";
					viewOption = "Archived";
				}
				else{
					view = "PRE";
					viewOption = "Proposed";
				}

				sql = "SELECT CourseNum, CourseNum + ' - ' + ShortTitle " +
					"FROM tblCourse " +
					"WHERE CourseType = " + aseUtil.toSQL(String.valueOf(view),1) + " AND " +
					"CourseAlpha = " + aseUtil.toSQL(String.valueOf(alpha),1) + " AND " +
					"Division = " + aseUtil.toSQL((String)session.getAttribute("aseDivision"),1) + " " +
					"ORDER BY CourseNum";

				out.println( aseUtil.createSelectionBox( conn, sql, "courseNum", "" ));
				out.println("				</td></tr>" );
			}

			// course by type
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Course Type:&nbsp;</td>" );
			out.println("					 <td>" );

			if ( setup == 0 ){
				// when viewOption does not have any value, display all 3 course types
				if ( viewOption == null || viewOption.length() == 0 ){
					out.println( aseUtil.drawHTMLField(conn,"radio","CourseType","viewOption",viewOption,0,0) );
					out.println("					<input type=\'hidden\' name=\'edt\' value=\'1\'>" );
				}
				else{
					if ( viewOption.equals("ARC") ){
						viewOption = "Archived";
					}
					else if ( viewOption.equals("CUR") ){
						viewOption = "Approved";
					}
					else if ( viewOption.equals("PRE") ){
						viewOption = "Proposed";
					}
					out.println("					<input type=\'hidden\' name=\'edt\' value=\'0\'>" );
				}
				out.println( viewOption );
				out.println("					<input type=\'hidden\' name=\'viewOption\' value=\'" + viewOption + "\'>" );
			}
			else{
				out.println( viewOption );
				out.println("					<input type=\'hidden\' name=\'viewOption\' value=\'" + viewOption + "\'>" );
			}

			out.println("					 </td>" );
			out.println("				</tr>" );

			// form buttons
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );

			if ( screen.equals("2") ){
				out.println("							<input type=\'submit\' name=\'aseBack\' value=\'Back\' class=\'inputsmallgray\' onClick=\"return goBack()\">" );
			}

			out.println("							<input type=\'hidden\' name=\'formDirection\' value=\'Submit\'>" );
			out.println("							<input type=\'hidden\' name=\'edt\' value=\'" + editType + "\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'cp\' value=\'" + callerPage + "\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm_" + screen + "()\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
