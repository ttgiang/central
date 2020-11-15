<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%
	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";

	try{
		Banner banner = BannerDB.getBanner(conn,alpha,num,campus);
	%>
		<TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
			<TBODY>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getINSTITUTION()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_ALPHA()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_NUMBER()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getEFFECTIVE_TERM()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_TITLE()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_LONG_TITLE()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_DIVISION()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_DEPT()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCRSE_COLLEGE()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getMAX_RPT_UNITS()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getREPEAT_LIMIT()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCREDIT_HIGH()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCREDIT_LOW()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCREDIT_IND()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCONT_HIGH()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCONT_LOW()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getCONT_IND()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLAB_HIGH()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLAB_LOW()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLAB_IND()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLECT_HIGH()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLECT_LOW()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getLECT_IND()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getOTH_HIGH()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getOTH_LOW()%></TD></TR>
				<TR><TD class="textblackTH">CRSNO:</TD><TD class="dataColumn"><%=banner.getOTH_IND()%></TD></TR>									</TBODY>
		</TABLE>
	<%
	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);
%>