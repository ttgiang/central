
/*
 * $Id: HelloWorldMeta.java 3373 2008-05-12 16:21:24Z xlv $
 *
 * This code is part of the 'iText Tutorial'.
 * You can find the complete tutorial at the following address:
 * http://itextdocs.lowagie.com/tutorial/
 *
 * This code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * itext-questions@lists.sourceforge.net
 */

import java.io.FileOutputStream;
import java.io.IOException;

import java.io.*;

import com.lowagie.text.html.SAXmyHtmlHandler;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

import org.xml.sax.*;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;

import org.htmlcleaner.*;

import org.w3c.tidy.Tidy;

/**
 * Generates a simple PDF file with metadata.
 *
 * @author blowagie
 */

public class HelloWorldMeta {

	/**
	 * Generates a PDF file with metadata
	 *
	 * @param args no arguments needed here
	 */
	public static void main(String[] args) {

		System.out.println("Metadata");

		String htmlFile = "<html><head><title>Curriculum Central: News &amp; Information</title>";

		ByteArrayInputStream is = new ByteArrayInputStream(htmlFile.getBytes());
		ByteArrayOutputStream os = new ByteArrayOutputStream();

		Tidy tidy = new Tidy();
		tidy.setTidyMark(false);
		tidy.setDocType("auto");
		tidy.setWrapScriptlets(true);
		tidy.setOnlyErrors(true);
		tidy.setXHTML(true);
		tidy.setEncloseText(true);
		tidy.setXmlTags(true);
		tidy.parseDOM(is, os);

		String  newString = os.toString();

		///
		ByteArrayInputStream input = new ByteArrayInputStream(htmlFile.getBytes());
		HtmlCleaner cleaner = new HtmlCleaner();
		CleanerProperties props = cleaner.getProperties();
		DomSerializer doms = new DomSerializer(props,true);
		org.w3c.dom.Document xmlDoc = null;
		try {
			TagNode node = cleaner.clean(input);
			xmlDoc = doms.createDOM(node);
		} catch (Exception e) {
			e.printStackTrace();
		}
		///

		org.w3c.dom.Document foDoc = null;
		try {
			foDoc = xml2FO(xmlDoc);
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			e.printStackTrace();
		}

		// step 1: creation of a document-object
		Document document = new Document();
		try {
			// step 2:
			// we create a writer that listens to the document
			// and directs a PDF-stream to a file
			PdfWriter.getInstance(document,new FileOutputStream("HelloWorldMeta.pdf"));
			//PdfWriter.getInstance(document, response.getOutputStream());

			// step 3: we add some metadata open the document
			document.addTitle("Hello World example");
			document.addSubject("This example explains how to add metadata.");
			document.addKeywords("iText, Hello World, step 3, metadata");
			document.addCreator("My program using iText");
			document.addAuthor("Bruno Lowagie");
			document.open();
			// step 4: we add a paragraph to the document

			document.add(new Paragraph(htmlFile));

			SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
			parser.parse(is, new SAXmyHtmlHandler(document));

		} catch (DocumentException de) {
			System.err.println(de.getMessage());
		} catch (IOException ioe) {
			System.err.println(ioe.getMessage());
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		// step 5: we close the document
		document.close();
	}

	/*
	* Applies stylesheet to input.
	*
	* @param xml The xml input Document
	*
	* @return Document Result of the transform
	*/
	private static Document xml2FO(Document xml) throws Exception {

		DOMSource xmlDomSource = new
		DOMSource(xml);
		DOMResult domResult = new DOMResult();
		TransformerFactory factory =
		TransformerFactory.newInstance();
		Transformer transformer =
		factory.newTransformer();

		if (transformer == null) {
			System.out.println("Error creatingtransformer");
			System.exit(1);
		}
		try {
			transformer.transform(xmlDomSource,domResult);
		} catch(javax.xml.transform.TransformerException e) {
			return null;
		}

		return (Document) domResult.getNode();
	}

	/*
	* Apply FOP to XSL-FO input
	*
	* @param foDocument The XSL-FO input
	*
	* @return byte[] PDF result
	*/
	private static byte[] fo2PDF(Document foDocument, String styleSheet) {
		FopFactory fopFactory =
		FopFactory.newInstance();
		try {
			ByteArrayOutputStream out = new
			ByteArrayOutputStream();
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF,out);
			Transformer transformer = getTransformer(styleSheet);
			Source src = new DOMSource(foDocument);
			Result res = new SAXResult(fop.getDefaultHandler());
			transformer.transform(src, res);
			return out.toByteArray();
		} catch (Exception ex) {
			return null;
		}
	}

	/*
	* Create and return a Transformer for the specified stylesheet.
	*
	* Based on the DOM2DOM.java example in the Xalan distribution.
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
		} catch (javax.xml.transform.TransformerException e) {
			e.printStackTrace();
			return null;
		} catch (java.io.IOException e) {
			e.printStackTrace();
			return null;
		} catch (javax.xml.parsers.ParserConfigurationException e) {
			e.printStackTrace();
			return null;
		} catch (org.xml.sax.SAXException e) {
			e.printStackTrace();
			return null;
		}
	}

}