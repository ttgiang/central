/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.io;

import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import java.awt.Image;
import java.awt.Graphics2D;
import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

/**
 * A class to resize images
 * <p>
 *
 * @author <b>ASE</b>, Copyright &#169; 2011
 *
 * @version 1.0, 2012/12/27
 */
public class ImageResize {

	static Logger logger = Logger.getLogger(ImageResize.class.getName());

	public ImageResize() throws Exception {}

	/**
	 * resize
	 * <p>
	 * @param	input		String
	 * @param	output	String
	 * @param	format	String
	 * @param	width		int
	 * @param	height	int
	 * <p>
	 *
	 */
	public void resize(String input,String output,String format,int width,int height) {

		try{

			File file = new File(input);
			if(file.exists()){

				BufferedImage bi = ImageIO.read(new File(input));

				Image img = bi.getScaledInstance(width,height,Image.SCALE_SMOOTH);

				int w = width; 	//img.getWidth();
				int h = height; 	//img.getHeight();

				BufferedImage scaled = new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);

				Graphics2D g = scaled.createGraphics();

				g.drawImage(img,0,0,null);

				if(g != null){
					g.dispose();
				}

				ImageIO.write(scaled,format,new File(output));

			}
			else{
				logger.fatal("ImageResize.resize: image not found for resizing");
			}	// file exists

		}
		catch(IOException e){
			logger.fatal("ImageResize.resize: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ImageResize.resize: " + e.toString());
		}

	}

	public void close() throws Exception {}

}