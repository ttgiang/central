<%@ page import="com.ase.aseutil.*" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String campus = website.getRequestParameter(request,"campus");
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String compid = website.getRequestParameter(request,"compid");
	String auditby = session.getAttribute("aseUserName").toString();

	int numberOfIDs = website.getRequestParameter(request,"numberOfIDs",0);
	String[] hiddenAssessID = new String[numberOfIDs];
	hiddenAssessID = website.getRequestParameter(request,"assessID").split(",");

	String selectedIDs = "";
	String temp = "";

	// get rid of existing before updating
	PreparedStatement preparedStatement = conn.prepareStatement("DELETE FROM tblCourseCompAss WHERE compid=?");
	preparedStatement.setString(1,compid);
	preparedStatement.executeUpdate();

	// for all fields, check to see if it was checked. if yes, set to 1, else 0;
	// the final result is CSV of 0's and 1's of items that can be edited.
	preparedStatement = conn.prepareStatement("INSERT INTO tblCourseCompAss(compid,assessmentid,auditby,auditdate) VALUES(?,?,?,?)");
	for ( int i = 0; i < numberOfIDs ; i++ ){
		temp = website.getRequestParameter(request,"assess_" + hiddenAssessID[i]);
		if ( temp != null && !"".equals(temp) ){
			out.println( compid + "-" + temp + "-" + auditby + "-" + AseUtil.getCurrentDateString() + "<br>" );
			preparedStatement.setInt(1,Integer.parseInt(compid));
			preparedStatement.setInt(2,Integer.parseInt(temp));
			preparedStatement.setString(3,auditby);
			preparedStatement.setString(4,AseUtil.getCurrentDateString());
			preparedStatement.executeUpdate();
		}
	}
	preparedStatement.close();
}
catch (Exception e){
	out.println( e.toString() );
};


%>