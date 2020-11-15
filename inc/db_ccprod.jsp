<%@ page import="java.sql.*"%>
<%@ page import="com.ase.aseutil.*"%>

<%
AsePool asePool = AsePool.getInstance(Constant.DATABASE_DRIVER_SQL,"curriculumcs-pr",request);
Connection conn = asePool.getConnection();
%>
