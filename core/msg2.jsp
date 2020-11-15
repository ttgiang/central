<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	msg2.jsp	different from msg.jsp in that it doesn't have header
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	/*
		servlets will call this file to display messages from
		any maintenance results. If rtn is available, it's because
		the maintenance was successful and rtn would be the
		page to send the user to.
	*/
	String temp = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String rtn = website.getRequestParameter(request,"rtn","");
	String message = session.getAttribute("aseApplicationMessage").toString();

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");

	String fid = website.getRequestParameter(request,"fid","0");
	String mid = website.getRequestParameter(request,"mid","0");

	String sq = website.getRequestParameter(request,"sq","0");
	String en = website.getRequestParameter(request,"en","0");
	String qn = website.getRequestParameter(request,"qn","0");

	/*
		if the returned value is saved to session, we have to break it appart here
		s = session; 3 = number of array element in the session variable

		at this time, it's from GenericUploadServlet where

			0 = the upload handler (mprt or gncrmprt)
			1 = kix
			2 = the calling program
	*/

	String src = "";

	if (rtn.equals("s3")){
		String[] r = (String[])session.getAttribute("aseSession");
		if (r != null){
			rtn = r[0];
			src = r[1];
			kix = r[2];
			fid = r[3];
			mid = r[4];
			sq = r[5];
			en = r[6];
			qn = r[7];
		}
	}

	if (kix.equals(Constant.BLANK)){
		kix = Helper.getKix(conn,campus,alpha,num,"PRE");
	}

	String currentTab = website.getRequestParameter(request,"ts");
	String currentNo = website.getRequestParameter(request,"no");

	// save it for later use
	session.setAttribute("aseAlpha", alpha);
	session.setAttribute("aseNum", num);
	session.setAttribute("asecurrentSeq", String.valueOf(currentNo));
	session.setAttribute("aseCurrentTab", String.valueOf(currentTab));

	if (message == null){
		message = "";
	}

	int codeName = 0;
	String returnPage = "";

	final int CRSBK 		= 0;
	final int MPRT 		= 1;
	final int NEWSIDX1	= 2;
	final int NEWSIDX2	= 3;
	final int NTFIDX 		= 4;
	final int RQSTIDX 	= 5;
	final int GNRCMPRT 	= 6;
	final int CRSATTACH	= 7;

	if (rtn.length() > 0){
		if (rtn.equals("crsbk"))
			codeName = CRSBK;
		else if (rtn.equals("mprt"))
			codeName = MPRT;
		else if (rtn.equals("newsidx1"))
			codeName = NEWSIDX1;
		else if (rtn.equals("newsidx2"))
			codeName = NEWSIDX2;
		else if (rtn.equals("ntfidx"))
			codeName = NTFIDX;
		else if (rtn.equals("rqstidx"))
			codeName = RQSTIDX;
		else if (rtn.equals("gnrcmprt"))
			codeName = GNRCMPRT;
		else if (rtn.equals("crsattach"))
			codeName = CRSATTACH;
		else
			codeName = -1;
	}

System.out.println(rtn);

	if (!kix.equals(Constant.BLANK)){
		message = "<br><br><a href=\'/central/core/" + rtn + ".jsp?kix=" + kix + "\' class=\"linkcolumn\">return to previous page</a>";
	}
	else{
		message = "<br><br><a href=\'/central/core/" + rtn + ".jsp\' class=\"linkcolumn\">return to previous page</a>";
	}

	if (processPage){
		switch (codeName){
			case CRSBK:
				returnPage = "return to Textbook screen";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true);
				message += "<br/><br/><a href=\"/central/core/"+rtn+".jsp?kix="+kix+"\" class=\"linkcolumn\">"+returnPage+"</a>"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;";

				String caller = aseUtil.getSessionValue(session,"aseCallingPage");
				if(caller.equals("crsfldy")){
					message += "<a href=\"/central/core/crsfldy.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\">return to raw edit</a>";
				}
				else{
					message += "<a href=\"/central/core/crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix+"\" class=\"linkcolumn\">return to outline modification</a>";
				}

				break;
			case MPRT:
				returnPage = "";

				/*
					for upload, message comes back withotu Exception if all is OK.
					format is upload type (coreq, prereq) and the timestamp for the file.
					break the data into components and send back for final processing
				*/
				message = website.getRequestParameter(request,"aseApplicationMessage","",true);

				if (message.indexOf("Error:")>-1)
					message += "<br/><br/><a href=\"/central/core/mprt.jsp\" class=\"linkcolumn\">Try again</a>"
								+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;"
								+ "&nbsp;&nbsp;<a href=\"/central/core/index.jsp\" class=\"linkcolumn\">Return to home page</a>";
				else{
					temp = message.substring(0,message.indexOf(Constant.SEPARATOR));
					returnPage = message.substring(message.indexOf(Constant.SEPARATOR)+2);
					message = "Click 'Process Data' to continue with your upload or click 'Cancel Upload' to return to the home page."
								+ "<br/><br/><a href=\"/central/servlet/mprt?arg=arg&tp="+temp+"&k="+returnPage+"\" class=\"linkcolumn\">Process Data</a>"
								+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;"
								+ "&nbsp;&nbsp;<a href=\"/central/core/index.jsp\" class=\"linkcolumn\">Cancel Upload</a>";
				}
				break;
			case NEWSIDX1:
				returnPage = "Return to news index";

				String lid = website.getRequestParameter(request,"aseKey","0",true);

				message = website.getRequestParameter(request,"aseApplicationMessage","",true)
							+ "<br/><br/><a href=\"/central/core/news.jsp?mnu=2&lid="+lid+"\" class=\"linkcolumn\">Attach document</a>"
							+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;"
							+ "<a href=\"/central/core/newsidx.jsp\" class=\"linkcolumn\">"+returnPage+"</a>";
				break;

			case NEWSIDX2:
				returnPage = "Return to news index";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true)
							+ "<br><br><a href=\"/central/core/newsidx.jsp\" class=\"linkcolumn\">"+returnPage+"</a>";
				break;

			case NTFIDX:
			case RQSTIDX:
				returnPage = "Return to previous page";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true)
							+ "<br/><br/><a href=\"/central/core/"+rtn+".jsp?kix="+kix+"\" class=\"linkcolumn\">"+returnPage+"</a>";
				break;
			case GNRCMPRT:
				returnPage = "";

				message = website.getRequestParameter(request,"aseApplicationMessage","",true);
				String aseUploadFileTitle = website.getRequestParameter(request,"aseUploadFileTitle","",true);

				if (message.indexOf("Error:")>-1)
					message += "<br/><br/>Click your browser's back button to try again</a>"
								+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;"
								+ "&nbsp;&nbsp;<a href=\"/central/core/index.jsp\" class=\"linkcolumn\">Return to home page</a>";
				else{
					returnPage = message.substring(message.indexOf(Constant.SEPARATOR)+2);

					temp = "?kix=" + kix;

					if(com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix)){
						temp += "&sq=" + sq + "&en=" + en + "&qn=" + qn + "&fid=" + fid;
					}
					else if (src.indexOf("forum/") > -1){

						// top level forum
						temp = "?fid=" + fid;

						// message to forum
						if (!mid.equals(Constant.OFF))
							temp = temp + "&mid=" + mid;

					} // src if forum

					message = "File <font class=\"textblackth\">" + aseUploadFileTitle + "</font> uploaded successfully."
								+ "<br/><br/><a href=\"/central/core/"+src+".jsp"+temp+"\" class=\"linkcolumn\">Return to previous page</a>";
				}
				break;
			case CRSATTACH:
				rtn = rtn + ".jsp?kix="+kix;

				int id = website.getRequestParameter(request,"id",0);
				if (id > 0)
					rtn = "attchst.jsp?kix="+kix+"&id="+id;

				returnPage = "Return to previous page";
				message = website.getRequestParameter(request,"aseApplicationMessage","",true)
							+ "<br/><br/><a href=\"/central/core/"+rtn+"\" class=\"linkcolumn\">"+returnPage+"</a>";
				break;
		}	// switch
	}
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<%
	out.println(message);

	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"msg2",user);
%>

</body>
</html>
