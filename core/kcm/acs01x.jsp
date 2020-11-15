<%@ include file="./acs00.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>KCM - Question Grouping</title>

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
        <a href="../index.jsp"><span class="glyphicon glyphicon-home"></span></a>&nbsp;&nbsp;<font class="text-muted"><a href="acs01.jsp">KCM - Question Grouping</a></font>
      </div>

      <div class="bs-example">
		  <form class="navbar-form navbar-right" role="search" name="frmMain" action="acs01x.jsp">
				<div class="panel panel-primary">
				  <div class="panel-heading">
				  </div>
				  <div class="panel-body">
					<table class="table">
					 <thead>
						<tr>
							<th>#</th>
							<th>Question</th>
							<th>Section</th>
						</tr>
					 </thead>
					 <tbody>
					 <%

						int i = 1;

						String[] aSections = "Course Information,Governance,Course Logistics,Learning Objectives,Course Requisites,Active Dates,Financials,Authors Collaborators,Supporting Documents,Campus".split(",");
						String[] aKey = "CI,GV,CL,LO,CR,AD,FI,AC,SD,CS".split(",");

						int defalt = 9;

						try {

							PreparedStatement ps2 = null;

							//
							// delete any existing
							//
							sql = "DELETE FROM kcm_section WHERE campus=?";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus);
							ps.executeUpdate();

							for(int j = 0; j < 2; j++){

								String table = "vw_CourseQuestions";
								String type = "course";

								if(j > 0){
									table = "vw_CampusQuestions";
									type = "campus";
								}

								sql = "SELECT question from " + table + " where campus=? order by questionseq";
								ps = conn.prepareStatement(sql);
								ps.setString(1,campus);
								rs = ps.executeQuery();
								while(rs.next()){
									String question = AseUtil.nullToBlank(rs.getString("question"));

									String selected = website.getRequestParameter(request,"ck_" + i, ""+defalt);

									String[] aSelected = selected.split("_");

									int checkbox = com.ase.aseutil.NumericUtil.getInt(aSelected[0]);

									String friendly = aSelected[1];

									String section = "";

									if(checkbox > -1){
										section = aSections[checkbox];
									}

									out.println("<tr>"
										+ "<td>" + i + "</td>"
										+ "<td>" + question + "</td>"
										+ "<td>" + section + "</td>"
										+ "</tr>");

									sql = "INSERT INTO kcm_section (campus,type,seq,section,auditby,auditdate,friendly) values(?,?,?,?,?,?,?)";
									ps2 = conn.prepareStatement(sql);
									ps2.setString(1,campus);
									ps2.setString(2,type);
									ps2.setInt(3,i);
									ps2.setString(4,aKey[checkbox]);
									ps2.setString(5,user);
									ps2.setString(6,aseUtil.getCurrentDateTimeString());
									ps2.setString(7,friendly);
									ps2.executeUpdate();
									ps2.close();

									++i;
								}
								rs.close();
								ps.close();


							} // j

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

					  <div class="form-group">
						 <div class="col-sm-offset-1 col-sm-11">
							<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Cancel</button>
							<button type="submit" class="btn btn-success" name="cmdUpdate" id="cmdUpdate">Return to Questions</button>
							<button type="submit" class="btn btn-info" name="cmdPreview" id="cmdPreview">Preview</button>
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

				window.location = "/central/core/kcm/acs01.jsp";

				return false;

			});

			//
			// cmdPreview
			//
			$("#cmdPreview").click(function() {

				window.location = "/central/core/kcm/acs05.jsp";

				return false;

			});

		}); // jq ends

	</script>


  </body>
</html>

