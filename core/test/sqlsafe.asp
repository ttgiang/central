
<%

'-----------------------------------------------------------------
function killChars(strWords)

	dim badChars
	dim newChars ,i

	badChars = array("select", "drop", ";", "--", "insert", "delete", "xp_")
	newChars = strWords

	for i = 0 to uBound(badChars)
		newChars = replace(newChars, badChars(i), "")
	next

	killChars = newChars

end function

'-----------------------------------------------------------------
function SQLSafeString(pstrString)
	SQLSafeString=replace(pstrString,"'","''")
end function

'-----------------------------------------------------------------
function QuerySafeString(pstrString)
	QuerySafeString=replace(pstrString,"'","''")
	QuerySafeString=killChars(QuerySafeString)
end function

'-----------------------------------------------------------------

%>