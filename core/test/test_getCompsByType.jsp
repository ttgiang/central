<%@ include file="ase.jsp" %>

<%
	String pageTitle = "";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsrwslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEE";
	String user = "THANHG";
	String type = "PRE";
	String[] iniValues;
	String fieldRef = "MethodInstructions";
	String question = "105,106,104,70,109";

	out.println(getCompsByType(conn,out,alpha,num,campus,"PRE",user,"","",false,"test"));

	asePool.freeConnection(conn);
%>

<%!
	public static String getCompsByType(Connection connection,
												javax.servlet.jsp.JspWriter out,
												String alpha,
												String num,
												String campus,
												String type,
												String user,
												String currentTab,
												String currentNo,
												boolean showImages,
												String caller) throws Exception {

		String getSQL = "SELECT compid,comp,approved,approvedby,approveddate FROM tblCourseComp WHERE campus=? AND courseAlpha=? AND courseNum=? AND coursetype=?";
		StringBuffer buf = new StringBuffer();
		String approved = "";
		String approvalDate = "";

		try {
			int compID;
			String image = "";
			String allRadios = "";
			AseUtil aseUtil = new AseUtil();

			// does this person have approval access?
			boolean isReviewer = DistributionDB.hasMember(connection,campus,"SLOReviewer",user);
			boolean isReviewing = SLODB.isReviewing(connection,campus,alpha,num);

			buf.append("<form name=\"aseApprovalForm\" method=\"post\" action=\"crscmpy.jsp\">");
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
				"<td width=\"60%\" valign=\"top\" class=\"textblackTH\">SLO</td>" +
				"<td width=\"15%\" valign=\"top\" class=\"textblackTH\" nowrap>Approved By</td>" +
				"<td width=\"20%\" valign=\"top\" align=\"right\" class=\"textblackTH\">Date</td></tr>");

			/*
				SLO reviewers sees Y/N for approval and not delete image.

				Proposer/author cannot see Y/N but allowed to delete.

				Once approved, delete not allowed.
			*/
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				compID = rs.getInt(1);
				if (AssessDB.hasAssessment(connection,campus,alpha,num,type,compID))
					image = "reviews";
				else
					image = "reviews_off";

				approved = aseUtil.nullToBlank(rs.getString("approved"));
				approvalDate = aseUtil.ASE_FormatDateTime(rs.getString("approveddate"),6);

				if ("Y".equals(approved)){
					buf.append("<tr>");

					if (showImages)
						buf.append("<td align=\"left\" width=\"03%\" valign=\"top\" nowrap><a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/" + image + ".gif\" border=\"0\" alt=\"add assessment\" id=\"assessment\"></a></td>");
					else
						buf.append("<td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
						"<td width=\"75%\" valign=\"top\" class=\"dataColumn\">" + rs.getString("comp") + "</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"dataColumn\">" + aseUtil.nullToBlank(rs.getString("approvedby")) + "</td>" +
						"<td width=\"10%\" valign=\"top\" align=\"right\" class=\"dataColumn\">" + approvalDate + "</td></tr>");
				}
				else{
					if ("".equals(allRadios))
						allRadios = String.valueOf(compID);
					else
						allRadios = allRadios + "," + String.valueOf(compID);

					buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>");

					if (showImages){
						buf.append("<a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/" + image + ".gif\" border=\"0\" alt=\"assessment\" id=\"assessment\"></a>&nbsp;");

						if (!isReviewer && !isReviewing)
							buf.append("<a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/del.gif\" border=\"0\" alt=\"delete\" id=\"delete\" onclick=\"aseSubmitClick2("+compID+"); return false;\"></a>");
					}
					else
						buf.append("&nbsp;");

					buf.append("</td><td width=\"75%\" valign=\"top\" class=\"dataColumn\">" + rs.getString("comp") + "</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"dataColumn\" nowrap>");

					if (isReviewer)
						buf.append(aseUtil.drawHTMLField(connection,"radio","YN",""+compID,approved,0,0,false));

					buf.append("</td>" +
						"<td width=\"10%\" valign=\"top\" align=\"right\" class=\"dataColumn\">" + approvalDate + "</td></tr>");
				}
			}

			buf.append("<tr><td align=\"right\" width=\"03%\" valign=\"top\" colspan=\"4\">");
			buf.append("<input type=\'hidden\' name=\'allRadios\' value=\'" + allRadios + "\'>");

			if (isReviewer)
				buf.append("<input type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'inputsmallgray\' onClick=\"checkForm(\'a\');\">&nbsp;");

			if ("".equals(allRadios))
				buf.append("<input type=\'submit\' name=\'aseReturnToProposer\' value=\'Return to Proposer\' class=\'inputsmallgray\' onClick=\"returnToProposer();\">&nbsp;");

			buf.append("<input type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+alpha+"','"+num+"','"+currentTab+"','"+currentNo+"')\">" );

			buf.append("<input type=\'hidden\' name=\'caller\' value=\"" + caller + "\">" );

			buf.append("&nbsp;&nbsp;</td></tr>");
			buf.append("</table>");
			buf.append("</form>");

			rs.close();
			ps.close();
		} catch (Exception e) {
			out.println("CompDB: getCompsByType\n" + e.toString());
			return null;
		}

		return buf.toString();
	}
%>

</body>
</html>
