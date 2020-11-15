<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.net.URL"%>


<%@
	page import="com.itextpdf.text.*,com.itextpdf.text.pdf.*"
%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form>
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

	String campus = "KAP";
	String alpha = "PHYS";
	String num = "272";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "R1c19c10185";
	String message = "";
	String url = "";

	out.println("Start<br/>");

	if (processPage){

		// create an instance of HtmlCleaner
		HtmlCleaner cleaner = new HtmlCleaner();

		// take default cleaner properties
		CleanerProperties props = cleaner.getProperties();

		String[] args = null;

		String destination = getArgValue(args, "dest");
		String outputType = getArgValue(args, "outputtype");
		String advancedXmlEscape = getArgValue(args, "advancedxmlescape");
		String useCData = getArgValue(args, "usecdata");
		String translateSpecialEntities = getArgValue(args, "specialentities");
		String unicodeChars = getArgValue(args, "unicodechars");
		String omitUnknownTags = getArgValue(args, "omitunknowntags");
		String treatUnknownTagsAsContent = getArgValue(args, "treatunknowntagsascontent");
		String omitDeprecatedTags = getArgValue(args, "omitdeprtags");
		String treatDeprecatedTagsAsContent = getArgValue(args, "treatdeprtagsascontent");
		String omitComments = getArgValue(args, "omitcomments");
		String omitXmlDeclaration = getArgValue(args, "omitxmldecl");
		String omitDoctypeDeclaration = getArgValue(args, "omitdoctypedecl");
		String omitHtmlEnvelope = getArgValue(args, "omithtmlenvelope");
		String useEmptyElementTags = getArgValue(args, "useemptyelementtags");
		String allowMultiWordAttributes = getArgValue(args, "allowmultiwordattributes");
		String allowHtmlInsideAttributes = getArgValue(args, "allowhtmlinsideattributes");
		String ignoreQuestAndExclam = getArgValue(args, "ignoreqe");
		String namespacesAware= getArgValue(args, "namespacesaware");
		String commentHyphen = getArgValue(args, "hyphenreplacement");
		String pruneTags = getArgValue(args, "prunetags");
		String booleanAtts = getArgValue(args, "booleanatts");
		String nodeByXPath = getArgValue(args, "nodebyxpath");

		props.setOmitUnknownTags( toBoolean(omitUnknownTags) );
		props.setTreatUnknownTagsAsContent( toBoolean(treatUnknownTagsAsContent) );
		props.setOmitDeprecatedTags( toBoolean(omitDeprecatedTags) );
		props.setTreatDeprecatedTagsAsContent( toBoolean(treatDeprecatedTagsAsContent) );
		props.setAdvancedXmlEscape( toBoolean(advancedXmlEscape) );
		props.setUseCdataForScriptAndStyle( toBoolean(useCData) );
		props.setTranslateSpecialEntities( toBoolean(translateSpecialEntities) );
		props.setRecognizeUnicodeChars( toBoolean(unicodeChars) );
		props.setOmitComments( toBoolean(omitComments) );
		props.setOmitXmlDeclaration( toBoolean(omitXmlDeclaration) );
		props.setOmitDoctypeDeclaration( toBoolean(omitDoctypeDeclaration) );
		props.setOmitHtmlEnvelope( toBoolean(omitHtmlEnvelope) );
		props.setUseEmptyElementTags( toBoolean(useEmptyElementTags) );
		props.setAllowMultiWordAttributes( toBoolean(allowMultiWordAttributes) );
		props.setAllowHtmlInsideAttributes( toBoolean(allowHtmlInsideAttributes) );
		props.setIgnoreQuestAndExclam( toBoolean(ignoreQuestAndExclam) );
		props.setNamespacesAware( toBoolean(namespacesAware) );
		props.setHyphenReplacementInComment(commentHyphen);
		props.setPruneTags(pruneTags);
		props.setBooleanAttributeValues(booleanAtts);

		TagNode node = cleaner.clean(...);

		OutputStream output = new FileOutputStream(new File("C:\\tomcat\\webapps\\central\\index.xml"));

		TagNode node = cleaner.clean(new URL("http://localhost:8080/central/core/test.jsp"), HtmlCleaner.DEFAULT_CHARSET);
		out.println(node.getText().toString());

		//new SimpleXmlSerializer(props).writeXmlToStream(node, output, HtmlCleaner.DEFAULT_CHARSET);
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	private static String getArgValue(String[] args, String name) {
		return "";
	}

	public static boolean toBoolean(String s) {
		return s != null && ( "on".equalsIgnoreCase(s) || "true".equalsIgnoreCase(s) || "yes".equalsIgnoreCase(s) );
	}

%>
</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
