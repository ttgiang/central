import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocListener;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontProvider;
import com.itextpdf.text.Image;
import com.itextpdf.text.html.simpleparser.ChainedProperties;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.html.simpleparser.ImageProvider;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

public class Roumanian {

   /**
    * Inner class implementing the FontProvider class.
    * This is needed if you want to select the correct fonts.
    */
   public static class MyFontFactory implements FontProvider {
       public Font getFont(String fontname,
               String encoding, boolean embedded, float size,
               int style, BaseColor color) {
               BaseFont bf;
               try {
                               bf = BaseFont.createFont("c:/windows/fonts/arialuni.ttf",
                                               "Identity-H", BaseFont.EMBEDDED);
                       } catch (DocumentException e) {
                               e.printStackTrace();
                               return new Font();
                       } catch (IOException e) {
                               e.printStackTrace();
                               return new Font();
                       }
           return new Font(bf, size);
       }

       public boolean isRegistered(String fontname) {
           return false;
       }
   }

   /** The resulting HTML file. */
   public static final String HTML = "/tomcat/webapps/central/src/com/ase/itextpdf/foobar.html";

   /** The resulting PDF file. */
   public static final String RESULT = "/tomcat/webapps/central/src/com/ase/itextpdf/foobar.pdf";

   /**
    * Main method.
    *
    * @param args no arguments needed
    * @throws IOException
    * @throws DocumentException
    * @throws SQLException
    */
   public static void main(String[] args)

       throws IOException, DocumentException, SQLException {
       HashMap<String,Object> map = new HashMap<String, Object>();
       map.put("font_factory", new MyFontFactory());
       // step 1
       Document document = new Document();
       // step 2
       PdfWriter.getInstance(document, new FileOutputStream(RESULT));
       // step 3
       document.open();
       // step 4
       List<Element> objects
           = HTMLWorker.parseToList(new FileReader(HTML), null, map);
       for (Element element : objects) {
           document.add(element);
       }
       // step 5
       document.close();
   }

}
