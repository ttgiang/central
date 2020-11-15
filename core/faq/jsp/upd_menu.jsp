<%@ page import="com.ase.aseutil.faq.*"
errorPage="error.jsp" %>
<jsp:useBean id="faq" class="FaqBean"/>
<%
  FaqBean[] faqs = (FaqBean[])request.getAttribute("faqs");
%>
<html>
<head><title>Update Menu</title></head>
<form name="menu" action="/central/servlet/faqtool" method="post">
<table border="1" align="center"><tr><td>
<table bgcolor="tan" border="1" align="center" cellpadding="10" cellspacing="0">
<tr><th colspan="2">FAQ Administration: Update Menu</th></tr>
<%
for (int i=0; i < faqs.length; i++) {
  faq = faqs[i];
%>
<tr>
<td><input type="radio" name="id"
value="<jsp:getProperty name="faq" property="ID"/>">
<jsp:getProperty name="faq" property="ID"/></td>
<td><jsp:getProperty name="faq" property="question"/></td>
</tr>
<% } %>
<tr><td colspan=2 align="center">
<input type="submit" value="Abort Updating">
<input type="submit" value="Update Selected FAQ" onClick="document.menu.cmd.value='update'">
</td></tr>
</table>
</td></tr></table>
<input type="hidden" name="cmd" value="abort">
</form>
</html>