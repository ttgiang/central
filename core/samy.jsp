<%@ include file="ase.jsp" %>
<%@ page import="org.owasp.validator.html.*"%>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "";
	String message = "";

	String data = "this is a test";

	boolean debug = false;

	try{
		Locale locale = Constant.LOCALE_ENGLISH;
		Locale.setDefault(locale);

		String policy = "antisamy.xml";
		String cleanedProfile = "";

		ServletContext sc = session.getServletContext();
		String realPath = sc.getRealPath("/WEB-INF/resources/" + policy);

		AntiSamy as = new AntiSamy();

		CleanResults cr = null;

		data = "test";

		System.out.println(data);
		System.out.println(realPath);

		cr = as.scan(data,realPath);

		if (data == null) {
			data = "(profile not set yet)";
		} else {
			cleanedProfile = cr.getCleanHTML();
		}

		if ( cr != null && cr.getErrorMessages().size() != 0 ) {
			%><font color="red" face="bold" size="+2">We encountered some errors with your profile:</font><br><ul><%

			for(int i=0;i<cr.getErrorMessages().size();i++) {
				%><li><%=cr.getErrorMessages().get(i)%></li><%
			}

			%></ul><%
		}
	}
	catch(Exception e){
		System.out.println(e.toString());
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	out.println( "<br><p align='center'>" + message + "</p>" );
%>

</body>
</html>
