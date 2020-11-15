<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscntnt.jsp	course content
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
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

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy") || caller.equals("crscmp")){
		validCaller = true;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String src = Constant.COURSE_CONTENT;

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
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage && validCaller){
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

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/linker?arg=frm\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td colspan=\"2\">");
			out.println("					<table width=\'100%\' cellspacing='1' cellpadding='2' border=\'0\'>" );
			out.println("						<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"10%\">&nbsp;</td>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"80%\">" + pageTitle + "</td>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"10%\">"
					+ "<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
					+ "<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\"></td>");
			out.println("						</tr>" );
			out.println("					</table>" );

			out.println("<p align=\"right\"><a href=\"qlst1.jsp?rtn2=edtcnt&kix="+kix+"&itm="+src+"\" class=\"linkcolumn\">Quick List Entry</a>&nbsp;</p>"
						+ "</td>" );

			out.println("			</tr>" );

%>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td colspan="2">
							<%
								String helpArg1 = "Course";
								String helpArg2 = "Content";
							%>
							<%@ include file="crshlpx.jsp" %>
						</td>
					</tr>

<%
			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + campusName );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Content:&nbsp;</td>" );
			out.println("				 <td><textarea class=\'input\' id=\"content\" name=\"content\" cols=100 rows=10>" + content + "</textarea>" );

			String ckEditorName = "content";
%>
<%@ include file="ckeditor01.jsp" %>
<%
			out.println("			</td></tr>" );
			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
			out.println("				<td><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'thisOption\' value=\'PRE\'>" );
			out.println("					<input type=\'hidden\' name=\'reqID\' value=\'" + reqID + "\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'src\' value=\'" + src + "\'>" );
			out.println("					<input type=\'hidden\' name=\'dst\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'keyid\' value=\'" + reqID + "\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"save content\" type=\'submit\' name=\'aseSave\' value=\'Save\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\',1000);\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+alpha+"','"+num+"','"+currentTab+"','"+caller+"','"+campus+"')\">" );
			out.println("			</td></tr>" );
			out.println("		</form>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );

			// in edit mode, we use PRE
			String thisType = "PRE";
			if(!caller.equals("crsedt")){
				String[] kixInfo = helper.getKixInfo(conn,kix);
				thisType = kixInfo[Constant.KIX_TYPE];
			}

			out.println(ContentDB.getContentForEdit(conn,campus,alpha,num,thisType));

			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"crscntnt",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
