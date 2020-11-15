<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscpyxy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String toAlpha = "";
	String toNum = "";

	String temp = "";
	String type = "";
	String comments = "";

	boolean valid = true;

	String fromCampus = website.getRequestParameter(request,"fromCampus","");
	String fromAlpha = website.getRequestParameter(request,"fromAlpha","");
	String fromNum = website.getRequestParameter(request,"fromNum","");

	String kix = website.getRequestParameter(request,"kix");
	String[] info = helper.getKixInfo(conn,kix);
	fromAlpha = info[Constant.KIX_ALPHA];
	fromNum = info[Constant.KIX_NUM];
	fromCampus = info[Constant.KIX_CAMPUS];
	type = info[Constant.KIX_TYPE];

	String fromCampusName = CampusDB.getCampusNameOkina(conn,fromCampus);
	String campusName = CampusDB.getCampusNameOkina(conn,campus);

	toAlpha = website.getRequestParameter(request,"alpha_ID","");
	if (toAlpha.equals(""))
		toAlpha = website.getRequestParameter(request,"alpha","");

	toNum = website.getRequestParameter(request,"toNum","");
	comments = website.getRequestParameter(request,"comments","");

	String message = "Do you wish to continue with copy operation?";

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s")){
				if (toAlpha.equals("")){
					message = "Missing or invalid TO ALPHA.";
					valid = false;
				}
				else{
					if(fromAlpha.equals(toAlpha) && fromNum.equals(toNum) && fromCampusName.equals(campus)){
						message = "From and To values are identical. Please revise your entry.";
						valid = false;
					}
					else{
						msg = courseDB.isCourseCopyable(conn,campus,toAlpha,toNum);
						if (!"".equals(msg.getMsg())){
							valid = false;
							if ("NotAllowToCopyOutline".equals(msg.getMsg())){
								temp = "Click <a href=\"vwcrsx.jsp?kix=" + kix + "&t="+type+"\" class=\"linkcolumn\">here</a> to view outline for " + fromAlpha + " " + fromNum + ".";
							}
							message = MsgDB.getMsgDetail(msg.getMsg()) + ".&nbsp;" + temp;
						}
					} // from /to
				} // toalpha
			}	// action = s
		}	// valid form
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",fromAlpha,fromNum,fromCampus);
	fieldsetTitle = "Copy Outline";

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscpy.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
			   "bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '40%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="crscpyxy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br /><br />
					<TABLE cellSpacing=0 cellPadding=0 width="60%" border=0>
						<TBODY>
							<TR height="20">
								<TD class="textblackth" width="25%" valign="bottom">From:</td>
								<td class="datacolumn"><%=fromCampusName%>&nbsp;-&nbsp;<%=fromAlpha%>&nbsp;<%=fromNum%></td>
							</tr>
							<TR height="20">
								<td class="textblackth" width="25%" valign="bottom">To:</td>
								<td class="datacolumn"><%=campusName%>&nbsp;-&nbsp;<%=toAlpha%>&nbsp;<%=toNum%></td>
							</tr>
							<TR height="20">
								<td class="textblackth" width="25%" valign="bottom">Comments:</td>
								<td class="datacolumn"><%=comments%></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=fromCampus%>" name="fromCampus">
					<input type="hidden" value="<%=fromAlpha%>" name="fromAlpha">
					<input type="hidden" value="<%=fromNum%>" name="fromNum">
					<input type="hidden" value="<%=toAlpha%>" name="toAlpha">
					<input type="hidden" value="<%=toNum%>" name="toNum">
					<input type="hidden" value="<%=comments%>" name="comments">
				</TD>
			</TR>
			<%
				if (valid) {
			%>
				<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>

				<TR>
					<TD align="center">
						<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
						<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
						</div>
					</td>
				</tr>

				<TR>
					<TD align="center">
						<br />
						<input id="cmdYes" title="save entered data" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkFormX('s')">&nbsp;
						<input id="cmdNo" title="abort selected operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>

			<%
				}

				out.println("<TR><td><div class=\"hr\"></div>Similar outlines found at other campuses</td></TR>");
				String sql = aseUtil.getPropertySQL( session, "getOtherCampuses2" );
				if ( sql != null && sql.length() > 0 ){

					sql = aseUtil.replace(sql, "_alpha_", toAlpha);
					sql = aseUtil.replace(sql, "_num_", toNum);

					paging = null;

					com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
					out.print("<TR><td><br/>" + jqPaging.showTable(conn,sql,"") + "</td></tr>");
					jqPaging = null;

				}
				out.println("<TR><td><br/><p align=\"center\">click <a href=\"crscpyxx.jsp?cps="+fromCampus+"&kix="+kix+"\" class=\"linkcolumn\">here</a> to try again.</p></td></TR>");

			%>
		</TBODY>
	</TABLE>
</form>

<%
	asePool.freeConnection(conn,"crscpyxy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

