<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnmxy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crsrnm";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String fromAlpha = "";
	String fromNum = "";
	String toAlpha = "";
	String toNum = "";
	String type = "";
	String temp = "";
	String proposer = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	boolean valid = true;
	msg.setMsg("");

	String message = "Do you wish to continue with rename/renumber operation?";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		fromAlpha = info[Constant.KIX_ALPHA];
		fromNum = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		proposer = info[Constant.KIX_PROPOSER];
	}
	else{
		fromAlpha = website.getRequestParameter(request,"fromAlpha","");
		fromNum = website.getRequestParameter(request,"fromNum","");
		type = website.getRequestParameter(request,"type","");
		proposer = courseDB.getCourseProposer(conn,campus,fromAlpha,fromNum,type);
	}

	toAlpha = website.getRequestParameter(request,"alpha_ID","");
	if (toAlpha.equals(Constant.BLANK)){
		toAlpha = website.getRequestParameter(request,"alpha","");
	}

	toNum = website.getRequestParameter(request,"toNum","");

	// sent in from crsedt (course mod)
	// st determines whether we are here to start a change alpha or number
	// depending on st, we initialize screen accordingly
	String st = website.getRequestParameter(request,"st","");
	String ts = website.getRequestParameter(request,"ts","");
	String no = website.getRequestParameter(request,"no","");
	String justification = website.getRequestParameter(request,"justification","");

	if ( formName != null && formName.equals("aseForm") && formAction.equalsIgnoreCase("s")){

		msg = courseDB.isCourseRenamable(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type);
		if (!"".equals(msg.getMsg())){
			valid = false;

			if ("CourseExistCampusWide".equals(msg.getMsg())){
				temp = "Click <a href=\"vwcrsx.jsp?kix=" + kix + "&t=CUR\" class=\"linkcolumn\">here</a> to view outline for " + fromAlpha + " " + fromNum + ".";
			}

			message = MsgDB.getMsgDetail(msg.getMsg()) + "<br/><br/>" + temp;
			if (	"CourseExistCampusWide".equals(msg.getMsg()) ||
					"CourseModificationInProgress".equals(msg.getMsg())){
				kix = Helper.getKix(conn,campus,toAlpha,toNum,"CUR");
				if (!"".equals(kix))
					message = "Outline " + toAlpha + " " + toNum + " already in Curriculum Central." +
						"<br/><br/>Click <a href=\"vwhtml.jsp?cps="+campus+"&kix="+kix+"&t=CUR\" class=\"linkcolumn\" target=\"_blank\">here</a> to view outline";
			}
		}
		else{
			// if the course is in proposed status, only proposer may rename
			if(type.equals(Constant.PRE) && !user.equals(proposer)){
				valid = false;

				message = "Only the proposer ("+proposer+") may request rename/renumber for " + fromAlpha + " " + fromNum + " at this time.";
			} // type

		}

	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Rename/Renumber Outline";
	fieldsetTitle = "Rename/Renumber Outline";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsrnm.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />

<%

	if (processPage){

%>

<form method="post" action="crsrnmxy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br /><br />
					<TABLE cellSpacing=2 cellPadding=4 width="80%" border=0>
							<TR>
								<TD class="textblackth" width="15%">From:&nbsp;</td>
								<td class="datacolumn" width="85%"><%=fromAlpha%>&nbsp;<%=fromNum%></td>
							</tr>
							<tr>
								<td class="textblackth" width="15%">To:&nbsp;</td>
								<td class="datacolumn" width="85%"><%=toAlpha%>&nbsp;<%=toNum%></td>
							</tr>
							<tr>
								<td class="textblackth" width="15%">Justification:&nbsp;</td>
								<td class="datacolumn" width="85%"><%=justification%></td>
							</tr>
					</table>
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=st%>" name="st">
					<input type="hidden" value="<%=no%>" name="no">
					<input type="hidden" value="<%=ts%>" name="ts">
					<input type="hidden" value="<%=justification%>" name="justification">
					<input type="hidden" value="<%=fromAlpha%>" name="fromAlpha">
					<input type="hidden" value="<%=fromNum%>" name="fromNum">
					<input type="hidden" value="<%=toAlpha%>" name="toAlpha">
					<input type="hidden" value="<%=toNum%>" name="toNum">
					<input type="hidden" value="<%=type%>" name="type">
				</TD>
			</TR>

			<%
				if (valid) {
			%>
				<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<TD align="center">
						<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
						<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
						</div>
					</td>
				</tr>
				<TR>
					<TD align="center">
						<br />
						<input id="cmdYes" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkFormX('s')">&nbsp;
						<input id="cmdNo" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>
			<%
				}
			%>
		</TBODY>
	</TABLE>
</form>

<%
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
