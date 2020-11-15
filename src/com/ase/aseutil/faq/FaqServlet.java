package com.ase.aseutil.faq;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class FaqServlet extends HttpServlet {

	private String jspdir = "/central/core/faq/";
	private String error = "error.jsp";

	public void service(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {

		String next;
		Command cmd;

		try {
			next = req.getParameter("page");

			if (next == null)
				throw new CommandException("Page not specified");

			if (req.getParameter("id") != null)
				cmd = new GetCommand(next);
			else
				cmd = new GetAllCommand(next);

			cmd.execute(req);
		}
		catch (CommandException e) {
			req.setAttribute("javax.servlet.jsp.jspException", e);
			next = error;
		}

		RequestDispatcher rd;

		rd = getServletContext().getRequestDispatcher(jspdir + next);

		rd.forward(req, res);
	}
}

