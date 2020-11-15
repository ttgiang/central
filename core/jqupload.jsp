<link rel="stylesheet" href="./css/helppopup.css">
<script type="text/javascript" src="js/jquery.min.popup.js"></script>
<script type="text/javascript" src="js/helppopup.js"></script>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>

<script type="text/javascript">

	function ajaxFileUpload(){

		jQuery("#loading")

			.ajaxStart(function(){
				jQuery(this).show();
			})

			.ajaxComplete(function(){
				jQuery(this).hide();
			});

			jQuery.ajaxFileUpload({
				url:'doupload.jsp',
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

							if (document.getElementById("uploadDiv")){
								document.getElementById("uploadDiv").innerHTML = "<img src=\"" + data.linkedName + data.originalFileName + "\">";
								document.aseForm.filename.value =  data.originalFileName;
								document.aseForm.weburl.value =  data.originalFileName;
							}

							$('.close').click();
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
	<form enctype="multipart/form-data" id="image" name="image" method="post" action="imageuploadx.jsp">
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
