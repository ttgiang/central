<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>
<%@ page import="org.apache.commons.io.filefilter.*"%>
<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ART";
	String num = "107";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "K9c4l10181";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		String klass = "com.ase.aseutil.jobs.JobNameDB";
		String methed = "resetJobNames";

		/*
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,methed,new Class[] {},new Object[]{});

		methed = "resetJobName";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class},
				new Object[]{new String("SearchData")});

		methed = "updateJobStats";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,String.class,int.class},
				new Object[]{new String("SearchData"),new String("THANHG"),0});

		methed = "updateJobTotal";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,int.class},
				new Object[]{new String("SearchData"),0});

		klass = "com.ase.aseutil.util.SearchDB";
		methed = "createSearchData";
		out.println("executing " + klass + "." + methed + Html.BR());
		invoke(klass,
				methed,
				new Class[] {String.class,String.class},
				new Object[]{new String(""),new String("")});

      Class c = Class.forName(klass);
      Method[] metheds = c.getMethods();
      for(Method m : metheds ){
         out.println(m  + Html.BR());
      }

		*/

		com.ase.aseutil.util.JarUtil.createJavaDoc();

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	static void invoke(String className, String methodName, Class[] params, Object[] args) {

		try {
			Class c = Class.forName(className);
			Method m = c.getDeclaredMethod(methodName, params);
			Object i = c.newInstance();
			Object r = m.invoke(i,args);
		}
		catch (Exception e) {
			System.out.println(e.toString());
		}

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>