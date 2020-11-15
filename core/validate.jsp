<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
 .bp_invalid {
    color:white;
    background:red;
 }
 .bp_valid {
    color:green;
 }
</style>

<script type="text/javascript">
	function AJAXInteraction(url, callback) {

		 var req = init();
		 req.onreadystatechange = processRequest;

		 function init() {
			if (window.XMLHttpRequest) {
			  return new XMLHttpRequest();
			} else if (window.ActiveXObject) {
			  return new ActiveXObject("Microsoft.XMLHTTP");
			}
		 }

		 function processRequest () {
			// readyState of 4 signifies request is complete
			if (req.readyState == 4) {
			  // status of 200 signifies sucessful HTTP call
			  if (req.status == 200) {
				 if (callback) callback(req.responseXML);
			  }
			}
		 }

		 this.doGet = function() {
			req.open("GET", url, true);
			req.send(null);
		 }
	}

	function validateUserId() {
		 var target = document.getElementById("userid");
		 var url = "/central/servlet/validate?id=" + encodeURIComponent(target.value);
		 var ajax = new AJAXInteraction(url, validateCallback);
		 ajax.doGet();
	}

	function validateCallback(responseXML) {
		var msg = responseXML.getElementsByTagName("valid")[0].firstChild.nodeValue;
		if (msg == "false"){
			 var mdiv = document.getElementById("userIdMessage");
			 mdiv.className = "invalidEntry";
			 mdiv.innerHTML = "Invalid User Id";
			 var submitBtn = document.getElementById("submit_btn");
			 submitBtn.disabled = true;
		 } else {
			 var mdiv = document.getElementById("userIdMessage");
			 mdiv.className = "validEntry";
			 mdiv.innerHTML = "Valid User Id";
			 var submitBtn = document.getElementById("submit_btn");
			 submitBtn.disabled = false;
		 }
	}
</script>
 <title>Form Data Validation using AJAX</title>
</head>
 <body>

 <h1>Form Data Validation using AJAX</h1>
 <hr/>
 <p>
 This example shows how you can use AJAX to do server-side form data validation without
 a page reload.
 </p>
 <p>
 In the form below enter a user id. By default the user ids &quot;greg&quot;, &quot;duke&quot;
 and "&#x306D&#x3053" are taken. If you attempt to enter a user id that has been taken an error message will be
 displayed next to the form field and the &quot;Create Account&quot; button will be
 disabled. After entering a valid user id and selecting the &quot;Create Account&quot;
 button that user id  will be added to the list of user ids that are taken.
 </p>

  <form name="updateAccount" action="/central/servlet/validate" method="post">
   <input type="hidden" name="action" value="create"/>
   <table border="0" cellpadding="5" cellspacing="0">
    <tr>
     <td><b>User Id:</b></td>
     <td>
      <input type="text" size="20" id="userid" name="id" autocomplete="off" onkeyup="validateUserId()">
     </td>
     <td>
      <div id="userIdMessage"></div>
     </td>
    </tr>
    <tr>
     <td align="right" colspan="2">
      <input id="submit_btn" type="Submit" value="Create Account" onClick="validateUserId()">
     </td>
     <td></td>
	</tr>
   </table>
  </form>
 </body>
</html>
