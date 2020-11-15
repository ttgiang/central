<%@ page import="java.sql.*"%>
<%@ page import="com.ase.aseutil.*"%>

<%
//AsePool asePool = AsePool.getInstance(Constant.DATABASE_DRIVER_SQL,"curriculumcs",request);
AsePool asePool = AsePool.getInstance(Constant.DATABASE_DRIVER_SQL,"CCENTRAL-TEST",request);
Connection conn = asePool.getConnection();
%>
