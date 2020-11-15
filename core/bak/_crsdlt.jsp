<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdlt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// course to work with
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsdlt&viewOption=CUR");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = (String)session.getAttribute("aseCampus");
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Maintenance";

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsdlt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="crsdltxx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<div align="left">
						&nbsp;&nbsp;&nbsp;If you select to continue, the following actions are performed:
						<ul>
							<li>The course will be archived prior to deletion</li>
							<li>Similar course references will be removed</li>
						</ul>
					</div>
					Do you wish to continue?
					<br />
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<TR><TD align="center"><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<TR>
				<TD align="center">
					<br />
					<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>
<br>
<%
	if ( alpha.length() > 0 && num.length() > 0 ){
		String sql = "";
		sql = aseUtil.getPropertySQL( session, "crscoreqidx" );
		if ( sql != null && sql.length() > 0 ){
			out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td colspan=2>&nbsp;</td></r>" );
			out.println("<tr class=tableCaption align=center><td colspan=2><font class=textblackTH>Co-Requisites</font>" );
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", "CUR");
			paging = new com.ase.paging.Paging();
			paging.setRecordsPerPage(99);
			paging.setNavigation( false );
			paging.setSorting( false );
			paging.setSQL( sql );
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
			out.println("</td></tr>" );
		}

		sql = aseUtil.getPropertySQL( session, "crsprereqidx" );
		if ( sql != null && sql.length() > 0 ){
			out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'><td colspan=2>&nbsp;</td></r>" );
			out.println("<tr class=tableCaption align=center><td colspan=2><font class=textblackTH>Pre-Requisites</font>" );
			sql = aseUtil.replace(sql, "_sql_", campus);
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_type_", "CUR");
			paging = new com.ase.paging.Paging();
			paging.setRecordsPerPage(99);
			paging.setNavigation( false );
			paging.setSorting( false );
			paging.setSQL( sql );
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
			out.println("</td></tr>" );
		}

		out.println("</table>" );
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
