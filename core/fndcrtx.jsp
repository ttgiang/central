<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrtx.jsp	create new outline.
	*	TODO: fndcrtx.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "70%";

	String pageTitle = "screen 3 of 4 - Select co-authors (optional)";
	fieldsetTitle = "Create Foundation Course";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String foundation = website.getRequestParameter(request,"foundation","");
	String assessment = website.getRequestParameter(request,"assessment","");

	String courseTitle = "";
	String action = "fndcrty.jsp";
	String authors = "";
	String courseDescr = "";

	//
	// id is available when coming in to adjust settings
	//
	int id = website.getRequestParameter(request,"id",0);
	if(id > 0){
		pageTitle = "Select co-authors (optional)";
		fieldsetTitle = "Edit Foundation Course Settings";

		com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

		kix = fnd.getFndItem(conn,id,"historyid");
		if(!kix.equals(Constant.BLANK)){
			String[] info = fnd.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			courseTitle = info[Constant.KIX_COURSETITLE];

			foundation = fnd.getFndItem(conn,id,"fndtype");
			authors = fnd.getFndItem(conn,id,"coproposer");
			assessment = fnd.getFndItem(conn,id,"assessment");
			courseDescr = fnd.getFndItem(conn,id,"coursedescr");
		}

		fnd = null;

		action = "fndcrtxx.jsp";
	}
	else{
		courseTitle = courseDB.getCourseItem(conn,kix,"coursetitle");
		courseDescr = courseDB.getCourseItem(conn,kix,"coursedescr");
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/fndcrtx.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>

<form method="post" name="aseForm" action="<%=action%>">
	<%
		out.println("<table height=\'90\' width=\'98%\' cellspacing='4' cellpadding='4' align=\'center\'  border=\'0\'>" );

		out.println("	<tr><td class=\"textblackth\" width=\"15%\">Campus:</td><td class=\"datacolumn\">" + campus + "</td></tr>" );
		out.println("	<tr><td class=\"textblackth\" width=\"15%\">Course Outline:</td><td class=\"datacolumn\">" + alpha + " " + num + " - " + courseTitle + "</td></tr>" );
		out.println("	<tr><td class=\"textblackth\" width=\"15%\">Description:</td><td class=\"datacolumn\">" + courseDescr + "</td></tr>" );
		out.println("	<tr><td class=\"textblackth\" width=\"15%\">Foundation Type:</td><td class=\"datacolumn\">" + foundation + " - " + com.ase.aseutil.fnd.FndDB.getFoundationDescr(foundation) + "</td></tr>" );
		out.println("	<tr><td class=\"textblackth\" width=\"15%\">Assessment:</td><td class=\"datacolumn\">");

		String ckName = "assessment";
		String ckData = assessment;

	%>
		<%@ include file="ckeditor02.jsp" %>
	<%
		out.println("</td></tr>" );

		out.println("<form method=\'post\' name=\'aseForm\' action=\'fndcrty1.jsp\'>" );
		out.println("	<tr>" );
		out.println("		<td colspan=\"2\">" );
		out.println("				<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("					<tr>" );
		out.println("					 	<td width=\"10%\" class=\'textblackTH\' nowrap valign=top>Co-Authors:</td>" );
		out.println("					 	<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");

		out.println(ReviewerDB.getCampusReviewUsers2(conn,campus,campus,alpha,num,user,""));
		out.println("						</td>" );
		out.println("					 	<td width=\"10%\" valign=\'middle\'>" );
		out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Remove\" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
		out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Add\" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
		out.println("						</td>" );

		out.println("					 	<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");

		if(id==0){
			%>
				<select name="toList" size="10" class="smalltext">
					<option selected="" value="">- select -</option>
				</select>
			<%
		}
		else{
			%>
				<input type="hidden" name="id" value="<%=id%>">
				<select name="toList" size="10" class="smalltext">
			<%
					if(!authors.equals(Constant.BLANK)){
						String[] aAuthors = authors.split(",");
						for(int i=0;i<aAuthors.length;i++){
							out.println("<option value=\""+aAuthors[i]+"\">"+UserDB.getUserFriendlyName(conn,aAuthors[i])+"</option>");
						}
					} // authors
			%>
				</select>
			<%
		}

		out.println("					 	</td>" );
		out.println("					</tr>" );
		out.println("				</table>" );
		out.println("		 </td>" );
		out.println("	</tr>" );

		// form buttons
		out.println("				<tr>" );
		out.println("					 <td  colspan=\"2\" class=\'textblackTHRight\'><hr size=\'1\'>" );
		out.println("							<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
		out.println("							<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
		out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
		out.println("							<input type=\'hidden\' name=\'foundation\' value=\'" + foundation + "\'>" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
		out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Continue\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
		out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("</form>" );

		out.println("			</table>" );

	%>

</form>

<%
	}

	asePool.freeConnection(conn,"fndcrty",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){

		//
		// aseCancel
		//
		$("#aseCancel").click(function() {

			window.location = "fndmnu.jsp";

			return false;

		});

	}); // jq

</script>

</body>
</html>
