<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	search.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central Search";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<%@ include file="ase2.jsp" %>

<%
	if (processPage){

		String txt1 = website.getRequestParameter(request,"txt1","");
		String txt2 = website.getRequestParameter(request,"txt2","");
		String txt3 = website.getRequestParameter(request,"txt3","");
		String term = website.getRequestParameter(request,"term","");
		String alpha = website.getRequestParameter(request,"alpha","");
		String radio1 = website.getRequestParameter(request,"radio1","");
		String radio2 = website.getRequestParameter(request,"radio2","");
		String type = website.getRequestParameter(request,"type","");
		String cps = website.getRequestParameter(request,"cps","");

		if (!txt1.equals(Constant.BLANK)){
			out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
// INLINE
//out.println(com.ase.aseutil.util.SearchDB.searchCC(conn,campus,cps,type,txt1,txt2,txt3,radio1,radio2,term,alpha));
out.println(searchCC(conn,campus,cps,type,txt1,txt2,txt3,radio1,radio2,term,alpha));
			out.println("</td>");
			out.println("</tr>");
			out.println("</table></div>");
		}

	} // processPage

	asePool.freeConnection(conn,"srch",user);

%>

<%@ page import="org.apache.log4j.Logger"%>

<%!

	/*
	 * searchCC
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String		// user campus
	 * @param	cps		String		// selected campus
	 * @param	txt1		String
	 * @param	txt2		String
	 * @param	txt3		String
	 * @param	radio1	String
	 * @param	radio2	String
	 *	<p>
	 * @return	String
	 */
	public static String searchCC(Connection conn,
												String campus,
												String cps,
												String type,
												String txt1,
												String txt2,
												String txt3,
												String radio1,
												String radio2,
												String term,
												String prefix) throws Exception {

Logger logger = Logger.getLogger("test");

		//
		// X87 is manoa's catalog description for alpha courses
		//
		boolean x87 = false;

		StringBuffer result = new StringBuffer();
		String junk = null;
		String junkX87 = null;
		int parms = 0;

		boolean multiWordSearch = false;

		//
		// search text
		//
		if (!txt2.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		if (!txt3.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		//
		// operators
		//
		if (radio1.equals(Constant.BLANK)){
			radio1 = "AND";
		}

		if (radio2.equals(Constant.BLANK)){
			radio2 = "AND";
		}

		//
		// help refine simple search
		// when simple search is selected and we have multiple words,
		// break apart and set up as if we were doing AND search
		//
		if(!multiWordSearch && txt1.contains(Constant.SPACE)){
			String[] aText = txt1.trim().split(Constant.SPACE);
			txt1 = aText[0];

			if(aText.length > 1)	txt2 = aText[1];
			if(aText.length > 2)	txt3 = aText[2];
		}

		//
		// sql statement
		//
		try {
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT  c.campus, c.historyid, c.coursealpha, c.coursenum, c.coursetitle, c.coursetype, c.coursedescr, c.effectiveterm, b.term_description "
						+ "FROM tblCourse c LEFT OUTER JOIN BannerTerms b ON c.effectiveterm = b.TERM_CODE "
						+ "WHERE c.historyid <> '' ";

			if (!cps.equals(Constant.BLANK)){
				sql = sql + " AND c.campus=? ";
			}

			if (!type.equals(Constant.BLANK)){
				sql = sql + " AND c.coursetype like '%"+aseUtil.toSQL(type,1,false)+"%' ";
			}

			if (!term.equals(Constant.BLANK)){
				sql = sql + " AND b.term_description like '%"+aseUtil.toSQL(term,1,false)+"%' ";
			}

			if (!prefix.equals(Constant.BLANK)){
				sql = sql + " AND c.coursealpha like '%"+aseUtil.toSQL(prefix,1,false)+"%' ";
			}

			// combine for text with logical operators
			junk = "";
			junkX87 = "";

			if (!txt1.equals(Constant.BLANK)){
				junk = " c.coursedescr LIKE ? ";
				if(x87) junkX87 = " c.x87 LIKE ? ";
			}

			if (!txt2.equals(Constant.BLANK)){
				junk = junk + " " + radio1 + " c.coursedescr LIKE ? ";
				if(x87) junkX87 = junkX87 + " " + radio1 + " c.x87 LIKE ? ";
			}

			if (!txt3.equals(Constant.BLANK)){
				junk = junk + " " + radio2 + " c.coursedescr LIKE ? ";
				if(x87) junkX87 = junkX87 + " " + radio2 + " c.x87 LIKE ? ";
			}

			if (!junk.equals(Constant.BLANK)){
				sql = sql + " AND (" + junk + ") ";
				if(x87) sql = sql + " OR (" + junkX87 + ") ";

				junk = "";
				junkX87 = "";
			}

			sql = sql + " ORDER BY c.campus, c.coursealpha, c.coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);

			if (!cps.equals(Constant.BLANK)){
				ps.setString(++parms,cps);
			}

			if (!type.equals(Constant.BLANK)){
				ps.setString(++parms,type);
			}

			//
			// this set is for coursedescr
			//
			if (!txt1.equals(Constant.BLANK)){
				ps.setString(++parms, "%" + txt1.toLowerCase() + "%");
			}

			if (!txt2.equals(Constant.BLANK)){
				ps.setString(++parms, "%" + txt2.toLowerCase() + "%");
			}

			if (!txt3.equals(Constant.BLANK)){
				ps.setString(++parms, "%" + txt3.toLowerCase() + "%");
			}

			//
			// this set is for x87
			//
			if(x87){
				if (!txt1.equals(Constant.BLANK)){
					ps.setString(++parms, "%" + txt1.toLowerCase() + "%");
				}

				if (!txt2.equals(Constant.BLANK)){
					ps.setString(++parms, "%" + txt2.toLowerCase() + "%");
				}

				if (!txt3.equals(Constant.BLANK)){
					ps.setString(++parms, "%" + txt3.toLowerCase() + "%");
				}
			}

			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");

				do{
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String title = AseUtil.nullToBlank(rs.getString("coursetitle"));
					String src = AseUtil.nullToBlank(rs.getString("coursedescr"));
					String typeStatus = AseUtil.nullToBlank(rs.getString("coursetype"));
					String termDescription = AseUtil.nullToBlank(rs.getString("TERM_DESCRIPTION"));
					term = AseUtil.nullToBlank(rs.getString("effectiveterm"));

					if(type.equals(Constant.BLANK)){
						if(typeStatus.equals(Constant.CUR)){
							typeStatus = "&nbsp;&nbsp;&nbsp;<img src=\"../images/fastrack.gif\" alt=\"this is an approved outline\" title=\"this is an approved outline\">";
						}
						else if(typeStatus.equals(Constant.PRE)){
							typeStatus = "&nbsp;&nbsp;&nbsp;<img src=\"../images/edit.gif\" alt=\"this outline is being modified/proposed\" title=\"this outline is being modified/proposed\">";
						}
						else if(typeStatus.equals(Constant.ARC)){
							typeStatus = " - ARCHIVED";
						}
					}

					if (enableCCLab.equals(Constant.ON)){
						result.append("<a href=\"/central/core/vwpdf.jsp?kix="+kix+"\" alt=\"view in html format\" class=\"linkcolumn\" target=\"_blank\">"
										+ "<img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\">"
										+ "</a>&nbsp;&nbsp;");
					}

					result.append("<a href=\"/central/core/vwcrsy.jsp?pf=1&kix="+kix+"&comp=1\" class=\"linkcolumn\" target=\"_blank\">"
									+ campus + " - " + title + " ("+alpha + " " + num +") - " + termDescription
									+ "</a>"
 									+ typeStatus
									+ Html.BR()
									);

					junk = src.replace(txt1,"<span class=\"highlights1\">" + txt1 + "</span>");

					if (!txt2.equals(Constant.BLANK))
						junk = junk.replace(txt2,"<span class=\"highlights2\">" + txt2 + "</span>");

					if (!txt3.equals(Constant.BLANK))
						junk = junk.replace(txt3,"<span class=\"highlights3\">" + txt3 + "</span>");

					result.append(junk + Html.BR() + Html.BR());

				} while (rs.next());
			}
			else{
				result.append("no record found matching the requested search data.");
			} // if

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (SQLException se) {
			logger.fatal("SearchDB: searchCC - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SearchDB: searchCC - " + e.toString());
		}

		return result.toString();
	} // searchCC

%>