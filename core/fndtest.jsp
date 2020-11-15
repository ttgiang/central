<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ITE";
	String num = "390E";
	String type = "ARC";
	String user = "THANHG";
	String courseTitle = "";
	String kix = "";
	String fndType = "";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{

			String question = "";
			String data = "";

			int sq = 0;
			int en = 0;
			int qn = 0;

			int id = 11722;

			//
			// get a list of sequence so we can loop through to draw out sections
			// code to add bogus data and reviews
			//

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			Review reviewDB = null;

			if(id > 0 && kix.equals(Constant.BLANK)){
				kix = fnd.getFndItem(conn,id,"historyid");
				if(!kix.equals(Constant.BLANK)){
					String[] info = fnd.getKixInfo(conn,kix);
					campus = info[Constant.KIX_CAMPUS];
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
					courseTitle = info[Constant.KIX_COURSETITLE];
					fndType = info[Constant.KIX_ROUTE];
				}
			}

			ArrayList list = fnd.getFoundationSQ(conn,id);

			if (list != null){
				for (int i=0; i<list.size(); i++){

					int sqID = (Integer)list.get(i);

					for(com.ase.aseutil.Generic fd: fnd.getCourseFoundationBySQ(conn,id,sqID)){

						sq = NumericUtil.getInt(fd.getString1(),0);
						en = NumericUtil.getInt(fd.getString2(),0);
						qn = NumericUtil.getInt(fd.getString3(),0);

						if(en > 0 || qn > 0){

							out.println(fd.getString6() + "<br>");

							String dta = fd.getString5() + "<br>" + AseUtil.getCurrentDateTimeString() + "<br>" + fd.getString5();
							fnd.setItem(conn,id,fd.getString6(),dta,user);

							reviewDB = new Review();
							reviewDB.setId(0);
							reviewDB.setUser(user);
							reviewDB.setAlpha(alpha);
							reviewDB.setNum(num);
							reviewDB.setHistory(kix);
							reviewDB.setComments(fd.getString4());
							reviewDB.setItem(sq);
							reviewDB.setCampus(campus);
							reviewDB.setEnable(true);
							reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
							reviewDB.setSq(sq);
							reviewDB.setEn(en);
							reviewDB.setQn(qn);
							int rowsAffected = ReviewDB.insertReview(conn,reviewDB,"99",Constant.REVIEW);

						}

					} // for generic

				} // for i

			} // if list

			fnd = null;

			reviewDB = null;

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!


%>

</form>
		</td>
	</tr>
</table>

</body>
</html
