   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.theme.css" type="text/css" />
   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.core.css" type="text/css" />
   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.button.css" type="text/css" />
   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.dialog.css" type="text/css" />
   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.resizable.css" type="text/css" />
   <link rel="stylesheet" href="/central/core/js/modal/themes/base/jquery.ui.selectable.css" type="text/css" />
	<script type="text/javascript" src="/central/core/js/jquery/jquery-latest.pack.js"></script>

	<script>
		<!--
		$(document).ready(function() {

			//select all the a tag with name equal to modal
			$('a[name=modal]').click(function(e) {
				//Cancel the link behavior
				e.preventDefault();

				//Get the A tag
				var id = $(this).attr('href');

				//Get the screen height and width
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();

				//Set heigth and width to mask to fill up the whole screen
				$('#mask').css({'width':maskWidth,'height':maskHeight});

				//transition effect
				$('#mask').fadeIn(1000);
				$('#mask').fadeTo("slow",0.8);

				//Get the window height and width
				var winH = $(window).height();
				var winW = $(window).width();

				//Set the popup window to center
				$(id).css('top',  winH/2-$(id).height()/2);
				$(id).css('left', winW/2-$(id).width()/2);

				//transition effect
				$(id).fadeIn(2000);

			});

			//if close button is clicked
			$('.window .close').click(function (e) {
				//Cancel the link behavior
				e.preventDefault();

				$('#mask').hide();
				$('.window').hide();
			});

			//if mask is clicked
			$('#mask').click(function () {
				$(this).hide();
				$('.window').hide();
			});

		});

		-->

	</script>

	<style>

		a {color:#333; text-decoration:none}

		a:hover {color:#ccc; text-decoration:none}

		#mask {
		  position:absolute;
		  left:0;
		  top:0;
		  z-index:9000;
		  background-color:#000;
		  display:none;
		}

		#boxes .window {
		  position:absolute;
		  left:0;
		  top:0;
		  width:800px;
		  height:400px;
		  display:none;
		  z-index:9999;
		  padding:05px;
		  overflow: auto;
		  background-color:#ffffff;
		}

		#boxes #dialog0 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog1 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog2 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog3 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog4 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog5 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog6 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog7 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog8 {
		  width:800px;
		  height:400px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialogTaskDescription {
		  width:800px;
		  height:620px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		#boxes #dialog_photo {
		  width:480px;
		  height:640px;
		  padding:05px;
		  color:#000000;
		  background-color:#ffffff;
		}

		pre {
		  position: relative;
		  background: #333;
		  color: white;
		  line-height: 1.8;
		  -moz-border-radius:    8px;
		  -webkit-border-radius: 8px;
		  border-radius:         8px;
		  font-size: 12px;
		  padding: 0;
		  margin: 0 0 0 0;
		  overflow: auto;
		}

		pre code {
		  padding: 0;
		  color: white;
		  background: #333;
		}
		pre[rel] {
			padding-top: 0px;
		}

		pre[rel]:after {
		  content: attr(rel);
		  position: absolute;
		  top: 0;
		  background: #ffffff;
		  padding: 0px;
		  left: 0;
		  right: 0;
		  font-size: 24px;
		  line-height: 0;
		  color: white;
		  font: bold 16px "myriad-pro-1","myriad-pro-2", "Lucida Grande", Sans-Serif;
		  -webkit-border-top-left-radius: 7px;
			-webkit-border-top-right-radius: 7px;
			-moz-border-radius-topleft: 7px;
			-moz-border-radius-topright: 7px;
			border-top-left-radius: 7px;
			border-top-right-radius: 7px;
		}

	</style>