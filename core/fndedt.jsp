<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndedt.jsp
	*	2007.09.01	edit fnd
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "fndedt";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Edit Foundation Course";
	fieldsetTitle = pageTitle
			+ "&nbsp;&nbsp;&nbsp;<img src=\"images/helpicon.gif\" border=\"0\" alt=\"foundation edit help\" title=\"foundation edit help\" onclick=\"switchMenu('fndEditHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String courseTitle = "";
	String fndType = "";

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

	//
	// save this information for file upload to prepend.
	//
	session.setAttribute("aseFileUploadPrefix",alpha + "_" + num);

	pageTitle = alpha + " " + num + " - " + courseTitle + "<br/>" + fndType + " - " + fnd.getFoundationDescr(fndType);

	//
	// forum ID
	//
	int fid = ForumDB.getForumID(conn,campus,kix);

	String messageBoard = Util.getSessionMappedKey(session,"EnableMessageBoard");

%>

<html>
<head>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
	<link type="text/css" href="./js/plugins/jquery/css/ui-lightness/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />
	<script type="text/javascript" src="../ckeditor431/ckeditor.js"></script>
	<script type="text/javascript" src="../ckeditor431/adapters/jquery.js"></script>

	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="./js/fndedt.js"></script>

   <link href="../inc/docs.css" rel="stylesheet">
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
			padding: 4px 4px;
			color: #31708F;
			background-color: #D9EDF7;
			border-color: #BCE8F1;
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
			text-align: right;
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
	</style>

	<style type="text/css">
		.divHidden { display: none !important; }

		.divShow { display: visible !important;
			display: block;
			padding: 9.5px;
			margin: 0 0 10px;
			font-size: 13px;
			line-height: 1.428571429;
			color: #333;
			background-color: whiteSmoke;
			border: 1px solid #CCC;
			border-radius: 4px;
		}

		.divQuestion {
			display: block;
			padding: 9.5px;
			margin: 0 0 10px;
			font-size: 13px;
			color: #333;
			background-color: D9EDF7;
			border: 1px solid #BCE8F1;
			border-radius: 4px;
		}

		.btn-sm {
			color: #ffffff;
			padding: 5px 10px;
			font-size: 12px;
			line-height: 1.5;
			border-radius: 9px;
		}

		.btn-xs {
			padding: 1px 5px;
			font-size: 12px;
			line-height: 1.5;
			border-radius: 3px;
		}

		.show-grid {
		  margin-bottom: 0px;
		}

		.show-grid [class^="col-"] {
		  padding-top: 0px;
		  padding-bottom: 0px;
		}

	</style>

</head>

<body topmargin="0" leftmargin="0">

	<%@ include file="../inc/header.jsp" %>

	<div id="fndEditHelp" style="width: 100%; display: none; ">
		<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
			<TBODY>
				<TR>
					<TD class=title-bar width="50%"><font class="textblackth">Foundation Edit</font></TD>
					<td class=title-bar width="50%" align="right">
						<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('fndEditHelp');">
					</td>
				</TR>
				<TR>
					<TD colspan="2">
						<p>
							To edit explanatory or questions, click the 'edit' button. Once in edit mode, you may click 'save' or 'cancel' to abort
							your modifications. If you don't click 'save' upon making changes, the system sends a reminder before moving on.
						</p>
						<ul>
							<li>Click <img src="../images/attachment.png" width="22px" alt="click to attach file" title="click to attach file"> to attach documents to the specific explantory or question. In doing so, attached documents are tied to the specific item.</li>
							<li>When shown, click <img src="../images/comments.jpg" width="22px" alt="view comments" title="view comments"> to view any review/approval comments linked to the item. The number in the bubble refers to the number of review/approval comments available.</li>
						</ul>
						<p>
							Attachments are located at the bottom of the page. You may attach to a specific item or to then entire foundation. Column labeled 'Item' indicates which foundation item an attached document is linked to.
						</p>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</div>

	<h1 class="samples"><%=pageTitle%></h1>

	<%
		String reviewerComments = "";

		if(processPage){

			String question = "";
			String data = "";

			int sq = 0;
			int en = 0;
			int qn = 0;

			//
			// get a list of sequence so we can loop through to draw out sections
			//
			ArrayList list = fnd.getFoundationSQ(conn,id);

			if (list != null){
				for (int i=0; i<list.size(); i++){

					int sqID = (Integer)list.get(i);

					out.println("<div class=\"bs-example\">");
					out.println("	<div class=\"panel panel-primary\">");

					for(com.ase.aseutil.Generic fd: fnd.getCourseFoundationBySQ(conn,id,sqID)){

						String fld = fd.getString6();

						sq = NumericUtil.getInt(fd.getString1(),0);
						en = NumericUtil.getInt(fd.getString2(),0);
						qn = NumericUtil.getInt(fd.getString3(),0);

						if(en > 0 || qn > 0){

							if(messageBoard.equals(Constant.ON)){
								reviewerComments = "" + ForumDB.countPostsToForum(conn,kix,sq,en,qn);
							}
							else{
								reviewerComments = "" + ReviewerDB.countReviewerComments(conn,kix,sq,en,qn,Constant.TAB_FOUNDATION,0);
							}

							if(reviewerComments != null && !reviewerComments.equals(Constant.BLANK)){
								if(reviewerComments.equals("0")){
									reviewerComments = "";
								}
								else{
									if(messageBoard.equals(Constant.OFF)){
										reviewerComments = "<a href=\"crsrvwcmnts.jsp?c=99&md=0&kix="+kix+"&itm="+sq + "&sq=" + sq + "&en=" + en + "&qn=" + qn
											+ "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span class=\"badge\">"
											+ reviewerComments + "</span></a>&nbsp;";
									}
									else{
										reviewerComments = "<a href=\"./forum/prt.jsp?fid="+fid+"&mid=0&itm="+sq + "&sq=" + sq + "&en=" + en + "&qn=" + qn
											+ "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span class=\"badge\">"
											+ reviewerComments + "</span></a>&nbsp;";
									}

								}
							}

							%>

								<div class="panel-body alignleft">

									<div class="divQuestion">
										<div class="bs-docs-grid">
											<div class="row show-grid">
												<div class="col-md-10"><%=fd.getString4()%>
												</div>
												<div class="col-md-2">
													<a href="fndattach.jsp?kix=<%=kix%>&sq=<%=sq%>&en=<%=en%>&qn=<%=qn%>"><img src="../images/attachment.png" width="22px" alt="click to attach file" title="click to attach file"></a>
													&nbsp;<%=reviewerComments%>
												</div>
											</div>
										</div>
									</div>

									<div class="new_line_padded">
									</div>

									<div id="div<%=fld%>Editor" name="div<%=fld%>Editor" class="divHidden ">
										<textarea class="jquery_ckeditor<%=fld%>" cols="160" id="editor<%=fld%>" name="editor<%=fld%>" rows="10"><%=fd.getString5()%></textarea>
										<div class="new_line_padded">
										</div>
										<p>
											<button name="btn<%=fld%>Cancelx" type="button" class="btn btn-warning btn-xs" onclick="hideShowControlsCKEditor('w','<%=fld%>'); return false;">cancel</button>
											<button name="btn<%=fld%>Savex" type="button" class="btn btn-success btn-xs" onclick="hideShowControlsCKEditor('s','<%=fld%>'); return false;">save</button>
										</p>
									</div>

									<div id="div<%=fld%>Text" name="div<%=fld%>Text" class="divShow">
										<div id="div<%=fld%>TextContent"><%=fd.getString5()%>
										</div>
										<div class="new_line_padded">
										</div>
										<p>
											<button name="btn<%=fld%>Editx" type="button" class="btn btn-primary btn-xs" onclick="hideShowControlsCKEditor('e','<%=fld%>'); return false;">edit</button>
										</p>
									</div>

								</div>

							<%

						}
						else{
							out.println("		<div class=\"panel-heading alignleft\">");
							out.println("			<h3 class=\"panel-title\">"+ sq + ". " + fd.getString4() +"</h3>");
							out.println("		</div> <!-- panel-heading -->");
						}

					} // for generic

					out.println("</div> <!-- panel-primary -->");
					out.println("</div> <!-- bs-example -->");

				} // for i

			} // if list


			if(messageBoard.equals(Constant.ON)){
				reviewerComments = "" + ForumDB.countPostsToForum(conn,kix,0,0,0);
			}
			else{
				reviewerComments = "" + ReviewerDB.countReviewerComments(conn,kix,0,0,0,Constant.TAB_FOUNDATION,0);
			}

			if(reviewerComments.equals("0")){
				reviewerComments = "";
			}
			else{
				reviewerComments = " (" + reviewerComments + ")";
			}

		} // process page

		paging = null;

	%>

	<form method="post" name="aseForm" action="?">
		<div id="buttonDiv">
			<div id="buttonDivLeft">
			</div>
			<div id="buttonDivRight">
				<button name="cmdAttach" id="cmdAttach" title="attach/upload documents" type="button" class="btn btn-primary btn-sm">Attach</button>
				<button name="cmdLinkItems" id="cmdLinkItems" title="link items" type="button" class="btn btn-primary btn-sm">Link Items</button>
				<button name="cmdReview" id="cmdReview" title="request review" type="button" class="btn btn-success btn-sm">Review</button>
				<button name="cmdApproval" id="cmdApproval" title="request approval" type="button" class="btn btn-success btn-sm">Approval</button>
				<button name="cmdViewComments" id="cmdViewComments" title="view all comments" type="button" class="btn btn-info btn-sm">View Comments<%=reviewerComments%></button>
				<button name="cmdPrint" id="cmdPrint" title="print foundation" type="button" class="btn btn-info btn-sm">Print</button>
				<button name="cmdClose" id="cmdClose" title="end editing" type="button" class="btn btn-warning btn-sm">Close</button>
				<input name="filename" id="filename" value="" type="hidden">
				<input name="prependedFileName" id="prependedFileName" value="" type="hidden">
				<input name="FileUpload" id="FileUpload" value="0" type="hidden">
				<input name="en" id="en" value="0" type="hidden">
				<input name="sq" id="sq" value="0" type="hidden">
				<input name="qn" id="qn" value="0" type="hidden">
				<input name="id" id="id" value="<%=id%>" type="hidden">
				<input name="alpha" id="alpha" value="<%=alpha%>" type="hidden">
				<input name="num" id="num" value="<%=num%>" type="hidden">
			</div>
		</div>
	</form>

	<div class="new_line_padded">
	<div class="new_line_padded">

	<%@ include file="fndattach00.jsp" %>

<%
	fnd = null;

	asePool.freeConnection(conn,"fndedt",user);
%>

<%@ include file="../inc/footer.jsp" %>

<script type="text/javascript">
//<![CDATA[

		$(function()
		{
		}); // jq

		//
		// globals
		//
		var lastDivEditor = "";
		var lastDivText = "";
		var lastDivTextControl = "";
		var lastControl = "";
		var editor;
		var editorContent = "";
		var fndID = <%=id%>;

		var config = {
			toolbar:
			[
			 { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
			 { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
			 { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo', 'Source' ] }
			],
			enterMode: CKEDITOR.ENTER_BR,
			shiftEnterMode: CKEDITOR.ENTER_P,
			toolbarCanCollapse: false,
			width: '100%',
			removePlugins: 'elementspath'
		};

		//
		// hideShowControls
		//
		function hideShowControlsTextArea(mode,control){

			/*
				NOTE: Using this does not hold the carriage return linefeed when
						display on screen.
			*/

			//
			// control as variables
			//
			var divEditor = "#div"+control+"Editor";
			var divText = "#div"+control+"Text";
			var textAreaControl = "#editorFG_1_1_0";

			//
			// this one does not have #
			//
			var divTextContent = "div"+control+"TextContent";


			if(mode=="s"){
				editorContent = $(textAreaControl).val();
				document.getElementById(lastDivTextContent).innerHTML = editorContent;
				saveData();
			}
			else if(mode=="w"){

				//
				// hide the last editor used
				//
				if(lastDivEditor != ""){
					$(lastDivEditor).addClass('divHidden');
					$(lastDivText).removeClass('divHidden');
				}

				lastDivEditor = "";
				lastDivText = "";
				lastDivTextControl = "";
				lastControl = "";
			}
			else if(mode=="e"){

				//
				// hide the last editor used
				//
				if(lastDivEditor != ""){
					$(lastDivEditor).addClass('divHidden');
					$(lastDivText).removeClass('divHidden');
				}

				//
				// display requested editor
				//
				$(divEditor).removeClass('divHidden');
				$(divText).addClass('divHidden');

			} // mode

			//
			// save to hide when we come back this way
			//
			lastDivEditor = divEditor;
			lastDivText = divText;
			lastDivTextContent = divTextContent;
			lastControl = control;

			return false;

		}

		//
		// hideShowControls
		//
		function hideShowControlsCKEditor(mode,control){

			/*
				NOTE: Using this breaks popup attachment page processing
						so processing is moved off to a separate page. This is a benefit
						since returning from processing shows all attached documents
			*/

			//
			// control as variables
			//
			var divEditor = "#div"+control+"Editor";
			var divText = "#div"+control+"Text";

			//
			// period in front of jq
			//
			var jqControl = ".jquery_ckeditor"+control;

			//
			// this one does not have #
			//
			var divTextContent = "div"+control+"TextContent";

			if(mode=="s"){
				editorContent = editor.getData();
				document.getElementById(lastDivTextContent).innerHTML = editorContent;
				saveData();
			}
			else if(mode=="w"){

				//
				// editor content for saving
				//
				if (editor && editor.checkDirty()){
					if(confirm("Do you want to save changes?")){
						editorContent = editor.getData();
						document.getElementById(lastDivTextContent).innerHTML = editorContent;
						saveData();
					}
				}

				if(editor){
					editor.destroy();
				}

				//
				// hide the last editor used
				//
				if(lastDivEditor != ""){
					$(lastDivEditor).addClass('divHidden');
					$(lastDivText).removeClass('divHidden');
				}

				lastDivEditor = "";
				lastDivText = "";
				lastDivTextControl = "";
				lastControl = "";
			}
			else if(mode=="e"){
				//
				// editor content for saving
				//
				if (editor && editor.checkDirty()){
					if(confirm("Do you want to save changes?")){
						editorContent = editor.getData();
						document.getElementById(lastDivTextContent).innerHTML = editorContent;
						saveData();
					}
				}

				if(editor){
					editor.destroy();
				}

				//
				// hide the last editor used
				//
				if(lastDivEditor != ""){
					$(lastDivEditor).addClass('divHidden');
					$(lastDivText).removeClass('divHidden');
				}

				//
				// display requested editor
				//
				$(divEditor).removeClass('divHidden');
				$(divText).addClass('divHidden');

				// Initialize the editor.
				// Callback function can be passed and executed after full instance creation.
				$(jqControl).ckeditor(config);
				editor = $(jqControl).ckeditor(config).editor;


			} // mode

			//
			// save to hide when we come back this way
			//
			lastDivEditor = divEditor;
			lastDivText = divText;
			lastDivTextContent = divTextContent;
			lastControl = control;

			return false;

		}

		//
		// saveData
		//
		function saveData(){

			//var message = "";

			 $.ajax({
					type:       "post",
					url:        "fndedtx.jsp",
					async: false,
					timeout: 3000,
					data:       {"id":fndID,"col":lastControl,"dta":editorContent},
					success:    function(msg) {
						//message = "Data saved successfully";
						//document.getElementById("output").innerHTML = "<font color=\"#FF7C01\">" + message + "</font>";
					},
					error:function (xhr, ajaxOptions, thrownError){
						//message = xhr.status;
						//document.getElementById("output").innerHTML = "<font color=\"#FF7C01\">" + message + "</font>";
					}
			 });

			editor.resetDirty();

		}

		//
		// register save command
		//
		CKEDITOR.plugins.registered['save'] = {
			 init : function( editor ) {
				var command = editor.addCommand( 'save',
					 {
						 modes : { wysiwyg:1, source:1 },
						 exec : function(editor) {

							if(editor.checkDirty() && fndID > 0){

								saveData(fndID);

							} // input

						 }
					 }
				);
				editor.ui.addButton( 'Save',{label : 'Save',command : 'save'});
			 }
		  }

//]]>
</script>

<script type="text/javascript">

	$(document).ready(function(){

		//
		// cmdAttach
		//
		$("#cmdAttach").click(function() {

			/*
			var popID = "helpPopup";
			var popWidth = "500";

			$('input[name=en]').val('0');
			$('input[name=sq]').val('0');
			$('input[name=qn]').val('0');

			attachmentForm(popID,popWidth);

			*/

			window.location = "fndattach.jsp?kix=<%=kix%>";

			return false;

		});

		//
		// attachmentForm
		//
		function attachmentForm(popID,popWidth) {

			//Fade in the Popup and add close button
			$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="closePopup" id="closePopup"><img src="/central/inc/popup/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>');

			//Define margin for center alignment (vertical + horizontal) - we add 80 to the height/width to accomodate for the padding + border width defined in the css
			var popMargTop = ($('#' + popID).height() + 80) / 2;
			var popMargLeft = ($('#' + popID).width() + 80) / 2;

			//Apply Margin to Popup
			$('#' + popID).css({
				'margin-top' : -popMargTop,
				'margin-left' : -popMargLeft
			});

			//Fade in Background
			$('body').append('<div id="fade"></div>'); 		//Add the fade layer to bottom of the body tag.
			$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer

			return false;

		}

		//
		// attach-link
		//
		$('.attach-link').click( function() {

				var attachURL = $(this).attr('href');
				var query= attachURL.split('?');
				var dim = query[1].split('&');

				var en = dim[0].split('=')[1];
				var sq = dim[1].split('=')[1];
				var qn = dim[2].split('=')[1];

				$('input[name=en]').val(en);
				$('input[name=sq]').val(sq);
				$('input[name=qn]').val(qn);

				var popID = "helpPopup";
				var popWidth = "500";

				attachmentForm(popID,popWidth);

				return false; // don't follow the link!
		});

		//
		// cmdClose
		//
		$("#cmdClose").click(function() {

			//window.location = "fndvwedit.jsp";

			window.location = "fndedty.jsp?kix=<%=kix%>";

			return false;

		});

		//
		// cmdViewComments
		//
		$("#cmdViewComments").click(function() {

			var myLink = "";

			var messageBoard = '<%=messageBoard%>';

			if(messageBoard=='1'){
				myLink = "./forum/prt.jsp?fid=<%=fid%>&mid=0&itm=0&sq=0&en=0&qn=0";
			}
			else{
				myLink = "crsrvwcmnts.jsp?md=0&kix=<%=kix%>&qn=0";
			}

			var win2 = window.open(myLink, 'myWindow','toolbar=no,width=900,height=800,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');

			return false;

		});

		//
		// cmdPrint
		//
		$("#cmdPrint").click(function() {

			var myLink = "vwpdf.jsp?kix=<%=kix%>";

			var win2 = window.open(myLink, 'myWindow','toolbar=no,width=900,height=800,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');

			return false;

		});

		//
		// cmdLinkItems
		//
		$("#cmdLinkItems").click(function() {

			var myLink = "fndlnkd.jsp?id=<%=id%>";

			var win2 = window.open(myLink, 'myWindow','toolbar=no,width=900,height=600,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');

			return false;

		});


		//
		// cmdApproval
		//
		$("#cmdApproval").click(function() {

			window.location = "fndedt6.jsp?kix=<%=kix%>&progress=APPROVAL";

			return false;

		});

		//
		// cmdReview
		//
		$("#cmdReview").click(function() {

			window.location = "fndedt6.jsp?kix=<%=kix%>&progress=REVIEW";

			return false;

		});

	}); // jq

</script>

</body>
</html>

