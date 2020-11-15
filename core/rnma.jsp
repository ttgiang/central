<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnma.jsp - rename/renumber approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crsrnm";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}
	else{
		alpha = website.getRequestParameter(request,"fromAlpha","");
		num = website.getRequestParameter(request,"fromNum","");
		type = website.getRequestParameter(request,"type","");
	}

	// GUI
	String chromeWidth = "70%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Rename/Renumber Approval";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="bigbox.jsp" %>
	<script language="JavaScript" src="js/rnma.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			RenameDB renameDB = new RenameDB();
			Rename rename = renameDB.getRename(conn,kix);

			if(rename != null){

				String title = courseDB.getCourseItem(conn,kix,"coursetitle");

				String proposer = rename.getProposer();

				String renameRenumber = "Rename "
											+ rename.getFromAlpha()
											+ " "
											+ rename.getFromNum()
											+ " to "
											+ rename.getToAlpha()
											+ " "
											+ rename.getToNum();

				String justification = rename.getJustification();

				String approvers = rename.getApprovers();

				out.println("		<form method=\'post\' name=\'aseForm\' action=\'rnmax.jsp\'>" );

				out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td width=\'15%\' class=\'textblackTH\' valign=\"top\" nowrap>Proposer:&nbsp;</td>" );
				out.println("					 <td width=\'70%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println(proposer);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Course Title:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(title);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Request:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(renameRenumber);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" nowrap>Justification:&nbsp;</td>" );
				out.println("					 <td class=\'dataColumn\' valign=\"top\">" );
				out.println(justification);
				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\' valign=\"top\" colspan=\"3\"><div class=\"hr\"></div></td>" );
				out.println("				</tr>" );

				// show completed approvals
				for(com.ase.aseutil.Generic g: RenameDB.showCompletedProgress(conn,kix)){
				%>
				  <tr height="25">
					 <td class="textblackTH" valign="top" nowrap><%=g.getString1()%></td>
					 <td align="left" class="datacolumn" valign="top"><%=g.getString3()%>  - <%=g.getString2()%></td>
					 <td align="left" class="datacolumn" valign="top">
						<%
							if(g.getString4().equals("1")){
								out.println("<img src=\"../images/approved.gif\">");
							}
							else{
								out.println("<img src=\"../images/denied.gif\">");
							}
						%>
					 </td>
				  </tr>
				<%
				}

				// person doing approval
				out.println("				<tr height=\'25\'>" );
				out.println("					 <td class=\'textblackTH\'  width=\"15%\">"+user+":&nbsp;</td>" );
				out.println("					 <td>" );

				String ckName = "approval";
				String ckData = "";
		%>
				<%@ include file="ckeditor02.jsp" %>
		<%

				out.println("				</td>" );
				out.println("					 <td width=\'15%\'  class=\'dataColumn\' valign=\"top\">" );
				out.println("");
				out.println("				</td></tr>" );

		%>
				<TR><td>&nbsp;</td><TD align="left" colspan="2"><% out.println(Skew.showInputScreen(request)); %></td></tr>
		<%
				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTHRight\' colspan=\'3\'><br/>" );
				out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'q\'>" );
				out.println("							<input title=\"continue\" type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Approved\' class=\'inputgo\' onClick=\"return checkForm(\'s\')\">" );
				out.println("							<input title=\"continue\" type=\'submit\' name=\'aseDenied\' id=\'aseDenied\' value=\'Denied\' class=\'inputstop\' onClick=\"return checkForm(\'s\')\">" );
				out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputother\' onClick=\"return cancelForm()\">" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("			</table>" );
				out.println("		</form>" );

			} // got a valid rename structure

			renameDB = null;
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"rnma",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
