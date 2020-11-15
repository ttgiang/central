import java.io.*;
import java.net.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

class EditPaneExample
		extends 	JFrame
		implements	HyperlinkListener
{
	private	JEditorPane	html;

	final   String		sPath = System.getProperty( "user.dir" ) + "/";
	public EditPaneExample()
	{
		setTitle( "HTML Application" );
		setSize( 400, 300 );
		setBackground( Color.gray );
		getContentPane().setLayout( new BorderLayout() );

		JPanel topPanel = new JPanel();
		topPanel.setLayout( new BorderLayout() );
		getContentPane().add( topPanel, BorderLayout.CENTER );

    	try {
    		// Load the url we want to display
	    	URL url = new URL( "file:///" + sPath + "mylog.html" );

		    // Create an HTML viewer to display the URL
		    html = new JEditorPane( url );
		    html.setEditable( false );

		    JScrollPane scrollPane = new JScrollPane();
		    scrollPane.getViewport().add( html, BorderLayout.CENTER );

		    topPanel.add( scrollPane, BorderLayout.CENTER );

		    html.addHyperlinkListener( this );
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

    public void hyperlinkUpdate( HyperlinkEvent event )
    {
		if( event.getEventType() == HyperlinkEvent.EventType.ACTIVATED )
		{
			// Load some cursors
			Cursor cursor = html.getCursor();
			Cursor waitCursor = Cursor.getPredefinedCursor( Cursor.WAIT_CURSOR );
			html.setCursor( waitCursor );

			// Handle the hyperlink change
			SwingUtilities.invokeLater( new PageLoader( html,
								event.getURL(), cursor ) );
		}
    }

	public static void main( String args[] )
	{
		// Create an instance of the test application
		EditPaneExample mainFrame	= new EditPaneExample();
		mainFrame.setVisible( true );
	}
}

