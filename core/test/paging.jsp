<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="errorpge.jsp" %>
<%
response.setDateHeader("Expires", 0); // date in the past
response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.addHeader("Pragma", "no-cache"); // HTTP/1.0
%>

<% Locale locale = Locale.getDefault();
response.setLocale(locale);%>
<% session.setMaxInactiveInterval(30*60); %>
<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>

<html>
<head>
    <title>Test</title>
    <link rel="stylesheet" href="../inc/style.css">
	<STYLE>
		A.TopMenuLink:link {
			FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #ffffff; TEXT-DECORATION: none
		}
		A.TopMenuLink:visited {
			FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #ffffff; TEXT-DECORATION: none
		}
		A.TopMenuLink:hover {
			FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #ffffff; TEXT-DECORATION: underline
		}
		A.TopMenuLink:active {
			FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #ffffff; TEXT-DECORATION: underline
		}
		TD.HeaderRow {
			FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #ffffff; BACKGROUND-COLOR: #3d84cc; TEXT-DECORATION: none
		}
	</STYLE>
</head>

<%
		//<jsp:useBean id="paging" scope="session" class="ase.paging.Paging"/>

		//paging.setDetail("index.asp?report=2&search=");
		//paging.setNumberOfColumns(3);
		//paging.setSortColumns("user_id,name,email");
		//paging.setFormatColumns("user_id,name,email");
		//paging.setSumColumns("user_id,name,email");
		//paging.setTemplateHeader(strHeader);
		//paging.setTemplate(strTemplate);
		//paging.setTemplateFooter(strFooter);
		//paging.setTemplateNavigation(strNavigation);
		//paging.setScriptName("paging.jsp");
		//paging.setRecordsPerPage(recordsPerPage);
		//paging.setDetail("");
		//paging.setTableBorder(true);
		//paging.SetAllignTableCell(true);
		//paging.setTableWidth("660");
		//paging.setSortOrder(aseSrt);
		//paging.setOrderBy(aseCol);
		//paging.setDebug(true);
		//paging.setTableRowBackgroundColor("#dfdfdf");
		//paging.setRecordsPerPage(aseRecordsPerPage);

		ase.paging.Paging paging = new ase.paging.Paging();
		paging.setSQL("SELECT id, userid, access, lastname, firstname, position from tblInstructors  ");
		paging.setDebug(true);
		//paging.setSearch(true);
		paging.setTableRowBackgroundColor("#596e7f");
		paging.setEvenRowColor("#596e7f");
		paging.setTheme(0);
		paging.setDetail("paging.jsp");
		out.print( paging.showRecords( conn, request, response ) );
		paging = null;

		conn.close();
		conn = null;
%>

</body>
</html>
