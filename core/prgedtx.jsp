<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedtx.jsp - NOT USED
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Program Maintenance";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
	boolean debug = false;

	String sURL = "";
	String message = "";

	int action = 0;
	final int APPROVAL = 1;
	final int REVIEW = 2;
	final int SUBMIT = 3;

	String formAction = website.getRequestParameter(request,"formAction","");
	String formName = website.getRequestParameter(request,"formName","");

	if ( formAction.equalsIgnoreCase("a") ) action = APPROVAL;
	if ( formAction.equalsIgnoreCase("r") ) action = REVIEW;
	if ( formAction.equalsIgnoreCase("s") ) action = SUBMIT;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage && formName != null && formName.equals("aseForm") ){

		int degree = 0;
		int division = 0;
		String title = null;
		String description = null;
		String effectiveDate = null;
		String year = null;
		boolean regentApproval = false;
		int rowsAffected = 0;

		int items = website.getRequestParameter(request,"items",0);

		if (action==REVIEW){
			//NOTE: Code here is identical to APPROVAL accept for PROGRESS
			session.setAttribute("aseAlpha", alpha);
			session.setAttribute("aseNum", num);

			session.setAttribute("aseModificationMode", "");
			session.setAttribute("aseWorkInProgress", "0");
			session.setAttribute("aseProgress", "REVIEW");
			sURL = "prgedt6.jsp?kix="+kix;
		} // if action
		else if (action==SUBMIT){

			if (items > 0){

				// get column names from db table
				String column = null;
				ArrayList columns = ProgramsDB.getColumnNames(conn,campus);
				if (columns != null){

					degree = website.getRequestParameter(request,"degree",0);
					division = website.getRequestParameter(request,"division",0);
					title = website.getRequestParameter(request,"title","");
					description = website.getRequestParameter(request,"description","");
					effectiveDate = website.getRequestParameter(request,"effectiveDate","");
					year = website.getRequestParameter(request,"year","");

					// save data from form so we can update
					String[] data = new String[items];

					int i = 0;

					String sql = "";

					for (i=0; i<items; i++){
						column = (String)columns.get(i);
						data[i] = website.getRequestParameter(request,column, "");

						if (i == 0)
							sql = column + "=?";
						else
							sql = sql + "," + column + "=?";
					}

					// recreate html for quick access and pdf generation
					try{
						Tables.createPrograms(campus,kix,""+degree,""+division);
						//columns = null;
					}
					catch(SQLException e){
						//System.out.println(e.toString());
					}
					catch(Exception e){
						//System.out.println(e.toString());
					}

				} // columns != null
			} // if items > 0
		} // if action
	} // if processPage

	asePool.freeConnection(conn,"prgedtx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<%
	if (!(Constant.BLANK).equals(sURL))
		response.sendRedirect(sURL);
	else{
%>
		<p align="center"><%=message%></p>

		<p align=\"center\"><a href="prgidx.jsp" class="linkcolumn">return to program maintenance</a></p>
<%
	}
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
