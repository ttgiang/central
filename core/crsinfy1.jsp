<%
	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);
%>

<br/>
<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none" name="progress" class="linkcolumn">Outline Progress</a></td>
		<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
	</tr>
	<tr bgcolor="white">
		<td colspan="2">
			<%@ include file="crsedt9.jsp" %>
		</td>
	</tr>
</table>