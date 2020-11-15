<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	newsdlt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";
	String pageTitle = "News Detail";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	int lid = 0;

	lid = website.getRequestParameter(request,"lid", 0);
	NewsDB newsDB = new NewsDB();
	News news = new News();

	if ( lid > 0 ){
		news = newsDB.getNews( conn, lid);
	}

	asePool.freeConnection(conn,"newsdtl",user);

%>

									<table width="100%" cellspacing='1' cellpadding="6" style="BORDER-TOP: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-RIGHT: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-BOTTOM: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-LEFT: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid" align="center" border="0">
										<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
											 <td class="textblackTH" width="20%">Author:&nbsp;</td>
											 <td><%=news.getAuditBy()%></td>
										</tr>
										<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
											 <td class="textblackTH" width="20%">Date Posted:&nbsp;</td>
											 <td><%=news.getAuditDate()%></td>
										</tr>
										<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
											 <td class="textblackTH" width="20%">Title:&nbsp;</td>
											 <td><%=news.getTitle()%></td>
										</tr>
										<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
											 <td class="textblackTH" width="20%">News:&nbsp;</td>
											 <td><%=news.getContent()%></td>
										</tr>
									</table>
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE class=epi-chromeHeaderBG cellSpacing=0 cellPadding=4 width="100%" background=Home_files/chrome_bg.gif border=0>
						<TBODY>
							<TR>
								<TD class=epi-chromeHeaderFont id="" noWrap width="100%">
									<B><div align="center"><a href="javascript:history.go(-1)">previous page</a></div></B>
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>