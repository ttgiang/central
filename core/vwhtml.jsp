<%@ include file="ase.jsp" %>
<%@ page session="true" buffer="16kb" import="java.io.*"%>

<%
	/**
	*	ASE
	*	vwhtml.jsp
	*	2007.09.01	view outline.
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "90%";
	String pageTitle = "View Outline";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	asePool.freeConnection(conn,"vwhtml",user);

	if (processPage){

		String cat = website.getRequestParameter(request,"cat","");
		String cps = website.getRequestParameter(request,"cps","");
		String kix = website.getRequestParameter(request,"kix","");

		if(cps.equals("")){
			cps = campus;
		}

		String url = "";
		String fileName = "";
		String alpha = "";
		String num = "";
		String category = "";
		String divisionName = "";
		String program = "";

		String documents = SysDB.getSys(conn,"documents");
		String documentsLib = SysDB.getSys(conn,"documentsURL");
		String directory = AseUtil.getCurrentDrive() + ":" + documents;

		boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

		if (isAProgram){
			category = "programs";
		}
		else{
			category = "outlines";
		}

		fileName = directory + category + "\\"+cps+"\\"+kix+".html";
		url = documentsLib + category + "/" + cps + "/" + kix+".html";

		// if the file exists and it's a CUR, don't recreate. have to
		// preserve history of when the file was created

		boolean exists = false;

		try{
			File file = new File(fileName);
			exists = file.exists();
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		// if kix is available, determine proper type to avoid recreating
		// an outline once approved as CUR
		String type = "";

		if (kix != null){
			String[] info = Helper.getKixInfo(conn,kix);
			type = info[Constant.KIX_TYPE];
			info = null;
		}

		if (!exists || type.equals(Constant.PRE)) {

			if (isAProgram){
				Programs prg = ProgramsDB.getProgram(conn,campus,kix);
				if (prg != null){
					program = prg.getProgram();
					divisionName = prg.getDivisionName();
				}

				Tables.createPrograms(campus,kix,program,divisionName);
			}
			else{
				String[] info = helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];

				Tables.createOutlines(cps,kix,alpha,num);
			} // isAProgram

		} // exists

		response.sendRedirect(url);

	}	// processPage

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
