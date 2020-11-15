<html>
<head>
	<link rel="stylesheet" type="text/css" href="./inc/timeline.css">
</head>
<body topmargin="0" leftmargin="0">

			<div id="containertop">
				<div id='profile' style='margin:10px;height:10px'>
				</div>
			</div>

			<div id="container">
			<div class="timeline_container">
			<div class="timeline">
			<div class="plus"></div>
			</div>
			</div>

<div class="item"><a href='#' class='deletebox'>X</a><div>6</div></div>
<div class="item"><a href='#' class='deletebox'>X</a><div>5</div></div>
<div class="item"><a href='#' class='deletebox'>X</a><div>4</div></div>
<div class="item"><a href='#' class='deletebox'>X</a><div>3</div></div>
<div class="item"><a href='#' class='deletebox'>X</a><div>2</div></div>
<div class="item"><a href='#' class='deletebox'>X</a><div>1</div></div>

			<div id="popup" class='shade'>
			<div class="Popup_rightCorner"></div>
			<div id='box'>
			<b>What's Up?</b><br />
			<textarea id='update'>
				</textarea> <input type='submit' value=' Update ' id='update_button' />
			</div>
			</div>
			</div>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="./inc/jquery.masonry.min.js"></script>

<script>
	$(function(){

		function Arrow_Points(){
			var s = $('#container').find('.item');
			$.each(s,function(i,obj){
			var posLeft = $(obj).css("left");
			$(obj).addClass('borderclass');
				if(posLeft == "0px"){
					html = "<span class='rightCorner'></span>";
					$(obj).prepend(html);
				}
				else{
					html = "<span class='leftCorner'></span>";
					$(obj).prepend(html);
			}
			});
		}

		$('.timeline_container').mousemove(function(e){
			var topdiv=$("#containertop").height();
			var pag= e.pageY - topdiv-26;
			$('.plus').css({"top":pag +"px", "background":"url('/central/core/forum/images/plus.png')","margin-left":"1px"});}).
			mouseout(function()
			{
			$('.plus').css({"background":"url('')"});
		});

		$("#update_button").live('click',function(){
			var x=$("#update").val();
			$("#container").prepend('<div class="item"><a href="#" class="deletebox">X</a><div>'+x+'</div></div>');

			//Reload masonry
			$('#container').masonry( 'reload' );

			$('.rightCorner').hide();
			$('.leftCorner').hide();
			Arrow_Points();

			$("#update").val('');
			$("#popup").hide();
			return false;
		});

		// Divs
		$('#container').masonry({itemSelector : '.item',});
		Arrow_Points();

		//Mouseup textarea false
		$("#popup").mouseup(function(){
			return false
		});

		$(".timeline_container").click(function(e){
			var topdiv=$("#containertop").height();
			$("#popup").css({'top':(e.pageY-topdiv-33)+'px'});
			$("#popup").fadeIn();
			$("#update").focus();
		});


		$(".deletebox").live('click',function(){

			if(confirm("Are your sure?")){
				$(this).parent().fadeOut('slow');

				//Remove item
				$('#container').masonry( 'remove', $(this).parent() );

				//Reload masonry
				$('#container').masonry( 'reload' );
				$('.rightCorner').hide();
				$('.leftCorner').hide();
				Arrow_Points();
			}

			return false;
		});

		//Textarea without editing.
		$(document).mouseup(function(){
			$('#popup').hide();
		});

	});
</script>

