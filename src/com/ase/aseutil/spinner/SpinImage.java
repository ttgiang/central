package com.ase.aseutil.spinner;

import java.util.Random;
import java.util.TimerTask;
import javax.swing.Icon;
import javax.swing.JLabel;

/**
 * SpinImage.java
 */
class SpinImage extends TimerTask {

	private JLabel spinner;
	private Random rg = new Random();
	private PictureGetter getter;
	private int count;
	private String image = "";

	public SpinImage(JLabel spinner,String image) {

		this.spinner = spinner;

		this.image = image;

		count = 25;

		getter = new PictureGetter();
	}

	public void run(){
		if(count > 0){
			count --;
			int num = rg.nextInt(6);
			Icon icon = getter.getIcon(image + (num+1) + ".jpg");
			spinner.setIcon(icon);
		}
		else{
			this.cancel();
		}
	}

}
