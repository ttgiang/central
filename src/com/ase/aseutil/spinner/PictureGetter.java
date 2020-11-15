package com.ase.aseutil.spinner;

import javax.swing.Icon;
import javax.swing.ImageIcon;

/**
 * ImageGetter.java
 */
public class PictureGetter {

	public Icon getIcon(String name){
		return new ImageIcon(Spinner.class.getResource("images/" + name));
	}
}
