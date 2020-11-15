<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndattach.jsp
	*	2007.09.01	edit fnd
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "fndedt";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Foundation Attachments";
	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"foundation attachment help\" title=\"foundation attachment help\" onclick=\"switchMenu('foundationHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String courseTitle = "";
	String fndType = "";
	int rowsAffected = 0;

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	String[] info = null;

	int id = website.getRequestParameter(request,"id", 0);
	String kix = website.getRequestParameter(request,"kix", "");
	if(id > 0 && kix.equals(Constant.BLANK)){
		kix = fnd.getFndItem(conn,id,"historyid");
		if(!kix.equals(Constant.BLANK)){
			info = fnd.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			courseTitle = info[Constant.KIX_COURSETITLE];
			fndType = info[Constant.KIX_ROUTE];
		}
	}
	else if(!kix.equals(Constant.BLANK)){
		id = NumericUtil.getInt(fnd.getFndItem(conn,kix,"id"),0);
		info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		courseTitle = info[Constant.KIX_COURSETITLE];
		fndType = info[Constant.KIX_ROUTE];
	}

	int sq = website.getRequestParameter(request,"sq", 0);
	int en = website.getRequestParameter(request,"en", 0);
	int qn = website.getRequestParameter(request,"qn", 0);

	String messages = "";

	//
	// most recent upload file id
	//
	int fid = website.getRequestParameter(request,"fid", 0);
	if(fid > 0){
		messages = "Document attached successfully";
	}

	//
	// delete file id
	//
	int did = website.getRequestParameter(request,"did", 0);
	if(did > 0 && fnd.isAuthor(conn,campus,user,kix,id)){
		rowsAffected = fnd.deleteFile(conn,campus,user,id,did);
		if(rowsAffected > 0){
			messages = "Document deleted successfully";
		}
	}

	//
	// sorting is either file name (fn) or question sequence (qs)
	//
	String sort = website.getRequestParameter(request,"sort", "fn");

	String url = "?id="+id+"&sq="+sq+"&en="+en+"&qn="+qn;

	//
	// save this information for file upload to prepend.
	//
	session.setAttribute("aseFileUploadPrefix",alpha + "_" + num);

	pageTitle = alpha + " " + num + " - " + courseTitle + "<br/>" + fndType + " - " + fnd.getFoundationDescr(fndType);

	//
	// requires for generic upload
	//
	session.setAttribute("aseCampus",campus);

	session.setAttribute("aseKix",kix);
	session.setAttribute("aseUploadProcess","gnrcmprt");
	session.setAttribute("aseCallingPage","fndattach");
	session.setAttribute("aseUploadSrc","fndattach");
	session.setAttribute("aseUploadTo","fnd");

	session.setAttribute("aseAlpha",""+alpha);
	session.setAttribute("aseNum",""+num);

	session.setAttribute("aseSq",""+sq);
	session.setAttribute("aseSq",""+sq);
	session.setAttribute("aseEn",""+en);
	session.setAttribute("aseQn",""+qn);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

   <link href="../inc/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" href="../inc/fndedt.css" rel="Stylesheet" />
	<link type="text/css" href="../inc/buttons.css" rel="Stylesheet" />

	<style type="text/css">

		#questionDiv{
			width:99%;
			float: left;
		}

		#questionDivLeft {
			width:02%;
			float: left;
			text-align: left;
		}

		#questionDivRight {
			width:97%;
			float: left;
			text-align: left;
		}

		#buttonDiv{
			width:99%;
			float: left;
		}

		#buttonDivLeft {
			width:02%;
			float: left;
			text-align: left;
		}

		#buttonDivRight {
			width:97%;
			float: left;
			text-align: left;
		}

		.new_line_padded{ clear: left; padding: 2px 2px;  }

		legend {
			padding: 4px 4px;
			border-color: #999 #CCC #CCC #999;
			border-style: solid;
			font-size: 12px;
			border-width: 1px;
			background: #EEE;
			width: 200px;
		}

		input, textarea, select, option, optgroup, button, td, th {
			font-size: 100%;
		}

		input[type="file"] {
			display:inline;
		}

		tr.d0 td {
			background-color: #428BCA; color: white;
		}

		.btn-sm {
			padding: 5px 10px;
			font-size: 12px;
			font-weight: bold;
			line-height: 1.5;
			border-radius: 9px;
		}

		.btn-xs {
			padding: 1px 5px;
			font-size: 12px;
			line-height: 1.5;
			border-radius: 3px;
		}

	</style>

</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

	<div id="foundationHelp" style="width: 100%; display:none;">
		<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
			<TBODY>
				<TR>
					<TD class=title-bar width="50%"><font class="textblackth">Foundation Attachments</font></TD>
					<td class=title-bar width="50%" align="right">
						<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('foundationHelp');">
					</td>
				</TR>
				<TR>
					<TD colspan="2">
						<p>
							Attaching documents is possible in 2 ways:
						</p>
						<ul>
							<li>Attaching for the entire foundation course</li>
							<li>Attaching to individual items (hallmarks), including explanatory (EN) and/or questions (QN)</li>
						</ul>
						<p>
							By default, attachments are listed by document names. To view by items, click 'Item' column. Sorting is possible
							for document or items only.
						</p>
						<p>
							If you arrive at this screen for a specific item, any attached document is tied to the item. To change the upload
							to a different item, click the <img src="/central/images/upload.png" border="0" title="attach to this section" alt="attach to this section"> beside the item sequence.
							To upload for the entire foundation course (not tied to any item), click the 'Upload' column header.
						</p>
						<p>
							To delete/remove an attachment, click the <img src="/central/images/del.gif" border="0" title="delete document" alt="delete document"> image to the right of the document.
						</p>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</div>

	<div class="bs-example">
      <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><%=pageTitle%></div>
        <div class="panel-body">
				<div class="bs-docs-grid">
					<div class="row show-grid">
					  <div class="col-md-8">
					  		<%
					  			//
					  			// no IE version works like a charm. Just damn IE screws up the upload with ajax
					  			//

					  			String browser = "ie";

					  			if(browser.equals("ie")){
							%>
									<table width="100%" border="0" cellspacing="10"  cellpadding="0" >
										<tr>
											<td style="color:#FDBA45">
												<form method="post" id="aseForm" name="aseForm" enctype="multipart/form-data" action="/central/servlet/opihi?s=gnrcmprt">
													<input class="input" type="file" name="fileName" size="50" id="fileName" class="upload" />
													<input type="hidden" name="formName" value="aseForm">
													<input type="hidden" name="sq" value="<%=sq%>">
													<input type="hidden" name="en" value="<%=en%>">
													<input type="hidden" name="qn" value="<%=qn%>">
													<input name="id" id="id" value="<%=id%>" type="hidden">
													<input name="kix" id="kix" value="<%=kix%>" type="hidden">
													<input name="alpha" id="alpha" value="<%=alpha%>" type="hidden">
													<input name="sort" id="sort" value="<%=sort%>" type="hidden">
													<input name="num" id="num" value="<%=num%>" type="hidden">
													<input name="buttonUpload" id="buttonUpload" type="submit" value="Upload" class="btn btn-primary btn-sm">
													<input name="buttonEdit" id="buttonEdit" type="submit" value="Return to editing" class="btn btn-primary btn-sm">
												</form>
											</td>
										</tr>
									</table>
							<%
								}
								else{
							%>
									<form enctype="multipart/form-data" id="image" name="image" method="post" action="fndattach.jsp">
										<table width="100%" border="0" cellspacing="10"  cellpadding="0" >
											<tr>
												<td style="color:#FDBA45">
													<input id="fileName"  name="fileName" type="file" />
													<input name="prependedFileName" id="prependedFileName" value="" type="hidden">
													<input name="FileUpload" id="FileUpload" value="0" type="hidden">
													<input name="en" id="en" value="<%=en%>" type="hidden">
													<input name="sq" id="sq" value="<%=sq%>" type="hidden">
													<input name="qn" id="qn" value="<%=qn%>" type="hidden">
													<input name="id" id="id" value="<%=id%>" type="hidden">
													<input name="kix" id="kix" value="<%=kix%>" type="hidden">
													<input name="alpha" id="alpha" value="<%=alpha%>" type="hidden">
													<input name="sort" id="sort" value="<%=sort%>" type="hidden">
													<input name="num" id="num" value="<%=num%>" type="hidden">
													<input name="buttonUpload" id="buttonUpload" onclick="return ajaxFileUpload();" type="submit" value="Attach" class="confirm_button blue styled_button">
													<input name="buttonEdit" id="buttonEdit" type="submit" value="Edit Foundation Course" class="confirm_button blue styled_button">
												</td>
											</tr>
										</table>
									</form>
							<%
								}
					  		%>
					  </div>
					  <div class="col-md-4">
					  		<%
					  			if(!messages.equals("")){
							%>
								<div class="alert alert-success">
								  <%=messages%>
								</div>
							<%
								}
					  		%>
						</div>
					</div>
				</div>
        </div>

			<table  class="table">
				<tr>
				  <th></th>
				  <th></th>
				  <th><a href="<%=url%>&sort=fn" class="linkcolumn">Document</a></th>
				  <th><a href="<%=url%>&sort=qs" class="linkcolumn">Item</a></th>
				  <th>User</th>
				  <th>Date</th>
				  <th><a href="?kix=<%=kix%>" class="linkcolumn">Upload</a></th>
				  <th>Delete</th>
				</tr>
				<tbody>
					<%
						for(com.ase.aseutil.Generic u: fnd.getAttachmentsMaster(conn,campus,id,sort)){

							int seq = NumericUtil.getInt(u.getString1(),0);

							int fileID = NumericUtil.getInt(u.getString1());
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

							String rowColor = "";
							if(fid==fileID){
								rowColor = "d0";
							}
					%>
							<tr class="<%=rowColor%>">
								<td><a href="/centraldocs/docs/fnd/<%=campus%>/<%=u.getString5()%>" target="_blank"><img src="/central/images/ext/<%=extension%>.gif" border="0" title="view most recent document" alt="view most recent document"></a>&nbsp;</td>
								<td>&nbsp;</td>
								<td><%=fileName%></td>
								<td><%=question%></td>
								<td><%=u.getString3()%></td>
								<td><%=u.getString4()%></td>
								<td><a href="?id=<%=id%>&sq=<%=s_sq%>&en=<%=s_en%>&qn=<%=s_qn%>&sort=<%=sort%>"><img src="/central/images/upload.png" border="0" title="attach to this section" alt="attach to this section"></a>&nbsp;</td>
								<td><a href="##" onClick="return removeFile(<%=id%>,<%=sq%>,<%=en%>,<%=qn%>,<%=fileID%>);"><img src="/central/images/del.gif" border="0" title="delete document" alt="delete document"></a>&nbsp;</td>
							</tr>
					<%
							for(com.ase.aseutil.Generic v: fnd.getAttachmentsDetail(conn,campus,id,seq,fileName,sort)){

								int fileID2 = NumericUtil.getInt(v.getString1());

								s_sq = v.getString6();
								s_en = v.getString7();
								s_qn = v.getString8();

								question = "";
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
									<td><%=question%>&nbsp;</td>
									<td><%=v.getString3()%>&nbsp;</td>
									<td><%=v.getString4()%>&nbsp;</td>
									<td><a href="?id=<%=id%>&sq=<%=s_sq%>&en=<%=s_en%>&qn=<%=s_qn%>&sort=<%=sort%>"><img src="/central/images/upload.png" border="0" title="attach to this section" alt="attach to this section"></a>&nbsp;</td>
									<td><a href="##" onClick="return removeFile(<%=id%>,<%=sq%>,<%=en%>,<%=qn%>,<%=fileID2%>);" target="_blank"><img src="/central/images/del.gif" border="0" title="delete document" alt="delete document"></a>&nbsp;</td>
								</tr>
							<%
							} // for v
						} // for u
					%>

				</tbody>
			</table>

      </div>
    </div>

<%
	fnd = null;
	paging = null;
	asePool.freeConnection(conn,"fndattach",user);
%>

<%@ include file="../inc/footer.jsp" %>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<link type="text/css" href="./js/plugins/jquery/css/ui-lightness/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />

	<script type="text/javascript" src="js/ajaxfileupload.js"></script>

	<script type="text/javascript">

		$(document).ready(function(){

			//
			// cmdClose
			//
			$("#cmdClose").click(function() {

				window.location = "fndvwedit.jsp";

				return false;

			});

			//
			// buttonUpload
			//
			$("#buttonUpload").click(function() {

				var fileName = $("#fileName").val();

				if(fileName != null && fileName != ''){
					return true;
				}
				else{
					alert("Please select document to attach");
					$("#fileName").focus();
				}

				return false;

			});

			//
			// buttonEdit
			//
			$("#buttonEdit").click(function() {

				var id = $("#id").val();

				window.location = "fndedt.jsp?id="+id;

				return false;

			});

		}); // jq

		//
		// removeFile
		//
		function removeFile(id,sq,en,qn,did){

			if(confirm("Do you wish to continue?")){
				window.location = "fndattach.jsp?id="+id+"&sq="+sq+"&en="+en+"&qn="+qn+"&did="+did;
			}

			return false;

		}

		//
		// ajaxFileUpload
		//
		function ajaxFileUpload(){

			var sq = $("#sq").val();
			var en = $("#en").val();
			var qn = $("#qn").val();
			var id = $("#id").val();
			var alpha = $("#alpha").val();
			var num = $("#num").val();
			var sort = $("#sort").val();

			jQuery("#loading")

				.ajaxStart(function(){
					jQuery(this).show();
				})

				.ajaxComplete(function(){
					jQuery(this).hide();
				});

				jQuery.ajaxFileUpload({
					url:'douploadfnd.jsp?en='+en+'&sq='+sq+'&qn='+qn+'&id='+id+'&a='+alpha+'&n='+num,
					secureuri:false,
					fileElementId:'fileName',
					dataType: 'json',
					success: function (data, status){

						if(typeof(data.error) != 'undefined'){

							if(data.error != ''){
								alert(data.error);
							}else{
								window.location = "fndattach.jsp?id="+id+"&sq="+sq+"&en="+en+"&qn="+qn+"&sort="+sort+"&fid="+data.fileID;
							}

						} // typeof
					},
					error: function (data, status, e){
						alert(e);
					} // error
				} // upload
			) //

			return false;

		}

	</script>

<!-- jqupload -->

</body>
</html>

