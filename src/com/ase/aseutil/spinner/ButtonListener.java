package com.ase.aseutil.spinner;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Timer;
import javax.swing.JLabel;

/**
 * ButtonListener.java
 */
class ButtonListener implements ActionListener {

    private JLabel spinner;
    private String image;

    public ButtonListener(JLabel spinner,String image) {
        this.spinner = spinner;
        this.image = image;
    }

    public void actionPerformed(ActionEvent e) {
        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new SpinImage(spinner,image), 0, 100);
    }
}
