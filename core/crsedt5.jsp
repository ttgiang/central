<link rel="stylesheet" type="text/css" href="./forum/inc/niceframe.css">
<link rel="stylesheet" type="text/css" href="./forum/inc/forum.css">

<style type="text/css">

	.collapse p {padding:0 10px 1em}
	.top{font-size:.9em; text-align:right}
	#switch, .switch {margin-bottom:5px; text-align:right}

	h2{font-size:1em}

	.expand{padding-bottom:.75em}

	/* --- Links  --- */
	a:link, a:visited {
	  border:1px dotted #ccc;
	  border-width:0 0 1px;
	  text-decoration:none;
	  color:blue
	}
	a:hover, a:active, a:focus {
	  border-style:solid;
	  background-color:#f0f0f0;
	  outline:0 none
	}

	a:active, a:focus {
	  color:red;
	}

	.expand a {
	  display:block;
	  padding:3px 10px
	}

	.expand a:link, .expand a:visited {
	  border-width:1px;
	  background-image:url(img/arrow-down.gif);
	  background-repeat:no-repeat;
	  background-position:98% 50%;
	  color: #E87B10;
	}

	.expand a:hover, .expand a:active, .expand a:focus {
	  color: #083772;
	}

	.expand a.open:link, .expand a.open:visited {
	  border-style:solid;
	  background:#eee url(img/arrow-up.gif) no-repeat 98% 50%
	}

	#accordionExample {
		border : 1px solid #4f4f4f;
		width: 99%;
	}

	.panelheader{
		background-image: url('images/panelBG.png');
		height: 22px;
		color : #525252;
		font-weight : bold;
		padding-left: 5px;
	}

	.panelContent {
		background: #f8f8f8;
		overflow: auto;
	}

	#boardcomments {
		border: 1px solid;
		color : #f8f8f8;
	}

</style>

<!--[if lte IE 7]>
	<style type="text/css">
	h2 a, .demo {position:relative; height:1%}
	</style>
<![endif]-->

<!--[if lte IE 6]>
	<script type="text/javascript">
		try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
	</script>
<![endif]-->
<!--[if !lt IE 6]><!-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="./js/expand_collapse.js"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--
$(function() {
	 // --- Using the default options:
	 $("h2.expand").toggler();
	 // --- Other options:
	 //$("h2.expand").toggler({method: "toggle", speed: 0});
	 //$("h2.expand").toggler({method: "toggle"});
	 //$("h2.expand").toggler({speed: "fast"});
	 //$("h2.expand").toggler({method: "fadeToggle"});
	 //$("h2.expand").toggler({method: "slideFadeToggle"});
	 $("#content").expandAll({trigger: "h2.expand", ref: "div.demo", localLinks: "p.top a"});
});
//--><!]]>
</script>
<!--<![endif]-->

					<tr>
						<td>
							<div class="hr"></div>
							<table border="0" width="100%">
								<tr>
									<td width="50%" nowrap valign="top">
										<div class="pagination">
											<%
												String si = "";		// used for page display
												String xi = "";		// used for help tool tip
												boolean enabled = false;
												int lineMax = maxNo + 1;
												String enabledItem = "linkcolumn";

												// save enabled items
												String printText = "";
												StringBuffer editable = new StringBuffer();

												lineMax = 15;

												try{
													for (i=1; i<=maxNo; i++){
														// during the approval process, items allowed for
														// modifications will be bolded. other items are read only
														enabled = false;

														enabledItem = "";

														// count number of comments by the question seq
														commentsCount = ReviewerDB.countReviewerCommentsBySeq(conn,kix,i,currentTab,0);

														// can this screen be saved?
														if ((bApproval && !sEdits[i-1].equals(Constant.OFF))){
															enabled = true;
														}

														si = "";

														// padding for 2 digit display
														if (currentTab==TAB_CAMPUS){
															si = "" + (i + courseTabCount);
															xi = "" + i;
														}
														else{
															if (i < 10)
																si = "0" + i;
															else
																si = "" + i;

															xi = si;
														}

														// printing or not to print depends on the current question
														if (i == currentSeq){
															printText = "<span class=\"current\"><b>" + si + "</span></b>\n";
															editable.append(printText);
														}
														else{
															if (enabled){
																if (currentTab==TAB_COURSE && (!QuestionDB.isCourseNumFromSequence(conn,campus,i) && !QuestionDB.isCourseAlphaFromSequence(conn,campus,i))){
																	si = "<font>" + si + "</font>";
																	enabledItem = "linkcolumn";
																}
																else if (currentTab==TAB_CAMPUS){
																	si = "<font>" + si + "</font>";
																	enabledItem = "linkcolumn";
																}
																else{
																	enabledItem = "";
																}
															}

															printText = "<a onmouseover=\"ajax_showTooltip('tooltip.jsp?src=item&si="+xi+"&tp="+currentTab+"',this);return false;\" onmouseout=\"ajax_hideTooltip()\" href=\"?ts="+currentTab+"&no="+i+"&kix="+kix+"\" class=\""+enabledItem+"\">"+si+"</a>&nbsp;";

															// if requesting to have condensed print, clear items not enabled
															if(condensedIndex && !enabled && !showAllIndex){
																printText = "";
															}

															editable.append(printText);

														} // matching sequence

														// count of items printed for page break handling
														if (!printText.equals("")){
															j++;
														}

														// drop to next line
														if ( j == lineMax ){
															printText = "<br/><br/>";
															editable.append(printText);
															j = 0;
														} // line break

													} // for

													// display collaspe/expand only when enabled items are available
													if(!showAllIndex){

														if (condensedIndex){
															printText = "<a href=\"?kix="+kix+"&idx=0&ts="+currentTab+"\"><img src=\"../images/expand/add.jpg\" border=\"0\" title=\"expand index\"></a>&nbsp;";
														}
														else{
															printText = "<a href=\"?kix="+kix+"&idx=1&ts="+currentTab+"\"><img src=\"../images/expand/subtract.jpg\" border=\"0\" title=\"collapse index\"></a>&nbsp;";
														}
														editable.append(printText);
													}  // showAllIndex

												}
												catch(Exception e){
													MailerDB mailerDB = new MailerDB(conn,campus,kix,faculty,e.toString(),"Outline modification");
												}

												out.println(editable.toString());

											%>
										</div>
									</td>
									<td valign="top">
										<%
											if(enableMessageBoard.equals(Constant.ON)){

												int forumItem = currentSeq;

												if(currentTab==Constant.TAB_CAMPUS){
													forumItem = forumItem + maxNoCourse;
												}

												int countOfCommentsForItem = Board.countOfCommentsForItem(conn,fid,forumItem);
												if(countOfCommentsForItem > 0){
													out.println("<h2 class=\"expand\">Message board comments</h2>"
													+ "<div class=\"collapse\">"
													+ Board.showBoardCommentsForItem(conn,faculty,fid,forumItem)
													+ "</div>");
												}
											}
										%>
									</td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td valign="top">
										<%@ include file="crsedt12.jsp" %>
										<img src="images/category.gif" border="0" title="view item index">&nbsp;<a href="crsqstq.jsp?ts=<%=currentTab%>&h=0" class="linkColumn" onclick="asePopUpWindow(this.href,'aseWin_Crsedt5','800','600','yes','center');return false" onfocus="this.blur()">item index</a>
										&nbsp;
										<img src="images/category.gif" border="0" title="view help index">&nbsp;<a href="crsqstq.jsp?ts=<%=currentTab%>&h=1" class="linkColumn" onclick="asePopUpWindow(this.href,'aseWin_Crsedt6','800','600','yes','center');return false" onfocus="this.blur()">help index</a>

										<%
											if (HistoryDB.hasHistory(conn,campus,kix)){
										%>
											&nbsp;
											<img src="images/comment.gif" border="0" title="approval history">&nbsp;<a href="crsrvwcmnts.jsp?kix=<%=kix%>" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWin_Crsedt7','800','600','yes','center');return false" onfocus="this.blur()">approver comments</a>
										<%
											}
										%>

									</td>
								</tr>
							</table>
						</td>
					</tr>

