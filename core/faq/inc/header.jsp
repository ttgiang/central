<%
	String aseFormSearchValue = (String)session.getAttribute("aseFormSearchValue");
	aseFormSearchValue = aseUtil.nullToBlank(aseFormSearchValue);
%>

<div id="forum_wrapper">
	  <div id="forum_header">
			<form method="post" action="faq.jsp" name="aseSearch">
				<table border="0" width="100%">
					<tr>
						<td>
							<a href="faq.jsp"><img src="./inc/ccanswers.gif" border="0" alt="cc answers!"></a>&nbsp;&nbsp;&nbsp;&nbsp;

							<a href="faq.jsp?a=0" class="bluelinkcolumn">View CC Answers!</a>
							<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
							<a href="faq.jsp?a=1" class="bluelinkcolumn">View Archive</a>

							<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
							<a href="ask.jsp" class="bluelinkcolumn">Ask a Question</a>

							<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
							<a href="myq.jsp" class="bluelinkcolumn">My Questions</a>

							<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
							&nbsp;&nbsp;Search:&nbsp;&nbsp;<input class="input" name="srch" size="30" value="<%=aseFormSearchValue%>" type="text">
							<input type="submit" value="Go" name="cmdSubmit" class="input">
							<img src="../images/helpicon.gif" border="0" alt="show CC Answers! help" title="show CC Answers! help" onclick="switchMenu('ccanswerhelp');">
							<input type="hidden" name="cmd" value="srch">
						</td>
						<%
							if (SQLUtil.isSysAdmin(conn,user)){

								int pointsEarned = com.ase.aseutil.faq.AnswerDB.getScore(user);
						%>
							<td align="right">
								<a href="scores.jsp" class="bluelinkcolumn">Scores</a>
							</td>
							<td align="right">
								Points Earned: <%=pointsEarned%>
								&nbsp;&nbsp;&nbsp;
							</td>
						<%
							}
						%>
					</tr>
				</table>
			</form>
		</div>
<p align="left">

<div id="ccanswerhelp" style="width: 100%; display:none;">
	<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
		<TBODY>
			<TR>
				<TD class=title-bar width="50%"><font class="textblackth">CC Answers!</font></TD>
				<td class=title-bar width="50%" align="right">
					<img src="../../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('ccanswerhelp');">
				</td>
			</TR>
			<TR>
				<TD colspan="2">
<h2>What is CC Answers!</h2>
<p>
	CC Answers! is a place where users ask and answer questions on any topic (course, programs, other). This is the place to share your experience and opinions with
	other CC users?
</p>

<p><span class="textblackth">ASK</span></p>
<p><span class="datacolumn">Asking is easy. Ask a question on any category that matters to you, so that other people can give you answers.</span></p>
<p><span class="textblackth">CATEGORIZE</span></p>
<p><span class="datacolumn">When asking a question, you categorize it, making it easier for others to find and answer it.</span></p>
<p><span class="textblackth">ANSWER</span></p>
<p><span class="datacolumn">Have an answer to a question? Share what you know and make someone's day.</span></p>
<p><span class="textblackth">BEST Answer</span></p>
<p><span class="datacolumn">Once your question has been answered, you can pick the best answer to tell others the approach that works best for you.</span></p>
<p><span class="textblackth">SEARCH</span></p>
<p><span class="datacolumn">You can also use the search box on each page to locate questions and answers related to specific words and phrases.</span></p>

					</p>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>

<%
	session.setAttribute("aseFormSearchValue","");
%>
