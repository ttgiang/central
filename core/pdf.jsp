<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.fop.*"%>
<%@ page import="org.w3c.tidy.Tidy"%>
<%@ page import="java.io.*"%>

<%@ page import="org.allcolor.yahp.converter.CYaHPConverter"%>
<%@ page import="org.allcolor.yahp.converter.IHtmlToPdfTransformer"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.FileOutputStream"%>

<%@ page import="java.net.URL"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%

	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HIL";
	String user = "THANHG";

	out.println("Start<br/>");

	if (processPage){
		try{
			System.out.println("---------------------------- START");

			CYaHPConverter converter = new CYaHPConverter();

			String url = null;
			String outfile = null;
			String fontPath = null;
			String password = null;
			String keystorePath = null;
			String keystorePassword = null;
			String keyPassword = null;
			String cryptReason = null;
			String cryptLocation = null;

			url = "http://www.yahoo.com";
			outfile = "out.pdf";

			try {
				new URL(url);
			}
			catch (final Exception e) {
				//showUsage("--url must be a valid URL !");
			}

			try {
				File fout = new File(outfile);
				List headerFooterList = new ArrayList();

				FileOutputStream output = new FileOutputStream(fout);
				System.out.println("before conversion");

				Map properties = new HashMap();

				headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter(
					"<table width=\"100%\"><tbody><tr><td align=\"left\">Generated with YaHPConverter.</td><td align=\"right\">Page <pagenumber>/<pagecount></td></tr></tbody></table>",
					IHtmlToPdfTransformer.CHeaderFooter.HEADER));

				headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter("© 2011 Quentin Anciaux",IHtmlToPdfTransformer.CHeaderFooter.FOOTER));

				properties.put(IHtmlToPdfTransformer.PDF_RENDERER_CLASS,IHtmlToPdfTransformer.FLYINGSAUCER_PDF_RENDERER);

				if (fontPath != null)
					properties.put(IHtmlToPdfTransformer.FOP_TTF_FONT_PATH, fontPath);

				if (password != null) {
					System.out.println(password);
					properties.put(IHtmlToPdfTransformer.USE_PDF_ENCRYPTION,"true");
					properties.put(IHtmlToPdfTransformer.PDF_ALLOW_SCREEN_READERS,"true");
					properties.put(IHtmlToPdfTransformer.PDF_ENCRYPTION_PASSWORD,password);

					if (keystorePath != null) {
						properties.put(IHtmlToPdfTransformer.USE_PDF_SIGNING,"true");
						properties.put(IHtmlToPdfTransformer.PDF_SIGNING_PRIVATE_KEY_FILE,keystorePath);
						properties.put(IHtmlToPdfTransformer.PDF_SIGNING_KEYSTORE_PASSWORD,keystorePassword);
						properties.put(IHtmlToPdfTransformer.PDF_SIGNING_PRIVATE_KEY_PASSWORD,keyPassword);

						if (cryptReason != null) {
							properties.put(IHtmlToPdfTransformer.PDF_SIGNING_REASON,cryptReason);
						} // end if

						if (cryptLocation != null) {
							properties.put(IHtmlToPdfTransformer.PDF_SIGNING_LOCATION,cryptLocation);
						} // end if
					} // end if
				} // end if

				converter.convertToPdf(new URL(url),

				IHtmlToPdfTransformer.A4P, headerFooterList, output,properties);

				System.out.println("after conversion");

				output.flush();

				output.close();
			} // end try
			catch (final Throwable t) {
				t.printStackTrace();
				System.err.println("An error occurs while converting '" +url + "' to '" + outfile + "'. Cause : " +
				t.getMessage());
			} // end catch

			System.out.println("---------------------------- END");
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"fop",user);
%>

</table>

<%!

	/**
	 * return true if the given parameter is on the command line
	 *
	 * @param args startup arguments
	 * @param name parameter name
	 *
	 * @return true if the given parameter is on the command line
	 */
	private static boolean hasParameter(
		final String args[],
		final String name) {
		for (int i = 0; i < args.length; i++) {
			if (args[i].equals(name)) {
				return true;
			} // end if
		} // end for

		return false;
	} // end hasParameter()

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>