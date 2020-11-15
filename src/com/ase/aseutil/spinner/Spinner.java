package com.ase.aseutil.spinner;

import java.awt.Container;
import java.awt.FlowLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 * Spinner.java
 */
class Spinner {

	private PictureGetter getter;

	private String image = "talin";

	public Spinner(String image){

		this.image = image;

		getter = new PictureGetter();
	}

    public void start() {

        JLabel spinner = new JLabel(getter.getIcon(image + ".jpg"));

        JButton button = new JButton("Spin");
        JFrame window = new JFrame("Spinner (c) TalinG");
        Container cp = window.getContentPane();
        cp.setLayout(new FlowLayout());
        cp.add(spinner);
        cp.add(button);

        button.addActionListener(new ButtonListener(spinner,image));

        window.pack();
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setVisible(true);
    }
}
