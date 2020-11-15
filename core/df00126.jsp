<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "DF00126";
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
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"],[1, "asc"],[2, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<div id="container90">
	<div id="demo_jui">
	  <table id="jquery" class="display">
			<thead>
				 <tr>
					  <th align="left">Campus</th>
					  <th align="left">Alpha</th>
					  <th align="left">Num</th>
					  <th align="left">cProgress</th>
					  <th align="left">pProgress</th>
					  <th align="left">cAuditDate</th>
					  <th align="left">cCourseDate</th>
				 </tr>
			</thead>
			<tbody>
<%
	/**
	*	ASE
	*	df00001.jsp
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		com.ase.aseutil.df.DF00126.populateTables(conn);

		paging = null;

		for(com.ase.aseutil.Generic g: com.ase.aseutil.df.DF00126.getData(conn)){

			String link = "crscmprx.jsp?ks="+g.getString8()+"&kd="+g.getString9();

		%>
			<tr>
				<td><a href="<%=link%>" target="_blank" class="linkcolumn" alt="compare outline" title="compare outline"><%=g.getString1()%></a></td>
				<td><%=g.getString2()%></td>
				<td><%=g.getString3()%></td>
				<td><%=g.getString4()%></td>
				<td><%=g.getString5()%></td>
				<td><%=g.getString6()%></td>
				<td><%=g.getString7()%></td>
			</tr>
		<%

		} // for

	} // if

	asePool.freeConnection(conn,"df00126",user);
%>

					</tbody>
			  </table>
		 </div>
	  </div>

<%!

	/**
	 * saveThisCode - original code to correct progress
	 * <p>
	 */
	private static void saveThisCode() throws Exception {
		/*

		try{

			out.println("Collects data from courses where approved courses are not "
				+ "set to APPROVE progress. This process corrects the problem by " + Html.BR()
				+ "pulling together all occurences where TYPE='CUR' and PROGRESS <> 'APPROVED'." + Html.BR()  + Html.BR()
				+ "<strong>Click</strong> the outline to move from current to archive or click <a href=\"?\" class=\"linkcolumn\">here</a> to refresh page." + Html.BR()  + Html.BR());

			com.ase.aseutil.df.DF00126 df126 = new com.ase.aseutil.df.DF00126();

			//
			// process if kix exists
			//
			String kix = website.getRequestParameter(request,"kix","");
			if(kix != null && kix.length() > 0){

				String[] info = helper.getKixInfo(conn,kix);
				String kalpha = info[Constant.KIX_ALPHA];
				String knum = info[Constant.KIX_NUM];
				String ktype = info[Constant.KIX_TYPE];
				String kcampus = info[Constant.KIX_CAMPUS];

				// move entry to archived table
				com.ase.aseutil.CourseCurrentToArchive cca = new com.ase.aseutil.CourseCurrentToArchive();
				msg = cca.moveCurrentToArchived(conn,kcampus,kalpha,knum,user);
				cca = null;

				out.println("Msg: " + aseUtil.nullToBlank(msg.getErrorLog()) + Html.BR() + Html.BR());

				// clear from temp table
				int rowAffected = df126.df00126_DeleteRow(conn,kix);

			}
			else{
				out.println(df126.df00126(conn) + "<br>remaining data to manually adjust.<br>");
			}

			hc = null;

		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}

		String sql = aseUtil.getPropertySQL(session,"df00126");
		if ( sql != null && sql.length() > 0 ){
			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			jqPaging.setUrlKeyName("kix");
			out.println(jqPaging.showTable(conn,sql,"/central/core/df00126.jsp"));
			jqPaging = null;
		}

		*/

	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>