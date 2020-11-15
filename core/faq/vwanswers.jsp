<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	bb.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Curriculum Central Answers!";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int id = website.getRequestParameter(request,"id",0);
	session.setAttribute("aseFAQId", id);

	String bestAnswer = website.getRequestParameter(request,"ba","0");
	String srch = website.getRequestParameter(request,"sr","");

	String question = "";
	String asker = "";
	String askedby = "";
	String askerCampus = "";
	int answeredSeq = 0;

	com.ase.aseutil.faq.Faq faq = com.ase.aseutil.faq.FaqDB.getFaq(conn,id);
	if (faq != null){
		question = faq.getQuestion();
		answeredSeq = faq.getAnsweredSeq();
		asker = faq.getAuditBy();
		askedby = faq.getAskedby();
		askerCampus = faq.getCampus();
	}

	String ckName = "faq";
	String ckData = "";

	String askedbyImage = UserDB.getProfileImage(conn,askedby);
	if(askedbyImage.equals(Constant.BLANK)){
		askedbyImage = "../../images/logos/logo" + askerCampus + ".jpg";
	}
	else{
		askedbyImage = "/centraldocs/docs/profiles/" + askedbyImage;
	}

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link type="text/css" href="../../inc/buttons.css" rel="Stylesheet" />
	<script language="JavaScript" src="inc/faq.js"></script>
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>

	<style type="text/css">

		.highlightWordYellow { background-color: #ff2; }
		.highlightWordGreen { background-color: #adff2f; }
		.highlightWordPink { background-color: #ffb6c1; }
		.highlightWordAqua { background-color: #00ffff; }
		.highlightWordDarkkhaki { background-color: #bdb76b; }

		h3 {
			font-size: 120%;
			font-weight: normal;
			color: #E87B10;
		}

		#divQuestion {
			width:99%;
			float: left;
			 padding: 0.3em;
			 font-weight: bold;
		}

		#divLeft {
			width:05%;
			float: left;
		}

		#divRight {
			width:92%;
			float: right;
			text-align: left;
			font-size: 120%;
			font-weight: normal;
			color: #E87B10;
		}

		.new_line_padded{ clear: left; padding: 2px 2px;  }
	</style>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<%
	if (processPage){
%>
<table border="0" width="100%">
	<tr>
		<td>
			<h4 class="tutheader">Question:</h4>

			<div id="divQuestion">
				<div id="divLeft">
					<img src="<%=askedbyImage%>" width="48">
				</div>
				<div id="divRight">
					<%=question%>
				</div>
			</div>

			<div class="new_line_padded"></div>
<%

			ArrayList list = com.ase.aseutil.faq.AnswerDB.getAnswers(conn,id);

			if (list != null && list.size() > 0){

				String thisAnswer = "";
				String auditDate = "";
				String auditBy = "";
				String thisCampus = "";
				int seq = 0;
				String clss= "";

				com.ase.aseutil.faq.Answer answer = null;
%>
				<h4 class="tutheader">Answers:</h4>

		</td>
	</tr>
</table>

<div id="body">
	<div id="body_top">
		<div class="commentlist">
				<form method="post" action="/central/servlet/faq" name="aseAnswer">
<%
						for (int i = 0; i<list.size(); i++){
							answer = (com.ase.aseutil.faq.Answer)list.get(i);

							thisCampus = "logo" + answer.getCampus();
							thisAnswer = answer.getAnswer();
							String profile = answer.getProfile();
							seq = answer.getSeq();

							if (thisAnswer.toLowerCase().startsWith("<p>")){
								thisAnswer = thisAnswer.substring(3);
								if (thisAnswer.toLowerCase().endsWith("</p>")){
									thisAnswer = thisAnswer.substring(0,thisAnswer.length()-4);
								}
							}

							String profileImage = "";
							if(!profile.equals(Constant.BLANK)){
								profileImage = "/centraldocs/docs/profiles/" + profile;
							}
							else{
								profileImage = "../../images/logos/" + thisCampus + ".jpg";
							}

							auditDate = answer.getAuditDate();
							auditBy = answer.getAuditBy();

							//
							// display appropriate image
							// uncomment if we don't want to show THANHG
							//
							/*
							if (SQLUtil.isSysAdmin(conn,auditBy)){
								thisCampus = "nocampus";
							}
							*/

							if (i % 2 == 0){
								clss="even thread-even";
							}
							else{
								clss="odd alt thread-odd thread-alt";
							}

							// if-else are identical with the exception of displaying of
							// a form with radio buttons to select the best answer for the
							// person asking
							if (answeredSeq > 0){
%>
								<!-- row start -->
								<div class="comment <%=clss%> depth-1" id="comment">
									<div class="commentmet_data" id="commentmet_data<%=id%>">
										<table cellpadding="0" cellspacing="0" width="100%">
											<tbody>
												<tr>
													<td colspan="2">
														<div class="commentmetadata">
															<span><%=auditBy%></span> answered on <%=auditDate%>
														</div>
													</td>
												</tr>
												<tr>
													<td width="102">
														<div class="commentmet_avatar">
															<img class="avatar" title="" alt="" src="<%=profileImage%>" width="48" border="0">
														</div>

														<%
															if (answeredSeq == seq){
														%>
																<p><img class="avatar" title="best answer" alt="best answer" src="../../images/bestanswer.jpg" width="48" border="0"></p>
														<%
															}
														%>
													</td>
													<td width="90%">
														<div class="commentmet_text" id="commentlist<%=id%>">
															<p><%=thisAnswer%></p>
															<div class="commentmet_replay"></div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<!-- row end -->
<%
							}
							else{
%>
								<!-- row start -->
								<div class="comment <%=clss%> depth-1" id="comment">
									<div class="commentmet_data" id="commentmet_data<%=id%>">
										<table cellpadding="0" cellspacing="0" width="100%">
											<tbody>
												<tr>
													<td colspan="2">
														<div class="commentmetadata">
															<span><%=auditBy%></span> said on <%=auditDate%>
														</div>
													</td>
												</tr>
												<tr>
													<td width="102">
														<div class="commentmet_avatar">
															<img class="avatar" title="best answer" alt="best answer" src="<%=profileImage%>" width="48" border="0">
															<br/>
															<!--
															<input type="radio" name="seq" value="<%=seq%>">
															-->
														</div>
														<%
															//
															// only creted gets to vote on best answer
															//
															if(askedby.equals(user)){
														%>
																<a href="/central/servlet/faq?cmd=bst&id=<%=id%>&seq=<%=seq%>"><img src="../../images/like.png" alt="best answer" title="best answer" width="60"></a>
														<%
															}
														%>
													</td>
													<td width="90%">
														<div class="commentmet_text" id="commentlist<%=id%>">
															<p><%=thisAnswer%></p>
															<div class="commentmet_replay"></div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<!-- row end -->
<%
							} // answeredSeq > 0

						} // for

					// only the person asking can select the best answer
					// sysadm is anonymous so make sure it shows the buttons
					//
					// since we are using like button, best answer button not needed
					//
					if (answeredSeq <= 0 && (user.equals(asker))){
%>
						<br>
						<!--
						<button title="Best Answer" type="submit" value="Best Answer" name="cmdBestAnswer" id="cmdBestAnswer" class="confirm_button green styled_button">Best Answer</button>
						-->
						<input type="hidden" name="cmd" value="bst">
						<input type="hidden" name="id" value="<%=id%>">
<%
					}
%>

				</form>
		</div> <!-- commentlist -->
	</div> <!-- body_top -->
</div> <!-- body -->

<%
			} // list
%>

<table border="0" width="100%">
	<tr>
		<td>
			<form method="post" action="/central/servlet/faq" name="aseForm">

				<%
					if (answeredSeq > 0){
						//
					}
					else{
				%>
					<h4 class="tutheader">What's your answer:</h4>
					<br>
					<%@ include file="../ckeditor02.jsp" %>
					<p>
					<button title="submit" type="submit" value="Submit" name="cmdSubmit" id="cmdSubmit" class="confirm_button green styled_button">Submit</button>
					<button title="cancel" type="submit" value="Cancel" name="cmdCancel" id="cmdCancel" class="cancel_button red styled_button" onClick="return cancelForm()">Cancel</button>
					</p>
				<%
					}
				%>

				<input type="hidden" name="cmd" value="ans">
				<input type="hidden" name="id" value="<%=id%>">

			</form>
		</td>
	</tr>
</table>

<%
	} // processPage

	session.setAttribute("aseApplicationMessage", "");

	asePool.freeConnection(conn,"ask",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>

<script type="text/javascript">

	jQuery.fn.highlight = function (str, className) {
		 var regex = new RegExp(str, "gi");
		 return this.each(function () {
			  $(this).contents().filter(function() {
					return this.nodeType == 3;
			  }).replaceWith(function() {
					return (this.nodeValue || "").replace(regex, function(match) {
						 return "<span class=\"" + className + "\">" + match + "</span>";
					});
			  });
		 });
	};

	$(document).ready(function () {

		<%
			//
			// highlighter
			//
			String[] aHighlights = "highlightWordYellow,highlightWordGreen,highlightWordDarkkhaki,highlightWordAqua,highlightWordPink".split(",");

			//
			// highlight text
			//
			if(!srch.equals(Constant.BLANK)){

				String[] aSrch = srch.split(Constant.SPACE);
				for(int z=0; z<aSrch.length; z++){
					%>
						$("#comment *").highlight("<%=aSrch[z]%>", "<%=aHighlights[z]%>");
					<%
				}

			} // highlight
		%>

	});

</script>

</body>
</html>
