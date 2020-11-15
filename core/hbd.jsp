<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "HAWAII BUSINESS DATABASE, INC.";
	fieldsetTitle = pageTitle;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	int startPage = website.getRequestParameter(request,"s",0);
	int endPage = website.getRequestParameter(request,"e",0);
	String isle = website.getRequestParameter(request,"isle","OAHU");
	String idx = website.getRequestParameter(request,"idx","0");

%>

<html>
<head>
	<title><%=pageTitle%></title>
	<%@ include file="ase2hbd2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	out.println(getHBD(conn,out,isle,idx));
	asePool.freeConnection(conn);
%>

<%!
	public static String getHBD(Connection conn,
										javax.servlet.jsp.JspWriter out,
										String isle,
										String idx) throws Exception {

		try{
			int increment = 272;			// 304 entries per page
			long startID = 0;				// starting id to read from
			long endID = 0;				// ending id

			long thisStart = 0;
			long thisEnd = 0;

			int pages = 0;

			if ("0".equals(idx))
				idx = "[0-9]";
			else
				idx = idx + "%";

			String sql = "SELECT MIN(id) AS startID,MAX(id) AS endID "
				+ "FROM output "
				+ "WHERE island='"+isle+"' AND alpha like '"+idx+"'";
			//System.out.println(sql);
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				thisStart = rs.getLong("startID");
				thisEnd = rs.getLong("endID");
			}
			rs.close();
			ps.close();

			System.out.println("----------------------------- START");
			System.out.println(pages + ": " + thisStart + " to " + thisEnd);

			//out.println("Start-End: " + thisStart + " to " + thisEnd + "<br/>");

			boolean run = true;

			while((endID <= thisEnd) && run){
				++pages;

				// where to start from. first time through from nothing
				if (startID==0)
					startID = thisStart;
				else
					startID = endID;

				// process only x entries each loop
				endID = startID + increment;

				// cannot go beyond end
				if (endID > thisEnd){
					endID = thisEnd;
					run = false;
				}

				System.out.println("page: " + pages + " -  " + startID + " to " + endID);
				//out.println(pages + "," + startID + "," + endID + "," + (endID-startID) +"<br/>");

				// where was the last end point. start again from there
				endID = showHBD(conn,out,startID,endID);
			}

			System.out.println("----------------------------- END");
		}
		catch(Exception e){
			out.println(e.toString());
		}

		return "";
	}

	public static long showHBD(Connection conn,javax.servlet.jsp.JspWriter out,long startID,long endID) throws Exception {

		int columns = 4;
		String[] cols = new String[columns];
		StringBuffer buffer = new StringBuffer();
		StringBuffer output = new StringBuffer();

		int i = 0;
		int j = 0;
		long id = 0;
		int linesPerColumn = 68;

		cols[0] = "";
		cols[1] = "";
		cols[2] = "";
		cols[3] = "";

		boolean run = true;
		boolean pending = true;

		String line = "";

		try{
			PreparedStatement ps;
			ResultSet rs;

			String sql = "select id,line "
				+ "from output "
				+ "where id>=? and id<=? "
				+ "order by id";
			ps = conn.prepareStatement(sql);
			ps.setLong(1,startID);
			ps.setLong(2,endID);
			rs = ps.executeQuery();
			while (rs.next() && run) {

				// get data
				id = rs.getLong("id");
				line = rs.getString("line").trim();

				// line reaches column max
				if (++i < linesPerColumn+1){
					buffer.append(line + "<br/>");
					pending = true;
				}
				else{
					cols[j++] = buffer.toString();
					buffer.setLength(0);

					// page filled
					if (j==columns)
						run = false;

					// capture line data at page max
					pending = false;
					i = 1;
					buffer.append(line + "<br/>");
				} // i
			}	// while
			rs.close();
			ps.close();

			// if the loop ended before reaching linesPerColumn, it's likely
			// that there are pending entries.
			if (pending)
				cols[j++] = buffer.toString();

			output.append("<p style=\"page-break-after: void;\">");
			output.append("<div id=\"container4\">");
			output.append("<div id=\"container3\">");
			output.append("<div id=\"container2\">");
			output.append("<div id=\"container1\">");
			output.append("<div id=\"col1\">" + cols[0] + "</div>");
			output.append("<div id=\"col2\">" + cols[1] + "</div>");
			output.append("<div id=\"col3\">" + cols[2] + "</div>");
			output.append("<div id=\"col4\">" + cols[3] + "</div>");
			output.append("</div>");
			output.append("</div>");
			output.append("</div>");
			output.append("</div>");
			output.append("</p>");

			out.println(output.toString());
		}
		catch(SQLException se){
			System.out.println(se.toString());
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return id;
	}

	public static String showHBDTable(Connection conn,javax.servlet.jsp.JspWriter out,long startID,long endID) throws Exception {

		int columns = 4;
		String[] cols = new String[columns];
		StringBuffer buffer = new StringBuffer();
		StringBuffer output = new StringBuffer();
		String id;

		int i = 0;
		int j = 0;
		long x = 0;
		int linesPerColumn = 70;
		int page = 0;
		int len = 0;

		cols[0] = "";
		cols[1] = "";
		cols[2] = "";
		cols[3] = "";

		boolean run = true;

		String line = "";
		String tableStart = "<table width=\"100%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
		String tableEnd = "</table>";

		try{
			PreparedStatement ps;
			ResultSet rs;

			String sql = "select line "
				+ "from output "
				+ "where id>=? and id<=? "
				+ "order by id";

			ps = conn.prepareStatement(sql);
			ps.setLong(1,startID);
			ps.setLong(2,endID);
			rs = ps.executeQuery();
			while (rs.next()) {

				// count line
				++i;
				++x;

				// get data
				line = rs.getString("line").trim();
				len = line.length();

				// line wrapped and takes up and extra print line
				//if (len>20)
				//	++i;

				// line reaches column max
				if (i < linesPerColumn+1){
					buffer.append(line + "<br/>");
					//buffer.append(page + " - " + x + "<br/>");
				}
				else{
					cols[j++] = buffer.toString();
					buffer.setLength(0);

					// page filled
					if (j==columns){
						j = 0;
						++page;

						output.append(
							"<p style=\"page-break-after: always;\">"
							+ tableStart
							+ "<tr>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"02%\">&nbsp;</td>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"23%\">" + cols[0] + "</td>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"25%\">" + cols[1] + "</td>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"25%\">" + cols[2] + "</td>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"23%\">" + cols[3] + "</td>"
							+ "<td class=\"hbdtext\" valign=\"top\" width=\"02%\">&nbsp;</td>"
							+ "</tr>"
							+ tableEnd
							+ "</p>"
							);

						cols[0] = "";
						cols[1] = "";
						cols[2] = "";
						cols[3] = "";
					}	// j

					// capture line data at page max
					i = 1;
					buffer.append(line + "<br/>");
					//buffer.append(page + " - " + x + "<br/>");

				} // i
			}	// while
			rs.close();
			ps.close();

			output.append(
				"<p style=\"page-break-after: always;\">"
				+ tableStart
				+ "<tr>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"02%\">&nbsp;</td>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"23%\">" + cols[0] + "</td>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"25%\">" + cols[1] + "</td>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"25%\">" + cols[2] + "</td>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"23%\">" + cols[3] + "</td>"
				+ "<td class=\"hbdtext\" valign=\"top\" width=\"02%\">&nbsp;</td>"
				+ "</tr>"
				+ tableEnd
				+ "</p>"
				);

			out.println(output.toString());

		}
		catch(SQLException se){
			System.out.println(se.toString());
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return "";
	}

	public static String getHBD2(Connection conn,
										javax.servlet.jsp.JspWriter out,
										int startPage,
										int endPage,
										String isle,
										String idx) throws Exception {

		String[] cols = new String[5];
		StringBuffer buffer = new StringBuffer();

		int i = 0;
		int j = 0;
		long x = 0;
		int linesPerColumn = 70;
		int page = 0;

		boolean run = true;

		String line = "";
		String tableStart = "<table width=\"100%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
		String tableEnd = "</table>";

		try{
			PreparedStatement ps;
			ResultSet rs;

			if ("0".equals(idx))
				idx = "0-9";
			else
				idx = idx + "%";

			String sql = "select line "
				+ "from output "
				+ "where island=? and alpha like '["+idx+"]' "
				+ "order by id";

			ps = conn.prepareStatement(sql);
			ps.setString(1,isle);
			rs = ps.executeQuery();
			while (rs.next()) {
				line = rs.getString("line").trim();
				out.println(line+"<br/>");

			}	// while
			rs.close();
			ps.close();

		}
		catch(SQLException se){
			out.println(se.toString());
		}
		catch(Exception e){
			out.println(e.toString());
		}

		return "";
	}


	public static String getHBD3(Connection conn,javax.servlet.jsp.JspWriter out,String island) throws Exception {

		Logger logger = Logger.getLogger("test");

		String firmname = "";
		String address = "";
		String city = "";
		String zip = "";
		String fone = "";
		String yearest = "";
		String employee = "";
		String bustype = "";
		String sicdesc = "";
		String homeofc = "";
		String title = "";
		String firstname = "";
		String lastname = "";
		String suffix = "";
		String fax = "";
		String state = "";
		String lineBreak = "<br/>";
		String comma = ",";
		String space = "&nbsp;";
		String spaces = "&nbsp;&nbsp;";
		String boldStart = "<b>";
		String boldEnd = "</b>";
		String temp = "";

		String sql = "SELECT firmname,address,city,zip,fone,yearest,employee,bustype,sicdesc,homeofc,"
			+ "title,firstname,lastname,suffix,fax,state "
			+ "FROM HBD "
			+ "WHERE Island=?";

		PreparedStatement ps;
		ResultSet rs;

		int i = 0;

		int lines = -1;				// line counter
		int linesPerPage = 480;
		String[] aLines = new String[linesPerPage*5];

		try{
			ps = conn.prepareStatement(sql);
			ps.setString(1,island);
			rs = ps.executeQuery();
			while (rs.next() && i < 300) {
				firmname = AseUtil.nullToBlank(rs.getString("Firmname")).trim();
				address = AseUtil.nullToBlank(rs.getString("address")).trim();
				city = AseUtil.nullToBlank(rs.getString("city")).trim();
				zip = AseUtil.nullToBlank(rs.getString("zip")).trim();
				fone = AseUtil.nullToBlank(rs.getString("fone")).trim();
				yearest = AseUtil.nullToBlank(rs.getString("yearest")).trim();
				employee = AseUtil.nullToBlank(rs.getString("employee")).trim();
				bustype = AseUtil.nullToBlank(rs.getString("bustype")).trim();
				sicdesc = AseUtil.nullToBlank(rs.getString("sicdesc")).trim();
				homeofc = AseUtil.nullToBlank(rs.getString("homeofc")).trim();
				title = AseUtil.nullToBlank(rs.getString("title")).trim();
				firstname = AseUtil.nullToBlank(rs.getString("firstname")).trim();
				lastname = AseUtil.nullToBlank(rs.getString("lastname")).trim();
				suffix = AseUtil.nullToBlank(rs.getString("suffix")).trim();
				fax = AseUtil.nullToBlank(rs.getString("fax")).trim();
				state = AseUtil.nullToBlank(rs.getString("state")).trim();

				//output.append(boldStart+firmname+boldEnd+lineBreak);
				aLines[++lines] = boldStart+firmname+boldEnd+lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				//output.append(address+lineBreak);
				aLines[++lines] = address+lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				//output.append(city+comma+spaces+state+spaces+zip.replace(".0","")+lineBreak);
				aLines[++lines] = city+comma+spaces+state+spaces+zip.replace(".0","")+lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				//output.append("Phone"+space+fone+lineBreak);
				aLines[++lines] = "Phone"+space+fone+lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				//output.append(sicdesc+lineBreak);
				aLines[++lines] = sicdesc+lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				if (!"".equals(yearest)){
					temp = title+firstname+lastname+suffix;

					if (!"".equals(temp)){
						//output.append(title+space+firstname+spaces+lastname+space+suffix+lineBreak); ++lines;
						aLines[++lines] = title+space+firstname+spaces+lastname+space+suffix+lineBreak;
						if (lines==linesPerPage){
							printOutput(aLines,out);
							lines = -1;
						}
					}

					if (!"".equals(fax)){
						//output.append("Fax:"+space+fax+lineBreak); ++lines;
						aLines[++lines] = "Fax:"+space+fax+lineBreak;
						if (lines==linesPerPage){
							printOutput(aLines,out);
							lines = -1;
						}
					}

					//output.append(boldStart+"Y:"+space+yearest.replace(".0","")+spaces); ++lines;
					temp = boldStart+"Y:"+space+yearest.replace(".0","")+spaces;

					if (!"".equals(employee)){
						//output.append("E:"+spaces+employee.replace(".0","")+spaces); ++lines;
						temp += "E:"+spaces+employee.replace(".0","")+spaces;
					}

					if (!"".equals(bustype)){
						//output.append(bustype+spaces); ++lines;
						temp += bustype+spaces;
					}

					//output.append(spaces+boldEnd+lineBreak); ++lines;
					aLines[++lines] = temp+spaces+boldEnd+lineBreak;
					if (lines==linesPerPage){
						printOutput(aLines,out);
						lines = -1;
					}
				}

				aLines[++lines] = lineBreak;
				if (lines==linesPerPage){
					printOutput(aLines,out);
					lines = -1;
				}

				++i;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			System.out.println("ApproverDB: getApprovers\n" + e.toString());
		}

		return "";
	}

	public static String printOutput(String[] aLines,javax.servlet.jsp.JspWriter out) throws Exception {

		int lines = -1;
		StringBuffer output = new StringBuffer();
		output.append("<table border=1 cellspace=0 cellpadding=0 width=\"100%\">");
		for (int i=0;i<96;i++){
			output.append("<tr>");
			output.append("<td width=\"20%\" class=\"hbd\">"+aLines[++lines]+"</td>");
			output.append("<td width=\"20%\" class=\"hbd\">"+aLines[lines+95]+"</td>");
			output.append("<td width=\"20%\" class=\"hbd\">"+aLines[lines+190]+"</td>");
			output.append("<td width=\"20%\" class=\"hbd\">"+aLines[lines+286]+"</td>");
			output.append("<td width=\"20%\" class=\"hbd\">"+aLines[lines+381]+"</td>");
			output.append("</tr>");
		}
		output.append("</table>");
		out.println(output.toString());

		return "";
	}

%>
</body>
</html>

