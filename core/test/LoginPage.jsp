<HTML>
<HEAD>
<TITLE><%=website.preferences.loginPage.txtTitle%></TITLE>
</HEAD>
<BODY>
<%=website.preferences.globalPage.txtHeader%>
<%=website.preferences.loginPage.txtHeader%>

	<%if(txtMessage != null){%>
		<font color=red><%=txtMessage%></font>
	<%}%>

	<FORM action="Login.jsp" method="POST" id=form1 name=form1>
		<input type=hidden name="txtRedirect" value="<%=txtRedirect%>">
		<input type=hidden name="txtAdmin" value="<%=txtAdmin%>">
	<TABLE class=Data cellspacing=1 >
		<TR>
			<TH colspan=2><%=website.preferences.loginPage.txtTitle%></TH>
		</TR>
		<TR>
			<TD>Email Address</TD>
			<TD><input type=text name="txtUsername"></TD>
		</TR>
		<TR>
			<TD>Password</TD>
			<TD><input type=password name="txtPassword"></TD>
		</TR>
		<TR>
			<TD colspan=2><input type=submit value="Login" id=submit1 name=submit1></TD>
		</TR>
	</TABLE>
	</FORM>
	<BR>
	<TABLE class=Data cellspacing=1 >
		<FORM action="ForgotPassword.jsp" method="POST" id=form2 name=form2>
			<input type=hidden name="txtRedirect" value="<%=txtRedirect%>">
			<input type=hidden name="txtAdmin" value="<%=txtAdmin%>">
		<TR>
			<TH colspan=2>Forgot Password?</TH>
		</TR>
		<TR>
			<TD>Email Address</TD>
			<TD><input type=text name='txtUsername' value="<%=txtUsername%>"></TD>
		</TR>
		<TR>
			<TD colspan=2><input type=submit value="Send Password" id=submit2 name=submit2></TD>
		</TR>
		</FORM>
	</TABLE>
	<BR>
	<BR>
	<TABLE class=Data cellspacing=1 >
		<TR>
			<TH>Not Member Yet ?</TH>
		</TR>
		<TR>
			<TD><A href="Signup.jsp?txtRedirect=<%=txtRedirect%>">Click Here</a> to signup with <%=website.shopName%></TD>
		</TR>
	</TABLE>
<%=website.preferences.loginPage.txtFooter%>
<%=website.preferences.globalPage.txtFooter%>
</BODY>
</HTML>
