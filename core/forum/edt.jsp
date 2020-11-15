<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	edt.jsp - create
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Edit Message";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	int fid = website.getRequestParameter(request,"fid",0);

	String kix = null;
	String status = null;
	String forumCampus = null;
	String category = null;
	String title = null;
	String descr = null;
	String auditDate = null;
	String auditBy = null;
	String xref = null;
	int priority = 0;

	boolean lock = false;

	// only sys admin can edit
	if (!SQLUtil.isSysAdmin(conn,user)){
		lock = true;
	}

	if (processPage && fid > 0){
		Forum forum = ForumDB.getForum(conn,fid);
		if (forum != null){
			kix = forum.getHistoryid();
			status = forum.getStatus();
			forumCampus = forum.getCampus();
			category = forum.getSrc();
			title = forum.getForum();
			descr = forum.getDescr();
			priority = forum.getPriority();
			auditDate = forum.getAuditDate();
			auditBy = forum.getAuditBy();
			xref = forum.getXref();
		}
	} // processPage

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="../js/functions.js"></script>
	<script language="JavaScript" src="inc/edt.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<%
	if (processPage && fid > 0){
%>

 <FORM NAME="aseForm" ACTION="edtx.jsp" METHOD="post">
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width="80%" align="left">

		<!--
		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Key:&nbsp;</TD>
			<TD colspan="3" class="datacolumn"><%=kix%></TD>
		</TR>
		-->

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">&nbsp;</TD>
			<TD colspan="3" class="datacolumn">&nbsp;</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Campus:&nbsp;</TD>
			<TD colspan="3" class="datacolumn">
				<%
					if (lock){
						out.println(forumCampus);
					}
					else{
						String sql = aseUtil.getPropertySQL(session,"campusList");
						out.println(aseUtil.createSelectionBox(conn, sql, "forumCampus", forumCampus, "",false ));
					}
				%>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Status:&nbsp;</TD>
			<TD width="35%" class="datacolumn">
				<%
					if (lock){
						out.println(status);
					}
					else{
						out.println(ForumDB.showStatusDDL(conn,status));
					}
				%>
			</TD>
			<%
				if (lock){
			%>
					<TD width="15%" class="textblackth" valign="top">&nbsp;</TD>
					<TD width="35%" class="textblackth">&nbsp;</td>
			<%
				}
				else{
			%>
					<TD width="15%" class="textblackth" valign="top">New Status:&nbsp;</TD>
					<TD width="35%" class="textblackth"><input type="text" name="newStatus" size="20" maxlength="20" class="input" value=""></TD>
			<%
				}
			%>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Category:&nbsp;</TD>
			<TD colspan="3" class="datacolumn">
				<%
					String data = Constant.COURSE
										+ ","
										+ Constant.DEFECT
										+ ","
										+ Constant.ENHANCEMENT
										+ ","
										+ Constant.PROGRAM
										+ ","
										+ Constant.TODO
										+ ",Other";

					String value = "Course,Defect,Enhancement,Program,ToDo,Other";

					if (lock){
						out.println(category);
					}
					else{
						out.println(aseUtil.createStaticSelectionBox(value,data,"src",category,"",""," ",""));
					}
					%>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Priority:&nbsp;</TD>
			<TD colspan="3">
				<%
					if (lock){
						out.println(priority);
					}
					else{
						out.println(aseUtil.createStaticSelectionBox("0,1,2,3,4,5","0,1,2,3,4,5","priority",""+priority,"",""," ",""));
					}
				%>

				<a href="../priority.htm" onclick="asePopUpWindow(this.href,'aseWin','400','200','no','center');return false" onfocus="this.blur()"><img src="../images/helpicon.gif" border="0" alt="help on priority" title="help on priority"></a>

			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Title:&nbsp;</TD>
			<TD colspan="3" class="datacolumn">
				<%
					if (lock){
						out.println(title);
					}
					else{
				%>
						<input type="text" name="forumName" size="100" maxlength="50" class="input" value="<%=title%>">
				<%
					}
				%>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Xref:&nbsp;</TD>
			<TD colspan="3" class="datacolumn">
				<%
					if (lock){
						out.println(xref);
					}
					else{
				%>
						<input type="text" name="xref" size="10" maxlength="18" class="input" value="<%=xref%>">
				<%
					}
				%>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Description:&nbsp;</TD>
			<TD colspan="3" class="datacolumn">
			<%
				if (lock){
					out.println(descr);
				}
				else{

					String ckName = "forumDescr";
					String ckData = descr;
%>
			<%@ include file="../ckeditor02.jsp" %>
<%
				}
			%>

			</TD>
		</TR>

		<TR height="20" valign="top">
			<TD width="15%" class="textblackth">&nbsp;</TD>
			<TD colspan="3" class="datacolumn">&nbsp;</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Audit By:&nbsp;</TD>
			<TD colspan="3" class="datacolumn"><%=auditBy%></TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Audit Date:&nbsp;</TD>
			<TD colspan="3" class="datacolumn"><%=auditDate%></TD>
		</TR>

		<TR height="40">
			<TD width="15%"  class="textblackth">&nbsp;</TD>
			<TD colspan="3"  valign="bottom" ALIGN="left">

		<%
			if (!lock){
		%>
						<input type="hidden" name="kix" value="<%=kix%>">
						<input type="hidden" name="fid" value="<%=fid%>">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
						<INPUT  TYPE="submit" VALUE="Update Message" id=cmdSubmit name=cmdSubmit class="input" onClick="return checkForm('s')">&nbsp;&nbsp;
						<INPUT  TYPE="reset" VALUE="Cancel Form" id=cmdReset name=cmdReset class="input" onClick="return cancelForm()">&nbsp;&nbsp;
		<%
			}
			else{
				out.println("<a href=\"dsplst.jsp?src="+category+"&status="+status+"\" class=\"linkcolumn\">previous page</a>");
			}
		%>
				</TD>
			</TR>

	</TABLE>
</form>

<%
	}

	asePool.freeConnection(conn,"edt",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
