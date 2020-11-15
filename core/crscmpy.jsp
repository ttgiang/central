<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpy.jsp	course competency - called by CompDB
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "SLO Review";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>

<%@ include file="../inc/header.jsp" %>

<body topmargin="0" leftmargin="0">
<%
	try{
		int rowsAffected = 0;
		int i = 0;

		String alpha = "";
		String num = "";
		String type = "";

		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);
		String campusName = CampusDB.getCampusName(conn,campus);
		String kix = website.getRequestParameter(request,"kix");
		if (!kix.equals("")){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
		}

		boolean debug = false;

		// get all the radio fields from the form
		String allRadios = website.getRequestParameter(request,"allRadios");

		// if there were anything to process
		if (!allRadios.equals("")){
			// break the radios into individual fields
			String[] eachRadio = allRadios.split(",");
			String radio = "";
			String slo = "";

			if (debug){
				out.println("allRadios: " + allRadios + "<br>");
			}

			// cycle through all radios, pick out the values and update.
			// AseUtil.drawHTMLField creates fields with name followed by underscore and 0 (name_0)
			// the name was set to the compid which were all saved in allRadios as CSV
			for(i=0;i<eachRadio.length;i++){
				radio = website.getRequestParameter(request,"radio_"+eachRadio[i]+"_0");
				slo = website.getRequestParameter(request,"slo"+eachRadio[i]);
				if (!radio.equals("")){
					if (debug){
						out.println("slo: " + slo + "<br>");
						out.println("radio: " + radio + "<br>");
					}
					else{
						rowsAffected = CompDB.setCompReview(conn,campus,alpha,num,type,slo,radio,user,Integer.parseInt(eachRadio[i]));
					}
				}
			}
		}

		asePool.freeConnection(conn,"crscmpy",user);

		out.println("	<table width=\'40%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td colspan=\"2\" align=\"center\"><br/>SLOs updated successfully<br/><br/></td>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + campusName );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Outline:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + alpha + " " + num);
		out.println("			</td></tr>" );

		out.println("	</table>" );
	}
	catch(Exception e){}
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
