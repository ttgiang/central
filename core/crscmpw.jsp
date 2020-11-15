<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpw.jsp - delete SLO
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "crscmpw";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");
	int compID = website.getRequestParameter(request,"compID",0);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String action = website.getRequestParameter(request,"act", "");
	String kix = website.getRequestParameter(request,"kix", "");
	String slo = "";
	boolean isDeletable = false;

	String type = (String)session.getAttribute("aseType");
	if (type==null)
		type="PRE";

	String message = "";
	String src = Constant.COURSE_OBJECTIVES;

	if (processPage && formName != null && formName.equals("aseForm") ){
		if ( alpha != null && num != null ){
			if (action.equals("r")){
				slo = SLODB.getSLOByID(conn,compID);
				isDeletable = LinkerDB.isMaxtrixItemDeletable(conn,campus,kix,src,compID);
			}
		}	// alpha & num
	}	// valid form

	// GUI
	String chromeWidth = "80%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete SLO";

	asePool.freeConnection(conn,"crscmpw",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscmpw.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '5%' },
					{ sWidth: '25%' },
					{ sWidth: '55%' },
					{ sWidth: '5%' },
					{ sWidth: '5%' },
					{ sWidth: '5%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	if (processPage){
%>
	<form method="post" action="crscmpww.jsp" name="aseForm">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<TR height="20">
					<TD class="textblackTH" width="10%">Campus:</TD>
					<TD class="datacolumn"><%=campus%></TD>
				</TR>
				<TR height="20">
					<TD class="textblackTH" width="10%">SLO:</TD>
					<TD class="datacolumn"><%=slo%></TD>
				</TR>
				<TR height="20">
					<TD colspan="2"><div class="hr"></div></TD>
				</TR>
				<TR>
					<TD align="center" colspan="2">
						<input type="hidden" value="<%=action%>" name="act">
						<input type="hidden" value="<%=kix%>" name="kix">
						<input type="hidden" value="<%=compID%>" name="compID">
						<input type="hidden" value="<%=alpha%>" name="alpha">
						<input type="hidden" value="<%=num%>" name="num">

						Do you wish to continue?<br/><br/>

						<%
							if (isDeletable){
						%>
								<input name="cmdDelete" title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
							<input name="cmdCancel" title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
						<%
							}else
							{
						%>
							<input name="cmdDelete" title="continue with request" type="submit" name="aseDeleteForce" value="Force Delete" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
							<input name="cmdCancel" title="end requested operation" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="hr"></div>
							<p align="left"><font class="textblack">NOTE:</font> Requested item has links to other outline items and is not deletable at this time. If you feel the linked items shown below are incorrect, click the 'Force Delete' button to continue or 'Cancel' to abort the operation.</p>
						<%
								out.println("<fieldset class=\"FIELDSET100\">");
								out.println("<legend>Linked Items</legend>");

								String sql = aseUtil.getPropertySQL(session,"matrixBySRC");

								sql = sql.replace("_kix_",kix);
								sql = sql.replace("_src_",src);
								sql = sql.replace("_seq_",""+compID);

								/*
									paging.setTableColumnWidth("0,5,25,55,5,5,5");
									paging.setSQL(sql);
									paging.setRecordsPerPage(99);
									paging.setShowPrinterFriendly(true);
									paging.setNavigation(false);
									out.print(paging.showRecords(conn,request,response));
								*/

								com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
								out.println(jqPaging.showTable(conn,sql,""));
								jqPaging = null;

								out.println("</fieldset>");
								paging = null;
							}
						%>
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</form>
<%
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
