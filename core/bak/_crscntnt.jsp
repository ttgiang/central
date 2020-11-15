<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscntnt.jsp	course content
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	//String alpha = website.getRequestParameter(request,"alpha");
	//String num = website.getRequestParameter(request,"num");

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
	}

	if ((alpha == null || alpha.length() == 0) && (num == null || num.length() == 0)){
		response.sendRedirect("sltcrs.jsp?cp=crscntnt&viewOption=PRE");
	}

	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	// GUI
	String campus = (String)session.getAttribute("aseCampus");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Content";

	int reqID = website.getRequestParameter(request,"id",0);
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

	<script type="text/javascript" src="js/crscntnt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if ("crsedt".equals(caller)){
		try{

			String description = "";
			String content = "";

			if (reqID > 0){
				Content cont = ContentDB.getContentByID(conn,reqID);
				if (cont!=null){
					description = cont.getShortContent();
					content = cont.getLongContent();
				}
			}

			out.println("	<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crscntntx.jsp\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textbrownTH\' colspan=\"2\">" + pageTitle + "<br><br></td>" );
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + campusName );
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Description:&nbsp;</td>" );
			out.println("				 <td><input type=\"text\" class=\'input\' size=50 maxlength=30 id=\"description\" name=\"description\" value=\"" + description + "\">" );
			out.println("			</td></tr>" );
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Content:&nbsp;</td>" );
			out.println("				 <td><textarea class=\'input\' id=\"content\" name=\"content\" cols=80 rows=5>" + content + "</textarea>" );
			out.println("			</td></tr>" );
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
			out.println("				<td><input type=\'hidden\' name=\'thisAlpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'thisNum\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'thisOption\' value=\'PRE\'>" );
			out.println("					<input type=\'hidden\' name=\'reqID\' value=\'" + reqID + "\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"save content\" type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+alpha+"','"+num+"','"+currentTab+"','"+currentNo+"')\">" );
			out.println("			</td></tr>" );
			out.println("		</form>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );
			out.println(ContentDB.getContentForEdit(conn,campus,alpha,num,"PRE"));
			out.println("			 </td>" );
			out.println("		</tr>" );

			// form buttons
			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn);

%>

<p align="left"><b>Instruction:</b> <font>as an option, course contents may be broken down into individual lined items.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
