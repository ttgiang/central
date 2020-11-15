import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics2D;
import java.io.FileOutputStream;
import java.io.IOException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.FontMapper;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;

public class Text2ToPdf1 {
    /** The resulting PDF. */
    public static final String RESULT = "c:\\tomcat\\webapps\\central\\core\\testj\\mylog.pdf";

    /**
     * Creates a PDF document.
     * @param filename the path to the new PDF document
     * @throws DocumentException
     * @throws IOException
     */
    public void createPdf(String filename) throws IOException, DocumentException {
    	// step 1
        Document document = new Document(new Rectangle(300, 150));
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filename));
        // step 3
        document.open();
        // step 4
        PdfContentByte canvas = writer.getDirectContent();
        // Create a custom font mapper that forces the use of arial unicode
        FontMapper arialuni = new FontMapper() {
            public BaseFont awtToPdf(Font font) {
                try {
                    return BaseFont.createFont(
                            "c:/windows/fonts/arialuni.ttf",
                            BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                } catch (DocumentException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return null;
            }

            public Font pdfToAwt(BaseFont font, int size) {
                return null;
            }

        };
        // Create a Graphics2D object
        Graphics2D g2 = canvas.createGraphics(300, 150, arialuni);
        // Draw text to the Graphics2D
        HtmlEditorKitTest text = new HtmlEditorKitTest();
        //text.setSize(new Dimension(300, 150));
        //text.paint(g2);
        g2.dispose();
        // step 5

/*
PdfContentByte cb = writer.getDirectContent();
Graphics2D g22 = cb.createGraphics(612, 792, new DefaultFontMapper(), true, .95f);
AffineTransform at = new AffineTransform();
at.translate(convertToPixels(20), convertToPixels(20));
at.scale(pixelToPoint, pixelToPoint);
g22.transform(at);
g22.setColor(Color.WHITE);
g22.fill(ta.getBounds());
Rectangle alloc = getVisibleEditorRect(ta);
ta.getUI().getRootView(ta).paint(g22, alloc);
g22.setColor(Color.BLACK);
g22.draw(ta.getBounds());
g22.dispose();
*/
        document.close();
    }
    /**
     * Main method.
     *
     * @param    args    no arguments needed
     * @throws DocumentException
     * @throws IOException
     */
    public static void main(String[] args) throws IOException, DocumentException {
        new Text2ToPdf1().createPdf(RESULT);
    }
}