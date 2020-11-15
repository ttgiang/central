/*
 * DemoParserUploadServlet.java
 *
 * Example servlet to handle file uploads using MultipartParser for
 * decoding the incoming multipart/form-data stream
 */

package com.ase.aseutil.uploads;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

import com.oreilly.servlet.multipart.*;

public class DemoParserUploadServlet extends HttpServlet {

	private File dir;

	public void init(ServletConfig config) throws ServletException {

		super.init(config);

		// Read the uploadDir from the servlet parameters
		String dirName = config.getInitParameter("uploadDir");
		if (dirName == null) {
			throw new ServletException("Please supply uploadDir parameter");
		}

		dir = new File(dirName);
		if (! dir.isDirectory()) {
			throw new ServletException("Supplied uploadDir " + dirName + " is invalid");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		response.setContentType("text/plain");

		out.println("Demo Upload Servlet using MultipartParser");
		out.println();

		try {

			MultipartParser mp = new MultipartParser(request, 10*1024*1024); // 10MB

			Part part;

			while ((part = mp.readNextPart()) != null) {

				String name = part.getName();
				if (part.isParam()) {
					// it's a parameter part
					ParamPart paramPart = (ParamPart) part;
					String value = paramPart.getStringValue();
					out.println("param: name=" + name + "; value=" + value);
				}
				else if (part.isFile()) {
					// it's a file part
					FilePart filePart = (FilePart) part;
					String fileName = filePart.getFileName();

					if (fileName != null) {
						// the part actually contained a file
						long size = filePart.writeTo(dir);
						out.println("file: name=" + name + "; fileName=" + fileName +
						", filePath=" + filePart.getFilePath() +
						", contentType=" + filePart.getContentType() +
						", size=" + size);
					}
					else {
						// the field did not contain a file
						out.println("file: name=" + name + "; EMPTY");
					}

					out.flush();
				}
			}
		}
		catch (IOException lEx) {
			this.getServletContext().log(lEx, "error reading or saving file");
		}
	}
}
