<%@ include file="./acs00.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>KCM - Question Grouping - STEP 1</title>

    <!-- Bootstrap core CSS -->
    <link href="../bs-dist/css/bootstrap.css" rel="stylesheet">

	<style type="text/css">

		.container {
			max-width: 100%;
		}

		.form-group {
			width: 100%;
		}
		.col-sm-4 {
			width: 100%;
		}

		.lead14 {
			font-size: 14px;
		}

		.badge {
			display: inline-block;
			min-width: 10px;
			padding: 3px 7px;
			font-size: 12px;
			font-weight: bold;
			line-height: 1;
			color: white;
			text-align: center;
			white-space: nowrap;
			vertical-align: baseline;
			background-color: #E87B10;
			border-radius: 10px;
		}

		.text-muted {
			font-size: 24px;
			color: #999;
		}


		.table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
			padding: 20px;
			line-height: 1.428571429;
			vertical-align: top;
			border-top: 1px solid #DDD;
			border-right: 1px solid #DDD;
		}

		a:visited {TEXT-DECORATION: none;}
		a:hover {COLOR: #E87B10; TEXT-DECORATION: none; }

	</style>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
    <div class="container">
      <div class="header">
        <a href="../index.jsp"><span class="glyphicon glyphicon-home"></span></a>&nbsp;&nbsp;<font class="text-muted"><a href="acs01.jsp">KCM - Question Grouping - STEP 1</a></font>
      </div>

      <div class="bs-example">
		  <form class="navbar-form navbar-right" method="post" role="search" name="frmMain" action="acs01x.jsp">
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
				  </div>
				  <div class="panel-body">
					<table class="table">
					 <thead>
						<tr>
							<th>#</th>
							<th>Question</th>
							<!--
							<th>Course<br>Information</th>
							<th>Governance</th>
							<th>Course<br>Logistics</th>
							<th>Learning<br>Objectives</th>
							<th>Course<br>Requisites</th>
							<th>Active<br>Dates</th>
							<th>Financials</th>
							<th>Authors<br>Collaborators</th>
							<th>Supporting<br>Documents</th>
							-->
							<th width="05%">CI</th>
							<th width="05%">GV</th>
							<th width="05%">CL</th>
							<th width="05%">LO</th>
							<th width="05%">CR</th>
							<th width="05%">AD</th>
							<th width="05%">FI</th>
							<th width="05%">AC</th>
							<th width="05%">SD</th>
							<th width="05%">CS</th>
						</tr>
					 </thead>
					 <tbody>
					 <%

						int i = 1;

						String[] aChecked = "0,0,0,0,0,0,0,0,0,0".split(",");

						try {

							for(int j = 0; j < 2; j++){

								String table = "vw_CourseQuestions";

								if(j > 0){
									table = "vw_CampusQuestions";
								}

								sql = "SELECT question, Question_Friendly as friendly from " + table + " where campus=? order by questionseq";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								rs = ps.executeQuery();
								while(rs.next()){

									String question = AseUtil.nullToBlank(rs.getString("question"));

									String friendly = AseUtil.nullToBlank(rs.getString("friendly"));

									String section = getSection(conn,campus,i);

									aChecked[0] = "";
									aChecked[1] = "";
									aChecked[2] = "";
									aChecked[3] = "";
									aChecked[4] = "";
									aChecked[5] = "";
									aChecked[6] = "";
									aChecked[7] = "";
									aChecked[8] = "";
									aChecked[9] = "";

									if(section.equals("CI")){
										aChecked[0] = "checked";
									}
									else if(section.equals("GV")){
										aChecked[1] = "checked";
									}
									else if(section.equals("CL")){
										aChecked[2] = "checked";
									}
									else if(section.equals("LO")){
										aChecked[3] = "checked";
									}
									else if(section.equals("CR")){
										aChecked[4] = "checked";
									}
									else if(section.equals("AD")){
										aChecked[5] = "checked";
									}
									else if(section.equals("FI")){
										aChecked[6] = "checked";
									}
									else if(section.equals("AC")){
										aChecked[7] = "checked";
									}
									else if(section.equals("SD")){
										aChecked[8] = "checked";
									}
									else {
										aChecked[9] = "checked";
									}

									out.println("<tr>"
										+ "<td>" + i + "</td>"
										+ "<td>" + question + "</td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[0] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"0_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[1] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"1_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[2] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"2_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[3] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"3_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[4] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"4_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[5] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"5_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[6] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"6_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[7] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"7_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[8] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"8_"+friendly+"\"></td>"
										+ "<td><input type=\"radio\" width=\"5%\"" + aChecked[9] + " name=\"ck_"+i+"\" id=\"ck_"+i+"\"value=\"9_"+friendly+"\"></td>"
										+ "</tr>");

									++i;
								}
								rs.close();
								ps.close();

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
				  </table>

						<input type="hidden" name="counter" id="counter" value="<%=(i-1)%>">

					  <div class="form-group">
						 <div class="col-sm-offset-1 col-sm-11">
							<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Cancel</button>
							<button type="submit" class="btn btn-success" name="cmdUpdate" id="cmdUpdate">Update</button>
						 </div>
					  </div>

				  </div>
				</div>
			</form>
      </div>

      <div class="footer">
        <p>&copy; 1997-2014. All rights reserved</p>
      </div>

    </div> <!-- /container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="../bs-dist/js/bootstrap.js"></script>
	<script src="../bs-docs-assets/js/holder.js"></script>
	<script src="../bs-docs-assets/js/application.js"></script>
    <!-- Placed at the end of the document so the pages load faster -->

	<script>

		$(document).ready(function() {

			//
			// cmdCancel
			//
			$("#cmdCancel").click(function() {

				window.location = "/central/core/index.jsp";

				return false;

			});

			//
			// cmdUpdate
			//
			$("#cmdUpdate").click(function() {

				$('#frmMain').submit();

				return true;

			});

		}); // jq ends

	</script>


  </body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	/*
	 * getSection
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 */
	public static String getSection(Connection conn,String campus,int seq){

		Logger logger = Logger.getLogger("acs01");

		//
		// default to campus
		//
		String section = "CS";

		try{

			String sql = "SELECT section FROM kcm_section WHERE campus=? AND seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				section = rs.getString("section");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("acs01 - getSection: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("acs01 - getSection: " + e.toString());
		}

		return section;

	}


%>