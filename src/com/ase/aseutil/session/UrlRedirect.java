package com.ase.aseutil.session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UrlRedirect extends HttpServlet {

 public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {

       //redirect the user depending on the value of the 'go' param
        String destination = request.getParameter("go");
        String contextPath = request.getContextPath();

         if(destination == null || destination.equals(""))
            throw new ServletException(
             "Missing or invalid 'go' parameter in " +
               getClass().getName());

        if(destination.equals("weather"))
        //ensure URL rewriting
            response.sendRedirect(
              response.encodeRedirectURL(
                contextPath + "/weather") );

         if(destination.equals("maps"))
        //ensure URL rewriting
            response.sendRedirect(
              response.encodeRedirectURL(
                contextPath + "/maps") );
    }
}
