<%@ page errorPage="exception.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

//--------------------------------------------
// campus and user
//--------------------------------------------

String campus = Util.getSessionMappedKey(session,"aseCampus");
String user = Util.getSessionMappedKey(session,"aseUserName");

String campus = website.getRequestParameter(request,"aseCampus","",true);
String user = website.getRequestParameter(request,"aseUserName","",true);

String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

//--------------------------------------------
// kix
//--------------------------------------------
String kix = website.getRequestParameter(request,"kix");
if (!"".equals(kix)){
	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[0];
	num = info[1];
	type = info[2];
	proposer = info[3];
	campus = info[4];
	historyid = info[5];
	route = NumericUtil.nullToZero(info[6]);
	progress = info[7];
	subprogress = info[8];

	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[Constant.KIX_ALPHA];
	num = info[Constant.KIX_NUM];
	type = info[Constant.KIX_TYPE];
	proposer = info[Constant.KIX_PROPOSER];
	campus = info[Constant.KIX_CAMPUS];
	historyid = info[Constant.KIX_HISTORYID];
	route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
	progress = info[Constant.KIX_PROGRESS];
	subprogress = info[Constant.KIX_SUBPROGRESS];
	courseTitle = info[Constant.KIX_COURSETITLE];

	alpha = info[Constant.KIX_PROGRAM_TITLE];
	num = info[Constant.KIX_PROGRAM_DIVISION];
}
else{
	alpha = (String)session.getAttribute("aseAlpha");
	num = (String)session.getAttribute("aseNum");
	type = (String)session.getAttribute("aseType");
}

kix = helper.getKix(conn,campus,alpha,num,"PRE");

String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
String kix = info[0];
int route = Integer.parseInt(info[1]);

//--------------------------------------------
// date time
//--------------------------------------------
AseUtil.getCurrentDateString()
aseUtil.ASE_FormatDateTime(rs.getString("XYZ"),Constant.DATE_DATETIME);

//--------------------------------------------
// debug setting
//--------------------------------------------

debug = DebugDB.getDebug(conn,"CourseApproval");

//--------------------------------------------
// div tag visible hidden
//--------------------------------------------
<div style="visibility:visible; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
</div>

//--------------------------------------------
// compile
//--------------------------------------------
@SuppressWarnings("unchecked")

//--------------------------------------------
// popup
//--------------------------------------------
onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','no','center');return false\" onfocus=\"this.blur()\"
onclick="asePopUpWindow(this.href,'aseWin1','800','600','no','center');return false" onfocus="this.blur()"

String enableOtherDepartmentLink = Util.getSessionMappedKey(session,"EnableOtherDepartmentLink");
String outineSubmissionWithProgram = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutineSubmissionWithProgram");

//--------------------------------------------
// tools and config
//--------------------------------------------
// screen has configurable item. setting determines whether
// users are sent directly to news or task screen after login
session.setAttribute("aseConfig","1");
session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

//--------------------------------------------
// paging
//--------------------------------------------
paging = new com.ase.paging.Paging();
paging.setSQL( aseUtil.getPropertySQL(session,"dividx"));
paging.setScriptName("/central/core/dividx.jsp");
paging.setDetailLink("/central/core/div.jsp");
paging.setTableColumnWidth("0,10,50,20,20");
paging.setLinkedColumn("ed_link.gif,link alphas,pgrchr.jsp,programid,0");
paging.setRecordsPerPage(99);
paging.setAllowAdd(true);
out.print( paging.showRecords(conn,request,response));
paging = null;

String modifyText = SysDB.getTaskMenuText(conn,Constant.MODIFY_TEXT);

//--------------------------------------------
// system values
//--------------------------------------------
if (SysDB.getSys(connection,"useNewMenu").equals(Constant.ON)){

//--------------------------------------------
// ckeditor
//--------------------------------------------
<script type="text/javascript">
	//<![CDATA[
		CKEDITOR.replace( 'content',
			{
				toolbar : [],
				extraPlugins : 'tableresize',
				toolbarCanCollapse : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode: CKEDITOR.ENTER_P
			}
		);
	//]]>
</script>

//--------------------------------------------
// system columns
//--------------------------------------------
SELECT so.name as tbl,sc.name as col
FROM syscolumns sc, sysobjects so
WHERE so.id = sc.id
AND (so.xtype='U' OR so.xtype='T')
AND so.name not like '%temp%'
AND (sc.name = 'historyid' or sc.name = 'coursealpha' or sc.name like '%alpha%')

//--------------------------------------------
// ckeditor
//--------------------------------------------

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

String ckName = "statement";
String ckData = statement;

<%@ include file="ckeditor02.jsp" %>

var ckContent = CKEDITOR.instances["infocontent"].getData();
if(ckContent == ""){
	alert( "Content is a required field.");
	return false;
}

//--------------------------------------------
// data tables
//--------------------------------------------
	 /* Init the table*/
	  $("#ratesandcharges1").dataTable({
			"bRetrieve": false,
			"bFilter": false,
			"bSortClasses": false,
			"bLengthChange": false,
			"bPaginate": false,
			"bInfo": true,	// navigation page count
			"bJQueryUI": true,
			"aaSorting": [ [1,'asc'], [2,'asc'] ],
			"bAutoWidth": false,
			"aoColumns": [
			{"bVisible": false},
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '9%' },
			{ sWidth: '10%' } ]
	  });

	sysspc = footer
	dfqst = sorting numeric first column
	newsidx = hidden column
	usrlog = hidden and sort

	//
	// sorting where the first column is and integer - starts
	// this example has a table with 7 columns and the first
	// is to be sorted using integer
	//
	jQuery.fn.dataTableExt.oSort['num-html-asc']  = function(a,b) {
		 var x = a.replace( /<.*?>/g, "" );
		 var y = b.replace( /<.*?>/g, "" );
		 x = parseFloat( x );
		 if ( isNaN( x ) ) { x = -1; };
		 y = parseFloat( y );
		 if ( isNaN( y ) ) { y = -1; };
		 return ((x < y) ? -1 : ((x > y) ?  1 : 0));
	};

	jQuery.fn.dataTableExt.oSort['num-html-desc'] = function(a,b) {
		 var x = a.replace( /<.*?>/g, "" );
		 var y = b.replace( /<.*?>/g, "" );
		 x = parseFloat( x );
		 if ( isNaN( x ) ) { x = -1; };
		 y = parseFloat( y );
		 if ( isNaN( y ) ) { y = -1; };
		 return ((x < y) ?  1 : ((x > y) ? -1 : 0));
	};

	$(document).ready(function () {
		$("#jquery").dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 99,
			"bJQueryUI": true,
			"bSort": true,
			"aaSorting": [ [0,'asc'] ],
			"aoColumns": [
				 { "sType": "num-html" },
				 null,
				 null,
				 null,
				 null,
				 null,
				 null
			]
		});
	});
	//
	// sorting where the first column is and integer - ends
	//

//--------------------------------------------
// hr class
//--------------------------------------------

<style type="text/css">
	.hr { clear: both;margin: 20px 0 20px 0;font-size: 2px;line-height: 2px;background: #ccc;border: 1px solid #888;height: 2px;display: block;}
</style>

<div class="hr"></div>

<div class=\"hr\"></div>

//--------------------------------------------
// SQL
//--------------------------------------------

AseUtil.toSQL(where, 1);

//--------------------------------------------
// session
//--------------------------------------------

aseAlpha
aseApplicationMessage
aseCampus
asecurrentSeq
asecurrentTab
aseKey
aseLinker
aseNum
aseParm1
aseParm2
aseParm3
aseParm4
aseParm5
aseSession
aseType
aseUserName

//--------------------------------------------
// try/catch in JSP
//--------------------------------------------
MailerDB mailerDB = new MailerDB(conn,
											campus,
											kix,
											user,
											e.toString(),
											fieldsetTitle + " selection");
