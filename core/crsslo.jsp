<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsslo.jsp	-	SLO Assessment - connect content --> slo --> assessments. Works with crscntidx.jsp
	*	TODO need to tie this together and save
	*	TODO need to set type the right way
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";
	String pageTitle = "";

	String thisPage = "crsslo";
	session.setAttribute("aseThisPage",thisPage);

	String type = "PRE";

	String message = "";
	String alpha = "";
	String num = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	int cid = website.getRequestParameter(request,"cid",0);

	String url = "";

	session.setAttribute("aseApplicationMessage","");

	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];

		// not already assessing by another
		// person = proposer & outline = modify
		// if SLO record not there, create one
		// continue as long as ASSESS status

		if (SLODB.sloProgress(conn,kix,"APPROVAL") && DistributionDB.hasMember(conn,campus,"SLOApprover",user)){
			// permit approver to continue
		}
		else if (SLODB.sloProgress(conn,kix,"APPROVED") && user.equals(SLODB.getAssesser(conn,campus,alpha,num))){
			// permit assesser to continue
		}
		else{
			msg = SLODB.isAssessible(conn,kix,user);
			if ( !"".equals(msg.getMsg()) ){
				message = MsgDB.getMsgDetail(msg.getMsg());

				if (!"".equals(msg.getErrorLog()))
					message = message + " <b>" + msg.getErrorLog() + "</b>";

				url = "msg.jsp?nomsg=1&kix=" + kix + "&campus=" + campus;
			}
			else{
				if (CompDB.isCompAdded(conn,kix)){
					SLODB.createSLO(conn,campus,alpha,num,user,kix,"ASSESS");

					if (!SLODB.sloProgress(conn,kix,"ASSESS")){
						message = "You are not authorized to assess this SLO or it is not assessable at this time.<br><br>";
						url = "msg.jsp?nomsg=1&kix=" + kix + "&campus=" + campus;
					}
				} // CompDB.isCompAdded
			}	//!"".equals(msg.getMsg()
		}	// (SLODB.sloProgress
	}
	else{
		url = "tasks.jsp";
	} // !"".equals(kix)

	session.setAttribute("aseApplicationMessage",message);
	asePool.freeConnection(conn);

	if (url.equals("")){
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
		if (SLODB.sloProgress(conn,kix,"APPROVAL"))
			fieldsetTitle = "SLO/Competencies Approval";
		else
			fieldsetTitle = "Outline SLO/Competencies Assessment";
	}
	else{
		response.sendRedirect(url);
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (message.length()==0){
		try{
		%>
			<form method="post" name="aseForm" action="/central/servlet/als">

				<table width="80%" cellspacing="0" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
					<tr >
						 <td class="textblackTH" nowrap colspan=2><br /></td
					</tr>
					<tr height="170" >

						 <td align="left" valign="top" width="50%">
							<fieldset class="FIELDSET90">
								<legend>SLO/Competencies</legend>
								<%
									try{
										String comp = getCompsAsHTMLOptionsByKix(conn,kix,cid);
										if (comp != null && comp.length() > 0)
											out.println(comp);
									}
									catch (Exception e){
										out.println( e.toString() );
									}
								%>
							</fieldset>
						 </td>

						 <td align="left" valign="top" width="50%">
							<fieldset class="FIELDSET90">
								<legend>Assessment</legend>
								<%
									try{
										String assessment = getAssessmentsAsCheckBox(conn,campus,kix,cid);
										if ( assessment != null && assessment.length() > 0)
											out.println(assessment);
									}
									catch (Exception e){
										out.println( e.toString() );
									}
								%>
							</fieldset>
						 </td>
					</tr>
					<tr>
						 <td colspan="2" align="right">
								<input type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onClick="return validateForm('a')">
								<!--
								<input type="submit" name="aseRemove" value="Remove" class="inputsmallgray" onClick="return validateForm('r')">
								-->
								<input type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return cancelForm()">
						 </td>
					</tr>
				</table>

				<input type="hidden" name="kix" value="<%=kix%>">
				<input type="hidden" name="campus" value="<%=campus%>">
				<input type="hidden" name="alpha" value="<%=alpha%>">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="type" value="<%=type%>">
				<input type="hidden" name="formName" value="aseForm">
				<input type="hidden" name="compid" value="<%=cid%>">
				<input type="hidden" name="rtn" value="crsslo">
			</form>

		<%
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%!

	/*
	 * getCompsAsHTMLOptionsByKix
	 *	<p>
	 * @return String
	 */
	public static String getCompsAsHTMLOptionsByKix(Connection connection,String kix,int compid) throws Exception {

		StringBuffer buf = new StringBuffer();
		String temp = "";

		boolean found = false;

		try {
			String sql = "SELECT compid, comp FROM tblCourseComp WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = NumericUtil.getInt(rs.getInt(1),0);

				String warnMessage = "";
				String checked = "";
				if (id == compid){
					warnMessage = "id=\"warnmessage\"";
					checked = "checked";
				}

				buf.append("<tr "+warnMessage+"><td valign=\"top\" width=\"2%\"><input "+checked+" onClick=\"return reLoadPage('"+kix+"',"+id+");\" type=\"radio\" name=\"compGroup\" value=\"" + id + "\"></td>" +
					"<td width=\"2%\">&nbsp;&nbsp;</td>" +
					"<td valign=\"top\">" + AseUtil.nullToBlank(rs.getString(2)) + "<br/><br/></td></tr>");
				found = true;
			}
			rs.close();
			ps.close();

			temp = buf.toString();
		} catch (Exception e) {
			//logger.fatal("CompDB: getCompsAsHTMLOptionsByKix - " + e.toString());
			buf = null;
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
				+ temp
				+ "</table>";

		return temp;
	} // CompDB: getCompsAsHTMLOptionsByKix

	/*
	 * getAssessmentsAsCheckBox
	 *	<p>
	 *	@param	conn		connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getAssessmentsAsCheckBox(Connection conn,String campus,String kix,int compid) {

		StringBuffer buf = new StringBuffer();
		String temp = "";

		boolean found = false;

		try {

			String assessID = "";
			ArrayList list = new ArrayList();
			String checked = "";
			String comp = "";

			// retrieve all assessed items. put in CSV here
			String selected = "," + AssessDB.getSelectedAssessments(conn,kix,""+compid) + ",";

			// retrieve all available assessments
			list = AssessDB.getAssessments(conn,campus);

			if ( list != null ){

				found = true;

				Assess assess;

				for (int i = 0; i<list.size(); i++){
					assess = (Assess)list.get(i);

					// put a check on items already selected
					checked = "";

					temp = "," + assess.getId() + ",";

					if ( selected.indexOf(temp) >= 0 )
						checked = "checked";

					buf.append("<tr>"
						+ "<td><input type=\"checkbox\" name=\"assess_"+assess.getId()+"\" value=\""+assess.getId()+"\" "+checked+"></td>"
						+ "<td class=\"dataColumn\">"+assess.getAssessment()+"</td>"
						+ "</tr>");

					if ( assessID.length() == 0 )
						assessID = assess.getId();
					else
						assessID = assessID + "," + assess.getId();
				} // for

				// save these ids for later processing
				buf.append( "<input type=hidden value=\'" + assessID + "\' name=assessID>"
					+ "<input type=hidden value=\'" + list.size() + "\' name=numberOfIDs>"
					+ "<input type=hidden value=\'1\' name=currentTab>"
					+ "<input type=hidden value=\'1\' name=currentNo>" );
			}

		} catch (Exception e) {
//logger.fatal("AssessDB: getAssessmentsAsCheckBox - " + e.toString());
			buf = null;
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
				+ buf.toString()
				+ "</table>";

		return temp;
	} // AssessDB: getAssessmentsAsCheckBox


%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
