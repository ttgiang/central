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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "m55g17d9203";
	String src = "x43";
	String dst = "m55g17d9203";
	out.println("Start<br/>");

System.out.println("===========================================");

	kix = website.getRequestParameter(request,"kix");
	//System.out.println("1: " + kix);
	System.out.println(spamy(kix));
	kix = spamy(kix);
	//System.out.println("2: " + kix);
	if (!"".equals(kix)){

	//System.out.println("3: " + kix);

			String[] info = new String[6];
			info[0] = "";
			info[1] = "";

			try{
				String sql = "SELECT coursealpha,coursenum,coursetype,proposer,campus,historyid " +
					"FROM tblCourse " +
					"WHERE id=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					info[0] = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					info[1] = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
					info[2] = aseUtil.nullToBlank(rs.getString("coursetype")).trim();
					info[3] = aseUtil.nullToBlank(rs.getString("proposer")).trim();
					info[4] = aseUtil.nullToBlank(rs.getString("campus")).trim();
					info[5] = aseUtil.nullToBlank(rs.getString("historyid")).trim();
				}
				else{
					info[0] = "No data";
				}
				rs.close();
				ps.close();
			}
			catch(Exception ex){
				System.out.println("Helper: getKixInfo\n" + ex.toString());
				info[0] = "";
			}

		alpha = info[0];
		num = info[1];
		type = info[2];

		out.println(info[0] + "<br/>");
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public String spamy(String kix){

		String html = "";

		 String inputString = null;
		 StringBuffer buf = new StringBuffer();

		 buf.append("This is all normal text.\n");
		 buf.append("But suddenly out of the blue...\n");
		 buf.append("An eveil laughter crackles in the cold night...\n");
		 buf.append("<SCRIPT>alert('HAHAHA');</SCRIPT>\n");
		 buf.append("Did you hear that??!!\n");
		 buf.append("No?\n");
		 buf.append("How about this twisted one: <SCRIPT>alert(\"HAHAHA\");</SCRIPT><SCRIPT>alert(\"HAHAHA\");</SCRIPT><SCRIPT>alert(\"HAHAHA\");</SCRIPT><SCRIPT>alert(\"HAHAHA\");</SCRIPT>\n");
		 buf.append("Or this eveil smile!!! <IMG SRC=\"javascript:alert('XSS');\" />\n");
		 buf.append("Its actually worse than the laugh right? Right?\n");
		 buf.append("\n");
		 buf.append("ok ok. Heres a normal smile <IMG SRC='javascript' />\n");
		 buf.append("Hows that!");
		 inputString = buf.toString();

		 System.out.println(inputString);

		try{
			Policy policy = Policy.getInstance("d:/tomcat/webapps/central/WEB-INF/resources/AntiSamy.xml");
System.out.println("got policy");
			AntiSamy sanitizer = new AntiSamy(policy);
System.out.println("got samy");
			CleanResults cr = sanitizer.scan(inputString);
System.out.println("scanned");
			html = cr.getCleanHTML();
System.out.println("cleaned");
			if (!cr.getErrorMessages().isEmpty()) {
				System.out.println("Input contains errors");
			}

		}catch(ScanException se){
			System.out.println(se.toString());
		}catch(PolicyException pe){
			System.out.println(pe.toString());
		}catch(Exception e){
			System.out.println(e.toString());
		}

		return html;
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
