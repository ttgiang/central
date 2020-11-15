<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	int idx = website.getRequestParameter(request,"idx",0);

	//crscmpx-70;crscntntx=77;crslgx=117;crsmodx=124;crsreqidx=133;

	String src = "about,alpha,alphaidx,appr,appridx,apprl,ase,ase2,ase2hbd,ase2hbd2,ase2x,ase3,asex,banner,bigbox,bnr,cas,cas2,casx,catidx,cccm6100,ccrpt,ccutil,chk,cllgidx,cmps,contact,crs,crsacan,crsacanx,crsacany,crsappr,crsapprhst,crsapprslo,crsapprx,crsaslo,crsaslox,crsass,crsassidx,crsasslnk,crsassr,crsassrpt,crsassrpt0,crsassrpt01,crsassrpt02,crsassrpt1,"
		+ "crsassrpt11,crsassrpt12,crsassrpt13,crsassrpt2,crsbk,crsbkx,crscan,crscanappr,crscanapprx,crscanslo,crscanslox,crscanx,crscany,crscat,crscatx,crscaty,crscmnt,"
		+ "crscmp,crscmpr,crscmprx,crscmpry,crscmprz,crscmpw,crscmpww,crscmpx,crscmpy,crscmpz,crscmpzz,crscnclled,crscntidx,crscntnt,crscntntx,crscon,"
		+ "crsconx,crscony,crsconz,crscpy,crscpyx,crscpyxx,crscpyxy,crscpyy,crscrt,crscrtx,crscrty,crsdlt,crsdltx,crsdltxx,crsdltxy,crsdocs,"
		+ "crsdtes,crsedt,crsedtx,crsexc,crsexp,"
		+ "crsfld,crsfldx,crsfldy,crsfldz,crsfstrk,crsgen,crsgenidx,crshlp,crshst,crsinf,crsinfx,crsinfy,crsinfy1,crsinp,crsitm,crsitmx,crslg,"
		+ "crslgx,crslnkr,crslnks,crslnksx,crslst,crslst2,crsmod,crsmodx,crsmody,crsprgrs,crsprgs,crsprgsx,crsqst,crsqstq,crsrdr,crsreq,"
		+ "crsreqidx,crsrnm,crsrnmx,crsrnmxx,crsrnmxy,crsrnmy,crsrpt,crsrqstrvw,crsrss,crsrssx,crsrssy,crsrvw,crsrvw1,crsrvw2,crsrvwcan,crsrvwcanx,"
		+ "crsrvwcmnts,crsrvwer,crsrvwerx,crsrvwx,crsrwslo,crsrwslox,crsslo,crsslo1,crssloappr,crssloapprcan,crssloapprcanx,crssloidx,crsslolnk,"
		+ "crsslosts,crsslox,crssts,crsstsh,crstpl,crsvw,crsxprt,crsxrf,crsxrfidx,crsxrfx,crsxtr,crsxtridx,crttpl,denied,dfqst,dfqstr,dfqsts,"
		+ "dfqstsx,dfqstx,dfqsty,disciplineidx,div,dividx,dprtmnt,dspcrs,dstidx,dstlst,dstlst2,dump,dvsn,edit,encrypt,error,exception,fckeditor,"
		+ "hbd,hbd2,help,highslide,hlp,hlpidx,hlptip,inactive,index,index1,index2,index3,index4,index5,ini,inimod,initm,jsid,kix,li,listarc,"
		+ "listcur,listpre,lo,login,lox,lstappr,lstapprx,lstcoreq,lstcoreqx,lstprereq,lstprereqx,lsttsks,mail,maillog,msg,msg2,msg3,news,"
		+ "newsdtl,newsdtlx,newsidx,ntf,ntfidx,ntfprvw,pages,posidx,prg,qlst,qlst0,qlst1,qlst2,rqst,rqstidx,sa,sacmps,sahstlg,salgs,samllg,samsg,"
		+ "satsk,sausrlg,sess,sessx,sessxx,sessz,shwfld,shwfldx,sloedt,sloedtx,sloinc,slosplt,slospltx,slostrt,sltcrs,sssm,stmt,stmtidx,success,"
		+ "support,syl,sylidx,sylx,sylxx,syly,tag,tasks,tooltip,trms,useridx,"
		+ "usr,usridx,usrlog,usrprfl,usrtsks,usrtsks01,usrtsks02,usrtsksx,utilities,validate,verifySQL,verifySQLx,vwcrs,"
		+ "vwcrsslo,vwcrsx,vwcrsy,vwoutline,vwoutlinex,vwslo,vwslox,wsloy,xCreateClassFile,";

	String[] aSrc = src.split(",");

	int min = 0;
	int max = aSrc.length;

	int next = idx + 1;

	if (next>max)
		next = min;

	int prev = idx - 1;

	if (prev<0)
		prev = max;

%>

<form name="aseForm" action="?" method="post">
<p align="center">
<font class="textblackth">Min:</font> <font class="datacolumn"><%=min%></font>&nbsp;&nbsp;&nbsp;
<font class="textblackth">Max:</font> <font class="datacolumn"><%=max%></font>&nbsp;&nbsp;&nbsp;
<font class="textblackth">Current:</font> <font class="datacolumn"><%=idx%></font>&nbsp;&nbsp;&nbsp;
<font class="textblackth">Skip:</font> <input class="input" type="text" size="1" maxlength="3" value="1" name="idx">
<input type="submit" name="aseSubmit" value="Go" class="Input">
<br/>
<a href="?idx=<%=prev%>" class="linkcolumn"><img src="../images/images/commArrowLeftSmall.gif" border=""></a>&nbsp;
<a href="<%=aSrc[idx]%>.jsp" target="top" class="linkcolumn"><%=aSrc[idx]%></a>&nbsp;
<a href="?idx=<%=next%>" class="linkcolumn"><img src="../images/images/commArrowRightSmall.gif" border=""></a>
<a href="jsp2.jsp" class="linkcolumn" target="top"><img src="../images/images/commArrowRightSmall.gif" border=""></a>
</p>
</form>

</body>
</html>

