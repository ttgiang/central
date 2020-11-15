import java.awt.Event;
import java.awt.Button;
import java.awt.TextField;
import java.awt.FlowLayout;
import java.applet.Applet;
import java.net.URL;
import java.net.MalformedURLException;
import netscape.javascript.JSObject;
import netscape.javascript.JSException;


public class JScriptExample extends Applet
{
    private String text1 = "<HTML><HEAD><TITLE>Wow</TITLE></HEAD><BODY><H1>Gimme more!</H1></BODY></HTML>";
    private String text2 = "<HTML><HEAD><TITLE>Wowee</TITLE></HEAD><BODY><H1>Gimme more!</H1></BODY></HTML> ";
    private TextField txt1, txt2;

    private JSObject win, doc;


    public void init()
    {
	setLayout(new FlowLayout(FlowLayout.LEFT));
	txt1 = new TextField(text1, 40);
	txt2 = new TextField(text2, 40);
	add(txt1);
	add(new Button("LiveConnect"));
	add(txt2);
	add(new Button("showDocument()"));
    }

    public void start()
    {
	win = JSObject.getWindow(this);
	doc = (JSObject) win.getMember("document");
    }

    public boolean action(Event evt, Object obj)
    {
        if (obj.equals("LiveConnect"))
        {
	    Object[] args = { txt1.getText() };
	    doc.call("writeln", args);
            return true;
        }

        if (obj.equals("showDocument()"))
        {
	    URL js;

	    try
		{ js = new URL("javascript:\"" + txt2.getText() + "\""); }
	    catch (MalformedURLException mue)
		{ return true; }
	    getAppletContext().showDocument(js);
            return true;
        }

        return super.action(evt, obj);
    }

}
