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
	*	testfix29.jsp - fill in #29 for KAP
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	String campus = "LEE";
	String user = "THANHG";
	int route = 708;

	out.println("Start<br/>");

	out.println("Administration - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Administration","Administration",route) + Html.BR());
	out.println("WEST - Arts and Humanities - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Arts and Humanities","Arts and Humanities",route) + Html.BR());
	out.println("SOTA - Business Technology - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Business Technology","Business Technology",route) + Html.BR());
	out.println("Information & Technology - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Information & Technology","Information & Technology",route) + Html.BR());
	out.println("KCALDWEL - Language Arts - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Language Arts","Language Arts",route) + Html.BR());
	out.println("JITO - Mathematics and Natural Sciences - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Mathematics and Natural Sciences","Mathematics and Natural Sciences",route) + Html.BR());
	out.println("UMEHIRA - Office of Continuing Education and Training - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Office of Continuing Education and Training","Office of Continuing Education and Training",route) + Html.BR());
	out.println("WTERAOKA - Social Sciences - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Social Sciences","Social Sciences",route) + Html.BR());
	out.println("Student Services - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Student Services","Student Services",route) + Html.BR());
	out.println("JDARAKJI - Vocational Technical Education - " + ApproverDB.copyApprovalRouting(conn,campus,user,"Vocational Technical Education","Vocational Technical Education",route) + Html.BR());

	//out.println(processItem(conn) + " <br/>");

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	processItem
	*/
	public static String processItem(Connection conn){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int dcCount = 6;

		String[] dc = new String[dcCount];
		dc[0] = "nbuchana";
		dc[1] = "jito";
		dc[2] = "kcaldwel";
		dc[3] = "jdarakji";
		dc[4] = "sota";
		dc[5] = "west";

		/*
			1734, Administration
			1735, Arts and Humanities
			1736, Business Technology
			1737, Language Arts
			1738, Mathematics and Natural Sciences
			1739, Office of Continuing Education and Training
			1740, Social Sciences
			1741, Vocational Technical Education
		*/

		int[] dcRoute = new int[dcCount];
		dcRoute[0] = 1735;
		dcRoute[1] = 1738;
		dcRoute[2] = 1737;
		dcRoute[3] = 1741;
		dcRoute[4] = 1736;
		dcRoute[5] = 1742;

		// nbuchana IS (with the exception of IS 221), SSCI
		// WEST Eng 250 - 257N

		String[] dcAlpha = new String[dcCount];
		dcAlpha[0] = "IS,SSCI";
		dcAlpha[1] = "ASTR,BIOC,BIOL,BOT,CE,CHEM,EE,FSHN,GG,HLTH,HORT,ICS,MATH,ME,MICR,OCN,PHRM,PHYS,SCI,ZOOL";
		dcAlpha[2] = "CHN,COM,ENG,ESL,ELI,HAW,JPNS,JOUR,KOR,LING,LSK,SP,SPA";
		dcAlpha[3] = "CULN,AMT,TVPR";
		dcAlpha[4] = "ACC,BLAW,BUS,BUSN,ECOM,FIN,HOST,MGT,MKT,TIM";
		dcAlpha[5] = "ART,ASAN,DNCE,DMED,DRAM,HUM,HWST,IS 250H,HIST,MUS,PHIL,REL";

		try{
			String sql = "UPDATE tblCourse SET route=? WHERE campus='LEE' AND route > 0 AND progress<>'APPROVED' AND coursealpha=?";

			logger.info("---------------------- START");
			for(int i=0; i<dcCount; i++){

				String[] temp = dcAlpha[i].split(",");
				if (temp != null){

					for(int j=0; j<temp.length; j++){
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setInt(1,dcRoute[i]);
						ps.setString(2,temp[j]);
						rowsAffected = ps.executeUpdate();
						ps.close();

						logger.info(dc[i] + " - updated " + rowsAffected + " rows for " + temp[j]);
					}

				}
			}

			logger.info("---------------------- END");
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return "done";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

