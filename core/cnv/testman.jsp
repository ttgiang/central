<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.exception.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Assign History ID";
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

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "VIET";
	String num = "197Z";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "l30i20f10222&";
	String message = "";
	String url = "";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(createHistoryID(conn));
		}
		catch(Exception ce){
			//System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static int createHistoryID(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

int rowsAffected = 0;

		try {
			PreparedStatement ps2 = null;

			System.out.println("----------------------------- START");

			String sql = "SELECT id FROM tblcourseman";

			System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int key = rs.getInt("id");
				if (key > 0){
					String kix = SQLUtil.createHistoryID(1) + key;
					sql = "UPDATE tblcourseman SET historyid=?,id=? WHERE id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setString(2,kix);
					ps2.setInt(3,key);
					rowsAffected += ps2.executeUpdate();
					System.out.println(key);
				}
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- END");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

