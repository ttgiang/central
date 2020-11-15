<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	bnnr.jsp
	*	2007.09.01
	**/

	// mnu controls the action on this form. Either add the news or upload document

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "70%";

	String key = website.getRequestParameter(request,"key", "");
	String tbl = website.getRequestParameter(request,"tbl", "");

	String formAction = "u";

	String table = "";
	String rtn = "";

	if (tbl.toLowerCase().equals("ba")){
		table = "Alpha";
		rtn = "alphaidx";
	}
	else if (tbl.toLowerCase().equals("bc")){
		table = "College";
		rtn = "cllgidx";
	}
	else if (tbl.toLowerCase().equals("bdt")){
		table = "Department";
		rtn = "dprtmnt";
	}
	else if (tbl.toLowerCase().equals("bdv")){
		table = "Division";
		rtn = "dvsn";
	}
	else if (tbl.toLowerCase().equals("bl")){
		table = "Level";
		rtn = "lvlidx";
	}
	else if (tbl.toLowerCase().equals("bt")){
		table = "Terms";
		rtn = "trms";
	}

	String pageTitle = "Banner "+table+" Maintenance";

	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/bnnr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%

	String code = "";
	String descr = "";

	try{
		// defafult values
		if (!key.equals(Constant.BLANK)){
			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0

			formAction = "u";

			BannerData data = new BannerData();
			data = BannerDataDB.getBannerData(conn,tbl,key);
			if ( data != null ){
				code = data.getCode();
				descr = data.getDescr();
			}
		}
		else{
			formAction = "a";

			key = "";
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/naboo\'>" );

		out.println("			<table width=\'100%\' cellspacing='4' cellpadding='2'  align=\'center\'  border=\'0\' class=asetable>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\' width=\"15%\">Code:&nbsp;</td>" );

		if (key.equals(Constant.BLANK)){
			out.println("					 <td><input size=\'70\' class=\'input\' name=\'code\' id=\'code\' type=\'text\' value=\'" + code +"\'></td>" );
		}
		else{
			out.println("					 <td>" + code +"</td>" );
			out.println("							<input name=\'code\' id=\'code\' type=\'hidden\' value=\'" + code + "\'>" );
		}

		out.println("				</tr>" );
		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTH\'>Description:&nbsp;</td>" );
		out.println("					 <td><input size=\'70\' class=\'input\' name=\'descr\' id=\'descr\' type=\'text\' value=\'" + descr +"\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
		out.println("							<input name=\'key\' id=\'key\' type=\'hidden\' value=\'" + key + "\'>" );
		out.println("							<input name=\'rtn\' id=\'rtn\' type=\'hidden\' value=\'" + rtn + "\'>" );
		out.println("							<input name=\'tbl\' id=\'tbl\' type=\'hidden\' value=\'" + tbl + "\'>" );

		out.println("							<input type=\'hidden\' name=\'formAction\' id=\'formAction\' value=\'" + formAction + "\'>" );

		//out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
		if (!key.equals(Constant.BLANK)){
			//out.println("							<input type=\'submit\' name=\'aseDelete\' id=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return deleteBannerData('"+key+"','"+tbl+"')\">" );
		}

		out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+rtn+"')\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"bnnr",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
