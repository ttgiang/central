<%@ include file="./acs00.jsp" %>

<!DOCTYPE html>
<html lang="en"  ng-app="angularjs-starter">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>KCM - Question Grouping - Usage Matrix</title>

    <!-- Bootstrap core CSS -->
    <link href="../bs-dist/css/bootstrap.css" rel="stylesheet">

	<style type="text/css">

		.container {
			max-width: 100%;
			-webkit-print-color-adjust: exact;
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
			 -webkit-print-color-adjust: exact !important;
		}

		a:visited {TEXT-DECORATION: none;}
		a:hover {COLOR: #E87B10; TEXT-DECORATION: none; }

		td.class- { background-color: #fff !important; color: #fff; }
		td.class-CI { background-color: #205081 !important; color: #fff; }
		td.class-GV { background-color: #1087dd !important; color: #fff; }
		td.class-CL { background-color: #3b5998 !important; color: #fff;  }
		td.class-LO { background-color: #ff0084 !important; color: #fff;  }
		td.class-CR { background-color: #444 !important;  color: #fff; }
		td.class-AD { background-color: #dd4b39 !important;  color: #fff; }
		td.class-FI { background-color: #517fa4 !important;  color: #fff; }
		td.class-AC { background-color: #007bb6 !important;  color: #fff; }
		td.class-SD { background-color: #cb2027 !important;  color: #fff; }
		td.class-CS { background-color: #2c4762 !important;  color: #fff; }

		td.class-kscm { background-color: #fff !important;  color: #E87B10; }
		td.class-kscmx { background-color: #E87B10 !important;  color: #fff; }
		td.class-cccm { background-color: #fff !important;  color: #000; }

		tr.class-gray { background-color: #eee !important;  color: #000; }

	</style>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body ng-controller="MainCtrl">
    <div class="container">
      <div class="header">
        <a href="../index.jsp"><span class="glyphicon glyphicon-home"></span></a>&nbsp;&nbsp;<font class="text-muted"><a href="acs01.jsp">KCM - Question Grouping - Usage Matrix</a></font>
      </div>

		<%@ include file="./acs04x.jsp" %>

      <div class="footer">
        <p>&copy; 1997-2014. All rights reserved</p>
      </div>

    </div> <!-- /container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
	<script src="../bs-js/angular.js"></script>
	<script src="../bs-js/ui-bootstrap-tpls-0.4.0.min.js"></script>
	<script src="../bs-js/app.js"></script>

	<script src="../bs-dist/js/bootstrap.js"></script>
	<script src="../bs-docs-assets/js/holder.js"></script>
	<script src="../bs-docs-assets/js/application.js"></script>


  </body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	/*
	 * getSection
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	friendly	String
	 */
	public static String getSection(Connection conn,String campus,String friendly){

		Logger logger = Logger.getLogger("acs04");

		//
		// default to campus
		//
		String section = "";

		try{

			String sql = "SELECT section FROM kcm_section WHERE campus=? AND friendly=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,friendly);
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

	/*
	 * getCourseQuestion
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	friendly	String
	 */
	public static String getCourseQuestion(Connection conn,String campus,String friendly){

		Logger logger = Logger.getLogger("acs04");

		String question = "";

		try{

			String sql = "SELECT question FROM vw_coursequestions WHERE campus=? AND question_friendly=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,friendly);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				question = rs.getString("question");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("acs01 - getCourseQuestion: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("acs01 - getCourseQuestion: " + e.toString());
		}

		return question;

	}

	/*
	 * inUse
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	friendly	String
	 */
	public static int inUse(Connection conn,int qn){

		Logger logger = Logger.getLogger("acs04");

		int counter = 0;

		try{

			String sql = "SELECT COUNT(questionnumber) AS counter FROM tblCourseQuestions WHERE (questionnumber=?) AND (include = 'Y')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,qn);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				counter = rs.getInt("counter");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("acs01 - inUse: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("acs01 - inUse: " + e.toString());
		}

		return counter;

	}

%>