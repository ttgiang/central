	<%
		// only course and campus tab requires currentNo > 0
		if (currentTab < Constant.TAB_COURSE || currentTab > Constant.TAB_CAMPUS){
			currentNo = 0;
		}

		if (approvalHistory > 0 && enableMessageBoard.equals(Constant.OFF)){
	%>
		<img src="images/history.gif" border="0" title="view approval history">&nbsp;<a href="crshst.jsp?hid=<%=kix%>&t=PRE" class="linkColumn"  onclick="asePopUpWindow(this.href,'aseWinCrsedt121','800','600','yes','center');return false" onfocus="this.blur()">approval history&nbsp;(<%=approvalHistory%>)</a>
	<%
		}

		if (enableMessageBoard.equals(Constant.ON)){
			if (currentTab>0 && fid>0){
				out.println("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"images/document.gif\" border=\"0\" title=\"message board\">&nbsp;<a href=\"forum/usrbrd.jsp?fid="+fid+"&ts="+currentTab+"&orig="+Constant.COURSE+"&src="+Constant.COURSE+"&item="+currentSeq+"&kix="+kix+"\" class=\"linkColumn\">message board</a>&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;");
			}
		}
		else{
			if (approverComments > 0 || reviewerComments > 0){

				long allComments = approverComments + reviewerComments;

				if (approverComments > 0 || reviewerComments > 0){
					out.println("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"images/comment.gif\" border=\"0\" title=\"view reviewer comments\">&nbsp;<a href=\"crsrvwcmnts.jsp?c="+currentTab+"&md="+Constant.REVIEW+"&kix="+kix+"&qn="+currentNo+"\" class=\"linkColumn\" onclick=\"asePopUpWindow(this.href,'aseWinCrsedt123','800','600','yes','center');return false\" onfocus=\"this.blur()\">approver/reviewer comments&nbsp;("+allComments+")</a>");
				}

			}
		} // board is off

	%>
