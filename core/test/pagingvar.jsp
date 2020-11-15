<%
	/**
		* these are values used for paging. they are pulled in and remembered
		* from page to page.
	*/

	int asePage = 1;
	int aseRecordsPerPage = 10;

	// get the name of the page that we are on. this is used
	// to wipe out the default sort id field when going from
	// one page to another page (different name)
	String uri =  request.getRequestURI();
	if ( uri != null && uri.length() > 0 ){
		// extract only the page name
		uri = uri.substring( uri.lastIndexOf("/") + 1 );
		if ( session.getAttribute("aseURI") != null && !((String)session.getAttribute("aseURI")).equals(uri) ){
			session.setAttribute("aseCol", "");
			session.setAttribute("aseSrt", "");
			out.print( (String)session.getAttribute("aseURI") );
		}
		session.setAttribute("aseURI", uri);
	}
	else{
		session.setAttribute("aseURI", "");
	}

	// what column to do sorting by
	String aseCol = request.getParameter("col");
	if (aseCol != null && aseCol.length() > 0) {
		if (session.getAttribute("aseCol") != null && ((String) session.getAttribute("aseCol")).equals(aseCol)) {
			if (((String) session.getAttribute("aseSrt")).equals("ASC")) {
				session.setAttribute("aseSrt", "DESC");
			}else{
				session.setAttribute("aseSrt", "ASC");
			}
		}else{
			session.setAttribute("aseSrt", "ASC");
		}
		session.setAttribute("aseCol", aseCol);
	}else{
		aseCol = (String) session.getAttribute("aseCol");
		if (aseCol == null || aseCol.length() == 0) {
			aseCol = "";
			session.setAttribute("aseCol", aseCol);
			session.setAttribute("aseSrt", "");
		}
	}

	String aseSrt = (String) session.getAttribute("aseSrt");

	// the page we are going to display
	if ( request.getParameter("page") != null && Integer.parseInt(request.getParameter("page")) > 0 )
		asePage = Integer.parseInt(request.getParameter("page"));

	// how many records to show per page
	if ( request.getParameter("rpp") != null && Integer.parseInt(request.getParameter("rpp")) > 0)
		aseRecordsPerPage = Integer.parseInt(request.getParameter("rpp"));
	else{
		if ( session.getAttribute("aseRecordsPerPage") != null ){
			aseRecordsPerPage = ((Integer)session.getAttribute("aseRecordsPerPage")).intValue();
		}
	}

	// save the records per page for next arrival
	session.setAttribute("aseRecordsPerPage",  new Integer(aseRecordsPerPage));
%>
