<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rptinix.jsp - system value report
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";

	String formName = website.getRequestParameter(request,"formName");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String message = "";
	String pageTitle = "System Value Report";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"bFilter": true,
				"bSortClasses": false,
				"bLengthChange": true,
				"bPaginate": true,
				"bInfo": false
			});
		});
	</script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (formName != null && formName.equals("aseForm")){

		String category = website.getRequestParameter(request,"category", "");
		String formValues = website.getRequestParameter(request,"formValue","");

		String selectedValues = "";

		if (formValues != null && formValues.length() > 0){
			String[] aFormValues = formValues.split(",");
			for (int i=0; i<aFormValues.length; i++){
				String temp = website.getRequestParameter(request,"chk_"+aFormValues[i],"");
				if (temp != null && temp.length() > 0){
					if (selectedValues.equals(Constant.BLANK))
						selectedValues = aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);
					else
						selectedValues += "," + aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);
				}	// if temp
			}	// for
		} // formValues

		%>
		  <div id="container90">
				<div id="demo_jui">
					<p>
					<font class="textblackth">Category:</font> <font class="datacolumn"><%=category%></font>;
					<font class="textblackth">Selected Values:</font> <font class="datacolumn"><%=selectedValues%></font>
					</p>
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">Outline </th>
								  <th align="left">Progress</th>
								  <th align="left">Title</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic g: com.ase.aseutil.IniDB.systemListUsage(conn,campus,category,formValues,request)){ %>
							  <tr>
								 <td><a href="vwcrsy.jsp?pf=1&kix=<%=g.getString4()%>&comp=0" target="_blank" title="view outline" class="linkcolumn"><%=g.getString1()%></a></td>
								 <td><%=g.getString2()%></td>
								 <td><%=g.getString3()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>
			 </div>
		  </div>
		<%

	} // valid form

	asePool.freeConnection(conn,"rptinix",user);

	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>

<p align="middle"><a href="rptini.jsp" class="linkcolumn">run another system value report</a></p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

