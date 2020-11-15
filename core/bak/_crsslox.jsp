					<table width="90%" cellspacing="0" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
						<tr >
							 <td class="textblackTH" nowrap colspan=2><br /><p align="left">1) Select an least 1 item from the lists below<br>2) Click add to start your assessment</p><br/></td
						</tr>
						<tr height="170" >

							 <td align="left" valign="top" width="50%">
								<fieldset class="FIELDSET280">
									<legend>SLO/Competencies</legend>
									<%
										try{
											String comp = getCompsAsHTMLOptionsByKix(conn,kix);
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
								<fieldset class="FIELDSET280">
									<legend>Assessment</legend>
									<%
										try{
											String assessment = getAssessmentsAsCheckBox(conn,campus,kix,4779);
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
						<tr >
							 <td class="textblackTHCenter" colspan="2">
									<input type="submit" name="aseSubmit" value="Add" class="inputsmallgray" onClick="return validateForm('a')">
									<input type="submit" name="aseRemove" value="Remove" class="inputsmallgray" onClick="return validateForm('r')">
									<input type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return cancelForm()">
							 </td>
						</tr>
					</table>

<%!

	/*
	 * getCompsAsHTMLOptionsByKix
	 *	<p>
	 * @return String
	 */
	public static String getCompsAsHTMLOptionsByKix(Connection connection,String kix) throws Exception {

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
				buf.append("<tr><td valign=\"top\" width=\"2%\"><input onClick=\"return reLoadPage('"+kix+"',"+id+");\" type=\"radio\" name=\"compGroup\" value=\"" + id + "\"></td>" +
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
					+ "<input type=hidden value=\'" + kix + "\' name=kix>"
					+ "<input type=hidden value=\'" + campus + "\' name=campus>"
					+ "<input type=hidden value=\'" + compid + "\' name=compid>"
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