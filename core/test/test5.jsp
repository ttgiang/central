<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	//CompareFile(out);
%>

<%!
	public static int CompareFile(javax.servlet.jsp.JspWriter out) throws SQLException {

		try{
			//Getting the name of the files to be compared.
			BufferedReader br2 = new BufferedReader (new InputStreamReader(System.in));

			//System.out.println("Enter 1st File name:");
			//String str = br2.readLine();

			//System.out.println("Enter 2nd File name:");
			//String str1 = br2.readLine();

			String str = "c:\\tomcat\\webapps\\central\\core\\test5.bak";
			String str1 = "c:\\tomcat\\webapps\\central\\core\\test5.jsp";

			String s1="";
			String s2="";
			String s3="";
			String s4="";
			String y="";
			String z="";

			//Reading the contents of the files
			BufferedReader br = new BufferedReader (new FileReader (str));
			BufferedReader br1 = new BufferedReader (new FileReader (str1));

			while((z=br1.readLine())!=null)
				s3+=z;

			while((y=br.readLine())!=null)
				s1+=y;

			out.println("<br/>");

			//String tokenizing
			int numTokens = 0;
			StringTokenizer st = new StringTokenizer (s1);
			String[] a = new String[10000];
			for(int l=0;l<10000;l++){
				a[l]="";
			}

			int i=0;
			while (st.hasMoreTokens()){
				s2 = st.nextToken();
				a[i]=s2;
				i++;
				numTokens++;
			}

			int numTokens1 = 0;
			StringTokenizer st1 = new StringTokenizer (s3);
			String[] b = new String[10000];
			for(int k=0;k<10000;k++){
				b[k]="";
			}

			int j=0;
			while (st1.hasMoreTokens()){
				s4 = st1.nextToken();
				b[j]=s4;
				j++;
				numTokens1++;
			}

			//comparing the contents of the files and printing the differences, if any.
			int x=0;
			for(int m=0;m<a.length;m++){
				if(a[m].equals(b[m])){
				}
				else{
					x++;
					out.println(a[m] + " -- " +b[m] + "<br/>");
				}
			}

			out.println("No. of differences : " + x + "<br/>");

			if(x>0){
				out.println("Files are not equal<br/>");
			}
			else{
				out.println("Files are equal. No difference found<br/>");
			}
		}
		catch(IOException i){
			//
		}

		return 0;

	}
%>
		</td>
	</tr>
</table>

</body>
</html>

