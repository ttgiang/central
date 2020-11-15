<!--
<link href="jquery/media/dataTables/ColumnFilterWidgets.css" rel="stylesheet" type="text/css" />
<script src="jquery/scripts/ColumnFilterWidgets.js" type="text/javascript"></script>
<script src="jquery/scripts/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
-->

<!--
<script src="jquery/scripts/jquery.dataTables.editable.js" type="text/javascript"></script>
<script src="jquery/scripts/jquery.jeditable.js" type="text/javascript"></script>
<script src="jquery/scripts/jquery.validate.js" type="text/javascript"></script>
-->

<link rel="stylesheet" type="text/css" href="./js/qtip/jquery.qtip.min.css" />
<style type="text/css">
	.qtip-wiki{max-width: 440px;}

	.qtip-wiki .qtip-content{
		padding: 10px;
		line-height: 12.5px;
	}

	.qtip-wiki h1{
		margin: 0 0 7px;
		font-size: 1.5em;
		line-height: 1em;
	}

	.qtip-wiki img{ padding: 0 10px 0 0; }

	.qtip-wiki p{ margin-bottom: 9px; }
	.qtip-wiki .note{ margin-bottom: 0; font-style: italic; color: #888; }
</style>

<script type="text/javascript" src="./js/qtip/jquery.qtip.min.js"></script>

<script class="example" type="text/javascript">

	// Create the tooltips only on document load
	$(document).ready(function()
	{
		$(document).ready(function () {
			/*

			used with top code

			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": <%=displayLength%>,
				 "bJQueryUI": true,
				 "sDom": 'W<"clear">lfrtip'
			})
			.rowGrouping({sGroupBy: "letter", bHideGroupingColumn: false})

			*/

			/*

			inline editing. works in terms of opening input box. need
			to work up updates.

			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": <%=displayLength%>,
				 "bJQueryUI": true
			}).makeEditable();

			*/

			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": <%=displayLength%>,
				 "bJQueryUI": true
			});

		});

		// Make sure to only match links to wikipedia with a rel tag
		//$('a[href*="wikipedia.org/"][rel]').each(function()
		$('a[href*="localhost:8080"][rel]').each(function()
		{
			// We make use of the .each() loop to gain access to each element via the "this" keyword...
			$(this).qtip(
			{
				content: {
					// Set the text to an image HTML string with the correct src URL to the loading image you want to use
					text: '<img class="throbber" src="./js/qtip/throbber.gif" alt="Loading..." />',
					ajax: {
						url: $(this).attr('rel') // Use the rel attribute of each element for the url to load
					},
					title: {
						text: 'CC Profile - ' + $(this).text(), // Give the tooltip a title using each elements text
						button: true
					}
				},
				position: {
					at: 'bottom center', // Position the tooltip above the link
					my: 'top center',
					viewport: $(window), // Keep the tooltip on-screen at all times
					effect: false // Disable positioning animation
				},
				show: {
					event: 'click',
					solo: true // Only show one tooltip at a time
				},
				hide: 'unfocus',
				style: {
					classes: 'qtip-wiki qtip-light qtip-shadow'
				}
			})
		})

		// Make sure it doesn't follow the link when we click it
		.click(function(event) { event.preventDefault(); });

	});

</script>
