<%@ page import="com.ase.aseutil.faq.*"
contentType="text/plain" errorPage="error.jsp" %>
<jsp:useBean id="faq" class="FaqBean"/>
<% FaqBean[] faqs = (FaqBean[])request.getAttribute("faqs"); %>
FAQs List:
<%
for (int i=0; i < faqs.length; i++) {
  faq = faqs[i];
%>
Question: <jsp:getProperty name="faq" property="question"/>
Answer: <jsp:getProperty name="faq" property="answer"/>
<% } %>
