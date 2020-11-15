<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnm.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM,session,response,request).equals("") ){
		return;
	}

	// course to work with
	String courseAlpha = "";
	String courseNum = "";
	String campus = (String)session.getAttribute("aseCampus");

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		courseAlpha = info[0];
		courseNum = info[1];
	}
	else{
		courseAlpha = website.getRequestParameter(request,"alpha");
		courseNum = website.getRequestParameter(request,"num");
	}

	if ( ( courseAlpha == null || courseAlpha.length() == 0 ) && ( courseNum == null || courseNum.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsrnm&viewOption=CUR");
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",courseAlpha,courseNum,campus);
	fieldsetTitle = "Renumber Outline";

	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
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

	<script language="JavaScript" src="js/crsrnm.js"></script>
	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if ( "sendRedirect".equals( message ) ){
		asePool.freeConnection(conn);
	}
	else{
		if (message.length()==0)
			showFormAjax(request,response,session,out,conn,aseUtil,courseAlpha,courseNum);
		else
			showMessage(request,response,out,conn,message,courseAlpha,courseNum,campus);

		asePool.freeConnection(conn);
	}
%>

<%!
	//
	// show this form with data
	//
	void showFormAjax(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						AseUtil aseUtil,
						String fromAlpha,
						String fromNum) throws java.io.IOException {
		try{
			String sql = "";
			String view = "";
			String campus = (String)session.getAttribute("aseCampus");

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsrnmx.jsp\'>" );
			out.println("			<input type=\"hidden\" id=\"campus\" name=\"campus\" value=\"" + campus + "\">" );
			out.println("			<input type=\"hidden\" id=\"thisOption\" name=\"thisOption\" value=\"CUR\">" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap colspan=2><br /><p align=\'center\'>Enter new course alpha and number</p><br /></td>" );
			out.println("				</tr>" );
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.campus,'APPROVED')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("				</td></tr>" );
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"toNum\" name=\"toNum\" autocomplete=\"off\" value=\"\" size=\'4\' maxlength=\'4\'>" );
			out.println("				</td></tr>" );

			out.println("		<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td colspan=2>&nbsp;</td></r>" );
			out.println("		<tr class=tableCaption align=center><td colspan=2><font class=textblackTH>Cross Listing</font>" );
			com.ase.paging.Paging paging = new com.ase.paging.Paging();
			sql = aseUtil.getPropertySQL( session,"crsxrfidx" );
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql,"_sql_",campus);
				sql = aseUtil.replace(sql,"_alpha_",fromAlpha);
				sql = aseUtil.replace(sql,"_num_",fromNum);
				sql = aseUtil.replace(sql,"_type_","CUR");
				paging.setRecordsPerPage(99);
				paging.setNavigation( false );
				paging.setSorting( false );
				paging.setSQL( sql );
				out.print( paging.showRecords( conn,request,response ) );
				paging = null;
			}
			out.println("			 </td></tr>" );

			out.println("		<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td colspan=2>&nbsp;</td></r>" );
			out.println("		<tr class=tableCaption align=center><td colspan=2><font class=textblackTH>Co-Requisites</font>" );
			sql = aseUtil.getPropertySQL( session,"crscoreqidx" );
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql,"_sql_",campus);
				sql = aseUtil.replace(sql,"_alpha_",fromAlpha);
				sql = aseUtil.replace(sql,"_num_",fromNum);
				sql = aseUtil.replace(sql,"_type_","CUR");
				paging = new com.ase.paging.Paging();
				paging.setRecordsPerPage(99);
				paging.setNavigation( false );
				paging.setSorting( false );
				paging.setSQL( sql );
				out.print( paging.showRecords( conn,request,response ) );
				paging = null;
			}
			out.println("			 </td></tr>" );

			out.println("		<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td colspan=2>&nbsp;</td></r>" );
			out.println("		<tr class=tableCaption align=center><td colspan=2><font class=textblackTH>Pre-Requisites</font>" );
			sql = aseUtil.getPropertySQL( session,"crsprereqidx" );
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql,"_sql_",campus);
				sql = aseUtil.replace(sql,"_alpha_",fromAlpha);
				sql = aseUtil.replace(sql,"_num_",fromNum);
				sql = aseUtil.replace(sql,"_type_","CUR");
				paging = new com.ase.paging.Paging();
				paging.setRecordsPerPage(99);
				paging.setNavigation( false );
				paging.setSorting( false );
				paging.setSQL( sql );
				out.print( paging.showRecords( conn,request,response ) );
				paging = null;
			}
			out.println("			 </td></tr>" );

			String notified = aseUtil.lookUp(conn, "tblDistribution", "members", "title='NotifiedWhenRename' AND campus = '" + (String)session.getAttribute("aseCampus") + "'" );
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td colspan=2 nowrap><hr size=1>The following occur upon submission:<ul><li>Rename notifications sent to <strong>" + notified + "</strong></li><li>Rename references to reflect changes</li></ul></td>" );
			out.println("				</tr>" );

			// form buttons
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'fromAlpha\' value=\'" + fromAlpha + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromNum\' value=\'" + fromNum + "\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'q\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(\'s\')\">" );
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

	//
	// showMessage
	//
	void showMessage(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						String message,
						String alpha,
						String num,
						String campus) throws java.io.IOException {

		out.println( "<br><p align=\'center\'>" + message + "</p>" );

		try{
			com.ase.aseutil.CourseDB course = new com.ase.aseutil.CourseDB();
			out.println ( "<p align=center>" + course.showCourseProgress(conn,campus,alpha,num,"PRE") + "</p>" );
			course = null;
		}
		catch(Exception ex){
			out.println ( ex.toString() );
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
