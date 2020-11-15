package com.ase.aseutil;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ValidationServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	private ServletContext context;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		this.context = config.getServletContext();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse  response)

		throws IOException, ServletException {

		String message = "false";
		String temp = "";

		//request.setCharacterEncoding("UTF-8");

		//javax.servlet.http.HttpUtils.setCharacterEncoding("UTF-8");

		String targetId = request.getParameter("id");

		try{
			if ((targetId != null) && !UserDB.isMatch(targetId,Constant.CAMPUS_LEE))
				message = "true";
		}
		catch(SQLException se){
			message = "false";
		}

		//response.setContentType("text/xml");
		//response.setHeader("Cache-Control", "no-cache");
		//response.getWriter().write("<valid>" + message + "</valid>");
		response.getWriter().write(message);
	}

	public  void doPost(HttpServletRequest request, HttpServletResponse  response)
		throws IOException, ServletException {

		String targetId = request.getParameter("id");

		try{
			if ((targetId != null) && !UserDB.isMatch(targetId,Constant.CAMPUS_LEE))
				context.getRequestDispatcher("/core/success.jsp").forward(request, response);
			else
				context.getRequestDispatcher("/core/error.jsp").forward(request, response);
		}
		catch(SQLException se){}
	}
}


