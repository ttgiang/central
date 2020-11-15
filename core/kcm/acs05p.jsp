<%@ include file="./acs00.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />

    <!-- Bootstrap core CSS -->
    <link href="../bs-dist/css/bootstrap.css" rel="stylesheet">
	 <link href="../bs-css/docs.min.css" rel="stylesheet">

	<style type="text/css">

		.container {
			max-width: 100%;
			-webkit-print-color-adjust: exact;
		}

		.form-group {
			width: 100%;
		}
		.col-sm-4 {
			width: 100%;
		}

		.lead14 {
			font-size: 14px;
		}

		.badge {
			display: inline-block;
			min-width: 10px;
			padding: 3px 7px;
			font-size: 12px;
			font-weight: bold;
			line-height: 1;
			color: white;
			text-align: center;
			white-space: nowrap;
			vertical-align: baseline;
			background-color: #E87B10;
			border-radius: 10px;
		}

		.text-muted {
			font-size: 24px;
			color: #999;
		}


		.table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
			padding: 20px;
			line-height: 1.428571429;
			vertical-align: top;
			border-top: 1px solid #DDD;
			border-right: 1px solid #DDD;
		}

		a:visited {TEXT-DECORATION: none;}
		a:hover {COLOR: #E87B10; TEXT-DECORATION: none; }

		.panelx {
			margin-bottom: 20px;
			background-color: white !important;
			border: 1px solid transparent;
			border-color: gray;
			border-radius: 4px;
			-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
			box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
		}

		.panel-HAW > .panel-heading {
			color: white !important;
			background-color: #91004B !important;
			border-color: #91004B;
			-webkit-print-color-adjust: exact;
		}

		.panel-HIL > .panel-heading {
			color: white !important;
			background-color: #D52B1E !important;
			border-color: #D52B1E;
			-webkit-print-color-adjust: exact;
		}

		.panel-HON > .panel-heading {
			color: white !important;
			background-color: #00747A !important;
			border-color: #00747A;
			-webkit-print-color-adjust: exact;
		}

		.panel-KAP > .panel-heading {
			color: white !important;
			background-color: #002395 !important;
			border-color: #002395;
			-webkit-print-color-adjust: exact;
		}

		.panel-KAU > .panel-heading {
			color: white !important;
			background-color: #7D5CC6 !important;
			border-color: #7D5CC6;
			-webkit-print-color-adjust: exact;
		}

		.panel-LEE > .panel-heading {
			color: white !important;
			background-color: #3D7EDB !important;
			border-color: #3D7EDB;
			-webkit-print-color-adjust: exact;
		}

		.panel-MAN > .panel-heading {
			color: white !important;
			background-color: #024731 !important;
			border-color: #024731;
			-webkit-print-color-adjust: exact;
		}

		.panel-UHMC > .panel-heading {
			color: white !important;
			background-color: #005172 !important;
			border-color: #005172;
			-webkit-print-color-adjust: exact;
		}

		.panel-WIN > .panel-heading {
			color: white !important;
			background-color: #7AB800 !important;
			border-color: #7AB800;
			-webkit-print-color-adjust: exact;
		}

		.panel-WOA > .panel-heading {
			color: white !important;
			background-color: #A71930 !important;
			border-color: #A71930;
			-webkit-print-color-adjust: exact;
		}

	</style>

  <style type="text/css">
/*<![CDATA[*/
  html{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;}body{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;line-height:1;color:black;background:white;}div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;}blockquote{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;quotes:"" "";}pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,font,img,ins,kbd{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;}q{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;quotes:"" "";}s,samp,small,strike,strong,sub,sup,tt,var,dl,dt,dd{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;}ol,ul{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;list-style:none;}li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td{margin:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:top;}:focus{outline:0;}table{border-collapse:separate;border-spacing:0;}caption,th,td{text-align:left;font-weight:normal;}blockquote:before,blockquote:after,q:before,q:after{content:"";}
  /*]]>*/
  </style>
  <style type="text/css">
/*<![CDATA[*/
  body{font-size:75%;background:#fff;font-family:Helvetica, Arial, sans-serif;}h1{font-size:2.2em;line-height:1;margin-bottom:0.5em;}h2{font-size:2em;font-weight:normal;margin-bottom:0.75em;}h3{font-size:1.5em;line-height:1;margin-bottom:1em;}h4{font-size:1.167em;line-height:1.25em;}h5{font-size:1.083em;font-weight:bold;margin-bottom:1em;}h6{font-size:1em;font-weight:bold;margin-bottom:0;color:#000;}h7{font-size:0.916em;text-transform:uppercase;}p{margin:0 0 1.5em;line-height:1.25em;}p img.left{float:left;margin:1.5em 1.5em 1.5em 0;padding:0;}p img.right{float:right;margin:1.5em 0 1.5em 1.5em;}a,a:visited{color:#2c61e6;text-decoration:none;}a:hover{text-decoration:underline;}a:active{color:#2c61e6;}a.disabled{text-decoration:none;color:#999;pointer:none;}a.disabled:hover,a.disabled:visited,a.disabled:active{text-decoration:none;color:#999;}blockquote{margin:1.5em;color:#666;font-style:italic;}strong{font-weight:bold;}em{font-style:italic;}dfn{font-style:italic;font-weight:bold;}sup,sub{line-height:0;}address{margin:0 0 1.5em;font-style:italic;}del{color:#666;}pre{margin:1.5em 0;white-space:pre;font:1em "andale mono", "lucida console", monospace;line-height:1.5;}code,tt{font:1em "andale mono", "lucida console", monospace;line-height:1.5;}li ul,li ol{margin:0 1.5em;}ul{margin:0 1.5em 1.5em 1.5em;list-style-type:disc;}ol{margin:0 1.5em 1.5em 1.5em;list-style-type:decimal;}dl{margin:0 0 1.5em 0;}dl dt,th{font-weight:bold;}dd{margin-left:1.5em;}thead th{background:#c3d9ff;}tr.even td{background:#e5ecf9;}tfoot{font-style:italic;}caption{background:#eee;}
  /*]]>*/
  </style>
  <style type="text/css">
/*<![CDATA[*/

  .gwt-Reference-chrome{height:5px;width:5px;zoom:1;}.gwt-Button{margin:0;padding:3px 5px;text-decoration:none;font-size:small;cursor:pointer;cursor:hand;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;border:1px outset #ccc;}.gwt-Button:active{border:1px inset #ccc;}.gwt-Button:hover{border-color:#9cf #69e #69e #7af;}.gwt-Button[disabled]{cursor:default;color:#888;}.gwt-Button[disabled]:hover{border:1px outset #ccc;}.gwt-CheckBox-disabled{color:#888;}.gwt-DecoratorPanel .topCenter,.gwt-DecoratorPanel .bottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x;}.gwt-DecoratorPanel .middleLeft,.gwt-DecoratorPanel .middleRight{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DecoratorPanel .topLeftInner,.gwt-DecoratorPanel .topRightInner,.gwt-DecoratorPanel .bottomLeftInner,.gwt-DecoratorPanel .bottomRightInner{width:5px;height:5px;zoom:1;}.gwt-DecoratorPanel .topLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 0;}.gwt-DecoratorPanel .topRight{background:url(gwt/standard/images/corner.png) no-repeat -5px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px 0;}.gwt-DecoratorPanel .bottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -5px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -5px;}.gwt-DecoratorPanel .bottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -5px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -5px;}* html .gwt-DecoratorPanel .topLeftInner,* html .gwt-DecoratorPanel .topRightInner,* html .gwt-DecoratorPanel .bottomLeftInner,* html .gwt-DecoratorPanel .bottomRightInner{width:5px;height:5px;overflow:hidden;}.gwt-DialogBox .Caption{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;padding:4px 4px 4px 8px;cursor:default;border-bottom:1px solid #bbb;border-top:5px solid #e3e3e3;}.gwt-DialogBox .dialogMiddleCenter{padding:3px;background:white;}.gwt-DialogBox .dialogBottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x 0 -4px;-background:url(gwt/standard/images/hborder_ie6.png) repeat-x 0 -4px;}.gwt-DialogBox .dialogMiddleLeft{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DialogBox .dialogMiddleRight{background:url(gwt/standard/images/vborder.png) repeat-y -4px 0;-background:url(gwt/standard/images/vborder_ie6.png) repeat-y -4px 0;}.gwt-DialogBox .dialogTopLeftInner{width:5px;zoom:1;}.gwt-DialogBox .dialogTopRightInner{width:8px;zoom:1;}.gwt-DialogBox .dialogBottomLeftInner,.gwt-DialogBox .dialogBottomRightInner{width:5px;height:8px;zoom:1;}.gwt-DialogBox .dialogTopLeft{background:url(gwt/standard/images/corner.png) no-repeat -13px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -13px 0;}.gwt-DialogBox .dialogTopRight{background:url(gwt/standard/images/corner.png) no-repeat -18px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -18px 0;}.gwt-DialogBox .dialogBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -15px;}.gwt-DialogBox .dialogBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -15px;}* html .gwt-DialogBox .dialogTopLeftInner{width:5px;overflow:hidden;}* html .gwt-DialogBox .dialogTopRightInner{width:8px;overflow:hidden;}* html .gwt-DialogBox .dialogBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-DialogBox .dialogBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-DisclosurePanel .header,.gwt-DisclosurePanel .header a,.gwt-DisclosurePanel .header td{text-decoration:none;color:black;cursor:pointer;cursor:hand;}.gwt-DisclosurePanel .content{border-left:3px solid #e3e3e3;padding:4px 0 4px 8px;margin-left:6px;}.gwt-Frame{border-top:2px solid #666;border-left:2px solid #666;border-right:2px solid #bbb;border-bottom:2px solid #bbb;}.gwt-HorizontalSplitPanel .hsplitter{cursor:move;border:0;background:#91c0ef url(gwt/standard/images/vborder.png) repeat-y;}.gwt-VerticalSplitPanel .vsplitter{cursor:move;border:0;background:#91c0ef url(gwt/standard/images/hborder.png) repeat-x;}.gwt-Hyperlink{display:inline;}.gwt-MenuBar,.gwt-MenuBar .gwt-MenuItem{cursor:default;}.gwt-MenuBar .gwt-MenuItem-selected{background:#cdcdcd;}.gwt-MenuBar-horizontal{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;border:1px solid #bbb;}.gwt-MenuBar-horizontal .gwt-MenuItem{padding:0 10px;vertical-align:bottom;color:#666;font-weight:bold;}.gwt-MenuBar-horizontal .gwt-MenuItemSeparator{width:1px;padding:0;margin:0;border:0;border-left:1px solid #888;background:white;}.gwt-MenuBar-horizontal .gwt-MenuItemSeparator .menuSeparatorInner{width:1px;height:1px;background:white;}.gwt-MenuBar-vertical{margin-top:0;margin-left:0;background:white;}.gwt-MenuBar-vertical table{border-collapse:collapse;}.gwt-MenuBar-vertical .gwt-MenuItem{padding:4px 14px 4px 1px;}.gwt-MenuBar-vertical .gwt-MenuItemSeparator{padding:2px 0;}.gwt-MenuBar-vertical .gwt-MenuItemSeparator .menuSeparatorInner{height:1px;padding:0;border:0;border-top:1px solid #777;background:#dde;overflow:hidden;}.gwt-MenuBar-vertical .subMenuIcon{padding-right:4px;}.gwt-MenuBar-vertical .subMenuIcon-selected{background:#cdcdcd;}.gwt-MenuBarPopup{margin:0 0 0 3px;}.gwt-MenuBarPopup .menuPopupTopCenter{background:url(gwt/standard/images/hborder.png) 0 -12px repeat-x;}.gwt-MenuBarPopup .menuPopupBottomCenter{background:url(gwt/standard/images/hborder.png) 0 -13px repeat-x;-background:url(gwt/standard/images/hborder_ie6.png) 0 -13px repeat-x;}.gwt-MenuBarPopup .menuPopupMiddleLeft{background:url(gwt/standard/images/vborder.png) -12px 0 repeat-y;-background:url(gwt/standard/images/vborder_ie6.png) -12px 0 repeat-y;}.gwt-MenuBarPopup .menuPopupMiddleRight{background:url(gwt/standard/images/vborder.png) -13px 0 repeat-y;-background:url(gwt/standard/images/vborder_ie6.png) -13px 0 repeat-y;}.gwt-MenuBarPopup .menuPopupTopLeftInner{width:5px;height:5px;zoom:1;}.gwt-MenuBarPopup .menuPopupTopRightInner{width:8px;height:5px;zoom:1;}.gwt-MenuBarPopup .menuPopupBottomLeftInner{width:5px;height:8px;zoom:1;}.gwt-MenuBarPopup .menuPopupBottomRightInner{width:8px;height:8px;zoom:1;}.gwt-MenuBarPopup .menuPopupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -36px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -36px;}.gwt-MenuBarPopup .menuPopupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -36px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -36px;}.gwt-MenuBarPopup .menuPopupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -41px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -41px;}.gwt-MenuBarPopup .menuPopupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -41px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -41px;}* html .gwt-MenuBarPopup .menuPopupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-PasswordTextBox{padding:2px;}.gwt-PasswordTextBox-readonly,.gwt-RadioButton-disabled{color:#888;}.gwt-DecoratedPopupPanel .popupMiddleCenter{padding:3px;background:#e3e3e3;}.gwt-DecoratedPopupPanel .popupTopCenter{background:url(gwt/standard/images/hborder.png) repeat-x;}.gwt-DecoratedPopupPanel .popupBottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x 0 -4px;-background:url(gwt/standard/images/hborder_ie6.png) repeat-x 0 -4px;}.gwt-DecoratedPopupPanel .popupMiddleLeft{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DecoratedPopupPanel .popupMiddleRight{background:url(gwt/standard/images/vborder.png) repeat-y -4px 0;-background:url(gwt/standard/images/vborder_ie6.png) repeat-y -4px 0;}.gwt-DecoratedPopupPanel .popupTopLeftInner{width:5px;height:5px;zoom:1;}.gwt-DecoratedPopupPanel .popupTopRightInner{width:8px;height:5px;zoom:1;}.gwt-DecoratedPopupPanel .popupBottomLeftInner{width:5px;height:8px;zoom:1;}.gwt-DecoratedPopupPanel .popupBottomRightInner{width:8px;height:8px;zoom:1;}.gwt-DecoratedPopupPanel .popupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -10px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -10px;}.gwt-DecoratedPopupPanel .popupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -10px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -10px;}.gwt-DecoratedPopupPanel .popupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -15px;}.gwt-DecoratedPopupPanel .popupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -15px;}* html .gwt-DecoratedPopupPanel .popupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-PopupPanel{background:white;}.gwt-PushButton-up{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:pointer;cursor:hand;}.gwt-PushButton-up-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-PushButton-up-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:default;opacity:0.5;filter:alpha(opacity\=40);zoom:1;}.gwt-PushButton-down{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px inset #666;cursor:pointer;cursor:hand;}.gwt-PushButton-down-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px inset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-PushButton-down-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px outset #ccc;cursor:default;opacity:0.5;filter:alpha(opacity\=40);zoom:1;}.hasRichTextToolbar{border:0;}.gwt-RichTextToolbar{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;border-bottom:1px solid #bbb;padding:3px;margin:0;}.gwt-RichTextToolbar .gwt-PushButton-up{padding:0 1px 0 0;margin-right:4px;margin-bottom:4px;border-width:1px;}.gwt-RichTextToolbar .gwt-PushButton-up-hovering{margin-right:4px;margin-bottom:4px;padding:0 1px 0 0;border-width:1px;}.gwt-RichTextToolbar .gwt-PushButton-down,.gwt-RichTextToolbar .gwt-PushButton-down-hovering{margin-right:4px;margin-bottom:4px;padding:0 0 0 1px;border-width:1px;}.gwt-RichTextToolbar .gwt-ToggleButton-up,.gwt-RichTextToolbar .gwt-ToggleButton-up-hovering{margin-right:4px;margin-bottom:4px;padding:0 1px 0 0;border-width:1px;}.gwt-RichTextToolbar .gwt-ToggleButton-down,.gwt-RichTextToolbar .gwt-ToggleButton-down-hovering{margin-right:4px;margin-bottom:4px;padding:0 0 0 1px;border-width:1px;}.gwt-StackPanel{border-bottom:1px solid #bbb;}.gwt-StackPanel .gwt-StackPanelItem{cursor:pointer;cursor:hand;font-weight:bold;font-size:1.3em;padding:3px;border:1px solid #bbb;border-bottom:0;background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;}.gwt-StackPanel .gwt-StackPanelContent{border:1px solid #bbb;border-bottom:0;background:white;padding:2px 2px 10px 5px;}.gwt-DecoratedStackPanel{border-bottom:1px solid #bbb;}.gwt-DecoratedStackPanel .gwt-StackPanelContent{border:1px solid #bbb;border-bottom:0;background:white;padding:2px 2px 10px 5px;}.gwt-DecoratedStackPanel .gwt-StackPanelItem{cursor:pointer;cursor:hand;}.gwt-DecoratedStackPanel .stackItemTopLeft{height:6px;width:6px;zoom:1;border-left:1px solid #bbb;background:#e4e4e4 url(gwt/standard/images/corner.png) no-repeat 0 -49px;-background:#e4e4e4 url(gwt/standard/images/corner_ie6.png) no-repeat 0 -49px;}.gwt-DecoratedStackPanel .stackItemTopRight{height:6px;width:6px;zoom:1;border-right:1px solid #bbb;background:#e4e4e4 url(gwt/standard/images/corner.png) no-repeat -6px -49px;-background:#e4e4e4 url(gwt/standard/images/corner_ie6.png) no-repeat -6px -49px;}.gwt-DecoratedStackPanel .stackItemTopLeftInner,.gwt-DecoratedStackPanel .stackItemTopRightInner{width:1px;height:1px;}* html .gwt-DecoratedStackPanel .stackItemTopLeftInner,* html .gwt-DecoratedStackPanel .stackItemTopRightInner{width:6px;height:6px;overflow:hidden;}.gwt-DecoratedStackPanel .stackItemTopCenter{background:url(gwt/standard/images/hborder.png) 0 -21px repeat-x;}.gwt-DecoratedStackPanel .stackItemMiddleLeft{background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;border-left:1px solid #bbb;}.gwt-DecoratedStackPanel .stackItemMiddleLeftInner,.gwt-DecoratedStackPanel .stackItemMiddleRightInner{width:1px;height:1px;}.gwt-DecoratedStackPanel .stackItemMiddleRight{background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;border-right:1px solid #bbb;}.gwt-DecoratedStackPanel .stackItemMiddleCenter{font-weight:bold;font-size:1.3em;background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;}.gwt-DecoratedStackPanel .gwt-StackPanelItem-first .stackItemTopRight,.gwt-DecoratedStackPanel .gwt-StackPanelItem-first .stackItemTopLeft{border:0;background-color:white;}.gwt-DecoratedStackPanel .gwt-StackPanelItem-below-selected .stackItemTopLeft,.gwt-DecoratedStackPanel .gwt-StackPanelItem-below-selected .stackItemTopRight{background-color:white;}.gwt-SuggestBox{padding:2px;display:block;}.gwt-SuggestBoxPopup{margin-left:3px;z-index:2;}.gwt-SuggestBoxPopup .item{color:424242;cursor:default;line-height:1.5em;padding:2px 6px;}.gwt-SuggestBoxPopup .item-selected{background:#cdcdcd;}.gwt-SuggestBoxPopup .suggestPopupContent{background:none repeat scroll 0 0 #ecf2fa;border:none;padding:0;}.gwt-SuggestBoxPopup .suggestPopupTopCenter{background-color:#ecf2fa;border-top:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupBottomCenter{background-color:#ecf2fa;border-bottom:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupMiddleLeft{background-color:#ecf2fa;border-left:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupMiddleRight{background-color:#ecf2fa;border-right:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupTopLeftInner{background-color:#ecf2fa;border-top:1px solid #aaa;border-left:1px solid #aaa;height:5px;width:5px;}.gwt-SuggestBoxPopup .suggestPopupTopRightInner{background-color:#ecf2fa;border-top:1px solid #aaa;border-right:1px solid #aaa;height:5px;width:8px;}.gwt-SuggestBoxPopup .suggestPopupBottomLeftInner{background-color:#ecf2fa;border-bottom:1px solid #aaa;border-left:1px solid #aaa;height:8px;width:5px;}.gwt-SuggestBoxPopup .suggestPopupBottomRightInner{background-color:#ecf2fa;border-bottom:1px solid #aaa;border-right:1px solid #aaa;height:8px;width:8px;}.gwt-SuggestBoxPopup .suggestPopupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -23px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -23px;}.gwt-SuggestBoxPopup .suggestPopupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -23px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -23px;}.gwt-SuggestBoxPopup .suggestPopupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -28px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -28px;}.gwt-SuggestBoxPopup .suggestPopupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -28px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -28px;}* html .gwt-SuggestBoxPopup .suggestPopupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-TabBar .gwt-TabBarFirst,.gwt-DecoratedTabBar .gwt-TabBarFirst{width:5px;}.gwt-TabBar .gwt-TabBarItem{margin-left:6px;padding:3px 6px 3px 6px;cursor:pointer;cursor:hand;color:black;font-weight:bold;text-align:center;background:#e3e3e3;}.gwt-TabBar .gwt-TabBarItem-selected{cursor:default;background:#bcbcbc;}.gwt-TabBar .gwt-TabBarItem-disabled{cursor:default;color:#999;}.gwt-TabPanelBottom{border-color:#bcbcbc;border-style:solid;border-width:3px 2px 2px;overflow:hidden;padding:6px;}.gwt-DecoratedTabBar .gwt-TabBarItem{border-collapse:collapse;margin-left:6px;}.gwt-DecoratedTabBar .tabTopCenter{padding:0;background:#e3e3e3;}.gwt-DecoratedTabBar .tabTopLeft{padding:0;zoom:1;background:url(gwt/standard/images/corner.png) no-repeat 0 -55px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -55px;}.gwt-DecoratedTabBar .tabTopRight{padding:0;zoom:1;background:url(gwt/standard/images/corner.png) no-repeat -6px -55px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -6px -55px;}.gwt-DecoratedTabBar .tabTopLeftInner,.gwt-DecoratedTabBar .tabTopRightInner{width:6px;height:6px;}* html .gwt-DecoratedTabBar .tabTopLeftInner,* html .gwt-DecoratedTabBar .tabTopRightInner{width:6px;height:6px;overflow:hidden;}.gwt-DecoratedTabBar .tabMiddleLeft,.gwt-DecoratedTabBar .tabMiddleRight{width:6px;padding:0;background:#e3e3e3 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-DecoratedTabBar .tabMiddleLeftInner,.gwt-DecoratedTabBar .tabMiddleRightInner{width:1px;height:1px;}.gwt-DecoratedTabBar .tabMiddleCenter{padding:0 4px 2px 4px;cursor:pointer;cursor:hand;color:black;font-weight:bold;text-align:center;background:#e3e3e3 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopCenter{background:#747474;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopLeft{background-position:0 -61px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopRight{background-position:-6px -61px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleLeft,.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleRight{background:#bcbcbc url(gwt/standard/images/hborder.png) repeat-x 0 -2511px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleCenter{cursor:default;background:#bcbcbc url(gwt/standard/images/hborder.png) repeat-x 0 -2511px;color:white;}.gwt-DecoratedTabBar .gwt-TabBarItem-disabled .tabMiddleCenter{cursor:default;color:#999;}.gwt-TextArea-readonly,.gwt-TextBox-readonly,.datePickerDayIsFiller{color:#888;}.gwt-ToggleButton-up{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:pointer;cursor:hand;}.gwt-ToggleButton-up-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-ToggleButton-up-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:default;opacity:0.5;zoom:1;filter:alpha(opacity\=40);}.gwt-ToggleButton-down,.gwt-ToggleButton-down-hovering,.gwt-ToggleButton-down-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;}.gwt-ToggleButton-down{background-position:0 -513px;border:1px inset #ccc;cursor:pointer;cursor:hand;}.gwt-ToggleButton-down-hovering{background-position:0 -513px;border:1px inset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-ToggleButton-down-disabled{background-position:0 -513px;border:1px inset #ccc;cursor:default;opacity:0.5;zoom:1;filter:alpha(opacity\=40);}.gwt-Tree .gwt-TreeItem{padding:1px 0;margin:0;white-space:nowrap;cursor:hand;cursor:pointer;}.gwt-Tree .gwt-TreeItem-selected{background:#93c2f1 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-TreeItem .gwt-RadioButton input,.gwt-TreeItem .gwt-CheckBox input{margin-left:0;}* html .gwt-TreeItem .gwt-RadioButton input,* html .gwt-TreeItem .gwt-CheckBox input{margin-left:-4px;}.gwt-DateBox input{width:8em;}.dateBoxFormatError{background:#eed6d6;}.gwt-DatePicker{border:1px solid #888;cursor:default;}.gwt-DatePicker td,.datePickerMonthSelector td:focus{outline:none;}.datePickerDays{width:100%;background:white;}.datePickerDay,.datePickerWeekdayLabel,.datePickerWeekendLabel{font-size:75%;text-align:center;padding:4px;outline:none;}.datePickerWeekdayLabel,.datePickerWeekendLabel{background:#c1c1c1;padding:0 4px 2px;cursor:default;}.datePickerDay{padding:4px;cursor:hand;cursor:pointer;}.datePickerDayIsToday{border:1px solid black;padding:3px;}.datePickerDayIsWeekend{background:#eee;}.datePickerDayIsValue{background:#abf;}.datePickerDayIsDisabled{color:#aaa;font-style:italic;}.datePickerDayIsHighlighted{background:#dde;}.datePickerDayIsValueAndHighlighted{background:#ccf;}.datePickerMonthSelector{background:#c1c1c1;width:100%;}td.datePickerMonth{text-align:center;vertical-align:center;white-space:nowrap;font-size:70%;font-weight:bold;}.datePickerPreviousButton,.datePickerNextButton{font-size:120%;line-height:1em;cursor:hand;cursor:pointer;padding:0 4px;}

  .ks-menu-layout{white-space:nowrap;}.ks-menu-layout-menu .ks-page-sub-navigation{padding:0 0 0 9px;}.ks-menu-layout-rightColumn{display:inline-block;padding-left:20px;white-space:normal;width:790px;}.ks-menu-layout-special-menu-item-panel{border-bottom:2px solid #dadada;border-top:1px solid #dadada;color:#333;cursor:pointer;padding-bottom:10px;padding-left:5px;padding-top:10px;}.ks-menu-layout-special-menu-item-panel a,.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel a{text-decoration:none;}.ks-menu-layout-special-menu-item-panel .KS-Basic-Menu-Item-Label{font-weight:bold;font-size:1.2em;}.ks-menu-layout-leftColumn{float:left;margin-top:5.2em;}.ks-menu-layout-menu .ks-page-sub-navigation-menu .KS-Basic-Menu-Toplevel-Item-Label{color:#333;font-size:1.1em;letter-spacing:0.04em;margin:0 0 3px;overflow:hidden;padding:10px 0 0 4px;text-transform:uppercase;white-space:nowrap;}.ks-menu-layout-menu .ks-page-sub-navigation-menu ul{margin:0;padding:0;}.ks-menu-layout-menu .ks-page-sub-navigation-menu li{list-style:none;line-height:1.3em;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Label{color:#707270;font-size:1em;padding-left:5px;letter-spacing:0.02em;line-height:1.4em;white-space:nowrap;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Label-Selected{color:white;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel{border-bottom:1px solid #d7d7d7;color:#333;cursor:pointer;padding:3px 10px 3px 5px;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel a:hover{color:white;cursor:pointer;text-decoration:none;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel-Hover{background-color:#889606;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Label-Hover{color:white;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel-Selected a:hover{cursor:pointer;color:white;}.ks-menu-layout-special-menu-item-panel a:hover,.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel a:hover{color:white;}.ks-menu-layout-menu .KS-Basic-Menu-Item-Panel-Selected{background-color:#636d05;}.content-warning{color:#c4951d;font-size:0.9em;}.content-info{color:black;}.tabLayout-ContentHeader{margin-left:20px;margin-right:20px;}.contentHeader-utilities .gwt-ListBox{background:none repeat scroll 0 0 #eee;border:1px solid #999;color:#2679c7;font-size:0.9em;margin-top:-6px;padding:1px;}
  .KS-Multiplicity-Composite{text-align:left;width:100%;vertical-align:top;}.KS-Multiplicity-Item{text-align:left;width:65%;margin-bottom:10px;border:1px solid black;}.KS-Multiplicity-Item-Header{background-color:#e8e8e8;text-align:left;border:1px solid #808080;width:100%;}.KS-Multiplicity-Link-Label{color:blue;font-size:70%;cursor:pointer;}.KS-Multiplicity-Display-Item{margin-left:5px;margin-bottom:1px;}
  .KS-Picker-Border{padding:10px;}.KS-Picker-Criteria-Text{font-weight:bold;}.KS-Advanced-Search-Link,.KS-Advanced-Search-Buttons{margin-top:1.2em;}
  .printPage .ks-menu-layout-leftColumn,.printPage .ks-button-primary,.printPage .ks-link-large,.printPage .contentHeader-utilities,.printPage .header-innerDiv,.printPage .header-appTitle{display:none;}.printPage .standard-content-padding{padding:0;}.printPage .ks-menu-layout-rightColumn{display:block;padding:0;}.printPage .sectionEditLink,.printPage .ks-customDropDown-titlePanel{display:none;}
  .KSProgressIndicator{padding:10px;}
  .KS-Radio{margin:2px;}.KS-Radio-Focus,.KS-Radio-Selected{color:#9b251c;}
  .KS-Rule-ReqCompList-box{background:#f1f1f2;padding-left:10px;padding-top:10px;width:800px;}.KS-Rule-ReqComp-header{font-weight:bold;}.KS-Rule-ReqCompList,.KS-Rule-FieldsList{margin-bottom:15px;margin-top:15px;}.KS-Rule-ReqComp-btn{margin-bottom:15px;}.KS-Rule-ReqComp-Custom-Widget-label{font-weight:bold;margin-top:25px;}

  .KS-Rule-Preview-Subrule-Box{background:#f1f1f2;border:1px solid #a8a6a6;padding-left:15px;padding-bottom:15px;margin-bottom:10px;}.KS-Rule-Preview-Subrule-Box .ks-form-module h6{font-weight:normal;}.KS-Rule-Preview-Subrule-header{font-weight:normal;width:400px;border-bottom:1px solid #a8a6a6;margin-top:10px;margin-bottom:5px;padding-bottom:5px;}.KS-Rule-Preview-Subrule-header-action{float:right;}.KS-Rule-Preview-Subrule-ul{padding-left:0;margin-top:0;margin-bottom:0;}.KS-Rule-Preview-Subrule-ORAND{color:#df7401;font-weight:bold;}.KS-Rule-Preview-Subrule-li{padding-top:5px;}
  .KS-Program-Rule-LogicView-ExpressionPanel{background:#999;padding:10px 5px 10px 10px;border:1px solid #000;margin-bottom:13px;}.KS-Program-Rule-LogicView-ExpressionText{height:100px;width:580px;padding:15px;font-size:20px;max-width:500px;}.KS-Program-Rule-LogicView-ButtonPanel{padding-top:10px;}.KS-Program-Rule-LogicView-Update-Button,.KS-Program-Rule-LogicView-Undo-Button{margin-left:10px;}.KS-Program-Rule-LogicView-RulePanel{background:#999;padding:30px 5px 30px 10px;border:1px solid #000;}.KS-Program-Rule-LogicView-Missing-Rules{color:red;}.KS-Program-Rule-LogicView-Rule-ID{background-color:#e0e0e0;padding:10pt;font-weight:bold;font-size:14pt;margin-left:20px;}
  .KS-Program-Rule-ObjectView-RulePanel{background:#999;padding:30px 5px 30px 10px;border:1px solid #000;}.KS-Program-Rule-ObjectView-ButtonPanel{padding:10px;}.KS-Program-Rule-ObjectView-OR-Button{background:url(images/RuleOr.png) no-repeat center top;margin-left:10px;}.KS-Program-Rule-ObjectView-AND-Button{background:url(images/RuleAnd.png) no-repeat center top;margin-left:10px;}.KS-Program-Rule-ObjectView-Group-Button{background:url(images/RuleGroup.png) no-repeat center top;margin-left:20px;}.KS-Program-Rule-ObjectView-Down-Button{background:url(images/RuleDown.png) no-repeat center top;margin-left:20px;white-space:nowrap;}.KS-Program-Rule-ObjectView-Up-Button{background:url(images/RuleUp.png) no-repeat center top;margin-left:10px;white-space:nowrap;}.KS-Program-Rule-ObjectView-Undo-Button{background:url(images/RuleUndo.png) no-repeat center top;margin-left:50px;}.KS-Program-Rule-ObjectView-Redo-Button{background:url(images/RuleRedo.png) no-repeat center top;margin-left:10px;}.KS-Program-Rule-ObjectView-Delete-Button{background:url(images/RuleDelete.png) no-repeat center top;margin-left:50px;}
  .KS-Rule-Preview-Box{border:1px solid #d7d7d7;margin-top:20px;padding:5px;width:650px;}.KS-Rule-Preview-header{font-weight:normal;margin-bottom:5px;padding:20px 20px 5px 5px;background:#f1f1f2;}.KS-Rule-Preview-header-action{float:right;}.KS-Rule-Preview-Box1{padding-left:5px;}.KS-Rule-Preview-NoRule{margin-bottom:20px;}.KS-Rule-Preview-subheader{font-weight:normal;padding-top:15px;padding-bottom:10px;}.KS-Rule-Preview-header-Subrule{font-weight:normal;width:600px;padding-top:15px;padding-bottom:15px;}.KS-Rule-Preview-Operator{font-weight:bold;padding-bottom:10px;padding-left:30px;font-size:12px;}.KS-Rule-Last-Preview-Spacer{marging-bottom:10px;}.KS-Rule-Preview-Add-Subrule{margin-bottom:25px;}
  .KS-Rules-Table{padding:0;border-width:1px;border-spacing:0;border-style:solid;border-color:black;border-collapse:collapse;max-width:800px;}.KS-Rules-Toggle-Button{height:20;width:40;text-align:center;}.KS-Rules-Toggle-Label{background:#039;color:white;height:20;width:40;text-align:center;}.KS-Rules-Table-Cell-ANDOR{font-weight:bold;}.KS-Rules-Table-Cell-Selected{background-color:#ff9;}.KS-Rules-Table-Cell-DeSelected{background-color:#fff;}.KS-ReqComp-Selected{background-color:#ff9;color:black;text-decoration:none;padding:15px;font-size:10pt;}.KS-ReqComp-DeSelected{background-color:#fff;color:black;text-decoration:none;padding:15px;font-size:10pt;}.KS-Toggle{vertical-align:middle;}.KS-ReqComp-Panel label{display:none;}.KS-Rules-Table-Cell-ID{background-color:#e0e0e0;padding:10pt;font-weight:bold;font-size:14pt;}.KS-Rules-URL-Link{margin-left:20px;font-size:8pt;color:#03c;text-decoration:underline;cursor:pointer;}.KS-Rules-URL-Link-Readonly{margin-left:20px;font-size:8pt;color:#999;text-decoration:underline;cursor:default;}
  .ks-header h3{margin:0;}.ks-heading-course-title h1{color:#666;display:block;font-size:2.333em;font-weight:normal;margin-bottom:0;padding:15px 0 10px 0;}.ks-heading-page-title h2{font-size:2em;color:#940b07;}.ks-heading-page-section h3{font-size:1.5em;color:#000;font-weight:normal;padding-bottom:4px;border-bottom:solid 2px #ccc;margin-bottom:0.5em;}h1.ks-layout-header{font-size:3em;color:#940b07;margin-bottom:0;}h2.ks-layout-header{color:#636d05;font-size:1.6em;margin-bottom:2px;padding-bottom:2px;}h3.ks-layout-header{border-bottom:1px dotted #bbb;color:#000;font-size:1.3em;font-weight:normal;letter-spacing:0.05em;margin-bottom:9px;}h4.ks-layout-header,h5.ks-layout-header,h6.ks-layout-header,h7.ks-layout-header{margin-bottom:0;}.header-underline{border-bottom:solid 2px #ccc;}h4.text-underline{font-size:1.1538em;font-weight:bold;font-family:Georgia;text-decoration:underline;}.ks-section-widget{padding-bottom:3px;}.ks-page-container{background-color:#fff;min-height:100%;position:relative;margin:20px 3%;-moz-box-shadow:0 0 10px #666;-webkit-box-shadow:0 0 10px #666;}.ks-page-banner{background-color:#eaeaea;padding-right:20px;}.ks-page-banner-title{border-left:solid 6px #999;padding-left:14px;margin-bottom:20px;}.ks-page-banner-actions{float:left;width:50%;}.ks-page-banner-workflow,.ks-page-banner-project{width:48%;float:left;margin-right:2%;}.ks-page-banner-workflow-menu,.ks-page-banner-project-menu{min-height:36px;color:#424242;border:solid 1px #b2b2b2;padding:6px;background-color:#f3f3f3;}.ks-page-banner-workflow-menu p,.ks-page-banner-project-menu p{font-size:0.916em;font-style:italic;margin-left:3px;margin-bottom:0;}.ks-page-banner-workflow-status{width:50%;float:right;padding:0;background:#e0e0e0 url(../images/icons/node.png) no-repeat 5px 5px;}.ks-page-banner-workflow-status p{margin:0 0 0 23px;padding:6px;color:#424242;min-height:38px;}.ks-page-banner-workflow-status p span{font-weight:bold;}.ks-page-banner-message{padding:0 20px;background-color:#eaeaea;}.ks-page-content{padding:20px;}.ks-message-static{background-color:#eddc91;color:#000;margin-bottom:10px;padding:6px 6px 6px 15px;position:relative;}.ks-message-static-margin{margin-bottom:1em;}.ks-message-static-image{display:inline;left:-9px;position:absolute;top:2px;}.ks-comments{padding:12px;margin-bottom:1em;line-height:1.25em;}.ks-comments:hover{background-color:#fffbc9;}.ks-comments-logged{width:25%;float:left;}.ks-comments-form{width:75%;float:right;text-align:right;}.ks-comments-meta{width:25%;float:left;}.ks-comments-text{width:58%;float:left;}.ks-comments-actions{width:15%;float:right;text-align:right;}#basic-modal-content{display:none;}#simplemodal-overlay{background-color:#000;}#simplemodal-container{width:850px;color:#333;background-color:#fff;border:6px solid #aaa;}#simplemodal-container a{color:#ddd;}#simplemodal-container a.modalCloseImg{background:url(../images/x.png) no-repeat;width:25px;height:29px;display:inline;z-index:9999;position:absolute;top:-12px;right:-12px;cursor:pointer;}.visible{display:block;}.hidden{display:none;}p.noted{margin:0 0 10px 0;color:#39b54a;font-family:Georgia;}.clearfix:after{content:" ";display:block;height:0;clear:both;visibility:hidden;overflow:hidden;}.clearfix{display:block;}.clear{clear:both;height:0;}.clearboth{clear:both;}.ks-form-bordered{border:1px solid #d2d8e3;margin-bottom:1em;}.ks-form-bordered-header{background-color:#e4e6f2;margin:0;padding:4px 6px;}.ks-form-bordered-header-title{color:#424242;display:table;float:left;font-size:1em;height:1%;letter-spacing:0.06em;line-height:1.6em;padding:0 0 0 5px;text-transform:uppercase;}.ks-form-bordered-header-title h4{margin:0;padding:0;}.ks-form-bordered-header-delete{float:right;margin-left:3px;width:12px;height:14px;}.ks-form-bordered-header-delete a{display:block;padding:14px 0 0 0;overflow:hidden;background:transparent url(../images/icons/delete_gray_12px.png) no-repeat right center;height:0 !important;height:14px;}.ks-form-bordered-header-help{float:right;margin-left:3px;width:14px;height:14px;}.ks-form-bordered-header-help a{display:block;padding:14px 0 0 0;overflow:hidden;background:url(../images/icons/help_gray_14px.png) no-repeat right center;height:0 !important;height:14px;}.ks-form-bordered-body{padding:10px 10px 0 10px;}.ks-form-course-format-advanced{background-color:#f1f1f1;margin-bottom:10px;}.ks-form-course-format-advanced-header{background:#fff;padding:4px;}.ks-form-course-format-advanced-body{padding:10px 10px 0 10px;}.ks-form-course-format-activity{padding:10px;margin-bottom:10px;max-width:450px;}.ks-form-course-format-activity-header{border-bottom:1px dotted #ccc;height:1.5em;margin-bottom:0.1em;padding:1px 0;position:relative;}.ks-form-course-format-activity-header-title{color:#424242;display:table;float:left;font-size:1.083em;font-weight:bold;height:1%;line-height:1.7em;text-transform:uppercase;}.ks-form-course-format-activity-header-title h5{margin-bottom:0;color:#424242;}.ks-form-course-format-activity-header-delete{float:right;margin-left:3px;width:12px;height:14px;}.ks-form-course-format-activity-header-delete a{-moz-border-radius:0 4px 0 4px;padding:3px 4px 1px;display:block;padding:14px 0 0 0;overflow:hidden;background:transparent url(../images/icons/delete_gray_12px.png) no-repeat right center;height:0 !important;height:12px;}.ks-form-course-format-activity-header-delete a:hover{background-image:url(../images/icons/delete_blue_12px.png);}.ks-form-course-format-activity-header-help{float:right;margin-left:3px;width:14px;height:14px;}.ks-form-course-format-activity-header-help a{display:block;padding:14px 0 0 0;overflow:hidden;background:url(../images/icons/help_gray_14px.png) no-repeat;height:0 !important;height:14px;}.ks-form-course-format-activity-header-help a:hover{background-image:url(../images/icons/help_blue_14px.png);}.ks-form-module{color:#444;margin-bottom:1em;clear:both;}.ks-form-module-group,.ks-form-module-solo{padding-bottom:5px;margin-bottom:0.1em;}.ks-form-module-fields{float:left;}.ks-form-module-elements{min-width:140px;margin-bottom:1px;float:left;margin-right:20px;line-height:1.4em;}.ks-form-required-for-submit{color:#999;font-size:0.9em;font-style:italic;font-weight:normal;margin-left:4px;}.ks-form-module-elements-required{color:red;}.ks-form-module-elements-inputs{border:solid 1px transparent;padding:2px;display:inline-block;}.ks-form-module-elements-instruction{font-size:1em;color:#000;display:block;line-height:1.4em;}.ks-form-header-title-actions{display:inline-block;float:right;margin-top:2px;line-height:1.2em;}.ks-form-module-elements-help a{-moz-border-radius:7px 7px 7px 7px;background-color:transparent;border:1px solid #ccc;color:#aaa;font-size:11px;font-weight:bold;margin:0 5px;padding:1px 3px 0;text-decoration:none;}.ks-form-module-elements-delete a{border:1px solid #ccc;color:#aaa;font-size:12px;font-weight:bold;padding:0 3px 1px;text-decoration:none;text-transform:lowercase;}.ks-form-module-elements-help a:hover,.ks-form-module-elements-delete a:hover{color:#2c61e6;border-color:#2c61e6;}.ks-form-module-elements-help-text{margin:2px 0 0 0;font-size:0.916em;color:#424242;display:block;}.ks-form-module-validation{float:left;font-size:1em;font-weight:bold;color:red;margin-right:10px;margin-left:0;}.ks-form-module-validation ul{background:transparent url(images/common/exclamation-red.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation li{margin-left:0;padding:3px 0;list-style:none;}.ks-form-module-validation-inline{font-size:1em;font-weight:bold;color:red;margin-left:0;float:left;margin-right:10px;}.ks-form-module-validation-errors ul{background:transparent url(images/common/exclamation-red.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation-warnings ul{background:transparent url(images/common/exclamation-diamond-frame.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation-inline li{margin-left:0;padding:3px 0;list-style:none;}.ks-form-module label,.ks-form-module h6,.ks-form-module .KS-Common-Title{display:block;font-weight:bold;color:#000;line-height:1.2em;}.ks-form-module label span a{font-weight:normal;margin-left:0.3em;}.ks-form-module-elements label{color:#000;display:block;font-weight:bold;line-height:1.9em;white-space:nowrap;}.ks-form-module-triple-line-margin{margin-top:3.6em;}.ks-form-module-double-line-margin{margin-top:2.4em;}.ks-form-module-single-line-margin{margin-top:1.2em;}.ks-form-module-single-line-margin-narrow{margin-top:0.4em;}.ks-form-module-no-line-margin{margin-top:0;}label.ks-form-module-elements-top-margin,h6.ks-form-module-elements-top-margin{font-size:1em;font-weight:bold;margin-top:0;}.ks-form-module-elements input[type="checkbox"]+label{display:inline;font-weight:normal;line-height:2em;white-space:nowrap;}.ks-form-module-elements input[type="radio"]+label{display:inline;white-space:nowrap;font-weight:normal;}.ks-form-module-elements input[type="text"]{border-bottom:#b5bdbd 1px solid;border-left:#b5bdbd 1px solid;padding-bottom:3px;padding-left:3px;border-top:#b5bdbd 1px solid;border-right:#b5bdbd 1px solid;padding-top:3px;margin-right:0.938em;}.ks-form-module-elements textarea{border:1px solid #b5bdbd;padding:3px;}.ks-form-module-elements select{border:1px solid #aaa;border:solid 1px #aaa;padding:3px;}.ks-form-required{color:red;font-size:14px;}.ks-form-show-advanced{background:transparent url(../images/right_arrow.png) no-repeat left center;padding-left:16px;}.ks-form-hide-advanced{background:transparent url(../images/down_arrow.png) no-repeat left center;padding-left:16px;}.ks-form-button-container{margin-bottom:10px;}a.ks-form-button-large,span.ks-form-button-large{text-decoration:none;background:#f3f3f3 url(images/common/plus_13px.png) no-repeat 6px center;padding:5px 8px 3px 22px;border:solid 1px #d5d5d5;line-height:23px;}a.ks-form-button-small,span.ks-form-button-small{text-decoration:none;font-size:0.9em;text-decoration:none;background:#f3f3f3 url(images/common/plus_13px.png) no-repeat 6px center;padding:5px 8px 3px 22px;border:solid 1px #d5d5d5;line-height:21px;}a:hover.ks-form-button-large,a:hover.ks-form-button-small,a:focus{text-decoration:underline;}span.disabled{background:#f3f3f3 url(../images/icons/plus_gray_13px.png) no-repeat 6px center;color:#888;}.error{background-color:#ffe0e9;}.error .ks-form-bordered-header{background-color:#f5d6df;}.warning{background-color:#f4e271;}.warning .ks-form-bordered-header{background-color:#f5d6df;}.invalid label,.invalid h6,.invalid legend,.invalid .KS-Common-Title,label.invalid,h6.invalid,legend.invalid,.ks-form-error-label{color:red;}.ks-form-warn-label{font-weight:normal;color:black;}.highlighted{background-color:#fffdd4;}.highlighted .ks-form-bordered-header{background-color:#f2f0c9;}.ks-page-sub-navigation-container .ks-page-sub-navigation-container{margin:0 20px;height:1%;}.ks-page-sub-navigation-container .ks-page-sub-navigation{border-bottom:solid 1px #ccc;padding:15px 0;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu{float:left;margin-right:35px;color:#666;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu .KS-Basic-Menu-Toplevel-Item-Label{font-size:0.916em;text-transform:uppercase;font-weight:bold;margin:0 0 3px 0;white-space:nowrap;overflow:hidden;color:#797979;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu ul{margin:0;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu li{list-style:none;line-height:1.3em;}a.ks-button-primary{border-bottom:#a1baf7 1px solid;border-left:#a1baf7 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#e4ebff;padding-left:15px;padding-right:15px;color:#2c61e6;font-size:1.16em;border-top:#a1baf7 1px solid;font-weight:bold;border-right:#a1baf7 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-primary:focus{color:#2c61e6;border:1px solid #2c61e6;background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);}a.ks-button-primary:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);border:1px solid #2c61e6;}.ks-button-primary-disabled{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#f8f8f8;padding-left:10px;padding-right:10px;color:#999;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-secondary{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#ececec;padding-left:10px;padding-right:10px;color:#2c61e6;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-secondary:focus,a.ks-button-secondary:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);border:1px solid #2c61e6;}.ks-button-secondary-disabled{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#f8f8f8;padding-left:10px;padding-right:10px;color:#999;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-primary-small{line-height:1.93em;text-decoration:none;background-color:#e4ebff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#e4ebff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#e4ebff,#bfd1ff);-moz-border-radius:4px 4px 4px 4px;-webkit-border-radius:3px;border:1px solid #a1baf7;padding:3px 8px 2px 8px;color:#2c61e6;font-size:1em;font-weight:bold;}a.ks-button-primary-small:focus,a.ks-button-primary-small:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);border:1px solid #2c61e6;}.ks-button-primary-small-disabled{-moz-border-radius:3px 3px 3px 3px;background-color:#f8f8f8;background-image:-moz-linear-gradient(-90deg,#fff,#ccc);border:1px solid #999;color:#999;font-size:1em;font-weight:bold;line-height:1.93em;padding:3px 8px 2px;text-decoration:none;}a.ks-button-secondary-small{line-height:1.93em;text-decoration:none;background-color:#eee;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid #999;padding:3px 8px 2px 8px;color:#2c61e6;font-size:1em;}a.ks-button-secondary-small:focus,a.ks-button-secondary-small:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);border:1px solid #2c61e6;}.ks-button-secondary-small-disabled{line-height:1.93em;text-decoration:none;background-color:#f8f8f8;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#ccc));background-image:-moz-linear-gradient(-90deg,#fff,#ccc);-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid #999;padding:3px 8px 2px 8px;color:#999;font-size:1em;}.ks-link-disabled,.ks-link-large-disabled{color:#999;}.ks-link-large{font-size:1.167em;line-height:2.15em;}.ks-help-popup{background-color:#ffe87c;padding:3px 3px 3px 3px;border:1px solid black;width:250px;}.ks-example-popup{width:300px;}.top-padding{padding-top:10px;}.ks-button-right-margin{margin-right:1em;}.ks-header-edit-link{font-size:0.6em;padding-left:1em;}.horizontal-component{width:50%;float:left;}.accessibility-hidden{position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden;}.ks-multiplicity-section-label{margin-top:0;margin-bottom:0;font-weight:bold;color:#000;}.test{display:inline;}.ks-bordered{border:1px solid #d2d8e3;}

  /*]]>*/
  </style>

  <title>Kuali Student: ENG 100 (Proposal) - STEP 2</title>

</head>

<%
	//
	// global data
	//
	String section = website.getRequestParameter(request,"section", "CI");
	String type = website.getRequestParameter(request,"type", "course");
	String selectedCampus = website.getRequestParameter(request,"cps", "");
	int print = website.getRequestParameter(request,"prt", 0);
	int printmode = print;

	if(print == 1){
		printmode = 0;
	}
	else{
		printmode = 1;
	}

	String pageTitle = "";

	String[] links = "Course Information,Governance,Course Logistics,Learning Objectives,Course Requisites,Active Dates,Financials,Authors & Collaborators,Supporting Documents".split(",");
	String[] args = "CI,GV,CL,LO,CR,AD,FI,AC,SD".split(",");

	if(!selectedCampus.equals("")){
		pageTitle = selectedCampus + " Campus";
	}
	else{
		for(int i = 0; i < links.length; i++){
			if(args[i].equals(section)){
				pageTitle = links[i];
			}
		}
	}	// selectedCampus

%>

<body>
  <div id="applicationPanel" style="height: 100%; width: 100%;">
    <div class="app-wrap">

      <div class="app-content">
        <table cellspacing="0" cellpadding="0" class="ks-menu-layout courseProposal">
          <tbody>
            <tr>
              <td align="left" style="vertical-align: top;">
                <div class="ks-menu-layout-rightColumn">
                  <div class="GL3CMX0BAH" style="">
                    <div>
                      <div class="GL3CMX0BEH">
                        <h3>ENG 100 (Proposal) - STEP 2</h3>
                      </div>
                    </div>
	                   <div style="clear: both"></div>
                  </div>

                  <div>
                    <div class="KS-LUM-Section">
                      <div class="ks-form-module">
                        <h2 class=
                        "KS-Section-Title KS-H2-Section-Title ks-layout-header"><%=pageTitle%></h2>

<%
	//
	// body content
	//

	int j = 0;

	if(type.equals("course")){
		sql = "SELECT DISTINCT type, friendly FROM kcm_vw_course WHERE section=? ORDER BY type desc, friendly";
		ps = conn.prepareStatement(sql);
		ps.setString(1,section);
		rs = ps.executeQuery();
		while(rs.next()){
			String friendly = rs.getString("friendly");
			%>
				<div class="bs-example">

					<div class="ks-form-module-group clearfix">
					  <div class="ks-form-module-fields">
						 <div class="ks-form-module-elements ks-form-module-single-line-margin">
						 <%
							out.println("<font color=\"#E87B10\"><strong>" + com.ase.aseutil.CCCM6100DB.getCCCM6100ByColumn(conn,friendly) + "&nbsp;("+friendly+")</strong></font>");
							%>
						 </div>
					  </div>

					  <div class="ks-form-module-validation-inline">
						 <div class="KS-Vertical-Flow ks-form-module-validation-errors"></div>
						 <div class="KS-Vertical-Flow ks-form-module-validation-warnings"></div>
					  </div>
					</div>

			<%
				j = 0;
				PreparedStatement ps2 = null;
				sql = "SELECT campus, seq, question FROM kcm_vw_course WHERE section=? AND friendly=? ORDER BY friendly, campus";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,section);
				ps2.setString(2,friendly);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){
					String cps = rs2.getString("campus");
					String question = rs2.getString("question");
					int seq = rs2.getInt("seq");

					%>
							<div class="panelx panel-<%=cps%>">
								<div class="panel-heading"><%=cps%></div>
								<div class="panel-body">
									<%=seq%>. <%=question%>
								</div>
							</div>
					<%

					++j;
				} // while

				%>

					<div class="panel panel-success">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							TBD - this is the agreed upon text/language/verbiage for this course question. When the system
							text is in place, campus defined text (above) will not show.
						</div>
					</div>

				</div>

				<%

				rs2.close();
				ps2.close();

		} // while
		rs.close();
		ps.close();

		if(section.equals("AD")){
			%>
					<div class="panel panel-danger">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							99. Approval Date
						</div>
					</div>

					<div class="panel panel-danger">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							99. Next Review Date
						</div>
					</div>

					<div class="panel panel-danger">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							99. Experimental Date
						</div>
					</div>

					<div class="panel panel-danger">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							99. End Date
						</div>
					</div>
			<%
		}
		else if (section.equals("AC")){
			%>
					<div class="panel panel-danger">
						<div class="panel-heading">SYSTEM</div>
						<div class="panel-body">
							99. Proposer
						</div>
					</div>
			<%
		}

		rs = null;
		ps = null;
	}
	else{

		//String campusItems = com.ase.aseutil.CampusDB.getCampusItems(conn,selectedCampus);
		//if(campusItems != null){
		//	campusItems = "\'" + campusItems.replace(",","\',\'") + "\'";
		//}
		PreparedStatement ps2 = null;
		sql = "SELECT question, friendly FROM kcm_vw_campus WHERE campus=? ORDER BY friendly, campus";
		ps2 = conn.prepareStatement(sql);
		ps2.setString(1,selectedCampus);
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next()){
			String friendly = rs2.getString("friendly");
			String question = rs2.getString("question");

			%>
				<div class="bs-example">

					<div class="ks-form-module-group clearfix">
					  <div class="ks-form-module-fields">
						 <div class="ks-form-module-elements ks-form-module-single-line-margin">
							<%=question%> (<%=friendly%>)
						 </div>
					  </div>
					</div>

					<div class="panel panel-primaryx">
						<div class="panel-heading"></div>
						<div class="panel-body">
							 <div>
								<div class="ks-form-module-group clearfix">
								  <div class="ks-form-module-fields clearfix">
									 <div class="ks-form-module-elements ks-form-module-single-line-margin">
										<textarea class=
										"gwt-TextArea KS-Textarea ks-textarea-width ks-textarea-medium-height finalExamRationale gwt-TextArea-readonly"
										id="gwt-uid-59" readonly="readonly">
						</textarea></span>
									 </div>
								  </div>
								  <div class="ks-form-module-validation">
									 <div class="KS-Vertical-Flow ks-form-module-validation-errors"></div>
									 <div class="KS-Vertical-Flow ks-form-module-validation-warnings"></div>
								  </div>
								</div>
							 </div>

						</div>
					</div>
				</div>
			<%

			++j;
		} // while

		rs2.close();
		ps2.close();

	} // type

%>


                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

</body>

    <!-- Bootstrap core JavaScript
    ================================================== -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="../bs-dist/js/bootstrap.js"></script>
	<script src="../bs-docs-assets/js/holder.js"></script>
	<script src="../bs-docs-assets/js/application.js"></script>
    <!-- Placed at the end of the document so the pages load faster -->

</html>
