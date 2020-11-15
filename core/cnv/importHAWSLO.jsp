<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

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
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HAW";
	String user = "SYSADM-HAW-SLO";
	String alpha = "";
	String num = "";
	String type = "";
	String kix = "";
	String message = "";

	System.out.println("Start<br/>");

	if (processPage){

		try{
			int pre = 0;
			int cur = 0;
			int read = 0;
			int processed = 0;
			int error = 0;
			String sql = "select * from hawslo";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				alpha = AseUtil.nullToBlank(rs.getString("crsalpha"));
				num = AseUtil.nullToBlank(rs.getString("crsno"));
				type = AseUtil.nullToBlank(rs.getString("status"));
				String comp = AseUtil.nullToBlank(rs.getString("slo"));
				kix = helper.getKix(conn,campus,alpha,num,type);

				if(!kix.equals("")){

					msg = CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,comp,0,user,kix);

					if (!"Exception".equals(msg.getMsg())){
						++processed;
					}
					else{
						++error;
					}

					if(type.equals("CUR")){
						++cur;
					}
					else if(type.equals("PRE")){
						++pre;
					}

				}
				else{
					out.println("missing kix: " + alpha + " " + num + " " + type + Html.BR());
				}
				// valid kix
			}
			rs.close();
			ps.close();

			out.println("Read: " + read + Html.BR());
			out.println("CUR: " + cur + Html.BR());
			out.println("PRE: " + pre + Html.BR());
			out.println("Processed: " + processed + Html.BR());
			out.println("Error: " + error + Html.BR());

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html
