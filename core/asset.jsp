<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Listing";
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
		<form name="aseForm" action="testz.jsp" method="post">
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "UNIV";
	String num = "101";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "255i7d119";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

%>
	<p>&nbsp;&nbsp;</p>
	<ul>
		<li><a href="?idx=1" class="linkcolumn">Conversion 1</a></li>
		<li><a href="?idx=2" class="linkcolumn">Conversion 2</a></li>
		<li><a href="?idx=3" class="linkcolumn">Conversion 3</a></li>
		<li><a href="?idx=4" class="linkcolumn">Conversion 4</a></li>
		<li><a href="?idx=5" class="linkcolumn">Conversion 5</a></li>
	</ul>

<%

	if (processPage){

		int idx = website.getRequestParameter(request,"idx",0);

		if (idx > 0){
			process01(conn,idx);

			out.println("&nbsp;&nbsp;&nbsp;&nbsp;processed - " + idx);
		}

	}

	System.out.println("***End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!
	public static void process01(Connection conn,int idx) throws Exception {

Logger logger = Logger.getLogger("test");

		String sql = "";

		switch(idx){
			case 1:
				sql= "SELECT distinct userid FROM zzzassets WHERE userid>'A' AND userid<'E' ORDER BY USERID";
				break;
			case 2:
				sql= "SELECT distinct userid FROM zzzassets WHERE userid>'E' AND userid<'I' ORDER BY USERID";
				break;
			case 3:
				sql= "SELECT distinct userid FROM zzzassets WHERE userid>'I' AND userid<'M' ORDER BY USERID";
				break;
			case 4:
				sql= "SELECT distinct userid FROM zzzassets WHERE userid>'M' AND userid<'Q' ORDER BY USERID";
				break;
			case 5:
				sql= "SELECT distinct userid FROM zzzassets WHERE userid>'Q' ORDER BY USERID";
				break;
		}

		StringBuffer temp = new StringBuffer();

		FileWriter fstream = null;

		BufferedWriter output = null;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String dept = "";
				String user = AseUtil.nullToBlank(rs.getString("userid"));

				String filename = user.toUpperCase();

System.out.println(user);

				fstream = new FileWriter("L:\\COMMON\\zoom\\printers\\software\\" + filename + ".txt");
				output = new BufferedWriter(fstream);
				output.write("Standard Software\n");
				output.write("-----------------\n");
				output.write(process02(conn,dept,user,"S"));
				output.write("\n\n");
				output.write("Non-Standard Software\n");
				output.write("---------------------\n");
				output.write(process02(conn,dept,user,"N"));
				output.write("\n\n");
				output.write("Other Installed Software\n");
				output.write("------------------------\n");
				output.write(process04(conn,dept,user));
				output.close();
				fstream = null;
			}
		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

	} //

	public static String process02(Connection conn,String dept,String user,String type) throws Exception {

Logger logger = Logger.getLogger("test");

		String sql = "SELECT App2 FROM zzzsoftware WHERE Type=?";

		StringBuffer temp = new StringBuffer();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String name = AseUtil.nullToBlank(rs.getString("App2"));
				if (process03(conn,name,dept,user)){
					temp.append(name + "\n");
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal(e.toString() + "\n" + dept + " - " + user);
		}

		return temp.toString();
	} //

	public static boolean process03(Connection conn,String name,String dept,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		String sql = "SELECT DISTINCT NAME FROM zzzassets WHERE userid=? AND NAME like '%"+name+"%'";

		boolean found = false;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			found = rs.next();
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal(e.toString() + "\n" + name + "\n" + dept + " - " + user);
		}

		return found;
	} //

	public static String process04(Connection conn,String dept,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		String sql = "SELECT DISTINCT NAME FROM zzzassets WHERE userid=? AND NOT NAME IN (SELECT app2 FROM zzzsoftware)";

		StringBuffer temp = new StringBuffer();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				temp.append(AseUtil.nullToBlank(rs.getString("NAME")) + "\n");
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal(e.toString() + "\n" + dept + " - " + user);
		}

		return temp.toString();
	} //

%>

</form>
		</td>
	</tr>
</table>

</body>
</html>