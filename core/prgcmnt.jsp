<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcmnt.jsp	- add comments to program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String type = "";

	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

	int id = website.getRequestParameter(request,"id", 0);
	int item = website.getRequestParameter(request,"qn", 0);
	int md = website.getRequestParameter(request,"md", 0);
	String tb = website.getRequestParameter(request,"c","");
	boolean update = false;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
	}

	String chromeWidth = "68%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Program Item Comments";
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgcmnt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String comments = "";
			String auditby = "";
			String auditdate = "";

			String question = QuestionDB.getCourseQuestionByNumber(conn,campus,Constant.TAB_PROGRAM,item);
			String questionNumber = "" + ProgramsDB.getProgramSequenceByNumber(conn,campus,item);
			if (item>0 && id>0){
				update = true;

				Review review = ReviewerDB.getReview(conn,campus,kix,id);
				if (review != null){
					comments = review.getComments();
					auditby = review.getUser();
					auditdate = review.getAuditDate();
				}
			}
			else{
				auditby = user;
				auditdate = aseUtil.getCurrentDateTimeString();
			}

			// set up bogus data during test.
			boolean debug = false;
			if (debug){
				comments = aseUtil.getCurrentDateTimeString();
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/r2d2\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Question:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + questionNumber + ". " + question +"</td></tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Comments:&nbsp;</td>" );
			out.println("					 <td>");
			out.println("						<textarea class=\"input\" id=\"comments\" name=\"comments\" style=\"height: 200px; width: 500px;\">"+comments+"</textarea>");
			out.println("					 </td></tr>" );

			boolean testing = false;

			if (testing){
				boolean isApprover = ApproverDB.isApprover(conn,kix,user);
				String itemMessage = "enable this item for modification";
				String checked = "";
				String disabled = "";
				String whoEnabledThisItem = "";
				int itemValue = 0;

				/*
					approver comments has mode value of 1 and
					review within approver has value of 3
				*/
				if (isApprover){

					// was it enabled for modification?
					checked = "";
					if (ProgramsDB.isProgramItemEditable(conn,campus,kix,item)){
						checked = "checked";
						whoEnabledThisItem = ProgramsDB.whoEnabledThisItem(conn,campus,kix,item);
						itemMessage = whoEnabledThisItem + " enabled this item for modification";
					}

					/*
						enable item only for person who turned it on or an approver.
						setting itemValue to 0 tells the form submission program
						to ignore updating this value. Only update when the value
						is submitted by the person updating the field.
						cannot use field item since it is relied upon below
					*/
					if (whoEnabledThisItem.equals(user) || isApprover){
						disabled = "";
						itemValue = item;
					}
					else{
						itemValue = 0;
						disabled = "disabled";
					}

					out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
					out.println("					 <td class=\'textblackTH\' nowrap>Enable Item:&nbsp;</td>" );
					out.println("					 <td class=\'datacolumn\'>" );
					out.println("					 <input type=\"checkbox\" " + checked + " " + disabled + " name=\"enable\" value=\""+itemValue+"\">&nbsp;(" + itemMessage + ")");
					out.println("					 </td>" );
					out.println("				</tr>" );
				} // if isApprover
			}
			else{
				out.println("<input name=\'enable\' type=\'hidden\' value=\'0\'>" );
			} // testing

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
			out.println("							<input name=\'item\' type=\'hidden\' value=\'" + item + "\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input name=\'id\' type=\'hidden\' value=\'" + id + "\'>" );
			out.println("							<input name=\'tb\' type=\'hidden\' value=\'" + tb + "\'>" );
			out.println("							<input name=\'md\' type=\'hidden\' value=\'" + md + "\'>" );

			if (update){
				out.println("							<input title=\"update entered data\" type=\'submit\' name=\'aseUpdate\' value=\'Update\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			}
			else{
				out.println("							<input title=\"save entered data\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			}

			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td colspan=\"2\">"
				+ "<fieldset class=\"FIELDSET90\">"
				+ "<legend>Approver Comments</legend>"
				+	Html.BR()
				+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,Constant.TAB_PROGRAM,Constant.REVIEW,true,true)
				+	"</fieldset>"
				+	Html.BR()
				+ "</td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );

		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}
	else
		out.println("CC was not able to process your request.");

	asePool.freeConnection(conn,"prgcmnt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
