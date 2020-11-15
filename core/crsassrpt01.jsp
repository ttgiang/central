<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassrpt1.jsp
	*	2007.09.01	returns all outlines containing selected assessment
	**/
%>

<br>
<form>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="15%">Select Outline:&nbsp;</td>
			<td width="85%">
				<select class="smalltext" name="crsassrpt01" onchange="showAjax(this.value,2)">
					<option value=''></option>
					<%
						try{
							String q = website.getRequestParameter(request,"q","");
							String campus = website.getRequestParameter(request,"aseCampus","",true);
							String temp = "";
							String temp2 = "";
							ArrayList list = CompDB.getCompsByID(conn,campus,q);
							if ( list != null ){
								Comp comp;
								for ( int i=0; i<list.size(); i++){
									comp = (Comp)list.get(i);
									temp = comp.getAlpha();
									temp2 = q + "_" + temp.replace(" ", "_");
									%>
										<option value="<%=temp2%>"><%=temp%></option>
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
