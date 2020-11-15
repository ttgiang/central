<%
	/**
	*	ASE
	*	sessz.jsp
	*	2007.09.01
	**/
	int numberOfEntries = 23;
	String[] sessField;
	String[] sessType;

	String sessFieldNames =
		"aseApplicationTitle,aseTableWidth,aseTheme,aseURI,aseCol," +
		"aseSrt,aseApplicationMessage,aseRecordsPerPage,aseSearchFields,aseSearchFieldTypes," +
		"aseSearchFieldValues,aseSearchFieldTypes,aseCampus,aseUserFullName,aseUserName," +
		"aseRichEdit,aseDivision,aseEmail,aseDataType,aseWorkInProgress," +
		"aseUserRights,aseCallingPage,aseDept";

	String sessFieldType =
		"s,s,i,s,s," +
		"s,s,i,s,s," +
		"s,s,s,s,s," +
		"s,s,s,s,s," +
		"s,s,s";

	sessField = new String[numberOfEntries];
	sessField = sessFieldNames.split(",");

	sessType = new String[numberOfEntries];
	sessType = sessFieldType.split(",");
%>
