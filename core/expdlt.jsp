<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	expdlt.jsp	- expedited delete process
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int showLink = website.getRequestParameter(request,"lnk",1);

	String pageTitle = "Expedited Delete Process";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#jquery0").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true,
				 "aaSorting": [ [1,'asc'] ],
				"aoColumns": [
				{ sWidth: '15%' },
				{ sWidth: '15%' },
				{ sWidth: '40%' },
				{ sWidth: '15%' },
				{ sWidth: '15%' } ]

			});

			$("#jquery1").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true,
				 "aaSorting": [ [1,'asc'] ],
				"aoColumns": [
				{ sWidth: '15%' },
				{ sWidth: '15%' },
				{ sWidth: '40%' },
				{ sWidth: '15%' },
				{ sWidth: '15%' } ]
			});

		});
	</script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if(showLink==1){
%>
		<p align="left">Instructions:<br><br>Outlines listed below are going through the normal course approval process where reasons for modifications is 'Delete' (ReasonsForMods = Delete in <a href="ini.jsp?category=ReasonsForMods" class="linkcolumn">system settings</a>).
		Select an APPROVED outline then follow the on screen instructions to finalize the delete process. Keep in mind that Curriculum Central (CC) does not a deleted outline from the system. All outline data is moved
		to the archive.
		</p>
<%
	}
	else{
%>
		<p align="left">Outlines listed below are going through the normal course approval process where reasons for modifications is 'Delete' (ReasonsForMods = Delete in <a href="ini.jsp?category=ReasonsForMods" class="linkcolumn">system settings</a>).
		</p>
<%
	}
%>

<%
	if (processPage){
%>
	  <div id="container90">
			<div id="demo_jui">

				<%
					for(int i = 0; i < 2; i++){

						String type = Constant.CUR;
						String dateField = "Approved Date";
						String progress = "Approved Outlines";

						if(i==1){
							type = Constant.PRE;
							dateField = "Last Modified";
							progress = "Modified Outlines";
						}
				%>
						<fieldset class="FIELDSET96">
						<span align="left"><legend><font color="#000"><%=progress%></font></legend></span>
						  <table id="jquery<%=i%>" class="display">
								<thead>
									 <tr>
										  <th align="left">Outline</th>
										  <th align="left">Proposer</th>
										  <th align="left">Title</th>
										  <th align="left"><%=dateField%></th>
										  <th align="left">Term</th>
									 </tr>
								</thead>
								<tbody>
									<%
										for(com.ase.aseutil.Generic g: Outlines.getOutlinesForExpeditedDeletes(conn,campus,type)){
									%>
									  <tr>
										 <td>
											<%
												if(showLink==1 && type.equals(Constant.CUR)){
											%>
													<a href="expdltx.jsp?kix=<%=g.getString6()%>" class="linkcolumn" alt="expediate delete" title="expediate delete"><%=g.getString1()%>&nbsp;<%=g.getString2()%></a>
											<%
												}
												else{
											%>
													<%=g.getString1()%>&nbsp;<%=g.getString2()%>
											<%
												}
											%>
										 </td>
										 <td><%=g.getString4()%></td>
										 <td><%=g.getString3()%></td>
										 <td><%=g.getString5()%></td>
										 <td><%=g.getString7()%></td>
									  </tr>
								<% } %>
								</tbody>
						  </table>
						 </fieldset>
						 <br/>

				<%
					} // for
				%>

		 </div>
	  </div>
<%

	} // processPage

	asePool.freeConnection(conn,"expdlt",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

