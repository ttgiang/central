<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%

	//need to include outline status when changing term

	/**
	*	ASE
	*	crscmpr.jsp	- course compare
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Compare Outlines";
	fieldsetTitle = pageTitle;

	//SOURCE
	String cs = website.getRequestParameter(request,"cs",campus);	// campus
	String tss = website.getRequestParameter(request,"tss","");	// type
	String as = website.getRequestParameter(request,"as","");	// alpha
	String ns = website.getRequestParameter(request,"ns","");	// num
	String fs = website.getRequestParameter(request,"fs","");	// kix

	//DESTINATION
	String cd = website.getRequestParameter(request,"cd",campus);
	String tdd = website.getRequestParameter(request,"tdd","");
	String ad = website.getRequestParameter(request,"ad","");
	String nd = website.getRequestParameter(request,"nd","");
	String fd = website.getRequestParameter(request,"fd","");

	// kix
	String ks = helper.getKix(conn,cs,as,ns,tss);
	String kd = helper.getKix(conn,cd,ad,nd,tdd);

	// kix for archived
	if(!fs.equals(Constant.BLANK) && tss.equals(Constant.ARC)){
		ks = CourseDB.getArchivedCourseItem(conn,cs,as,ns,fs,"historyid");
	}

	if(!fd.equals(Constant.BLANK) && tdd.equals(Constant.ARC)){
		kd = CourseDB.getArchivedCourseItem(conn,cd,ad,nd,fd,"historyid");
	}

	boolean debug = false;
	if(debug){
		System.out.println("SRC" + Html.BR());
		System.out.println("---" + Html.BR());
		System.out.println("cs: " + cs + Html.BR());
		System.out.println("tss: " + tss + Html.BR());
		System.out.println("as: " + as + Html.BR());
		System.out.println("ns: " + ns + Html.BR());
		System.out.println("fs: " + fs + Html.BR());
		System.out.println("ks: " + ks + Html.BR());

		System.out.println("SRC" + Html.BR());
		System.out.println("---" + Html.BR());
		System.out.println("cd: " + cd + Html.BR());
		System.out.println("tdd: " + tdd + Html.BR());
		System.out.println("ad: " + ad + Html.BR());
		System.out.println("nd: " + nd + Html.BR());
		System.out.println("fd: " + fd + Html.BR());
		System.out.println("kd: " + kd + Html.BR());
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscmpr.js"></script>

	<%@ include file="datatables.jsp" %>

	<script type="text/javascript">
		$(document).ready(function(){

			var tss = "";
			var cs = "";
			var as = "";
			var ns = "";
			var fs = "<%=fs%>";

			var tdd = "";
			var cd = "";
			var ad = "";
			var nd = "";
			var fd = "<%=fd%>";

			$(".tss").change(function(){
				tss = $(this).val();
				cs = document.getElementById("cs").value;
				as = document.getElementById("as").value;
				ns = document.getElementById("ns").value;
				fs = document.getElementById("fs").value;

				if(tss!='' && cs!='' && as != '' && ns !=''){
					getTerms("fs",cs,as,ns,tss,fs);
				}

			});

			$(".tdd").change(function(){
				tdd = $(this).val();
				cd = document.getElementById("cd").value;
				ad = document.getElementById("ad").value;
				nd = document.getElementById("nd").value;
				fd = document.getElementById("fd").value;

				if(tdd!='' && cd!='' && ad != '' && nd !=''){
					getTerms("fd",cd,ad,nd,tdd,fd);
				}
			});

			getFormDefaults(fs,fd);

		});

		function getTerms(control,campus,alpha,num,type,term){

			var dataString = 'cs='+campus+'&as='+alpha+'&ns='+num+'&ts='+type+'&fs='+term;

			$.ajax({
				type: "POST",
				url: "crscmprz.jsp",
				data: dataString,
				cache: false,
				success: function(html){
					$("."+control).html(html);
				}
			});

		}

		function getFormDefaults(fs,fd){

			var tss = document.getElementById("tss").value;
			var cs = document.getElementById("cs").value;
			var as = document.getElementById("as").value;
			var ns = document.getElementById("ns").value;

			if(tss!='' && cs!='' && as != '' && ns !=''){
				getTerms("fs",cs,as,ns,tss,fs);
			}

			var tdd = document.getElementById("tdd").value;
			var cd = document.getElementById("cd").value;
			var ad = document.getElementById("ad").value;
			var nd = document.getElementById("nd").value;

			if(tdd!='' && cd!='' && ad != '' && nd !=''){
				getTerms("fd",cd,ad,nd,tdd,fd);
			}

		}


	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		int thisCounter = 0;
		int thisTotal = 3;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "CUR"; thisTitle[0] = "Approved";
		thisType[1] = "ARC"; thisTitle[1] = "Archived";
		thisType[2] = "PRE"; thisTitle[2] = "Proposed";

		String sql = "";
%>

		<form method="post" action="?" name="aseForm">
			<table width="100%" cellspacing='1' cellpadding='2' class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td class="textblackTH" width="08%" height="40" nowrap>Source:&nbsp;</td>
					<td class="dataColumn" valign="top" nowrap>
						Campus:&nbsp;&nbsp;
						<%
							sql = aseUtil.getPropertySQL(session,"campus4");
							out.println(aseUtil.createSelectionBox(conn,sql,"cs",cs,"","",false,"",true,false));
						%>

						&nbsp;&nbsp;Alpha:&nbsp;&nbsp;
						<%
							sql = aseUtil.getPropertySQL(session,"alphas3");
							out.println(aseUtil.createSelectionBox(conn,sql,"as",as,"","",false,"",true,false));
						%>&nbsp;&nbsp;
						Number:&nbsp;&nbsp;<input name="ns" id="ns" class="input" type="text" size="6" maxlength="10" value="<%=ns%>">&nbsp;&nbsp;

						Type:&nbsp;&nbsp;
						<select name="tss" id="tss" class="tss" size="1">
							<option value="">-select-</option>
							<%
								for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
									if (tss.equals(thisType[thisCounter]))
										out.println("<option value=\""+thisType[thisCounter]+"\" selected>" + thisTitle[thisCounter] + "</option>" );
									else
										out.println("<option value=\""+thisType[thisCounter]+"\">" + thisTitle[thisCounter] + "</option>" );
								}
							%>
						</select>&nbsp;&nbsp;

						Effective Term:&nbsp;&nbsp;<select name="fs" id="fs" class="fs"><option value="">- select -</option></select>
					</td>
					<td rowspan="2" nowrap>
						<input name="aseSubmit" class="inputsmallgray" type="submit" value="Compare" onClick="return checkForm('s')">
						<input name="aseCancel" class="inputsmallgray" type="submit" value="Cancel" onClick="return cancelForm()">
					</td>
				</tr>

				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td class="textblackTH" width="08%" height="40" nowrap>Destination:&nbsp;</td>
					<td class="dataColumn" valign="top" nowrap>
						Campus:&nbsp;&nbsp;
						<%
							sql = aseUtil.getPropertySQL(session,"campus4");
							out.println(aseUtil.createSelectionBox(conn,sql,"cd",cd,"","",false,"",true,false));
						%>

						&nbsp;&nbsp;Alpha:&nbsp;&nbsp;
						<%
							sql = aseUtil.getPropertySQL(session,"alphas3");
							out.println(aseUtil.createSelectionBox(conn,sql,"ad",ad,"","",false,"",true,false));
						%>&nbsp;&nbsp;
						Number:&nbsp;&nbsp;<input name="nd" id="nd" class="input" type="text" size="6" maxlength="10" value="<%=nd%>">&nbsp;&nbsp;

						Type:&nbsp;&nbsp;
						<select name="tdd" id="tdd" class="tdd" size="1">
							<option value="">-select-</option>
							<%
								for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
									if (tdd.equals(thisType[thisCounter]))
										out.println("<option value=\""+thisType[thisCounter]+"\" selected>" + thisTitle[thisCounter] + "</option>" );
									else
										out.println("<option value=\""+thisType[thisCounter]+"\">" + thisTitle[thisCounter] + "</option>" );
								}
							%>
						</select>&nbsp;&nbsp;

						Effective Term:&nbsp;&nbsp;<select name="fd" id="fd" class="fd"><option value="">- select -</option></select>&nbsp;&nbsp;
					</td>
				</tr>

				<!--
				<tr>
					<td colspan="3">
						<div id="crscmpr" style="width: 100%; display:none;">
							<p>&nbsp;</p>
							<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
								<TBODY>
									<TR>
										<TD class=title-bar width="50%"><font class="textblackth">Compare Help</font></TD>
										<td class=title-bar width="50%" align="right">
											<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('crscmpr');">
										</td>
									</TR>
									<TR>
										<TD colspan="2">
											<p>
												Use this function to compare contents of 2 outlines with different types or status (approved or proposed). Provide the source and destination values then click the 'Submit' button to start the compare.
												<p>
												<b>NOTE</b>: KeyID is a special key representing courses and are reserved for advanced users. This value is found in the URL string following the 'kix' value pair. KeyID takes precedence over type, course alpha and number combination.
												</p>
											</p>

										<br/>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</div>
					</td>
				</tr>
				-->
			</table>
		</form>
<%
		if (processPage){
			if (ks.length() > 0 && kd.length() > 0){
				// this version is nice but comparing too much
				//msg = Outlines.compareOutlineWithDiff(conn,ks,kd,user,false);
				// this version is comparing alpha/num incorrectly when they are different from src and dst
				//msg = Outlines.compareOutline(conn,ks,kd,user,false);
				msg = TempOutlines.compareOutline(conn,ks,kd,user,false,true);
				out.println(msg.getErrorLog());
			}
			else{

				out.println("<br><br>Data not available for selected outline criteria");

			} 	// valid kix
		} // processPage

	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"crscmpr",user);
%>

<%!
	public static Msg compareOutline(Connection conn,
												String kixSRC,
												String kixDST,
												String user,
												boolean compressed,
												boolean show) throws Exception {

		Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH bgcolor=\"<| counterColor |>\" width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorSRC |>\" valign=\"top\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"<| paddedColor |>\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" bgcolor=\"<| colorDST |>\" valign=\"top\"><| answer2 |></td>"
			+"</tr>";

		String paddedColor = "#e1e1e1";
		String colorSRC = Constant.COLOR_LEFT;
		String colorDST = Constant.COLOR_RIGHT;
		String notMatchedColor = "#D2A41C";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String temp = "";

		//SRC
		int ts = 0;
		String cs = "";
		String[] is = Helper.getKixInfo(conn,kixSRC);
		ts = ConstantDB.getConstantTypeFromString(is[2]);
		cs = is[Constant.KIX_CAMPUS];

		//DST
		int td = 0;
		String cd = "";
		String[] id = Helper.getKixInfo(conn,kixDST);
		td = ConstantDB.getConstantTypeFromString(id[2]);
		cd = id[Constant.KIX_CAMPUS];

		String alpha = is[Constant.KIX_ALPHA];
		String num = is[Constant.KIX_NUM];
		String type = is[Constant.KIX_TYPE];

		String alphaDST = id[Constant.KIX_ALPHA];
		String numDST = id[Constant.KIX_NUM];

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,cs).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,cs).split(",");

		String headerSRC = "";
		String headerDST = "";

		String typeSRC = "";
		String typeDST = "";

		try {

			typeSRC = Outlines.getCourseType(conn,kixSRC);
			typeDST = Outlines.getCourseType(conn,kixDST);

			// source is on the left and destination is on the right
			// depending on what the source is, the title may change
			// for example, if source is PRE, the title is modified
			// if CUR, the current
			// if ARC, existing

			String termSRC = CourseDB.getCourseItem(conn,kixSRC,"effectiveterm");
			String termDST = CourseDB.getCourseItem(conn,kixDST,"effectiveterm");

			termSRC = BannerDataDB.getBannerDescr(conn,"bt",termSRC);
			termDST = BannerDataDB.getBannerDescr(conn,"bt",termDST);

			headerSRC = cs
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixSRC))
							+ " ("+termSRC+"_PDF_)";

			headerDST = cd
							+ " - "
							+ Outlines.getCourseCompareHeader(Outlines.getCourseType(conn,kixDST))
							+ " ("+termDST+"_PDF_)";

			//
			// enableCCLab
			//
			String userCampus = UserDB.getUserCampus(conn,user);
			String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,userCampus,"System","EnableCCLab");
			if (enableCCLab.equals(Constant.ON)){
				headerSRC = headerSRC.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixSRC+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);

				headerDST = headerDST.replace("_PDF_",
							" - <a href=\"/central/core/vwpdf.jsp?kix="+kixDST+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>"
								);
			}
			else{
				headerSRC = headerSRC.replace("_PDF_","");
				headerDST = headerDST.replace("_PDF_","");
			} // enableCCLab

			boolean same = true;

			//-----------------------------------------------------
			// course
			//-----------------------------------------------------
			int dataSRC = 0;
			int dataDST = 0;

			//
			// how many columns are we comparing
			//
			dataSRC = CourseDB.countCourseQuestions(conn,cs,"Y","",1);
			if(cs.equals(cd)){
				dataDST = dataSRC;
			}
			else{
				dataDST = CourseDB.countCourseQuestions(conn,cd,"Y","",1);
			}

			String src = "";
			String dst = "";

			//
			// always display as many as there are questions on SRC outline
			//
			for(i=0; i<dataSRC;i++){
				t1 = row1;
				t2 = row2;

				same = true;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[i] + "'" );

				// get data for the column. if the dst has fewer columns, don't get data
				src = CourseDB.getCourseItem(conn,kixSRC,columns[i]);
				src = Outlines.formatOutline(conn,columns[i],cs,alpha,num,typeSRC,kixSRC,src,true,user);

				if(dataDST > i){
					dst = CourseDB.getCourseItem(conn,kixDST,columns[i]);
					dst = Outlines.formatOutline(conn,columns[i],cd,alphaDST,numDST,typeDST,kixDST,dst,true,user);
				}
				else{
					dst = "";
				}

				// compare for display
				if (!src.equals(dst)){
					same = false;
				}

				// do we show?
				if(show || (!show && !same)){

					t1 = t1.replace("<| counter |>",(""+(i+1)));

					if (!same){
						t1 = t1.replace("<| counterColor |>",notMatchedColor);
					}
					else{
						t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
					}

					t1 = t1.replace("<| question |>",question+"<br><br>");

					t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
							.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
							.replace("<| paddedColor |>",paddedColor)
							.replace("<| colorSRC |>",colorSRC)
							.replace("<| colorDST |>",colorDST);

					buf.append(t1).append(t2);

				} // show

			} // for

			//
			// now we print campus tab data
			// if the campus SRC = DST, then we compare campus questions for SRC and DSt
			// if campuses are different, we only display SRC data since campus data are
			// not meant to be similar
			//
			if(i < columns.length){

				for(int j=i; j<columns.length; j++){

					t1 = row1;
					t2 = row2;

					same = true;

					question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + cs + "' AND question_friendly = '" + columns[j] + "'" );

					dst = "";

					// get data for the column. if the dst has fewer columns, don't get data
					src = CampusDB.getCampusItem(conn,kixSRC,columns[j]);
					src = Outlines.formatOutline(conn,columns[j],cs,alpha,num,typeSRC,kixSRC,src,true,user);

					// for same campus compare, get dst
					if(cs.equals(cd)){
						dst = CampusDB.getCampusItem(conn,kixDST,columns[j]);
						dst = Outlines.formatOutline(conn,columns[j],cd,alphaDST,numDST,typeDST,kixDST,dst,true,user);
					}

					//
					// compare for display
					// if the src not equals data and the campuses are different, we compare
					//
					if (!src.equals(dst)){
						same = false;
					}

					// do we show?
					if(show || (!show && !same)){

						t1 = t1.replace("<| counter |>",(""+(j+1)));

						if (!same){
							t1 = t1.replace("<| counterColor |>",notMatchedColor);
						}
						else{
							t1 = t1.replace("<| counterColor |>",Constant.ODD_ROW_BGCOLOR);
						}

						t1 = t1.replace("<| question |>",question+"<br><br>");

						t2 = t2.replace("<| answer1 |>",aseUtil.nullToBlank(src)+"<br><br>")
								.replace("<| answer2 |>",aseUtil.nullToBlank(dst)+"<br><br>")
								.replace("<| paddedColor |>",paddedColor)
								.replace("<| colorSRC |>",colorSRC)
								.replace("<| colorDST |>",colorDST);

						buf.append(t1).append(t2);

					} // show

				} // for

			}

			//
			// output
			//
			String campusTitle = "";

			cs = CampusDB.campusDropDownWithKix(conn,alpha,num,typeSRC,"ks",cs);
			cd = CampusDB.campusDropDownWithKix(conn,alphaDST,numDST,typeDST,"kd",cd);

			msg.setErrorLog("<table summary=\"\" id=\"tableCompareOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\">"
								+ campusTitle
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorSRC+"\" valign=\"top\" width=\"47%\">"+headerSRC+"</td>"
								+"<td align=\"center\" bgcolor=\""+paddedColor+"\" valign=\"top\" width=\"02%\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+colorDST+"\" valign=\"top\" width=\"47%\">"+headerDST+"</td>"
								+"</tr>"
								+ buf.toString()
								+ "</table>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines.compareOutline ("+kixSRC+"/"+kixDST+"): " + e.toString());
		}

		return msg;
	} // compareOutline
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

