package com.ase.aseutil.spinner;

/**
 * Main.java
 */
public class Main {

	public static void main(String[] args) {

		String image = "talin";

		if (args.length > 0)
			image = args[0];

		Spinner spinner = new Spinner(image);

		spinner.start();
	}

}
