/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang

 this section is different than the ASP version

 001) Fix_001: remove sort and order by in navigation
 002) Fix_002: navigation and paging is now in a single table
 003) Fix_003: remove use of up/down images for sorting
 004) Fix_004: include wasNull and null checking of dates
 005) Fix_005: after search, lost last column

 TODO:
 001)	--moving page to page should leave pages to link to on the right and left
 002)	--when switch pages, the order by column name is still in session and may not exist
 			in the new page causing the page to error out because order by is wrong
 003)	--when records per page is same as total records, input field disappears
 004)	--add search fields to top of table
 005)	--when no records found, everything is gone. should at least show empty table.
 006)	--preserve search values when sorting after executing a search
 007)	when no data found and paging detail is available, there's no way to add new
 008)	master-detail
 009)	--hide key field (hideKey)
 010)	when key field is hidden, allowing search fields causes problem
 011)	--additional keys in detail string causes problem (linkedKey)
 012)	--adding OnClick link for HREF
 013)	--allow user defined URL key field parameter name other that lid (urlKeyName)
 014)	--added column height
 015)	--added column width (autoColumnWidth and columnWidth)
 016)	--class color (tableColorClass)
 017)	--links for navigation is white/gray so that it shows through campus colors
 018)	use website request
 019)	--add alpha index (alphaIndex and showAlphaIndex)
 020)	add first column for extra links (image to other task - linkedColumn,useLink)
 021)	--add printer friendly
 022)	--extra linked images (see #20)
 */

package com.ase.paging;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.Constant;
import com.ase.aseutil.Encrypter;
import com.ase.aseutil.WebSite;

public class Paging {

	//
	// these are the values to use should we not have valid data
	//
	static Logger logger = Logger.getLogger(Paging.class.getName());

	private String DEFAULT_templateHeader;
	private String DEFAULT_templateSearch;
	private String DEFAULT_template;
	private String DEFAULT_templateFooter;
	private String DEFAULT_templateNavigation;
	private String DEFAULT_tableBorder;
	private String DEFAULT_tableWidth;
	private String DEFAULT_tableRowtableColorClass;

	//
	// member variables
	//
	private String template;
	private String templateHeader;
	private String templateFooter;
	private String templateNavigation;
	private String tableRowtableColorClass;
	private String tableWidth;
	private boolean tableBorder;
	private String tableColorClass;

	/**
	 * different color themes. why not?
	 */
	private int startColumn = 1;
	private int theme;
	private int themeMin = 0;
	private int themeMax = 3;
	private String[] themetableColorClasss;
	private String[] themeHighlightColors;

	/**
	 * master and detail display SQL
	 */
	private String masterSQL;
	private String detailSQL;

	/**
	 * when not null, there is a detail record to display so create link
	 */
	private String detailLink;
	private String linkedKey;
	private String scriptName;
	private String sortOrder;
	private String orderBy;
	private String exportPath;
	private boolean navigation;
	private int recordsPerPage;
	private int currentPage;
	private int numberOfColumns;
	private int columnHeight;
	private int recordCount;
	private int pageCount;
	private boolean debug;
	private int alphaIndex;
	private boolean showAlphaIndex;
	private boolean showPrinterFriendly;

	/**
	 * use a URL name other than LID
	 */
	private String urlKeyName;

	/**
	 * Whether or not to enable search fields. Default is false
	 */
	private boolean search;

	/**
	 * Whether or not to display the key field (first column)
	 */
	private boolean hideKey;

	/**
	 * Default template for displaying search fields
	 */
	private String templateSearch;

	/**
	 * Field containing values combined for where clause
	 */
	private String searchWhere;

	/**
	 * Hidden field on search form containing the database column names of the
	 * search fields. Because of program flow, we don't know the column names
	 * prior to formulating the SQL statement. formulateSQL() runs before the
	 * ResultSet is availble.
	 * <p>
	 * We could have easily connected to the ResultSet to obtain the column but
	 * that would be doing multiple reads on each call.
	 */
	private String searchFields = "";

	/**
	 * Search input values. These values are entered by the user when search is
	 * enabled. The fields are held and then displayed in search fields to
	 * retain from page to page.
	 */
	private String[] searchInputValues;

	/**
	 * Hidden field on search form containing the database column type of the
	 * search fields.
	 */
	private String searchFieldTypes;

	/**
	 * Hidden field on search form containing values entered for searches
	 */
	private String searchFieldValues;

	/**
	 * Whether or not to enable sorting. Default is true.
	 */
	private boolean sorting;

	/**
	 * Whether or not to show trace of program flow
	 */
	private boolean showTrace;

	/**
	 * Whether or not to allow additions
	 */
	private boolean allowAdd;

	/**
	 * Whether or not to format output columns
	 */
	private String[] formatColumns;

	/**
	 * Column names for sorting
	 */
	private String[] sortColumns;

	/**
	 * Whether or not to sum output columns
	 */
	private String[] sumColumns;

	/**
	 * The type of displayed data
	 */
	private String[] columnDataType;

	/**
	 * column width
	 */
	private String[] columnWidth;

	private String tableColumnWidth;

	/**
	 * whether paging should create column width
	 */
	private boolean autoColumnWidth;

	/**
	 * How to Align columns (left, right, center)
	 */
	private String[] columnAlignStyle;

	/**
	 * Whether or not to format output columns
	 */
	private String[] arrSumColumns;
	private String oddRowColor;
	private String evenRowColor;

	/**
	 * Current cursor position value
	 */
	private int relativeRecord;

	/**
	 * How to Align table cell data (left, center, right). Numbers and dates are
	 * right Align. Text is left.
	 */
	private boolean AlignTableCell;

	/**
	 * first column to provide link to additional functions
	 *	image name, alt text, page to link to, key name, 1/0 for new window
	 */
	private String[] linkedColumn = null;
	private String[] linkedColumn1 = null;
	private String[] linkedColumn2 = null;
	private boolean useLink;

	final int LINKED_IMAGE 		= 0;
	final int LINKED_ALTTEXT 	= 1;
	final int LINKED_PAGE 		= 2;
	final int LINKED_KEY 		= 3;
	final int LINKED_NEWWINDOW = 4;

	/**
	 * A string representing an onClick ID to display data.
	 */
	private String onClick;

	/**
	 * HttpServletRequest is necessary to obtain request object data used in
	 * paging class.
	 */
	private HttpServletRequest request;
	private HttpServletResponse response;

	private com.ase.aseutil.AseUtil aseUtil;

	public void init() throws ServletException {}

	public void destroy() {}

	/**
	 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
	 * You may not modify, use, reproduce, or distribute this software except in
	 * compliance with the terms of the License made with Applied Software
	 * Engineernig.
	 * <p>
	 * $Id: Paging.java,v 1.00 2007/07/15 23:32:30 ttgiang Exp $
	 * <p>
	 * Paging class constructor. Sets up how table, rows, columns are rendered.
	 * Most important is the key filed must be the first field in the select
	 * statement.
	 */
	public Paging() throws IOException, ServletException {

		DEFAULT_templateSearch = "<| row |>";
		DEFAULT_templateHeader = "<| row |>";
		DEFAULT_template = "<| row |>";
		DEFAULT_templateFooter = "</table>";
		DEFAULT_templateNavigation = "<table id=\'asePager\' class=\'<| borderColor |>\' border=\'0\' cellspacing=\'0\' cellpadding=\'0\' width=\'98%\'> "
				+ "<tr class=\'<| borderColor |>\'> "
				+ "<td width=\'70%\'><| navigation |></td> "
				+ "<td width=\'30%\' align=\'right\'><| records |></td> "
				+ "</tr>\n<tr  class=\'<| borderColor |>\' ><td colspan=\'2\'><| pages |></td></tr>\n</table>\n";
		DEFAULT_tableBorder = "class=\'<| borderColor |>\'";
		DEFAULT_tableRowtableColorClass = "#3d84cc";
		DEFAULT_tableWidth = "100%";

		// defaults for data replacement
		templateSearch = "";
		templateHeader = "";
		template = "";
		templateFooter = "";
		templateNavigation = "";
		;
		tableWidth = "";
		tableBorder = true;
		tableRowtableColorClass = DEFAULT_tableRowtableColorClass;
		theme = -1;

		numberOfColumns = 0;
		recordsPerPage = 10;
		columnHeight = 24;

		currentPage = 1;
		recordCount = 0;
		pageCount = 0;
		sortOrder = "";
		orderBy = "";
		detailLink = "";
		exportPath = "";
		scriptName = "";
		masterSQL = "";
		detailSQL = "";
		relativeRecord = 0;
		alphaIndex = -1;
		showAlphaIndex = false;
		showPrinterFriendly = false;

		// default is navigation is on
		navigation = true;

		// alternating row colors
		oddRowColor = "#FFFFFF";
		evenRowColor = "#e5f1f4";

		// for table column display, how should data be Aligned
		AlignTableCell = false;

		debug = false;
		sorting = true;
		search = false;
		searchWhere = "";
		searchFields = "";
		searchFieldTypes = "";
		searchFieldValues = "";

		// not yet implemented. intent is for tracing program flow.
		showTrace = false;

		// by default, we don't allow add
		allowAdd = false;

		// by default, we hide key
		hideKey = true;

		// linkedKey is key used for modifying detail screen.
		linkedKey = "";

		// onClick is default to blank
		onClick = "";

		// default URL key name is lid
		urlKeyName = "lid";

		// by default, with is auto set
		autoColumnWidth = true;

		tableColumnWidth = "";

		/*
			first linked column comes in the following format:

			image name, alt text, page to link to, key name, 1/0 for new window

			ie: paging.setLinkedColumn("viewcourse.gif,view syllabus,syly.jsp,sid,1");
		*/
		useLink = false;

		aseUtil = new com.ase.aseutil.AseUtil();

		setSessionTheme();
	}

	/**
	 * Whether or not to enable auto column width
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setTableColumnWidth(String arg) {
		tableColumnWidth = arg;
	}

	public String getTableColumnWidth() {
		return tableColumnWidth;
	}

	/**
	 * Whether or not to enable auto column width
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setAutoColumnWidth(boolean arg) {
		autoColumnWidth = arg;
	}

	public boolean isAutoColumnWidth() {
		return autoColumnWidth;
	}

	/**
	 * Whether or not to enable search fields
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is false)
	 */
	public void setSearch(boolean arg) {
		search = arg;
	}

	public boolean isSearch() {
		return search;
	}

	/**
	 * Whether or not to hide the key field (first column)
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setHideKey(boolean arg) {
		hideKey = arg;
	}

	public boolean isHideKey() {
		return hideKey;
	}

	/**
	 * Whether or not to enable column sorting
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setSorting(boolean arg) {
		sorting = arg;
	}

	public boolean isSorting() {
		return sorting;
	}

	/**
	 * @param arg
	 *            true or false (default is false)
	 */
	public void setShowTrace(boolean arg) {
		showTrace = arg;
	}

	public boolean isShowTrace() {
		return showTrace;
	}

	/**
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setAllowAdd(boolean arg) {
		allowAdd = arg;
	}

	public boolean isAllowAdd() {
		return allowAdd;
	}

	/**
	 * @param arg
	 *            Color themes (0-1)
	 */
	public void setTheme(int arg) {

		theme = arg;

		if (theme >= themeMin && theme <= themeMax) {
			tableRowtableColorClass = themetableColorClasss[theme];
			evenRowColor = themeHighlightColors[theme];
		} else {
			tableRowtableColorClass = themetableColorClasss[0];
			evenRowColor = themeHighlightColors[0];
		}
	}

	public int getTheme() {
		return theme;
	}

	/**
	 * @param arg
	 *            Number of records available in the resultset
	 */
	public void setRecordCount(int arg) {

		// don't allow negative numbers
		if (arg < 1)
			arg = 1;

		recordCount = arg;
	}

	public int getRecordCount() {
		return recordCount;
	}

	/**
	 * Page count refers to the number of pages available from the resultset. A
	 * page consists of the number of records per page. Number of pages is the
	 * total record count (recordCount) divided by the number of records per
	 * page (recordsPerPage).
	 * <p>
	 *
	 * @param arg
	 *            Number of pages available in the resultset.
	 */
	public void setPageCount(int arg) {

		// don't allow negative numbers
		if (arg < 1)
			arg = 1;

		pageCount = arg;
	}

	public int getPageCount() {
		return pageCount;
	}

	/**
	 * The page that is currently displayed. This value exists as links jump
	 * from page to page. See page determination in setPageCount.
	 * <p>
	 *
	 * @param arg
	 *            Number of pages available in the resultset.
	 */
	public void setCurrentPage(int arg) {

		// don't allow negative numbers
		if (arg < 1)
			arg = 1;

		currentPage = arg;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	/**
	 * The alpha index to show
	 * <p>
	 *
	 * @param arg	the integer representing the alpha
	 */
	public void setAlphaIndex(int arg) {
		if (arg<65 || arg >90)
			arg = -1;

		alphaIndex = arg;
	}

	public int getAlphaIndex() {
		return alphaIndex;
	}

	/**
	 * Determines whether or not to show index
	 * <p>
	 *
	 * @param arg true or false
	 */
	public void setShowAlphaIndex(boolean arg) {
		showAlphaIndex = arg;
	}

	public boolean isShowAlphaIndex() {
		return showAlphaIndex;
	}

	/**
	 * Determines whether or not to show printer friendly
	 * <p>
	 *
	 * @param arg true or false
	 */
	public void setShowPrinterFriendly(boolean arg) {
		showPrinterFriendly = arg;
	}

	public boolean isShowPrinterFriendly() {
		return showPrinterFriendly;
	}

	/**
	 * @param arg
	 * SQL for data retrieval/display
	 */
	public void setLinkedColumn(String arg) {
		if (!"".equals(arg)){
			useLink = true;
			linkedColumn = arg.split(",");
			if (linkedColumn != null && linkedColumn.length != 5){
				useLink = false;
				linkedColumn = null;
			}
			//linkedColumn = new String[5];
		}
	}

	public String[] getLinkedColumn() {
		return linkedColumn;
	}

	/**
	 * @param arg
	 * SQL for data retrieval/display
	 */
	public void setLinkedColumn1(String arg) {
		if (!"".equals(arg) && useLink){
			linkedColumn1 = arg.split(",");
			if (linkedColumn1 != null && linkedColumn1.length != 5){
				linkedColumn1 = null;
			}
		}
	}

	public String[] getLinkedColumn1() {
		return linkedColumn1;
	}

	/**
	 * @param arg
	 * SQL for data retrieval/display
	 */
	public void setLinkedColumn2(String arg) {
		if (!"".equals(arg) && useLink){
			linkedColumn2 = arg.split(",");
			if (linkedColumn2 != null && linkedColumn2.length != 5){
				linkedColumn2 = null;
			}
		}
	}

	public String[] getLinkedColumn2() {
		return linkedColumn2;
	}

	/**
	 * @param arg
	 *            SQL for data retrieval/display
	 */
	public void setMasterSQL(String arg) {
		masterSQL = arg;
	}

	public String getMasterSQL() {
		return masterSQL;
	}

	public void setSQL(String arg) {
		setMasterSQL(arg);
	}

	public String getSQL() {
		return masterSQL;
	}

	/**
	 * @param arg
	 */
	public void setUrlKeyName(String arg) {
		urlKeyName = arg;
	}

	public String getUrlKeyName() {
		return urlKeyName;
	}

	/**
	 * @param arg
	 */
	public void setOnClick(String arg) {
		onClick = arg;
	}

	public String getOnClick() {
		return onClick;
	}

	/**
	 * @param arg
	 *            SQL for data retrieval/display
	 */
	public void setDetailSQL(String arg) {
		detailSQL = arg;
	}

	public String getDetailSQL() {
		return detailSQL;
	}

	/**
	 * Detail refers to the page that is linked to from the paging page. This
	 * page is normally tied to a key returned from the resultset.
	 * <p>
	 *
	 * @param arg
	 *            Formatted URL
	 */
	public void setDetailLink(String arg) {
		detailLink = arg;

		// when detail linking is available, make sure to
		// create linked page properly. If no key and just
		// a page is sent in, then the URL argument starts
		// with a question mark. However, if an argument
		// is provided along with the linked page, then
		// a question mark is there. So, in linking the key
		// field, start with apersand.
		if (detailLink != null) {
			if (detailLink.indexOf("?") > 0)
				linkedKey = "&";
			else
				linkedKey = "?";
		}
	}

	public String getDetailLink() {
		return detailLink;
	}

	/**
	 * Detail column height
	 * <p>
	 *
	 * @param arg
	 *            column height.
	 */
	public void setColumnHeight(int arg) {
		columnHeight = arg;
	}

	public int getColumnHeight() {
		return columnHeight;
	}

	/**
	 * Number of records to display per page.
	 * <p>
	 *
	 * @param arg
	 *            Number of records to display per page.
	 */
	public void setRecordsPerPage(int arg) {
		recordsPerPage = arg;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	/**
	 * Number of columns in resulting table. When provided, the library will
	 * only render so many columns. When not available, the library will display
	 * the number of columns from the SQL statement.
	 * <p>
	 *
	 * @param arg
	 *            Number of columns to display.
	 */
	public void setNumberOfColumns(int arg) {

		// don't allow negative numbers
		if (arg < 1)
			arg = 1;

		numberOfColumns = arg;
	}

	public int getNumberOfColumns() {
		return numberOfColumns;
	}

	/**
	 * String consisting of table row (TR) and table columns (TD) for how the
	 * data is displayed. There should only be 1 TR and as many TDs as required
	 * by the SQL SELECT statement.
	 * <p>
	 * When not provided, the number of TDs is determined by the number of
	 * columns to display (based on the SQL SELECT).
	 * <p>
	 *
	 * @param arg
	 *            String of table row for output.
	 */
	public void setTemplate(String arg) {
		template = arg;
	}

	public String getTemplate() {
		return template;
	}

	/**
	 * The closing tag for the displayed table (</table>).
	 * <p>
	 *
	 * @param arg
	 *            HTML String
	 */
	public void setTemplateFooter(String arg) {
		templateFooter = arg;
	}

	public String getTemplateFooter() {
		return templateFooter;
	}

	/**
	 * HTML string containing how navigation should be displayed. The current
	 * systax consists of a table row with two columns. The first column
	 * contains the linked pages (1, 2, 3, ...), and the second column (right
	 * Aligned) contains a form field for the number of records to display per
	 * page.
	 * <p>
	 *
	 * @param arg
	 *            HTML String
	 */
	public void setTemplateNavigation(String arg) {
		templateNavigation = arg;
	}

	public String getTemplateNavigation() {
		return templateNavigation;
	}

	/**
	 * HTML string containing the top row of the displayed table. This is the
	 * header row. If nothing is provided, the system displays in the header row
	 * the column names retrieved from the SQL SELECT.
	 * <p>
	 *
	 * @param arg
	 *            HTML String
	 */
	public void setTemplateHeader(String arg) {
		templateHeader = arg;
	}

	public String getTemplateHeader() {
		return templateHeader;
	}

	/**
	 * Sorting order of ASC or DESC
	 * <p>
	 *
	 * @param arg
	 *            ASC or DESC
	 */
	public void setSortOrder(String arg) {
		sortOrder = arg;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	/**
	 * Script or pagename to link to
	 * <p>
	 *
	 * @param arg
	 *            String
	 */
	public void setScriptName(String arg) {
		scriptName = arg;
	}

	public String getScriptName() {
		return scriptName;
	}

	/**
	 * The column to sort the resultset by.
	 * <p>
	 *
	 * @param arg
	 *            table column name
	 */
	public void setOrderBy(String arg) {
		orderBy = arg;
	}

	public String getOrderBy() {
		return orderBy;
	}

	/**
	 * Determines whether page navigation is enabled.
	 * <p>
	 *
	 * @param arg
	 *            true or false
	 */
	public void setNavigation(boolean arg) {
		navigation = arg;
	}

	public boolean isNavigation() {
		return navigation;
	}

	/**
	 * Sets formats for columns. Determine the sorting image appearance.
	 * getFormatColumnsX used for debugging purposes only.
	 * <p>
	 * In coming parameter should be a comma separated list of column names.
	 * <p>
	 *
	 * @param arg
	 *            String
	 */
	public void setFormatColumns(String arg) {
		if (arg != null && arg.length() > 0)
			formatColumns = arg.trim().split(",");
	}

	public String[] getFormatColumns() {
		return formatColumns;
	}

	public String getFormatColumnsX() {

		int i;
		String tempStr = "";

		if (formatColumns != null && formatColumns.length > 0) {
			for (i = 0; i < formatColumns.length; i++) {
				if (i == 0)
					tempStr = tempStr + formatColumns[i];
				else
					tempStr = tempStr + "," + formatColumns[i];
			}
		}

		return tempStr;
	}

	/**
	 * Sets formats for columns. Determine the sorting image appearance.
	 * getFormatColumnsX used for debugging purposes only.
	 * <p>
	 * In coming parameter should be a comma separated list of column names.
	 * <p>
	 *
	 * @param arg
	 *            String
	 */
	public void setSumColumns(String arg) {
		if (arg != null && arg.length() > 0)
			sumColumns = arg.trim().split(",");
	}

	public String[] getSumColumns() {
		return sumColumns;
	}

	public String getSumColumnsX() {

		int i;
		String tempStr = "";

		if (sumColumns != null && sumColumns.length > 0) {
			for (i = 0; i < sumColumns.length; i++) {
				if (i == 0)
					tempStr = tempStr + sumColumns[i];
				else
					tempStr = tempStr + "," + sumColumns[i];
			}
		}

		return tempStr;
	}

	/**
	 * Sets formats for columns. Determine the sorting image appearance.
	 * getFormatColumnsX used for debugging purposes only.
	 * <p>
	 * In coming parameter should be a comma separated list of column names.
	 * <p>
	 *
	 * @param arg
	 *            String
	 */
	public void setSortColumns(String arg) {
		if (arg != null && arg.length() > 0)
			sortColumns = arg.trim().split(",");
	}

	public String[] getSortColumns() {
		return sortColumns;
	}

	public String getSortColumnsX() {

		int i;
		String tempStr = "";

		if (sortColumns != null && sortColumns.length > 0) {
			for (i = 0; i < sortColumns.length; i++) {
				if (i == 0)
					tempStr = tempStr + sortColumns[i];
				else
					tempStr = tempStr + "," + sortColumns[i];
			}
		}

		return tempStr;
	}

	/**
	 * Holds the table cell data type getColumnDataTypeX used for debugging
	 * purposes only.
	 * <p>
	 */
	public String getColumnDataTypeX() {

		int i;
		String tempStr = "";

		if (columnDataType != null && columnDataType.length > 0) {
			for (i = 0; i < columnDataType.length; i++) {
				if (i == 0)
					tempStr = tempStr + columnDataType[i];
				else
					tempStr = tempStr + "," + columnDataType[i];
			}
		}

		return tempStr;
	}

	/**
	 * Holds the table cell data type Alignment getColumnAlignStyleX used for
	 * debugging purposes only.
	 * <p>
	 */
	public String getColumnAlignStyleX() {

		int i;
		String tempStr = "";

		if (columnAlignStyle != null && columnAlignStyle.length > 0) {
			for (i = 0; i < columnAlignStyle.length; i++) {
				if (i == 0)
					tempStr = tempStr + columnAlignStyle[i];
				else
					tempStr = tempStr + "," + columnAlignStyle[i];
			}
		}

		return tempStr;
	}

	/**
	 * Values entered in search fields. getSearchInputValuesX used for debugging
	 * purposes only.
	 * <p>
	 */
	public String getSearchInputValuesX() {

		int i;
		String tempStr = "";

		if (search) {
			if (searchInputValues != null && searchInputValues.length > 0) {
				for (i = 0; i < searchInputValues.length; i++) {
					if (i == 0)
						tempStr = tempStr + searchInputValues[i];
					else
						tempStr = tempStr + "," + searchInputValues[i];
				}
			}
		}

		return tempStr;
	}

	/**
	 * Sets the background color for a table row.
	 * <p>
	 *
	 * @param arg
	 *            Valid HTML color code
	 */
	public void setTableRowtableColorClass(String arg) {
		tableRowtableColorClass = arg;
	}

	public String getTableRowtableColorClass() {
		return tableRowtableColorClass;
	}

	/**
	 * Sets the table width, When '%' is present, the width is treated in terms
	 * of percentage; otherwise as pixels.
	 * <p>
	 *
	 * @param arg
	 *            Value representing desired table width
	 */
	public void setTableWidth(String arg) {
		tableWidth = arg;
	}

	public String getTableWidth() {
		return tableWidth;
	}

	/**
	 * Displays border around table.
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setTableBorder(boolean arg) {

		tableBorder = arg;

		// when false, blank out the default values
		if (!tableBorder)
			DEFAULT_tableBorder = "";
	}

	public boolean isTableBorder() {
		return tableBorder;
	}

	/**
	 * When enabled, display debugging values for member variables.
	 * <p>
	 *
	 * @param arg
	 *            true or false
	 */
	public void setDebug(boolean arg) {
		debug = arg;
	}

	public boolean isDebug() {
		return debug;
	}

	/**
	 * How should table cell data be Aligned.
	 * <p>
	 *
	 * @param arg
	 *            true or false
	 */
	public void setAlignTableCell(boolean arg) {
		AlignTableCell = arg;
	}

	public boolean isAlignTableCell() {
		return AlignTableCell;
	}

	/**
	 * Determine odd row color
	 * <p>
	 *
	 * @param arg
	 *            Valid HTML color code
	 */
	public void setOddRowColor(String arg) {
		oddRowColor = arg;
	}

	public String getOddRowColor() {
		return oddRowColor;
	}

	/**
	 * Determine even row color
	 * <p>
	 *
	 * @param arg
	 *            Valid HTML color code
	 */
	public void setEvenRowColor(String arg) {
		evenRowColor = arg;
	}

	public String getEvenRowColor() {
		return evenRowColor;
	}

	/**
	 * Set the theme for this session
	 */
	public void setSessionTheme() throws IOException, ServletException {

		// there are only 3 themes at this time
		themetableColorClasss = new String[themeMax + 1];
		themeHighlightColors = new String[themeMax + 1];

		String sBackground = "#33B6E8,#336699,#d2a41c,#e5f1f4";
		String sHighlight = "#e5f1f4,#eeeecc,#c3f3c3,#ececff";

		themetableColorClasss = sBackground.split(",");
		themeHighlightColors = sHighlight.split(",");
	}

	/**
	 * Obtain session data kept between paging pages. This is completed during
	 * intialization and overriden when individual values are sent in via calls
	 * to the clas.
	 */
	public void getSessionData() throws IOException, ServletException {

		int rpp = 0;
		int page = 0;
		int asePage = 1;
		int aseRecordsPerPage = 10;
		int i = 0;
		int j = 0;

		String aseURI = "";

		WebSite ws = new WebSite();

		HttpSession session = request.getSession(true);

		/**
		 * get the name of the page that we are on. this is used to wipe out the
		 * default sort id field when going from one page to another page
		 * (different name)
		 */
		String uri = request.getRequestURI();
		if (uri != null && uri.length() > 0) {
			// extract only the page name
			// uri = uri.substring( uri.lastIndexOf("/") + 1 );

			aseURI = ws.getRequestParameter(request,"aseURI","",true);
			if (aseURI != null && aseURI.equals(uri)) {
				session.setAttribute("aseCol", "");
				session.setAttribute("aseSrt", "");
				session.setAttribute("aseSearchFields", "");
				session.setAttribute("aseSearchFieldValues", "");
				session.setAttribute("aseSearchFieldTypes", "");
			}
			session.setAttribute("aseURI", uri);
		} else {
			session.setAttribute("aseURI", "");
		}
		scriptName = (String)session.getAttribute("aseURI");

		// when sorting is requested, the following wont' be null
		String aseCol = ws.getRequestParameter(request,"col","",false);

		setSearchData(session);

		/**
		 * what column to do sorting by
		 */
		if (aseCol != null && aseCol.length() > 0) {
			if ((String)session.getAttribute("aseCol") != null
					&& ((String) session.getAttribute("aseCol")).equals(aseCol)) {
				if (((String) session.getAttribute("aseSrt")).equals("ASC")) {
					session.setAttribute("aseSrt", "DESC");
				} else {
					session.setAttribute("aseSrt", "ASC");
				}
			} else {
				session.setAttribute("aseSrt", "ASC");
			}
			session.setAttribute("aseCol", aseCol);
		} else {
			aseCol = (String)session.getAttribute("aseCol");
			if (aseCol == null || aseCol.length() == 0) {
				aseCol = "";
				session.setAttribute("aseCol", aseCol);
				session.setAttribute("aseSrt", "");
			}
		}
		String aseSrt = (String)session.getAttribute("aseSrt");
		sortOrder = (String)session.getAttribute("aseSrt");
		orderBy = (String)session.getAttribute("aseCol");

		/**
		 * the page we are going to display
		 */
		page = ws.getRequestParameter(request,"page",0,false);
		if (page > 0)
			asePage = page;

		currentPage = asePage;

		/**
		 * how many records to show per page. If the records per page is not the
		 * same as the value in session, then we know that a different value was
		 * desired.
		 */
		rpp = ws.getRequestParameter(request,"rpp",0,false);
		aseRecordsPerPage = ws.getRequestParameter(request,"aseRecordsPerPage",0,true);
		if (rpp > 0)
			aseRecordsPerPage = rpp;

		if (aseRecordsPerPage==0)
			aseRecordsPerPage = 10;

		if (recordsPerPage != aseRecordsPerPage)
			aseRecordsPerPage = recordsPerPage;

		session.setAttribute("aseRecordsPerPage",new Integer(aseRecordsPerPage));

		recordsPerPage = aseRecordsPerPage;

		/**
		 * What table width to use
		 */
		String _tableWidth = "";
		if (tableWidth.equals("") || tableWidth == null) {
			if ((String)session.getAttribute("aseTableWidth") != null)
				_tableWidth = (String)session.getAttribute("aseTableWidth");
			else
				_tableWidth = DEFAULT_tableWidth;
		} else {
			if (!_tableWidth.equals(tableWidth))
				_tableWidth = tableWidth;
		}
		session.setAttribute("aseTableWidth", _tableWidth);
		setTableWidth(_tableWidth);

		/**
		 * what theme to use. when nothing provided (theme = -1), use 0; if
		 * something was provided and it's not the same as the value in the
		 * session, set the session and that's the new theme
		 */
		int _theme = ws.getRequestParameter(request,"aseTheme",0,true);;
		if (theme == -1) {
			_theme = _theme;
		} else {
			if (_theme != theme)
				_theme = theme;
		}
		session.setAttribute("aseTheme", new Integer(_theme));
		setTheme(_theme);

		setCampusColors(session);

		// check to see if data was provided for search field
		if (search) {
			// TODO
		}
	}

	public void setCampusColors(HttpSession session) {

		// color customization is now by campus
		try {
			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			tableColorClass = campus + "BGColor";

			/*
			 * String HAWCC = "#91004B"; String HILCC = "#D52B1E"; String HONCC =
			 * "#00747A"; String KAPCC = "#002395"; String KAUCC = "#7D5CC6";
			 * String LEECC = "#3D7EDB"; String MANCC = "#024731"; String MAUCC =
			 * "#005172"; String WESCC = "#A71930"; String WINCC = "#7AB800";
			 */
		} catch (Exception e) {
			logger.fatal(e.toString());
		}

	}

	/**
	 * When search is turned on, how to handle collecting data entered for
	 * searches. With form submissions, the search fields are available and
	 * therefore not a problem to collect and work with. However, when searching
	 * with data then clicking to sort or jump to pages, the values are no
	 * longer there.
	 * <p>
	 * This routine saves data in a session variables for later use. The values
	 * are only valid after the first search is executed successfully.
	 * Afterwards, clicking to sort or page is to use session values while form
	 * submissions will collect from the form and saved for future use.
	 * <p>
	 *
	 * @param session
	 *            HttpSession passed over from the getSessionData routine
	 */
	public void setSearchData(HttpSession session) throws IOException,ServletException {

		int i = 0;
		int j = 0;
		String aseSearchFields = "";
		String aseSearchFieldTypes = "";
		String str = "";
		int dataType = 0;
		PrintWriter out = response.getWriter();
		String temp = "";

		//System.out.println("-------------------------------- setSearchData - IN");

		searchFieldValues = "";

		// construct where clause. We don't have the number of columns at this
		// point.
		// The call to the resultset doesn't happen until after this routine
		// that's why we had the hidden field on the form.
		// when in for the first time, it's likely that we won't have srch or
		// aseSearchFields.
		if (search) {

			// if this was a form submission, the hidden value will be available
			// if not, it might have been saved to the session
			if (request.getParameter("aseSearchFields") != null) {
				aseSearchFields = request.getParameter("aseSearchFields");
				aseSearchFieldTypes = request.getParameter("aseSearchFieldTypes");
				searchFieldValues = request.getParameter("aseSearchFieldValues");
				//System.out.println("form submission");
			} else {
				if ((String)session.getAttribute("aseSearchFields") != null) {
					aseSearchFields = (String)session.getAttribute("aseSearchFields");
					aseSearchFieldTypes = (String)session.getAttribute("aseSearchFieldTypes");
					//System.out.println("session data");
					searchFieldValues = (String)session.getAttribute("aseSearchFieldValues");
				}
			}

			//System.out.println("aseSearchFields: " + aseSearchFields);
			//System.out.println("aseSearchFieldTypes: " + aseSearchFieldTypes);
			//System.out.println("searchFieldValues: " + searchFieldValues);

			// either from form fields or sessions. If not, error
			if (aseSearchFields != null && aseSearchFields.length() > 0) {

				session.setAttribute("aseSearchFields", aseSearchFields);
				session.setAttribute("aseSearchFieldTypes",aseSearchFieldTypes);

				searchWhere = "";
				numberOfColumns = 0;

				/*
				 * number of columns not known till after the SQL statement
				 * executes. however, that's done after this stuff. determine
				 * number of columns based on hidden fields extra comma is to
				 * make sure that the last value is counted
				 */
				temp = aseSearchFields + ",";
				i = temp.indexOf(",");
				while (i > -1) {
					i = temp.indexOf(",", i + 1);
					++j;
				}
				// add 1 for the hidden column
				numberOfColumns = ++j;

				// knowing the number of columns, allocate array
				searchInputValues = new String[numberOfColumns];
				String sFields[] = new String[numberOfColumns];
				String sFieldTypes[] = new String[numberOfColumns];
				String sFieldValues[] = new String[numberOfColumns];

				sFields = aseSearchFields.trim().split(",");
				sFieldTypes = aseSearchFieldTypes.trim().split(",");

				// searchFieldValues is like a CSV. There's a comma after each input
				// searched field. When no values are there, the comma remains.
				// The split function doesn't handle the split properly. It only
				// splits up to a valid value. All trailing commas are ignored.
				// IE: searchFieldValues = ",,,,giang,thanh,,,"
				// the split function includes only up to thanh or the 6th value.
				// the other 3 values (trailing commas) are ignored causing the
				// array length to be smaller then the actual number of fields
				// available. By adding a space to the end, all values are collected
				// properly for a split. Note that there is no trim in the pending split.
				if (searchFieldValues.lastIndexOf(",") < searchFieldValues.length())
					searchFieldValues = searchFieldValues + " ";

				sFieldValues = searchFieldValues.split(",");

				// cycle through array and put where clause together
				// searchInputValues saved for later use
				for (j = 0; j < sFields.length; j++) {
					searchInputValues[j] = "";

					// when in sort or paging mode, take the search values from
					// session data otherwise take it from form fields
					if (request.getParameter("ase_" + sFields[j]) != null)
						str = request.getParameter("ase_" + sFields[j]);
					else
						str = sFieldValues[j].trim();

					if (str != null && str.length() > 0) {
						searchInputValues[j] = str;
						// depending on the data type, toWhereSQLX will append quotes or not
						if (sFieldTypes[j].toLowerCase().indexOf("char") > -1)
							dataType = 1;
						else if (sFieldTypes[j].toLowerCase().indexOf("date") > -1)
							dataType = 2;
						else
							dataType = 3;

						if (!searchWhere.equals(""))
							searchWhere = searchWhere + " AND ";

						searchWhere = searchWhere + aseUtil.toWhereSQLX(sFields[j], str, dataType);

						//System.out.println(searchWhere);

					} // if str
				} // for

				// save the search values for use when creating the form. The
				// values are placed in the field they belong to.
				for (j=0; j<sFields.length; j++) {
					if (j == 0)
						searchFieldValues = searchInputValues[j];
					else
						searchFieldValues = searchFieldValues + "," + searchInputValues[j];
				}
				session.setAttribute("aseSearchFieldValues", searchFieldValues);
			} // if aseSearchFields ! = null

		} // if search

		//System.out.println("-------------------------------- setSearchData - OUT");

	}

	/**
	 * Some defaults to get rolling.
	 * <p>
	 *
	 * @param rs
	 *            resultset data to work with
	 */
	public void _initialize(ResultSet rs) throws ServletException, SQLException {

		ResultSetMetaData rsmd = rs.getMetaData();

		// determine the number of columns returned
		if (numberOfColumns == 0)
			numberOfColumns = rsmd.getColumnCount();

		_initializeArrays(rsmd);
		_initializeColumnAlignment();
		_initializeOutputTemplates();

		// do not allow records per page to be greater than total record count
		if (recordsPerPage > recordCount)
			recordsPerPage = recordCount;
	}

	/**
	 * Initialize all arrays for program user
	 */
	public void _initializeArrays(ResultSetMetaData rsmd)
			throws ServletException, SQLException {

		int i;
		int textColumns = 0;

		// knowing the number of columns gets us our array count

		// column formatting
		if (formatColumns == null) {
			formatColumns = new String[numberOfColumns];
			for (i = 0; i < numberOfColumns; i++)
				formatColumns[i] = "";
		}

		// whether summation is required
		if (sumColumns == null) {
			sumColumns = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++)
				sumColumns[i] = "";
		}

		// sum to here
		if (arrSumColumns == null) {
			arrSumColumns = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++)
				arrSumColumns[i] = "";
		}

		// column name for sorting
		if (sortColumns == null) {
			sortColumns = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++)
				sortColumns[i] = rsmd.getColumnLabel(i + 1);
		}

		// column data type. while here, save the column type to determine
		// column width. width for numbers, dates and char < 30 is 15%.
		// larger columns should be a matter of what's left after all
		// other columns have been figured out.
		if (columnDataType == null) {
			columnDataType = new String[numberOfColumns];
			columnWidth = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++) {
				columnDataType[i] = rsmd.getColumnTypeName(i + 1);
				columnWidth[i] = "N";
				if (columnDataType[i].toUpperCase().indexOf("TEXT") >= 0
						|| columnDataType[i].toUpperCase().indexOf("VARCHAR") >= 0) {
					if (rsmd.getColumnDisplaySize(i + 1) > 50) {
						columnWidth[i] = "T";
						textColumns++;
					} else
						columnWidth[i] = "N";
				}
			}
		}

		// column Alignment style
		if (columnAlignStyle == null) {
			columnAlignStyle = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++)
				columnAlignStyle[i] = "";
		}

		// if user define column width is made available, use it first
		// the first column of the supplied list should be a 0 since
		// we don't display the first column
		String[] aTableColumnWidth = null;
		if (tableColumnWidth != null && tableColumnWidth.length() > 0){
			aTableColumnWidth = tableColumnWidth.split(",");
			for (i = startColumn; i < numberOfColumns; i++)
				columnWidth[i] = aTableColumnWidth[i] + "%";
		}
		else{
			// column width is based on text, and numeric
			// take total columns, give 12% to each numeric and remainder to text.
			if (textColumns > 0 && isAutoColumnWidth()) {
				int numberColumns = 100 - ((numberOfColumns - textColumns) * 12);
				numberColumns = (int) numberColumns / textColumns;
				for (i = startColumn; i < numberOfColumns; i++) {
					if ("N".equals(columnWidth[i]))
						columnWidth[i] = "12%";
					else
						columnWidth[i] = numberColumns + "%";
				}
			}
		}

	}

	/**
	 * Initialize how column output are aligned
	 */
	public void _initializeColumnAlignment() throws ServletException,SQLException {

		int i;
		String dataType = "";
		String findString = "integerdatetimedecimaldouble";

		/*
			retrieve metadata for column data type to determine
			how to Align data. Numbers are right, and text are left

			if the addition of the indexOf returns > 0, we found something
		*/
		if (AlignTableCell) {
			columnAlignStyle = new String[numberOfColumns];
			for (i = startColumn; i < numberOfColumns; i++) {
				columnAlignStyle[i] = "left";
				dataType = columnDataType[i].toLowerCase();
				if (findString.indexOf(dataType) >= 0)
					columnAlignStyle[i] = "right";
			}
		}
	}

	/**
	 * Initialize templates used to render data
	 */
	public void _initializeOutputTemplates() throws ServletException {

		int i;
		String tempStr = "";
		String ase = "";
		String strTemp;
		String target = "";

		// set up the navigation
		// if table border is requested and the color is provided, use them; if
		// not use the default
		if (tableBorder) {
			if (tableRowtableColorClass != null
					&& tableRowtableColorClass.length() > 0) {
				DEFAULT_templateNavigation = DEFAULT_templateNavigation.replace("<| borderColor |>", tableColorClass);
				DEFAULT_tableBorder = DEFAULT_tableBorder.replace("<| borderColor |>", tableColorClass);
			} else {
				DEFAULT_templateNavigation = DEFAULT_templateNavigation.replace("<| borderColor |>",DEFAULT_tableRowtableColorClass);
				DEFAULT_tableBorder = DEFAULT_tableBorder.replace("<| borderColor |>", DEFAULT_tableRowtableColorClass);
			}
		} else {
			DEFAULT_templateNavigation = DEFAULT_templateNavigation.replace("<| borderColor |>", "#ffffff");
			DEFAULT_tableBorder = DEFAULT_tableBorder.replace("<| borderColor |>", "#ffffff");
		}

		templateNavigation = DEFAULT_templateNavigation;

		// draw out search fields
		templateSearch = "";
		ase = "";
		if (search) {
			// when here for the first time, it's likely that no search values
			// were typed in.
			// if so, initialize to empty array
			if (searchInputValues == null) {
				searchInputValues = new String[numberOfColumns];
				for (i = startColumn; i < numberOfColumns; i++) {
					searchInputValues[i] = "";
				}
			}

			// use template to replace
			templateSearch = DEFAULT_templateSearch;
			searchFieldValues = "";

			// this extra column is to accommodate the addition of a detail line
			if (detailSQL != null && detailSQL.length() > 0)
				ase = "<td>&nbsp;</td>";

			searchFields = "";
			searchFieldTypes = "";

			for (i = startColumn; i < numberOfColumns; i++) {
				// save these in hidden form field for used with formulating the
				// SQL where statement
				if (searchFields.equals("")) {
					searchFields = sortColumns[i];
					searchFieldTypes = columnDataType[i];
				} else {
					searchFields = searchFields + "," + sortColumns[i];
					searchFieldTypes = searchFieldTypes + "," + columnDataType[i];
				}

				// save these values for use on form as hidden field
				if (i == 0)
					searchFieldValues = searchInputValues[i];
				else
					searchFieldValues = searchFieldValues + "," + searchInputValues[i];

				/*
				 * searchInputValues does not contain the first column used for
				 * detail screen. i-1 because the values start at 0 as compared
				 * to i=startColumn which is 1
				 */
				ase = ase
						+ "<td><input class=\'input\' type=\'text\' name=\'ase_"
						+ sortColumns[i] + "\' value=\'"
						+ aseUtil.nullToBlank(searchInputValues[i - 1])
						+ "\' size=\'10\'>";

				// on the last column, include the hidden form fields and submit
				// button. doing
				// this to keep the fields in the same table cell as the last
				// one.
				if (i == numberOfColumns - 1) {
					ase = ase
							+ "<input type=\'hidden\' name=\'aseSearchFields\' value=\'"
							+ searchFields
							+ "\'>"
							+ "<input type=\'hidden\' name=\'aseSearchFieldTypes\' value=\'"
							+ searchFieldTypes
							+ "\'>"
							+ "<input type=\'hidden\' name=\'aseSearchFieldValues\' value=\'"
							+ searchFieldValues
							+ "\'>"
							+ "&nbsp;<input type=\'submit\' name=\'aseSearchFieldsSubmit\' class=\'inputsmallgray\' value=\'Go\'>&nbsp;"
							+ "</td>";
				} else {
					ase = ase + "</td>";
				}
			} // for

			templateSearch = "<form name=\'aseSearchForm\' method=\'post\' action=\'?\'><tr> "
					+ templateSearch.replace("<| row |>", ase)
					+ "</tr></form>";

		} // end search

		// set up output table header template
		strTemp = scriptName;

		if (strTemp.length() > 0)
			strTemp = strTemp + "?";
		else
			strTemp = "?";

		// set up the heaer row
		ase = "";
		if ((templateHeader.length()==0) || (templateHeader==null)) {

			if (useLink)
				templateHeader += "<td>&nbsp;</td>";

			// this extra column is to accommodate the addition of a detail line
			if (detailSQL != null && detailSQL.length() > 0)
				templateHeader += "<td>&nbsp;</td>";

			for (i=startColumn; i<numberOfColumns; i++) {
				if (sorting)
					ase = "<td align=\'" + columnAlignStyle[i]
							+ "\'><a class=TopMenuLink href=\'" + strTemp
							+ "col=" + sortColumns[i] + "\'>" + sortColumns[i]
							+ "</a>" + "</td>";
				else
					ase = "<td align=\'" + columnAlignStyle[i] + "\'>" + sortColumns[i] + "</td>";

				templateHeader = templateHeader + DEFAULT_templateHeader.replace("<| row |>", ase);
			}

			templateHeader = "<table " + DEFAULT_tableBorder + " width=\'"
					+ tableWidth
					+ "\' cellspacing=\'1\' cellpadding=\'2\' border=\'0\'>\n"
					+ templateSearch + "<tr class=\'" + tableColorClass
					+ "\'> " + templateHeader + "</tr>\n";
		}

		// set up output table row template
		if ((template.length() == 0) || (template == null)) {

			// additional link
			if (useLink){
				String connector = "?";

				if (linkedColumn[LINKED_PAGE].indexOf("?") >= 0)
					connector = "&";

				if ("1".equals(linkedColumn[LINKED_NEWWINDOW]))
					target = "target=\"_blank\"";

				template += "<a href=\"" +
								linkedColumn[LINKED_PAGE] +
								connector +
								linkedColumn[LINKED_KEY] +
								"=<| linkedColumn |>\" " + target + "><img src=\'../images/" + linkedColumn[LINKED_IMAGE] +
								"\' title=\'" +
								linkedColumn[LINKED_ALTTEXT] +
								"\' alt=\'" +
								linkedColumn[LINKED_ALTTEXT] + "\' border=\'0\'></a>&nbsp;";

				if (linkedColumn1 != null){
					target = "";

					if ((Constant.ON).equals(linkedColumn1[LINKED_NEWWINDOW]))
						target = "target=\"_blank\"";

					template += "&nbsp;<a href=\"" +
									linkedColumn1[LINKED_PAGE] +
									connector +
									linkedColumn1[LINKED_KEY] +
									"=<| linkedColumn |>\" " + target + "><img src=\'../images/" + linkedColumn1[LINKED_IMAGE] +
									"\' title=\'" +
									linkedColumn1[LINKED_ALTTEXT] +
									"\' alt=\'" +
									linkedColumn1[LINKED_ALTTEXT] + "\' border=\'0\'></a>&nbsp;";
				}

				if (linkedColumn2 != null){
					target = "";

					if ((Constant.ON).equals(linkedColumn2[LINKED_NEWWINDOW]))
						target = "target=\"_blank\"";

					template += "&nbsp;<a href=\"" +
									linkedColumn2[LINKED_PAGE] +
									connector +
									linkedColumn2[LINKED_KEY] +
									"=<| linkedColumn |>\" " + target + "><img src=\'../images/" + linkedColumn2[LINKED_IMAGE] +
									"\' title=\'" +
									linkedColumn2[LINKED_ALTTEXT] +
									"\' alt=\'" +
									linkedColumn2[LINKED_ALTTEXT] + "\' border=\'0\'></a>&nbsp;";
				}

				template = "<td valign=\'top\' height=\'21\'>" +
								template +
								"</td>";

			}

			// this extra column is to accommodate the addition of a detail line
			// aseOnLoad is for the detail expansion (master-detail).
			if (detailSQL != null && detailSQL.length() > 0)
				template += "<td valign=\'top\' height=\'21\'><img src=\'../images/add.gif\' border=\'0\' onclick=\"aseOnLoad('<| onload |>')\"></td>";

			for (i = startColumn; i < numberOfColumns; i++) {
				// when detail is available, we need to link the first column
				if (i == startColumn
						&& (detailLink != null && detailLink.length() > 0)) {
					ase = "<td valign=\'top\' width=\'" + columnWidth[i]
							+ "\' height=\'" + columnHeight + "\' align=\'"
							+ columnAlignStyle[i]
							+ "\'><a class=\'linkcolumn\' href=\'" + detailLink
							+ linkedKey + urlKeyName
							+ "=<| link |>\' <| onclick |>><| row" + i
							+ " |></a></td>";
					if (onClick != null && onClick.length() > 0) {
						ase = ase.replace("<| onclick |>", "onClick=\""
								+ onClick + "\"");
					} else {
						ase = ase.replace("<| onclick |>", "");
					}
				} else
					ase = "<td valign=\'top\' width=\'" + columnWidth[i]
							+ "\' height=\'" + columnHeight + "\' align=\'"
							+ columnAlignStyle[i] + "\'><| row" + i
							+ " |></td>";

				template = template
						+ DEFAULT_template.replace("<| row |>", ase);
			}

			template = "<tr class=\'" + tableColorClass
					+ "Row\' bgcolor=\'<| rowbgcolor |>\'>" + template
					+ "</tr>\n";
		}

		// set up output table footer template
		if ((templateFooter.length() == 0) || (templateFooter == null)) {
			templateFooter = "</table>\n";
		}
	}

	/**
	 * Main routine to establish connection and query database.
	 * <p>
	 *
	 * @param connection database connection
	 * @param _request 	HttpServletRequest object
	 * @param _response 	HttpServletResponse object
	 * @return renderred output
	 */
	public String showRecords(Connection connection,
									HttpServletRequest _request,
									HttpServletResponse _response) throws IOException, ServletException, SQLException {

		// logger.info("Paging: showRecords");

		// this is completed after the initial setup
		request = _request;
		response = _response;

		// this must be done here to get the SQL statement set up properly
		getSessionData();

		String sql = "";
		StringBuffer resultString = new StringBuffer();
		int remainder = 0;

		// if turning of navigation, then allow as many records to display as possible.
		if (!navigation)
			recordsPerPage = 999;

		Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		try {
			sql = formulateSQL();

			//System.out.println("formulateSQL ENDs");
			//System.out.println(sql);

			ResultSet rs = stmt.executeQuery(sql);

			//System.out.println("executeQuery ENDs");

			if (rs.last()) {
				recordCount = rs.getRow();
				rs.beforeFirst();
			} else
				recordCount = 0;

			//System.out.println("recordCount: " + recordCount);

			// how many pages are we working with
			pageCount = recordCount / recordsPerPage;
			remainder = recordCount % recordsPerPage;

			//System.out.println("pageCount: " + pageCount);
			//System.out.println("remainder: " + remainder);

			if (remainder > 0)
				pageCount++;

			// initialize data that was not provided
			_initialize(rs);

			// reset starting point
			rs.beforeFirst();

			//System.out.println("beforeFirst");

			// where we are now
			// currentPage = pageCurrent;

			// If the request page falls outside the acceptable range,
			// give them the closest match (1 or max)
			if (currentPage > pageCount)
				currentPage = pageCount;

			if (currentPage < 1)
				currentPage = 1;

			if (showAlphaIndex)
				resultString.append(drawIndex());

			resultString.append(drawTable(rs));

			rs.close();
			rs = null;

			// display provide information
			if (debug)
				resultString.append(showDebug());

		} catch (Exception e) {
			logger.fatal("------------------------------\n"
				+ "Paging - show records\n"
				+ e.toString()
				+ "\n"
				+ sql
				+ "\n"
				+ "------------------------------");
			HttpSession session = request.getSession(true);
			session.setAttribute("aseCol", "");
			session.setAttribute("aseSrt", "");
			session.setAttribute("aseSearchFields", "");
			session.setAttribute("aseSearchFieldValues", "");
			session.setAttribute("aseSearchFieldTypes", "");
			resultString.append("Paging show records error.");
		} finally {
			stmt.close();
			stmt = null;
		}

		return resultString.toString();
	}

	/**
	 * Index for quick navigation
	 *
	 * @return String
	 */
	public String drawIndex(){

		StringBuffer buf = new StringBuffer();
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		int x = 0;

		buf.append("<div class=\"pagination\">");

		for(x=LETTER_A; x<=LETTER_Z; x++){
			if (x == alphaIndex)
				buf.append("<span><b>" + (char)x + "</span></b>&nbsp;");
			else
				buf.append("<a href=\"?x=" + x + "\">" + (char)x + "</a>&nbsp;");
		}

		if (alphaIndex > 0)
			setRecordsPerPage(999);

		buf.append("<a href=\"?\">ALL</a>&nbsp;");

		if (showPrinterFriendly)
			buf.append("&nbsp;<a href=\"/central/servlet/progress\" target=\"_blank\"><img src=\"../images/printer.gif\" border=\"0\" alt=\"print screen listing\"></a>&nbsp;");

		buf.append("<br><br>");
		buf.append("</div>");

		return buf.toString();
	}

	/**
	 * replace place holder for alpha index
	 */
	public void setIndexSQL(){
		if (showAlphaIndex && alphaIndex>0)
			masterSQL = aseUtil.replace(masterSQL, "%_index_", (char)alphaIndex + "");
		else
			masterSQL = aseUtil.replace(masterSQL, "_index_", "");
	}

	/**
	 * Combine all the different parts to formulate SQL statement
	 *
	 * @return String
	 */
	public String formulateSQL() throws ServletException, IOException {

		String where = "";
		String order = "";

		String _where = "";
		String _order = "";

		int iOrder = -1;
		int iWhere = -1;

		String sort = "";

		try {
			setIndexSQL();

			/*
			 * is ORDER BY involved? If so, where is it located. extract and
			 * work on it
			 */
			if (masterSQL.indexOf("ORDER") > 0) {
				iOrder = masterSQL.indexOf("ORDER");
				_order = masterSQL.substring(iOrder);
				// shorten sql string and remove order by
				masterSQL = masterSQL.substring(0, iOrder);
			}

			// construct sort ordering
			if (sortOrder != null && sortOrder.length() > 0)
				sort = " " + sortOrder;

			/*
			 * if user is requesting sort by column, take that action and ignore
			 * the default sort. append any other user provided order by columns
			 * construct ORDER BY clause
			 */
			if (orderBy != null && orderBy.length() > 0) {
				order = "ORDER BY " + orderBy + " " + sort;
			} else {
				if (_order.length() > 0)
					order = _order + " " + sort;
			}

			// is WHERE involved? Find it and separate it from ORDER clause if necessary
			if (masterSQL.indexOf("WHERE") > 0) {
				iWhere = masterSQL.indexOf("WHERE");
				if (iOrder > -1)
					_where = masterSQL.substring(iWhere,iWhere + (iOrder - iWhere));
				else
					_where = masterSQL.substring(iWhere);

				// shorten sql string and remove where
				masterSQL = masterSQL.substring(0, iWhere);
			}

			// is user sending in additional WHERE? if so,
			// append to end of where using AND condition
			if (searchWhere != null && searchWhere.length() > 0) {
				if (_where.length() > 0)
					where = _where + " AND (" + searchWhere + ")";
				else
					where = "WHERE (" + searchWhere + ")";
			} else {
				if (_where.length() > 0)
					where = _where;
			}

			masterSQL = masterSQL + " " + where + " " + order;

			return masterSQL;
		} catch (Exception e) {
			logger.warn("Paging: " + e.toString());
		}

		return "";

	}

	/**
	 * Draws paging table
	 * <p>
	 *
	 * @param rs
	 *            ResultSet created in showRecords
	 * @return String
	 */
	public String drawTable(ResultSet rs) throws ServletException, SQLException {
		String strFinalOutput = null;
		String strTempNav = "";
		boolean bSum = false;
		int iTemp = numberOfColumns;

		// add sort images
		strFinalOutput = formatSortImage();

		// put together main table body
		strFinalOutput = drawBody(rs, strFinalOutput, arrSumColumns, bSum);

		// write the summarized data
		if (bSum)
			strFinalOutput = drawSummary(strFinalOutput, arrSumColumns, bSum);

		// paging links
		if (navigation) {
			// this extra column spanning is to accommodate the
			// addition of a detail line
			if (detailSQL != null && detailSQL.length() > 0)
				++iTemp;

			strTempNav = "<tr><td colspan=\'" + iTemp + "\'>"
					+ drawNavigation() + "</td></tr>";
		}

		// table footer
		strFinalOutput = strFinalOutput + strTempNav + templateFooter;

		return strFinalOutput;
	}

	/**
	 * putting the table together here (body)
	 * <p>
	 *
	 * @param rs					ResultSet created in showRecords
	 * @param strFinalOutput	String
	 * @param arrSumColumns		String[]
	 * @param bSum					boolean
	 *
	 * @return String
	 */
	public String drawBody(ResultSet rs,
									String strFinalOutput,
									String[] arrSumColumns,
									boolean bSum) throws ServletException,SQLException {

		String strNewRow = null;
		String strTemp = null;
		String strJunk = "";
		String divID = "";
		String firstColumn = "";
		int i = 0;
		int iRecordsShown = 0;
		String dataType = "";

		// determine where to start reading
		relativeRecord = (currentPage - 1) * recordsPerPage;

		// dont' allow our move to start to be out of range
		if (relativeRecord > recordCount)
			relativeRecord = recordCount;

		if (rs.next()) {
			rs.first();
			rs.relative(relativeRecord - 1);
		}

		if (recordCount > 0) {
			while (rs.next() && iRecordsShown < recordsPerPage) {
				strNewRow = template;

				// alternating row colors
				if (iRecordsShown % 2 == 0)
					strNewRow = strNewRow.replace("<| rowbgcolor |>",oddRowColor);
				else
					strNewRow = strNewRow.replace("<| rowbgcolor |>",evenRowColor);

				// resultset in Java starts with column 1
				for (i=startColumn; i<numberOfColumns; i++) {

					// ensure that data is valid (Fix_004)
					strTemp = aseUtil.nullToBlank(String.valueOf(rs.getString(i+1))).trim();
					if (rs.wasNull())
						strTemp = "";

					if (i==startColumn)
						firstColumn = aseUtil.nullToBlank(String.valueOf(rs.getString(1))).trim();

					// format data
					if (formatColumns[i].length() > 0)
						strTemp = formatData(strTemp, formatColumns[i]);
					else {
						dataType = columnDataType[i].toLowerCase();
						if (dataType != null && dataType.length() > 0) {
							if (dataType.indexOf("time") > -1) {
								strTemp = formatData(strTemp, "");
							}
							else if (dataType.indexOf("date") > -1) {
								strTemp = formatData(strTemp, "");
							}
						}
					}

					// sum data
					if (sumColumns[i].length() > 0) {
						arrSumColumns[i] = arrSumColumns[i] + strTemp;
						bSum = true;
					}

					// replace all other columns with appropriate data
					strNewRow = strNewRow.replace("<| row" + i + " |>", strTemp);

					// set the href on the key field (first column) - Fix_004
					if (i==startColumn) {
						strJunk = firstColumn;
						strNewRow = strNewRow.replace("<| link |>", strJunk);
						divID = strJunk;
					}

					// additional column
					if (useLink)
						strNewRow = strNewRow.replace("<| linkedColumn |>", firstColumn);

					// 1) add a link to the expanding key to show detail
					// 2) add div id for javascript to load data when detail
					// clicked
					if (detailSQL != null && detailSQL.length() > 0) {
						divID = divID.trim();
						int pos = divID.indexOf(" ");
						if (pos > 0) {
							String alpha = divID.substring(0, pos);
							String num = divID.substring(pos).trim();
							divID = alpha + "_" + num;
							strTemp = divID;
						}
						strNewRow = strNewRow.replace("<| + |>", strTemp);
						strNewRow = strNewRow.replace("<| onload |>", divID);
					}
				}

				strFinalOutput = strFinalOutput + strNewRow;

				// add a blank line below each row to set up for the detail
				// display
				if (detailSQL != null && detailSQL.length() > 0)
					strFinalOutput = strFinalOutput + "<tr><td colspan=\'"
							+ (numberOfColumns) + "\'><div id=\'" + divID
							+ "\'></div></td></tr>";

				iRecordsShown = iRecordsShown + 1;
			}
		} else {
			// this extra column spanning is to accommodate the
			// addition of a detail line
			i = numberOfColumns;
			if (detailSQL != null && detailSQL.length() > 0)
				++i;

			strNewRow = "<tr bgcolor=#ffffff><td colspan=\'"
					+ i
					+ "\'><font color=\"000000\">no data found</font></td></tr>";
			strFinalOutput = strFinalOutput + strNewRow + "\n";
		}

		return strFinalOutput;
	}

	/**
	 * summarized data row
	 * <p>
	 * @param strFinalOutput 	String
	 * @param arrSumColumns 	String[]
	 * @param bSum					boolean
	 * <p>
	 * @return String
	 */
	public String drawSummary(String strFinalOutput,
									String[] arrSumColumns,
									boolean bSum) throws ServletException {

		int i;
		String strTemp;

		strTemp = template;

		for (i = startColumn; i < numberOfColumns; i++) {
			if (arrSumColumns[i].length() == 0)
				strTemp = strTemp.replace("<| row" + i + " |>", "");
			else
				strTemp = strTemp.replace("<| row" + i + " |>", "<b>"
						+ formatData(arrSumColumns[i], formatColumns[i])
						+ "</b>");
		}

		strFinalOutput = strFinalOutput + strTemp;

		return strFinalOutput;
	}

	/**
	 * Navigation row
	 * <p>
	 *
	 * @return String
	 */
	public String drawNavigation() throws ServletException {

		int i;
		int startPage;
		int endPage;
		String strNav = "";
		String strTemp;

		// link to previous page. Need to append start of URL link, and append
		// for page counter
		strTemp = scriptName;

		if (strTemp.length() > 0)
			strTemp = "?" + strTemp + "&";
		else
			strTemp = "?";

		// display first record link only if not on first page
		if (currentPage > 1) {
			strNav = strNav + "<a class=\"linkcolumn\" href=\'" + scriptName + strTemp
					+ "page=1\'><font color=\"#ffffff\">[<<]</font></a> ";
			strNav = strNav + "<a class=\"linkcolumn\" href=\'" + scriptName + strTemp + "page="
					+ (currentPage - 1)
					+ "\'><font color=\"#ffffff\">[<]</font></a> |";
		}

		// when viewing pages 10 or lower, show only first 10 page links
		if (currentPage < 10) {
			startPage = 1;
			endPage = 10;
		} else {
			// when at the last page, make it the end page
			if (currentPage == pageCount) {
				endPage = currentPage;
				startPage = endPage - 10;
			} else {
				// when current page is higher than 10, show current page as
				// middle point and showing 5 to the left and 5 to the right
				startPage = currentPage - 5;
				endPage = currentPage + 5;
			}
		}

		// don't allow the start/end to go out of range
		if (startPage < 1)
			startPage = 1;

		if (endPage > pageCount)
			endPage = pageCount;

		// Bold the page and dont make it a link or Link the page
		for (i = startPage; i <= endPage; i++) {
			if (currentPage == i) {
				strNav = strNav + " <b><u>" + i + "</u></b> <font color=\"#b7b7b7\">|</font>";
			} else {
				strNav = strNav + " <a class=\"linkcolumn\" href=\'" + scriptName + strTemp
						+ "page=" + i + "\'><font color=\"#ffffff\">" + i
						+ "</font></a> <font color=\"#b7b7b7\">|</font>";
			}
		}

		// link to the next page?
		if (currentPage < pageCount) {
			strNav = strNav + " <a class=\"linkcolumn\" href=\'" + scriptName + strTemp + "page="
					+ (currentPage + 1)
					+ "\'><font color=\"#ffffff\">[>]</font></a>";
			strNav = strNav + " <a class=\"linkcolumn\" href=\'" + scriptName + strTemp + "page="
					+ (pageCount)
					+ "\'><font color=\"#ffffff\">[>>]</font></a>";
		}

		// when detail page is available, enable add link
		if (isAllowAdd()) {
			if (detailLink != null && detailLink.length() > 0)
				strNav = strNav + "&nbsp;<a class=\"linkcolumn\" href=\'" + detailLink + linkedKey
						+ "lid=0\'><font color=\"#ffffff\">[+]</font></a>";
		}

		strNav = "<div align=\'left\'>&nbsp;Page(s): " + strNav + "</div>";
		strNav = templateNavigation.replace("<| navigation |>", strNav);
		strNav = strNav
				.replace(
						"<| records |>",
						"<form method=\'post\' action=\'"
								+ scriptName
								+ "\'>records per page: <input class=\'input\' type=\'text\' name=\'rpp\' maxlength=\'4\' size=\'4\' value=\'"
								+ recordsPerPage
								+ "\'>"
								+ "&nbsp;<input type=\'submit\' name=\'aserppSubmit\' class=\'inputsmallgray\' value=\'Go\'>&nbsp;"
								+ "</form>");

		// show summary if there are records
		strNav = strNav.replace("<| pages |>", "<br>&nbsp;" + recordCount
				+ " record(s) found on " + pageCount + " page(s)");

		return strNav;
	}

	/**
	 * print friendly
	 */
	public String drawPrintFriendly() throws ServletException {

		/*
		 *
		 * Dim strTemp, iPrint
		 *
		 * iPrint = "1"
		 *  ' printer friendly if allowPrint = "1" then ' when 2, the link stops
		 * the follwing: ' no print link on screen ' no sorting images ' no page
		 * detail iPrint = printFriendly ' what character to start with for URL
		 * argument if instr( m_strPaging, "?" ) = 0 then allowPrint = "?" &
		 * m_strPaging else allowPrint = "&" & m_strPaging end if allowPrint =
		 * allowPrint & "&page=" & m_CurrentPage strTemp = "" if m_strSortOrder <> ""
		 * then strTemp = strTemp & "&srt=" & m_strSortOrder if m_strorderBy <> ""
		 * then strTemp = strTemp & "&col=" & m_strorderBy
		 *
		 * strTemp = allowPrint & strTemp & "&prt=" & iPrint strTemp = "<br>&nbsp;<a
		 * href='#' onClick=""printerFriendlyFormmat('" & strTemp & "')"">print
		 * format</a>" else strTemp = "<br>&nbsp;" end if
		 *
		 * drawTable_4 = strTemp
		 */

		return "";
	}

	/**
	 * export
	 */
	public String drawExport() throws ServletException {

		/*
		 *
		 * Dim strTemp, strtempStrer
		 *  ' if export is requested, set up link. Export = 2 means we'll go
		 * directly ' to createexcel if m_Excel = "1" then if allowPrint <> ""
		 * then strTemp = "&nbsp;|&nbsp;"
		 *
		 * if m_strPaging = "" then strtempStrer = "<a href='#'
		 * onClick=""excelExport('?export=2&page=" & m_CurrentPage &
		 * "')"">create export</a>" strTemp = strTemp & strtempStrer else if
		 * left( m_strPaging, 1 ) <> "?" then m_strPaging = "?" & m_strPaging
		 * end if strtempStrer = m_strPaging & "&export=2&page=" & m_CurrentPage
		 * strTemp = strTemp & "<a href='#' onClick=""excelExport('" &
		 * strtempStrer & "')"">create export</a>" end if end if
		 *
		 * drawTable_5 = strTemp
		 */

		return "";
	}

	/**
	 * Format data before output
	 */
	public String formatData(String strTemp, String strFormat) throws ServletException {

		String strDate = "";
		int i = 0;

		switch (i) {
			case 0:
				try {
					// Fix_004
					if (strTemp != null && strTemp.length() > 0) {
						//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						//java.util.Date date = sdf.parse(strTemp);
						//java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
						//SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy", Locale.getDefault());
						//strDate = formatter.format(ts);
						strDate = aseUtil.ASE_FormatDateTime(strTemp,Constant.DATE_DATETIME);
					} else {
						strDate = "";
					}
				} catch (Exception e) {
					strDate = e.toString();
				}

				break;
		}

		return strDate;
	}

	/**
	 * Format sort images in column header.
	 * <p>
	 *
	 * @return String
	 */
	public String formatSortImage() throws ServletException {

		String strSortCol;

		strSortCol = templateHeader.replace("<| headerbgcolor |>",tableRowtableColorClass);

		return strSortCol;
	}

	/**
	 * createExcelFile
	 */
	public String createExcelFile(ResultSet rs) throws ServletException {
		return "";
	}

	/**
	 * showDebug
	 */
	public String showDebug() throws ServletException {

		String strDebug = null;

		strDebug = "<br/><br/><hr size=\'1\'><table width=\'100%\' cellspacing=\'0\' cellpadding=\'2\' border=\'0\'> "
				+ "<tr><td valign='top'>columnDataType</td><td valign='top'>"
				+ getColumnDataTypeX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>currentPage</td><td valign='top'>"
				+ currentPage
				+ "</td></tr>"
				+ "<tr><td valign='top'>detailLink</td><td valign='top'>"
				+ detailLink
				+ "</td></tr>"
				+ "<tr><td valign='top'>detailSQL</td><td valign='top'>"
				+ detailSQL
				+ "</td></tr>"
				+ "<tr><td valign='top'>evenRowColor</td><td valign='top'>"
				+ evenRowColor
				+ "</td></tr>"
				+ "<tr><td valign='top'>exportPath</td><td valign='top'>"
				+ exportPath
				+ "</td></tr>"
				+ "<tr><td valign='top'>formatColumns</td><td valign='top'>"
				+ getFormatColumnsX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>getColumnAlignStyle</td><td valign='top'>"
				+ getColumnAlignStyleX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>navigation</td><td valign='top'>"
				+ navigation
				+ "</td></tr>"
				+ "<tr><td valign='top'>numberOfColumns</td><td valign='top'>"
				+ numberOfColumns
				+ "</td></tr>"
				+ "<tr><td valign='top'>oddRowColor</td><td valign='top'>"
				+ oddRowColor
				+ "</td></tr>"
				+ "<tr><td valign='top'>onClick</td><td valign='top'>"
				+ onClick
				+ "</td></tr>"
				+ "<tr><td valign='top'>orderBy</td><td valign='top'>"
				+ orderBy
				+ "</td></tr>"
				+ "<tr><td valign='top'>pageCount</td><td valign='top'>"
				+ pageCount
				+ "</td></tr>"
				+ "<tr><td valign='top'>recordCount</td><td valign='top'>"
				+ recordCount
				+ "</td></tr>"
				+ "<tr><td valign='top'>recordsPerPage</td><td valign='top'>"
				+ recordsPerPage
				+ "</td></tr>"
				+ "<tr><td valign='top'>relativeRecord</td><td valign='top'>"
				+ relativeRecord
				+ "</td></tr>"
				+ "<tr><td valign='top'>scriptName</td><td valign='top'>"
				+ scriptName
				+ "</td></tr>"
				+ "<tr><td valign='top'>search</td><td valign='top'>"
				+ search
				+ "</td></tr>"
				+ "<tr><td valign='top'>searchFields</td><td valign='top'>"
				+ searchFields
				+ "</td></tr>"
				+ "<tr><td valign='top'>searchFieldTypes</td><td valign='top'>"
				+ searchFieldTypes
				+ "</td></tr>"
				+ "<tr><td valign='top'>searchFieldValues</td><td valign='top'>"
				+ searchFieldValues
				+ "</td></tr>"
				+ "<tr><td valign='top'>searchInputValues</td><td valign='top'>"
				+ getSearchInputValuesX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>searchWhere</td><td valign='top'>"
				+ searchWhere
				+ "</td></tr>"
				+ "<tr><td valign='top'>sortColumns</td><td valign='top'>"
				+ getSortColumnsX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>sorting</td><td valign='top'>"
				+ sorting
				+ "</td></tr>"
				+ "<tr><td valign='top'>sortOrder</td><td valign='top'>"
				+ sortOrder
				+ "</td></tr>"
				+ "<tr><td valign='top'>masterSQL</td><td valign='top'>"
				+ masterSQL
				+ "</td></tr>"
				+ "<tr><td valign='top'>sumColumns</td><td valign='top'>"
				+ getSumColumnsX()
				+ "</td></tr>"
				+ "<tr><td valign='top'>tableRowtableColorClass</td><td valign='top'>"
				+ tableRowtableColorClass
				+ "</td></tr>"
				+ "<tr><td valign='top'>tableWidth</td><td valign='top'>"
				+ tableWidth
				+ "</td></tr>"
				+ "<tr><td valign='top'>template</td><td valign='top'>"
				+ template
				+ "</td></tr>"
				+ "<tr><td valign='top'>templateHeader</td><td valign='top'>"
				+ templateHeader
				+ "</td></tr>"
				+ "<tr><td valign='top'>templateFooter</td><td valign='top'>"
				+ templateFooter
				+ "</td></tr>"
				+ "<tr><td valign='top'>templateNavigation</td><td valign='top'>"
				+ templateNavigation
				+ "</td></tr>"
				+ "<tr><td valign='top'>theme</td><td valign='top'>"
				+ theme
				+ "</td></tr>" + "</table>";

		return strDebug;
	}

}