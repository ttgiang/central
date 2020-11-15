<%
	if (processPage && displayApprovalRecommendation.equals(Constant.ON) && !isLastApprover){

		%>
			<div class="hr"></div>
			<br/>
			To send an approval recommendation to the next approver, complete the form below and click 'Send'
			<br/><br/>
		<%

		int getApproverSequence = 0;

		route = ProgramsDB.getProgramRoute(conn,campus,kix);

		// determine where this person is in the approval sequence. it is
		// possible this person is on the approval route more than once.
		// if first time in, that's easy. sequence is 1. If count > 0
		// then adjust to make sure we get the correct next approver
		long count = ApproverDB.countApprovalHistory(conn,kix);
		if (count == 0){
			getApproverSequence = 1;
		}
		else{
			// determine the last approved sequence, get the next
			getApproverSequence = ProgramsDB.getLastSequenceToApprove(conn,campus,kix);

			// add 1 makes it current user's turn
			++getApproverSequence;
		}

		// add 1 more to obtain the person following this user

		int nextSequence = ++getApproverSequence;

		int approversThisSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);
		if(approversThisSequence > 1){
			nextApprover = DivisionDB.getChairName(conn,campus,num);
		}
		else{
			nextApprover = ApproverDB.getApproverBySeq(conn,campus,nextSequence,route);
		}

		if (nextApprover != null && !nextApprover.equals(Constant.BLANK)){
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'prgapprz.jsp\'>" );
			out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\" width=\"15%\">From:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\' valign=\"top\">"+user+"</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">To:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\' valign=\"top\">"+nextApprover+"</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' valign=\"top\">Subject:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\' valign=\"top\">CC: Program Approval Recommendation ("+alpha+")</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Message:&nbsp;</td>" );
			out.println("					 <td>" );

			FCKeditor fckEditor = new FCKeditor(request,"content","580","300","ASE","","");
			out.println(fckEditor);

			out.println("					</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Send\' class=\'inputsmallgray\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' id=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'nextApprover\' id=\'nextApprover\' value=\'"+nextApprover+"\'>" );
			out.println("							<input type=\'hidden\' name=\'kix\' id=\'kix\' value=\'"+kix+"\'>" );
			out.println("							<input type=\'hidden\' name=\'route\' id=\'route\' value=\'"+route+"\'>" );
			out.println("							<input type=\'hidden\' name=\'voteFor\' voteFor=\'kix\' value=\'"+voteFor+"\'>" );
			out.println("							<input type=\'hidden\' name=\'getLastSequenceToApprove\' voteFor=\'getLastSequenceToApprove\' value=\'"+nextSequence+"\'>" );
			out.println("							<input type=\'hidden\' name=\'voteAgainst\' id=\'voteAgainst\' value=\'"+voteAgainst+"\'>" );
			out.println("							<input type=\'hidden\' name=\'voteAbstain\' id=\'voteAbstain\' value=\'"+voteAbstain+"\'>" );
			out.println("							<input type=\'hidden\' name=\'comments\' id=\'comments\' value=\'"+comments+"\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		} // nextApprover
	} // processPage

%>
