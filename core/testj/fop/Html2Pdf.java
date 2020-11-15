import java.io.FileInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.ByteArrayOutputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;

import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;

import org.w3c.tidy.Tidy;
import org.w3c.dom.Document;

import org.xml.sax.InputSource;

import org.apache.fop.apps.Driver;
//import org.apache.fop.messaging.MessageHandler;
import org.apache.fop.tools.DocumentInputSource;

//import org.apache.avalon.framework.logger.ConsoleLogger;
//import org.apache.avalon.framework.logger.Logger;

/*
 *  Class that converts HTML to PDF using
 *  the DOM interfaces of JTidy, Xalan, and FOP.
 *
 *  @author N. Afshartous
 *
 */
public class Html2Pdf {

	public static void main(String[] args) {

		// open file
		if (args.length != 2) {
			System.out.println("Usage: Html2Pdf htmlFile styleSheet");
			System.exit(1);
		}

		FileInputStream input = null;
		String htmlFileName = args[0];

		try {
			input = new FileInputStream(htmlFileName);
		}
		catch (java.io.FileNotFoundException e) {
			System.out.println("File not found: " + htmlFileName);
		}

		Tidy tidy = new Tidy();

		Document xmlDoc = tidy.parseDOM(input, null);

		Document foDoc = xml2FO(xmlDoc, args[1]);

		String pdfFileName = htmlFileName.substring(0, htmlFileName.indexOf(".")) + ".pdf";

		try {
			OutputStream pdf = new FileOutputStream(new File(pdfFileName));
			pdf.write(fo2PDF(foDoc));
		}
		catch (java.io.FileNotFoundException e) {
			System.out.println("Error creating PDF: " + pdfFileName);
		}
		catch (java.io.IOException e) {
			System.out.println("Error writing PDF: " + pdfFileName);
		}
	}

	/*
	*  Applies stylesheet to input.
	*
	*  @param xml  The xml input Document
	*
	*  @param stylesheet Name of the stylesheet
	*
	*  @return Document  Result of the transform
	*/
	private static Document xml2FO(Document xml, String styleSheet) {

		DOMSource xmlDomSource = new DOMSource(xml);

		DOMResult domResult = new DOMResult();

		Transformer transformer = getTransformer(styleSheet);

		if (transformer == null) {
			System.out.println("Error creating transformer for " + styleSheet);
			System.exit(1);
		}
		try {
			transformer.transform(xmlDomSource, domResult);
		}
		catch (javax.xml.transform.TransformerException e) {
			return null;
		}

		return (Document) domResult.getNode();
	}

	/*
	*  Apply FOP to XSL-FO input
	*
	*  @param foDocument  The XSL-FO input
	*
	*  @return byte[]  PDF result
	*/
	private static byte[] fo2PDF(Document foDocument) {

		DocumentInputSource fopInputSource = new DocumentInputSource(foDocument);

		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			//Logger log = new ConsoleLogger(ConsoleLogger.LEVEL_WARN);

			Driver driver = new Driver(fopInputSource, out);
			driver.setLogger(log);
			driver.setRenderer(Driver.RENDER_PDF);
			driver.run();

			return out.toByteArray();

		} catch (Exception ex) {
			return null;
		}
	}

	/*
	*  Create and return a Transformer for the specified stylesheet.
	*
	*  Based on the DOM2DOM.java example in the Xalan distribution.
	*/
	private static Transformer getTransformer(String styleSheet) {

		try {

			TransformerFactory tFactory = TransformerFactory.newInstance();

			DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance();

			dFactory.setNamespaceAware(true);

			DocumentBuilder dBuilder = dFactory.newDocumentBuilder();

			Document xslDoc = dBuilder.parse(styleSheet);

			DOMSource xslDomSource = new DOMSource(xslDoc);

			return tFactory.newTransformer(xslDomSource);

		}
		catch (javax.xml.transform.TransformerException e) {
			e.printStackTrace();
			return null;
		}
		catch (java.io.IOException e) {
			e.printStackTrace();
			return null;
		}
		catch (javax.xml.parsers.ParserConfigurationException e) {
			e.printStackTrace();
			return null;
		}
		catch (org.xml.sax.SAXException e) {
			e.printStackTrace();
			return null;
		}

	}

}
