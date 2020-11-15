<%@ page import="jasp.buildin.*" %>
<%@ page import="jasp.util.*" %>
<%@ page import="jasp.vbs.*" %>
<%@ page import="jasp.adodb.*" %>
<%@ page extends="jasp.servlet.JspBase" %>
<%
 try {
    jspinit(request,response,application,out);
%>

<%
    Connection conn = null;
    Recordset rsNew = null;
    String SQL = "";
    variant BBHomepageName = new variant();
    variant BBHomepageURL = new variant();
    variant ImageURL = new variant();
    variant PostID = new variant();
    variant BBName = new variant();
    variant BBEmail = new variant();
    variant Subject = new variant();
    variant Message = new variant();
%>
<%
    conn = new Connection();
    conn.Open("BulletinBoard", "", "");
    rsNew = new Recordset();
    SQL = "SELECT * FROM BulletinBoard ";
    rsNew.Open(SQL, conn, 3, 3);
    rsNew.AddNew();
    rsNew.setItem("BBName", Request.Form("BBName").toString());
    rsNew.setItem("BBEmail", Request.Form("BBEmail").toString());
    rsNew.setItem("Subject", Request.Form("Subject").toString());
    rsNew.setItem("Message", Request.Form("Message").toString());
    rsNew.setItem("ResponseTo", Request.Form("ResponseTo").toString());
    rsNew.setItem("BBHomepageName", Request.Form("BBHomepageName").toString());
    if (BBHomepageName.equals(new variant("")) || vb.IsNull(BBHomepageName)) {
        BBHomepageName.set("0");
    }
    rsNew.setItem("BBHomepageURL", Request.Form("BBHomepageURL").toString());
    if (BBHomepageURL.equals(new variant("")) || vb.IsNull(BBHomepageURL)) {
        BBHomepageURL.set("0");
    }
    rsNew.setItem("ImageURL", Request.Form("ImageURL").toString());
    if (ImageURL.equals(new variant("")) || vb.IsNull(ImageURL)) {
        ImageURL.set("0");
    }
    rsNew.Update();
    rsNew.MoveLast();
    PostID.set(rsNew.getItem("PostID").getValue());
    BBName.set(rsNew.getItem("BBName").getValue());
    BBEmail.set(rsNew.getItem("BBEmail").getValue());
    Subject.set(rsNew.getItem("Subject").getValue());
    Message.set(rsNew.getItem("Message").getValue());
    BBHomepageName.set(rsNew.getItem("BBHomepageName").getValue());
    BBHomepageURL.set(rsNew.getItem("BBHomepageURL").getValue());
    ImageURL.set(rsNew.getItem("ImageURL").getValue());
%>

<html>

<head>
<title> Bulletin Board</title>
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<meta HTTP-EQUIV="expires" CONTENT="0">

</head>
<body style="font-family: VERDANA, HELVETICA, ARIAL, 'SANS SERIF'; font-size: 10pt">
<!--The code on these pages was designed by Zola-- visit www.zolaweb.com-->

<div align="left">

<div align="center">
  <center>

<table cellspacing="0" cellpadding="0" border="0" width="80%">
  <tr>
    <td valign="top" align="center" width="80%" colspan="2"><font size="5">Bulletin
      Board</font></td>
  </tr>
  <tr>
    <td valign="top" width="80%" colspan="2"><p align="center"><b><font size="4"><%= Subject %></font></b></p>
      <hr size=7 width=75% >

      <font size="2">

<%= vb.Replace(Message.toString(), vbconst.vbCrLf, "<BR>") %><br>
<%
    if (false) {
%><a href="<%= BBHomepageURL %>"><%
        if (false) {
%>
<%= BBHomepageName %>"></a><%
        }
    }
%><br>
<%
    if (false) {
%><img src="<%= ImageURL %>"><%
    }
%></font><p>


<tr>
    <td valign="top" width="40%" align="right"><form method="POST" action="EditPost.jsp">
<p><font size="2"><input type="submit" value="Edit Post" name="B1">&nbsp;&nbsp;&nbsp;&nbsp;</font></p>
<input type="hidden" name="PostID" value="<%= PostID %>">
</form>
    <td valign="top" width="40%" align="left"><form method="POST" action="BulletinBoard.jsp">
<p><font size="2">&nbsp;&nbsp; <input type="submit" value="Post Message" name="B1"></font></p>
</form>
  </tr>
  <tr>
    <td valign="top" width="80%" colspan="2">
      <p align="center"><font size="2">If you would like to change your message, use the &quot;Edit&quot; button
<br>
      </font>
<hr size=7 width=75% >

      <p align="center"><font size="2">Use of this bulletin board means you have read and agree to
      <a href="../faq.jsp">our rules</a>.<br>
      <br>
      <center><font size="2">[ <a href="#followups">Follow Ups</a> ] [ <a href="#Post">Post Follow Up</a> ] [
      <a href="BB.jsp"> Bulletin Board</a> ] [ <a href="../faq.jsp">FAQ</a> ]</font></center></tr>
</table>
  </center>
  </div>
<%
    rsNew.Close();
    rsNew = (jasp.adodb.Recordset)null;
    conn.Close();
    conn = (jasp.adodb.Connection)null;
%>



</html>






































<%
    End();
    } catch(Exception ex) {
        printStackTrace(ex);
    }
%>