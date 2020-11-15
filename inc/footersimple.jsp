		<%
			int yearFooter = 0;

			try{
				java.util.Date todayFooter = new java.util.Date();
				java.sql.Date dateFooter = new java.sql.Date(todayFooter.getTime());
				java.util.GregorianCalendar calFooter = new java.util.GregorianCalendar();
				calFooter.setTime(dateFooter);
				yearFooter = calFooter.get(java.util.Calendar.YEAR);
			}
			catch(Exception z){
				//
			}
		%>

		<p style="text-align: center">
			<font class="copyright">Copyright &copy; 1997-<%=yearFooter%>. All rights reserved</font>
		</p>
