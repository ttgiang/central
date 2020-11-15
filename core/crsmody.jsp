<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsmody.jsp - outline modifications
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String caller = "crsmod";
	String pageTitle = "Outline Modifications";
	fieldsetTitle = pageTitle;

	String alpha = "";
	String num = "";
	String type = "";
	String proposer = "";
	String message = "";
	String url = "";
	int route = 0;

	String jsid = (String)session.getId();
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix","");
	String savedKix = kix;

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];
		route = NumericUtil.nullToZero(info[6]);

		//
		//	1) to modify, you must belong to the same alpha
		//	2) if you are and this is a CUR, check to see if a PRE exists
		//	3) if yes, push to the PRE; else, edit the CUR
		//

		if (alpha.equals(UserDB.getUserDepartment(conn,user,alpha))) {
			if (courseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){

				//
				//	if the selected outline = CUR and we already have a PRE in progress,
				//	the kix will be different. If different from savedKix, then a CUR
				//	was selected. Only display message when a CUR was selected.

				//	We could have just sent the user to the PRE version, but we have to
				//	warn them since they might have been viewing the content of a CUR and expect
				//	to modify that version.
				//
				kix = helper.getKix(conn,campus,alpha,num,"PRE");

				if (!courseDB.isEditable(conn,campus,alpha,num,user,jsid)){
					msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
					message = "You are not authorized to edit this outline or it is not editable at this time.<br><br><hr size=1>"
						+ helper.showCourseProgress(conn,kix)
						+ "<font class=\"textblackTH\">Completed approvals</font>"
						+ msg.getErrorLog()
						+ "<br/>"
						+ "<font class=\"textblackTH\">Pending approvals</font>"
						+ ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route)
						+ "<hr size=1>"
						+ "<p align=center><a href=\"vwcrs.jsp?alpha=" + alpha + "&num=" + num + "&t=PRE\" class=\"linkcolumn\">view outline</a>";
				}
				else{
					url = "crsedt.jsp?z=1&kix="+kix;

					if (!savedKix.equals(kix)){
						message = "The selected <b>APPROVED</b> outline is already going through modification by <b>" + proposer + "</b>.<br><br>" +
							"If you want to continue with modification of the <b>APPROVED</b> outline, you must cancel the currently proposed outline.<br><br>" +
							"Click <a href=\"" + url + "\">here</a> to modify the existing outline.";
					}
				}
			}
			else{
				session.setAttribute("aseRequestToStartModify", "1");
				url = "shwfld.jsp?rtn=crsedt&kix="+kix;
			}	// if PRE
		} else {
			message = MsgDB.getMsgDetail("NotAuthorizeToModify");
		}	// if alpha
	}
	else{
		message = "Unable to process your request.<br><br>";
	} // kix

	if ("".equals(message))
		response.sendRedirect(url);

	asePool.freeConnection(conn,"crsmody",user);

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#showCompletedApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '25%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#showPendingApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println("<br/><p align=\"center\">" + message + "</p>");
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
