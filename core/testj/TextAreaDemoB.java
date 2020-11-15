import java.awt.*;
import javax.swing.*;

public class TextAreaDemoB extends JFrame {
    //============================================== instance variables
   JTextArea _resultArea = new JTextArea(6, 20);

    //====================================================== constructor
    public TextAreaDemoB() {
        //... Set textarea's initial text, scrolling, and border.
        _resultArea.setText("Enter more text to see scrollbars");
        JScrollPane scrollingArea = new JScrollPane(_resultArea);

        //... Get the content pane, set layout, add to center
        JPanel content = new JPanel();
        content.setLayout(new BorderLayout());
        content.add(scrollingArea, BorderLayout.CENTER);

        //... Set window characteristics.
        this.setContentPane(content);
        this.setTitle("TextAreaDemo B");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.pack();
    }

    //============================================================= main
    public static void main(String[] args) {
        JFrame win = new TextAreaDemoB();
        win.setVisible(true);
    }
}