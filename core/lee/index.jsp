<%
	/**
	*	ASE
	*	ase.jsp
	*	2007.09.01	main drive to check on various settings
	**/

	String fieldsetTitle = "";

	if (com.ase.aseutil.session.SessionCheck.checkSession(request).equals("")){
		response.sendRedirect("../login.jsp");
	}
	else{
		session.setAttribute("aseThisPage","");
		session.setAttribute("aseConfig","");
		session.setAttribute("aseConfigMessage","");
	}

%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>

<%@ include file="../../inc/db.jsp" %>

<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="helper" scope="application" class="com.ase.aseutil.Helper" />
<jsp:useBean id="log" scope="application" class="com.ase.aseutil.ASELogger" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />
<jsp:useBean id="outlines" scope="application" class="com.ase.aseutil.Outlines" />
<jsp:useBean id="paging" scope="application" class="com.ase.paging.Paging" />
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.BufferedWriter"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.File"%>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../../exp/notauth.jsp");
	}

	String thisPage = "Index";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "";
	fieldsetTitle = pageTitle;

	int step = website.getRequestParameter(request,"step", 0);
	String hid = website.getRequestParameter(request,"hid", "");
	String alpha = "";
	String num = "";
	String title = "";

	int rowsAffected = 0;
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
   <link href="../bs-dist/css/bootstrap.css" rel="stylesheet">
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>

   <style>
		.list-group-item {
				text-align: left;
		}

		p {
			text-align: left;
		}

		.panel-body {
			text-align: left;
		}

   </style>

</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage && !user.equals(Constant.BLANK)){

		String sql = "";
		PreparedStatement ps = null;
		ResultSet rs = null;

%>
		 <div class="container">

			<div class="bs-example">

				<%
					if(step == 0){
				%>
						<table class="table table-striped">
							<tr>
								<th>Alpha</th>
								<th>Num</th>
								<th>Title</th>
								<th>Term</th>
								<th>Last Date</th>
								<th>Processed By</th>
								<th>Processed Date</th>
							</tr>

							<%
								try {
									sql = "SELECT DISTINCT historyid, coursealpha, coursenum, coursetitle, effectiveterm, convert(varchar, coursedate, 101) as coursedate, auditby, auditdate "
										+ "from ENG2122 WHERE done = 0 order by auditdate asc, coursealpha, coursenum";
									ps = conn.prepareStatement(sql);
									rs = ps.executeQuery();
									while(rs.next()){
										hid = AseUtil.nullToBlank(rs.getString("historyid"));
										alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
										num = AseUtil.nullToBlank(rs.getString("coursenum"));
										title = AseUtil.nullToBlank(rs.getString("coursetitle"));
										String auditby = AseUtil.nullToBlank(rs.getString("auditby"));
										String auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
										String term = AseUtil.nullToBlank(rs.getString("effectiveterm"));
										String coursedate = AseUtil.nullToBlank(rs.getString("coursedate"));

										out.println("<tr><td>" + alpha + "</td>"
											+ "<td>" + num + "</td>"
											+ "<td><a href=\"?step=1&hid="+hid+"\">" + title + "</a></td>"
											+ "<td>" + term + "</td>"
											+ "<td>" + coursedate + "</td>"
											+ "<td>" + auditby + "</td>"
											+ "<td>" + auditdate + "</td>"
											+ "</tr>");
									}
									rs.close();
									ps.close();

									rs = null;
									ps = null;

								} catch (SQLException e) {
									out.println("Exception: " + e.toString());
								} catch (Exception e) {
									out.println("Exception: " + e.toString());
								}
							%>
						</table>
				<%
					}
					else if(step == 1){
						try {

							//
							// check pre req table
							//
							String prereqstext = "";
							int prereqsfound = 0;
							String c25 = "";

							sql = "SELECT p.historyid, p.CourseAlpha, p.CourseNum, c.coursetitle, c.effectiveterm, p.PrereqAlpha, p.PrereqNum "
								+ "FROM   tblPreReq p inner join tblcourse c on p.historyid = c.historyid "
								+ "WHERE  (p.Campus = ?) AND (p.historyid = c.historyid) AND (p.historyid = ?)";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,hid);
							rs = ps.executeQuery();
							while(rs.next()){
								alpha = AseUtil.nullToBlank(rs.getString("PrereqAlpha"));
								num = AseUtil.nullToBlank(rs.getString("PrereqNum"));
								prereqstext += "<li>" + alpha + " " + num + "</li>";
								prereqsfound = 1;
							}
							rs.close();
							ps.close();

							//
							// campus data
							//
							sql = "select crs.coursealpha, crs.coursenum, crs.coursetitle, cps.c25 "
								+ "from tblcourse crs inner join tblcampusdata cps on crs.historyid = cps.historyid "
								+ "where crs.campus=? and crs.historyid = ?";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,hid);
							rs = ps.executeQuery();
							if(rs.next()){
								c25 = AseUtil.nullToBlank(rs.getString("c25"));
								alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
								num = AseUtil.nullToBlank(rs.getString("coursenum"));
								title = AseUtil.nullToBlank(rs.getString("coursetitle"));
							}

							rs.close();
							ps.close();

							rs = null;
							ps = null;

							out.println("<div class=\"panel panel-default\">"
							  + "<div class=\"panel-heading\">" + alpha + " " + num + " - " + title + " ("+hid+")" + "</div>"
							  + "<div class=\"panel-body\">");

							if(!prereqstext.equals("")){
								prereqstext += "<li>ENG 24</li>";
								prereqstext += "<li>ENG 24C</li>";
								prereqstext = "<ul>" + prereqstext + "</ul>";
								out.println(prereqstext);
							} // prereqstext

						%>
							<form id="aseForm" name="aseForm" method="post" action="?">
								<input type="hidden" id="step" name="step" value="2">
								<input type="hidden" id="hid" name="hid" value="<%=hid%>">
								<input type="hidden" id="alpha" name="alpha" value="<%=alpha%>">
								<input type="hidden" id="num" name="num" value="<%=num%>">
								<input type="hidden" id="title" name="title" value="<%=title%>">
								<input type="hidden" id="prereqstext" name="prereqstext" value="<%=prereqstext%>">
								<input type="hidden" id="prereqsfound" name="prereqsfound" value="<%=prereqsfound%>">
								<textarea id="content" name="content"><%=c25%></textarea>
								<script type="text/javascript">
									//<![CDATA[
										CKEDITOR.replace( 'content',
											{
												toolbar : [],
												extraPlugins : 'tableresize',
												toolbarCanCollapse : false,
												enterMode : CKEDITOR.ENTER_BR,
												shiftEnterMode: CKEDITOR.ENTER_P
											}
										);
									//]]>
								</script>
								<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Cancel</button>
								<button type="submit" class="btn btn-success" name="cmdUpdate" id="cmdUpdate">Review and Continue</button>
								<button type="submit" class="btn btn-info" name="cmdDone" id="cmdDone">Mark as Done</button>
							</form>
						<%
							out.println("</div></div>");

						} catch (SQLException e) {
							out.println("Exception: " + e.toString());
						} catch (Exception e) {
							out.println("Exception: " + e.toString());
						}
					} // step 1
					else if(step == 2){

						int prereqsfound = website.getRequestParameter(request,"prereqsfound", 0);
						String prereqstext = website.getRequestParameter(request,"prereqstext", "");
						String content = website.getRequestParameter(request,"content", "");
						alpha = website.getRequestParameter(request,"alpha", "");
						num = website.getRequestParameter(request,"num", "");
						title = website.getRequestParameter(request,"title", "");

						out.println("<div class=\"panel panel-default\">"
						  + "<div class=\"panel-heading\">" + alpha + " " + num + " - " + title + " ("+hid+")" + "</div>"
						  + "<div class=\"panel-body\">"
						  + prereqstext
						  + content
						  + "</div>"
						  + "</div>");

						%>
							<form id="aseForm" name="aseForm" method="post" action="?">
								<input type="hidden" id="step" name="step" value="3">
								<input type="hidden" id="hid" name="hid" value="<%=hid%>">
								<input type="hidden" id="alpha" name="alpha" value="<%=alpha%>">
								<input type="hidden" id="num" name="num" value="<%=num%>">
								<input type="hidden" id="title" name="title" value="<%=title%>">
								<input type="hidden" id="prereqstext" name="prereqstext" value="<%=prereqstext%>">
								<input type="hidden" id="prereqsfound" name="prereqsfound" value="<%=prereqsfound%>">
								<input type="hidden" id="content" name="content" value="<%=content%>">
								<div style="text-align: left;">
									<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Cancel</button>
									<button type="submit" class="btn btn-success" name="cmdUpdate" id="cmdUpdate">Update</button>
								<div>
							</form>
						<%

					} // step 2
					else if(step == 3){

						int prereqsfound = website.getRequestParameter(request,"prereqsfound", 0);
						String prereqstext = website.getRequestParameter(request,"prereqstext", "");
						String content = website.getRequestParameter(request,"content", "");
						alpha = website.getRequestParameter(request,"alpha", "");
						num = website.getRequestParameter(request,"num", "");
						title = website.getRequestParameter(request,"title", "");

						if(prereqsfound == 1){
							rowsAffected = RequisiteDB.addRemoveRequisites(conn,hid,"a",campus,alpha,num,"ENG","24","","1",user,0,false);
							rowsAffected = RequisiteDB.addRemoveRequisites(conn,hid,"a",campus,alpha,num,"ENG","24C","","1",user,0,false);
						}

						//
						// update campus data (content box)
						//
						sql = "UPDATE tblcampusdata SET c25=? WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,content);
						ps.setString(2,campus);
						ps.setString(3,hid);
						ps.executeUpdate();

						//
						// update work table
						//
						sql = "UPDATE ENG2122 SET updates=? WHERE historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,content);
						ps.setString(2,hid);
						ps.executeUpdate();

						//
						// create a version where we attempt to drop content into the exact spot without updating
						// the entire course outline. this is the version where only the SLO was touched.
						// the code below would regenerate the outline and that would adopt the course to
						// the most current question and list of options.
						//
						boolean fileUpdate = true;

						if(fileUpdate){

							String start = "Prerequisites<br/><br/></td></tr><tr><td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td><td class=\"datacolumn\" valign=\"top\">";
							String end = "<br/><br/></td></tr><tr>";

							int startLen = 158;	// from start of prereq to end of table texts

							String currentDrive = AseUtil.getCurrentDrive() + ":";
							String documents = SysDB.getSys(conn,"documents");

							String htmlFile = hid + ".html";

							String html = currentDrive + documents + "\\outlines\\" + campus + "\\" + htmlFile;

							File aFile = new File(html);

							//
							// create the outline if the file was not found
							//
							if(!aFile.exists()) {
								Tables.createOutlines(conn,campus,hid,alpha,num,"html","","",false,false,true);
							} // file not found

							BufferedReader input = new BufferedReader(new FileReader(aFile));

							String line = null;
							StringBuffer sb = new StringBuffer();

							if (input != null){
								while ((line = input.readLine()) != null) {
									sb.append(line);
								}	// while

								line = sb.toString();

								int iStart = line.indexOf(start);

								if(iStart > 0){
									iStart = iStart + startLen;
									int iEnd = line.indexOf(end,iStart);
									if(iEnd > 0){

										String left = line.substring(0,iStart);
										String right = line.substring(iEnd, (line.length() - 1));
										String newhtml = currentDrive + documents + "\\outlines\\" + campus + "\\_" + htmlFile;
										FileWriter fstream = new FileWriter(newhtml);
										BufferedWriter bw = new BufferedWriter(fstream);
										line = left + content + right;
										bw.write(line);
										bw.close();

									} // found end marker

								} // found start marker

							} // input file is valid

						} // fileUpdate

						//
						// recreate outline
						//
						CampusDB.updateCampusOutline(conn,hid,campus);

						Tables.createOutlines(conn,campus,hid,alpha,num,"html","","",false,false,true);

						//
						// update work status
						//
						sql = "UPDATE ENG2122 SET auditby=?, auditdate=? WHERE historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,user);
						ps.setString(2,AseUtil.getCurrentDateTimeString());
						ps.setString(3,hid);
						ps.executeUpdate();

						ps.close();
						ps = null;

						out.println("<div class=\"panel panel-default\">"
						  + "<div class=\"panel-heading\">" + alpha + " " + num + " - " + title + " ("+hid+")" + "</div>"
						  + "<div class=\"panel-body\">"
						  + prereqstext
						  + content
						  + "<br/><br/><div class=\"alert alert-success\" role=\"alert\">Course data updated successfully.</div>"
						  + "</div>"
						  + "</div>");

						%>
							<form id="aseForm" name="aseForm" method="post" action="?">
								<div style="text-align: left;">
									<button type="submit" class="btn btn-info" name="cmdPreview" id="cmdPreview">Preview Outline</button>
									<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Back to List</button>
								<div>
							</form>
						<%

					} // step 3
					else if(step == 4){
						//
						// update work status
						//
						sql = "UPDATE ENG2122 SET done=1, auditby=?, auditdate=? WHERE historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,user);
						ps.setString(2,AseUtil.getCurrentDateTimeString());
						ps.setString(3,hid);
						ps.executeUpdate();

						ps.close();
						ps = null;

						alpha = website.getRequestParameter(request,"alpha", "");
						num = website.getRequestParameter(request,"num", "");
						title = website.getRequestParameter(request,"title", "");

						out.println("<div class=\"panel panel-default\">"
						  + "<div class=\"panel-heading\">" + alpha + " " + num + " - " + title + " ("+hid+")" + "</div>"
						  + "<div class=\"panel-body\">"
						  + "<br/><br/><div class=\"alert alert-success\" role=\"alert\">Course was marked as done.</div>"
						  + "</div>"
						  + "</div>");

						%>
							<form id="aseForm" name="aseForm" method="post" action="?">
								<div style="text-align: left;">

									<button type="submit" class="btn btn-warning" name="cmdCancel" id="cmdCancel">Back to List</button>
								<div>
							</form>
						<%

					} // step 4
				%>

			</div> <!-- bs-example -->

		 </div> <!-- /container -->

<%
	} // processPage
%>


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
				window.location = "/central/core/lee/index.jsp";
				return false;
			});

			//
			// cmdDone
			//
			$("#cmdDone").click(function() {
				window.location = "/central/core/lee/index.jsp?step=4&hid=<%=hid%>&alpha=<%=alpha%>&num=<%=num%>&title=<%=title%>";
				return false;
			});

			//
			// cmdUpdate
			//
			$("#cmdUpdate").click(function() {
				$('#aseForm').submit();
				return true;

			});

			//
			// cmdPreview
			//
			$("#cmdPreview").click(function() {
				window.open("/centraldocs/docs/outlines/LEE/<%=hid%>.html");
				return false;
			});

	}); // jq ends

</script>

<%
	asePool.freeConnection(conn,"lee/index",user);
%>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>

