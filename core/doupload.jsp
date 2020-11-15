<%@ page import="java.io.*"%>
<%@ page import="com.ase.aseutil.uploads.AseUploadProcessing"%>
<%@ page import="com.ase.aseutil.uploads.DefaultFileTypePolicy"%>
<%@ page import="com.ase.aseutil.util.HashUtil"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ include file="ase.jsp" %>

<%
	String error = "";

	String fileName = "";
	String originalFileName = "";

	String dirName = AseUtil.getCurrentDrive()
						+ ":"
						+ com.ase.aseutil.SysDB.getSys(conn,"documents") + "profiles";

	String linkedName = com.ase.aseutil.SysDB.getSys(conn,"documents") + "profiles/";

	// replacing starts with \\ coming from database
	linkedName = linkedName.replace("\\\\","/").replace("\\","/").replace("/tomcat/webapps","");

	try {
		MultipartRequest multi = new MultipartRequest(request,
																	dirName,
																	10*1024*1024,
																	"ISO-8859-1",
																	new DefaultFileRenamePolicy(),
																	new DefaultFileTypePolicy());

		// show result of file upload (parameters included)
		if (multi.getParameterNameCount() > 0 || multi.getFileNameCount() > 0){
			fileName = multi.getFileName("fileName");
			originalFileName = multi.getOriginalFileName("fileName");
		}
		else{
			error = "error";
		}

		multi = null;

	}
	catch (IOException e) {
		error = e.toString();
	}
	catch (Exception e) {
		error = e.toString();
	}

	// returning jason data structure to calling routing (jqupload)
	out.println("{");
	out.println("error: '" + error + "',\n");
	out.println("file: '" + fileName + "',\n");
	out.println("originalFileName: '" + originalFileName + "',\n");
	out.println("linkedName: '" + linkedName + "'\n");
	out.println("}");

%>
