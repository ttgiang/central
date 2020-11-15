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
				<select class="smalltext" name="crsassrpt11" onchange="showAjax(this.value,12)">
					<option value=''></option>
					<%
						try{
							String q = website.getRequestParameter(request,"q","");
							String campus = website.getRequestParameter(request,"aseCampus","",true);
							String alpha = "";
							String num = "";
							String temp = "";
							String temp2 = "";

							ArrayList list = CompDB.getCompsByTypeCampusID(conn,campus,q);
							if ( list != null ){
								Comp comp;
								for (int i=0;i<list.size();i++){
									comp = (Comp)list.get(i);
									alpha = comp.getAlpha().replace(" ","");
									num = comp.getNum().replace(" ","");
									temp = alpha + " " + num;
									temp2 = alpha + "_" + num;
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
