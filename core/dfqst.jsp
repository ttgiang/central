<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dfqst.jsp
	*
	*	2009.04.10	turned of ability to update on this form
	*	2007.09.01	define questions
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","dfqst");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "";

	/*
		r = course questions
		c = campus questions
		p = program questions
	*/

	String questionType = website.getRequestParameter(request,"t","r");
	int currentTab = 1;

	String prop = "";
	String view = "";

	if (questionType.equals(Constant.TABLE_COURSE) ){
		pageTitle = "Outline Question Listing";
		prop = "tblCourseQuestions4";
		view = "vw_CourseItems";
		session.setAttribute("aseReport","courseItems");
		currentTab = 1;
	}
	else if (questionType.equals(Constant.TABLE_CAMPUS)){
		pageTitle = "Campus Question Listing";
		prop = "tblCampusQuestions3";
		view = "vw_CampusItems";
		session.setAttribute("aseReport","courseItems");
		currentTab = 2;
	}
	else if (questionType.equals(Constant.TABLE_PROGRAM)){
		pageTitle = "Program Question Listing";
		prop = "tblProgramQuestions2";
		view = "vw_programitems";
		session.setAttribute("aseReport","programItems");
		currentTab = 0;
	}

	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/itemmaintenance.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dfqst.js"></script>

	<%@ include file="datatables.jsp" %>

	<script type="text/javascript">

		/* Note 'unshift' does not work in IE6. A simply array concatenation would. This is used
		 * to give the custom type top priority
		 */
		jQuery.fn.dataTableExt.aTypes.unshift(
			 function ( sData )
			 {
				  var sValidChars = "0123456789-,";
				  var Char;
				  var bDecimal = false;

				  /* Check the numeric part */
				  for ( i=0 ; i<sData.length ; i++ )
				  {
						Char = sData.charAt(i);
						if (sValidChars.indexOf(Char) == -1)
						{
							 return null;
						}

						/* Only allowed one decimal place... */
						if ( Char == "," )
						{
							 if ( bDecimal )
							 {
								  return null;
							 }
							 bDecimal = true;
						}
				  }

				  return 'numeric-comma';
			 }
		);

		jQuery.fn.dataTableExt.oSort['numeric-comma-asc']  = function(a,b) {
			 var x = (a == "-") ? 0 : a.replace( /,/, "." );
			 var y = (b == "-") ? 0 : b.replace( /,/, "." );
			 x = parseFloat( x );
			 y = parseFloat( y );
			 return ((x < y) ? -1 : ((x > y) ?  1 : 0));
		};

		jQuery.fn.dataTableExt.oSort['numeric-comma-desc'] = function(a,b) {
			 var x = (a == "-") ? 0 : a.replace( /,/, "." );
			 var y = (b == "-") ? 0 : b.replace( /,/, "." );
			 x = parseFloat( x );
			 y = parseFloat( y );
			 return ((x < y) ?  1 : ((x > y) ? -1 : 0));
		};

		$(document).ready(function () {

			oTable = $('#jquery').dataTable({
						"bJQueryUI": true,
						"bPaginate": false,
						"iDisplayLength": 999,
						"bSort": true,
						"aoColumns": [
							{ "sType": "numeric-comma" },
							null,
							null,
							null,
							null,
							null,
							null,
							null,
							null,
							null
					]
			 });

		}); // main

	</script>
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		String included = website.getRequestParameter(request,"i","");
%>
			<a href="?t=<%=questionType%>&i=" class="linkcolumn">show all items</a>&nbsp;|
			<a href="?t=<%=questionType%>&i=Y" class="linkcolumn">hide excluded items</a>&nbsp;|
		<%
			if (user.equals("THANHG")){
		%>
			<a href="crsmode.jsp" class="linkcolumn">maintain process</a>&nbsp;|
		<%
			}
		%>
			<a href="/central/servlet/progress?t=<%=questionType%>" class="linkcolumn" target="_blank">print items</a>

	  <div id="container">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">Seq</th>
							  <th align="left">Question</th>
							  <th align="left">Type</th>
							  <th align="left">Include</th>
							  <th align="left">Required</th>
							  <th align="left">Comments</th>
							  <th align="left">Length</th>
							  <th align="left">Count</th>
							  <th align="left">Extra</th>
							  <th align="left">Friendly Name</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.CCCM6100 o: com.ase.aseutil.CCCM6100DB.getQuestions(conn,campus,view,included)){ %>
						  <tr id="<%=o.getId()%>">
							 <td><a href="/central/core/dfqstx.jsp?code=c&t=<%=questionType%>&lid=<%=o.getId()%>" class="linkcolumn"><%=o.getQuestionSeq()%></a></td>
							 <td><%=o.getCCCM6100()%></td>
							 <td><%=o.getQuestion_Type()%></td>
							 <td><%=o.getInclude()%></td>
							 <td><%=o.getRequired()%></td>
							 <td><%=o.getComments()%></td>
							 <td><%=o.getUserLen()%></td>
							 <td><%=o.getCounter()%></td>
							 <td><%=o.getExtra()%></td>
							 <td><%=o.getQuestion_Friendly()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	} // processPage

	asePool.freeConnection(conn,"dfqst",user);
%>

<%@ include file="../inc/footer.jsp" %>


</body>
</html>



