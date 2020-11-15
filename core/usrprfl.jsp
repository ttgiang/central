<%
	String fieldsetTitle = "";
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/db.jsp" %>

<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="helper" scope="application" class="com.ase.aseutil.Helper" />
<jsp:useBean id="log" scope="application" class="com.ase.aseutil.ASELogger" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />
<jsp:useBean id="outlines" scope="application" class="com.ase.aseutil.Outlines" />
<jsp:useBean id="paging" scope="application" class="com.ase.paging.Paging" />
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />

<%
	/**
	*	ASE
	*	usrprfl.jsp - limited access to fields for user profile
	*						2007.09.01
	*
	*	attachments	- 	2011.05.16
	*
	*
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "68%";
	String pageTitle = "Profile Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
	session.setAttribute("aseThisPage","usrprfl");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String thisUser = website.getRequestParameter(request,"aseUserName","",true);

	String documentsURL = SysDB.getSys(conn,"documentsURL") + "profiles/";

	String photo = "";
	String fullname = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether college codes are displayed (EnableCollegeCodes)");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/usrprfl.js"></script>
	<%@ include file="./js/modal/modalnews.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table><tr><td><div id="systemMessage">&nbsp;</div></td></tr></table>

<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		boolean hideCancelButton = false;

		try{
			String lid = "";
			String chk = website.getRequestParameter(request,"chk");

			if (chk.equals(Constant.ON)){
				lid = thisUser;
			}
			else{
				lid = website.getRequestParameter(request,"lid");
			}

			if (lid.equals(Constant.BLANK)){
				lid = thisUser;
			}

			String auditby = "";
			String auditdate = "";
			String status = "Y,N";
			String uh = "0";
			String dept = "";
			String division = "";
			String alphas = "";
			String sendNow = "";
			String attachment = "0";

			UserDB userDB = new UserDB();
			User user = new User();

			if (!lid.equals(Constant.BLANK) && !lid.equals(Constant.OFF)){
				user = userDB.getUserByName(conn, lid);
				if ( user != null ){
					auditby = user.getAuditBy();
					auditdate = user.getAuditDate();

					dept = user.getDepartment();
					division = user.getDivision();
					alphas = user.getAlphas();

					if (dept.length()==0 || division.length()==0){
						hideCancelButton = true;
					} // dept

					photo = user.getWeburl();

					if (user.getUH()==1){
						uh = "YES";
					}
					else{
						uh = "NO";
					} // getUH

					if ("Active".equals(user.getStatus())){
						status = "1";
					}
					else{
						status = "0";
					} // active

					if (user.getSendNow()==1){
						sendNow = "checked";
					} // sendnow

					if (user.getAttachment()==1){
						attachment = "checked";
					} // attachment
				}
			}
			else{
				lid = "";
				uh = "1";
				status = "1";
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = thisUser;
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/c3p0\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>UH System:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + uh + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>User ID:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + user.getUserid() + "<input type=\'hidden\' name=\'userid\' value=\'" + user.getUserid() + "\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Password:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>**********</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>First Name:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + user.getFirstname() + "</td>" );
			out.println("					 <td class=\'textblackTH\'>Last Name:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + user.getLastname() + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Full Name:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + user.getFullname() +"</td>" );
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
			out.println("					 <td class=\'dataColumn\' colspan=\"3\"><input type=\'text\' name=\'alphas\' class=\'input\'  size=\'80\' value=\'" + alphas + "\'>" );
			out.println("&nbsp;<a href=\"/centraldocs/docs/faq/additionalalphas.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=top nowrap>Access Level:&nbsp;</td>" );
			out.println("					 <td valign=top class=\'dataColumn\'>" + user.getUserLevel() + "</td>" );
			out.println("					 <td class=\'textblackTH\'>Status:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>Active</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Title:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'><input size=\'40\' maxlength=\'50\' class=\'inputRequired\'  name=\'title\' type=\'text\' value=\'" + user.getTitle() +"\'></td>" );
			out.println("					 <td class=\'textblackTH\'>Position:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'><input size=\'40\' maxlength=\'50\' class=\'inputRequired\'  name=\'position\' type=\'text\' value=\'" + user.getPosition() +"\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Email:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'><input autocomplete=\"off\" maxlength=\'50\' size=\'60\' class=\'inputRequired\' name=\'email\' type=\'text\' value=\'" + user.getEmail() +"\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" + user.getCampus() + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Office Location:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'60\' class=\'input\'  maxlength=\'50\' name=\'location\' type=\'text\' value=\'" + user.getLocation() +"\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Office Hours:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'60\' class=\'input\'  maxlength=\'50\' name=\'hours\' type=\'text\' value=\'" + user.getHours() +"\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Office Phone:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'><input size=\'30\' maxlength=\'20\' class=\'input\'  name=\'phone\' type=\'text\' value=\'" + user.getPhone() +"\'>&nbsp;xxx-xxx-xxxx</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>CC Notifications:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" );
			out.println("<input type=\"checkbox\" name=\"sendnow\" " + sendNow + " value=\"1\">");
			out.println("<a href=\"/centraldocs/docs/faq/dailynotification.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;");
			out.println("<br/>(check this box if you want CC to send notifications as they are generated. Uncheck to receive one notification per day.)");
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"24\" valign=\"top\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Include Attachments:&nbsp;</td>" );
			out.println("					 <td colspan=3 class=\'dataColumn\'>" );
			out.println("<input type=\"checkbox\" name=\"attachment\" " + attachment + " value=\"1\">");
			out.println("<br/>(check this box if you want CC to include the course outline or program with notifications.)");
			out.println("					 </td>" );
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
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><div class=\"hr\"></div" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );
			out.println("							<input name=\'chk\' type=\'hidden\' value=\'" + chk + "\'>" );
			//out.println("							<input title=\"save user data\" type=\'submit\' name=\'aseSubmit\' onClick=\"return checkForm()\" value=\'Save\' class=\'inputsmallgray\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );

			if (!hideCancelButton){
				out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			}

			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"usrprfl",thisUser);

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

<p align="left">Note:
<ul>
	<li>Password field is required only when user is not a part of the UH System</li>
	<li>Additional Alphas are entered as a list of ALPHAs separated by commas (ie: ENG,MATH,THAI)</li>
</ul>
</p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

