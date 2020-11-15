<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Task Listing";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String sql;
	String result;
	String left = "";
	String right = "";
	String alpha = "";
	String num = "";
	String link = "";
	String source = "";
	String type = "";
	String campus = "LEECC";
	int pos;

	paging = new com.ase.paging.Paging();
	sql = aseUtil.getPropertySQL( session, "tasks" );
	sql = sql.replace("_submittedfor_", (String)session.getAttribute("aseUserName"));
	paging.setSQL(sql);
	paging.setSorting(false);
	paging.setRecordsPerPage(99);
	result = paging.showRecords(conn,request,response);

	pos = result.indexOf("~ALPHA~");
	while (pos > 0){
		if (pos>0){
			pos = pos + 7;

			left = result.substring(0,pos);
			left = left.replace("~ALPHA~","");

			right = result.substring(pos);
			pos = right.indexOf("<");

			if (pos>0){
				alpha = right.substring(0,pos);
				right = right.substring(pos);
			}

			result = left+alpha+right;
		}

		pos = result.indexOf("~NUM~");
		if (pos>0){
			pos = pos + 5;

			left = result.substring(0,pos);
			left = left.replace("~NUM~","");

			right = result.substring(pos);
			pos = right.indexOf("<");

			if (pos>0){
				num = right.substring(0,pos);
				right = right.substring(pos);
			}

			result = left+num+right;
		}

		pos = result.indexOf("~HREF~");
		if (pos>0){
			pos = pos + 6;

			left = result.substring(0,pos);
			left = left.replace("~HREF~","");

			right = result.substring(pos);
			pos = right.indexOf("<");

			if (pos>0){
				link = right.substring(0,pos);

				if ("Modify Outline".equals(link)){
					source = "crsedt";
					type = "PRE";
				}
				else if ("Approve outline".equals(link)){
					source = "crsedt";
					type = "PRE";
				}

				right = right.substring(pos);
			}

			result = left+"<a class=\"linkcolumn\" href=\"" + source + ".jsp?alpha=" + alpha + "&num=" + num + "&campus=" + campus + "&view=PRE\">"+link+"</a>"+right;
		}

		pos = result.indexOf("~ALPHA~");
	}

	out.println(result);

	paging = null;
	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
