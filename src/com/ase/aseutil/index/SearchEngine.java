/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// SearchEngine.java
//

package com.ase.aseutil.index;

import java.io.File;
import java.sql.Connection;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import java.text.DecimalFormat;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.FuzzyQuery;
//import org.apache.lucene.search.highlight.Highlighter;
//import org.apache.lucene.search.highlight.NullFragmenter;
//import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.PhraseQuery;
import org.apache.lucene.search.PrefixFilter;
import org.apache.lucene.search.PrefixQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.search.WildcardQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import org.apache.log4j.Logger;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Generic;
import com.ase.aseutil.SysDB;

public class SearchEngine {

	static Logger logger = Logger.getLogger(SearchEngine.class.getName());

	// debug
	private static boolean debug;

	// location of our indexed data
	private static String indexFolder = "C:\\tomcat\\webapps\\centraldocs\\docs\\index";
	//private static String indexFolder = "C:\\tomcat\\webapps\\fchdocs\\index";

	// campus
	private static String campus;

	// search word(s)
	private static String searchWord;

	// number of hits returned
	private static int hitsFound = 0;

	// number of hits to display per page
	private static int pageSize = 10;

	// the page to retrieve
	private static int pageNumber = 1;

	// maxinum result per search
	private static int maxHits = 100;

	// search field
	private static final String SEARCH_FIELD = "contents";

	//--------------------------------------------
	//
	//--------------------------------------------
	public SearchEngine() throws Exception {}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static List<Generic> searchIndex(String _searchWord) throws IOException, ParseException {

		try{

			Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_35);

			QueryParser parser = new QueryParser(Version.LUCENE_35, SEARCH_FIELD, analyzer);

			Query query = parser.parse(_searchWord);

			//
			// this code works. it bolds the result
			//
			//Highlighter highlighter = new Highlighter(new QueryScorer(parser.parse(_searchWord)));
			//highlighter.setTextFragmenter(new NullFragmenter());
			//String text = highlighter.getBestFragment(analyzer, "", _searchWord);
			//System.out.println(text);

			return searchIndex(query);

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return null;
	}

	/**
	 * Generates list of hits
	 * @param query - as formalized by various options shown in main
	 * @return
	 * 		List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchIndex(Query query) throws IOException, ParseException {

		List<Generic> genericData = null;

		Directory directory = null;

		IndexSearcher searcher = null;

		IndexReader reader = null;

		try{

			File indexDir = new File(indexFolder);

			directory = FSDirectory.open(indexDir);

			reader = IndexReader.open(directory);

			searcher = new IndexSearcher(reader);

			TopDocs topDocs = searcher.search(query, maxHits);

			Paginator paginator = new Paginator();

			ArrayLocation arrayLocation = paginator.calculateArrayLocation(topDocs.scoreDocs.length,
																								pageNumber,
																								pageSize);

			ScoreDoc[] hits = topDocs.scoreDocs;

			hitsFound = hits.length;

			if(hitsFound > 0){

				genericData = new LinkedList<Generic>();

				for (int i = arrayLocation.getStart() - 1; i < arrayLocation.getEnd(); i++) {

					String filepath = "";
					String filename = "";
					String title = "";
					String contents =  "";

					ScoreDoc scoreDoc = hits[i];

					float score = scoreDoc.score;

					int docId = hits[i].doc;

					Document document = searcher.doc(docId);

					String docCampus = document.get("campus");

					if(docCampus.equals("ALL") || docCampus.equals(campus)){

						filepath = document.get("filepath");
						filename = document.get("filename");
						title = document.get("title");
						contents =  document.get(SEARCH_FIELD);

						genericData.add(new Generic("" + (i),filename,title,contents,""+score,filepath,docCampus,"","",""));
					} // docCampus

				} // for i

			} // found documents

		}
		catch(IOException e){
			System.out.println("searchIndex.IOException: " + e.toString());
		}
		catch(Exception e){
			System.out.println("searchIndex.Exception: " + e.toString());
		}
		finally{
			if(searcher != null)
				searcher.close();

			if(reader != null)
				reader.close();

			if(directory != null)
				directory.close();
		}

		return genericData;

	}

	//--------------------------------------------
	// indexExist
	//--------------------------------------------
	private static double rounded(double d) {
		DecimalFormat twoDForm = new DecimalFormat("#.##");
		return Double.valueOf(twoDForm.format(d));
	}

	//--------------------------------------------
	// indexExist
	//--------------------------------------------
	private static boolean indexExist(){

		File directory = new File(FileIndexer.getIdx());

		if(0 < directory.listFiles().length){
			return true;
		}else{
			return false;
		}

	}

	//--------------------------------------------
	// indexFolder
	//--------------------------------------------
	public static void setIndexFolder(String _indexFolder){

		indexFolder = _indexFolder;

	}

	public static String getIndexFolder(){

		return indexFolder;

	}

	//--------------------------------------------
	// searchWord
	//--------------------------------------------
	public static void setSearchWord(String _searchWord){

		searchWord = _searchWord;

	}

	public static String getsearchWord(){

		return searchWord;

	}

	//--------------------------------------------
	// hitsFound
	//--------------------------------------------
	public static void setHitsFound(int _hitsFound){

		hitsFound = _hitsFound;

	}

	public static int getHitsFound(){

		return hitsFound;

	}

	//--------------------------------------------
	// pageSize
	//--------------------------------------------
	public static void setPageSize(int _pageSize){

		pageSize = _pageSize;

	}

	public static int getPageSize(){

		return pageSize;

	}

	//--------------------------------------------
	// pageNumber
	//--------------------------------------------
	public static void setPageNumber(int _pageNumber){

		pageNumber = _pageNumber;

	}

	public static int getPageNumber(){

		return pageNumber;

	}

	//--------------------------------------------
	// maxHits
	//--------------------------------------------
	public static void setMaxHits(int _maxHits){

		maxHits = _maxHits;

	}

	public static int getMaxHits(){

		return maxHits;

	}

	//--------------------------------------------
	// debug
	//--------------------------------------------
	public static void setDebug(boolean _debug){

		debug = _debug;

	}

	public static boolean getDebug(){

		return debug;

	}

	//--------------------------------------------
	// campus
	//--------------------------------------------
	public static void setCampus(String _campus){

		campus = _campus;

	}

	public static String getCampus(){

		return campus;

	}

	/**
	 * searchTerm
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchTerm(String _searchWord) throws IOException, ParseException {

		Term term = new Term(SEARCH_FIELD,_searchWord);
		Query query = new TermQuery(term);
		return searchIndex(query);

	}

	/**
	 * searchBoolean
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchBoolean(String _searchWord) throws IOException, ParseException {

		BooleanQuery query = new BooleanQuery();

		String[] words = _searchWord.replace(" ",",").split(",");

		for(int i=0; i<words.length; i++){
			Query q = new TermQuery(new Term(SEARCH_FIELD, words[i]));
			query.add(q,BooleanClause.Occur.MUST);
		}

		return searchIndex(query);

	}

	/**
	 * searchPrefix
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchPrefix(String _searchWord) throws IOException, ParseException {

		PrefixQuery query = new PrefixQuery(new Term(SEARCH_FIELD,_searchWord));
		return searchIndex(query);

	}

	/**
	 * searchPhrase
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchPhrase(String _searchWord) throws IOException, ParseException {

		PhraseQuery query = new PhraseQuery();

		// number of words allowed between phrase words
		// 0 means exact match
		query.setSlop(1);

		String[] words = _searchWord.replace(" ",",").split(",");

		for(int i=0; i<words.length; i++){
			query.add(new Term(SEARCH_FIELD,words[i]));
		}

		return searchIndex(query);

	}

	/**
	 * searchWildCard
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchWildCard(String _searchWord) throws IOException, ParseException {

		Query query = new WildcardQuery(new Term(SEARCH_FIELD,_searchWord+"*"));
		return searchIndex(query);

	}

	/**
	 * searchFuzzy
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchFuzzy(String _searchWord) throws IOException, ParseException {

		Query query = new FuzzyQuery(new Term(SEARCH_FIELD, _searchWord));
		return searchIndex(query);

	}

	/**
	 * searchText
	 * @param 	_searchWord
	 * @return	List<Generic>
	 *
	 * @throws IOException, ParseException
	 */
	public static List<Generic> searchText(String _searchWord) throws IOException, ParseException {

		return searchIndex(_searchWord);

	}

	//--------------------------------------------
	// toString
	//--------------------------------------------
	public String toString(){

		return
			"index: " + indexFolder + "\n" +
			"searchWord: " + searchWord + "\n" +
			"hitsFound: " + hitsFound + "\n" +
			"pageSize: " + pageSize + "\n" +
			"pageNumber: " + pageNumber + "\n" +
			"maxHits: " + maxHits + "\n" +
			"campus: " + campus + "\n" +
			"";
	}

	//--------------------------------------------
	//
	//--------------------------------------------
	public static void main(String[] args) throws Exception {

		SearchEngine searchEngine = new SearchEngine();

		boolean runAll = true;

		String searchWord = "technical matters";

		//
		// term query
		//
		if(runAll){
			searchTerm(searchWord);
			System.out.println("------------------------------ Term - " + hitsFound);

			searchBoolean(searchWord);
			System.out.println("------------------------------ Boolean - " + hitsFound);

			searchPrefix(searchWord);
			System.out.println("------------------------------ Prefix - " + hitsFound);

			searchPhrase(searchWord);
			System.out.println("------------------------------ Phrase - " + hitsFound);

			// wild card includes ?, *
			searchWildCard("chick*");
			System.out.println("------------------------------ WildCard - " + hitsFound);

			// wild card includes ~
			searchFuzzy("chick~");
			System.out.println("------------------------------ Fuzzy - " + hitsFound);

			searchEngine.searchIndex(searchWord);
			System.out.println("------------------------------ Text - " + hitsFound);
		}
		else{
			searchBoolean("batter");
		}

	}

}


