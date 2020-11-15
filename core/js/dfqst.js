<!--
	function cancelForm(table){
		aseForm.action = "dfqst.jsp?t=" + table;
		aseForm.submit();
	}

	function checkForm(){

		var tempObj;
		var dups = true;
		var items = document.aseForm.items.value;
		var fieldList = new Array();

		for (count=1;count<=items;count++){
			temp = "document.aseForm.s" + count;
			tempObj = eval(temp);
			if (tempObj.value>0){
				fieldList[count-1] = tempObj.value;
			}
		}

		if (arrHasDupes(fieldList)){
			alert("Duplicate sequence values are not allowed.");
			dups = false;
		}

		return dups;
	}

	function arrHasDupes(A) {

		var X = new Array();
		var i, j, n;

		n = A.length;
																// to ensure the fewest possible comparisons
		for (i=0; i<n; i++) {							// outer loop uses each item i at 0 through n
			for (j=i+1; j<n; j++) {						// inner loop only compares items j at i+1 to n
				if (A[i]==A[j]) return true;
			}
		}

		return false;
	}
-->
