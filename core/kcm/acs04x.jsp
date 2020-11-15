      <div class="bs-example">
			<div class="panel panel-primary">
			  <div class="panel-heading">
					CI - Course Information&nbsp;|&nbsp;
					GV - Governance&nbsp;|&nbsp;
					CL - Course Logistics&nbsp;|&nbsp;
					LO - Learning Objectives&nbsp;|&nbsp;
					CR - Course Requisites&nbsp;|&nbsp;
					AD - Active Dates&nbsp;|&nbsp;
					FI - Financials<br/>
					AC - Authors & Collaborators&nbsp;|&nbsp;
					SD - Supporting Documents&nbsp;|&nbsp;
					CS - Campus
					<br/><br/>
					*Orange numbered rows designate proposed verbiage
			  </div>
			  <div class="panel-body">
				<table class="table">
				 <thead>
					<tr>
						<th>#</th>
						<th>CCCM Verbiage<font color="#E87B10">*</font></th>
						<th width="05%">HAW</th>
						<th width="05%">HIL</th>
						<th width="05%">HON</th>
						<th width="05%">KAP</th>
						<th width="05%">KAU</th>
						<th width="05%">LEE</th>
						<th width="05%">MAN</th>
						<th width="05%">UHMC</th>
						<th width="05%">WIN</th>
						<th width="05%">WOA</th>
					</tr>
				 </thead>
				 <tbody>
				 <%

					String[] campuses = "HAW,HIL,HON,KAP,KAU,LEE,MAN,UHMC,WIN,WOA".split(",");
					int[] counters = new int[10];

					int i = 1;

					try {

						String junk = "";
						String section = "";
						boolean hasContents = false;

						for(int j = 0; j < 2; j++){

							if(j == 0){
								sql = "SELECT DISTINCT vw.Question_Number as qn, vw.Question_Friendly as friendly, CAST(cccm.CCCM6100 AS varchar(500)) AS question, CAST(cccm.kscm AS varchar(500)) AS kscm "
									+ "FROM vw_coursequestions vw INNER JOIN CCCM6100 cccm ON vw.Question_Number = cccm.Question_Number AND vw.Question_Friendly = cccm.Question_Friendly";
								ps = conn.prepareStatement(sql);
							}
							else{
								sql = "SELECT 0 as qn, ks.friendly, ks.section, vw.question, '' as kscm "
									+ "FROM kcm_section ks INNER JOIN vw_CampusQuestions vw ON ks.campus = vw.campus AND ks.friendly = vw.Question_Friendly "
									+ "WHERE (ks.campus =?) AND (ks.type = 'campus')";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
							}

							rs = ps.executeQuery();
							while(rs.next()){

								String cccm = "cccm";
								String cccmx = "cccm";

								String kscm = AseUtil.nullToBlank(rs.getString("kscm"));
								String friendly = AseUtil.nullToBlank(rs.getString("friendly"));
								String question = AseUtil.nullToBlank(rs.getString("question")) + " ("+friendly+")";

								if(!kscm.equals("")){
									question = kscm;
									cccm = "kscm";
									cccmx = "kscmx";
								}

								int qn = rs.getInt("qn");

								if(j==0){
									int counter = inUse(conn,qn);

									if(counter > 0){

										hasContents = false;

										junk = "<tr>"
											+ "<td class=\"class-"+cccmx+"\">" + i + "</td>"
											+ "<td class=\"class-"+cccm+"\">" + question + "</td>";

										for(int k=0; k<campuses.length; k++){

											String course = getCourseQuestion(conn,campuses[k],friendly);
											if(!course.equals("")){
												course = campuses[k] + " - " + course;
												course = course
															.replace("\"","")
															.replace("\'","")
															.replace("<br>","\n")
															.replace("<br/>","\n")
															.replace("</br>","\n");
											}

											section = getSection(conn,campuses[k],friendly);
											if(!section.equals("")){
												++counters[k];
												hasContents = true;
											}

											junk = junk + "<td tooltip-append-to-body=\"true\" class=\"class-"+section+"\" tooltip=\""+course+"\">" + section + "</td>";
										}

										junk = junk + "</tr>";

										if(hasContents){
											out.println(junk);
										}
									} // counter
								}
								else{

									section = AseUtil.nullToBlank(rs.getString("section"));
									if(!section.equals("")){

										if(campus.equals("HAW")){
											++counters[0];
										}
										else if(campus.equals("HIL")){
											++counters[1];
										}
										else if(campus.equals("HON")){
											++counters[2];
										}
										else if(campus.equals("KAP")){
											++counters[3];
										}
										else if(campus.equals("KAU")){
											++counters[4];
										}
										else if(campus.equals("LEE")){
											++counters[5];
										}
										else if(campus.equals("MAN")){
											++counters[6];
										}
										else if(campus.equals("UHMC")){
											++counters[7];
										}
										else if(campus.equals("WIN")){
											++counters[8];
										}
										else {
											++counters[9];
										}

										hasContents = true;
									}

									junk = "<tr>"
										+ "<td>" + i + "</td>"
										+ "<td>" + question + "</td>";

									for(int k=0; k<campuses.length; k++){
										if(campus.equals(campuses[k])){
											junk = junk + "<td class=\"class-"+section+"\">" + section + "</td>";
										}
										else{
											junk = junk + "<td></td>";
										}
									}

									junk = junk + "</tr>";

									if(hasContents){
										out.println(junk);
									}

								}
								// j

								if(hasContents){
									++i;
								}

							}
							rs.close();
							ps.close();

							if(j == 0){
							%>
								<tr class="class-gray">
									<th>#</th>
									<th>CCCM Verbiage</th>
									<th width="05%">HAW<br><%=counters[0]%></th>
									<th width="05%">HIL<br><%=counters[1]%></th>
									<th width="05%">HON<br><%=counters[2]%></th>
									<th width="05%">KAP<br><%=counters[3]%></th>
									<th width="05%">KAU<br><%=counters[4]%></th>
									<th width="05%">LEE<br><%=counters[5]%></th>
									<th width="05%">MAN<br><%=counters[6]%></th>
									<th width="05%">UHMC<br><%=counters[7]%></th>
									<th width="05%">WIN<br><%=counters[8]%></th>
									<th width="05%">WOA<br><%=counters[9]%></th>
								</tr>
							<%
							}

						} // for j

						rs = null;
						ps = null;

					} catch (SQLException e) {
						System.out.println("acs01: " + e.toString());
					} catch (Exception e) {
						System.out.println("acs01: " + e.toString());
					}

				 %>
				 </tbody>
				 <tfoot>
					<tr>
						<th>#</th>
						<th>Question</th>
						<%
							for(int k=0; k<campuses.length; k++){
								if(campus.equals(campuses[k])){
								%>
									<th width="05%"><%=campus%><br><%=counters[k]%></th>
								<%
								}
								else{
								%>
									<th width="05%"></th>
								<%
								}
							}
						%>
					</tr>
				 </tfoot>
			  </table>
			  </div>
			</div>
      </div>
