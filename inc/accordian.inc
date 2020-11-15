<!-- accordion code: starts -->

<script src="../css-js/rico/src/rico.js" type="text/javascript"></script>
<script src="../css-js/rico/src/ricoEffects.js" type="text/javascript"></script>
<script src="../css-js/rico/src/ricoBehaviors.js" type="text/javascript"></script>
<script src="../css-js/rico/src/ricoComponents.js" type="text/javascript"></script>

<script type='text/javascript'>
	Rico.onLoad( function() {
	  new Rico.Accordion( $$('div.panelheader'), $$('div.panelContent'),{
						panelHeight:100,
						hoverClass: 'panelHover',
						selectedClass: 'panelSelected'
					});
	});
</script>

<style>

#accordionExample {
	border : 1px solid #4f4f4f;
	width: 600px;
}

.panelheader{
	background-image: url('../css-js/rico/client/images/example1_panelBG.png');
	height: 22px;
	color : #ECECEC;
	font-weight : normal;
	padding-left: 5px;
}

.panelHover {
	background-image: url('../css-js/rico/client/images/example1_panelBGHover.png');
	height: 22px;
	color : #ffffff;
	padding-left: 5px;
}

.panelClicked {
	background-image: url('../css-js/rico/client/images/example1_panelBGClick.png');
	height: 22px;
	color : #ffffff;
	padding-left: 5px;
}

.panelSelected {
	background-image: url('../css-js/rico/client/images/example1_panelBGSelected.png');
	height: 22px;
	color : #494949;
	font-weight : bold;
	padding-left: 5px;
}
.panelContent {
	background-image: url('../css-js/rico/client/images/example1_contentBG');
	background: #f8f8f8;
	overflow: auto;
}

</style>

<!-- accordion code: ends -->
