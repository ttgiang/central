/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// FileIndexer.java
//

package com.ase.aseutil.index;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileReader;
import java.io.FileInputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import org.apache.poi.hwpf.*;
import org.apache.poi.hwpf.extractor.*;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import java.io.FileInputStream;
import java.util.Iterator;
import java.util.Vector;
import java.sql.Connection;

import java.util.Scanner;

import com.snowtide.pdf.OutputTarget;
import com.snowtide.pdf.PDFTextStream;

import com.ase.aseutil.AsePool;

public class FileIndexer {

	static Logger logger = Logger.getLogger(FileIndexer.class.getName());

	//--------------------------------------------
	//
	//--------------------------------------------
	private static String dta = "C:\\tomcat\\webapps\\central\\doc\\completed\\pdf";
	private static String idx = "C:\\tomcat\\webapps\\centraldocs\\docs\\index";

	//private static String dta = "S:\\FORMS";
	//private static String idx = "C:\\tomcat\\webapps\\fchdocs\\index";

	// default to ALL can view
	private static String campus = "ALL";

	private static boolean central = true;

	private static long indexed = 0;

	private static int docs = 0;
	private static int xlss = 0;
	private static int txts = 0;
	private static int pdfs = 0;

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void main(String[] args) throws Exception {

		createIndex();

		System.out.println("doc indexed: " + docs);
		System.out.println("pdf indexed: " + pdfs);
		System.out.println("xls indexed: " + xlss);
		System.out.println("txt indexed: " + txts);

    }

	//--------------------------------------------
	//
	//--------------------------------------------
	public FileIndexer() throws Exception {}

	//--------------------------------------------
	//
	//--------------------------------------------
	@SuppressWarnings("unchecked")
	public static int createIndex() {

		int numIndexed = 0;

		System.out.println("data: " + dta);
		System.out.println("index: " + idx);

		if(!idx.equals("") && !dta.equals("")){

			IndexWriter indexWriter = null;

			Directory directory = null;

			try{

				System.out.println("starting index");

				File dir = new File(dta);
				if(dir.exists()){
					File idxDir = new File(idx);

					File dtaDir = new File(dta);

					StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_35);

					directory = FSDirectory.open(idxDir);

					indexWriter = new IndexWriter(directory,new IndexWriterConfig(Version.LUCENE_35,analyzer));

					indexDirectory(indexWriter, dtaDir);

					numIndexed = indexWriter.maxDoc();

					System.out.println("indexed " + numIndexed + " documents");
				} // data dir exist

			}
			catch(IOException e){
				logger.fatal("FileIndex.createIndex.IOException: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("FileIndex.createIndex.Exception: " + e.toString());
			}
			finally{

				try{
					if(indexWriter != null)
						indexWriter.close();

					System.out.println("indexer closed");

					if(directory != null)
						directory.close();

					System.out.println("directory closed");
				}
				catch(Exception e){
					logger.fatal("FileIndex.createIndex.finally: " + e.toString());
				}

			}

		} // folders available

		return numIndexed;

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void indexDirectory(IndexWriter indexWriter, File dta) {

		File[] files = dta.listFiles();

		try{
			for (int i = 0; i < files.length; i++) {
				File f = files[i];
				if (f.isDirectory()) {
					indexDirectory(indexWriter, f);
				}
				else {
					indexFileWithIndexWriter(indexWriter, f);
				}
			}
		}
		catch(IOException e){
			logger.fatal("FileIndex.indexDirectory.IOException: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("FileIndex.indexDirectory.Exception: " + e.toString());
		}
	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void indexFileWithIndexWriter(IndexWriter indexWriter, File f) throws IOException {

		if (f.isHidden() || f.isDirectory() || !f.canRead() || !f.exists()) {
			return;
		}

		boolean debug = false;

		String filename = f.getName();

		String error = "";

		String extractedText = "";

		// get the file extension
		String ext = filename.substring(filename.lastIndexOf(".")+1);

		try{

			Document doc = new Document();

			if (ext.toLowerCase().equals("txt")) {
				++txts;
				extractedText = new Scanner(new File(f.getCanonicalPath())).useDelimiter("\\Z").next();
			}
			else if (ext.toLowerCase().equals("doc")) {

				++docs;

				FileInputStream fis = new FileInputStream(f);

				HWPFDocument document = new HWPFDocument(fis);
				WordExtractor extractor = new WordExtractor(document);
				extractedText = extractor.getText();

				// start index from where procedure starts
				if(isCentral()){
					int pos = extractedText.indexOf("Procedure");
					if(pos > -1){
						extractedText = extractedText.substring(pos);
					}
				} // central

			}
			else if (ext.toLowerCase().equals("xls")) {

				++xlss;

				FileInputStream fis = new FileInputStream(f);

				Vector vector = ReadCSV(fis);

				extractedText = printCellDataToConsole(vector);

			}
			else if (ext.toLowerCase().equals("pdf")) {

				++pdfs;

				String pdfFilePath = f.getCanonicalPath();

				PDFTextStream pdfts = new PDFTextStream(pdfFilePath);

				StringBuilder text = new StringBuilder(1024);

				pdfts.pipe(new OutputTarget(text));

				pdfts.close();

				extractedText = text.toString();

			}

			if(!debug){

				doc.add(new Field("contents", extractedText,
								Field.Store.YES,
								Field.Index.ANALYZED,
								Field.TermVector.WITH_POSITIONS_OFFSETS));

				doc.add(new Field("title", f.getName(),
								Field.Store.YES,
								Field.Index.NOT_ANALYZED));

				doc.add(new Field("filepath", f.getCanonicalPath(),
								Field.Store.YES,
								Field.Index.NOT_ANALYZED));

				doc.add(new Field("filename", f.getName(),
								Field.Store.YES,
								Field.Index.NOT_ANALYZED));

				doc.add(new Field("campus", campus,
								Field.Store.YES,
								Field.Index.NOT_ANALYZED));

				indexWriter.addDocument(doc);
			}
		}
		catch(IOException e){
			error = "1";
			logger.fatal("FileIndex.indexFileWithIndexWriter.IOException: " + e.toString());
		}
		catch(Exception e){
			error = "1";
			logger.fatal("FileIndex.indexFileWithIndexWriter.Exception: " + e.toString());
		}

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	@SuppressWarnings("unchecked")
	public static Vector ReadCSV(FileInputStream fis) {

		Vector cellVectorHolder = new Vector();

		try {
			POIFSFileSystem myFileSystem = new POIFSFileSystem(fis);

			HSSFWorkbook myWorkBook = new HSSFWorkbook(myFileSystem);

			HSSFSheet mySheet = myWorkBook.getSheetAt(0);

			Iterator rowIter = mySheet.rowIterator();

			while (rowIter.hasNext()) {

				HSSFRow myRow = (HSSFRow) rowIter.next();
				Iterator cellIter = myRow.cellIterator();
				Vector cellStoreVector = new Vector();

				while (cellIter.hasNext()) {
					HSSFCell myCell = (HSSFCell) cellIter.next();
					cellStoreVector.addElement(myCell);
				}

				cellVectorHolder.addElement(cellStoreVector);
			}

		} catch (Exception e) {
			//e.printStackTrace();
			logger.fatal("printCellDataToConsole : " + e.toString());
		}

		return cellVectorHolder;
	}

	//--------------------------------------------
	//
	//--------------------------------------------
	private static String printCellDataToConsole(Vector dataHolder) {

		StringBuilder sb = new StringBuilder();

		try{
			for (int i = 0; i < dataHolder.size(); i++) {

				try{
					Vector cellStoreVector = (Vector) dataHolder.elementAt(i);

					for (int j = 0; j < cellStoreVector.size(); j++) {

						try{
							HSSFCell myCell = (HSSFCell) cellStoreVector.elementAt(j);

							sb.append(myCell.toString());
						}
						catch(Exception e){
							logger.fatal("printCellDataToConsole : " + e.toString());
						}
					}
				}
				catch(Exception e){
					logger.fatal("printCellDataToConsole : " + e.toString());
				}

			}
		}
		catch(Exception e){
			logger.fatal("printCellDataToConsole : " + e.toString());
		}

		return sb.toString();
	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void setIndexed(long _indexed){

		indexed = _indexed;

	}

	public static long getIndexed(){

		return indexed;

	}


	//--------------------------------------------
	//
	//--------------------------------------------
	public static void setDta(String _dta){

		dta = _dta;

	}

	public static String getDta(){

		return dta;

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void setIdx(String _idx){

		idx = _idx;

	}

	public static String getIdx(){

		return idx;

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void setCampus(String _campus){

		campus = _campus;

	}

	public static String getCampus(){

		return campus;

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static boolean isCentral(){

		return central;

	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public String toString(){

		return
			"dta: " + dta + "\n" +
			"idx: " + idx + "\n" +
			"indexed: " + indexed + "\n" +
			"central: " + central + "\n" +
			"campus: " + campus+ "\n" +
			"";

	}

}
