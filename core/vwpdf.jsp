<%@ include file="ase.jsp" %>
<%@ page session="true" buffer="16kb" import="java.io.File"%>

<%
	/**
	*	ASE
	*	vwpdf.jsp
	*	2012.12.10	view outline (pdf)
	*
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","vwpdf");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "90%";
	String pageTitle = "View Outline (PDF format)";
	fieldsetTitle = pageTitle;
%>

<%@ include file="ase2.jsp" %>

<%
	String kix = website.getRequestParameter(request,"kix","");

	String folder = "";
	String alpha = "";
	String num = "";

	boolean foundation = false;

	boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

	if(!isAProgram){
		foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
	}

	String[] info = null;

	String sessionInfo = "";

	//
	// create the htm. this is done here because of corrections to various
	// classes requiring regenerating htm
	//
	if(foundation){
		com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

		info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];

		// get campus based on kix because this page is not campus specific (display outlines)
		campus = info[Constant.KIX_CAMPUS];

		fnd.createFoundation(campus,user,kix);

		fnd = null;

		sessionInfo = "fnd";

		folder = "fnd";

	}
	else{
		info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];

		// get campus based on kix because this page is not campus specific (display outlines)
		campus = info[Constant.KIX_CAMPUS];

		if (isAProgram){
			info = Helper.getKixInfo(conn,kix);
			String degree = info[Constant.KIX_PROGRAM_TITLE];
			String division = info[Constant.KIX_PROGRAM_DIVISION];
			Tables.createPrograms(campus,kix,degree,division);
			folder = "programs";

			sessionInfo = "program";
		}
		else{
			Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);
			folder = "outlines";
			sessionInfo = "outline";
		}

	}

	//
	// these are picked up in the reporting generating process with PDF (PdfServlet)
	//
	session.setAttribute("aseReport",sessionInfo);
	session.setAttribute("asePdfCampus",campus);
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseShowAuditStampInFooter",Util.getSessionMappedKey(session,"showAuditStampInFooter"));

	//
	// create the xml
	//
	String htmName = AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\centraldocs\\docs\\"+folder+"\\"+campus+"\\"+kix+".html";

	File file = new File(htmName);
	if(file.exists()){
		com.ase.aseutil.xml.CreateXml xml = new com.ase.aseutil.xml.CreateXml();
		xml.createXML(conn,campus,kix);
		xml = null;

		//
		// create then show the pdf
		//
		response.sendRedirect("/central/servlet/talin");
	}
	else{
		response.sendRedirect("http://"+SysDB.getSys(conn,"server")+"/central/help/error.pdf");
	}

	asePool.freeConnection(conn,"vwpdf",user);

	//<%@ include file="_fnd.jsp" %>

%>
