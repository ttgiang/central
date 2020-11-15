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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAU";
	String alpha = "ITE";
	String num = "390E";
	String type = "ARC";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "a33k22j12188";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{

			out.println(notifiedDuringApproval(conn,campus,user,kix));

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	/*
	 * send email notification during approval
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 *	@param	kix		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean notifiedDuringApproval(Connection conn,String campus,String user,String kix) throws SQLException {

Logger logger = Logger.getLogger("test");

		//
		// notifiedDuringApproval allows system to determine whether messages are sent out during approval.
		// when value2 = 0, send notification at every sequence of approval
		// when value2 = a sequence number, only send at that point
		// value3 contains CSV of names to send
		//

		boolean send = false;
		boolean debug = true;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			if(debug){
				System.out.println("kix: " + kix);
				System.out.println("alpha: " + alpha);
				System.out.println("num: " + num);
				System.out.println("route: " + route);
			}

			if(route > 0){

				String notifiedDuringApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","NotifiedDuringApproval");

				if(debug) System.out.println("notifiedDuringApproval: " + notifiedDuringApproval);

				if(notifiedDuringApproval.equals(Constant.ON)){

					String seq = IniDB.getItem(conn,campus,"NotifiedDuringApproval","kval2");

					if(debug) System.out.println("seq: " + seq);

					if(seq != null && !seq.equals("")){

						int iSeq = NumericUtil.getInt(seq,0);

						String userlist = IniDB.getItem(conn,campus,"NotifiedDuringApproval","kval3");

						if(debug) System.out.println("userlist: " + userlist);

						if(userlist != null){

							int currentSeq = ApproverDB.getApproverSequence(conn,user,route);

							if(debug) System.out.println("currentSeq: " + currentSeq);

							if(iSeq == 0){
								send = true;
							}
							else if (iSeq == currentSeq){
								send = true;
							}

							if (send){
								MailerDB mailerDB = new MailerDB(conn,user,userlist,"","",alpha,num,campus,"notifiedDuringApproval",kix,user);
								if(debug) System.out.println("sent: " + send);
							}
						}
						else{
							logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid user list in value3 - " + userlist);
						}  // got a valid user list

					}
					else{
						logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid sequence in value2 - " + seq);
					}
					// got a valid sequence

				} // notify is on

			}
			else{
				logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid route - " + route);
			} // got a valid route

		} catch (Exception e) {
			logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + "\n" + e.toString());
		}

		return send;
	}


%>

</form>
		</td>
	</tr>
</table>

</body>
</html

<%@ include file="_fnd.jsp" %>
