<%@page import="com.ase.aseutil.*"%>
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite">
	<%website.init(application.getRealPath("/jspcart/"));%>
</jsp:useBean>
<%

	User user = website.user;

	String txtRedirect = website.getRequestParameter(request,"txtRedirect");
	String txtAdmin = website.getRequestParameter(request,"txtAdmin");
	String txtUsername = website.getRequestParameter(request,"txtUsername");
	String txtMessage = request.getParameter("txtMessage");
	if(txtMessage != null)
	{
		txtMessage = txtMessage.trim();
		if(txtMessage.length()==0)
		{
			txtMessage = null;
		}
	}


	if(request.getMethod().equalsIgnoreCase("post"))
	{
		User user = users.get(txtUsername);
		if(user == null)
		{
			txtMessage = "Email address '"+txtUsername+"' not found in our database. You need to register.";
		}
		else
		{
			String password = request.getParameter("txtPassword");
			if(!user.txtPassword.equals(password))
			{
				txtMessage = "Invalid password, please try again.";
			}
			else
			{

				if(txtAdmin.equals("True") && (!user.isAdmin()))
				{
					txtMessage = "Administration Access Required.";
				}
				else
				{
					session.setAttribute("User",user);
					if(txtRedirect.length()==0)
						txtRedirect = "./../../";
					response.sendRedirect(txtRedirect);
					return;
				}
			}
		}
	}

%>
<%@include file='LoginPage.jsp'%>