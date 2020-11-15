<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>Classic Models Order Detail</title>
		<link rel="stylesheet" type="text/css" href="css/central.css">
	</head>

	<body>

		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="3" class="pageHeader">
					<table width="100%" border=" 0" cellspacing="0" cellpadding="0" style="display:inline">
						<tr>
							<td>
								<div class="pageHeaderText">
									Classic Models Order Details
								</div>
							</td>
							<!-- For Internet Explorer, this <td> must have no spaces or line breaks after the <img> -->
							<td class="pageHeader" width="100%" align="right"><img src="images/am.jpg" class="logo" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="leftMenu" valign="top">
					<img src="images/spacer.gif" height="1" width="100px" />
					<br />
					&nbsp;
				</td>
				<td class="content" valign="top">
					<img src="spacer" width="1" height="16" class="pagelinks" />
					<br />
					<c:if test="${!empty param.id}">
						<display:table name="${tableDetails[param.id]}" id="row" class="dataTable" cellspacing="0">
							<display:column property="id" title="ID" class="hidden" headerClass="hidden" media="html" />
							<display:column property="customerName" title="Customer" sortable="true" class="customer" headerClass="customer" />
							<display:column property="orderNumber" title="Order Number" sortable="true" class="orderNumber" headerClass="orderNumber" />
							<display:column property="orderDate" title="Order Date" sortable="true" format="{0,date,short}" class="orderDate" headerClass="orderDate" />
							<display:column property="shippedDate" title="Shipped Date" sortable="true" format="{0,date,short}" class="orderDate" headerClass="orderDate" />
							<display:column property="productName" title="Product" sortable="true" class="productName" headerClass="productName" />
							<display:column title="Action">
								<a href="http://images.google.com/images?q=${row.productName}">Images</a>
							</display:column>
							<display:column property="quantity" title="Quantity" sortable="true" class="quantity" headerClass="quantity" />
							<display:column property="total" title="Line Item Total" sortable="true" format="{0,number, currency}" class="lineItemTotal" headerClass="lineItemTotal" />
						</display:table>
					</c:if>
					<br />
					<a href="courses.jsp">Back to full list</a>

				</td>
				<td class="rightColumn" valign="top">
					&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>
