<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwcrsy.jsp
	*	2007.09.01	view outline.
	*				for PRE and CUR, send directly to vwcrsx since there would always
	*				be only 1 of each. For ARC, show user all the different versions
	*
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "90%";
	String pageTitle = "View Outline";
	fieldsetTitle = pageTitle;

	int comp = website.getRequestParameter(request,"comp",0);
	int dtl = website.getRequestParameter(request,"dtl",0);

	boolean compressed = false;
	boolean detail = false;

	if (comp==1){
		compressed = true;
	}

	if (dtl==1){
		detail = true;
	}

	String kix = website.getRequestParameter(request,"kix");
%>
<html>
<head>
	<%@ include file="ase3.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="../inc/expand.jsp" %>

	<script type="text/javascript">

		$(document).ready(function () {

			var elem = document.getElementById("expand");
			if (typeof elem.onclick == "function") {
				 elem.onclick.apply(elem);
			}

		});

	</script>

</head>
<body topmargin="10" leftmargin="10">
<table width="100%">
	<tr>
		<td valign="top" width="03%">&nbsp;</td>
		<td valign="top">
			<%
				String user = website.getRequestParameter(request,"aseUserName","",true);
				String[] info = helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];
				String campus = info[Constant.KIX_CAMPUS];

				//
				// outline stamp in footer (ER00038 - HAW)
				//
				String outlineLastDate = "";

				if ((Constant.ON).equals(Util.getSessionMappedKey(session,"showAuditStampInFooter"))){
					outlineLastDate = outlines.footerStatus(conn,kix,type);
				} // showAuditStampInFooter

				if (processPage && !kix.equals(Constant.BLANK)){

					String htmlName = com.ase.aseutil.io.Util.getHtmlNameIfExists(conn,campus,Constant.COURSE,kix,alpha,num);

					/*
						code checks for existing HTML. If there, show instead of hitting database.
						however, because of caching, refresh not correct?

						this works, just having to undo for now

						if(!htmlName.equals(Constant.BLANK)){
							response.sendRedirect(htmlName);
						}
						else{
							msg = outlines.viewOutline(conn,kix,user,compressed);
							out.println("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>");
							out.println(courseDB.getCourseDescriptionByType(conn,campus,alpha,num,type) + "</p>");
							out.println(msg.getErrorLog());
						}
					*/

					msg = outlines.viewOutline(conn,kix,user,compressed,false,false,detail);
					out.println("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>");
					out.println(courseDB.getCourseDescriptionByTypePlus(conn,campus,alpha,num,type) + "</p>");
					out.println(msg.getErrorLog());
				} // process page

				asePool.freeConnection(conn,"vwcrsy",user);
			%>
		</td>
	</tr>

	<%
		if(dtl==1){
	%>
			<tr>
				<td colspan="2"><p align="center">
					(
					<a class="linkcolumn" href="vwcrsx.jsp#" id="collapse" onclick="ddaccordion.collapseall('technology'); return false">Collapse</a>
					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
					<a class="linkcolumn" href="vwcrsx.jsp#" id="expand" onclick="ddaccordion.expandall('technology'); return false">Expand</a>
					)
					</p>
				</td>
			</tr>
	<%
		}
	%>

	<tr>
		<td colspan="2" height="50" valign="bottom">
			<div class="hr"></div>
			<table width="100%">
				<tr>
					<td align="left"><font class="copyright"><%=aseUtil.copyright()%></font></td>
					<td align="right"><font class="copyright"><%=outlineLastDate%></font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>

