<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	displayusrmsg.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	session.setAttribute("aseThisPage","usrbrd");

	String pageTitle = "Message Board";
	String thisPage = "forum/displaymsg";

	String rtnToBoard = AseUtil.nullToBlank((String)session.getAttribute("aseBoard"));
	if(rtnToBoard.equals("")){
		rtnToBoard = "msgbrd";
	}

	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String src = website.getRequestParameter(request,"src","");
	String rtn = website.getRequestParameter(request,"rtn","");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String courseTitle = info[Constant.KIX_COURSETITLE];

	int mode = 0;

	if (rtn.equals("rvw")){
		mode = Constant.REVIEW;
	}
	else if (rtn.equals("apr")){
		mode = Constant.APPROVAL;
	}
	else if (rtn.equals("rvwinapr")){
		mode = Constant.REVIEW_IN_APPROVAL;
	}

	String kixX = "";
	String status = website.getRequestParameter(request,"status","");
	String sort = website.getRequestParameter(request,"s","");
	int item = website.getRequestParameter(request,"item",0);

	int tab = website.getRequestParameter(request,"t",0);
	if(tab == Constant.TAB_COURSE || tab == Constant.TAB_CAMPUS){
		int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);
		if (item > courseTabCount){
			tab = Constant.TAB_CAMPUS;
		}
	}
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" href="../../inc/fader.css" type="text/css" media="screen" title="no title" charset="utf-8">
	<script language="JavaScript" src="inc/displayusrmsg.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link rel="stylesheet" type="text/css" href="inc/forum.css">
	<link rel="stylesheet" type="text/css" href="./inc/timeline.css">
	<%@ include file="../js/modal/modalnews.jsp" %>
</head>
<body topmargin="0" leftmargin="0" onLoad="return expandResponse('<%=kix%>',<%=tab%>,<%=item%>);">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/usrheader.jsp" %>

<%
	if (processPage){
		int fid = website.getRequestParameter(request,"fid",0);
		int mid = website.getRequestParameter(request,"mid",0);

		if(fid == 0){
			fid = ForumDB.createMessageBoard(conn,campus,user,kix);
		}

		if (mid == 0){
			mid = ForumDB.insertReviewNoMid(conn,campus,user,kix,fid,mode,item);
		}

		kixX = ForumDB.getKixFromMid(conn,mid);
		kix = kixX + "_" + mid;

		// requires for upload
		session.setAttribute("aseKix",kix);
		session.setAttribute("aseUploadTo","Forum");
		session.setAttribute("aseCallingPage",thisPage);

		// we came here from outline work and should have chance to return there
		if (!rtn.equals(Constant.BLANK)){
			session.setAttribute("aseOrigin",rtn);
		}
		else{
			rtn = aseUtil.nullToBlank((String)session.getAttribute("aseOrigin"));
		}

		// how to display our data
		int aseBoardStyle = NumericUtil.getInt((String)session.getAttribute("aseBoardStyle"),0);
		int boardStyle = website.getRequestParameter(request,"s",0);

		if (boardStyle==0 && aseBoardStyle==0){
			boardStyle = 1;
		}
		else if (boardStyle==0 && aseBoardStyle>0){
			boardStyle = aseBoardStyle;
		}
		else if (boardStyle>0){
			session.setAttribute("aseBoardStyle",""+boardStyle);
		}

		String displayLink = "&fid="+fid+"&mid="+mid+"&item="+item+"&rtn="+rtn+"&t="+tab+"&kix="+kixX;

		if (boardStyle==1){
		%>
			<p>
			<img src="./images/view-list.gif" border="0">&nbsp;&nbsp;<font class="goldhighlights">list</font>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
			<img src="./images/view-threaded.gif" border="0">&nbsp;&nbsp;<a href="?s=2<%=displayLink%>" class="linkcolumn">threaded</a>
			</p>

			<div id="aseEdit" class="base-container ase-table-layer">

			<p>
			<%
				out.println(Board.displayUserMessage(conn,user,fid,mid,item,sort,rtnToBoard,rtn));
			%>
			</p>

		<%
		}
		else if (boardStyle==2){
		%>
			<p>
			<img src="./images/view-list.gif" border="0">&nbsp;&nbsp;<a href="?s=1<%=displayLink%>" class="linkcolumn">list</a>&nbsp;&nbsp;</font><font class="copyright">|</font>&nbsp;
			<img src="./images/view-threaded.gif" border="0">&nbsp;&nbsp;<font class="goldhighlights">threaded</font>
			</p>

			<div id="page">
				<div id="primary">
					<div id="content" role="main">
						<div id="comments">
							<ol class="commentlist">
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
										<tbody>
											<tr id="warnmessage">
												<td width="100%"><%=alpha+" "+num+" - "+courseTitle%></td>
											</tr>
										</tbody>
									</table>
								<%
									out.println(Board.displayBoardThreaded(conn,user,fid,mid,item,"",rtnToBoard,rtn));
								%>
							</ol>
						</div>
					</div>
				</div>
			</div>
		<%
		}	// boardStyle

	} // processPage

	asePool.freeConnection(conn,"displaymsg",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

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
			//var topdiv=$("#containertop").height();
			//var pag= e.pageY - topdiv-26;
			//$('.plus').css({"top":pag +"px", "background":"url('/central/core/forum/images/plus.png')","margin-left":"1px"});}).
			//mouseout(function()
			//{
			//$('.plus').css({"background":"url('')"});
		});

		$("#update_button").live('click',function(){
			var x=$("#update").val();
			$("#container").prepend('<div class="item"><a href="#" class="postbox"><img src="./images/reply.gif"></a><div>'+x+'</div></div>');

			//Reload masonry
			$('#container').masonry( 'reload' );

			$('.rightCorner').hide();
			$('.leftCorner').hide();
			Arrow_Points();

			$("#update").val('');
			$("#popup").hide();
			return false;
		});

		$("#cancel_button").live('click',function(){
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
			//var topdiv=$("#containertop").height();
			//$("#popup").css({'top':(e.pageY-topdiv-33)+'px'});
			//$("#popup").fadeIn();
			//$("#update").focus();
		});

		$(".postbox").live('click',function(e){
			var topdiv=$("#containertop").height();
			$("#popup").css({'top':(e.pageY-200)+'px'});
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

	  //When you click on a link with class of poplight and the href starts with a #
	  $('a.poplight[href^=#]').click(function() {

			var popID = $(this).attr('rel'); //Get Popup Name
			var popURL = $(this).attr('href'); //Get Popup href to define size

			//Pull Query & Variables from href URL
			var query= popURL.split('?');
			var dim= query[1].split('&');
			var popWidth = 500; //Gets the first query string value

			//Fade in the Popup and add close button
			$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="../../images/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>');

			//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
			var popMargTop = ($('#' + popID).height() + 80) / 2;
			var popMargLeft = ($('#' + popID).width() + 80) / 2;

			//Apply Margin to Popup
			$('#' + popID).css({
				 'margin-top' : -popMargTop,
				 'margin-left' : -popMargLeft
			});

			//Fade in Background
			$('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
			$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies

			return false;
	  });

	  //Close Popups and Fade Layer
	  $('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
			$('#fade , .popup_block').fadeOut(function() {
				 $('#fade, a.close').remove();  //fade them both out
			});
			return false;
	  });

	});

</script>

<div id="page_help" class="popup_block">
	<p>
	Use this page to post (provide) comments to course proposers. You are able to post comments if you are an approver or have been invited
	to do reviews.
	</p>
	<p>
		Postings are permitted during approvals, reviews or if there are replies to your posts.
	</p>
	<p>
	You may edit your posts as long as you don't end the current review session OR replies have not been made to your postings.
	</p>
</div>

</body>
</html>

