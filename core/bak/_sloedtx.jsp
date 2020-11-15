<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sloedtx.jsp
	*	2007.09.01
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "60%";
	String pageTitle = "Update SLO Content";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String campus = (String)session.getAttribute("aseCampus");
	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");
	String type = (String)session.getAttribute("aseType");

	if (alpha == null || alpha.length() == 0){
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"type");
		campus = website.getRequestParameter(request,"campus");
	}

	String mode = website.getRequestParameter(request,"mode");
	String user = session.getAttribute("aseUserName").toString();

	String message = "";

	boolean debug = false;

	if ( formName != null && formName.equals("aseForm") ){
		int controls = website.getRequestParameter(request,"controls",0);
		int lid = website.getRequestParameter(request,"lid",0);
		String answers;
		Vector<String> vector = new Vector<String>();

		// retrieve form values
		if (controls>0){
			for(int i=0;i<controls;i++){
				answers = website.getRequestParameter(request,"ase_"+i);
				vector.addElement(new String(answers));
			}

			msg = AssessedDataDB.updateAssessedQuestions(conn,campus,user,alpha,num,type,lid,mode,vector);
			if ("Exception".equals(msg.getMsg())){
				message = "SLO update failed.<br><br>" + msg.getErrorLog();
			}
			else{
				message = "Outline SLO was updated successfully.<br>";
			}
		}
	}	// valid form

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br><p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crsslo.jsp?alpha=<%=alpha%>&num=<%=num%>&campus=<%=campus%>&view=<%=type%>" class="linkcolumn">return to SLO assessment screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/vwslo.jsp?alpha=<%=alpha%>&num=<%=num%>&campus=<%=campus%>&view=<%=type%>" class="linkcolumn">View Outline SLO</a>
</p>



<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
