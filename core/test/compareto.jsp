<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="com.ase.aseutil.*"%>

<%

Object o1 = SystemAccess.CMPADM;
Object o2 = SystemAccess.SYSADM;

out.println( o1.toString() );
out.println( o2.toString() );
out.println( o2.toString().compareTo(o1.toString()) );

%>
