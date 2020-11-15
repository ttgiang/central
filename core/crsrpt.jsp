<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrpt.jsp - JQUERY implementation (export needs to be completed)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Reports";
	fieldsetTitle = pageTitle;

	String alpha = "";
	String num = "";
	String proposer = "";
	String sql = "";
	String temp = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix");
	String type = website.getRequestParameter(request,"type");
	String progress = website.getRequestParameter(request,"progress","APPROVED");
	String src = website.getRequestParameter(request,"src","");

	String message = "";
	String tableWidth = "80%";
	String reportName = "";

	String fromDate = website.getRequestParameter(request,"from","");
	String toDate = website.getRequestParameter(request,"to","");
	String semester = website.getRequestParameter(request,"semester","");

	int reportNumber = -1;
	int subReportNumber = -1;
	boolean showSummary = false;
	boolean export = false;
	String[] statusTab = null;

	fieldsetTitle = pageTitle;

	int reportMonth = 0;

	// determine report to show
	if (processPage && !src.equals(Constant.BLANK)){
		if (!kix.equals(Constant.BLANK)){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			proposer = info[3];
		}

		if (src.equals("CUR") || src.equals("CUR2")){
			reportNumber = 0;

			if (src.equals("CUR"))
				reportName = "ApprovedOutlines";
			else if (src.equals("CUR2"))
				reportName = "ApprovedOutlines2";

			type = "CUR";
			showSummary = false;
			pageTitle = "Display Approved Outlines";
		}
		else if (src.equals("showSLO")){
			if (kix.equals(Constant.BLANK)){
				reportNumber = 1;
				reportName = "ApprovedOutlinesSLO";
				showSummary = false;
				pageTitle = "Display Outline with SLO";
			}
			else{
				reportNumber = 2;
				reportName = "";
				showSummary = true;
				pageTitle = "Outline SLO";
			}
		}
		else if (src.equals("showComp")){
			if (kix.equals(Constant.BLANK)){
				reportNumber = 11;
				reportName = "ApprovedOutlinesComp";
				showSummary = false;
				pageTitle = "Display Outline with Competencies";
			}
			else{
				reportNumber = 12;
				reportName = "";
				showSummary = true;
				pageTitle = "Outline Competencies";
			}
		}
		else if (src.equals("noSLO")){
			reportNumber = 3;
			reportName = "ApprovedOutlinesNoSLO";
			showSummary = false;
			pageTitle = "Display Outline without SLO";
		}
		else if (src.equals("noComp")){
			reportNumber = 13;
			reportName = "ApprovedOutlinesNoComp";
			showSummary = false;
			pageTitle = "Display Outline without Competencies";
		}
		else if (src.equals("txt")){
			reportNumber = 4;
			reportName = "TextMaterials";
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Display Text & Materials";
		}
		else if (src.equals("app") || src.equals("mod") || src.equals("del")){
			reportNumber = 5;
			showSummary = false;
			tableWidth = "100%";

			if (src.equals("app")){
				pageTitle = "Outlines Approved by Calendar Year";
				reportName = "ApprovedAcademicYear";
			}
			else if (src.equals("del")){
				pageTitle = "Outlines Deleted by Calendar Year";
				reportName = "DeletedAcademicYear";
			}
			else if (src.equals("mod")){
				pageTitle = "Outlines Modified by Calendar Year";
				reportName = "ModifiedAcademicYear";
			}
		}
		else if (src.equals("trms")){
			reportNumber = 6;
			reportName = "EffectiveTerms";
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Outlines by Effective Terms";
		}
		else if (src.equals("fstrck")){
			reportNumber = 7;
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Outlines Fast Tracked";
		}
		else if (src.equals("enddate")){
			reportNumber = 8;
			subReportNumber = 1;
			reportName = "EndDate";
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Outlines by End Date";
		}
		else if (src.equals("expdate")){
			reportNumber = 8;
			subReportNumber = 2;
			reportName = "ExperimentalDate";
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Outlines by Experimental Date";
		}
		else if (src.equals("rvwdate")){
			reportNumber = 8;
			subReportNumber = 3;
			reportName = "ReviewDate";
			showSummary = false;
			tableWidth = "100%";
			pageTitle = "Outlines by Review Date";
		}

	}

	fieldsetTitle = "Report - " + pageTitle;

	if (showSummary && processPage){
		statusTab = courseDB.getCourseDates(conn,kix);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#crsrpt_5").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#crsrpt_5x").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#crsrpt_5y").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' }
				]
			});

			$("#crsrpt_6").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '15%' },
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' }
				]
			});

			$("#crsrpt_8").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '15%' },
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '30%' }
				]
			});

			$("#crsrpt_9").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 25,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '15%' },
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '30%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" cellpadding="2" width="<%=tableWidth%>" align="center" cellspacing="1">

	<%
		if (processPage && showSummary){
	%>
		<tr><td><%@ include file="crsedt9.jsp" %></td></tr>
	<%
		}
	%>

	<tr>
		<td>
<%

	if (processPage){

		switch(reportNumber){
			case 0:
				export = true;
				if (src.equals("CUR")){
					out.println(Outlines.showOutlines(conn,campus,user,progress,reportName));
				}
				else if (src.equals("CUR2")){
					out.println(Outlines.showOutlines(conn,campus,user,progress,reportName));
				}
				break;
			case 1:
				out.println(SLODB.showSLOs(conn,campus,user,reportName,progress,true));
				break;
			case 2:
				out.println("<br/><br/><font class=\"textblackth\">SLOs:</font><br/><br/>");
				out.println(CompDB.getObjectives(conn,kix));
				out.println(CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,Constant.COURSE_OBJECTIVES));
				break;
			case 3:
				out.println(SLODB.showSLOs(conn,campus,user,reportName,progress,false));
				break;
			case 4:
					type = website.getRequestParameter(request,"type","");
					String term = website.getRequestParameter(request,"term","");
				%>
					<form name="aseForm" method="post" action="?">
						<table width="40%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td class="textblackth" width="25%">Type:</td>
								<td class="textblackth">
									<input type="radio" class="input" value="CUR" name="type" <% if (type.equals("CUR")) out.println("checked"); %>>Approved
									<input type="radio" class="input" value="PRE" name="type" <% if (type.equals("PRE")) out.println("checked"); %>>Proposed
								</td>
							</tr>

							<%
								if (!type.equals(Constant.BLANK)){
							%>
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td class="textblackth" width="25%">Effective Term:</td>
								<td class="textblackth">
									<%
										String termSql = aseUtil.getPropertySQL(session,"terms");
										out.println(aseUtil.createSelectionBox(conn,termSql,"term",term,false));
									%>
								</td>
							</tr>
							<%
								}
							%>

							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td height="30" colspan="2" align="center">
									<input type="submit" value=" Go " class="inputsmallgray">
									<input type="hidden" name="src" value="<%=src%>">&nbsp;&nbsp;
									<%
										if (!type.equals(Constant.BLANK)){
											out.println("&nbsp;<a href=\"/central/servlet/clone?rpt="+reportName+"\" class=\"linkcolumn\">export</a>");
										}
									%>

								</td>
							</tr>
						</table>
					</form>
					<br/>
				<%

				if (!type.equals(Constant.BLANK) && !term.equals(Constant.BLANK)){
					session.setAttribute("aseParm1",reportName);
					session.setAttribute("aseParm2",type);
					session.setAttribute("aseParm3",term);
					out.println(TextDB.showText(conn,campus,type,term));
				}

				break;
			case 5:
					if (src.equals("app")){
						progress = Constant.COURSE_APPROVED_TEXT;
					}
					else if (src.equals("del")){
						progress = Constant.COURSE_DELETE_TEXT;
					}
					else if (src.equals("mod")){
						progress = Constant.COURSE_MODIFY_TEXT;
					}
					else{
						progress = "";
					}

				%>
					<form name="aseForm" method="post" action="?">
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td width="05%" class="textblackth">
									&nbsp;&nbsp;From:&nbsp;&nbsp;
									<%
										out.println(Html.drawYearListBox(conn,campus,progress,"from",fromDate,"BLANK"));
									%>
									&nbsp;&nbsp;To:&nbsp;&nbsp;
									<%
										out.println(Html.drawYearListBox(conn,campus,progress,"to",toDate,"BLANK"));

										if (!fromDate.equals(Constant.BLANK) && !toDate.equals(Constant.BLANK)){
											out.println("&nbsp;&nbsp;Semester: " + Html.drawSemesterList(conn,campus,progress,"semester",fromDate,toDate,semester,"BLANK"));
										}
									%>
									&nbsp;&nbsp;<input type="submit" value=" Go " class="inputsmallgray">
									<input type="hidden" name="src" value="<%=src%>">&nbsp;&nbsp;
									<%
										if (!fromDate.equals(Constant.BLANK) && !toDate.equals(Constant.BLANK)){
											out.println("&nbsp;<a href=\"/central/servlet/clone?rpt="+reportName+"\" class=\"linkcolumn\">export</a>"
												+ "&nbsp;&nbsp;&nbsp;&nbsp;(<img src=\"../images/archive01.gif\"  width=\"18\" height=\"18\" border=\"0\"> compare with archived outline is not available for new courses)");
										}
									%>
								</td>
							</tr>
						</table>
					</form>
					<br/>
				<%
					if (!fromDate.equals(Constant.BLANK) && !toDate.equals(Constant.BLANK)){
						session.setAttribute("aseParm1",reportName);
						session.setAttribute("aseParm2",fromDate);
						session.setAttribute("aseParm3",toDate);
						session.setAttribute("aseParm4",0);
						session.setAttribute("aseParm5",progress);
						session.setAttribute("aseParm6",semester);
						out.println(Outlines.showOutlinesModifiedByAcademicYear(conn,campus,fromDate,toDate,false,progress,semester));
					}

				break;
			case 6:
				String terms = website.getRequestParameter(request,"terms","");

				temp = aseUtil.drawHTMLField(conn,"listbox","EffectiveTerms","terms",terms,0,0,false,campus,false);

				%>
					<form name="aseForm" method="post" action="?">
						<font class="textblackth">Effective Term:</font> <%=temp%>
						<input type="hidden" name="src" value="trms">
						<input type="submit" name="aseSubmit" value="Go" class="Input">
				<%
					if (!terms.equals(Constant.BLANK)){
						session.setAttribute("aseParm1",reportName);
						session.setAttribute("aseParm2",terms);
						out.println("&nbsp;<a href=\"/central/servlet/clone?rpt="+reportName+"\" class=\"linkcolumn\">export</a>"
							+ "&nbsp;&nbsp;&nbsp;&nbsp;(<img src=\"../images/archive01.gif\" border=\"0\" width=\"18\" height=\"18\"> compare with archived outline is not available for new courses)"
						);
					}
				%>
					</form>
					<br/>
				<%

				if (!terms.equals(Constant.BLANK)){
					session.setAttribute("aseParm1",reportName);
					session.setAttribute("aseParm2",terms);
					session.setAttribute("aseParm3",0);
					session.setAttribute("aseParm4",0);
					session.setAttribute("aseParm5",0);
					out.println(Outlines.outlineEffectiveTerms(conn,campus,terms));
				}

				break;

			case 7:
					progress = "APPROVED";

				%>
					<form name="aseForm" method="post" action="?">
						<table width="40%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td width="10%" valign="top" class="textblackth">From:</td>
								<td width="20%" valign="top">
									<%
										out.println(Html.drawYearListBox(conn,campus,progress,"from",fromDate,"BLANK"));
									%>
								</td>
								<td width="10%" valign="top" class="textblackth">To:</td>
								<td width="20%" valign="top">
									<%
										out.println(Html.drawYearListBox(conn,campus,progress,"to",toDate,"BLANK"));
									%>
								</td>
								<td height="30" width="40%" valign="top" colspan="2" align="center">
									<input type="submit" value=" Go " class="inputsmallgray">
									<input type="hidden" name="src" value="<%=src%>">&nbsp;&nbsp;
								</td>
							</tr>
						</table>
					</form>
					<br/>
				<%

				if (!fromDate.equals(Constant.BLANK) && !toDate.equals(Constant.BLANK)){
					out.println(Outlines.showOutlinesFastTracked(conn,campus,fromDate,toDate));
				}

				break;

			case 8:
				String endYear = website.getRequestParameter(request,"endYear","");
				String endMonth = website.getRequestParameter(request,"endMonth","");

				String subTitle = "";
				String dateColumn = "enddate";

				if(subReportNumber==1){
					subTitle = "End Year";
					dateColumn = "enddate";
				}
				else if(subReportNumber==2){
					subTitle = "Experimental Year";
					dateColumn = "experimentaldate";
				}
				else if(subReportNumber==3){
					subTitle = "Review Year";
					dateColumn = "reviewdate";
				}

				%>

				<form name="aseForm" method="post" action="?">
					<table width="100%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
						<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
							<td width="15%" class="textblackth"><%=subTitle%>:</td>
							<td width="10%">
								<%
									out.println(Html.drawOutlineDateListBox(conn,campus,"endYear",endYear,"BLANK",dateColumn));
								%>
							</td>
							<td width="05%" class="textblackth">Month:</td>
							<td width="10%">
								<select name="endMonth" id="endMonth" class="input">
									<option value=""></option>

									<%
										reportMonth = NumericUtil.getInt(endMonth,0);

										for(int zz = 1; zz < 13; zz++){

											String selected = "";

											temp = "" + zz;

											if(zz < 10){
												temp = "0" + zz;
											}

											if(zz == reportMonth){
												selected = "selected";
											}

											out.println("<option value=\""+temp+"\" "+selected+">"+temp+"</option>");
										} // for

									%>

								</select>
							</td>
							<td height="30" width="60%" align="left">
								<input type="submit" value=" Go " class="inputsmallgray">
								<input type="hidden" name="src" value="<%=src%>">&nbsp;&nbsp;
								<%
									if (!endYear.equals(Constant.BLANK)){
										out.println("&nbsp;<a href=\"/central/servlet/clone?rpt="+reportName+"\" class=\"linkcolumn\">export</a>");
									}
								%>

							</td>
						</tr>
					</table>
				</form>
					<br/>
				<%

				if (!endYear.equals(Constant.BLANK)){
					session.setAttribute("aseParm1",reportName);
					session.setAttribute("aseParm2",endYear);
					session.setAttribute("aseParm3",endMonth);
					session.setAttribute("aseParm4",0);
					session.setAttribute("aseParm5",0);

					out.println(Outlines.outlineDates(conn,campus,endYear,endMonth,dateColumn));
				}

				break;

			case 11:
				out.println(CompetencyDB.showCompetencies(conn,campus,user,reportName,progress,true));
				break;
			case 12:
				out.println("<br/><br/><font class=\"textblackth\">Competencies:</font><br/><br/>");
				out.println(CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false,false));
				break;
			case 13:
				out.println(CompetencyDB.showCompetencies(conn,campus,user,reportName,progress,false));
				break;

			default:
				message = (String)session.getAttribute("aseJasperMessage");

				break;
		}	// switch
	}	// processPage

	asePool.freeConnection(conn,"crsrpt-"+src,user);
%>
		</td>
	</tr>
	<tr>
		<td>
			<%
				if (!message.equals(Constant.BLANK)){
			%>
					Report processing completed successfully.
					<br/><br/>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To view your report, click <a href="/centraldocs/docs/temp/<%=message%>.csv" class="linkcolumn" target="_blank">here</a>.
					<br/><br/>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To download your report, do the following:
					<br>
					<ul>
						<li>Right-mouse click <a href="/centraldocs/docs/temp/<%=message%>.csv" class="linkcolumn" target="_blank">here</a></li>
						<li>Select 'Save link as..'</li>
						<li>Save your report with extension CSV (IE. report.csv)</li>
					</ul>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To run another report, click <a href="/central/core/ccrpt.jsp" class="linkcolumn">here</a>.
					<br/><br/>
			<%
				}

				session.setAttribute("aseJasperMessage","");
			%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
