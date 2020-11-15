<%@ page import="com.ase.aseutil.Skew"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
	String passLine = request.getParameter("passLine");
	String passLineEncoded = request.getParameter("passLineEncoded");
	if ((passLine!=null) || (passLineEncoded !=null)) {
		if (Skew.encodedValueConfirmed(request))
			response.sendRedirect("testskew.jsp?error=Correct security code");
		else
			response.sendRedirect("index.jsp");
	}
%>
<html>
  <head><title>SkewPassImage Example</title></head>
  <body>
  <div align="center">
      <form action="testskew.jsp" method="post" name="auth_form">
          <table width="450" border="0" cellpadding="5" cellspacing="0">
              <tr>
                  <td align="center">
								<%
									 String passLineValueEncoded = Skew.getValueEncoded(request);
								%>
                      <table style="font-family:verdana; font-size:11px; color:#555555;">
                          <tr>
                              <td colspan="2" align="center"><img src="../PassImageServlet/<%=passLineValueEncoded %>" border="0"></td>
                          </tr>
                          <tr>
                              <td align="right">Security Code</td><td><input type="text" name="passLine" size="9"></td>
                          </tr>
                          <tr>
                              <td colspan="2" align="center"><input type="submit" name="NEXT" value="NEXT"></td>
                          </tr>
                      </table>
                      <input type="hidden" name="passLineEncoded" value="<%=passLineValueEncoded %>">
                   </td>
              </tr>
          </table>
      </form>
  </div>
  </body>
</html>