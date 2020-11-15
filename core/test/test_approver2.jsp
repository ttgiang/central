<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Course Question Listing";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%

	//AAMODT
	//ACEVES-FOSTER
	//THANHG
	//AKANA
	//AMUNDSON

	String user = "AKANA";
	String campus = "LEECC";
	String thisApprover = "";
	int thisSeq = 0;
	int currentSeq = 0;
	int firstSeq = 1;
	int nextSeq = 0;
	int prevSeq = 0;
	int lastSeq = 0;

	String thisDelegated = "";
	StringBuffer allApprovers = new StringBuffer();
	Approver approver = new Approver();

	try{
			String query = "SELECT approver,delegated,approver_seq " +
				"FROM tblApprover WHERE campus=? ORDER BY approver_seq";
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1,campus);
			ResultSet results = preparedStatement.executeQuery();

			while ( results.next() ){
				thisApprover = AseUtil.nullToBlank(results.getString(1)).trim();
				thisDelegated = AseUtil.nullToBlank(results.getString(2)).trim();
				thisSeq = results.getInt(3);

				//System.out.println("thisApprover: *" + thisApprover + "*\n");
				//System.out.println("thisDelegated: " + thisDelegated + "\n");
				//System.out.println("thisSeq: " + thisSeq + "\n");
				//System.out.println("user: *" + user + "*\n");

				// determine the current approver
				if ( user.trim().equals(thisApprover) && approver.getApprover().length() == 0 ){
					currentSeq = thisSeq;
				}

				// csv representing list of approvers
				if ( allApprovers.length() > 0 )
					allApprovers.append(",");

				allApprovers.append(thisApprover);

				lastSeq++;
			}
			results.close();
			preparedStatement.close();

			// include the last approver
			if ( thisApprover != null && thisApprover.length() > 0 ){
				approver.setAllApprovers(allApprovers.toString() );
			}

			if ( lastSeq > 0 ){
				// determine all sequences

				prevSeq = currentSeq - firstSeq;

				if (prevSeq == 0)
					prevSeq = 1;

				nextSeq = currentSeq + 1;

				if (nextSeq > lastSeq)
					nextSeq = lastSeq;

				String[] approvers = new String[lastSeq];
				approvers = allApprovers.toString().split(",");

				approver.setApprover(approvers[currentSeq-1]);
				approver.setSeq(Integer.toString(currentSeq));

				approver.setFirstApprover(approvers[firstSeq-1]);
				approver.setFirstSequence(Integer.toString(firstSeq));

				approver.setPreviousApprover(approvers[prevSeq-1]);
				approver.setPreviousSequence(Integer.toString(prevSeq));

				approver.setNextApprover(approvers[nextSeq-1]);
				approver.setNextSequence(Integer.toString(nextSeq));

				approver.setLastApprover(approvers[lastSeq-1]);
				approver.setLastSequence(Integer.toString(lastSeq));
			}
	}
	catch (Exception e){
		out.println( e.toString() );
	}

%>

</body>
</html>