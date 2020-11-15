<%@ page import="com.ase.aseutil.*" %>

<%@ include file="ase.jsp" %>

<%

try
{
	CreateObject co = new CreateObject();
	out.println( co.printObject(conn,"tblCourseContent","1","contentID") );
}
catch (Exception e){
	out.println( e.toString() );
};


%>