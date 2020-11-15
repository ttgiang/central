<!-- saved from url=(0048)http://jqueryui.com/demos/dialog/modal-form.html -->

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta name="generator" content=
   "HTML Tidy for Linux/x86 (vers 11 February 2007), see www.w3.org" />
   <meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
   <meta charset="utf-8" />

   <title>jQuery UI Dialog - Modal form</title>

   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.theme.css" type="text/css" />
   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.core.css" type="text/css" />
   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.button.css" type="text/css" />
   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.dialog.css" type="text/css" />
   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.resizable.css" type="text/css" />
   <link rel="stylesheet" href="./js/modal/themes/base/jquery.ui.selectable.css" type="text/css" />

   <script src="./js/modalform/jquery-1.5.1.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.core.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.widget.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.mouse.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.button.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.draggable.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.position.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.resizable.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.ui.dialog.js" type="text/javascript"></script>
   <script src="./js/modalform/jquery.effects.core.js" type="text/javascript"></script>

   <link rel="stylesheet" href="./js/modal/demos.css" type="text/css" />

   <style type="text/css">
/*<![CDATA[*/
             body { font-size: 62.5%; }
                label, input { display:block; }
                input.text { margin-bottom:12px; width:95%; padding: .4em; }
                fieldset { padding:0; border:0; margin-top:25px; }
                h1 { font-size: 1.2em; margin: .6em 0; }
                div#users-contain { width: 350px; margin: 20px 0; }
                div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
                div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
                .ui-dialog .ui-state-error { padding: .3em; }
                .validateTips { border: 1px solid transparent; padding: 0.3em; }
   /*]]>*/
   </style>
   <script type="text/javascript">
//<![CDATA[
     $(function() {
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			$( "#dialog:ui-dialog" ).dialog( "destroy" );

			var comp = $( "#comp" ),
				allFields = $( [] ).add( comp ),
				tips = $( ".validateTips" );

			function updateTips( t ) {
				tips
				.text( t )
				.addClass( "ui-state-highlight" );
				setTimeout(function() {
					tips.removeClass( "ui-state-highlight", 1500 );
				}, 500 );
			}

			function checkLength( o, n, min, max ) {
				if ( o.val().length > max || o.val().length < min ) {
					o.addClass( "ui-state-error" );
					updateTips( "Length of " + n + " must be between " +
					min + " and " + max + "." );
					return false;
				} else {
					return true;
				}
			}

			function checkRegexp( o, regexp, n ) {
				if ( !( regexp.test( o.val() ) ) ) {
					o.addClass( "ui-state-error" );
					updateTips( n );
					return false;
				} else {
					return true;
				}
			}

			$( "#dialog-form" ).dialog({
				autoOpen: false,
				height: 300,
				width: 350,
				modal: true,
				buttons: {
				"Submit": function() {
					var bValid = true;

					allFields.removeClass( "ui-state-error" );

					if ( bValid ) {
						$( "#users tbody" ).append( "<tr>" +
						"<td>" + comp.val() + "<\/td>" +
						"<\/tr>" );

						var values = {comp: "Doe@johndoe.com"};

						$.post("data.jsp", values);

						$( this ).dialog( "close" );
					}
				},

				Cancel: function() {
					$( this ).dialog( "close" );
				}
				},
				close: function() {
					allFields.val( "" ).removeClass( "ui-state-error" );
				}
			});

			$( "#create-comp" )
				.button()
				.click(function() {
				$( "#dialog-form" ).dialog( "open" );
			});

			$( "#cancel-create" )
				.button()
				.click(function() {
				document.location.href='data.jsp';
			});
		});
   //]]>
   </script>
</head>

<body>
   <div class="demo">
      <div id="users-contain" class="ui-widget">

         <table id="users" class="ui-widget ui-widget-content">
            <thead>
               <tr class="ui-widget-header">
                  <th>comp</th>
               </tr>
            </thead>

            <tbody>
               <tr>
                  <td>john.doe@example.com</td>
               </tr>
            </tbody>
         </table>
      </div>

	  <button	id="create-comp"
				role="button"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				aria-disabled="false">
				<span class="ui-button-text">Submit</span>
	  </button>

	  <button	id="cancel-create"
				role="button"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				aria-disabled="false">
				<span class="ui-button-text">Cancel</span>
	  </button>

   </div>

   <div style="outline-width: 0px; outline-style: initial; outline-color: initial; height: auto; width: 350px; position: absolute; top: 258px; left: 466px; z-index: 1002; display: none;"
   		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable"
	   	tabindex="-1"
	   	role="dialog"
	   	aria-labelledby="ui-dialog-title-dialog-form">

      <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
         <span class="ui-dialog-title" id="ui-dialog-title-dialog-form">Submit</span>
         <a href="http://jqueryui.com/demos/dialog/modal-form.html#"
         	class="ui-dialog-titlebar-close ui-corner-all"
         	role="button">
         	<span class="ui-icon ui-icon-closethick">close
         	</span>
         </a>
      </div>

      <div 	id="dialog-form" class="ui-dialog-content ui-widget-content" style="width: auto; min-height: 0px; height: 216px;">
         <form>
            <fieldset>
               <label for="comp">comp</label>
               <input type="text" name="comp" id="comp" value="test@test.com" class="text ui-widget-content ui-corner-all" />
            </fieldset>
         </form>
      </div>

      <div class="ui-resizable-handle ui-resizable-n"></div>
      <div class="ui-resizable-handle ui-resizable-e"></div>
      <div class="ui-resizable-handle ui-resizable-s"></div>
      <div class="ui-resizable-handle ui-resizable-w"></div>
      <div class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se ui-icon-grip-diagonal-se"
      		style="z-index: 1001;">
      </div>

      <div class="ui-resizable-handle ui-resizable-sw" style="z-index: 1002;"></div>
      <div class="ui-resizable-handle ui-resizable-ne" style="z-index: 1003;"></div>
      <div class="ui-resizable-handle ui-resizable-nw" style="z-index: 1004;"></div>

      <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
         <div class="ui-dialog-buttonset">
            <button type="button"
            		class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
            		role="button"
            		aria-disabled="false">
            		<span class="ui-button-text">Submit</span>
            </button>
            <button type="button"
            		class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
            		role="button"
            		aria-disabled="false">
            		<span class="ui-button-text">Cancel</span>
            </button>
         </div>
      </div>
   </div>
</body>
</html>
