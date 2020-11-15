<%@ page language="java" %>
<%@ page errorPage="exception.jsp" %>

<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%  // Get the type of the user who has logged in
    String userType = request.getParameter("UserType");

    // If the request parameter was set
    if(userType != null) {
      // Store the type of user logged in.
      session.setAttribute("UserType", userType);
    }
%>

<html>
<head>
<link rel=stylesheet href="../inc/style.css" type="text/css">
<title><%=session.getAttribute("applicationTitle")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript">
  function submitLoginForm(frmName){
    var user = frmName.UserName.value.toUpperCase();
    var passwd = frmName.Password.value.toUpperCase();
    if ((user=="")||(passwd=="")){
      alert("UserName and Password values are required!");
    } else if (!(user=="ADMINISTRATOR")){
      alert("Only Administrator can Login");
    } else if (!(passwd=="WELCOME")){
      alert("Incorrect Password !");
    } else {
      frmName.action = "crs.jsp";
      frmName.submit();
    }
  }

</script>

</head>
<body topmargin="0" leftmargin="0">
<table align="center" width="100%" height="100%" border="0">
  <tr height="25%">
    <td>
      <tags:Header backColor="#C0C0C0" title="Learning JSP" image="images/cc4b.gif" />
    </td>
  </tr>
  <tr height="65%" valign="top">
		<td valign="top" >
			<table width="100%" height="100%" border="0">
				<tr>
					<td valign="top">
					<!-- BODY GOES HERE -->
					<form name="LoginFrm" method="post">
						<table border="0" width="100%" cellspacing="4" cellpadding="0">
						  <tr><td colspan="4">&nbsp;</td></tr>
						  <tr>
							 <td width="38%" align="center">&nbsp;</td>
							 <td width="10%" align="left" class="textbold">User:</td>
							 <td width="27%" align="left"><input class="input" type="text" name="UserName" value="Administrator"></td>
							 <td width="25%" align="center">&nbsp;</td>
						  </tr>
						  <tr>
							 <td width="38%" align="center">&nbsp;</td>
							 <td width="10%" align="left" class="textbold">Password:</td>
							 <td width="27%" align="left"><input class="input" type="password" name="Password"></td>
							 <td width="25%" align="center">&nbsp;</td>
						  </tr>
						  <tr><td colspan="4">&nbsp;</td></tr>
						  <tr>
							 <td colspan="4" align="center">
								<a href="javascript:submitLoginForm(document.LoginFrm)"><img src="images/submit.gif" border=0 width="100" height="20" /></a>
								&nbsp;<a href="index.jsp"><img border=0 width="100" height="20" src="images/main.gif" /></a>
							 </td>
						  </tr>
						</table>
					</form>
					<!-- BODY GOES HERE -->
					</td>
				</tr>
			</table>
		</td>
  <tr height="05%" valign="bottom">
    <td>
      <tags:Footer backColor="#C0C0C0"/>
    </td>
  </tr>
</table>
</body>
</html>
