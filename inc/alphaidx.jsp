<div class="pagination">

<%
	int alphaIdx = 0;
	int idx = website.getRequestParameter(request,"x", 0);

	for(alphaIdx=65; alphaIdx<91; alphaIdx++){
		if (alphaIdx==idx)
			out.print("<span><b>" + (char)alphaIdx + "</span></b>&nbsp;");
		else
			out.println("<a href=\"?x=" + alphaIdx + "\">" + (char)alphaIdx + "</a>&nbsp;");
	}

	out.println("<a href=\"?\">ALL</a>&nbsp;");

	out.println("<br><br>");
%>

</div>
