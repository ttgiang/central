<div id="forum_wrapper">
	  <div id="forum_header">
			::&nbsp;&nbsp;

			<%
				if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
					out.println("<a href=\"auto.jsp?src=add\" class=\"bluelinkcolumn\">add message</a>");
				}
			%>

			<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

			<%
				if ((Constant.BLANK).equals(src)){
			%>
				<font class="copyrightdark">my messages</font>
			<%
				}
				else{
			%>
				<a href="dsplst.jsp" class="bluelinkcolumn">my messages</a>
			<%
				}
			%>

			<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

			<%
				if ((Constant.COURSE).equals(src)){
			%>
				<font class="copyrightdark">course messages</font>
			<%
				}
				else{
			%>
				<a href="dsplst.jsp?src=<%=Constant.COURSE%>" class="bluelinkcolumn">outline messages</a>
			<%
				}
			%>

			<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

			<%
				if ((Constant.PROGRAM).equals(src)){
			%>
				<font class="copyrightdark">program messages</font>
			<%
				}
				else{
			%>
				<a href="dsplst.jsp?src=<%=Constant.PROGRAM%>" class="bluelinkcolumn">program messages</a>
			<%
				}
			%>

			<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

			<%
				if ((Constant.ENHANCEMENT).equals(src)){
			%>
				<font class="copyrightdark">enhancement requests</font>
			<%
				}
				else{
			%>
				<a href="dsplst.jsp?src=<%=Constant.ENHANCEMENT%>" class="bluelinkcolumn">enhancement requests</a>
			<%
				}
			%>

			<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

			<%
				if ((Constant.DEFECT).equals(src)){
			%>
				<font class="copyrightdark">defect reporting</font>
			<%
				}
				else{
			%>
					<a href="dsplst.jsp?src=<%=Constant.DEFECT%>" class="bluelinkcolumn">defect reporting</a>
			<%
				}

			%>

			<br/><br/>

			<%

				if (!src.equals("add") && !src.equals("edt")){
					out.println(ForumDB.showSubMenu(conn,src,status));
				}
			%>

		</div>

<p align="left">
