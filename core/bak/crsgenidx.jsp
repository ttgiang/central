<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsgenidx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String pageTitle = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");
	String type = website.getRequestParameter(request,"type","CUR");
	String src = website.getRequestParameter(request,"src","");

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	if ((Constant.COURSE_PROGRAM_SLO).equals(src)){
		pageTitle = "Program SLO";
	}

	fieldsetTitle = pageTitle;

	int keyid = website.getRequestParameter(request,"keyid",0);

	String message = "";
	int rowsAffected = 0;

	String genContent = website.getRequestParameter(request,"genContent");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	// action is to add or remove (a or r)
	String action = website.getRequestParameter(request,"act", "");

	// if all the values are in place, add or remove
	if (action.length() > 0 && kix.length() > 0){
		if ("a".equals(action) || "r".equals(action)){
			if ("a".equals(action)){
				GenericContent gc = new GenericContent(keyid,kix,campus,alpha,num,"PRE",src,genContent,"",user,0);
				if (keyid==0)
					rowsAffected = GenericContentDB.insertContent(conn,gc);
				else
					rowsAffected = GenericContentDB.updateContent(conn,gc);
			}
			else
				rowsAffected = GenericContentDB.deleteContent(conn,kix,keyid);

			if (rowsAffected > 0){
				message = "Data saved successfully.";
			}
			else{
				message = "Unable to save data";
			}
		}	// if action
	}	// if action

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crsgen.jsp?kix=<%=kix%>&src=<%=src%>" class="linkcolumn">return to <%=pageTitle%> screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/crsedt.jsp?ts=<%=currentTab%>&no=<%=currentNo%>&kix=<%=kix%>" class="linkcolumn">return to outline modification</a>
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
