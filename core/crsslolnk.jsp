<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsslolnk.jsp	link content to slo
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";

	String src = website.getRequestParameter(request,"src");
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	String contentLabel = "";
	String servlet = "";

	if ((Constant.COURSE_COMPETENCIES).equals(src)){
		fieldsetTitle = "Course Competency";
		contentLabel = "Competency";
		servlet = "linker?arg=lnk";
	}
	else{
		fieldsetTitle = "Course Content";
		contentLabel = "Content";
		servlet = "windu";
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsslolnk.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<form name="aseForm" method="post" action="/central/servlet/<%=servlet%>">
	<table border="0" cellpadding="2" width="60%" align="center" cellspacing="1" class="tableBorder<%=session.getAttribute("aseTheme")%>">

	<%
		try{
			/*
				display all assessments for selection
			*/
			String allKeys = "";
			ArrayList list = new ArrayList();
			String keyid = website.getRequestParameter(request,"cid");
			String checked = "";
			String content = "";
			String selected = "";
			String temp = "";

			if ((Constant.COURSE_COMPETENCIES).equals(src))
				content = CompetencyDB.getContentByID(conn,kix,NumericUtil.stringToInt(keyid));
			else
				content = ContentDB.getContent(conn,alpha,num,keyid,campus);
			%>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" colspan="2" class="textbrownTH">Linking SLO(s)<br></td>
				</tr>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" width="15%" class="textblackTH">Course: </td>
					<td class="dataColumn"><%=alpha%>&nbsp;<%=num%></td>
				</tr>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" height="20">
					<td valign="top" width="15%" class="textblackTH"><%=contentLabel%>: </td>
					<td class="dataColumn"><%=content%><br/></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
			<%

			// retrieve all assessed items. put in CSV here
			if ((Constant.COURSE_COMPETENCIES).equals(src))
				selected = "," + CompetencyDB.getSelectedSLOs(conn,kix,keyid) + ",";
			else
				selected = "," + ContentDB.getSelectedSLOs(conn,kix,keyid) + ",";

			// retrieve all available SLOs
			list = CompDB.getCompsByKix(conn,kix);

			if ( list != null ){
				Comp comp;
				for (int i = 0; i<list.size(); i++){
					comp = (Comp)list.get(i);

					// put a check on items already selected
					checked = "";

					temp = "," + comp.getID() + ",";

					if (selected.indexOf(temp) >= 0)
						checked = "checked";
				%>
					<tr>
						<td valign="top"><input type="checkbox" name="link_<%=comp.getID()%>" value="<%=comp.getID()%>" <%=checked%>></td>
						<td valign="top" class="dataColumn"><%=comp.getComp()%></td>
					</tr>
				<%
					if ( allKeys.length() == 0 )
						allKeys = comp.getID();
					else
						allKeys = allKeys + "," + comp.getID();
				}

				// save these ids for later processing
				out.println( "<input type=hidden value=\'" + allKeys + "\' name=allKeys>" );
				out.println( "<input type=hidden value=\'" + list.size() + "\' name=totalKeys>" );
				out.println( "<input type=hidden value=\'" + alpha + "\' name=alpha>" );
				out.println( "<input type=hidden value=\'" + num + "\' name=num>" );
				out.println( "<input type=hidden value=\'" + kix + "\' name=kix>" );
				out.println( "<input type=hidden value=\'" + src + "\' name=src>" );
				out.println( "<input type=hidden value=\'SLO\' name=dst>" );
				out.println( "<input type=hidden value=\'crslnks\' name=caller>" );
				out.println( "<input type=hidden value=\'" + campus + "\' name=campus>" );
				out.println( "<input type=hidden value=\'" + keyid + "\' name=keyid>" );
				out.println( "<input type=hidden value=\'" + currentTab + "\' name=currentTab>" );
				out.println( "<input type=hidden value=\'" + currentNo + "\' name=currentNo>" );
			}
		}
		catch (Exception e){
			out.println( e.toString() );
		}

		asePool.freeConnection(conn);
	%>
		<tr>
			<td colspan="2" align="left">
				<br />
				<input type="hidden" name="formAction" value="c">
				<input type="hidden" name="formName" value="aseForm">
				<input title="save selected methods" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onClick="return checkForm('s')">
				<input title="abort selected operation" type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return cancelForm('c','<%=alpha%>','<%=num%>','<%=currentTab%>','<%=currentNo%>')">
				<br/><br/><br/>
			</td>

		</tr>

	</table>
</form>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
