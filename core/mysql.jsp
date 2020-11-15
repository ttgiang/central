<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="org.gjt.mm.mysql.*"%>
<%@ page import="com.mysql.jdbc.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
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

	if (processPage){
		main(conn);
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static String main(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		System.out.println("MySQL Connect Example.");
		Connection mysql = null;
		String url = "jdbc:mysql://localhost:3306/";
		String dbName = "zippys";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "root";
		String password = "z1ppies";

		String field = "orderID,unitordered,unitdelivered,ordertakenby,orderdate,customername,phonenumber,pickupdate,pickuptime,attachment,cakesize,cakeflavor,decoration,color,characters,portrait,dressstyle,haircolor,wording,wordingexcess,specialinstructions,orderreceivedby,attachmentreceived,delivered,receiveddelivery,Totalprice,background,candles,Multiplier,DPcode,custom,Status";
		String data = "n,n,n,s,s,s,s,s,s,n,n,n,n,n,n,n,n,n,s,i,s,i,i,s,s,i,i,i,i,i,i,s";

		String[] fields = field.split(",");
		String[] datas = data.split(",");

		StringBuffer buf = new StringBuffer();

		try {
			Class.forName(driver).newInstance();

			mysql = DriverManager.getConnection(url+dbName,userName,password);

			boolean error = false;

			int orderid = 0;

			int rowsAffected = 0;

			System.out.println("Connected to the database");

			Statement s = null;

			// clean up first
			try{
				s = mysql.createStatement();
				rowsAffected = s.executeUpdate("delete from order_admin");
				s.close();
			}
			catch(Exception e){
				logger.fatal(e.toString());
			}

			String sql = "";
			PreparedStatement ps = null;

			// clean up first
			try{
				sql = "update orders set pickupdate=null where isdate(pickupdate)=0";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();

				sql = "update orders set receiveddelivery=null where isdate(receiveddelivery)=0";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();

				sql = "update orders set delivered=null where isdate(delivered)=0";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
			}
			catch(Exception e){
				logger.fatal(e.toString());

			}

			String fileName = "/tomcat/webapps/bakery/import.sql";

			FileWriter fstream = new FileWriter(fileName);

			BufferedWriter output = new BufferedWriter(fstream);

			// read and insert
			sql = "SELECT * FROM orders ORDER BY orderid";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next() && !error){

				orderid = rs.getInt("orderid");
				String receiveddelivery = AseUtil.nullToBlank(rs.getString("receiveddelivery"));
				String delivered = AseUtil.nullToBlank(rs.getString("delivered"));
				String pickupdate = AseUtil.nullToBlank(rs.getString("pickupdate"));

				buf.setLength(0);

				for(int i = 0; i < datas.length; i++){
					String junk = "";

					if (datas[i].equals("s")){
						junk = AseUtil.nullToBlank(rs.getString(fields[i]));

						if ( 	fields[i].toLowerCase().indexOf("pickupdate") > -1 ||
								fields[i].toLowerCase().indexOf("delivered") > -1 ||
								fields[i].toLowerCase().indexOf("receiveddelivery") > -1
								){

							if(junk == null || junk.equals(Constant.BLANK)){
								junk = null;
							}
						}

						if (junk != null){
							junk = junk.replace("Null","");
							junk = junk.replace("\\","\\\\");
							junk = junk.replace("\"","in.");
							junk = "\'" + junk.replace("\'","\'\'") + "\'";
						}

					}
					else{
						junk = "" + NumericUtil.getInt(rs.getInt(fields[i]),0);
					} // if

					if (i==0){
						buf.append(junk);
					}
					else{
						buf.append("," + junk);
					}

				} // for

				sql = "INSERT INTO order_admin_x ("+field+") VALUES("+buf.toString()+");";
				sql = sql.replace("","");

				try{
					//s = mysql.createStatement();
					//rowsAffected = s.executeUpdate(sql);
					//s.close();

					output.write(sql + "\n\n");
				}
				catch(Exception e){
					error = true;
					logger.fatal("\n\n" + e.toString() + "\n\nsql: " + sql + "\n\norderid: " + orderid + "\n\nreceiveddelivery: " + receiveddelivery);
				}

			} // while

			rs.close();
			ps.close();

			mysql.close();
			output.close();

			System.out.println("Disconnected from database");

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return "";

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html