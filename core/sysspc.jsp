<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sysspc.jsp	system space report
	*	2007.09.01
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "CC Space Utilization";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 999,
				 "bJQueryUI": true,
				 "bSort": true,

					"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {

						/*
						 * Calculate the total market share for all browsers in this table (ie inc. outside
						 * the pagination)
						 */
						//var iTotalMarket = 0;
						//for ( var i=0 ; i<aaData.length ; i++ )
						//{
						//		iTotalMarket += aaData[i][4]*1;
						//}

						/* Calculate the market share for browsers on this page */
						var rowsLast = 0;
						var reserveLast = 0;
						var dataLast = 0;
						var indexLast = 0;
						var unusedLast = 0;
						var rowsDiff = 0;
						var reserveDiff = 0;
						var dataDiff = 0;
						var indexDiff = 0;
						var unusedDiff = 0;

						for ( var i=iStart ; i<iEnd ; i++ )
						{
							rowsLast += parseFloat(aaData[aiDisplay[i]][1]);
							reserveLast += parseFloat(aaData[aiDisplay[i]][2]);
							dataLast += parseFloat(aaData[aiDisplay[i]][3]);
							indexLast += parseFloat(aaData[aiDisplay[i]][4]);
							unusedLast += parseFloat(aaData[aiDisplay[i]][5]);
							rowsDiff += parseFloat(aaData[aiDisplay[i]][6]);
							reserveDiff += parseFloat(aaData[aiDisplay[i]][7]);
							dataDiff += parseFloat(aaData[aiDisplay[i]][8]);
							indexDiff += parseFloat(aaData[aiDisplay[i]][9]);
							unusedDiff += parseFloat(aaData[aiDisplay[i]][10]);
						}

						/* Modify the footer row to match what we want */
						var nCells = nRow.getElementsByTagName('th');
						nCells[0].innerHTML = 'TOTAL:';
						nCells[1].innerHTML = rowsLast.toFixed(2);
						nCells[2].innerHTML = reserveLast.toFixed(2);
						nCells[3].innerHTML = dataLast.toFixed(2);
						nCells[4].innerHTML = indexLast.toFixed(2);
						nCells[5].innerHTML = unusedLast.toFixed(2);
						nCells[6].innerHTML = rowsDiff.toFixed(2);
						nCells[7].innerHTML = reserveDiff.toFixed(2);
						nCells[8].innerHTML = dataDiff.toFixed(2);
						nCells[9].innerHTML = indexDiff.toFixed(2);
						nCells[10].innerHTML = unusedDiff.toFixed(2);
					}
			});
		});
	</script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){


		/*
			STEP 1 - update table 01 with the current space data

				delete from zzzTableSpaceUsed01;

				exec sp_msforeachtable
				@command1 = "insert into zzzTableSpaceUsed01([name],[rows],[reserved],[data],[index_size],[unused]) EXEC sp_spaceused '?'";

				update zzzTableSpaceUsed01 SET
					[reserved_int] = cast(substring([reserved],1,charindex(' ', [reserved])) as int),
					[data_int] = cast(substring([data],1,charindex(' ', [data])) as int),
					[index_size_int] = cast(substring([index_size],1,charindex(' ', [index_size])) as int),
					[unused_int] = cast(substring([unused],1,charindex(' ', [unused])) as int),
					[dte] = getdate();


			STEP 2 - this is done only once to get data into table 02 for processing

				delete from zzzTableSpaceUsed02;

				insert into zzzTableSpaceUsed02([name],[rows_last],[reserved_int_last],[data_int_last],[index_size_int_last],[unused_int_last],dte_last)
				select [name],[rows],[reserved_int],[data_int],[index_size_int],[unused_int],getdate()
				from zzzTableSpaceUsed01

			STEP 3 - run below

		*/

		String process = website.getRequestParameter(request,"process","");
		String formName = website.getRequestParameter(request,"formName","");

		if (formName.equals("aseForm") && process.equals("Process") && Skew.confirmEncodedValue(request)){
			updateSpaceUtilization(conn);
			processPage = true;
		}
		else{
			processPage = false;
		}

	}

	if (processPage){
%>

	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>Name</th>
							  <th style="text-align:right">Rows<br>Last</th>
							  <th style="text-align:right">Reserve<br>Last</th>
							  <th style="text-align:right">Data<br>Last</th>
							  <th style="text-align:right">Index<br>Last</th>
							  <th style="text-align:right">Unused<br>Last</th>
							  <th style="text-align:right">Rows<br>+/-</th>
							  <th style="text-align:right">Reserve<br>+/-</th>
							  <th style="text-align:right">Data<br>+/-</th>
							  <th style="text-align:right">Index<br>+/-</th>
							  <th style="text-align:right">Unused<br>+/-</th>
						 </tr>
					</thead>
					<tbody>
						<%
							String sql = "SELECT name, rows_last, reserved_int_last, data_int_last, index_size_int_last, unused_int_last, dte_diff, rows_diff, reserved_int_diff, data_int_diff, index_size_int_diff, unused_int_diff "
								+ "FROM zzzTableSpaceUsed02 ORDER BY name ";
							PreparedStatement ps = conn.prepareStatement(sql);
							ResultSet rs = ps.executeQuery();
							while(rs.next()){
								String tab = AseUtil.nullToBlank(rs.getString("name")).toLowerCase();
								tab = tab.replace("tbl","").replace("temp","t_").replace("course","c_");
								%>
								  <tr>
									 <td><%=tab%></td>
									 <td style="text-align:right"><%=rs.getInt("rows_last")%></td>
									 <td style="text-align:right"><%=rs.getInt("reserved_int_last")%></td>
									 <td style="text-align:right"><%=rs.getInt("data_int_last")%></td>
									 <td style="text-align:right"><%=rs.getInt("index_size_int_last")%></td>
									 <td style="text-align:right"><%=rs.getInt("unused_int_last")%></td>
									 <td style="text-align:right"><%=rs.getInt("rows_diff")%></td>
									 <td style="text-align:right"><%=rs.getInt("reserved_int_diff")%></td>
									 <td style="text-align:right"><%=rs.getInt("data_int_diff")%></td>
									 <td style="text-align:right"><%=rs.getInt("index_size_int_diff")%></td>
									 <td style="text-align:right"><%=rs.getInt("unused_int_diff")%></td>
								  </tr>
								<%
							}
							rs.close();
							ps.close();
						%>
					</tbody>

					<tfoot>
						<tr>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
							<th style="text-align:right"></th>
						</tr>
					</tfoot>

			  </table>
		 </div>
	  </div>

<%
	} // processPage
%>

		<%
			if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		%>
				<form method="post" action="sysspc.jsp" name="aseForm">
				  <table id="jquery" class="display">
						 <tr>
							  <td>
								<% out.println(Skew.showInputScreen(request,true)); %>
								<br><input type="submit" class="input" name="process" id="process" value="Process">
								<input type="hidden" class="input" name="formName" id="formName" value="aseForm">
							  </td>
						 </tr>
					</table>
				</form>
		<%
			}
		%>

<%
	asePool.freeConnection(conn,"sysspc","SYSADM");
%>

<%!

	//
	// updateSpaceUtilization
	//
	public static int updateSpaceUtilization(Connection conn) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			AseUtil ae = new AseUtil();

			String sql = "SELECT z01.name, z01.rows, z01.reserved_int, z01.data_int, z01.index_size_int, z01.unused_int, z01.dte,"
				+ "z02.dte_last, z02.rows_last, z02.reserved_int_last, z02.data_int_last, z02.index_size_int_last, "
				+ "z02.unused_int_last "
				+ "FROM zzzTableSpaceUsed01 AS z01 INNER JOIN zzzTableSpaceUsed02 AS z02 ON z01.name = z02.name "
				+ "ORDER BY z01.name";
			PreparedStatement ps01 = conn.prepareStatement(sql);
			ResultSet rs01 = ps01.executeQuery();
			while(rs01.next()){
				String name = AseUtil.nullToBlank(rs01.getString("name"));
				int rows = NumericUtil.getInt(rs01.getInt("rows"),0);
				int reserved_int = NumericUtil.getInt(rs01.getInt("reserved_int"),0);
				int data_int = NumericUtil.getInt(rs01.getInt("data_int"),0);
				int index_size_int = NumericUtil.getInt(rs01.getInt("index_size_int"),0);
				int unused_int = NumericUtil.getInt(rs01.getInt("unused_int"),0);
				String dte = ae.ASE_FormatDateTime(rs01.getString("dte"),Constant.DATE_DATETIME);

				int rows_last = NumericUtil.getInt(rs01.getInt("rows_last"),0);
				int reserved_int_last = NumericUtil.getInt(rs01.getInt("reserved_int_last"),0);
				int data_int_last = NumericUtil.getInt(rs01.getInt("data_int_last"),0);
				int index_size_int_last = NumericUtil.getInt(rs01.getInt("index_size_int_last"),0);
				int unused_int_last = NumericUtil.getInt(rs01.getInt("unused_int_last"),0);

				int rows_diff = rows - rows_last;
				int reserved_int_diff = reserved_int - reserved_int_last;
				int data_int_diff = data_int - data_int_last;
				int index_size_int_diff = index_size_int - index_size_int_last;
				int unused_int_diff = unused_int - unused_int_last;

				int date_diff = 0;

 				sql = "update zzzTableSpaceUsed02 set "
 						+ "rows_diff=?, reserved_int_diff=?, data_int_diff=?, index_size_int_diff=?, unused_int_diff=?, "
 						+ "rows_last=?, reserved_int_last=?, data_int_last=?, index_size_int_last=?, unused_int_last=?, dte_last=?, dte_diff=? where name=?";
				PreparedStatement ps02 = conn.prepareStatement(sql);
				ps02.setInt(1,rows_diff);
				ps02.setInt(2,reserved_int_diff);
				ps02.setInt(3,data_int_diff);
				ps02.setInt(4,index_size_int_diff);
				ps02.setInt(5,unused_int_diff);

				ps02.setInt(6,rows);
				ps02.setInt(7,reserved_int);
				ps02.setInt(8,data_int);
				ps02.setInt(9,index_size_int);
				ps02.setInt(10,unused_int);

				ps02.setString(11,dte);
				ps02.setInt(12,date_diff);

				ps02.setString(13,name);
				rowsAffected += ps02.executeUpdate();
				ps02.close();

			}
			rs01.close();
			ps01.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("SysSpc: updateSpaceUtilization - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SysSpc: updateSpaceUtilization - " + e.toString());
		}

		return rowsAffected;
	}


%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>