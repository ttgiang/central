<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE	OBSOLETE
	*	help.jsp
	*	2007.09.01	help file
	*	TODO 	not sure if this is doing anything
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "70%";
	String pageTitle = "Outline Item Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>

<%

String id = "11";
String message = "";

Help help = new Help
(
	id,
	"category",
	"title",
	"subtitle",
	"content",
	"THANHG",
	aseUtil.getCurrentDateTimeString(),
	Constant.CAMPUS_LEE
);

int rowsAffected = 0;

String insertSQL;
String insertSQLContent;

insertSQL = "INSERT INTO tblHelpIdx (category,title,subtitle,auditby) VALUES (?,?,?,?)";
insertSQLContent = "INSERT INTO tblHelp (id, content) VALUES (?,?)";

try
{
	PreparedStatement preparedStatement = conn.prepareStatement(insertSQL);
	preparedStatement.setString (1, help.getCategory());
	preparedStatement.setString (2, help.getTitle());
	preparedStatement.setString (3, help.getSubTitle());
	preparedStatement.setString (4, help.getAuditBy());
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();

	if ( rowsAffected == 1 ){
		int maxId = aseUtil.dbMaxValue(conn,"tblHelpidx","id" );
		PreparedStatement preparedStatementX = conn.prepareStatement(insertSQLContent);
		preparedStatementX.setInt (1, maxId);
		preparedStatementX.setString (2, help.getContent());
		rowsAffected = preparedStatementX.executeUpdate();
		preparedStatementX.close ();
	}
	out.println( String.valueOf(rowsAffected) );

}
catch (Exception e)
{
	out.println( e.toString() );
}

asePool.freeConnection(conn);

%>
