import javax.swing.*;

public class TestContentType {

  public static void main(String[] args) {
    JTextPane textpane = new JTextPane();
    textpane.setContentType("text/html");
    textpane.setText("<h1>News</h1><p> Java Version: " +
      System.getProperty("java.version") + "</p>");
    JOptionPane.showMessageDialog(null, textpane);
  }
}
