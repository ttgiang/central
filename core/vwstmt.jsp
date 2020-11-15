<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwstmt.jsp display questions index
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String statement = "";
	String type = "";

	String lid = website.getRequestParameter(request,"id","");

	if (processPage && !(Constant.BLANK).equals(lid)){
		Stmt stmt = StmtDB.getStatement(conn,campus,lid);
		if (stmt != null){
			statement = stmt.getStmt();
			type = stmt.getType();
		}
	}

%>

<title>Curriculum Central</title>

<link rel="stylesheet" type="text/css" href="/central/inc/style-popup.css">
</head>
<body topmargin="0" leftmargin="0">
<div id="wrap">
    <div id="container">
      <div id="container_construction">
      		<div id="box_bgg2">
				<h3><%=type%></h3>
				<%
					if (processPage)
						out.println(statement);

					asePool.freeConnection(conn,"vwstmt",user);
				%>
            </div>
      </div>
    </div>
</div>

</body>
</html>