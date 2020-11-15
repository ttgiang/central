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

public class XmlPDF {

    /**
     * Main method.
     *
     * @param    args    no arguments needed
     * @throws DocumentException
     * @throws IOException
     */
    public static void main(String[] args) throws IOException, DocumentException {

			try{
				Document doc = new Document(PageSize.A4);
				PdfWriter instance = PdfWriter.getInstance(doc, new FileOutputStream(new File("./target/testclasses/examples/columbus.pdf")));
				doc.open();
				XMLWorkerHelper.getInstance().parseXHtml(instance,doc,XMLWorkerHelperExample.class.getResourceAsStream("columbus.html"));
				doc.close();
			}
			catch(com.itextpdf.tool.xml.exceptions.CssResolverException e){
				 System.out.println("CssResolverException: " + e.toString());
			}
			catch(Exception e){
				 System.out.println("Exception: " + e.toString());
			}

    }
}
