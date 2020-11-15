<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassrpt2.jsp
	*	2007.09.01	select competencies given the outline
	**/
%>

<br>
<form>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="15%">Select Assessment:&nbsp;</td>
			<td width="85%">
				<%
					/*
						q comes in as alpha_num or ICS_218
						need to break it down to individual components
					*/

					String campus = website.getRequestParameter(request,"aseCampus","",true);
					String alpha = "";
					String num = "";
					String temp = "";
					String alphanum = "";
					String q = website.getRequestParameter(request,"q","");

					if ( q.length() > 0 ){
						// get compid
						int n = q.indexOf("_");
						alpha = q.substring(0,n);

						// remainder is num
						num = q.substring(n+1);
						alphanum = alpha + "_" + num;
					}

				%>
				<select class="smalltext" name="crsassrpt12" onchange="showAjax(this.value,13)">
					<option value=''></option>
					<option value='0_<%=alphanum%>'>All</option>
					<%
						try{
							StringBuffer buf = AssessDB.getAssessmentsByAlphaNumAsHTML(conn,campus,alpha,num);
							if ( buf != null )
								out.println(buf.toString());
						}
						catch (Exception e){
							out.println( e.toString() );
						}
						finally{
							asePool.freeConnection(conn);
						}
					%>
				</select>
			</td>
		</tr>
	</table>
</form>
