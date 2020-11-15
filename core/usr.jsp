<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usr.jsp
	*	2007.09.01
	** /TODO need to update user status
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";
	String pageTitle = "User Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String usr = Util.getSessionMappedKey(session,"aseUserName");

	int idx = website.getRequestParameter(request,"idx",0);

	// default level includes USER, FACULTY and CAMPADM
	String accessLevel = "AccessLevel";

	boolean isSysAdm = SQLUtil.isSysAdmin(conn,usr);

	// this level includes SYSADM in drop down list
	if(isSysAdm){
		accessLevel = "AccessLevelSysAdm";
	}

	String documentsURL = SysDB.getSys(conn,"documentsURL") + "profiles/";

	String photo = "";
	String fullname = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether college codes are displayed (EnableCollegeCodes)");

	String lid = "";
	String chk = website.getRequestParameter(request,"chk");

	if (chk.equals(Constant.ON)){
		lid = usr;
	}
	else{
		lid = website.getRequestParameter(request,"lid");
	}

	boolean hasWorkInProgress = UserDB.hasWorkInProgress(conn,campus,lid);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/usr.js"></script>
	<%@ include file="./js/modal/modalnews.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{

		String auditby = "";
		String auditdate = "";
		String status = "Y,N";
		String uh = "0";
		String pw = "";
		String pw2 = "";
		String alphas = "";
		String userCampus = "";

		UserDB userDB = new UserDB();
		User user = new User();

		if (!lid.equals(Constant.BLANK) && !lid.equals(Constant.OFF)){
			user = userDB.getUserByName(conn, lid);
			if ( user != null ){
				auditby = user.getAuditBy();
				auditdate = user.getAuditDate();
				userCampus = user.getCampus();

				photo = user.getWeburl();

				fullname = user.getFullname();

				if (user.getUH()==1){
					uh = "YES";
				}
				else{
					uh = "NO";
				}

				if ("Active".equals(user.getStatus())){
					status = Constant.ON;
				}
				else{
					status = Constant.OFF;
				}

				pw = user.getPassword();
				pw2 = user.getPassword();
				alphas = user.getAlphas();
			}
		}
		else{
			lid = "";
			uh = Constant.ON;
			status = Constant.ON;
			auditdate = aseUtil.getCurrentDateTimeString();
			auditby = usr;
			userCampus = campus;
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/hntr\'>" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>UH System:&nbsp;</td>" );
		if (!lid.equals(Constant.BLANK) && !lid.equals("0")){
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + uh + "</td>" );
		}
		else{
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"radio","YESNO","uh",uh,0,0,false,campus,false) + "</td>" );
		}
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>User ID:&nbsp;</td>" );

		if (!lid.equals(Constant.BLANK) && !lid.equals(Constant.OFF)){
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + user.getUserid() + "<input type=\'hidden\' name=\'userid\' value=\'" + user.getUserid() + "\'></td>" );
		}
		else{
			out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'30\' class=\'input\'  name=\'userid\' type=\'text\' value=\'" + user.getUserid() +"\'></td>" );
		}
		out.println("				</tr>" );

		if (lid.equals(Constant.OFF) || lid.equals(Constant.BLANK) || uh.equals("NO")){
			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Password:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'><input size=\'10\' class=\'input\'  name=\'pw\' type=\'password\' value=\'"+pw+"\'></td>" );
			out.println("					 <td class=\'textblackTH\'>Confirm Password:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'><input size=\'10\' class=\'input\'  name=\'pw2\' type=\'password\' value=\'"+pw2+"\'></td>" );
			out.println("				</tr>" );
		}
		else{
			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Password:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'15\' class=\'input\'  name=\'pw\' type=\'hidden\' value=\'" + user.getPassword() +"\'>UH Mail Password</td>" );
			out.println("				</tr>" );
		}

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>First Name:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'><input size=\'30\' class=\'input\'  name=\'first\' type=\'text\' value=\'" + user.getFirstname() +"\'></td>" );
		out.println("					 <td class=\'textblackTH\'>Last Name:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'><input size=\'30\' class=\'input\'  name=\'last\' type=\'text\' value=\'" + user.getLastname() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Full Name:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'30\' class=\'input\'  name=\'fullname\' type=\'text\' value=\'" + fullname +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Salutation:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"listbox","salutation","salutation",user.getSalutation(),0,0,false,"",false) + "</td>" );


		String sql = "";
		String enableCollegeCodes = Util.getSessionMappedKey(session,"EnableCollegeCodes");
		if(enableCollegeCodes.equals(Constant.ON)){
			sql = aseUtil.getPropertySQL(session,"college");
			out.println("<td class=\'textblackTH\'>College:&nbsp;</td>"
				+ "<td class=\'dataColumn\'>"
				+ aseUtil.createSelectionBox( conn, sql, "college", user.getCollege(),false)
				+ "</td>");
		}
		else{
			out.println("<td class=\'textblackTH\'>&nbsp;</td>"
				+	"<td class=\'dataColumn\'>"
				+  "<input type=\"hidden\" name=\"college\" value=\"\">"
				+ "</td>");
		}

		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Department:&nbsp;</td>" );

		sql = aseUtil.getPropertySQL(session,"bannerdepartment");
		out.println("					 <td class=\'dataColumn\'>"
										+ aseUtil.createSelectionBox( conn, sql, "department", user.getDepartment(),false)
										+ "</td>" );

		out.println("					 <td class=\'textblackTH\'>Division:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"listbox","BannerDivision2","division",user.getDivision(),0,0,false,"",true) + "</td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Additional Alphas*:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\' colspan=\"3\"><input type=\'text\' name=\'alphas\' class=\'input\'  size=\'80\' value=\'" + alphas + "\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' valign=top>Access Level:&nbsp;</td>" );
		out.println("					 <td valign=top class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"listbox",accessLevel,"userlevel",String.valueOf(user.getUserLevel()),0,0,false,"",false) + "</td>" );
		out.println("					 <td class=\'textblackTH\'>Status:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>");

		if(hasWorkInProgress){
		%>
			<a href="##" onclick="return showWorkInProgress('<%=lid%>');" alt="view work in progress" class="linkcolumn"><img src="../images/insert_table.gif" alt="view work in progress" title="view work in progress"></a>
		<%
		}

		out.println(aseUtil.drawHTMLField(conn,"radio","UserStatus","status",status,0,0,false,campus,false));

		out.println("</td>" );

		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Title:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'50\' class=\'inputRequired\'  name=\'title\' type=\'text\' value=\'" + user.getTitle() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Position:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'50\' class=\'inputRequired\'  name=\'position\' type=\'text\' value=\'" + user.getPosition() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Email:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'50\' class=\'inputRequired\'  name=\'email\' type=\'text\' value=\'" + user.getEmail() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'>" + aseUtil.drawHTMLField(conn,"listbox","Campus","campus",userCampus,0,0,false,"",false) + "</td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Office Location:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'50\' class=\'input\'  name=\'location\' type=\'text\' value=\'" + user.getLocation() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Office Hours:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'50\' class=\'input\'  name=\'hours\' type=\'text\' value=\'" + user.getHours() +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Office Phone:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'30\' maxlength=\'20\' class=\'input\'  name=\'phone\' type=\'text\' value=\'" + user.getPhone() +"\'>&nbsp;xxx-xxx-xxxx</td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Website:&nbsp;</td>" );
		out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'80\' maxlength=\'100\' class=\'input\'  name=\'website\' type=\'text\' value=\'" + user.getWebsite() +"\'>" );

		if(user.getWebsite() != null && !user.getWebsite().equals(Constant.BLANK)){
			out.println("&nbsp;<a href=\""+user.getWebsite()+"\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/reviews.gif\" alt=\"go to website\" title=\"go to website\"></a>");
		}

		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Photo:&nbsp;</td>" );

		out.println("					 <td colspan=3 class=\'dataColumn\'>");

		%>
			<div style="border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="uploadDiv">
				<a href="#dialog_photo" name="modal" class="linkcolumn">
					<img src="<%=documentsURL%><%=photo%>" border="0" title="<%=fullname%>" alt="<%=fullname%>">
				</a>
				<br/>
				<a href="#?w=500" rel="helpPopup" class="poplight">
					<span>
						<img src="../images/upload.png" border="0" title="upload photo" title="upload photo">
					</span>
				</a>
			</div>
			<input name="filename" id="filename" value="" type="hidden">
			<input name="weburl" id="weburl" value="<%=photo%>" type="hidden">
			<input name="FileUpload" id="FileUpload" value="0" type="hidden">
		<%

		out.println("</td>");

		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Updated By:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + auditby + "</td>" );
		out.println("					 <td class=\'textblackTH\'>Updated Date:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + auditdate + "</td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
		out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
		out.println("							<input name=\'idx\' type=\'hidden\' value=\'" + idx + "\'>" );
		out.println("							<input name=\'chk\' type=\'hidden\' value=\'" + chk + "\'>" );

		if (!lid.equals(Constant.BLANK) && !lid.equals(Constant.OFF)){
			//out.println("							<input title=\"save user data\" type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

			if (chk.equals(Constant.BLANK) && aseUtil.checkSecurityLevel(aseUtil.CAMPADM,session,response,request).equals("")){
				//out.println("							<input title=\"delete user\" type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
			}

			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			//out.println("							<input title=\"save user data\" type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm("+idx+");\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td colspan=\"4\" class=\'textblackTH\'>&nbsp;* NOTE: Password is required when the user is not part of the UH System.</td>" );
		out.println("				</tr>" );

		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch(Exception e){
		MailerDB mailerDB = new MailerDB(conn,
													campus,
													usr,
													usr,
													e.toString(),
													"pagename: usr");
	}

	asePool.freeConnection(conn,"usr",usr);
%>

<div id="boxes">
	<div id="dialog_photo" class="window ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
		<img src="<%=documentsURL%><%=photo%>" border="0" title="<%=fullname%>">
		<br><br>
		<a href="#" class="close"/><img src="../images/cancel.png" border="0" width="24" height="24" title="close"></a>
	</div>
	<div id="mask"></div>
</div>

<%@ include file="./jqupload.jsp" %>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
