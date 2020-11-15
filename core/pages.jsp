<%!
	/**
	*	ASE
	*	pages.jsp
	*	2007.09.01
	**/

	// global declaration (used in sltcrs and msg)

	final int DEFAULT 		= -1;
	final int APPRL 			= 0;
	final int CRSAPPR		 	= 1;	// outline approval
	final int CRSCAN 			= 2;	// outline cancel
	final int CRSDLT 			= 3;	// outline delete
	final int CRSEDT 			= 4;	// outline edit
	final int CRSSTS 			= 5;	// outline status
	final int CRSVW 			= 6;
	final int CRSXRF 			= 7;
	final int CRSCPY 			= 8;
	final int CRSCRT 			= 9;
	final int CRSFLD 			= 10;
	final int CRSRNM 			= 11;
	final int CRSRVW 			= 12;
	final int CRSRVWER 		= 13;
	final int CRSASSR 		= 14;
	final int CRSSLO 			= 15;
	final int VWSLO 			= 16;
	final int LSTPREREQ 		= 17;
	final int CRSCANAPPR 	= 18;	// cancel outline approval
	final int CRSCMPZ 		= 19;	// request to review SLO from modification screen
	final int CRSRWSLO 		= 20;	// review SLO
	final int CRSCANSLO 		= 21;	// cancel SLO review
	final int CRSCMPZZ 		= 22;	// request to review SLO from menu
	final int CRSCMP 			= 23;	// edit slo
	final int CRSSLOAPPRCAN	= 24;	// cancel SLO approval
	final int CRSSLOAPPR 	= 25;	// request SLO approval
	final int SLOSTRT 		= 26;	// start SLO assessment
	final int CRSRVWCAN 		= 27;	// cancel outline review request
	final int CRSRQSTRVW 	= 28;	// request outline review
	final int SYLIDX			= 29;	// syllabus index
	final int USRTSKS			= 30;	// user task
	final int SHWFLD			= 31;	// show fields to be enabled for editing
	final int CRSFLDY			= 32;	// raw outline item edits
	final int PROFILE			= 33;	// user profile
	final int CRSAPPRSLO		= 34;	// SLO approval
	final int CRSCMNT			= 35;	// course comment
	final int ALPHAIDX		= 36;	// alpha maintenance
	final int LSTAPPR			= 37;	// approver selection list
	final int PRGAPPR		 	= 38;	// program approval
	final int PRGCANAPPR 	= 39;	// cancel approval
	final int PRGEDT		 	= 40;	// program edit
	final int SHWPRGFLD		= 41;	// show fields to be enabled for editing
	final int PRGRVWER		= 42;	// program reviewer comments
	final int PRGCMNT			= 43;	// program comments
	final int PRGRVWCAN		= 44;	// cancel program review
	final int PRGRVW			= 45;	// program review
	final int PRGRQSTRVW		= 46;	// program request
	final int APPRIDX			= 47;	// approval routing
	final int FNDRQSTRVW		= 48;	// foundation request
	final int FNDRVWCAN		= 49;	// foundation request
	final int FNDRVW			= 50;	// invite reviews
	final int FNDRVWER		= 51; // from review
	final int FNDCMNT			= 52; // from review

	// used in sltcrs to record code or pages being called
	//String[] actions = "APPL,CRSAPPR,CRSCAN,CRSDLT,CRSEDT,CRSSTS,CRSVW,CRSXRF,CRSCPY,CRSCRT,
	//CRSFLD,CRSRNM,CRSRVW,CRSRVWER,CRSASSR,CRSSLO,VWSLO,LSTPREREQ,CRSCANAPPR,CRSCMPZ,CRSRWSLO,
	//CRSCANSLO,CRSCMPZZ,CRSCMP,CRSSLOAPPRCAN,CRSSLOAPPR,SLOSTRT,CRSRVWCAN,CRSRQSTRVW,SYLIDX,
	//USRTSKS,SHWFLD,CRSFLDY,PROFILE,CRSAPPRSLO"
	//.split(",");

	int codeName = -1;
%>