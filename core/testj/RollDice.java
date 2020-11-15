// File:   rolldice/RollDice.java
// Description: Main program and applet display two dice and roll them.
// Tag: <applet code="rolldice.RollDice.class" archive="rolldice.jar"
//            width="140" height="117"></applet>
// Author: Fred Swartz - 2006-11-30 - Placed in public domain.

import java.awt.*;
import javax.swing.*;

public class RollDice extends JApplet {

    public RollDice() {
        this.setContentPane(new RollDicePanel());
    }

    public static void main(String[] args) {
        JFrame window = new JFrame("Spinner");
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setContentPane(new RollDicePanel());
        window.pack();
        //System.out.println(window.getContentPane().getSize());
        window.setLocationRelativeTo(null);
        window.setVisible(true);
    }
}