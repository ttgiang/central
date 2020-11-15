import java.io.*;
import java.net.*;
import java.awt.BorderLayout;
import java.awt.Dimension;
import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.SwingUtilities;
import javax.swing.text.Document;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.StyleSheet;

public class HtmlEditorKitTest{

  public static void main(String[] args){
    new HtmlEditorKitTest();
  }

  public HtmlEditorKitTest(){
    SwingUtilities.invokeLater(new Runnable(){


      public void run(){
			try {
				String line = null;
				StringBuffer contents = new StringBuffer();
				File aFile = new File("c:\\tomcat\\webapps\\central\\core\\testj\\mylog.html");
				BufferedReader input = new BufferedReader(new FileReader(aFile));
				while ((line = input.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}
				input.close();

			  JEditorPane jEditorPane = new JEditorPane();

			  // make it read-only
			  jEditorPane.setEditable(false);

			  // create a scrollpane; modify its attributes as desired
			  JScrollPane scrollPane = new JScrollPane(jEditorPane);

			  // add an html editor kit
			  HTMLEditorKit kit = new HTMLEditorKit();
			  jEditorPane.setEditorKit(kit);

			  // add some styles to the html
			  StyleSheet styleSheet = kit.getStyleSheet();
			  styleSheet.addRule("body {color:#000; font: normal 11pt Verdana, Arial; margin: 0; }");
			  styleSheet.addRule(".dataColumn{text-align: left; nowrap; COLOR: #083772;}");
			  styleSheet.addRule(".textblackTH{FONT-WEIGHT: bold; text-align: left; nowrap; vertical-align: top; COLOR: #525252;}");
			  styleSheet.addRule(".outputTitleCenter{font-size:14pt; FONT-WEIGHT: bold; text-align: center; nowrap; vertical-align: top; COLOR: #525252;}");
			  styleSheet.addRule(".copyright {color: #C0C0C0;}");

			  // create a document, set it on the jeditorpane, then add the html
			  Document doc = kit.createDefaultDocument();
			  jEditorPane.setDocument(doc);
			  jEditorPane.setText(contents.toString());

			  // now add it all to a frame
			  JFrame j = new JFrame("HtmlEditorKit Test");
			  j.getContentPane().add(scrollPane, BorderLayout.CENTER);

			  // make it easy to close the application
			  j.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

			  // display the frame
			  j.setSize(new Dimension(800,600));

			  // pack it, if you prefer
			  //j.pack();

			  // center the jframe, then make it visible
			  j.setLocationRelativeTo(null);
			  j.setVisible(true);
			}
			catch( MalformedURLException e )
			{
				 System.out.println( "Malformed URL: " + e );
			}
			catch( IOException e )
			{
				 System.out.println( "IOException: " + e );
			}

      }
    });
  }
}
