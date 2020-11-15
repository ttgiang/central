<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkr.jsp	- linker page
	*
	*	url args should consist of kix, src, dest, keyid, and caller
	*
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");
	String src = website.getRequestParameter(request,"src");
	String dst = website.getRequestParameter(request,"dst");
	int keyid = website.getRequestParameter(request,"keyid",0);

	String caller = website.getRequestParameter(request,"caller");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Course Competency";

	String pageHeader = "";
	String columnHeader = "";
	String content = "";

	// 1 of 3) data for display at top
	if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
		columnHeader = "Competency";
		fieldsetTitle = "Outline Competency";
		content = CompetencyDB.getContentByID(conn,kix,keyid);
	}
	else if ((Constant.COURSE_CONTENT).equalsIgnoreCase(src)){
		columnHeader = "Content";
		fieldsetTitle = "Outline Content";
		Content c = ContentDB.getContentByID(conn,keyid);
		content = c.getLongContent();
	}
	else if ((Constant.COURSE_OBJECTIVES).equalsIgnoreCase(src)){
		columnHeader = "Course Outline SLO";
		fieldsetTitle = "Outline Objective";
		content = CompDB.getObjective(conn,kix,keyid);
	}
	else if ((Constant.COURSE_PROGRAM_SLO).equalsIgnoreCase(src)){
		if ("Competency".equalsIgnoreCase(dst)){
			columnHeader = "Program SLO";
			fieldsetTitle = "Program SLO";
			content = GenericContentDB.getComments(conn,kix,keyid);
		}
		else if ("PSLO".equalsIgnoreCase(dst)){
			columnHeader = "Course SLO";
			fieldsetTitle = "Program SLO";
			content = CompDB.getObjective(conn,kix,keyid);
		}
	}

	// 2 of 3) labels
	if ("Assess".equalsIgnoreCase(dst)){
		pageHeader = "Linking Assessment(s)";
	}
	else if ("Competency".equalsIgnoreCase(dst)){
		pageHeader = "Linking Competency(s)";
	}
	else if ("Content".equalsIgnoreCase(dst)){
		pageHeader = "Linking Content(s)";
	}
	else if ("GESLO".equalsIgnoreCase(dst)){
		pageHeader = "Linking GenED";
	}
	else if ("MethodEval".equalsIgnoreCase(dst)){
		pageHeader = "Linking Evaluation(s)";
	}
	else if ("PSLO".equalsIgnoreCase(dst)){
		pageHeader = "Linking Program SLO(s)";
	}

	// 3 of 3) data for link
	// rtn is 3 element array.
	// rtn[0] = size of array
	// rtn[1] = values of each array
	// rtn[2] = the resulting list to display on screen
	String[] rtn = new String[3];

	//System.out.println("src: " + src);
	//System.out.println("dst: " + dst);
	//System.out.println("keyid: " + keyid);

	rtn = LinkerDB.getLinkedData(conn,campus,src,dst,kix,keyid,true,false);

	if (rtn==null){
		rtn[0] = "";	// number of entries for selection
		rtn[1] = "";	// entry keys of items available for selection
		rtn[2] = "";	// resulting table HTML
	}

	//System.out.println(rtn[0]);
	//System.out.println(rtn[1]);
	//System.out.println(rtn[2]);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crslnkr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<form name="aseForm" method="post" action="/central/servlet/linker?arg=lnk">
	<table border="0" cellpadding="2" width="60%" align="center" cellspacing="1" class="tableBorder<%=session.getAttribute("aseTheme")%>">
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
			<td valign="top" colspan="2" class="textbrownTH"><%=pageHeader%><br></td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
			<td valign="top" width="15%" class="textblackTH">Outline: </td>
			<td class="dataColumn"><%=pageTitle%></td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
			<td valign="top" width="15%" class="textblackTH" nowrap><%=columnHeader%>: </td>
			<td class="dataColumn"><%=content%><br/></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2"><%=rtn[2]%></td></tr>
		<tr>
			<td colspan="2" align="left">
				<br />
				<input type=hidden value="<%=rtn[0]%>" name="totalKeys">
				<input type=hidden value="<%=rtn[1]%>" name="allKeys">

				<input type=hidden value="<%=kix%>" name="kix">
				<input type=hidden value="<%=src%>" name="src">
				<input type=hidden value="<%=dst%>" name="dst">
				<input type=hidden value="<%=keyid%>" name="keyid">
				<input type=hidden value="<%=caller%>" name="caller">

				<input type=hidden value="<%=alpha%>" name="alpha">
				<input type=hidden value="<%=num%>" name="num">
				<input type=hidden value="<%=campus%>" name="campus">
				<input type=hidden value="<%=currentTab%>" name="currentTab">
				<input type=hidden value="<%=currentNo%>" name="currentNo">
				<input type="hidden" name="formAction" value="c">
				<input type="hidden" name="formName" value="aseForm">
				<input title="save selection(s)" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onClick="return checkForm('s')">
				<input title="abort selected operation" type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return checkForm('s')">
				<br/><br/><br/>
				&nbsp;&nbsp;<b>Instruction:</b>&nbsp;place a check mark beside the item(s) to link.
			</td>
		</tr>
	</table>
</form>

<%
	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
