<%@ include file="ase.jsp" %>

<%
	/**
		ASE
		shwfldx.jsp	- This page is for debugging purposes only. Called by shwfld.
		2007.09.01	saves editable fields
		TODO
			no longer using this. converted to servlet
			need to include campus tab

	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String pageTitle = courseDB.setPageTitle(conn,"Editable Outline Items",alpha,num,campus);

	String message = "";

	try {

		int totalEnabledFields = website.getRequestParameter(request, "totalEnabledFields", 0);
		int toggledAll = website.getRequestParameter(request, "toggledAll", 0);
		int fieldCountSystem = website.getRequestParameter(request,"fieldCountSystem", 0);
		int fieldCountCampus = website.getRequestParameter(request,"fieldCountCampus", 0);

		message = "toggledAll - " + toggledAll + Html.BR()
			+ "totalEnabledFields - " + totalEnabledFields + Html.BR()
			+ "fieldCountSystem - " + fieldCountSystem + Html.BR()
			+ "fieldCountCampus - " + fieldCountCampus + Html.BR()
			+ "hiddenFieldSystem - " + website.getRequestParameter(request,"hiddenFieldSystem") + Html.BR()
			+ "hiddenFieldCampus - " + website.getRequestParameter(request,"hiddenFieldCampus") + Html.BR()
			;

		String[] hiddenFieldSystem = new String[fieldCountSystem];
		hiddenFieldSystem = website.getRequestParameter(request,"hiddenFieldSystem").split(",");

		String[] hiddenFieldCampus = new String[fieldCountCampus];
		hiddenFieldCampus = website.getRequestParameter(request,"hiddenFieldCampus").split(",");

		int i = 0;

		String checkField = "";
		String temp = "";
		String disabled = "";

		String editSystem = "";
		String editCampus = "";

		boolean foundCourse = true;
		boolean foundCampus = true;

		boolean allItemsEnabled = true;

		for (i=0; i<fieldCountSystem; i++) {
			checkField =  "Course_" + hiddenFieldSystem[i];
			temp = website.getRequestParameter(request,checkField);

			// for system setting OutlineItemsRequiredForMods, certain outline items are enabled
			// automatically on modifications. when enabled, they are also disabled from user's
			// use. when disabled, process cannot pick up the value so for any disabled control
			// there is a hidden control with the same name include '_disabled' included.
			// this control is hidden and has the value of 1 indicating it's going to be used and
			// is on. on form submission, the disabled value (temp) is not found so the
			// hiddened value (disabled) is used in its place.

			disabled = website.getRequestParameter(request,checkField+"_disabled");
			if(disabled != null && disabled.equals(Constant.ON)){
				temp = disabled;
			}

			if (temp != null && temp.equals(Constant.ON)){
				temp = hiddenFieldSystem[i];
				foundCourse = true;
			}
			else{
				temp = "0";
			}

			// create enable string
			if (editSystem.length() == 0){
				editSystem = temp;
			}
			else{
				editSystem += "," + temp;
			}
		}

		message += "editSystem - " + editSystem + Html.BR();

		for (i=0; i<fieldCountCampus; i++) {
			checkField = "Campus_" + hiddenFieldCampus[i];
			temp = website.getRequestParameter(request,checkField);

			disabled = website.getRequestParameter(request,checkField+"_disabled");
			if(disabled != null && disabled.equals(Constant.ON)){
				temp = disabled;
			}

			if (temp != null && temp.equals(Constant.ON)){
				temp = hiddenFieldCampus[i];
				foundCampus = true;
			}
			else
				temp = "0";

			if (editCampus.length() == 0)
				editCampus = temp;
			else
				editCampus += "," + temp;
		}

		message += "editCampus - " + editCampus + Html.BR();


	} catch (Exception e) {
		message += e.toString();
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println( "<p align=center>" + message + "</p>");
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

