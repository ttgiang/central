<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
   <title></title>

	<script type='text/javascript'>
		<!--
			function quickComments(c,mode,kix,num){

				var aseWindow = null;
				var w = '440';
				var h = '360';
				var scroll = 'yes';
				var pos = 'center';

				if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}

				if(pos=="center"){
					LeftPosition=(screen.width)?(screen.width-w)/2:100;
					TopPosition=(screen.height)?(screen.height-h)/2:100;
				}
				else
					if((pos!="center" && pos!="random") || pos==null){
						LeftPosition=0;TopPosition=20
					}

				settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';

				aseWindow=window.open("popupx.jsp?c="+c+"&md="+mode+"&kix="+kix+"&qn="+num,"crsrvwer",settings);

				return false;
			}
		-->
	</script>

</head>

<body>

	<a href="##" onClick="return quickComments('c','mode','kix','num')">click here</a>

</body>

</html>
