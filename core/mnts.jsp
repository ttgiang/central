<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	mnts.jsp - meeting minutes
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String minutes = website.getRequestParameter(request,"minutes","");

	if(!minutes.equals(Constant.BLANK)){

		String attendees = website.getRequestParameter(request,"attendees","");
		String recordedBy = website.getRequestParameter(request,"recordedBy","");
		String minutesDate = website.getRequestParameter(request,"minutesDate","");

		if(recordedBy.equals(Constant.BLANK)){
			recordedBy = user;
		}

		if(minutesDate.equals(Constant.BLANK)){
			minutesDate = AseUtil.getCurrentDateTimeString();
		}

		com.ase.aseutil.util.Minutes mins = new com.ase.aseutil.util.Minutes();
		mins.setUserid(recordedBy);
		mins.setDte(minutesDate);
		mins.setAttendees(attendees);
		mins.setMinutes(minutes);
		com.ase.aseutil.util.MinutesDB minsDB = new com.ase.aseutil.util.MinutesDB();
		minsDB.insert(conn,mins);
		mins = null;
		minsDB = null;

		// clear by redirect
		response.sendRedirect("mnts.jsp");
	}

	String pageTitle = "Curriculum Central Meeting Mintues";

	fieldsetTitle = pageTitle;

	// for popup modal box
	// 1) include ./js/modal/modalnews.jsp
	// 2) write links for each item with #dialog[ID]
	// 3) call writeModalDivs(conn,campus,"") after data has been rendered
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

 	<!-- 	#1 for create modal popups -->
	<%@ include file="./js/modal/modalnews.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true
			});
		});
	</script>

	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">Date</th>
							  <th align="left">Recorded By</th>
							  <th align="left">Attendees</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Generic g: com.ase.aseutil.util.MinutesDB.getMinutes(conn)){ %>
					  <tr>
					  	<!-- 	#2 for create modal popups -->
						 <td align="left"><a href="#dialog<%=g.getString1()%>" name="modal" class="linkcolumn"><%=g.getString4()%></a></td>
						 <td align="left"><%=g.getString2()%></td>
						 <td align="left"><%=g.getString3()%></td>
					  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>

		<form method="post" name="aseForm" action="?">
			<table width="100%" border="0">
				<tr>
					 <td width="10%" class="textblackTH">Recorded By:&nbsp;</td>
					 <td><input type="text" name="recordedBy" id="recordedBy" size="120" class="input" value="<%=user%>"></td>
					 <td width="20%">&nbsp;</td>
				</tr>
				<tr>
					 <td width="10%" class="textblackTH">Date:&nbsp;</td>
					 <td><input type="text" name="minutesDate" id="minutesDate" size="120" class="input" value="<% out.println(AseUtil.getCurrentDateTimeString()); %>"></td>
					 <td width="20%">&nbsp;</td>
				</tr>
				<tr>
					 <td width="10%" class="textblackTH">Attendees:&nbsp;</td>
					 <td><input type="text" name="attendees" id="attendees" size="120" class="input" value="JOANNE, WILLIAM, RYAN, MYRTLE, KATHLEN, RUSSELL, KEVIN, SUSAN, KAHELE, APRIL, THANH"></td>
					 <td width="20%">&nbsp;</td>
				</tr>
				<tr>
					 <td width="10%" class="textblackTH">Minutes:&nbsp;</td>
					 <td>
						<textarea cols="80" id="minutes" name="minutes" rows="10"></textarea>
						<script type="text/javascript">
							//<![CDATA[
								CKEDITOR.replace( 'minutes',
									{
										toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
													],
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode: CKEDITOR.ENTER_P
									});
							//]]>
							</script>
					</td>
					 <td width="20%">&nbsp;</td>
				</tr>
				<tr>
					<td width="10%">&nbsp;</td>
					<td colspan="2">
						<input type="submit" name="aseSubmit" value="Submit" class="inputsmallgray">
					</td>
				</tr>
			</table>
		</form>

<%
	}

	// #3 for create modal popups
	String sql = aseUtil.getPropertySQL(session,"modalMinutes" );
	out.println(com.ase.aseutil.util.Modal.writeModalDivs(conn,campus,user,sql));

	asePool.freeConnection(conn,"mnts",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

