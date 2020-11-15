<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crspsloy.jsp	- confirm before saving
	*	2009.06.05
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Quick List Program SLO Entry";
	fieldsetTitle = pageTitle;

	int x = quickListPSLO(request,response,conn);

	asePool.freeConnection(conn);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/qlst.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%=session.getAttribute("aseApplicationMessage")%>

<%!
	public int quickListPSLO(HttpServletRequest request, HttpServletResponse response,Connection conn) {

		Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int rowsAffected = 0;

		WebSite website = new WebSite();
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);

		Msg msg = new Msg();

		String message = "";

		try {
			if (formName != null && formName.equals("aseForm")){
				String lst = website.getRequestParameter(request,"lst");
				String alpha = website.getRequestParameter(request,"alpha","");
				String num = "";
				String type = "CUR";
				String itm = "X72";
				String temp = "";
				String historyid = "";
				String[] arr;
				int i = 0;

				GenericContent gc = null;

				arr = lst.split("//");

				String sql = "SELECT historyid,coursenum FROM tblCourse WHERE campus=? AND coursealpha=? and coursetype=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,type);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					historyid = rs.getString("historyid");
					num = rs.getString("coursenum");

					if (historyid != null && historyid.length()>0){
						for(i=0;i<arr.length;i++){
							gc = new GenericContent(0,historyid,campus,alpha,num,type,itm,arr[i],"",user,0);
							GenericContentDB.insertContent(conn,gc);
							++rowsAffected;
						}
					}
				}
				rs.close();
				ps.close();

				message = "Operation completed successfully. " + rowsAffected + " row(s) update";
			}
			else{
				message = "Invalid security code";
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception ie) {
			rowsAffected = -1;
			session.setAttribute("aseApplicationMessage", ie.toString());
			session.setAttribute("aseException", "Exception");
			System.out.println(ie.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
