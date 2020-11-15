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
	fieldsetTitle = pageTitle;

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

%>

<html>
<head>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
	<script type="text/javascript" src="../ckeditor431/ckeditor.js"></script>
	<script type="text/javascript" src="../ckeditor431/adapters/jquery.js"></script>

	<script type="text/javascript" src="js/ajaxfileupload.js"></script>

	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="./js/fndedt.js"></script>
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

	</style>

	<style>
		.divHidden { display: none !important; }
		.divShow { display: visible !important; }
	</style>

</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

	<h1 class="samples"><%=pageTitle%></h1>

	<hr>

	<%
		if(processPage){

			for(com.ase.aseutil.Generic fd: fnd.getCourseFoundation(conn,id)){

				String fld = fd.getString6();

				int sq = NumericUtil.getInt(fd.getString1(),0);
				int en = NumericUtil.getInt(fd.getString2(),0);
				int qn = NumericUtil.getInt(fd.getString3(),0);

				String question = "";
				String data = "";
				if(en > 0 || qn > 0){
					//
					// question or explanatory
					//
					question = "" + fd.getString4()
						+ "&nbsp;<a href=\"?sq="+sq+"&en="+en+"&qn="+qn+"\" class=\"attach-link\"><img src=\"../images/clip.gif\" alt=\"click to attach file\" title=\"click to attach file\"></a>&nbsp;"
						+ "";

					out.println("<div align=\"left\">" + question + "</div>");
					%>

					<div align="left">
						<div id="div<%=fld%>Editor" name="div<%=fld%>Editor" class="divHidden ">
							<textarea class="jquery_ckeditor<%=fld%>" cols="80" id="editor<%=fld%>" name="editor<%=fld%>" rows="10">
								This is control <%=fld%>.
							</textarea>
							<p>
							<a href="##" name="btn<%=fld%>Savex" onclick="hideShowControls('s','<%=fld%>'); return false;"><img src="/central/images/save1.png" width="16px"></a>
							</p>
						</div>
						<div id="div<%=fld%>Text" name="div<%=fld%>Text"  class="divShow ">
							<div id="div<%=fld%>TextContent">This is control <%=fld%>.</div>
							<p>
							<a href="##" name="btn<%=fld%>Editx" onclick="hideShowControls('e','<%=fld%>'); return false;"><img src="/central/images/edit.gif" width="16px"></a>
							</p>
						</div>
					</div>

					<%

				}
				else{
					question = "<h2 class=\"question\">" + sq + ". " + fd.getString4() + "</h2>";

					out.println("<div align=\"left\">" + question + "</div>");
				}

			} // for

		} // process page

		paging = null;

	%>

	<hr/>

	<form method="post" name="aseForm" action="?">
		<div id="divTitle">
			<div id="divLeft">
				<table id="report">
					<tbody>
						<%
							for(com.ase.aseutil.Generic u: fnd.getAttachmentsMaster(conn,campus,id)){

								int seq = NumericUtil.getInt(u.getString1(),0);

								String fileName = u.getString2();

								String extension = AseUtil2.getFileExtension(fileName);

								if (!(Constant.FILE_EXTENSIONS).contains(extension)){
									extension = "default.icon";
								}
						%>
								<tr class="odd">
									<td><a href="/centraldocs/docs/fnd/<%=campus%>/<%=u.getString5()%>" target="_blank"><img src="/central/images/ext/<%=extension%>.gif" border="0"></a>&nbsp;</td>
									<td><%=fileName%></td>
									<td><%=u.getString3()%></td>
									<td><%=u.getString4()%></td>
									<td><div class="arrow"></div></td>
								</tr>

								<tr style="display: none; ">
									<td>&nbsp;</td>
									<td colspan="4" id="extension">

						<%
								for(com.ase.aseutil.Generic v: fnd.getAttachmentsDetail(conn,campus,id,seq,fileName)){
								%>
											&nbsp;&nbsp;<a href="/centraldocs/docs/fnd/<%=campus%>/<%=v.getString5()%>" target="_blank"><img src="/central/images/ext/<%=extension%>.gif" border="0"></a>&nbsp;
											<%=fileName%>&nbsp;
											<%=v.getString3()%>&nbsp;
											<%=v.getString4()%>&nbsp;
											<br/>
								<%
								} // for v

						%>
										<br/>
									</td>
								</tr>
						<%
							} // for u
						%>

					</tbody>
				</table>
			</div>
			<div id="divRight">
				<br/>
				<input name="cmdReview" id="cmdReview" title="request outline review" type="submit" value="Review" class="confirm_button green styled_button">&nbsp;
				<input name="cmdApproval" id="cmdApproval" title="request outline approval" type="submit" value="Approval" class="confirm_button grey styled_button">&nbsp;
				<input name="cmdAttach" id="cmdAttach" title="attach/upload documents" type="submit" value="Attach" class="confirm_button blue styled_button">&nbsp;
				<input name="cmdLinkItems" id="cmdLinkItems" title="link items" type="submit" value="Link Items" class="confirm_button blue styled_button">&nbsp;
				<input name="cmdPrint" id="cmdPrint" title="print" type="submit" value="Print" class="confirm_button blue styled_button">&nbsp;
				<input name="cmdClose" id="cmdClose" title="end this operation" type="submit" value="Close" class="confirm_button red styled_button">&nbsp;
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

<%
	fnd = null;

	asePool.freeConnection(conn,"fndedt",user);
%>

<%@ include file="../inc/footer.jsp" %>

<!-- jqupload -->

	<link rel="stylesheet" href="./css/helppopup.css">
	<link type="text/css" href="./js/plugins/jquery/css/ui-lightness/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />

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
			var editor;

			var config = {
				toolbar:
				[
				 { name: 'savestyles', items : [ 'Save' ] },
				 { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
				 { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
				 { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo', 'Source' ] }
				],
				enterMode: CKEDITOR.ENTER_BR,
				shiftEnterMode: CKEDITOR.ENTER_P,
				toolbarCanCollapse: false,
				width: '80%',
				removePlugins: 'elementspath'
			};

			//
			// hideShowControls
			//
			function hideShowControls(mode,control){

				//
				// control as variables
				//
				var divEditor = "#div"+control+"Editor";
				var divText = "#div"+control+"Text";
				var jqControl = ".jquery_ckeditor"+control;

				//
				// this one does not have #
				//
				var divTextContent = "div"+control+"TextContent";

				//
				// editor content for saving
				//
				if (editor && editor.checkDirty()){
					if(confirm("Do you want to save changes?")){
						var content = editor.getData();
						document.getElementById(lastDivTextContent).innerHTML = content;
						//saveData(fndID);
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

				//
				// save to hide when we come back this way
				//
				lastDivEditor = divEditor;
				lastDivText = divText;
				lastDivTextContent = divTextContent;

				return false;

			}

			//
			// saveData
			//
			function saveData(id){

				//
				// toggle code works. ajax too fast
				// async code is fine. ajax too fast
				//

				var input = editor.getData();

				//var message = "";

				 $.ajax({
						type:       "post",
						url:        "fndedtx.jsp",
						async: false,
						timeout: 3000,
						data:       {"id":id,"col":lastControl,"dta":input},
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

			//
			// cancelData
			//
			function cancelData(id){

				toggleVisibility("spinner_"+control);

				//
				// hide buttons between div changes
				//
				if(lastControl && lastControl != ''){
					document.getElementById("buttonDivRight" + lastControl).innerHTML = "";
				}

				if(editor){
					editor.destroy();
					editor = null;
				}

				//
				// reset
				//
				lastControl = '';

				toggleVisibility("spinner_"+control);

			}

	//]]>
	</script>

	<script type="text/javascript">

		$(document).ready(function(){

			//
			// ase removed this line to avoid too many colors
			//
			//$("#report tr:odd").addClass("odd");
			$("#report tr:not(.odd)").hide();
			$("#report tr:first-child").show();

			$("#report tr.odd").click(function(){
				 $(this).next("tr").toggle();
				 $(this).find(".arrow").toggleClass("up");
			});
			//$("#report").jExpand();

			//
			// cmdAttach
			//
			$("#cmdAttach").click(function() {

				var popID = "helpPopup";
				var popWidth = "500";

				$('input[name=en]').val('0');
				$('input[name=sq]').val('0');
				$('input[name=qn]').val('0');

				attachmentForm(popID,popWidth);

				return false;

			});

			//
			// attachmentForm
			//
			function attachmentForm(popID,popWidth) {

				//Fade in the Popup and add close button
				$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/central/inc/popup/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>');

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

				window.location = "fndvwedit.jsp";

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

			//
			// Close Popups and Fade Layer
			//
			$('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
				$('#fade , .popup_block').fadeOut(function() {
					$('#fade, a.close').remove();
				}); //fade them both out

				return false;
			});

		}); // jq

		//
		// ajaxFileUpload
		//
		function ajaxFileUpload(){

			var en = $("#en").val();
			var sq = $("#sq").val();
			var qn = $("#qn").val();
			var id = $("#id").val();
			var alpha = $("#alpha").val();
			var num = $("#num").val();

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

								//
								// tell form that an upload took place
								//
								document.aseForm.FileUpload.value =  "1";
								document.aseForm.filename.value =  data.originalFileName;
								document.aseForm.prependedFileName.value =  data.prependedFileName;

								$('.close').click();

								$('input[name=en]').val('0');
								$('input[name=sq]').val('0');
								$('input[name=qn]').val('0');

							} // data.error

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

<div id="helpPopup" class="popup_block" style="width: 500px; margin-top: -159px; margin-left: -290px; display: none; ">
	<form enctype="multipart/form-data" id="image" name="image" method="post" action="fndedt.jsp">
		<table width="100%" border="0" cellspacing="10"  cellpadding="0" >
			<tr>
				<td style="color:#FDBA45">
					<input id="fileName"  name="fileName" type="file" />
					<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();">Upload</button><span id="loading" style="display: none;"><img src="./images/loading-orange.gif"></span>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- jqupload -->

</body>
</html>

