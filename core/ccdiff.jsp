<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccdiff.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Compare Outline Items";
	fieldsetTitle = pageTitle;

	String kixSRC = website.getRequestParameter(request,"src","");
	String kixDST = website.getRequestParameter(request,"dst","");
	String column = website.getRequestParameter(request,"item","");

	String oldVersion = CourseDB.getCourseItem(conn,kixSRC,column);
	String newVersion = CourseDB.getCourseItem(conn,kixDST,column);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/modal/modalnews.jsp" %>

	<link rel="stylesheet" href="./js/diff/css/blueprint/screen.css" type="text/css" media="screen, projection"></link>

	<!--[if IE]><link rel="stylesheet" href="./js/diff/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->

	<link type="text/css" href="./js/diff/css/style.css" rel="stylesheet" />
	<script type="text/javascript" src="./js/diff/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="./js/diff/js/diff_match_patch_uncompressed.js"></script>

	<script>
		<!--
		diff_match_patch.prototype.diff_prettierHtml = function(diffs) {
		  var html = [];
		  var i = 0;
		  for (var x = 0; x < diffs.length; x++) {
			 var op = diffs[x][0];    // Operation (insert, delete, equal)
			 var data = diffs[x][1];  // Text of change.
			 var text = data;
			 switch (op) {
				case DIFF_INSERT:
				  html[x] = '<ins>' + text + '</ins>';
				  break;
				case DIFF_DELETE:
				  html[x] = '<del>' + text + '</del>';
				  break;
				case DIFF_EQUAL:
				html[x] = '<span>' + text + '</span>';
				  break;
			 }
			 if (op !== DIFF_DELETE) {
				i += data.length;
			 }
		  }
		  return html.join('');
		};

		var current = null;

		function calcDiffs() {

			var dmp = new diff_match_patch();
			var differences = dmp.diff_main($("#oldVersion").val(), $("#newVersion").val());
			var ds = dmp.diff_prettierHtml(differences);

			$("#viewer").html(ds);

		}

		function resetText() {
			var fulltext = "";
			$("#viewer").children().each(function() {
				if (!$(this).is('ins')) {
					fulltext = fulltext + $(this).html();
				}
			});
			$("#oldVersion").val(fulltext)
		}
		function registerAcceptChange(){
		$('#accept').click(function () {

			if (current.is('del')) {

				current.remove();

			}
			if (current.is('ins')) {
				current.replaceWith('<span>' + current.html() + '</span>');
			}
			resetText();
			//calcDiffs();
			$('#contextmenu_holder').hide();
			return false;
		});
		}
		$(function() {
				calcDiffs();
				registerContextMenu();
				registerAcceptChange();
				//hide context menu when click anywhere
				$(document).click(function() {
					$('#contextmenu_holder').hide();
					$(".highlight").removeClass("highlight");
				});
				//caculate difference when text change
				$('textarea').change(function() {
						 calcDiffs();
				});

		});

		function registerContextMenu(){
				$('del, ins').live('mouseover', function(event) {

					current= $(this);
					$(".highlight").removeClass("highlight");
					current.addClass("highlight");
				//$("#zoom").html(current.html());
				var top= event.pageY +5;
					$('#contextmenu_holder').css( {
						top :top + 'px',
						left : event.pageX + 'px'
					}).show();
			});
		}
		-->
	</script>

	<style>
		del {
			color:#8A1F11;
		}
		ins {
			color:green;
			text-decoration:none;
		}
		#contextmenu_holder {
			display: none;
			position: absolute;
			padding: 5px;
		}
		#viewer {
			letter-spacing: 0.3em;
			font-size:1.em;
		}
	</style>

</head>
<body topmargin="0" leftmargin="0">

	<div class="container">
		<div class="span-24">
			<h3>Differences</h3>
			<div id="viewer" class="span-20 box"> </div>
		</div>

		<div class="span-12">
			<label>Old Version</label>
			<br>
			<textarea id="oldVersion" name="oldVersion" class="error">
<%=oldVersion%>
			</textarea>
		</div>

		<div class="span-12 last">
			<label>New Version</label>
			<br>
			<textarea id="newVersion" name="newVersion" class="success">
<%=newVersion%>
			</textarea>
		</div>

		</div>
		<div id="contextmenu_holder" class="notice">
		<div id="accept"><a href="#">Accept Change</a></div>
		</div>
		<div id="ad">
	</div>

<%
	asePool.freeConnection(conn,"ccdiff",user);
%>

</body>
</html>

