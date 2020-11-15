<%@ page import="sun.net.smtp.SmtpClient, java.io.*, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
   <title>404: Page Not Found</title>
   <meta http-equiv="Content-type" content="text/html; charset=ISO-8859-1" />
</head>
<body>
<h1>404: Page Not Found</h1>
<%
   String from="web_server@myhost.com";
   String to="my_address@myhost.com";
   String server="127.0.0.1";
   try{
      SimpleDateFormat simpleDate = new SimpleDateFormat("EE MMM dd yyyy hh:mm:ss aa zzz");
      SmtpClient client = new SmtpClient(server);
      client.from(from);
      client.to(to);
      PrintStream message = client.startMessage();
      message.println("To: " + to);
      message.println("Subject: 404 Error");
      message.println("" + simpleDate.format(new Date()));
      message.println();
      message.println("" + request.getRemoteAddr() + " tried to load http://" + request.getServerName() + request.getRequestURI());
      message.println();
      message.println("User Agent = " + request.getHeader("User-Agent"));
      message.println();
      message.println("" + request.getHeader("Referer"));
      message.println();
      client.closeServer();
   }
   catch (IOException e){
      System.out.println("Error Sending Email: " + e);
   }
%>
</body>
</html>