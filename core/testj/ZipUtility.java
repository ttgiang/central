/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

//package com.ase.aseutil.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.io.*;

public class ZipUtility {

	private ZipOutputStream zipOutputStream = null;
	private String strSource = "";
	private String strTarget = "";
	private static long size = 0;
	private static int numOfFiles = 0;

	public static void main(String args[]) {

		if(args == null || args.length < 2) {
			//System.out.println("Usage: java ZipUtility <directory or file to be zipped> <directory of zip file to be created>");
			//return;
		}

		ZipUtility zipUtility = new ZipUtility();
		zipUtility.strSource = "C:\\tomcat\\webapps\\central\\core\\testj\\"; //args[0];
		zipUtility.strTarget = "C:\\tomcat\\webapps\\central\\core\\testj\\zipfile.zip"; //args[1];
		zipUtility.zip();
	}

	private void zip(){
		try		{
			File file = new File (strSource);
			if (!file.isFile() && !file.isDirectory() ) {
				System.out.println("\nSource file/directory Not Found!");
				return;
			}
			FileOutputStream fos = new FileOutputStream(strTarget);
			zipOutputStream = new ZipOutputStream(fos);
			zipOutputStream.setLevel(9);
			zipFiles(file);
			zipOutputStream.finish();
			zipOutputStream.close();
			System.out.println("\n Finished creating zip file " + strTarget + " from source " + strSource);
			System.out.println("\n Total of  " + numOfFiles +" files are Zipped " );
			System.out.println("\n Total of  " + size  + " bytes are Zipped  ");
		}	catch (Exception e){
			e.printStackTrace();
		}
	}

	private void  zipFiles(File file) {

		int byteCount;
		final int DATA_BLOCK_SIZE = 2048;
		FileInputStream fileInputStream;


		if (file.isDirectory()) {
			if(file.getName().equalsIgnoreCase(".metadata")){
				return;
			}
			File [] fList = file.listFiles() ;
			for (int i=0; i< fList.length; i++){
				zipFiles(fList[i]) ;
			}
		}

		else {
			try {
				if(file.getAbsolutePath().equalsIgnoreCase(strTarget)){
					return;
				}

				size += file.length();

				numOfFiles++;

				Filename fileName = new Filename(file.getPath(), '\\', '.');

				String strZipEntryName = fileName.fullname();

				fileInputStream = new FileInputStream(file) ;

				ZipEntry zipEntry = new ZipEntry(strZipEntryName);

				zipOutputStream.putNextEntry(zipEntry );

				byte[] b = new byte[DATA_BLOCK_SIZE];
				while ( (byteCount = fileInputStream.read(b, 0, DATA_BLOCK_SIZE)) != -1) {
					zipOutputStream.write(b, 0, byteCount);
				}

				zipOutputStream.closeEntry() ;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}

