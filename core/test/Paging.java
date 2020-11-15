/*

	Source code started from musicstore userdb

*/

package central.paging;

import java.sql.*;
import java.util.Vector;

public class Paging{

	//
	// these are the values to use should we not have valid data
	//
	private int DEFAULT_NUM_RECORDS;
	private int DEFAULT_NUM_FIELDS;
	private String DEFAULT_templateHeader;
	private String DEFAULT_template;
	private String DEFAULT_templateNoRecord;
	private String DEFAULT_templateFooter;
	private String DEFAULT_templateNavigation;

	private String DEFAULT_tableRowBackgroundColor;

	//
	// member variables
	//
	private String template;
	private String templateHeader;
	private String templateNoRecord;
	private String templateFooter;
	private String templateNavigation;
	private String tableRowBackgroundColor;

	private String sql;
	private String detail;
	private String paging;

  	private String scriptName;
  	private String sortOrder;
  	private String orderBy;
	private String exportPath;
	private boolean navigation;
	private int recordsPerPage;
	private int currentPage;
	private int numberOfFields;
	private int recordCount;
	private int pageCount;

private String oddRowColor = "";
private String evenRowColor = "";

	private String[] formatColumns;
	private String[] sortColumns;
	private String[] sumCollumns;
 	private String[] arrSumColumns;

	/**
	 * Paging class constructor. Sets up how table, rows, columns are
	 * rendered.
	 */
	public Paging(){

		DEFAULT_NUM_FIELDS = 1;
		DEFAULT_NUM_RECORDS = 10;
		DEFAULT_templateHeader = "<table width=\'100%\' cellspacing=\'0\' cellpadding=\'0\' border=\'0\'><tr> " +
			"<td height=\'21\' bgcolor=\'black\'><font color=\'white\'><b>Field0</b></font></td></tr>";

		DEFAULT_template = "<tr class=\'<| class |>\'> " +
			"<td height=\'21\'><| row0 |></td></tr>";

		DEFAULT_templateNoRecord = "<tr><td colspan=9 height=\'21\'><b><| row0 |></b></td> </tr>";

		DEFAULT_templateFooter = "</table>";

		DEFAULT_templateNavigation = "<table width=\'100%\' cellspacing=\'0\' cellpadding=\'0\' border=\'0\'><tr> " +
			"<td height=\'21\' bgcolor=\'black\' align=\'left\'><font color=\'white\'><| navigation |></font></td></tr><table>";

		DEFAULT_tableRowBackgroundColor = "#FFFFFF";

		// defaults for data replacement
		template = DEFAULT_template;
		templateHeader = DEFAULT_templateHeader;
		templateNoRecord = DEFAULT_templateNoRecord;
		templateFooter = DEFAULT_templateFooter;
		templateNavigation = DEFAULT_templateNavigation;

		// table values
		tableRowBackgroundColor = DEFAULT_tableRowBackgroundColor;

		recordsPerPage = DEFAULT_NUM_RECORDS;
		numberOfFields = DEFAULT_NUM_FIELDS;

		currentPage = 1;
		recordCount = 0;
		pageCount = 0;
		sortOrder = "";
  		orderBy = "";
		detail = "";
		paging = "";
		exportPath = "";
		scriptName = "";
		sql = "";

		// default is navigation is on
		navigation = true;

// alternating row colors
oddRowColor = "#FFFFFF";
evenRowColor = "#E1E1E1";
	}

	/**
		* @param  arg	Number of records available in the resultset
	*/
	public void setRecordCount(int arg){
		recordCount = arg;
	}
	public int getRecordCount(){ return recordCount; }

	/**
		* Page count refers to the number of pages available from the resultset.
		* A page consists of the number of records per page. Number of pages
		* is the total record count (recordCount) divided by the number of records
		* per page (recordsPerPage).
		* <p>
		* @param  arg	Number of pages available in the resultset.
	*/
	public void setPageCount(int arg){
		pageCount = arg;
	}
	public int getPageCount(){ return pageCount; }

	/**
		* The page that is currently displayed. This value exists as links jump
		* from page to page. See page determination in setPageCount.
		* <p>
		* @param  arg	Number of pages available in the resultset.
	*/
	public void setCurrentPage(int arg){
		currentPage = arg;
	}
	public int getCurrentPage(){ return currentPage; }

	/**
		* @param  arg	SQL for data retrieval/display
	*/
	public void setSQL(String arg){
		sql = arg;
	}
	public String getSQL(){ return sql; }

	/**
		* Detail refers to the page that is linked to from the paging page.
		* This page is normally tied to a key returned from the resultset.
		* <p>
		* @param  arg	Formatted URL
	*/
	public void setDetail(String arg){
		detail = arg;
	}
	public String getDetail(){ return detail; }

	public void setPaging(String arg){
		paging = arg;
	}
	public String getPaging(){ return paging; }

	public void setRecordsPerPage(int arg){
		recordsPerPage = arg;
	}
	public int getRecordsPerPage(){ return recordsPerPage; }

	public void setNumberOfFields(int arg){

		int i;

		numberOfFields = arg;

		// knowing the number of fields gets us our array count
		formatColumns = new String[numberOfFields];
		sortColumns = new String[numberOfFields];
		sumCollumns = new String[numberOfFields];
		arrSumColumns = new String[numberOfFields];

		for ( i = 0; i < numberOfFields; i++ ){
			formatColumns[i] = "";
			sortColumns[i] = "";
			sumCollumns[i] = "";
			arrSumColumns[i] = "";
		}
	}
	public int getNumberOfFields(){ return numberOfFields; }

	public void setTemplate(String arg){
		template = arg;
	}
	public String getTemplate(){ return template; }

	public void setTemplateFooter(String arg){
		templateFooter = arg;
	}
	public String getTemplateFooter(){ return templateFooter; }

	public void setTemplateNavigation(String arg){
		templateNavigation = arg;
	}
	public String getTemplateNavigation(){ return templateNavigation; }

	public void setTemplateHeader(String arg){
		templateHeader = arg;
	}
	public String getTemplateHeader(){ return templateHeader; }

	public void setTemplateNoRecords(String arg){
		templateNoRecord = arg;
	}
	public String getTemplateNoRecords(){ return templateNoRecord; }

	public void setSortOrder(String arg){
		sortOrder = arg;
	}
	public String getSortOrder(){ return sortOrder; }

	public void setScriptName(String arg){
		scriptName = arg;
	}
	public String getScriptName(){ return scriptName; }

	public void setOrderBy(String arg){
		orderBy = arg;
	}
	public String getOrderBy(){ return orderBy; }

	public void setNavigation(boolean arg){
		navigation = arg;
	}
	public boolean getNavigation(){ return navigation; }

	public void setFormatColumns(String arg){
		if ( arg != null && arg.length() > 0 )
			formatColumns = arg.trim().split(",");
	}
	public String[] getFormatColumns(){ return formatColumns; }

	public void setSumCollumns(String arg){
		if ( arg != null && arg.length() > 0 )
			sumCollumns = arg.trim().split(",");
	}
	public String[] getSumCollumns(){ return sumCollumns; }

	public void setSortColumns(String arg){
		if ( arg != null && arg.length() > 0 )
			sortColumns = arg.trim().split(",");
	}
	public String[] getSortColumns(){ return sortColumns; }

	public void setTableRowBackgroundColor(String arg){
		tableRowBackgroundColor = arg;
	}
	public String getTableRowBackgroundColor(){ return tableRowBackgroundColor; }

/**
	* Determine odd row color
*/
public void setOddRowColor(String arg){
	oddRowColor = arg;
}
public String getOddRowColor(){ return oddRowColor; }

/**
	* Determine even row color
*/
public void setEvenRowColor(String arg){
	evenRowColor = arg;
}
public String getEvenRowColor(){ return evenRowColor; }

	/**
		* showRecords
		* <p>
		* @param  connection	database connection
		* @param  pageCurrent	paging to display
		* @return	renderred output
	*/
	public String showRecords(Connection connection, int pageCurrent) throws SQLException {

		String resultString = null;

		Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

		ResultSet rs = stmt.executeQuery( getSQL() );

		// got to the end to figure out how many records there are
		if ( rs.last() ) {
			recordCount = rs.getRow();
			pageCount = recordCount / recordsPerPage;
			rs.beforeFirst();
		}
		else{
			recordCount = 0;
			pageCount = 0;
		}

		// where we are now
		currentPage = pageCurrent;

		// If the request page falls outside the acceptable range,
		// give them the closest match (1 or max)
		if ( currentPage > pageCount )
			currentPage = pageCount;

		if ( currentPage < 1 )
			currentPage = 1;

		resultString = drawTable(rs);

		rs.close();
		rs = null;
		stmt.close();
		stmt = null;

		return resultString;
	}

	/**
		drawTable - draws paging table
	*/
	public String drawTable( ResultSet rs ) throws SQLException {
		String strFinalOutput = null;
		int i = 0;
		String strTemp = null;
		boolean bSum = false;

		// add sort images
		strFinalOutput = formatSortImage();

		// put together main table body
		strFinalOutput = drawBody(rs, strFinalOutput, arrSumColumns, bSum);

 		// write the summarized data
		if ( bSum )
			strFinalOutput = drawSummary(strFinalOutput, arrSumColumns, bSum);

		// table footer
 		strFinalOutput = strFinalOutput.concat(templateFooter);

		// paging links
		if ( navigation )
			strFinalOutput = strFinalOutput + drawNavigation();

		return strFinalOutput;
	}

	/**
		putting the table together here (body)
	*/
	public String drawBody(ResultSet rs, String strFinalOutput, String[] arrSumColumns, boolean bSum) throws SQLException {

		String strNewRow = null;
		String strTemp = null;
		int i = 0;
		int iRecordsShown = 0;

		if ( pageCount > 0 ){
			rs.first();
			rs.relative(currentPage*recordsPerPage+1);

			while (rs.next() && iRecordsShown < recordsPerPage ) {
				strNewRow = template;

// alternating row colors
if ( iRecordsShown % 2 == 0 )
	strNewRow = strNewRow.replace("<| class |>", oddRowColor);
else
	strNewRow = strNewRow.replace("<| class |>", evenRowColor);

				// resultset in Java starts with column 1
				for ( i = 0; i < numberOfFields; i++ ){

					// link to key field for detail display
					if ( i == 0 )
						strNewRow = strNewRow.replace("<| link |>", detail + String.valueOf(rs.getString(i+1)) );

					// ensure that data is valid
					strTemp = String.valueOf(rs.getString(i+1));

					// format data
					if ( formatColumns[i].length() > 0 )
						strTemp = formatData(strTemp, formatColumns[i]);

					// sum data
					if ( sumCollumns[i].length() > 0 ) {
						arrSumColumns[i] = arrSumColumns[i] + strTemp;
						bSum = true;
					}

					// replace all other columns with appropriate data
					strNewRow = strNewRow.replace("<| row" + i + " |>", strTemp );
				}

				strFinalOutput = strFinalOutput + strNewRow + "\n";

				iRecordsShown = iRecordsShown + 1;
			}
		}
		else{

			// No records returned from the query
			strNewRow = templateNoRecord;
			strNewRow = strNewRow.replaceAll("<| link |>", "");
			strNewRow = strNewRow.replaceAll("<| row0 |>", "No records found");

			for ( i = 0; i < 10; i++ )
				strNewRow = strNewRow.replaceAll("<| row" + i + " |>", "&nbsp;");

strNewRow = strNewRow.replaceAll("<| class |>", oddRowColor);
			strFinalOutput = strFinalOutput.concat(strNewRow);
		}

		return strFinalOutput;
	}

	/**
		summarized data
	*/
	public String drawSummary(String strFinalOutput, String[] arrSumColumns, boolean bSum) throws SQLException {

		int i;
		String strTemp;

		strTemp = template;

		for ( i = 0; i < numberOfFields; i++ ){
			if ( arrSumColumns[i].length() == 0 )
				strTemp = strTemp.replace("<| row" + i + " |>", "" );
			else
				strTemp = strTemp.replace("<| row" + i + " |>", "<b>" + formatData(arrSumColumns[i], formatColumns[i]) + "</b>" );
		}

		strFinalOutput = strFinalOutput + strTemp;

		return strFinalOutput;
	}

	/**
		navigation
	*/
	public String drawNavigation() throws SQLException {

		int i;
		int j;
		int k;
		String strNav;
		String strTemp;

 		// Build the recordset paging links
 		strNav = "";

 		if ( recordCount > recordsPerPage ) {
			// link to previous page. Need to append start of URL link, and append
			// for page counter
			strTemp = paging;

			if ( strTemp.length() > 0 )
				strTemp = "?" + strTemp + "&";
			else
				strTemp = "?";

			if ( sortOrder.length() > 0 )
				strTemp = strTemp + "srt=" + sortOrder + "&";

			if ( orderBy.length() > 0 )
				strTemp = strTemp + "col=" + orderBy + "&";

			if ( currentPage > 1) {
				strNav = strNav + "<a href=\'" + scriptName + strTemp + "page=1\'>[<<]</a> ";
				strNav = strNav + "<a href=\'" + scriptName + strTemp + "page=" + (currentPage-1) + "\'>[<]</a> |";
			}

			j = 1;
			k = (pageCount);

			if ( pageCount > 15 ){
				j = currentPage;
				k = j + 12;

				if ( k > pageCount )
					k = pageCount;
			}

			for (i = j; i <= k; i++){
				if ( currentPage == i){
					// Bold the page and dont make it a link
					strNav = strNav + " <b>" + i + "</b> |";
				}
				else{
					// Link the page
					strNav = strNav + " <a href=\'" + scriptName + strTemp + "page=" + i + "\'>" + i + "</a> |";
				}
			}

			// link to the next page?
			if ( currentPage < pageCount) {
				strNav = strNav + " <a href=\'" + scriptName + strTemp + "page=" + (currentPage+1) + "\'>[>]</a>";
				strNav = strNav + " <a href=\'" + scriptName + strTemp + "page=" + (pageCount) + "\'>[>>]</a>";
			}

			strNav = "<div align=\'left\'><br>Page(s): " + strNav + "</div>";
			strNav = templateNavigation.replace("<| navigation |>", strNav);
			strNav = strNav.replace("<| records |>", "<form method=\'post\' action=\'" + scriptName +
				"\'><input type=\'text\' name=\'rpp\' maxlength=\'4\' size=\'4\' value=\'" + recordsPerPage + "\'>" +
				"&nbsp;<input type=\'submit\' name=\'rppSubmit\' value=\'Go\'>" +
				"</form>");
		}

		// show summary if there are records
		if ( recordCount > 0 ){
			strNav = strNav + "<table border=\'0\' width=\'660\' cellspacing=\'0\' cellpadding=\'0\'>";
			strNav = strNav + "<tr>";
			strNav = strNav + "<td width=\'100%\'><br>&nbsp;" + recordCount + " record(s) found on " + pageCount + " page(s)<br></td>";
			strNav = strNav + "</tr></table>";
		}

		return strNav;
	}

	/**
		print friendly
	*/
	public String drawPrintFriendly() throws SQLException {

		/*

		Dim strTemp, iPrint

		iPrint = "1"

		' printer friendly
		if allowPrint = "1" then
			' when 2, the link stops the follwing:
			' 	no print link on screen
			'	no sorting images
			'	no page detail
			iPrint = printFriendly
			' what character to start with for URL argument
			if instr( m_strPaging, "?" ) = 0 then
				allowPrint = "?" & m_strPaging
			else
				allowPrint = "&" & m_strPaging
			end if
			allowPrint = allowPrint & "&page=" & m_CurrentPage
			strTemp = ""
			if m_strSortOrder <> "" then strTemp = strTemp & "&srt=" & m_strSortOrder
			if m_strorderBy <> "" then strTemp = strTemp & "&col=" & m_strorderBy

			strTemp = allowPrint & strTemp & "&prt=" & iPrint
			strTemp = "<br>&nbsp;<a href='#' onClick=""printerFriendlyFormmat('" & strTemp & "')"">print format</a>"
		else
			strTemp = "<br>&nbsp;"
		end if

		drawTable_4 = strTemp
		*/

		return "";
	}

	/**
		export
	*/
	public String drawExport() throws SQLException {


		/*

		Dim strTemp, strJunker

		' if export is requested, set up link. Export = 2 means we'll go directly
		' to createexcel
		if m_Excel = "1" then
			if allowPrint <> "" then strTemp = "&nbsp;|&nbsp;"

			if m_strPaging = "" then
				strJunker = "<a href='#' onClick=""excelExport('?export=2&page=" & m_CurrentPage & "')"">create export</a>"
				strTemp = strTemp & strJunker
			else
				if left( m_strPaging, 1 ) <> "?" then
					m_strPaging = "?"  & m_strPaging
				end if
				strJunker = m_strPaging & "&export=2&page=" & m_CurrentPage
				strTemp = strTemp & "<a href='#' onClick=""excelExport('" & strJunker & "')"">create export</a>"
			end if
		end if

		drawTable_5 = strTemp
		*/

		return "";
	}

	/**
		Format data before output
	*/
	public String formatData(String strTemp, String strFormat) throws SQLException {

		/*

		' if formatting is requested, and there is data, apply the format
		if strFormat <> "" and strTemp <> "" then
			Select Case strFormat
				' date/time
				Case "longdate"
					strTemp = FormatDateTime(strTemp, 1)
				Case "longtime"
					strTemp = FormatDateTime(strTemp, 3)
				Case "shortdate"
					strTemp = FormatDateTime(strTemp, 2)
				Case "shorttime"
					strTemp = FormatDateTime(strTemp, 4)
				' numbers
				Case "number02"
					strTemp = FormatNumber(strTemp, 2)
				Case "number04"
					strTemp = FormatNumber(strTemp, 4)
				' currency
				Case "currency02"
					strTemp = formatcurrency(strTemp, 2)
				Case "currency04"
					strTemp = formatcurrency(strTemp, 4)
				' phone
				Case "phone"
					strTemp = FormatPhoneNumber(strTemp)
			End Select
		end if

		formatData = strTemp
		*/

		return "";
	}

	/**
		Format Sort Image
	*/
	public String formatSortImage() throws SQLException {

		String strUp;
		String strDown;
		String strTemp;
		String strSortCol;
		int i;

		strTemp = paging;

		if ( strTemp.length() > 0 )
			strTemp = "?" + strTemp + "&";
		else
			strTemp = "?";

		strSortCol = templateHeader.replace("<| _bgcolor |>", tableRowBackgroundColor);

		for ( i = 0; i < numberOfFields; i++ ){
			// suppress images if in print friendly mode
			if ( (sortColumns[i].length() > 0) ) {
				// define the up and down links when sorting is enable
				// calling the page to sort is simply sending in 'a' for ASC, or 'd' for DESC
				strUp = "<a href=\'" + scriptName + strTemp + "srt=asc&col=" + sortColumns[i] + "\'><img src=\'images/up.gif\' border=\'0\' alt=\'sort ascending\'></a>";
				strDown = "<a href=\'" + scriptName + strTemp + "srt=desc&col=" + sortColumns[i] + "\'><img src=\'images/down.gif\' border=\'0\' alt=\'sort descending\'></a>";
				strSortCol = strSortCol.replace("<| col_u_" + i + " |>", strUp );
				strSortCol = strSortCol.replace("<| col_d_" + i + " |>", strDown );
			}
			else{
				strSortCol = strSortCol.replace("<| col_u_" + i + " |>", "" );
				strSortCol = strSortCol.replace("<| col_d_" + i + " |>", "" );
			}
		}

		return strSortCol;
	}

	/**
		createExcelFile
	*/
	public String createExcelFile( ResultSet rs ) throws SQLException {
		return "";
	}

}