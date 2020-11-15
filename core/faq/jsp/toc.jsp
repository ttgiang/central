<%@ page import="com.ase.aseutil.faq.*"
 errorPage="error.jsp" %>
<jsp:useBean id="faq" class="FaqBean"/>
<% FaqBean[] faqs = (FaqBean[])request.getAttribute("faqs"); %>
<html>
<head><title>FAQ Index</title></head>
<body bgcolor="white">
<h2>FAQ Index</h2>
<%
for (int i=0; i < faqs.length; i++) {
  faq = faqs[i];
%>
<b>Q:</b>
<a href="/faqs?page=single.jsp&id=<jsp:getProperty name="faq" property="ID"/>">
<jsp:getProperty name="faq" property="question"/></a>
<p>
<% } %>
</body>
</html>