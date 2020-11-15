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

/////
		String sAction = "";

		int i = 0;
		int j = 0;
		int ix = 0;
		int iAction = 0;
		int rowsAffected = 0;

		String campus = "";
		String user = "";

		String caller = "";
		String sql = "";

		String src = "";
		String temp = "";
		String kix = "";
		String field = "";
		String message = "";

		int id = 0;

//		Msg msg = new Msg();

//Connection conn = connectionPool.getConnection();
		PreparedStatement ps = null;
//WebSite website = new WebSite();

		try {
			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			caller = website.getRequestParameter(request,"caller","");
			id = website.getRequestParameter(request,"id",0);
			kix = website.getRequestParameter(request,"kix","");
			src = website.getRequestParameter(request,"src","");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int submitAction = 2;

			if (sAction.equalsIgnoreCase("Cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("Submit")) { iAction = submitAction; }

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled.<br/>";
					break;
				case submitAction:

					String junkX = website.getRequestParameter(request,"xiAxis", "");
					String junkY = website.getRequestParameter(request,"yiAxis", "");

					if (junkX!=null && junkY != null && id > 0){

						String[] xiAxis = junkX.split(",");
						String[] yiAxis = junkY.split(",");

						if (xiAxis!=null && yiAxis != null){

							//
							// with valid data, we start by deleting old selections
							//
							sql = "DELETE FROM tblfndlinked WHERE campus=? AND id=? AND historyid=?";
							ps = conn.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setInt(2,id);
							ps.setString(3,kix);
							rowsAffected = ps.executeUpdate();
							ps.close();

							for(i=0;i<yiAxis.length;i++){

								for(j=0;j<xiAxis.length;j++){

									field = ""+yiAxis[i]+"_"+xiAxis[j];
									temp = website.getRequestParameter(request,field, "");

									if(temp.equals(Constant.ON)){
										sql = "INSERT INTO tblfndlinked (campus,id,historyid,src,srcid,fndid,auditby,auditdate) VALUES(?,?,?,?,?,?,?,?)";
										ps = conn.prepareStatement(sql);
										ps.setString(1,campus);
										ps.setInt(2,id);
										ps.setString(3,kix);
										ps.setString(4,src);
										ps.setInt(5,NumericUtil.getInt(yiAxis[i],0));
										ps.setInt(6,NumericUtil.getInt(xiAxis[j],0));
										ps.setString(7,user);
										ps.setString(8,AseUtil.getCurrentDateTimeString());
										rowsAffected = ps.executeUpdate();
										ps.close();
									}

								} // for xiAxis

							} // for yiAxis

						} // valid axis data

						message = "Selection(s) saved successfully.";

					} // valid website data

					break;
			}

			msg.setMsg(message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			msg.setMsg("Exception");
			//logger.fatal("LinkerServlet - processFoundations - " + e.toString());
			throw new ServletException(e);
		} finally {
			try{
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				throw new ServletException(ex);
			}

//connectionPool.freeConnection(conn);
		}

/////

	asePool.freeConnection(conn," ","");
%>

</form>
		</td>
	</tr>
</table>

</body>
</html
