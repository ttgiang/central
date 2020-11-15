<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	stmt.jsp
	*	2007.09.01	statement maintenance
	*	TODO statement not showing up correctly. display type
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "70%";

	String pageTitle = "General Statement Maintenance";

	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"./images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('stmtHelp');\">";

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/stmt.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

	<div id="forum_wrapper">
			<div id="stmtHelp" style="width: 100%; display:none;">
				<p>&nbsp;</p>
				<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
					<TBODY>
						<TR>
							<TD class=title-bar width="50%"><font class="textblackth">Course Catalog</font></TD>
							<td class=title-bar width="50%" align="right">
								<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('stmtHelp');">
							</td>
						</TR>
						<TR>
							<TD colspan="2">
								<ol>
									<li>Determine the layout of your catalog</li>
									<li>Click 'view catalog fields' to determine data elements for your catalog template</li>
									<li>Type the data elements in the text box below. Enclose data elements in square brackets ([]).
										<ul>
											<li>data elements beginning with 'c.' are core or primary elements (course tab)</li>
											<li>data elements beginning with 'cd.' are campus specific or comments elements (campus tab)</li>
											<li>include {cc_nb} at the beginning of lines to suppressed when it's empty</li>
										</ul>
									</li>
									<li>Format (bold, italics) your catalog template</li>
									<li>Due to the nature of HTML creation, use the 'Source' button to make sure your tags are in order</li>
									<li>Press SHIFT+ENTER to separate one item from the next</li>
								</ol>
								<br>
								NOTE: your campus web developer is a good resource for this effort.
							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</div>
	</div>

<%
	if (processPage){
		try{
			int lid = 0;
			String type = "";
			String statement = "";
			String auditby = "";
			String auditdate = "";

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if ( request.getParameter("lid") != null ){
				lid = Integer.parseInt(request.getParameter("lid"));
				if ( lid > 0 ){
					Stmt stmt = StmtDB.getStatement(conn,lid,campus);
					if ( stmt != null ){
						type = stmt.getType();
						statement = stmt.getStmt();
						auditby = stmt.getAuditBy();
						auditdate = stmt.getAuditDate();
					}
				}
				else{
					lid = 0;
					auditdate = aseUtil.getCurrentDateTimeString();
					auditby = user;
				}
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/yoda\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("				<tr>" );
			out.println("					 <td width=\"10%\" class=\'textblackTH\'>ID:&nbsp;</td>" );
			out.println("					 <td>" + lid + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Name:&nbsp;</td>" );
			out.println("					 <td><input size=\'50\' maxlength=\'50\' class=\'input\'  name=\'type\' type=\'text\' value=\'" + type +"\'>" );

			if (type.equals("Catalog")){
				out.println("&nbsp;&nbsp;<a href=\"crscatw.jsp\" class=\"linkcolumn\" target=\"_blank\">view catalog fields</a>");
			}

			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Statement:&nbsp;</td>" );
			out.println("					 <td>" );

			String ckName = "statement";
			String ckData = statement;

%>
			<%@ include file="ckeditor02.jsp" %>
<%

			out.println("					</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + campus + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );

			if ( lid > 0 ){
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"stmt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
