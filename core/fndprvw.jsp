<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndprvw.jsp
	*	2007.09.01	generic statements used for all reasons
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String type = website.getRequestParameter(request,"type","");

	String pageTitle = "Foundation Hallmark Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<style>
		.wrapper{ width: 800px;	background-color: #cccccc; }
		.col1H{	float: left;	width: 20px; 	text-align: left; color: #525252;	}
		.col2H{	float: right;	width: 780px; 	text-align: left; color: #525252;	}
		.new_line_padded{ clear: left; padding: 5px 5px;  }
	</style>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

	<%
		if(processPage){

			for(com.ase.aseutil.Generic fd: com.ase.aseutil.fnd.FndDB.getFoundations(conn,type)){

				String number = fd.getString3() + ".";

				int en = NumericUtil.getInt(fd.getString4(),0);
				int qn = NumericUtil.getInt(fd.getString5(),0);

				if(en > 0 || qn > 0){
					number = "&nbsp;";
				}

				out.println("<div class=\"wrapper\">"
						+ "<div class=\"col1H\">"
						+ number
						+ "</div>"
						+ "<div class=\"col2H\">"
						+ fd.getString6()
						+ "</div>"
						+ "</div>"
						+ "<div class=\"new_line_padded\">&nbsp;</div>"
						);
			}

		}

		paging = null;

		asePool.freeConnection(conn,"fndprvw",user);
	%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

