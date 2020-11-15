<%
	// 1
	//boolean processPage = true;

	// 2
	String linkedExtension = ".pdf";

	// 3
	boolean isCentral = true;

	//
	// no changes below here
	//
	int BOOLEAN 	= 0;
	int FUZZY 		= 1;
	int PHRASE 		= 2;
	int TEXT 		= 3;
	int WILDCARD 	= 4;

	int searchUsed = 0;

	String srchWrd = website.getRequestParameter(request,"s","");

	int currentPage = website.getRequestParameter(request,"p",1);

	List<com.ase.aseutil.Generic> genericData = null;

	com.ase.aseutil.index.SearchEngine se = null;

	int rowsReturned = 0;

	StringBuilder pagination = new StringBuilder();

	int i = 0;

	int pages = 0;

	if (processPage){

		String result = "";

		if(!srchWrd.equals(Constant.BLANK)){

			se = new com.ase.aseutil.index.SearchEngine();

			if(se != null){

				se.setPageNumber(currentPage);
				se.setCampus(campus);

				// boolean must be all CAPS
				if(srchWrd.contains("~")){
					genericData = se.searchFuzzy(srchWrd);
					searchUsed = FUZZY;
				}
				else if(srchWrd.contains("*") || srchWrd.contains("?")){
					genericData = se.searchWildCard(srchWrd);
					searchUsed = WILDCARD;
				}
				else if(srchWrd.contains("AND") || srchWrd.contains("OR")){
					genericData = se.searchBoolean(srchWrd);
					searchUsed = BOOLEAN;
				}
				else if(srchWrd.contains(" ")){
					genericData = se.searchPhrase(srchWrd);
					searchUsed = PHRASE;
				}
				else{
					genericData = se.searchIndex(srchWrd);
					searchUsed = TEXT;
				}

				rowsReturned = se.getHitsFound();

				result = "About " + rowsReturned + " results";

			}

			pages = ((int)rowsReturned / se.getPageSize());

			if(pages > 0){

				pagination.append("Pages: ");

				for(i = 1; i <= pages; i++){

					if(currentPage==i){
						pagination.append("<font class=\"copyrightgold\">"+i+"</font>&nbsp;");
					}
					else{
						pagination.append("<a href=\"?p="+i+"&s="+srchWrd+"\" class=\"linkcolumn\">"+i+"</a>&nbsp;");
					}

				} // for i
			}
			else{
				pagination.append("<font class=\"copyrightgold\">page: 1 of 1</font>");
			}

		}
%>
	<div class="search">
		<FORM id="aseForm" method="post" action="?">
			<TABLE width="100%">
				<TBODY>
					<TR>
						<TD align="left">
							<INPUT name="s" id="s" type="text" value="<%=srchWrd%>" size="40">
							<INPUT id=doSearch type=submit value=search>&nbsp;<font color="#999">
							<a href="syntax.htm" class="linkColumn" onclick="asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false" onfocus="this.blur()"><img src="./images/helpicon.gif" border="0" alt="help" title="help" ></a>
							<%=result%></font>
						</TD>
						<td align="right" width="50%"><%=pagination%></td>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</div>

  <table align="left" width="100%">

		<%
			if (se != null && genericData != null){

				try{

					// how far left and right do we want to display text
					String output = "";

					int offset = 300;

					//
					// clean up characters for highlight
					//
					if(searchUsed == FUZZY){
						srchWrd = srchWrd.replace("~","");
					}
					else if(searchUsed == WILDCARD){
						srchWrd = srchWrd.replace("*","").replace("?","");
					}

					String[] words = srchWrd.split(" ");

					//
					// for phrase search, if we find the words together, then we treat that is an exactMatch
					//
					boolean exactMatch = false;

					for(i = 0; i < genericData.size(); i++){

						int pos = 0;

						com.ase.aseutil.Generic generic = (com.ase.aseutil.Generic)genericData.get(i);

						String docCampus = generic.getString7();

						if(docCampus.equals("ALL") || docCampus.equals(campus)){

							String link = "";

							if(docCampus.equals(campus)){
								link = "/centraldocs/docs/campus/" + campus + "/" + generic.getString2().replace(".doc",linkedExtension);
							}
							else{
								link = "/centraldocs/docs/faq/" + generic.getString2().replace(".doc",linkedExtension);
							}

							String title = generic.getString3();
							String content = generic.getString4();
							String filepath = generic.getString6();

							// skip over introduction section
							if(isCentral){

								pos = content.indexOf("Procedure");

								if(pos > -1){

									content = content.substring(pos+9);

								}

							} // isCentral

							// default is to display all text returned
							int start = 0;
							int end = content.length();

							if(content.toLowerCase().indexOf(srchWrd.toLowerCase()) >-1 ){
								exactMatch = true;
							}

							//-----------------------------------------------------------------
							// extract text to show. start with multi or complete search term.
							// if not found as exact match (words next to each other), then
							// search for first word only.
							//-----------------------------------------------------------------
							pos = content.toLowerCase().indexOf(srchWrd.toLowerCase());
							if(pos == -1){
								pos = content.toLowerCase().indexOf(words[0].toLowerCase());
							}

							// extract enough text to show
							if(pos > -1){
								start = pos - offset;
								if(start < 0){
									start = 0;
								}

								end = pos + offset;
								if(end > content.length()){
									end = content.length();
								}

								content = content.substring(start,end);
							} // pos > -1

							//-----------------------------------------------------------------
							// high lighting words. highlight complete words before breaking apart
							//-----------------------------------------------------------------
							if(exactMatch){
								content = content.toLowerCase().replace(srchWrd,"<font class=\"highlight0\">"+srchWrd.toLowerCase()+"</font>");
							}
							else{
								// with content to display, highlight word(s) found
								// highlight each word found
								for(int j = 0; j< words.length; j++){
									content = content.toLowerCase().replace(words[j],"<font class=\"highlight"+j+"\">"+words[j].toLowerCase()+"</font>");
								} // for j
							} // exactMatch


							title = title.replace("C:\\tomcat\\webapps\\","/").toLowerCase().replace(".doc","").replace(".pdf","");

							filepath = filepath.replace("C:\\tomcat\\webapps\\centraldocs\\docs\\","");
							filepath = filepath.replace("C:\\tomcat\\webapps\\central\\doc\\completed\\","");

							out.println("<tr><td align=\"left\" valign=\"top\" >"
								+ "<img src=\"../images/ext/pdf.gif\" border=\"0\" title=\"view help\" alt=\"view help\">&nbsp;<a href=\""+link+"\" class=\"linkcolumn\" target=\"_blank\">"+title+"</a>"
								+ "<br/>"
								+ content
								+ "<br/>"
								+ "<font class=\"filepath\">" + filepath + "</font>"
								+ "<br/><br/></td></tr>");

						} // docCampus

					} // for i

					if(pages > 0){
						out.println("<tr><td align=\"right\" valign=\"top\">"
									+ pagination.toString()
									+ "<br/><br/></td></tr>");
					}

				}
				catch(Exception e){
					System.out.println(e.toString());
				}

			} // se

			se = null;

		%>

  </table>

<%
	} // processPage

	asePool.freeConnection(conn,"ccfaq",user);
%>
