<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnksx.jsp - delete linker entry
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "crslnksx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String action = website.getRequestParameter(request,"act", "");
	String kix = website.getRequestParameter(request,"kix", "");
	String src = website.getRequestParameter(request,"src", "");
	String dst = website.getRequestParameter(request,"dst", "");
	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");
	int keyid = website.getRequestParameter(request,"keyid",0);

	boolean isDeletable = false;

	String content = "";

	String type = (String)session.getAttribute("aseType");
	if (type==null)
		type="PRE";

	String message = "";
	String inputTitle = "";

	if (processPage && formName != null && formName.equals("aseForm") ){
		if ( alpha != null && num != null ){
			if ("r".equals( action)){
				content = CompetencyDB.getContentByID(conn,kix,keyid);
				isDeletable = LinkerDB.isMaxtrixItemDeletable(conn,campus,kix,src,keyid);
			}
		}	// alpha & num
	}	// valid form

	// GUI
	String chromeWidth = "80%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete SLO";

	if ((Constant.COURSE_OBJECTIVES).equalsIgnoreCase(src)){
		fieldsetTitle = "Delete SLO";
		inputTitle = "SLO";
	}
	else if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
		fieldsetTitle = "Delete Competency";
		inputTitle = "Competency";
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crslnksx.js"></script>

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
	if (processPage) {
%>
<form method="post" action="/central/servlet/linker?arg=frm" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="20%">Campus:</TD>
				<TD class="datacolumn"><%=campus%></TD>
			</TR>
			<TR height="20">
				<TD class="textblackTH" width="20%"><%=inputTitle%>:</TD>
				<TD class="datacolumn"><%=content%></TD>
			</TR>
			<TR height="20">
				<TD colspan="2"><div class="hr"></div></TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=keyid%>" name="keyid">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
					<input type="hidden" value="<%=src%>" name="src">
					<input type="hidden" value="<%=dst%>" name="dst">
					<input type="hidden" value="<%=action%>" name="act">

					Do you wish to continue?<br/><br/>
					<%
						if (isDeletable){
					%>
						<input title="continue with request" type="submit" name="aseDelete" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
						<input title="end requested operation" type="submit" name="aseCancel" value=" No  " class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=src%>','<%=dst%>','<%=keyid%>')">
					<%
						}
						else{
					%>
							<input title="continue with request" type="submit" name="aseDeleteForce" value="Force Delete" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
							<input title="end requested operation" type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=src%>','<%=dst%>','<%=keyid%>')">
							&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="hr"></div>
						<p align="left"><font class="textblack">NOTE:</font> Requested item has links to other outline items and is not deletable at this time. If you feel the linked items shown below are incorrect, click the 'Force Delete' button to continue or 'Cancel' to abort the operation.</p>
					<%
							out.println("<fieldset class=\"FIELDSET100\">");
							out.println("<legend>Linked Items</legend>");

							String sql = aseUtil.getPropertySQL(session,"matrixBySRC");
							sql = sql.replace("_kix_",kix);
							sql = sql.replace("_src_",src);
							sql = sql.replace("_seq_",""+keyid);

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
