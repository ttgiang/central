	//
	// slide down on submit
	// source: add_submit.php
	//
	$(document).ready(function() {
		$("#msg").slideDown('slow').delay(5000).slideUp('slow');
	});

	//
	// masking input fields on form
	// source: form.php
	// http://www.meiocodigo.com/projects/meiomask/
	//
	$(document).ready(function() {

		//Setup for new masks and for masks that overwrite older ones.
		$.mask.masks = $.extend($.mask.masks,{
			//We use the '9' because that stands for [0-9], 6 = [0-6], 2 = [0-2]..etc
			phone:{ mask : '(999) 999-9999' },

			//The type reverse simple reverses the order of the mask so text is entered
			//from right to left instead.
			price:{ mask : '99.999,999,999,999', type : 'reverse', defaultValue: '000' }

			//We are not doing the Credit Card text input because we are leaving it to
			//the presets (9999 9999 9999 9999).
		});

		//Assign these masks to all text input
		$('input:text').setMask();

	});

	//
	// tooltip function initialization
	// source: header.php
	// http://code.drewwilson.com/entry/tiptip-jquery-plugin
	//
	$(document).ready(function(){
		$(".tiptip").tipTip();
	});

	//
	// timepicker function initialization
	// source: form.php
	// http://fgelinas.com/code/timepicker/
	//
	$(document).ready(function() {
		$("input#timepicker_6").defaultText('Time');

	});
	$(document).ready(function() {
		$('#timepicker_6').timepicker({
			defaultTime: '1:00',
			showPeriod: true,
			showLeadingZero: true,
			minuteText: 'Min',         // Define the locale text for "Minute"
			minutes: {
			interval: 15               // Interval of displayed minutes
			},
		});
	});

	// NO LONGER IN USE 8/30/11 - keep for possible further use
	// accordion slider for payment screen
	// source: add.php
	//
	$(document).ready(function() {
		$("#pmb").click(function () {
			if ($("#pmd").is(":hidden")) {
				$("#pmd").slideDown(1000);
				$("#pmb").html('Use the current payment method');
				$('html,body').animate({
					scrollTop: $("#pmd").offset().top
					}, 2000);
			} else {
				$("#pmd").slideUp(1000);
				$("#pmb").html('Use an alternate payment method');
			}
		});
	});
	$(document).ready(function() {

		//ACCORDION BUTTON ACTION
		$('div.accordionButton').click(function() {
			$('div.accordionContent').slideUp('normal');
			$(this).next().slideDown('normal');
		});

		//HIDE THE DIVS ON PAGE LOAD
		$("div.accordionContent").hide();

	});

	//
	// configuration ajax add store function
	// source: includes/settings_store.php
	//
	$(document).ready(function() {
		$("form#storeform").submit(function() {
			var name = $("input#storename").val();
			var wmax = $("input#wmax").val();
			var hmax = $("input#hmax").val();
			var wpad = $("input#wpad").val();
			var hpad = $("input#hpad").val();
			$.ajax({
			   type: "POST",
			   url: "includes/settings_submit.php",
			   data: 'name='+ name + '&wmax=' + wmax + '&hmax=' + hmax + '&wpad=' + wpad + '&hpad=' + hpad + '&addstore=1',
			   success: function(){
				   $("#ras").prepend("<div class='sidenavOff'><div class='set-th-l'>"+ name +"</div><a class='d_stores set-cb'><img src='img/activedelete.png'></a><div class='set-td lock'><input type='checkbox'></div><div class=' set-td'>"+ hmax +"</div><div class='set-td'>"+ wmax +"</div></div>");
				   $("#ras").fadeIn();
				   $.modal.close();
				   $("#setmsg").text('You have successfully added '+ name +'.').slideDown('slow').delay(5000).slideUp('slow');
			   }
			});
			return false;
		});

	});

	//
	// configuration ajax add users function
	// source: includes/settings_user.php
	//
	$(document).ready(function() {
		$("form#userform").submit(function() {
			var name = $("input#ufname").val();
			var store = $("select#ufstore").val();
			var group = $("select#ufgroup").val();
			var initials = $("input#ufinitials").val();
			var ip1 = $("input#ufip-1").val();
			var ip2 = $("input#ufip-2").val();
			var ip3 = $("input#ufip-3").val();
			var ip4 = $("input#ufip-4").val();
			var ip = ip1 +'.'+ ip2 +'.'+ ip3 +'.'+ ip4;
			$.ajax({
			   type: "POST",
			   url: "includes/settings_submit.php",
			   data: 'name='+ name +'&store='+ store +'&group='+ group +'&ip='+ ip +'&initials='+ initials +'&adduser=1',
			   success: function(){
				   $("#rau").prepend("<div class='sidenavOff'><div class='set-th-l'>"+ name +"</div><a class='set-cb'><img src='img/activedelete.png'></a><div class='set-td th-ip'>"+ ip +"</div><div class='set-td'>"+ initials +"</div><div class='set-td'>"+ store +"</div><div class='set-td'>"+ group +"</div></div>");
				   $("#rau").fadeIn();
				   $.modal.close();
				   $("#msg").text('You have successfully added '+ name +'.').slideDown('slow').delay(5000).slideUp('slow');
			   }
			});
			return false;
		});
	});

	//
	// configuration ajax add groups function
	// source: includes/settings_group.php
	//
	$(document).ready(function() {
		$("form#groupform").submit(function() {
			var name = $("input#ugname").val();
			$.ajax({
			   type: "POST",
			   url: "includes/settings_submit.php",
			   data: 'name='+ name +'&addgroup=1',
			   success: function(){
				   $("#rag").prepend("<div class='sidenavOff'><div class='set-th-l'>"+ name +"</div></div>");
				   $("#rag").fadeIn();
				   $.modal.close();
				   $("#msg").text('You have successfully added '+ name +'.').slideDown('slow').delay(5000).slideUp('slow');
			   }
			});
			return false;
		});
	});

	//
	// autocomplete search box
	// source: header.php
	// ???
	//
	$().ready(function() {
		$("#autocomplete").autocomplete("get_list.php", {
			width: 260,
			matchContains: true,
			selectFirst: false
		});
	});

	//
	// clear field for autocomplete search box
	// source: header.php
	//
	$(document).ready(function() {
		$("a.clear").live('click', function() {
			var id = "#" + $(this).attr('alt');
			$(id).attr('value', '');
		});
		$('.clear').each(function() {
			var html = '<a href="#" class="clear" alt="' + $(this).attr('id') + '"><img class="input-button" src="img/clear.png"></a>';
			$(html).insertAfter(this);
		});
	});


	//
	// simplemodal - modal box
	// source: header.php
	// http://www.ericmmartin.com/projects/simplemodal/
	//
	jQuery(function ($) {
		// Load dialog on page load
		//$('#basic-modal-content').modal();

		// Load dialog on click
		$('#basic-modal .basic').click(function (e) {
			$('.modal-reportabug').modal({
				overlayClose:true,
				opacity:0,
				overlayCss: {backgroundColor:"white"},
				onOpen: function (dialog) {
					dialog.overlay.fadeIn('fast', function () {
						dialog.data.fadeIn('fast');
						dialog.container.fadeIn('fast');
					});
				},
				onClose: function (dialog) {
					dialog.data.fadeOut('fast', function () {
						dialog.container.fadeOut('fast', function () {
							dialog.overlay.fadeOut('fast', function () {
								$.modal.close();
							});
						});
					});

			}});

			return false;
		});

		// Load dialog on click
		$('#basic-modal .orderSummaryBasic').click(function (e) {
			$('.modal-orderSummary').modal({
				overlayClose:true,
				opacity:0,
				overlayCss: {backgroundColor:"white"},
				onOpen: function (dialog) {
					dialog.overlay.fadeIn('fast', function () {
						dialog.data.fadeIn('fast');
						dialog.container.fadeIn('fast');
					});
				},
				onClose: function (dialog) {
					dialog.data.fadeOut('fast', function () {
						dialog.container.fadeOut('fast', function () {
							dialog.overlay.fadeOut('fast', function () {
								$.modal.close();
							});
						});
					});

			}});

			return false;
		});

		// Load dialog on click
		$('#addstorediv .addstore').click(function (e) {
			$('.modal-addstore').modal({
				overlayClose:true,
				opacity:0,
				overlayCss: {backgroundColor:"white"},
				containerCss:{
					height:100,
					padding:0,
					width:600
				},
				onOpen: function (dialog) {
					dialog.overlay.fadeIn('fast', function () {
						dialog.data.fadeIn('fast');
						dialog.container.fadeIn('fast');
					});
				},
				onClose: function (dialog) {
					dialog.data.fadeOut('fast', function () {
						dialog.container.fadeOut('fast', function () {
							dialog.overlay.fadeOut('fast', function () {
								$.modal.close();
							});
						});
					});

			}});

			return false;
		});

		// Load dialog on click
		$('#adduserdiv .adduser').click(function (e) {
			$('.modal-adduser').modal({
				overlayClose:true,
				opacity:0,
				overlayCss: {backgroundColor:"white"},
				containerCss:{
					height:265,
					padding:0,
					width:340
				},
				onOpen: function (dialog) {
					dialog.overlay.fadeIn('fast', function () {
						dialog.data.fadeIn('fast');
						dialog.container.fadeIn('fast');
					});
				},
				onClose: function (dialog) {
					dialog.data.fadeOut('fast', function () {
						dialog.container.fadeOut('fast', function () {
							dialog.overlay.fadeOut('fast', function () {
								$.modal.close();
							});
						});
					});

			}});

			return false;
		});

		// modal box for add group form
		$('#addgroupdiv .addgroup').click(function (e) {
			$('.modal-addgroup').modal({
				overlayClose:true,
				opacity:0,
				overlayCss: {backgroundColor:"white"},
				containerCss:{
					height:100,
					padding:0,
					width:340
				},
				onOpen: function (dialog) {
					dialog.overlay.fadeIn('fast', function () {
						dialog.data.fadeIn('fast');
						dialog.container.fadeIn('fast');
					});
				},
				onClose: function (dialog) {
					dialog.data.fadeOut('fast', function () {
						dialog.container.fadeOut('fast', function () {
							dialog.overlay.fadeOut('fast', function () {
								$.modal.close();
							});
						});
					});

			}});

			return false;
		});

	});


	//
	// last 30 accordion slidedown
	// source: widgets/rc-last-30.php
	// ???
	//
	jQuery(function( $ ){

		// Get a reference to the container.
		var container = $( "#container" );

		// Bind the link to toggle the slide.
		$( "a.showall" ).click(
			function( event ){
				// Prevent the default event.
				event.preventDefault();

				// Toggle the slide based on its current
				// visibility.
				if (container.is( ":visible" )){

					// Hide - slide up.
					container.slideUp( 500 );
					$(this).html('Show all &raquo;');

				} else {

					// Show - slide down.
					container.slideDown( 500 );
					 $(this).html('Show less &raquo;');
				}
			}
		);
	});

	//
	// ajax delete function for stores in settings
	// source: settings_store.php
	//
	$(document).ready(function() {
	  $('a.d_stores').click(function(e) {
		e.preventDefault();
		var parent = $(this).parent();
		var name = $(this).attr("title");
		$.ajax({
		  type: 'get',
		  url: 'includes/settings_del.php',
		  data: 'ajax=1&d_stores=' + parent.attr('id').replace('record-',''),
		  beforeSend: function() {
			parent.animate({'backgroundColor':'#fb6c6c'},300);
		  },
		  success: function() {
			parent.slideUp(300,function() {
			  parent.remove();
			});
			$("#msg").text('You have successfully deleted '+ name +'.').slideDown('slow').delay(5000).slideUp('slow');
		  }
		});
	  });
	});

	//
	// ajax delete function for users in settings
	// source: settings_user.php
	//
	$(document).ready(function() {
	  $('a.d_users').click(function(e) {
		e.preventDefault();
		var parent = $(this).parent();
		$.ajax({
		  type: 'get',
		  url: 'includes/settings_del.php',
		  data: 'ajax=1&d_users=' + parent.attr('id').replace('record-',''),
		  beforeSend: function() {
			parent.animate({'backgroundColor':'#fb6c6c'},300);
		  },
		  success: function() {
			parent.slideUp(300,function() {
			  parent.remove();
			});
		  }
		});
	  });
	});

	//
	// ajax submit for bug report form
	// source: widgets/rc-report-a-bug.php
	//
	$(function() {
		$('.error').hide();
		$("#sendfeedback").click(function() {
			// validate and process form here

			$('.error').hide();
			var name = $("input#name").val();
			if (name == "") {
				$("label#name_error").show();
				$("input#name").focus();
				return false;
			}
			var store = $("input#store").val();
			if (store == "") {
				$("label#store_error").show();
				$("input#store").focus();
				return false;
			}

			var tfeedback = $("textarea#tfeedback").val();

			var dataString = 'name='+ name + '&store=' + store + '&tfeedback=' + tfeedback;
			//alert (dataString);return false;

			$.ajax({
				type: "POST",
				url: "process.php",
				data: dataString,
				success: function() {
					$('#contact_form').html("<div id='message'></div>");
					$('#message').html("<h2>Bug Reported</h2>")
					.append("<p>We will be in touch soon.</p>")
					.hide()
					.fadeIn(1500, function() {
						$('#message').append("<img id='checkmark' src='img/reported.png' />");
					});
				}
			});
			return false;
		});
	});

	//
	// inline editing function for settings
	// source: settings.php
	// http://www.appelsiini.net/projects/jeditable
	//
	$(document).ready(function() {

		//
		// ASE
		//
		$('.edit-sys-value').editable('./sysx.jsp?type=ini', {
			type : 'text',
			indicator : '<center><img src="../images/loading.gif" style="margin-top:12px;"></center>',
			tooltip : 'Click to edit',
			onblur : 'submit',
			id   : 'id',
			name : 'value'
		});

		// system settings
		$('.edit-sys-settings').editable('./sysx.jsp?type=settings', {
			type : 'text',
			indicator : '<center><img src="../images/loading.gif" style="margin-top:12px;"></center>',
			tooltip : 'Click to edit',
			onblur : 'submit',
			id   : 'id',
			name : 'value'
		});

		// system settings
		$('.edit-distribution').editable('./dstidxx.jsp', {
			type : 'text',
			indicator : '<center><img src="../images/loading.gif" style="margin-top:12px;"></center>',
			tooltip : 'Click to edit',
			onblur : 'submit',
			id   : 'id',
			name : 'value'
		});

		//
		// highlighting rows in settings
		// source: settings.php
		//
		$("div.sidenavOff").mouseover(function(){
			$(this).removeClass().addClass("sidenavOver");
		}).mouseout(function(){
			$(this).removeClass().addClass("sidenavOff");
		})
	});

	//
	// ajax comment submit
	// source: customer.php
	//
	$(document).ready(function(){
		$("form#submit_wall_form").submit(function() {
			var message_wall = $('#message_wall').attr('value');
			var cust_id = $('#cust_id').attr('value');
			var user_id = $('#user_id').attr('value');
			var username = $('#username').attr('value');

			$.ajax({
				type: "POST",
				url: "includes/comment-insert.php",
				data: "message_wall="+ message_wall +"&cust_id="+ cust_id +"&user_id="+ user_id,
				success: function(){
					$("ul#wall").prepend("<li class='comment-wall' style='display:none'><div class='comment-tl'><span class='comment-name'><a href='#'>"+ username +"</a> </span><span class='comment-time'>  - Just Now </span></div>"+message_wall+"</li>");
					$("ul#wall li").slideDown(1000);
					$("textarea#message_wall").val('');
				}
			});
			return false;
		});
	});

	//
	// ajax comment delete
	// source: customer.php
	//
	$(document).ready(function() {
			$('#commentcon').hide();
		});

		$(function() {
			$(".comment-delete").click(function() {
				$('#commentcon').fadeIn();
				var commentContainer = $(this).parent();
				var id = $(this).attr("id");
				var string = 'id='+ id ;

				$.ajax({
				type: "POST",
				url: "includes/comment-delete.php",
				data: string,
				cache: false,
				success: function(){
					commentContainer.slideUp('slow', function() {$(this).remove();});
					$('#load').fadeOut();
				}
			});
			return false;
		});
	});
