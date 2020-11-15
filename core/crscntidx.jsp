<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscntidx.jsp	outline slo index
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%
	String sql = "";
	String message = "";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = "";
	String num = "";
	String type = "";

	String kix = website.getRequestParameter(request,"kix");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"type");
		kix = helper.getKix(conn,campus,alpha,num,type);
	}

	if (kix.length() > 0){
		// action is to add or remove (a or r)
		String action = website.getRequestParameter(request,"act", "");

		// if all the values are in place, add or remove
		if ( action.length() > 0 ){
			int l1 = website.getRequestParameter(request,"l1", 0);
			int l2 = website.getRequestParameter(request,"l2", 0);
			int l3 = website.getRequestParameter(request,"l3", 0);
			if ("a".equals(action) || "r".equals(action)){
				msg = CourseACCJCDB.courseACCJC(conn,action,user,campus,alpha,num,type,l1,l2,l3);
				if (!"".equals(msg.getMsg())){
					message = MsgDB.getMsgDetail(msg.getMsg());
					if (msg.getCode()<0)
						message = "<font color=red>" + message + "</font>";
					out.println(message);
				}
			}
		}
		msg = AssessedDataDB.listAssessment(conn,kix,user);
		session.setAttribute("aseErrorCode",""+msg.getCode());
		out.println(msg.getErrorLog());
	}

	asePool.freeConnection(conn);
%>
</body>
</html>
