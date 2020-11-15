<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	expand.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "tasks";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Foundation";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix", "");

	//
	// for testing only
	//

	campus = "KAP";
	String alpha = "VIET";
	String num = "197F";
	if(kix.equals(Constant.BLANK)){
		kix = helper.getKix(conn,campus,alpha,num,"CUR");
		campus = "KAP";
	}

	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	if (processPage){
		//
	} //processPage

%>

<html>
<head>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<%@ include file="ase2.jsp" %>

	<style type="text/css">
		/* --------
		  The CSS rules offered here are just an example, you may use them as a base.
		  Shape your 'expand/collapse' content so that it meets the style of your site.
		 --------- */
		#wrapper{
		  width:100%;
		  margin:0 auto;
		  text-align:left
		}

		#content {
		  max-width:70em;
		  width:100%;
		  margin:0 auto;
		  padding-bottom:20px;
		  overflow:hidden
		}
		.demo {
		  margin:0;
		  padding:1.5em 1.5em 0.75em;
		  border:1px solid #ccc;
		  position:relative;
		  overflow:hidden
		}

		.commands div {
		  display: inline-block;
		  float: right;
			padding-left: 10px;
		}

		div.collapse {
			padding:0 10px 1em;
			border: solid 2px Transparent;
			padding-left: 15px;
			padding-right: 15px;
		}

		div.collapse:hover
		{
			border-color: #c0c0c0;
		}

		.collapse p {padding:0 10px 1em}
		.top{font-size:.9em; text-align:right}
		#switch, .switch {margin-bottom:5px; text-align:right}

		/* --- Headings  --- */
		h1 {
		  margin-bottom:.75em;
		  font-family:georgia,'times new roman',times,serif;
		  font-size:2.5em;
		  font-weight:normal;
		  color:#c30
		}
		h2{font-size:1em}

		.expand{padding-bottom:.75em}

		/* --- Links  --- */
		a:link, a:visited {
		  border:1px dotted #ccc;
		  border-width:0 0 1px;
		  text-decoration:none;
		  color:blue
		}
		a:hover, a:active, a:focus {
		  border-style:solid;
		  background-color:#f0f0f0;
		  outline:0 none
		}

		a:active, a:focus {
		  color:red;
		}

		.expand a {
		  display:block;
		  padding:3px 10px
		}

		.expand a:link, .expand a:visited {
		  border-width:1px;
		  background-image:url(img/arrow-down.gif);
		  background-repeat:no-repeat;
		  background-position:98% 50%;
		  color: #083772;
		}

		.expand a:hover, .expand a:active, .expand a:focus {
		  color: #E87B10;
		}

		.expand a.open:link, .expand a.open:visited {
		  border-style:solid;
		  background:#eee url(img/arrow-up.gif) no-repeat 98% 50%
		}
	</style>

	<!--[if lte IE 7]>
		<style type="text/css">
		h2 a, .demo {position:relative; height:1%}
		</style>
	<![endif]-->

	<!--[if lte IE 6]>
		<script type="text/javascript">
			try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
		</script>
	<![endif]-->
	<!--[if !lt IE 6]><!-->

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="./js/expand_collapse.js"></script>
	<link type="text/css" href="./js/plugins/jquery/css/ui-lightness/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />

	<script type="text/javascript">

		<!--//--><![CDATA[//><!--
		$(document).ready(function(){
			$("h2.expand").toggler({initShow: "div.collapse"});
			$("#content").expandAll({trigger: "h2.expand", ref: "div.demo",  speed: 300, oneSwitch: false});
		})(jQuery);
		//--><!]]>

	</script>
	<!--<![endif]-->

	<script type="text/javascript">

		var editor;
		var html = '';

		// Create a new editor inside the <div id="editor">, setting its data to html
		CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
		CKEDITOR.config.shiftEnterMode = CKEDITOR.ENTER_P;
		CKEDITOR.config.toolbarCanCollapse = false;
		CKEDITOR.config.width = '100%';
		CKEDITOR.config.removePlugins = 'elementspath';
		CKEDITOR.config.toolbar =
		[
			 { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
			 { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
			 { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo', 'Source' ] }
		];

		/**
		*
		* createEditor
		*
		**/
		function createEditor(divID){

			if (editor){
				return;
			}

			showProgress(divID);

			document.getElementById("output").innerHTML = "&nbsp;";

			//
			// take the value from the displayed text and hold for later use
			// clear the display text div so we dont have large space take up room
			// hide display only text since it's going to show in the editor
			//

			var displayDiv = "aseDisplayDiv"+divID;
			var editorDiv = "aseEditorDiv"+divID;
			var editCommandDiv = "aseeditCommandDiv"+divID;
			var saveCommandDiv = "asesaveCommandDiv"+divID

			var data = document.getElementById(displayDiv).innerHTML;
			document.getElementById(displayDiv).innerHTML = "";
			document.getElementById(displayDiv).style.visibility = "hidden";

			document.getElementById(editorDiv).style.visibility = "visible";

			// save for restore to cancel operation
			html = data;

			editor = CKEDITOR.appendTo(editorDiv, null, data);

			document.getElementById(editCommandDiv).style.visibility = "hidden";
			document.getElementById(saveCommandDiv).style.visibility = "visible";

			hideProgress(divID);
		}

		/**
		*
		* cancelEditor
		*
		**/
		function cancelEditor(divID){

			if (!editor){
				return;
			}

			showProgress(divID);

			var displayDiv = "aseDisplayDiv"+divID;
			var editorDiv = "aseEditorDiv"+divID;
			var editCommandDiv = "aseeditCommandDiv"+divID;
			var saveCommandDiv = "asesaveCommandDiv"+divID

			document.getElementById(editorDiv).innerHTML = "";
			document.getElementById(editorDiv).style.visibility = "hidden";

			document.getElementById(saveCommandDiv).style.visibility = "hidden";

			document.getElementById(displayDiv).innerHTML = html;
			document.getElementById(displayDiv).style.visibility = "visible";

			document.getElementById(editCommandDiv).style.visibility = "visible";

			// Destroy the editor.
			editor.destroy();
			editor = null;

			hideProgress(divID);

		}

		/**
		*
		* saveEditor
		*
		**/
		function saveEditor(divID,kix,col){

			if (!editor){
				return;
			}

			showProgress(divID);

			var displayDiv = "aseDisplayDiv"+divID;
			var editorDiv = "aseEditorDiv"+divID;
			var editCommandDiv = "aseeditCommandDiv"+divID;
			var saveCommandDiv = "asesaveCommandDiv"+divID

			if(editor.checkDirty()){

				var data = editor.getData();

				var message = "";

				 $.ajax({
					  type:       "post",
					  url:        "expandx.jsp",
					  data:       {"kix":kix,"col":col,"dta":data},
					  success:    function(msg) {
						  	message = "Data saved successfully";
							document.getElementById("output").innerHTML = "<font color=\"#FF7C01\">" + message + "</font>";
						},
						error:function (xhr, ajaxOptions, thrownError){
						  	message = xhr.status;
							document.getElementById("output").innerHTML = "<font color=\"#FF7C01\">" + message + "</font>";
						}
				 });

				html = data;

				editor.resetDirty();

			} // dirty?

			document.getElementById(editorDiv).innerHTML = '';
			document.getElementById(editorDiv).style.visibility = "hidden";

			document.getElementById(saveCommandDiv).style.visibility = "hidden";

			document.getElementById(displayDiv).innerHTML = html;
			document.getElementById(displayDiv).style.visibility = "visible";

			document.getElementById(editCommandDiv).style.visibility = "visible";

			// Destroy the editor.
			editor.destroy();
			editor = null;

			hideProgress(divID);

		}

		/**
		*
		* showProgress
		*
		**/
		function showProgress(divID){

			document.getElementById("aseProgressDiv"+divID).innerHTML = "<img src='/central/images/loading-orange.gif'>";

		}

		/**
		*
		* hideProgress
		*
		**/
		function hideProgress(divID){

			document.getElementById("aseProgressDiv"+divID).innerHTML = "";

		}

	</script>

</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

	<%
		//
		// to put expand/collapse link at top of page, put div with id=content between
		// wrapper and demo
		//
	%>

    <div id="wrapper">
        <div id="content">
          <div class="demo">
     			<div id="output">&nbsp;</div>
          	<%

					CCCM6100 cccm6100 = null;
          		String[] item = "X46,coursedescr,X20,X60,X38".split(",");
          		int[] seq = new int[5];
          		seq[0] = 3;
          		seq[1] = 15;
          		seq[2] = 23;
          		seq[3] = 43;
          		seq[4] = 44;

          		String question = "";
          		String answer = "";

          		for(int i=0; i<5; i++){

						cccm6100 = CCCM6100DB.getCCCM6100(conn,seq[i],campus,1);
						if ( cccm6100 != null ){
							question = cccm6100.getCCCM6100();
						}

						cccm6100 = null;

						answer = courseDB.getCourseItem(conn,kix,item[i]);

				%>
					<h2 class="expand"><%=question%></h2>
					<div class="collapse">
						<div id="aseDisplayDiv<%=i%>">
							 <%=answer%>
						</div>

						<div id="aseEditorDiv<%=i%>"></div>

						<div id="aseeditCommandDiv<%=i%>" class="commands" style="visibility: show">
							<div><a href="#content"><img src="/central/images/top.gif" width="18"></a></div>
							<div>
								<a href="#" onclick="return createEditor('<%=i%>');">
									<img src="/central/images/edit.gif">
								</a>
							</div>
						</div>

						<div id="asesaveCommandDiv<%=i%>" class="commands" style="visibility: hidden">
							<div><a href="#" onclick="return cancelEditor('<%=i%>');"><img src="/central/images/cancel.jpg" width="18"></a></div>
							<div>
								<a href="#" onclick="return saveEditor('<%=i%>','<%=kix%>','<%=item[i]%>');">
									<img src="/central/images/save.png" width="18">
								</a>
							</div>
						</div>

						<div id="aseProgressDiv<%=i%>"></div>

						<div class="new_line_padded">&nbsp;</div>

					</div>

				<%
					} // for
          	%>

          </div>
          </div>
    </div>

<%
	asePool.freeConnection(conn,"expand",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
