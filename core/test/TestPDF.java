/*
 * This class is part of the book "iText in Action - 2nd Edition"
 * written by Bruno Lowagie (ISBN: 9781935182610)
 * For more info, go to: http://itextpdf.com/examples/
 * This example only works with the AGPL version of iText.
 */
import java.awt.Graphics2D;
import java.io.*;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.DefaultFontMapper;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;

import com.itextpdf.tool.xml.DefaultTagProcessorFactory;
import com.itextpdf.tool.xml.ElementHandler;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerImpl;
import com.itextpdf.tool.xml.XMLWorkerConfigurationImpl;
import com.itextpdf.tool.xml.XMLWorkerHelper;

import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.GrayColor;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;

import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.CssUtils;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.exceptions.CssResolverException;

import com.itextpdf.tool.xml.parser.XMLParser;

import com.itextpdf.tool.xml.html.DummyTagProcessor;
import com.itextpdf.tool.xml.html.Tags;

import java.util.List;

public class TestPDF {

    /**
     * Creates a PDF document.
     * This example doesn't work as expected.
     * See Text1ToPdf2 to find out how to do it correctly.
     * @param filename the path to the new PDF document
     * @throws DocumentException
     * @throws IOException
     */
    public void createPdf(String inputFile,String outputFile) throws IOException, DocumentException, CssResolverException {

		System.out.println("START...");

		System.out.println("inputFile: " + inputFile);
		System.out.println("outputFile: " + outputFile);

		try{

			// Create a TagProcessor
			DefaultTagProcessorFactory htmlTagProcessorFactory = (DefaultTagProcessorFactory) new Tags().getHtmlTagProcessorFactory();
			System.out.println("DefaultTagProcessorFactory");

			// if needed override tag that you don't want to parse to DummyTagProcessor
			htmlTagProcessorFactory.addProcessor("img", new DummyTagProcessor());
			htmlTagProcessorFactory.addProcessor("link", new DummyTagProcessor());
			System.out.println("htmlTagProcessorFactory");

			// Create a fresh configuration and set needed configuration objects.
			XMLWorkerConfigurationImpl config = new XMLWorkerConfigurationImpl();
			System.out.println("config");

			// Attach the default CSS to a new CSSResolver
			CssFile defaultCSS = new XMLWorkerHelper().getDefaultCSS();
			System.out.println("defaultCSS");

			StyleAttrCSSResolver cssResolver = new StyleAttrCSSResolver();
			System.out.println("cssResolver");

			cssResolver.addCssFile(defaultCSS);
			System.out.println("addCssFile");

			// attach more CSS files if needed
			String otherCssFile = "c:\\tomcat\\webapps\\central\\inc\\style.css";
			cssResolver.addCssFile(otherCssFile);
			System.out.println("otherCssFile");

			// set the TagProcessorFactory
			config.tagProcessorFactory(htmlTagProcessorFactory).cssResolver(cssResolver).acceptUnknown(true);
			System.out.println("tagProcessorFactory");

			// create a document
			final Document doc = new Document();
			doc.setPageSize(PageSize.A4);
			System.out.println("setPageSize");

			// create writer
			FileOutputStream outputStream = new FileOutputStream(outputFile);
			PdfWriter writer = PdfWriter.getInstance(doc, outputStream);
			writer.setPageEvent(new Watermark());
			System.out.println("Watermark");

			// set margins for first page
			float margin = CssUtils.getInstance().parsePxInCmMmPcToPt("8px");
			doc.setMargins(margin, margin, margin, margin);
			System.out.println("setMargins");

			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(inputFile));
			System.out.println("inputFile");

			// OPEN the document !
			doc.open();
			config.document(doc).pdfWriter(writer);
			System.out.println("writer");

			// create the worker
			final XMLWorker worker = new XMLWorkerImpl(config);
			System.out.println("XMLWorker");

			// attach an ElementHandler
			worker.setDocumentListener(new ElementHandler() {

				public void addAll(final List<Element> arg0) throws DocumentException {
					for (Element e : arg0) {
						doc.add(e);
					}
				}

				public void add(final Element e) throws DocumentException {
					doc.add(e);
				}
			});

			// Set the worker in the parser and start parsing
			System.out.println("before parsing");
			XMLParser p = new XMLParser(worker);
			if (bis != null){
				p.parse(new StringReader(ReadFile(inputFile)));
			}
			else{
				System.out.println("bis is null");
			}
			writer.close();

		}
		catch(CssResolverException e){
			System.out.println("CssResolverException: " + e.toString());
		}
		catch(DocumentException e){
			System.out.println("DocumentException: " + e.toString());
		}
		catch(IOException e){
			System.out.println("IOException: " + e.toString());
		}
		catch(Exception e){
			System.out.println("Exception: " + e.toString());
		}

		System.out.println("END...");

    }

		public String ReadFile(String inputFile){

			StringBuffer sb = new StringBuffer();

		  try{
			  FileInputStream fstream = new FileInputStream(inputFile);

			  DataInputStream in = new DataInputStream(fstream);

			  BufferedReader br = new BufferedReader(new InputStreamReader(in));

			  String strLine;

			  while ((strLine = br.readLine()) != null)   {
				  sb.append(strLine);
			  }

			  in.close();
			}
				catch (Exception e){
				System.err.println("Error: " + e.getMessage());
			}

			return sb.toString();
		}

		/**
		* Inner class to add a watermark to every page.
		*/
		static class Watermark extends PdfPageEventHelper {

			private String waterMark;

			Font font = new Font(Font.TIMES_ROMAN, 36, Font.NORMAL, new GrayColor(0.95f));

			public Watermark(){
				waterMark = "";
			}

			public Watermark(String wm){
				waterMark = wm;
			}

			public void onEndPage(PdfWriter writer, Document document) {

				ColumnText.showTextAligned(writer.getDirectContentUnder(),
												  Element.ALIGN_CENTER,
												  new Phrase(waterMark, font),
												  297.5f, 421, 0);
			}
		}

    /**
     * Main method.
     *
     * @param    args    no arguments needed
     * @throws DocumentException
     * @throws IOException
     */
    public static void main(String[] args) throws IOException, DocumentException {

			try{
        		new TestPDF().createPdf("c:\\tomcat\\webapps\\central\\core\\test.html","c:\\tomcat\\webapps\\central\\core\\testpdf.pdf");
			}
			catch(com.itextpdf.tool.xml.exceptions.CssResolverException e){
				 System.out.println("CssResolverException: " + e.toString());
			}
			catch(Exception e){
				 System.out.println("Exception: " + e.toString());
			}

    }
}
