/*
 * @(#)TestJEditorPane.java
 *
 * Summary: demonstrate the use of javax.swing.JEditorPane to edit HTML text.
 *
 * Copyright: (c) 2009-2010 Roedy Green, Canadian Mind Products, http://mindprod.com
 *
 * Licence: This software may be copied and used freely for any purpose but military.
 *          http://mindprod.com/contact/nonmil.html
 *
 * Requires: JDK 1.6+
 *
 * Created with: IntelliJ IDEA IDE.
 *
 * Version History:
 *  1.0 2009-01-01 - initial version
 */
import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.SwingUtilities;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.html.HTMLDocument;
import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.net.MalformedURLException;
import java.net.URL;

import static java.lang.System.out;

/**
 * demonstrate the use of javax.swing.JEditorPane to edit HTML text.
 *
 * @author Roedy Green, Canadian Mind Products
 * @version 1.0 2009-01-01 - initial version
 * @since 2009-01-01
 */
public final class TestJEditorPane
    {
// --------------------------- main() method ---------------------------

    /**
     * Debugging harness for a Frame
     *
     * @param args command line arguments are ignored.
     */
    public static void main( String args[] )
    {
    SwingUtilities.invokeLater( new Runnable()
    {
    /**
     * fire up a JFrame on the Swing thread
     */
    public void run()
    {
    final JFrame jFrame = new JFrame();
    final Container contentPane = jFrame.getContentPane();
    contentPane.setLayout( new GridBagLayout() );

    final JEditorPane jEditorPane = new JEditorPane();
    jEditorPane.setContentType( "text/html" );
    jEditorPane.setEditable( true );

    // Gotcha! Setting background has no effect. You must set colours in HTML markup
    jEditorPane.setBackground( new Color( 0xffe8e8 ) );

    jEditorPane.setForeground( Color.BLACK );
    jEditorPane.setFont( new Font( "Dialog", Font.BOLD, 15 ) );
    jEditorPane.setAlignmentX( 0.5f );
    jEditorPane.setAlignmentY( 0.5f );
    // provide some space around the inside
    jEditorPane.setMargin( new Insets( 4, 4, 4, 4 ) );
    jEditorPane.setEnabled( true );
    final JScrollPane scroller = new JScrollPane( jEditorPane );
    final HTMLDocument htmlDocument = new HTMLDocument();
    // If there are any relative links including relative references to images in your HTML,
    // you will need some sort of assumed base URL to define what they mean.
    // There is nothing inherently inside the document to define that.
    try
        {
        htmlDocument.setBase( new URL( "http://mindprod.com" ) );
        }
    catch ( MalformedURLException e )
        {
        System.exit( 1 );
        }
    jEditorPane.setDocument( htmlDocument );

    // do you setText after the setDocument.
    jEditorPane.setText( "<html><body><font color=\"red\">hello</font></body></html>" );

    htmlDocument.addDocumentListener( new DocumentListener()
    {
    public void changedUpdate( DocumentEvent theEvent )
        {
        out.println( "change: " + jEditorPane.getText() );
        }

    public void insertUpdate( DocumentEvent theEvent )
        {
        out.println( "insert: " + jEditorPane.getText() );
        }

    public void removeUpdate( DocumentEvent theEvent )
        {
        out.println( "remove: " + jEditorPane.getText() );
        }
    } );

    contentPane.add( scroller,

            new GridBagConstraints( 0,
                    0,
                    1,
                    1,
                    100.0,
                    100.0,
                    GridBagConstraints.CENTER,
                    GridBagConstraints.BOTH,
                    new Insets( 10, 10, 10, 10 ),
                    0,
                    0 ) );

    jFrame.setSize( 150, 100 );
    jFrame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
    jFrame.validate();
    jFrame.setVisible( true );
    }
    } );
    }// end main
    }