<%@ page import="java.sql.*"%>
<%@ page import="com.ase.aseutil.*"%>

<%
AsePool asePool = AsePool.getInstance(Constant.DATABASE_DRIVER_SQL,"thanh",request);
Connection conn = asePool.getConnection();
%>
