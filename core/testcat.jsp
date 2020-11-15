<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>
<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		String kix = helper.getKix(conn,"KAP","ENG","100","CUR");;

		String courseItems = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + "KAP" + "'" );

		String[] co = courseItems.split(",");

		int i = 0;

		String explain = "";

		for(i = 0; i < co.length; i++){
			explain = QuestionDB.getExplainColumnName(conn,co[i]);

			if (explain != null && explain.length() > 0){
				 explain = " [cd." + explain + "] ";
			}
			else{
				explain = "";
			}

			out.println((i+1) + ". [c." + co[i] + "] " + explain + Html.BR() + Html.BR() + "<div class=\"hr\"></div>");
		}

		String campusItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + "KAP" + "'" );

		String[] ca = campusItems.split(",");

		for(int j = 0; j < ca.length; j++){

			explain = QuestionDB.getExplainColumnName(conn,ca[j]);

			if (explain != null && explain.length() > 0){
				 explain = " [cd." + explain + "] ";
			}
			else{
				explain = "";
			}

			out.println((i+1) + ". [cd." + ca[j] + "]"  + explain + Html.BR() + Html.BR() + "<div class=\"hr\"></div>");
			++i;
		}

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");

/*

<p>
	1. [c.coursealpha]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	2. [c.coursenum]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	3. [c.X46]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	4. [c.coursetitle]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	5. [c.coursedate]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	6. [c.X15] [cd.C25]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	7. [c.X16] [cd.C26]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	8. [c.X17]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	9. [c.credits] [cd.C23]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	10. [c.repeatable] [cd.C19]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	11. [c.maxcredit]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	12. [c.crosslisted]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	13. [c.X32] [cd.C20]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	14. [c.hoursperweek]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	15. [c.coursedescr]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	16. [c.X23] [cd.C11]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	17. [c.X24] [cd.C10]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	18. [c.X71]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	19. [c.X72]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	20. [c.X18]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	21. [c.X43]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	22. [c.X19]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	23. [c.X20]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	24. [c.X22]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	25. [c.X21]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	26. [c.semester] [cd.C18]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	27. [c.effectiveterm]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	28. [c.X68] [cd.C17]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	29. [c.gradingoptions] [cd.C16]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	30. [c.X77]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	31. [c.X29] [cd.C33]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	32. [c.X27] [cd.C32]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	33. [c.X51]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	34. [c.X34]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	35. [c.X45]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	36. [c.X44]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	37. [c.X25]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	38. [c.X57]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	39. [c.X58]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	40. [c.X59]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	41. [c.X61]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	42. [c.X56] [cd.C12]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	43. [c.X60]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	44. [c.X38]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	45. [c.X42]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	46. [c.X40] [cd.C34]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	47. [c.X49]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	48. [c.X69]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	49. [c.X74]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	50. [c.excluefromcatalog]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	51. [cd.C1]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	52. [cd.C2]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	53. [cd.C3]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	54. [cd.C4]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	55. [cd.C5]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	56. [cd.C40]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	57. [cd.C41]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	58. [cd.C42]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	59. [cd.C43]<br />
	&nbsp;</p>
<hr size="1" />
<p>
	60. [cd.C6]<br />
	&nbsp;</p>
<hr size="1" />
<hr size="1" />
<p>
	&nbsp;</p>

*/

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html