<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	initm.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "System Settings Maintenance";

	String alpha = "";
	String num = "";
	String type = "";
	String campus = "";
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
	}
	fieldsetTitle = pageTitle;
	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/initm.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%
	try{
		int i = 0;

		// -----------------------------> 1
		int numberOfColumns = 3;
		String[] sFieldLabel = new String[numberOfColumns];
		String[] sColumnValue = new String[numberOfColumns];
		String[] sFieldName = new String[numberOfColumns];
		String[] sEdit = new String[numberOfColumns];
		String sql;

		// -----------------------------> 2
		sFieldLabel = "Category,Description,Value".split(",");
		sFieldName = "category,kdesc,kval1".split(",");
		sEdit = "0,1,1".split(",");

		sColumnValue[0] = "RequisiteComments";
		sColumnValue[1] = "";
		sColumnValue[2] = "";

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/is\'>" );
		out.println("			<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td align=\"center\" class=\'textblackTHCenter\' colspan=\"2\">" + pageTitle + "</td>" );
		out.println("				</tr>" );

		int j;
		for (j=0; j<numberOfColumns; j++){
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td nowrap class=\'textblackTH\'>" + sFieldLabel[j] + ":&nbsp;</td>" );

			if (sEdit[j].equals("1"))
				out.println("					 <td><textarea cols=\'65\' rows=\'2\' class=\'input\'  name=\'" + sFieldName[j] + "\'>"+ sColumnValue[j] + "</textarea></td>" );
			else
				out.println("					 <td class=\"dataColumn\">" + sColumnValue[j] + "</td>" );

			out.println("				</tr>" );
		}

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
		out.println("							<input type=\'hidden\' name=\'kix\' value=\'"+kix+"\'>" );
		out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch(Exception e){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

</body>
</html>
