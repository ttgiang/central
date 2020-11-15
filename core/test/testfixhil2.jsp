<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	out.println("Start<br/>");

	int rowsAffected = 0;

	String reqType = "2";
	String alpha = "";
	String num = "";
	String alphaX = "";
	String numX = "";
	String kix = "";

	try{

		PreparedStatement ps2 = null;

		String sql = "SELECT alpha,num,alphax,numx FROM _coreq ORDER BY alphax,numx";
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			alpha = AseUtil.nullToBlank(rs.getString("alpha"));
			num = AseUtil.nullToBlank(rs.getString("num"));

			alphaX = AseUtil.nullToBlank(rs.getString("alphax"));
			numX = AseUtil.nullToBlank(rs.getString("numx"));

			kix = Helper.getKix(conn,"HIL",alpha,num,"CUR");
			if (!"".equals(kix)){
				sql = "INSERT INTO tblCoReq "
					+ " (coursealpha,coursenum,campus,coursetype,historyid,CoreqAlpha,CoreqNum,grading,auditby,id) VALUES(?,?,?,?,?,?,?,?,?,?)";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,alpha);
				ps2.setString(2,num);
				ps2.setString(3,"HIL");
				ps2.setString(4,"CUR");
				ps2.setString(5,kix);
				ps2.setString(6,alphaX);
				ps2.setString(7,numX);
				ps2.setString(8,"");
				ps2.setString(9, "SYSTEM");
				ps2.setInt(10, RequisiteDB.getNextRequisiteNumber(conn,reqType));
				//rowsAffected = ps2.executeUpdate();  - completed on 11/1/09
				ps2.close();
				out.println(alphaX + " " + numX + " ---> " + alpha + " " + num + "<br/>");
			}
			else
				out.println(alphaX + " " + numX + " --- " + alpha + " " + num + "<br/>");
		}
		rs.close();
		ps.close();
	}
	catch(SQLException sx){
		System.out.println("fix - " + sx.toString());
	} catch(Exception ex){
		System.out.println("fix - " + ex.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

