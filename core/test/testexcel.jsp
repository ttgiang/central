<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,com.Ostermiller.util.*"%>

<%

ExcelCSVPrinter ecsvp = new ExcelCSVPrinter(out);
ecsvp.writeln(new String[]{"hello","world"});

%>
