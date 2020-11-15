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
			<td width="15%">Select Compentency:&nbsp;</td>
			<td width="85%">
				<%
					/*
						q comes in as compid_alpha_num or 2_ICS_218
						need to break it down to individual components
					*/

					String compid = "";
					String alpha = "";
					String num = "";
					String campus = "";
					String q = website.getRequestParameter(request,"q","");

					if ( q.length() > 0 ){
						// get compid
						int n = q.indexOf("_");
						compid = q.substring(0,n);

						// advance to point after first _
						q = q.substring(n+1);
						n = q.indexOf("_");
						alpha = q.substring(0,n);

						// remainder is num
						num = q.substring(n+1);

						campus = website.getRequestParameter(request,"aseCampus","",true);
					}

				%>
				<select class="smalltext" name="crsassrpt02">
					<option value=''></option>
					<%
						try{
							ArrayList list = CompDB.getCompsByAlphaNumID(conn,alpha,num,campus,compid);
							if ( list != null ){
								Comp comp;
								for (int i=0; i<list.size(); i++){
									comp = (Comp)list.get(i);
									%>
										<option value="<%=comp.getID()%>"><%=comp.getComp()%></option>
									<%
								}
							}
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
