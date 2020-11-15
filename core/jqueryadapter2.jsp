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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>jQuery Adapter &mdash; CKEditor Sample</title>
	<meta content="text/html; charset=utf-8" http-equiv="content-type" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
	<script type="text/javascript" src="../ckeditor431/ckeditor.js"></script>
	<script type="text/javascript" src="../ckeditor431/adapters/jquery.js"></script>

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
				width: '100%',
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
			function saveDataX(id){


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

	<style>
		.divHidden { display: none !important; }
		.divShow { display: visible !important; }
	</style>

</head>
<body>
	<form action="sample_posteddata.php" method="post" name="ccForm" id="ccForm">
	<p>
		<%
			for(int i = 0; i < 3; i++){

				String si = "";
				if(i < 10){
					si = "0" + i;
				}
				else{
					si = "" + i;
				}
		%>
			<label for="editor<%=si%>">Editor <%=si%>:</label>
			<div id="div<%=si%>Editor" name="div<%=si%>Editor" class="divHidden ">
				<textarea class="jquery_ckeditor<%=si%>" cols="80" id="editor<%=si%>" name="editor<%=si%>" rows="10">
					This is control <%=si%>.
				</textarea>
				<p>
				<a href="##" name="btn<%=si%>Savex" onclick="hideShowControls('s','<%=si%>'); return false;"><img src="/central/images/save1.png" width="16px"></a>
				</p>
			</div>
			<div id="div<%=si%>Text" name="div<%=si%>Text"  class="divShow ">
				<div id="div<%=si%>TextContent">This is control <%=si%>.</div>
				<p>
				<a href="##" name="btn<%=si%>Editx" onclick="hideShowControls('e','<%=si%>'); return false;"><img src="/central/images/edit.gif" width="16px"></a>
				</p>
			</div>
		<%
			} // for
		%>

	</p>
	</form>
</body>
</html>
