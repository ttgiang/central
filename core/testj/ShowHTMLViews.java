import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.PrintStream;
import java.util.Enumeration;

import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.UIManager;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.Element;
import javax.swing.text.JTextComponent;
import javax.swing.text.View;

public class ShowHTMLViews {
  public static void main(String[] args) {
    try {
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
    } catch (Exception evt) {}

    try {
      JFrame f = new JFrame("HTML Document View Structure");
      final JEditorPane ep = new JEditorPane("mylog.html");
      ep.setEditable(false);
      f.getContentPane().add(new JScrollPane(ep));
      f.setSize(400, 300);
      f.setVisible(true);

      ep.addPropertyChangeListener(new PropertyChangeListener() {
        public void propertyChange(PropertyChangeEvent evt) {
          if (evt.getPropertyName().equals("page")) {
            System.out.println("Document:\n");
            HTMLDocDisplay.displayModel(ep, System.out);
            System.out.println("\n\nViews:\n");
            HTMLViewDisplayer.displayViews(ep, System.out);
          }
        }
      });
    } catch (Exception e) {
      System.out.println(e);
      System.exit(1);
    }
  }
}

class HTMLDocDisplay {
  public static void displayAttributes(AttributeSet a, int indent,
      PrintStream out) {
    if (a == null)
      return;

    a = a.copyAttributes();
    Enumeration x = a.getAttributeNames();
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }
    if (x != null) {
      out.println("ATTRIBUTES:");
      while (x.hasMoreElements()) {

        for (int i = 0; i < indent; i++) {
          out.print("  ");
        }
        Object attr = x.nextElement();
        out.println(" (" + attr + ", " + a.getAttribute(attr) + ")"
            + " [" + getShortClassName(attr.getClass()) + "/"
            + getShortClassName(a.getAttribute(attr).getClass())
            + "] ");
      }
    } else {
      out.println("No attributes");
    }
    if (a.getResolveParent() != null) {
      displayAttributes(a.getResolveParent().copyAttributes(),
          indent + 1, out);
    }
  }

  public static void displayModel(JTextComponent comp, PrintStream out) {
    Document doc = comp.getDocument();
    Element e = doc.getDefaultRootElement();
    displayElement(doc, e, 0, out);
  }

  public static void displayElement(Document doc, Element e, int indent,
      PrintStream out) {
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }
    out.println("===== Element Class: " + getShortClassName(e.getClass()));
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }
    int startOffset = e.getStartOffset();
    int endOffset = e.getEndOffset();
    out.println("Offsets [" + startOffset + ", " + endOffset + "]");
    AttributeSet a = e.getAttributes();
    Enumeration x = a.getAttributeNames();
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }
    out.println("ATTRIBUTES:");
    while (x.hasMoreElements()) {
      for (int i = 0; i < indent; i++) {
        out.print("  ");
      }
      Object attr = x.nextElement();
      out
          .println(" ("
              + attr
              + ", "
              + a.getAttribute(attr)
              + ")"
              + " ["
              + getShortClassName(attr.getClass())
              + "/"
              + getShortClassName(a.getAttribute(attr).getClass())
              + "] ");
    }

    // Display the text for a leaf element
    if (e.isLeaf()) {
      try {
        String str = doc.getText(startOffset, endOffset - startOffset);
        if (str.length() > 40) {
          str = str.substring(0, 40);
        }
        if (str.length() > 0) {
          for (int i = 0; i < indent; i++) {
            out.print("  ");
          }
          out.println("[" + str + "]");
        }
      } catch (BadLocationException ex) {
      }
    }

    // Display child elements
    int count = e.getElementCount();
    for (int i = 0; i < count; i++) {
      displayElement(doc, e.getElement(i), indent + 1, out);
    }
  }

  public static String getShortClassName(Class clazz) {
    String className = clazz.getName();
    return className.substring(className.lastIndexOf(".") + 1);
  }
}

class HTMLViewDisplayer {
  public static void displayViews(JTextComponent comp, PrintStream out) {
    View rootView = comp.getUI().getRootView(comp);
    displayView(rootView, 0, comp.getDocument(), out);
  }

  public static void displayView(View view, int indent, Document doc,
      PrintStream out) {
    String name = view.getClass().getName();
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }

    int start = view.getStartOffset();
    int end = view.getEndOffset();
    out.println(name + "; offsets [" + start + ", " + end + "]");
    for (int i = 0; i < indent; i++) {
      out.print("  ");
    }
    HTMLDocDisplay.displayAttributes(view.getAttributes(), indent, out);
    int viewCount = view.getViewCount();
    if (viewCount == 0) {
      int length = Math.min(32, end - start);
      try {
        String txt = doc.getText(start, length);
        for (int i = 0; i < indent + 1; i++) {
          out.print("  ");
        }
        out.println("[" + txt + "]");
      } catch (BadLocationException e) {
      }
    } else {
      for (int i = 0; i < viewCount; i++) {
        displayView(view.getView(i), indent + 1, doc, out);
      }
    }
    out.println("");
  }
}