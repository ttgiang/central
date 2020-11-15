<%@ page import="java.io.*"%>
<%@ page import="com.ase.aseutil.uploads.AseUploadProcessing"%>
<%@ page import="com.ase.aseutil.uploads.DefaultFileTypePolicy"%>
<%@ page import="com.ase.aseutil.util.HashUtil"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ include file="ase.jsp" %>

<%
	String error = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = website.getRequestParameter(request,"a","");
	String num = website.getRequestParameter(request,"n","");
	int id = website.getRequestParameter(request,"id",0);
	int en = website.getRequestParameter(request,"en",0);
	int sq = website.getRequestParameter(request,"sq",0);
	int qn = website.getRequestParameter(request,"qn",0);

	String aseFileUploadPrefix = website.getRequestParameter(request,"aseFileUploadPrefix","",true);

	String folder = "fnd/" + campus;
	String fileName = "";
	String originalFileName = "";
	String prependedFileName = "";

	String dirName = AseUtil.getCurrentDrive()
						+ ":"
						+ com.ase.aseutil.SysDB.getSys(conn,"documents") + folder;

	String linkedName = com.ase.aseutil.SysDB.getSys(conn,"documents") + folder + "/";

	//
	// replacing starts with \\ coming from database
	//
	linkedName = linkedName.replace("\\\\","/").replace("\\","/").replace("/tomcat/webapps","");

	int fileID = 0;

	try {
		MultipartRequest multi = new MultipartRequest(request,
																	dirName,
																	10*1024*1024,
																	"ISO-8859-1",
																	new DefaultFileRenamePolicy(),
																	new DefaultFileTypePolicy(),
																	aseFileUploadPrefix);

		//
		// show result of file upload (parameters included)
		//
		if (multi.getParameterNameCount() > 0 || multi.getFileNameCount() > 0){
			fileName = multi.getFileName("fileName");
			originalFileName = multi.getOriginalFileName("fileName");
			prependedFileName = multi.getPrependedFileName("fileName");

			fileID = com.ase.aseutil.fnd.FndDB.addFile(conn,campus,user,id,prependedFileName,originalFileName,en,sq,qn);
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

	//
	// returning jason data structure to calling routing (jqupload)
	//
	out.println("{");
	out.println("error: '" + error + "',\n");
	out.println("file: '" + fileName + "',\n");
	out.println("fileID: '" + fileID + "',\n");
	out.println("originalFileName: '" + originalFileName + "',\n");
	out.println("prependedFileName: '" + prependedFileName + "',\n");
	out.println("linkedName: '" + linkedName + "'\n");
	out.println("}");
%>

