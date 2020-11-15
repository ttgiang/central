<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>


<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpi.jsp 	compare outline item
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String column = "";
	String compared = "";
	String preItem = "";
	String curItem = "";
	String outlineItem = "";
	String preKix = "";

	String pageTitle = "Compare Outlines";
	fieldsetTitle = pageTitle;

	String alpha = "";
	String num = "";

	if (processPage){

		Enc enc = EncDB.getEnc(request,"aseLinker");
		if (enc != null){
			preKix = enc.getKix();
			column = enc.getKey1();
		} // enc != null

		// using the current kix to get alpha and num
		// use resulting alpha and num with type of CUR to retrieve old KIX for compare
		String[] info = helper.getKixInfo(conn,preKix);
		alpha = info[0];
		num = info[1];

		// get the question to display
		Question question = QuestionDB.getCourseQuestionByColumn(conn,campus,column,Constant.TAB_COURSE);
		if (question != null)
			outlineItem = question.getQuestion();

		// look up the older or current version
		String curKix = helper.getKix(conn,campus,alpha,num,"CUR");
		if (curKix == null || curKix.length() == 0)
			curItem = "&nbsp;";
		else{
			curItem = courseDB.getCourseItem(conn,curKix,column);
			curItem = outlines.formatOutline(conn,column,campus,alpha,num,"CUR",curKix,curItem,false,user);
		}

		// get the version that is being modified
		preItem = courseDB.getCourseItem(conn,preKix,column);
		if (preItem == null || preItem.length() == 0)
			preItem = "&nbsp;";
		else
			preItem = outlines.formatOutline(conn,column,campus,alpha,num,"PRE",preKix,preItem,false,user);

		// compare
		if (curItem.equals(preItem))
			compared = "identical";
		else
			compared = "not identical";
	}

	asePool.freeConnection(conn,"crscmpi",user);
%>

<title>Curriculum Central: Course Questions</title>
</style>

<link rel="stylesheet" type="text/css" href="/central/inc/style.css">
<link rel="stylesheet" type="text/css" href="/central/inc/site.css" />
	<%@ include file="ase2.jsp" %>
</head>
<%@ include file="../inc/header4.jsp" %>

<body topmargin="0" leftmargin="0">

<table border="0" cellpadding="0" cellspacing="1" width="98%">
	<tbody>
		<tr>
			<td class="textblackth" width="15%">Outline item:</td>
			<td class="datacolumn"><%=outlineItem%></td>
		</tr>
		<tr>
			<td class="datacolumn" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td class="textblackth" width="15%">Result:</td>
			<td class="datacolumn"><%=compared%></td>
		</tr>
	</tbody>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="1" width="98%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					<tr>
						<td class="intd" height="90%" align="center" valign="top" colspan="2">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="" valign="top">
										<!-- PAGE CONTENT GOES HERE -->
											<table border="1" cellspacing="0" cellpadding="0" width="96%">
												<tr>
													<td valign=top width="48%" class="textblackth" bgcolor="<%=Constant.COLOR_LEFT%>">&nbsp;Existing Item</td>
													<td valign=top width="48%" class="textblackth" bgcolor="<%=Constant.COLOR_RIGHT%>">&nbsp;Modified Item</td>
												</tr>
												<tr>
													<td valign=top class="datacolumn" bgcolor="<%=Constant.COLOR_LEFT%>"><%=curItem%></td>
													<td valign=top class="datacolumn" bgcolor="<%=Constant.COLOR_RIGHT%>"><%=preItem%></td>
												</tr>
											</table>
										<!-- PAGE CONTENT ENDS HERE -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>
<br>
<br>
<table border="0" cellpadding="0" cellspacing="1" width="98%">
	<tbody>
		<tr>
			<td class="textblackth">Similar items in UH System:</td>
		</tr>
		<tr>
			<td>
				<br>
				<%
					out.println(outlines.getSystemWideItem(conn,user,preKix,column));
				%>
			</td>
		</tr>
	</tbody>
</table>
<br>

</body>
</html>