<%@ page language="java" import="java.io.*, java.sql.*, java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%

	byte[] cr = {13};
	byte[] lf = {10};

	String CR = new String(cr);
	String LF = new String(lf);
	String CRLF = CR + LF;

	out.println("Before a LF=chr(10)" + LF
					+ "Before a CR=chr(13)" + CR
					+ "Before a CRLF" + CRLF);

	//can be overriden by the posturl parameter: if error=true is passed as a parameter on the url
	boolean generateError = false;

	response.setContentType("text/plain");

	try{
		out.println("[parseRequest.jsp]  ------------------------------ ");

		// Directory to store all the uploaded files
		String ourTempDirectory = "/temp/";
		int ourMaxMemorySize  = 10000000;
		int ourMaxRequestSize = 2000000000;

		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Set factory constraints
		factory.setSizeThreshold(ourMaxMemorySize);
		factory.setRepository(new File(ourTempDirectory));

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);

		// Set overall request size constraint
		upload.setSizeMax(ourMaxRequestSize);

		// Parse the request
		if (! request.getContentType().startsWith("multipart/form-data")) {
			out.println("[parseRequest.jsp] No parsing of uploaded file: content type is " + request.getContentType());
		}
		else {
			List items = upload.parseRequest(request);
			Iterator iter = items.iterator();
			FileItem fileItem;
			File fout;
			out.println("[parseRequest.jsp]  Let's read input files ...");
			while (iter.hasNext()) {
				 fileItem = (FileItem) iter.next();

				 if (fileItem.isFormField()) {
					out.println("[parseRequest.jsp] (form field) " + fileItem.getFieldName() + " = " + fileItem.getString());
				 }
				 else {
					out.println("[parseRequest.jsp] FieldName: " + fileItem.getFieldName());
					out.println("[parseRequest.jsp] File Name: " + fileItem.getName());
					out.println("[parseRequest.jsp] ContentType: " + fileItem.getContentType());
					out.println("[parseRequest.jsp] Size (Bytes): " + fileItem.getSize());
					String uploadedFilename = fileItem.getName();
					fout = new File(ourTempDirectory + (new File(uploadedFilename)).getName());
					out.println("[parseRequest.jsp] File Out: " + fout.toString());
					out.println("[parseRequest.jsp] ");

					fileItem.write(fout);
					fileItem.delete();
				 }	// if file item
			}//while
		}	// if multiform

		out.println("[parseRequest.jsp] " + "Let's write a status, to finish the server response :");

		//Let's wait a little, to simulate the server time to manage the file.
		Thread.sleep(500);

		//Do you want to test a successful upload, or the way the applet reacts to an error ?
		if (generateError) {
			out.println("ERROR: this is a test error (forced in /wwwroot/pages/parseRequest.jsp).\\nHere is a second line!");
		}
		else {
			out.println("SUCCESS");
		}

		out.println("[parseRequest.jsp] " + "End of server treatment ");

  }catch(Exception e){
    out.println("");
    out.println("ERROR: Exception e = " + e.toString());
    out.println("");
  }

%>