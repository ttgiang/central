import java.io.*;
import java.lang.*;
import java.net.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.text.*;

class PageLoader implements Runnable
{
    private JEditorPane html;
    private URL         url;
    private Cursor      cursor;

    PageLoader( JEditorPane html, URL url, Cursor cursor )
    {
        this.html = html;
        this.url = url;
        this.cursor = cursor;
    }

    public void run()
    {
	    if( url == null )
	    {
    		// restore the original cursor
	    	html.setCursor( cursor );

    		// PENDING(prinz) remove this hack when
    		// automatic validation is activated.
    		Container parent = html.getParent();
    		parent.repaint();
        }
        else
        {
    		Document doc = html.getDocument();
	    	try {
		        html.setPage( url );
    		}
    		catch( IOException ioe )
    		{
    		    html.setDocument( doc );
    		}
    		finally
    		{
    		    // schedule the cursor to revert after
	    	    // the paint has happended.
		        url = null;
    		    SwingUtilities.invokeLater( this );
	    	}
	    }
	}
}

