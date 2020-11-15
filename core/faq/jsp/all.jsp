<%@ page import="com.ase.aseutil.faq.*"
errorPage="error.jsp" %>
<jsp:useBean id="faq" class="FaqBean"/>
<% FaqBean[] faqs = (FaqBean[])request.getAttribute("faqs"); %>
<html>
<head><title>FAQ List</title></head>
<body bgcolor="white">
<h2>FAQ List</h2>
<%
for (int i=0; i < faqs.length; i++) {
  faq = faqs[i];
%>
<b>Question:</b> <jsp:getProperty name="faq" property="question"/>
<br>
<b>Answer:</b> <jsp:getProperty name="faq" property="answer"/>
<p>
</tr>
<% } %>
</body>
</html>