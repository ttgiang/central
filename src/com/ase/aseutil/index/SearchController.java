/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// SearchController.java
//

package com.ase.aseutil.index;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.Generic;
import com.ase.aseutil.WebSite;

/**
 * This servlet is used to deal with the search request
 * and return the search results to the client
 */
public class SearchController extends HttpServlet{

	static Logger logger = Logger.getLogger(SearchController.class.getName());

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{

		List<Generic> genericData = null;

		WebSite website = new WebSite();

		String srchWrd = website.getRequestParameter(request,"srchWrd","");

		if(!srchWrd.equals("")){
			try{
				SearchEngine searchEngine = new SearchEngine();
				genericData = searchEngine.searchIndex(srchWrd);
			}
			catch(Exception e){
				logger.fatal("SearchController: doPost - " + e.toString());
			}
		} // got srchWrd

    	RequestDispatcher dispatcher = request.getRequestDispatcher("idx.jsp");

    	request.setAttribute("searchResult",genericData);

    	dispatcher.forward(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
                     throws IOException, ServletException{
        doPost(request, response);
    }
}
