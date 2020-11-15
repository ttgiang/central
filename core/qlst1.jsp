<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	qlst1.jsp	- quickly collect slo, comp...
	*
	*  work on this page includes editing qlst.js as well
	*
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Quick List Entry";
	fieldsetTitle = pageTitle;

	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	// item to work on
	String itm = website.getRequestParameter(request,"itm","");

	// where to return 2 when process completes. when doing
	// quick list entry from the menu, it goes back to quick list entry
	// when doing quick list entry from editing screen, return to edit
	String rtn2 = website.getRequestParameter(request,"rtn2","");

	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);

	String html = "";
	String tabTitle = "";

	if (!itm.equals("")){
		if (itm.equals(Constant.COURSE_OBJECTIVES)){
			tabTitle = "Outline SLO";
			html = CompDB.getObjectives(conn,kix);
			if ("".equals(html))
				html = CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,itm);
		}
		else if(itm.equals(Constant.COURSE_COMPETENCIES)){
			tabTitle = "Competency";
			html = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
		}
		else if(itm.equals(Constant.COURSE_CONTENT)){
			tabTitle = "Content";
			html = ContentDB.getContentAsHTMLList(conn,campus,alpha,num,type,kix,true,false);
		}
		else if(itm.equals(Constant.COURSE_PROGRAM_SLO)){
			tabTitle = "Program SLO";
			html = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_PROGRAM_SLO);
		}
		else if(itm.equals(Constant.COURSE_INSTITUTION_LO)){
			tabTitle = "Institution LO";
			html = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_INSTITUTION_LO);
		}
	}

	asePool.freeConnection(conn,"qlst1",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/qlst.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
%>

<table width="100%" border="0">
	<tr>
		<td width="30%" valign="top">
			<fieldset class="FIELDSET280">
				<legend>Outline Information</legend>
				<%@ include file="crsedt9.jsp" %>
				<br/><br/><br/><br/><br/>
			</fieldset>
		</td>
		<td width="70%" valign="top">
			<fieldset class="FIELDSET560">
			<legend><strong>Quick List - step 3 of 4</strong></legend>
				<form name="aseForm" method="post" action="qlst2.jsp">
					<font class="textblackth">Paste your list in the box below then separate each item with double slashes (//).<br/>
					Finalize the list by	removing all unnecessary text and spaces.</font><br/>
					<textarea name="lst" cols="100" rows="10" class="input"></textarea>
					<br/><br/>
					<font class="textblackth">Clear existing outline content:</font> <input type="checkbox" name="clr" value="1" class="input">
					&nbsp;&nbsp;&nbsp;
					<font class="textblackth">Clear existing list:</font> <input type="checkbox" name="clrList" value="1" class="input">
					<br/><br/>
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=itm%>" name="itm">
					<input type="hidden" value="<%=rtn2%>" name="rtn2">
					<input title="continue" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				</form>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td width="100%" colspan="2" valign="top">
			<fieldset class="FIELDSET">
				<legend><%=tabTitle%></legend>
				<%=html%>
			</fieldset>
		</td>
	</tr>
</table>

<%
	}
%>


<%@ include file="../inc/footer.jsp" %>

</body>
</html>
