	<div class="bs-example">
		<div class="panel panel-primary">
        <div class="panel-heading alignleft">
          <h3 class="panel-title">Attached Documents</h3>
        </div>
        <div class="panel-body">
			<table class="table">
			  <thead>
				 <tr>
					<th></th>
					<th></th>
					<th>Document</th>
					<th>Item</th>
					<th>User</th>
					<th>Date</th>
				 </tr>
			  </thead>
			  <tbody class="table">
				<%
					for(com.ase.aseutil.Generic u: fnd.getAttachmentsMaster(conn,campus,id)){

						int seq = NumericUtil.getInt(u.getString1(),0);

						String fileName = u.getString2();

						String extension = AseUtil2.getFileExtension(fileName);

						String s_sq = u.getString6();
						String s_en = u.getString7();
						String s_qn = u.getString8();

						String question = "";

						if(!s_sq.equals("0") && !s_sq.equals("")){
							question = "ITEM: " + s_sq + "; EN: " + s_en;
							if(!s_qn.equals("0") && !s_qn.equals("")){
								question += "; QN: " + s_qn;
							}
						}

						if (!(Constant.FILE_EXTENSIONS).contains(extension)){
							extension = "default.icon";
						}
				%>
						<tr>
							<td><a href="/centraldocs/docs/fnd/<%=campus%>/<%=u.getString5()%>" target="_blank"><img src="/central/images/ext/<%=extension%>.gif" border="0"></a>&nbsp;</td>
							<td>&nbsp;</td>
							<td><%=fileName%></td>
							<td><%=question%></td>
							<td><%=u.getString3()%></td>
							<td><%=u.getString4()%></td>
							</tr>
				<%
						for(com.ase.aseutil.Generic v: fnd.getAttachmentsDetail(conn,campus,id,seq,fileName)){

							if(!s_sq.equals("0") && !s_sq.equals("")){
								question = "ITEM: " + s_sq + "; EN: " + s_en;
								if(!s_qn.equals("0") && !s_qn.equals("")){
									question += "; QN: " + s_qn;
								}
							}

						%>
							<tr>
								<td>&nbsp;</td>
								<td><a href="/centraldocs/docs/fnd/<%=campus%>/<%=v.getString5()%>" target="_blank"><img src="/central/images/ext/<%=extension%>.gif" border="0" title="view previously attached document" id="view previously attached document"></a>&nbsp;</td>
								<td><%=fileName%>&nbsp;</td>
								<td><%=question%></td>
								<td><%=v.getString3()%>&nbsp;</td>
								<td><%=v.getString4()%>&nbsp;</td>
							</tr>
						<%
						} // for v
					} // for u
				%>

				  </tbody>
				</table>
        </div>
      </div>
	</div>
