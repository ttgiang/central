<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.PrintWriter"%>

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

	String campus = "KAP";
	String alpha = "ENG";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "520l15m1180";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		main(conn,response,campus,"CUR","MODIFY");

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static int main(Connection conn,HttpServletResponse res,String campus,String type,String progress) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int i = 0;

		try{
			PrintWriter out = res.getWriter();

			out.println(Html.BR() + Html.BR());

			out.println("<table width=\"100%\" border=\"0\">");

			out.println("<tr>");
			out.println("<td width=\"15%\">&nbsp;</td>");
			out.println("<td width=\"15%\">&nbsp;</td>");
			out.println("<td width=\"35%\">CUR</td>");
			out.println("<td width=\"35%\">PRE</td>");
			out.println("</tr>");

			String sql = "select * from tbltasks where campus=? and coursetype=? and progress=? order by coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,type);
			ps.setString(3,progress);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String message = AseUtil.nullToBlank(rs.getString("message"));

				String curKix = Helper.getKix(conn,campus,alpha,num,type);
				String[] info = Helper.getKixInfo(conn,curKix);
				String proposer = info[Constant.KIX_PROPOSER];
				String courseTitle = info[Constant.KIX_COURSETITLE];
				int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

				String preKix = Helper.getKix(conn,campus,alpha,num,"PRE");
				String preProposer = info[Constant.KIX_PROPOSER];
				String preProgress = info[Constant.KIX_PROGRESS];
				String preCourseTitle = info[Constant.KIX_COURSETITLE];
				int preRoute = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">" + (++i) + "</td>");
				out.println("<td colspan=\"2\">" + "<a href=\"crscmprx.jsp?ks="+preKix+"&kd="+preKix+"\" target=\"_blank\">" + alpha + " - " + num + "</a> ("+message+")" + "</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">proposer</td>");
				out.println("<td width=\"35%\">"+proposer+"</td>");
				out.println("<td width=\"35%\">"+preProposer+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">kix</td>");
				out.println("<td width=\"35%\">"+curKix+"</td>");
				out.println("<td width=\"35%\">"+preKix+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">route</td>");
				out.println("<td width=\"35%\">"+route+"</td>");
				out.println("<td width=\"35%\">"+preRoute+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">courseTitle</td>");
				out.println("<td width=\"35%\">"+courseTitle+"</td>");
				out.println("<td width=\"35%\">"+preCourseTitle+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">progress</td>");
				out.println("<td width=\"35%\">"+progress+"</td>");
				out.println("<td width=\"35%\">"+preProgress+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">auditdate</td>");
				out.println("<td width=\"35%\">"+CourseDB.getCourseItem(conn,curKix,"auditdate")+"</td>");
				out.println("<td width=\"35%\">"+CourseDB.getCourseItem(conn,preKix,"auditdate")+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">reviewerComments</td>");
				out.println("<td width=\"35%\">"+ReviewerDB.countActiveReviews(conn,curKix)+"</td>");
				out.println("<td width=\"35%\">"+ReviewerDB.countActiveReviews(conn,preKix)+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">approvalHistory</td>");
				out.println("<td width=\"35%\">"+ApproverDB.countApprovalHistory(conn,curKix)+"</td>");
				out.println("<td width=\"35%\">"+ApproverDB.countApprovalHistory(conn,preKix)+"</td>");
				out.println("</tr>");

				out.println("<tr>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"15%\">&nbsp;</td>");
				out.println("<td width=\"35%\">&nbsp;</td>");
				out.println("<td width=\"35%\">&nbsp;</td>");
				out.println("</tr>");

			}
			rs.close();
			ps.close();

			out.println("</table>");

		} catch (SQLException e) {
			logger.fatal("Test: main - " + e.toString());
		} catch (IOException e) {
			logger.fatal("Test: main - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Test: main - " + e.toString());
		}

		return rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

</body>
