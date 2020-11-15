<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cchlp.jsp
	*	2007.09.01
	**/

	String mp4 = website.getRequestParameter(request,"m","");
	String player = website.getRequestParameter(request,"p","help");
	String pageTitle = "Curriculum Central Help";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"ccmp4",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%

if ("qt".equals(player)){
%>
	<OBJECT CLASSID="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" CODEBASE="http://www.apple.com/qtactivex/qtplugin.cab"
		WIDTH="160"
		HEIGHT="136" >

	<PARAM NAME="src" VALUE="/centraldocs/docs/help/<%=mp4%>.mp4" >
	<PARAM NAME="autoplay" VALUE="true" >

	<EMBED SRC="/centraldocs/docs/help/<%=mp4%>.mp4"
		TYPE="image/x-macpaint"
		PLUGINSPAGE="http://www.apple.com/quicktime/download"
		WIDTH="160"
		HEIGHT="136"
		AUTOPLAY="true"></EMBED>
	</OBJECT>
<%
}
else if ("wmp".equals(player)){
%>

	<OBJECT id="VIDEO" width="320" height="240"
		style="position:absolute; left:0;top:0;"
		CLASSID="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"
		type="application/x-oleobject">

		<PARAM NAME="URL" VALUE="your file or url">
		<PARAM NAME="SendPlayStateChangeEvents" VALUE="True">
		<PARAM NAME="AutoStart" VALUE="True">
		<PARAM name="uiMode" value="none">
		<PARAM name="PlayCount" value="9999">

		<embed type="application/x-mplayer2"
			pluginspage="http://microsoft.com/windows/mediaplayer/en/download/"
			showcontrols="true" uimode="full" width="300" height="45"
			src="/centraldocs/docs/help/<%=mp4%>.mp4" autostart="true" loop="true">
	</OBJECT>
<%
}
else if ("help".equals(player)){
%>

<table border="0" width="100%" id="table1">
	<tr>
		<td width="72%" bgcolor="#E0E0E0" class="textblackth">Select Media Format</td>
	</tr>
	<tr>
		<td width="72%">
			<ul>
				<li>
					<a href="/central/core/ccmp4.jsp?m=<%=mp4%>&p=qt" class="linkcolumn"><img src="../images/quicktime.gif" border="0" alt="quick time"></a>
				</li>
				<li>
					<a href="/central/core/ccmp4.jsp?m=<%=mp4%>&p=wmp" class="linkcolumn"><img src="../images/mp3.gif" border="0" alt="media player"></a>
				</li>
			</ul>
		</td>
	</tr>

	<tr>
		<td width="72%" bgcolor="#E0E0E0" class="textblackth">Downloads</td>
	</tr>
	<tr>
		<td>
			<table border="0" width="100%" id="table1">
				<tr>
					<td width="50"><img src="../images/quicktime.gif" border="0"></td>
					<td><a href="http://www.apple.com/quicktime/download" class="linkcolumn" target="_blank">Apple Quick Time player</a></td>
				</tr>
				<tr>
					<td width="50"><img src="../images/mp3.gif" border="0"></td>
					<td><a href="http://www.microsoft.com/windows/windowsmedia/download/" class="linkcolumn" target="_blank">Microsoft Windows Media Player</a></td>
				</tr>
				<tr>
					<td width="50"><img src="../images/swf.gif" border="0"></td>
					<td><a href="http://get.adobe.com/flashplayer/" class="linkcolumn" target="_blank">Adobe Flash Player</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
}
%>

</body>
</html>
