<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	prtpst.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "";
	String pageTitle = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int fid = website.getRequestParameter(request,"fid",0);
	int itm = website.getRequestParameter(request,"itm",0);

	if (processPage){
%>

<p>

<table width="100%" class="mystyle">
	<tbody>
		<%
			int i = 0;

			String clss = "";

			for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPostedItem(conn,fid,itm)){

				if (i % 2 == 0){
					clss = "rankline1";
				}
				else{
					clss = "rankline2";
				}

				++i;

				int mid = Integer.parseInt(u.getString4());

		%>
			<tr class="<%=clss%>">
				<td>
					<%
						out.println(Board.printChildren(conn,fid,itm,0,0,mid,user));
					%>
				</td>
			</tr>
		<%
			} // for
		%>
	</tbody>
</table>

</p>

<%
	}

	asePool.freeConnection(conn,"prtpst",user);
%>