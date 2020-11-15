<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "DF00032";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
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
	*	df00001.jsp
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	out.println("Starting...<br/><br/>"
			+ "This process recreates/generates HTML files for quick viewing. When history is set to 1, "
		 	+ "only HTML for CUR with data in approval history is generated.<br><br>");

	if (processPage){
		try{

			String campusToRecreate = website.getRequestParameter(request,"cps","");
			String type = website.getRequestParameter(request,"type","");
			int count = website.getRequestParameter(request,"count",1);
			int history = website.getRequestParameter(request,"history",1);
			if(!campusToRecreate.equals(Constant.BLANK) && !type.equals(Constant.BLANK)){

				type = type.toUpperCase();

				com.ase.aseutil.df.DF00000 df = new com.ase.aseutil.df.DF00000();
				int rowsAffected = df.reCreateOutlineHtml(campusToRecreate,type,count,history);

				if(count==1){
					out.println(""
							+ "Campus: " + campusToRecreate
							+ "<br>Count: " + count
							+ "<br>History: " + history
							+ "<br><br>" + rowsAffected + " " + type + " outlines to process for " + campusToRecreate
							+ ". <br><br>Click <a href=\"?cps="+campusToRecreate+"&type="+type+"&count=0&history="+history+"\" class=\"linkcolumn\">here</a> to generate " + type + " HTML files.");
				}
				else{
					out.println(rowsAffected + " " + type + " HTML files generated for " + campusToRecreate);
				}

				df = null;

			}
			else{
				out.println("Campus is required (cps=[xyz]&type=[CUR,PRE]&count=[1,0]&history=[1,0])");
			}

			out.println("<br><br><a href=\"sa.jsp\" class=\"linkcolumn\">return to system jobs</a>");

		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/><br/>Ending...");

	asePool.freeConnection(conn,"df00000",user);
%>

</table>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>