<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link type="text/css" rel="stylesheet" href="/jquery/modal03/inc/cc.css" />

	<script type='text/javascript'>
		<!--
			function saveQuickComments(){

				document.getElementById("ajaxpopform").style.display="none";

				document.getElementById("ajaxpopform-success").style.display="block";

				return false;
			}
		-->
	</script>

</head>
<body>

<form method="post" id="ajaxpopform" class='ajaxpopform'  action="/feedback/post/ajax/"  >

	<div class='ajaxpopformwrapper'>

		<div class="ajaxpopforminner">
			<h2>Contact Us</h2>
			<fieldset>
				<label for="help-us-email">Your email address:</label>
				<div class="field"><input type="text" name="email" id="help-us-email" value="" /></div>
			</fieldset>
			<fieldset>
				<label for="help-us-message">Comments:</label>
				<div class="field"><textarea id="help-us-message" name="message" cols="20" rows="5"></textarea></div>
			</fieldset>
		</div>

		<div class="buttons">
			<div class="submit-button">
				<a class="button form-submit-button"><span class="inner">Save</span></a>
			</div>
			<a class="button cancel" onClick="saveQuickComments();"><span class="inner">Cancel</span></a>
		</div>
	</div>

	<div style="display:none" id="ajaxpopform-success">
		<div class="inner">
			<h4>Processing completed successfully.</h4>
		</div>
		<div class="buttons">
		<a class="button cancel"><span class="inner">Close</span></a>
		</div>
	</div>

</form>

</body>
</html>
