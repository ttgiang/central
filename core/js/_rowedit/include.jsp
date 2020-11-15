	<script type="text/javascript" src="./js/rowedit/jquery.min.js"></script>
	<script type="text/javascript">
		<!--
		$(document).ready(function(){

			$(".edit_tr").click(function(){
				var ID=$(this).attr('id');
				$("#kid_"+ID).hide();
				$("#descr_"+ID).hide();
				$("#val_"+ID).hide();
				$("#auditby_"+ID).hide();
				$("#auditdate_"+ID).hide();

				$("#kid_"+ID).show();
				$("#descr_"+ID).show();
				$("#val_input_"+ID).show();
				$("#auditby_"+ID).show();
				$("#auditdate_"+ID).show();

				}).change(function(){
						var ID=$(this).attr('id');

						var descr=$("#descr_input_"+ID).val();
						var kid=$("#kid_input_"+ID).val();
						var val=$("#val_input_"+ID).val();
						var auditby=$("#auditby_input_"+ID).val();
						var auditdate=$("#auditdate_input_"+ID).val();

						var dataString = 'id='+ ID +'&val='+val;

						$("#kid_"+ID).html('<img src="../images/load.gif" />');

					if(descr.length && kid.length > 0){
						$.ajax({
							type: "POST",
							url: "inix.jsp",
							data: dataString,
							cache: false,
							success: function(html){
								$("#kid_"+ID).html(kid);
								$("#descr_"+ID).html(descr);
								$("#val_"+ID).html(val);
								$("#auditby_"+ID).html(auditby);
								$("#auditdate_"+ID).html(auditdate);
								}
						});
					}
					else{
						alert('Invalid data');
					}
			});

			$(".editbox").mouseup(function(){
				return false
			});

			$(document).mouseup(function(){
				$(".editbox").hide();
				$(".text").show();
			});

		});
		-->
	</script>

	<style>
		body{
		}

		.editbox{
			display:none
		}

		td{
			padding:4px;
		}

		.editbox{
			width:200px;
			background-color:#ffffcc;
			border:solid 1px #000;
			padding:2px;
		}

		.edit_td{
			vertical-align:text-top;
		}

		.edit_tr:hover{
			background: url(../images/edit.gif) right no-repeat #80C8E5;
			vertical-align:text-top;
			cursor:pointer;
		}

		img{
			vertical-align:text-top;
		}

		th{
			font-weight:bold;
			text-align:left;
			padding:2px;
		}

		.head{
			background-color:#80C8E5;
			color:#333
		}
	</style>
