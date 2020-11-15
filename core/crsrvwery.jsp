<%
	System.out.println("----------------------------------");

	String kix = request.getParameter("kix");

	System.out.println("message: " + request.getParameter("message"));

	response.sendRedirect("crsrvwer.jsp?kix="+kix);
%>
