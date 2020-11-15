<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fnd.jsp
	*	2007.09.01	statement maintenance
	*	TODO statement not showing up correctly. display type
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "70%";

	String pageTitle = "Foundation Hallmark Maintenance";

	fieldsetTitle = pageTitle;

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/fnd.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	if (processPage){
		try{
			int lid = 0;
			int seq = 0;
			int en = 0;
			int qn = 0;
			String type = "";
			String hallmark = "";
			String explanatory = "";
			String question = "";
			String data = "";
			String auditby = "";
			String auditdate = "";

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if ( request.getParameter("lid") != null ){
				lid = Integer.parseInt(request.getParameter("lid"));
				if ( lid > 0 ){
					com.ase.aseutil.fnd.Fnd fnd = com.ase.aseutil.fnd.FndDB.getHallmark(conn,lid);
					if ( fnd != null ){
						type = fnd.getType();
						seq = fnd.getSeq();
						en = fnd.getEn();
						qn = fnd.getQn();

						hallmark = fnd.getHallmark();
						explanatory = fnd.getExplanatory();
						question = fnd.getQuestion();

						if(en == 0 && qn == 0){
							data = hallmark;
						}
						else if(en > 0 && qn == 0){
							data = explanatory;
						}
						else if(en > 0 && qn > 0){
							data = question;
						}

						auditby = fnd.getAuditBy();
						auditdate = fnd.getAuditDate();
					}
				}
				else{
					lid = 0;
					auditdate = aseUtil.getCurrentDateTimeString();
					auditby = user;
				}
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/jango\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("				<tr>" );
			out.println("					 <td width=\"10%\" class=\'textblackTH\'>ID:&nbsp;</td>" );
			out.println("					 <td>" + lid + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Type:&nbsp;</td>" );
			out.println("					 <td>");
			out.println(aseUtil.createStaticSelectionBox("FG,FS,FW","FG,FS,FW","type",type,"",""," ","INFO"));
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Sequence:&nbsp;</td>" );
			out.println("					 <td>");
			out.println(aseUtil.createStaticSelectionBox("0,1,2,3,4,5,6,7,8,9,10","0,1,2,3,4,5,6,7,8,9,10","seq",""+seq,"",""," ","INFO"));
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Explanatory:&nbsp;</td>" );
			out.println("					 <td>");
			out.println(aseUtil.createStaticSelectionBox("0,1,2,3,4,5,6,7,8,9,10","0,1,2,3,4,5,6,7,8,9,10","en",""+en,"",""," ","INFO"));
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Question:&nbsp;</td>" );
			out.println("					 <td>");
			out.println(aseUtil.createStaticSelectionBox("0,1,2,3,4,5,6,7,8,9,10","0,1,2,3,4,5,6,7,8,9,10","qn",""+qn,"",""," ","INFO"));
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Hallmark:&nbsp;</td>" );
			out.println("					 <td>" );

			String ckName = "data";
			String ckData = data;

%>
			<%@ include file="ckeditor02.jsp" %>
<%

			out.println("					</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + campus + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input name=\'lid\' type=\'hidden\' value=\'" + lid + "\'>" );

			if ( lid > 0 ){
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			}
			else{
				out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
			}

			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"fnd",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
