import org.htmlcleaner.*;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.output.XMLOutputter;
import org.jdom.xpath.XPath;

import javax.xml.transform.stream.StreamResult;
import java.util.List;
import java.util.Map;
import java.util.Iterator;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.File;
import java.net.URL;

public class HTMLCleaner {

public static void main(String[] args) throws IOException, JDOMException, XPatherException {

		String html = "<body>&copy; &nbsp; &apos; &quot; &lt; &gt; &mama;<script>var x = mama && tata;</script></body>";
		HtmlCleaner cleaner = new HtmlCleaner();
		CleanerProperties props = cleaner.getProperties();
		props.setUseCdataForScriptAndStyle(true);
		props.setRecognizeUnicodeChars(true);
		props.setUseEmptyElementTags(true);
		props.setAdvancedXmlEscape(true);
		props.setTranslateSpecialEntities(true);
		props.setBooleanAttributeValues("empty");

		//TagNode node = cleaner.clean(html);
		TagNode node = cleaner.clean(new File("C:/tomcat/webapps/htmlcleaner/src/files/test8.html"));

		System.out.println( new PrettyXmlSerializer(props).getXmlAsString(node) );

		new PrettyXmlSerializer(props).writeXmlToFile(node, "C:/tomcat/webapps/htmlcleaner/src/out.xml");
		//new ConfigFileTagProvider(new File("default.xml"));
	}

}
