<%@ include file="ase.jsp" %>

<%
	String pageTitle = "";
%>

<%@ include file="ase2.jsp" %>

<%
		String campus = Util.getSessionMappedKey(session,"aseCampus");
		String user = Util.getSessionMappedKey(session,"aseUserName");
		String c = website.getRequestParameter(request,"c","");
		String a = website.getRequestParameter(request,"a","");
		String n = website.getRequestParameter(request,"n","");

		String t = website.getRequestParameter(request,"t","");

		String results = HistoryDB.getHistoryIDs(conn,c,a,n,t);

		if(results != null && results.length() > 0){

			String[] aResults = results.split(",");

			for(int i = 0; i < aResults.length; i++){

				String kix = aResults[i];

				String title = "Archived: " + courseDB.getCourseDate(conn,campus,kix,t);

				ArrayList list = null;
%>
				<fieldset class="FIELDSETYELLOW">
					<legend><%=title%></legend>
						<table border="0" cellpadding="2" width="100%">
							<%
								list = HistoryDB.getHistories(conn,kix,t);
								if (list != null){
									History history;
									for (int j=0; j<list.size(); j++){
										history = (History)list.get(j);
										out.println("<tr><td valign=\"top\" class=\"textblackTH\">" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
										out.println("<tr><td valign=\"top\" class=\"datacolumn\">" + history.getComments() + "</td></tr>" );
									}
									history = null;
								}
							%>
						</table>
				</fieldset>

				<br>

<%
			} // for i
%>
			<p>&nbsp;</p><p><a href="##" class="linkcolumn" onClick="return lessHistory();">&nbsp;hide archived history</a></p>
<%
		}
		else{
			out.println("no data available");
		}
		// results

%>
