<html>
<head>
    <link rel="stylesheet" href="../inc/style.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String _sql = "";
	String _where = "";
	String _order = "";
	String order = "id";
	String where = "x = 1";
	int iOrder = -1;
	int iWhere = -1;

	_sql = "SELECT id, InfoTitle, DatePosted, Author FROM tblInfo WHERE campus like '%" + _sql + "%' ORDER BY dateposted desc";

	// is ORDER involved? If so, where is it located.
	if ( _sql.indexOf("ORDER") > 0 ){
		iOrder = _sql.indexOf("ORDER");
		_order = _sql.substring( iOrder );

		// shorten sql string and remove order by
		_sql = _sql.substring( 0, iOrder );
	}

	// append any other user provided order by columns
	if ( order != null && order.length() > 0 ){
		if ( _order.length() > 0 )
			_order = _order + ", " + order;
		else
			_order = "ORDER BY " + order;
	}

	// is WHERE involved? Find it and separate it from
	// ORDER clause if necessary
	if ( _sql.indexOf("WHERE") > 0 ){
		iWhere = _sql.indexOf("WHERE");
		if ( iOrder > -1 )
			_where = _sql.substring(iWhere, iWhere + (iOrder - iWhere) );
		else
			_where = _sql.substring(iWhere);

		// shorten sql string and remove where
		_sql = _sql.substring( 0, iWhere );
	}

	// is user sending in additional WHERE? if so,
	// append to end of where using AND condition
	if ( where != null && where.length() > 0 ){
		if ( _where.length() > 0 )
			_where = _where + " AND (" + where + ")";
		else
			_where = "WHERE (" + where + ")";
	}

	out.print( "sql: " + _sql + "<br>" );
	out.print( "where: " + _where + "<br>" );
	out.print( "order: " + _order + "<br>" );
	out.print( "space: " + (iOrder - iWhere )+ "<br>" );

	// reassemble back
	out.print( "sql: " + _sql + " " + _where + " " + _order + "<br>" );

%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>