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
			background-color: white;
			border: 1px solid transparent;
			border-color: gray;
			border-radius: 4px;
			-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
			box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
		}

		.panel-HAW > .panel-heading {
			color: white;
			background-color: #91004B;
			border-color: #91004B;
		}

		.panel-HIL > .panel-heading {
			color: white;
			background-color: #D52B1E;
			border-color: #D52B1E;
		}

		.panel-HON > .panel-heading {
			color: white;
			background-color: #00747A;
			border-color: #00747A;
		}

		.panel-KAP > .panel-heading {
			color: white;
			background-color: #002395;
			border-color: #002395;
		}

		.panel-KAU > .panel-heading {
			color: white;
			background-color: #7D5CC6;
			border-color: #7D5CC6;
		}

		.panel-LEE > .panel-heading {
			color: white;
			background-color: #3D7EDB;
			border-color: #3D7EDB;
		}

		.panel-MAN > .panel-heading {
			color: white;
			background-color: #024731;
			border-color: #024731;
		}

		.panel-UHMC > .panel-heading {
			color: white;
			background-color: #005172;
			border-color: #005172;
		}

		.panel-WIN > .panel-heading {
			color: white;
			background-color: #7AB800;
			border-color: #7AB800;
		}

		.panel-WOA > .panel-heading {
			color: white;
			background-color: #A71930;
			border-color: #A71930;
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
  .KS-Dropdown{border:1px solid #aaa;padding:3px;}.KS-Dropdown-Focus,.KS-Dropdown-Hover{background-color:#ecf2fa;border:1px solid #aaa;padding:3px;}.KS-Dropdown-Short .KS-Dropdown{max-width:300px;}
  .KS-ActionItemList-Link{font-size:0.8em;white-space:nowrap;}.KS-ActionItemList-Desc{white-space:nowrap;padding-left:5px;font-size:0.8em;}.KS-ActionItemList-ListPanel ul{margin:0;padding:0;list-style-type:none;padding-bottom:1em;width:300px;}.KS-ActionItemList-Title{font-weight:bold;margin-bottom:0.5em;}
  .KS-Basic-Menu-Panel ul{margin:0;padding:0;list-style:none;}.KS-Basic-Menu-Panel li{margin:0;padding:0;list-style:none;border:0;}.KS-Basic-Menu-Item-Panel.KS-Basic-Menu-Toplevel-Item-Panel{border-top:1px solid #333;}.KS-TabbedSectionLayout-Menu ul{padding-bottom:1em;border-style:solid;border-width:1px;border-color:#d5d5d5;background-color:#f4f5f4;-moz-border-radius:1em;-webkit-border-radius:1em;border-radius:1em;padding-left:20px;padding-right:10px;width:260px;}.KS-TabbedSectionLayout-Menu .KS-Basic-Menu-Item-Label-Selected{color:black;text-decoration:underline;}.KS-TabbedSectionLayout-Menu .KS-Basic-Menu-Item-Label{font-size:10pt;color:#315caa;cursor:pointer;}.KS-TabbedSectionLayout-Menu .KS-Basic-Menu-Toplevel-Item-Label{font-size:9pt;font-weight:bold;color:#8e181b;margin-top:20px;text-transform:uppercase;}.KS-CustomDropDown-Arrow{float:right;}.KS-CustomDropDown-Arrow .KS-Image{margin:2px;}.KS-CustomDropDown-Layout{width:100%;}.KS-Navigation-DropDown{width:230px;}.KS-Navigation-DropDown li{border-bottom:1px solid #cecece;line-height:1.8em;zoom:1;}.KS-Navigation-DropDown .KS-CustomDropDown-TitlePanel{cursor:pointer;width:230px;background-color:#e8e8e8;padding:4px 4px 3px 4px;}.KS-Navigation-DropDown .KS-CutomDropDown-TitleLabel{color:#2c61e6;cursor:pointer;float:left;margin-bottom:1px;margin-top:2px;padding-left:6px;}.KS-Navigation-DropDown ul{border-style:solid;border-width:1px;border-color:#9c9c9c;border-bottom:medium none;background-color:#f5f5f5;}.KS-Navigation-DropDown .KS-Basic-Menu-Toplevel-Item-Label{color:white;font-size:0.8em;font-weight:bold;white-space:nowrap;text-transform:uppercase;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Label{font-size:12px;margin-left:4px;white-space:nowrap;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel{padding:3px;color:#333;cursor:pointer;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel a{color:#2c61e6;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel a:hover{color:#fff;cursor:pointer;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel-Hover{background-color:gray;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel-Main-Hover{background-color:#c1cdcd;}.KS-Navigation-DropDown .KS-Basic-Menu-Item-Panel-Selected a:hover{color:#333;cursor:pointer;}.KS-Workflow-DropDown{width:200px;}.KS-Workflow-DropDown li{border-bottom:1px solid #cecece;line-height:1.8em;zoom:1;}.KS-Workflow-DropDown .KS-CustomDropDown-TitlePanel{background-color:#f3f3f3;border:1px solid #d2d2d2;cursor:pointer;padding:3px 6px;}.KS-Workflow-DropDown .KS-CutomDropDown-TitleLabel{color:#15317e;font-size:12px;font-weight:bold;white-space:nowrap;}.KS-Workflow-DropDown ul{border-style:solid;border-width:1px;border-color:#9c9c9c;background-color:#f5f5f5;}.KS-Workflow-DropDown .KS-Basic-Menu-Toplevel-Item-Label{color:white;font-size:0.8em;font-weight:bold;white-space:nowrap;text-transform:uppercase;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Label{font-size:12px;margin-left:4px;white-space:nowrap;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Panel{padding:3px;color:#333;cursor:pointer;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Panel a{color:#333;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Panel a:hover{color:#fff;cursor:pointer;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Panel-Hover{background-color:#15317e;}.KS-Workflow-DropDown .KS-Basic-Menu-Item-Panel-Selected a:hover{color:#333;cursor:pointer;}.KS-Username-DropDown{width:90px;}.KS-Username-DropDown li{border-bottom:1px solid #cecece;line-height:1.8em;zoom:1;}.KS-Username-DropDown .KS-CustomDropDown-TitlePanel{cursor:pointer;background-color:#8d0000;border:1px solid #850000;padding:4px;}.KS-Username-DropDown .KS-CutomDropDown-TitleLabel{color:white;font-size:14px;font-weight:bold;white-space:nowrap;}.KS-Username-DropDown ul{border-style:solid;border-width:1px;border-color:#9c9c9c;border-bottom:medium none;background-color:#f5f5f5;}.KS-Username-DropDown .KS-Basic-Menu-Toplevel-Item-Label{color:white;font-size:0.8em;font-weight:bold;white-space:nowrap;text-transform:uppercase;}.KS-Username-DropDown .KS-Basic-Menu-Item-Label{font-size:12px;margin-left:4px;white-space:nowrap;}.KS-Username-DropDown .KS-Basic-Menu-Item-Panel{padding:3px;color:#333;cursor:pointer;}.KS-Username-DropDown .KS-Basic-Menu-Item-Panel a{color:#333;}.KS-Username-DropDown .KS-Basic-Menu-Item-Panel a:hover{color:#fff;cursor:pointer;}.KS-Username-DropDown .KS-Basic-Menu-Item-Panel-Hover{background-color:#ac0000;}.KS-Username-DropDown .KS-Basic-Menu-Item-Panel-Selected a:hover{color:#333;cursor:pointer;}
  .KS-Blocking-Glass{background-color:#000;opacity:0.3;filter:alpha(opacity=30);z-index:2;}
  .KS-Button-Column-MainPanel{height:100%;}.KS-Button-Column-TopPanel,.KS-Button-Column-BottomPanel{width:100%;padding-right:2px;padding-left:2px;}.KS-Button-Column-Button{width:100%;margin-left:0;margin-right:0;margin-bottom:1px;margin-top:1px;}.KS-Button-Row-MainPanel{width:100%;}
  .KS-Checkbox{margin:2px;}.KS-Checkbox label{font-size:1em;font-weight:normal;line-height:2em;}.KS-Checkbox-Checked,.KS-Checkbox-Focus{color:#9b251c;}.KS-Checkbox-Table td{vertical-align:middle;}
  .KS-Comment-Button-Panel{float:right;}.KS-Comment-Image-Button{margin:2px;cursor:pointer;}.KS-Comment-Image-Button-Panel{float:right;padding-right:10px;}.KS-Comment-Name{font-weight:bold;}.KS-Comment-Date-Created{color:#666;font-size:x-small;}.KS-Comment-Date-Modified{float:right;color:#666;font-size:x-small;}.KS-Comment-Header-Left{float:left;padding-left:10px;}.KS-Comment-Container{background-color:#f2f2f2;padding:2px;width:700px;margin:4px;margin-top:10px;overflow:hidden;}.KS-Comment-Container-InUse{background-color:#d7d7d7;}.KS-Comment-Create-Panel{margin-left:4px;width:520px;}.KS-Comment-Text{width:650px;font-weight:normal;padding-left:20px;padding-right:20px;clear:both;}.KS-Comment-Login-User{color:#666;font-size:x-small;}.KS-Comment-Inline-Edit-Panel{clear:both;margin-top:10px;margin-bottom:10px;margin-left:20px;}.KS-Comment-Create-Editor{width:550px;height:132px;border:1px solid black;}.KS-Comment-Inline-Edit-Editor{width:650px;}

  .KS-Popup-Header{background-color:#99bbe8;font-weight:bold;border-bottom:1px solid black;margin-bottom:2px;width:100%;cursor:move;}.ks-confirmation-message-layout{width:400px;}.ks-confirmation-message-label{font-weight:bold;margin-top:2em;margin-bottom:2em;}
  .KS-DocumentList-Attachment-Column-Header{font-weight:bold;padding-bottom:10px;}.KS-DocumentList-Attachment-Table{padding-bottom:20px;}
  .KS-Error-Dialog{border:1px solid black;padding:8px;background-color:#f0f0f0;}.KS-Error-Dialog-Title{font-weight:bold;font-size:large;background-color:#f0f0f0;border:1px outset grey;text-align:center;padding:5px;}.KS-Error-Dialog-TextArea{width:400px;height:100px;}.KS-Error-Dialog-Panel{border:1px inset grey;}
  .KS-Horizontal-Data-Cell{display:table-cell;}.KS-Horizontal-Block-Flow{display:inline-block;}.KS-Horizontal-Inline-Flow{display:inline;}.KS-Vertical-Flow{display:block;}
  .KS-Footer{background-color:#eee;width:100%;clear:both;height:70px;margin-top:3px;position:relative;}.KS-Footer-Line1{text-align:center;padding-top:20px;color:gray;}.KS-Footer-Line{text-align:center;color:gray;}.app-wrap{min-height:100%;}.app-content{padding-bottom:190px;clear:both;}
  .KS-Application,.KS-Application-Content{width:100%;}.KS-Drop-Shadow{-moz-box-shadow:2px 2px 10px #000;-webkit-box-shadow:2px 2px 10px #000;box-shadow:2px 2px 10px #000;}html,body{height:100%;width:100%;overflow:hidden;}.ks-lightbox{background-color:#fff;border:3px solid #54565c;color:#333;overflow:visible;z-index:2;-moz-border-radius:10px 10px 10px 10px;}.ks-lightbox .Caption{background-color:#dfe2e9;color:#000;cursor:move;font-size:1.2em;font-weight:bold;padding:10px 0 10px 16px;position:relative;text-align:left;text-shadow:0 2px 2px #fff;-moz-border-radius:8px 8px 0 0;}.ks-lightbox .popupContent{display:inline;overflow:visible;}.ks-lightbox-mainPanel{margin-left:15px;}.ks-lightbox-closeLink{background:url(images/common/lightbox_close.png) no-repeat;width:40px;height:40px;display:block;z-index:9999;position:absolute;right:-18px;top:-18px;cursor:pointer;float:right;}.ks-lightbox-closeLink-with-Caption{top:-54px;}.ks-lightbox-scrollPanel{padding-right:20px;margin-bottom:10px;}.ks-lightbox-buttonPanel{padding-top:5px;}.ks-lightbox-buttonPanel .KS-Advanced-Search-Link,.ks-lightbox-buttonPanel .KS-Advanced-Search-Buttons{margin-top:0;}.KSBlockingDialog-icon{float:left;}.KSBlockingDialog-message{float:left;margin-left:10px;}.gwt-PopupPanelGlass{background-color:#000;opacity:0.45;z-index:1;filter:alpha(opacity=45);}.ks-button-spacing,.ks-selected-list-picker .gwt-SuggestBox{margin-right:10px;}.ks-notification-container{top:45px;overflow:visible;position:absolute;left:400px;}.ks-notification-message{width:300px;min-height:20px;background-color:black;background-position:8px 8px;background-repeat:no-repeat;line-height:1.35em;margin-top:10px;overflow:visible;padding:9px 15px 10px 28px;position:relative;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-wrap:break-word;color:white;border-radius:6px 6px;-moz-border-radius:6px 6px;-webkit-border-radius:6px 6px;background-image:url(images/common/tick-circle.png);}.ks-notification-error{width:300px;min-height:20px;background-color:black;background-position:8px 8px;background-repeat:no-repeat;line-height:1.35em;margin-top:10px;overflow:visible;padding:9px 15px 10px 28px;position:relative;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-wrap:break-word;color:white;border-radius:6px 6px;-moz-border-radius:6px 6px;-webkit-border-radius:6px 6px;background-image:url(images/common/exclamation-red.png);}.ks-notification-message p *{white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-wrap:break-word;color:white;vertical-align:baseline;}.ks-notification-message a{color:#2c61e6;}a.ks-notification-close{background-image:url(images/common/lightbox_close_20px.png);background-repeat:no-repeat;cursor:pointer;display:inline;height:25px;position:absolute;right:0;top:6px;width:25px;z-index:9999;}a.ks-notification-close:hover{background-image:url(images/common/lightbox_close_hover_20px.png);}div.ks-selected-list-picker{width:20em;display:inline;}ul.ks-selected-list{margin:0;padding:0;}.ks-selected-list ul{list-style-type:none;margin:10px 0 0 0;padding:0;}.ks-selected-list-value abbr{position:absolute;right:3px;top:12px;}.ks-selected-list ul li{border:1px solid #cdcdcd;display:block;margin:0;width:30em;}.ks-selected-list .ks-form-module-validation-warnings li{border-style:none;}.ks-selected-list-value{display:block;min-height:25px;padding:9px 7px 0 6px;position:relative;}.ks-selected-list-value-remove{position:absolute;right:3px;}.ks-selected-list-value-remove:focus{cursor:pointer;border:1px solid black;}.ks-selected-list-value-remove:hover{cursor:pointer;border:1px solid black;background-image:url(images/common/selected_list_value_remove_20px.png);}.ks-selected-list-value-label{white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-wrap:break-word;vertical-align:baseline;width:18em;}.ks-selected-list-value-container{background-color:#fafcd7;position:absolute;top:0;left:0;height:100%;width:100%;z-index:-1;}.ks-selected-list-readOnly ul{margin:0;padding:0;list-style-type:none;}.ks-selected-list-readOnly ul li{padding:0;margin:0;display:block;}.ks-selected-list-readOnly .ks-selected-list-value{padding-bottom:2px;min-height:0;}.standard-content-padding{padding-left:20px;}.header-innerDiv{padding-right:10px;padding-left:5px;}.header-appTitle{color:#ccc;font-size:20px;font-weight:bold;margin-bottom:4px;padding:15px 0 5px 14px;}.bold{font-weight:bold;}.table-row{background-color:white;color:black;}.table-row-hover{background-color:#024fd0;color:white;}.table-row-selected{background-color:#c6d9ff;color:black;}.ks-no-results-message{margin:100px;padding:0;text-align:center;font-weight:bold;font-size:10pt;}.KS-indented{margin-left:40px;}.ks-documentHeader-widgetPanel{float:left;}
  .gwt-Reference-chrome{height:5px;width:5px;zoom:1;}.gwt-Button{margin:0;padding:3px 5px;text-decoration:none;font-size:small;cursor:pointer;cursor:hand;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;border:1px outset #ccc;}.gwt-Button:active{border:1px inset #ccc;}.gwt-Button:hover{border-color:#9cf #69e #69e #7af;}.gwt-Button[disabled]{cursor:default;color:#888;}.gwt-Button[disabled]:hover{border:1px outset #ccc;}.gwt-CheckBox-disabled{color:#888;}.gwt-DecoratorPanel .topCenter,.gwt-DecoratorPanel .bottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x;}.gwt-DecoratorPanel .middleLeft,.gwt-DecoratorPanel .middleRight{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DecoratorPanel .topLeftInner,.gwt-DecoratorPanel .topRightInner,.gwt-DecoratorPanel .bottomLeftInner,.gwt-DecoratorPanel .bottomRightInner{width:5px;height:5px;zoom:1;}.gwt-DecoratorPanel .topLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 0;}.gwt-DecoratorPanel .topRight{background:url(gwt/standard/images/corner.png) no-repeat -5px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px 0;}.gwt-DecoratorPanel .bottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -5px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -5px;}.gwt-DecoratorPanel .bottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -5px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -5px;}* html .gwt-DecoratorPanel .topLeftInner,* html .gwt-DecoratorPanel .topRightInner,* html .gwt-DecoratorPanel .bottomLeftInner,* html .gwt-DecoratorPanel .bottomRightInner{width:5px;height:5px;overflow:hidden;}.gwt-DialogBox .Caption{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;padding:4px 4px 4px 8px;cursor:default;border-bottom:1px solid #bbb;border-top:5px solid #e3e3e3;}.gwt-DialogBox .dialogMiddleCenter{padding:3px;background:white;}.gwt-DialogBox .dialogBottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x 0 -4px;-background:url(gwt/standard/images/hborder_ie6.png) repeat-x 0 -4px;}.gwt-DialogBox .dialogMiddleLeft{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DialogBox .dialogMiddleRight{background:url(gwt/standard/images/vborder.png) repeat-y -4px 0;-background:url(gwt/standard/images/vborder_ie6.png) repeat-y -4px 0;}.gwt-DialogBox .dialogTopLeftInner{width:5px;zoom:1;}.gwt-DialogBox .dialogTopRightInner{width:8px;zoom:1;}.gwt-DialogBox .dialogBottomLeftInner,.gwt-DialogBox .dialogBottomRightInner{width:5px;height:8px;zoom:1;}.gwt-DialogBox .dialogTopLeft{background:url(gwt/standard/images/corner.png) no-repeat -13px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -13px 0;}.gwt-DialogBox .dialogTopRight{background:url(gwt/standard/images/corner.png) no-repeat -18px 0;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -18px 0;}.gwt-DialogBox .dialogBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -15px;}.gwt-DialogBox .dialogBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -15px;}* html .gwt-DialogBox .dialogTopLeftInner{width:5px;overflow:hidden;}* html .gwt-DialogBox .dialogTopRightInner{width:8px;overflow:hidden;}* html .gwt-DialogBox .dialogBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-DialogBox .dialogBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-DisclosurePanel .header,.gwt-DisclosurePanel .header a,.gwt-DisclosurePanel .header td{text-decoration:none;color:black;cursor:pointer;cursor:hand;}.gwt-DisclosurePanel .content{border-left:3px solid #e3e3e3;padding:4px 0 4px 8px;margin-left:6px;}.gwt-Frame{border-top:2px solid #666;border-left:2px solid #666;border-right:2px solid #bbb;border-bottom:2px solid #bbb;}.gwt-HorizontalSplitPanel .hsplitter{cursor:move;border:0;background:#91c0ef url(gwt/standard/images/vborder.png) repeat-y;}.gwt-VerticalSplitPanel .vsplitter{cursor:move;border:0;background:#91c0ef url(gwt/standard/images/hborder.png) repeat-x;}.gwt-Hyperlink{display:inline;}.gwt-MenuBar,.gwt-MenuBar .gwt-MenuItem{cursor:default;}.gwt-MenuBar .gwt-MenuItem-selected{background:#cdcdcd;}.gwt-MenuBar-horizontal{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;border:1px solid #bbb;}.gwt-MenuBar-horizontal .gwt-MenuItem{padding:0 10px;vertical-align:bottom;color:#666;font-weight:bold;}.gwt-MenuBar-horizontal .gwt-MenuItemSeparator{width:1px;padding:0;margin:0;border:0;border-left:1px solid #888;background:white;}.gwt-MenuBar-horizontal .gwt-MenuItemSeparator .menuSeparatorInner{width:1px;height:1px;background:white;}.gwt-MenuBar-vertical{margin-top:0;margin-left:0;background:white;}.gwt-MenuBar-vertical table{border-collapse:collapse;}.gwt-MenuBar-vertical .gwt-MenuItem{padding:4px 14px 4px 1px;}.gwt-MenuBar-vertical .gwt-MenuItemSeparator{padding:2px 0;}.gwt-MenuBar-vertical .gwt-MenuItemSeparator .menuSeparatorInner{height:1px;padding:0;border:0;border-top:1px solid #777;background:#dde;overflow:hidden;}.gwt-MenuBar-vertical .subMenuIcon{padding-right:4px;}.gwt-MenuBar-vertical .subMenuIcon-selected{background:#cdcdcd;}.gwt-MenuBarPopup{margin:0 0 0 3px;}.gwt-MenuBarPopup .menuPopupTopCenter{background:url(gwt/standard/images/hborder.png) 0 -12px repeat-x;}.gwt-MenuBarPopup .menuPopupBottomCenter{background:url(gwt/standard/images/hborder.png) 0 -13px repeat-x;-background:url(gwt/standard/images/hborder_ie6.png) 0 -13px repeat-x;}.gwt-MenuBarPopup .menuPopupMiddleLeft{background:url(gwt/standard/images/vborder.png) -12px 0 repeat-y;-background:url(gwt/standard/images/vborder_ie6.png) -12px 0 repeat-y;}.gwt-MenuBarPopup .menuPopupMiddleRight{background:url(gwt/standard/images/vborder.png) -13px 0 repeat-y;-background:url(gwt/standard/images/vborder_ie6.png) -13px 0 repeat-y;}.gwt-MenuBarPopup .menuPopupTopLeftInner{width:5px;height:5px;zoom:1;}.gwt-MenuBarPopup .menuPopupTopRightInner{width:8px;height:5px;zoom:1;}.gwt-MenuBarPopup .menuPopupBottomLeftInner{width:5px;height:8px;zoom:1;}.gwt-MenuBarPopup .menuPopupBottomRightInner{width:8px;height:8px;zoom:1;}.gwt-MenuBarPopup .menuPopupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -36px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -36px;}.gwt-MenuBarPopup .menuPopupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -36px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -36px;}.gwt-MenuBarPopup .menuPopupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -41px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -41px;}.gwt-MenuBarPopup .menuPopupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -41px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -41px;}* html .gwt-MenuBarPopup .menuPopupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-MenuBarPopup .menuPopupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-PasswordTextBox{padding:2px;}.gwt-PasswordTextBox-readonly,.gwt-RadioButton-disabled{color:#888;}.gwt-DecoratedPopupPanel .popupMiddleCenter{padding:3px;background:#e3e3e3;}.gwt-DecoratedPopupPanel .popupTopCenter{background:url(gwt/standard/images/hborder.png) repeat-x;}.gwt-DecoratedPopupPanel .popupBottomCenter{background:url(gwt/standard/images/hborder.png) repeat-x 0 -4px;-background:url(gwt/standard/images/hborder_ie6.png) repeat-x 0 -4px;}.gwt-DecoratedPopupPanel .popupMiddleLeft{background:url(gwt/standard/images/vborder.png) repeat-y;}.gwt-DecoratedPopupPanel .popupMiddleRight{background:url(gwt/standard/images/vborder.png) repeat-y -4px 0;-background:url(gwt/standard/images/vborder_ie6.png) repeat-y -4px 0;}.gwt-DecoratedPopupPanel .popupTopLeftInner{width:5px;height:5px;zoom:1;}.gwt-DecoratedPopupPanel .popupTopRightInner{width:8px;height:5px;zoom:1;}.gwt-DecoratedPopupPanel .popupBottomLeftInner{width:5px;height:8px;zoom:1;}.gwt-DecoratedPopupPanel .popupBottomRightInner{width:8px;height:8px;zoom:1;}.gwt-DecoratedPopupPanel .popupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -10px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -10px;}.gwt-DecoratedPopupPanel .popupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -10px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -10px;}.gwt-DecoratedPopupPanel .popupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -15px;}.gwt-DecoratedPopupPanel .popupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -15px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -15px;}* html .gwt-DecoratedPopupPanel .popupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-DecoratedPopupPanel .popupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-PopupPanel{background:white;}.gwt-PushButton-up{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:pointer;cursor:hand;}.gwt-PushButton-up-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-PushButton-up-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:default;opacity:0.5;filter:alpha(opacity\=40);zoom:1;}.gwt-PushButton-down{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px inset #666;cursor:pointer;cursor:hand;}.gwt-PushButton-down-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px inset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-PushButton-down-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;border:1px outset #ccc;cursor:default;opacity:0.5;filter:alpha(opacity\=40);zoom:1;}.hasRichTextToolbar{border:0;}.gwt-RichTextToolbar{background:#ebebeb url(gwt/standard/images/hborder.png) repeat-x 0 -2003px;border-bottom:1px solid #bbb;padding:3px;margin:0;}.gwt-RichTextToolbar .gwt-PushButton-up{padding:0 1px 0 0;margin-right:4px;margin-bottom:4px;border-width:1px;}.gwt-RichTextToolbar .gwt-PushButton-up-hovering{margin-right:4px;margin-bottom:4px;padding:0 1px 0 0;border-width:1px;}.gwt-RichTextToolbar .gwt-PushButton-down,.gwt-RichTextToolbar .gwt-PushButton-down-hovering{margin-right:4px;margin-bottom:4px;padding:0 0 0 1px;border-width:1px;}.gwt-RichTextToolbar .gwt-ToggleButton-up,.gwt-RichTextToolbar .gwt-ToggleButton-up-hovering{margin-right:4px;margin-bottom:4px;padding:0 1px 0 0;border-width:1px;}.gwt-RichTextToolbar .gwt-ToggleButton-down,.gwt-RichTextToolbar .gwt-ToggleButton-down-hovering{margin-right:4px;margin-bottom:4px;padding:0 0 0 1px;border-width:1px;}.gwt-StackPanel{border-bottom:1px solid #bbb;}.gwt-StackPanel .gwt-StackPanelItem{cursor:pointer;cursor:hand;font-weight:bold;font-size:1.3em;padding:3px;border:1px solid #bbb;border-bottom:0;background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;}.gwt-StackPanel .gwt-StackPanelContent{border:1px solid #bbb;border-bottom:0;background:white;padding:2px 2px 10px 5px;}.gwt-DecoratedStackPanel{border-bottom:1px solid #bbb;}.gwt-DecoratedStackPanel .gwt-StackPanelContent{border:1px solid #bbb;border-bottom:0;background:white;padding:2px 2px 10px 5px;}.gwt-DecoratedStackPanel .gwt-StackPanelItem{cursor:pointer;cursor:hand;}.gwt-DecoratedStackPanel .stackItemTopLeft{height:6px;width:6px;zoom:1;border-left:1px solid #bbb;background:#e4e4e4 url(gwt/standard/images/corner.png) no-repeat 0 -49px;-background:#e4e4e4 url(gwt/standard/images/corner_ie6.png) no-repeat 0 -49px;}.gwt-DecoratedStackPanel .stackItemTopRight{height:6px;width:6px;zoom:1;border-right:1px solid #bbb;background:#e4e4e4 url(gwt/standard/images/corner.png) no-repeat -6px -49px;-background:#e4e4e4 url(gwt/standard/images/corner_ie6.png) no-repeat -6px -49px;}.gwt-DecoratedStackPanel .stackItemTopLeftInner,.gwt-DecoratedStackPanel .stackItemTopRightInner{width:1px;height:1px;}* html .gwt-DecoratedStackPanel .stackItemTopLeftInner,* html .gwt-DecoratedStackPanel .stackItemTopRightInner{width:6px;height:6px;overflow:hidden;}.gwt-DecoratedStackPanel .stackItemTopCenter{background:url(gwt/standard/images/hborder.png) 0 -21px repeat-x;}.gwt-DecoratedStackPanel .stackItemMiddleLeft{background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;border-left:1px solid #bbb;}.gwt-DecoratedStackPanel .stackItemMiddleLeftInner,.gwt-DecoratedStackPanel .stackItemMiddleRightInner{width:1px;height:1px;}.gwt-DecoratedStackPanel .stackItemMiddleRight{background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;border-right:1px solid #bbb;}.gwt-DecoratedStackPanel .stackItemMiddleCenter{font-weight:bold;font-size:1.3em;background:#d3def6 url(gwt/standard/images/hborder.png) repeat-x 0 -989px;}.gwt-DecoratedStackPanel .gwt-StackPanelItem-first .stackItemTopRight,.gwt-DecoratedStackPanel .gwt-StackPanelItem-first .stackItemTopLeft{border:0;background-color:white;}.gwt-DecoratedStackPanel .gwt-StackPanelItem-below-selected .stackItemTopLeft,.gwt-DecoratedStackPanel .gwt-StackPanelItem-below-selected .stackItemTopRight{background-color:white;}.gwt-SuggestBox{padding:2px;display:block;}.gwt-SuggestBoxPopup{margin-left:3px;z-index:2;}.gwt-SuggestBoxPopup .item{color:424242;cursor:default;line-height:1.5em;padding:2px 6px;}.gwt-SuggestBoxPopup .item-selected{background:#cdcdcd;}.gwt-SuggestBoxPopup .suggestPopupContent{background:none repeat scroll 0 0 #ecf2fa;border:none;padding:0;}.gwt-SuggestBoxPopup .suggestPopupTopCenter{background-color:#ecf2fa;border-top:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupBottomCenter{background-color:#ecf2fa;border-bottom:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupMiddleLeft{background-color:#ecf2fa;border-left:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupMiddleRight{background-color:#ecf2fa;border-right:1px solid #aaa;}.gwt-SuggestBoxPopup .suggestPopupTopLeftInner{background-color:#ecf2fa;border-top:1px solid #aaa;border-left:1px solid #aaa;height:5px;width:5px;}.gwt-SuggestBoxPopup .suggestPopupTopRightInner{background-color:#ecf2fa;border-top:1px solid #aaa;border-right:1px solid #aaa;height:5px;width:8px;}.gwt-SuggestBoxPopup .suggestPopupBottomLeftInner{background-color:#ecf2fa;border-bottom:1px solid #aaa;border-left:1px solid #aaa;height:8px;width:5px;}.gwt-SuggestBoxPopup .suggestPopupBottomRightInner{background-color:#ecf2fa;border-bottom:1px solid #aaa;border-right:1px solid #aaa;height:8px;width:8px;}.gwt-SuggestBoxPopup .suggestPopupTopLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -23px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -23px;}.gwt-SuggestBoxPopup .suggestPopupTopRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -23px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -23px;}.gwt-SuggestBoxPopup .suggestPopupBottomLeft{background:url(gwt/standard/images/corner.png) no-repeat 0 -28px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -28px;}.gwt-SuggestBoxPopup .suggestPopupBottomRight{background:url(gwt/standard/images/corner.png) no-repeat -5px -28px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -5px -28px;}* html .gwt-SuggestBoxPopup .suggestPopupTopLeftInner{width:5px;height:5px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupTopRightInner{width:8px;height:5px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupBottomLeftInner{width:5px;height:8px;overflow:hidden;}* html .gwt-SuggestBoxPopup .suggestPopupBottomRightInner{width:8px;height:8px;overflow:hidden;}.gwt-TabBar .gwt-TabBarFirst,.gwt-DecoratedTabBar .gwt-TabBarFirst{width:5px;}.gwt-TabBar .gwt-TabBarItem{margin-left:6px;padding:3px 6px 3px 6px;cursor:pointer;cursor:hand;color:black;font-weight:bold;text-align:center;background:#e3e3e3;}.gwt-TabBar .gwt-TabBarItem-selected{cursor:default;background:#bcbcbc;}.gwt-TabBar .gwt-TabBarItem-disabled{cursor:default;color:#999;}.gwt-TabPanelBottom{border-color:#bcbcbc;border-style:solid;border-width:3px 2px 2px;overflow:hidden;padding:6px;}.gwt-DecoratedTabBar .gwt-TabBarItem{border-collapse:collapse;margin-left:6px;}.gwt-DecoratedTabBar .tabTopCenter{padding:0;background:#e3e3e3;}.gwt-DecoratedTabBar .tabTopLeft{padding:0;zoom:1;background:url(gwt/standard/images/corner.png) no-repeat 0 -55px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat 0 -55px;}.gwt-DecoratedTabBar .tabTopRight{padding:0;zoom:1;background:url(gwt/standard/images/corner.png) no-repeat -6px -55px;-background:url(gwt/standard/images/corner_ie6.png) no-repeat -6px -55px;}.gwt-DecoratedTabBar .tabTopLeftInner,.gwt-DecoratedTabBar .tabTopRightInner{width:6px;height:6px;}* html .gwt-DecoratedTabBar .tabTopLeftInner,* html .gwt-DecoratedTabBar .tabTopRightInner{width:6px;height:6px;overflow:hidden;}.gwt-DecoratedTabBar .tabMiddleLeft,.gwt-DecoratedTabBar .tabMiddleRight{width:6px;padding:0;background:#e3e3e3 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-DecoratedTabBar .tabMiddleLeftInner,.gwt-DecoratedTabBar .tabMiddleRightInner{width:1px;height:1px;}.gwt-DecoratedTabBar .tabMiddleCenter{padding:0 4px 2px 4px;cursor:pointer;cursor:hand;color:black;font-weight:bold;text-align:center;background:#e3e3e3 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopCenter{background:#747474;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopLeft{background-position:0 -61px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabTopRight{background-position:-6px -61px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleLeft,.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleRight{background:#bcbcbc url(gwt/standard/images/hborder.png) repeat-x 0 -2511px;}.gwt-DecoratedTabBar .gwt-TabBarItem-selected .tabMiddleCenter{cursor:default;background:#bcbcbc url(gwt/standard/images/hborder.png) repeat-x 0 -2511px;color:white;}.gwt-DecoratedTabBar .gwt-TabBarItem-disabled .tabMiddleCenter{cursor:default;color:#999;}.gwt-TextArea-readonly,.gwt-TextBox-readonly,.datePickerDayIsFiller{color:#888;}.gwt-ToggleButton-up{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:pointer;cursor:hand;}.gwt-ToggleButton-up-hovering{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-ToggleButton-up-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:3px 5px 3px 5px;border:1px outset #ccc;cursor:default;opacity:0.5;zoom:1;filter:alpha(opacity\=40);}.gwt-ToggleButton-down,.gwt-ToggleButton-down-hovering,.gwt-ToggleButton-down-disabled{margin:0;text-decoration:none;background:url(gwt/standard/images/hborder.png) repeat-x 0 -27px;padding:4px 4px 2px 6px;}.gwt-ToggleButton-down{background-position:0 -513px;border:1px inset #ccc;cursor:pointer;cursor:hand;}.gwt-ToggleButton-down-hovering{background-position:0 -513px;border:1px inset;border-color:#9cf #69e #69e #7af;cursor:pointer;cursor:hand;}.gwt-ToggleButton-down-disabled{background-position:0 -513px;border:1px inset #ccc;cursor:default;opacity:0.5;zoom:1;filter:alpha(opacity\=40);}.gwt-Tree .gwt-TreeItem{padding:1px 0;margin:0;white-space:nowrap;cursor:hand;cursor:pointer;}.gwt-Tree .gwt-TreeItem-selected{background:#93c2f1 url(gwt/standard/images/hborder.png) repeat-x 0 -1463px;}.gwt-TreeItem .gwt-RadioButton input,.gwt-TreeItem .gwt-CheckBox input{margin-left:0;}* html .gwt-TreeItem .gwt-RadioButton input,* html .gwt-TreeItem .gwt-CheckBox input{margin-left:-4px;}.gwt-DateBox input{width:8em;}.dateBoxFormatError{background:#eed6d6;}.gwt-DatePicker{border:1px solid #888;cursor:default;}.gwt-DatePicker td,.datePickerMonthSelector td:focus{outline:none;}.datePickerDays{width:100%;background:white;}.datePickerDay,.datePickerWeekdayLabel,.datePickerWeekendLabel{font-size:75%;text-align:center;padding:4px;outline:none;}.datePickerWeekdayLabel,.datePickerWeekendLabel{background:#c1c1c1;padding:0 4px 2px;cursor:default;}.datePickerDay{padding:4px;cursor:hand;cursor:pointer;}.datePickerDayIsToday{border:1px solid black;padding:3px;}.datePickerDayIsWeekend{background:#eee;}.datePickerDayIsValue{background:#abf;}.datePickerDayIsDisabled{color:#aaa;font-style:italic;}.datePickerDayIsHighlighted{background:#dde;}.datePickerDayIsValueAndHighlighted{background:#ccf;}.datePickerMonthSelector{background:#c1c1c1;width:100%;}td.datePickerMonth{text-align:center;vertical-align:center;white-space:nowrap;font-size:70%;font-weight:bold;}.datePickerPreviousButton,.datePickerNextButton{font-size:120%;line-height:1em;cursor:hand;cursor:pointer;padding:0 4px;}

  .KS-Header-Logo-Spacer{width:100%;background:#fff;}.KS-Header-Link{color:#fff;text-decoration:none;font-size:70%;text-align:right;padding-right:5px;}.KS-Header-Link-Focus{cursor:pointer;text-decoration:underline;}

  .blockLayout{padding-left:17px;padding-top:20px;}.blockLayout-row{clear:both;width:960px;}.blockLayout-title{display:inline;font-weight:bold;}.blockLayout-titlePanel{border-bottom:3px solid black;margin-bottom:14px;padding-bottom:10px;width:960px;}.blockLayout-title-widget{float:right;padding-top:10px;}.blockLayout-blockPadding{float:left;margin-bottom:30px;margin-right:20px;}.contentBlock-titlePanel{padding-top:20px;border-bottom:1px dotted gray;height:5em;overflow:hidden;}.contentBlock-title{font-size:1.5em;font-weight:bold;margin-bottom:5px;}.contentBlock-desc{color:gray;font-size:1.1em;}.contentBlock-size3{width:1000px;}.contentBlock-size2{width:650px;}.contentBlock-size1{width:300px;}.contentBlock-list{list-style-type:none;padding:0;}.contentBlock-list ul{list-style-type:none;padding:0;margin:0;}.contentBlock-list li{margin-top:15px;}.contentBlock-navLink{font-size:1.3em;}.contentBlock-navLink-disabled{font-size:1.3em;color:gray;}.recentlyViewed-block{background-color:#e8e8e8;}.recentlyViewed-block .contentBlock-list{padding-left:20px;margin-right:20px;padding-bottom:20px;}.recentlyViewed-block .contentBlock-titlePanel{margin-left:20px;margin-right:20px;}.titleWidget-separator{padding-left:1em;padding-right:1em;font-size:1.3em;}
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
  .gwt-ScrollTable{border-color:#aaa;border-style:solid;border-width:1px 0 1px 1px;}.gwt-ScrollTable .headerWrapper{background:#8bd url(images/bg_header_gradient.gif) repeat-x bottom left;}.gwt-ScrollTable .footerWrapper{border-top:1px solid #aaa;background:#8bd url(images/bg_header_gradient.gif) repeat-x bottom left;}.gwt-ScrollTable .dataTable td{border-color:#aaa;border-style:solid;border-bottom:1px solid #d5d5d5;empty-cells:show;border-width:0 1px 1px 0;white-space:nowrap;overflow:hidden;}.gwt-ScrollTable .headerTable td,.gwt-ScrollTable .footerTable td{border-color:#aaa;border-style:solid;border-bottom:1px solid #d5d5d5;empty-cells:show;border-width:0 1px 1px 0;white-space:nowrap;overflow:hidden;font-weight:bold;text-align:center;color:#fff;}.gwt-ScrollTable .dataTable tr.highlighted{background:#c3d9ff;}.gwt-ScrollTable .dataTable td.highlighted{background:#ffa;cursor:hand;cursor:pointer;}.gwt-ScrollTable .dataTable tr.selected td{background:#7aa5d6;}.gwt-PagingOptions{background:#e8eef7;border:1px solid #aaa;border-top:none;}.gwt-PagingOptions .errorMessage{color:red;}.pagingOptionsFirstPage,.pagingOptionsLastPage,.pagingOptionsNextPage,.pagingOptionsPrevPage{cursor:hand;cursor:pointer;}.gwt-InlineCellEditor{border:3px solid #7aa5d6;padding:4px;background:white;overflow:auto;}.gwt-InlineCellEditor .accept,.gwt-InlineCellEditor .cancel{cursor:pointer;cursor:hand;}.AbstractOption-Label{font-weight:bold;text-align:right;}
  .ks-header h3{margin:0;}.ks-heading-course-title h1{color:#666;display:block;font-size:2.333em;font-weight:normal;margin-bottom:0;padding:15px 0 10px 0;}.ks-heading-page-title h2{font-size:2em;color:#940b07;}.ks-heading-page-section h3{font-size:1.5em;color:#000;font-weight:normal;padding-bottom:4px;border-bottom:solid 2px #ccc;margin-bottom:0.5em;}h1.ks-layout-header{font-size:3em;color:#940b07;margin-bottom:0;}h2.ks-layout-header{color:#636d05;font-size:1.6em;margin-bottom:2px;padding-bottom:2px;}h3.ks-layout-header{border-bottom:1px dotted #bbb;color:#000;font-size:1.3em;font-weight:normal;letter-spacing:0.05em;margin-bottom:9px;}h4.ks-layout-header,h5.ks-layout-header,h6.ks-layout-header,h7.ks-layout-header{margin-bottom:0;}.header-underline{border-bottom:solid 2px #ccc;}h4.text-underline{font-size:1.1538em;font-weight:bold;font-family:Georgia;text-decoration:underline;}.ks-section-widget{padding-bottom:3px;}.ks-page-container{background-color:#fff;min-height:100%;position:relative;margin:20px 3%;-moz-box-shadow:0 0 10px #666;-webkit-box-shadow:0 0 10px #666;}.ks-page-banner{background-color:#eaeaea;padding-right:20px;}.ks-page-banner-title{border-left:solid 6px #999;padding-left:14px;margin-bottom:20px;}.ks-page-banner-actions{float:left;width:50%;}.ks-page-banner-workflow,.ks-page-banner-project{width:48%;float:left;margin-right:2%;}.ks-page-banner-workflow-menu,.ks-page-banner-project-menu{min-height:36px;color:#424242;border:solid 1px #b2b2b2;padding:6px;background-color:#f3f3f3;}.ks-page-banner-workflow-menu p,.ks-page-banner-project-menu p{font-size:0.916em;font-style:italic;margin-left:3px;margin-bottom:0;}.ks-page-banner-workflow-status{width:50%;float:right;padding:0;background:#e0e0e0 url(../images/icons/node.png) no-repeat 5px 5px;}.ks-page-banner-workflow-status p{margin:0 0 0 23px;padding:6px;color:#424242;min-height:38px;}.ks-page-banner-workflow-status p span{font-weight:bold;}.ks-page-banner-message{padding:0 20px;background-color:#eaeaea;}.ks-page-content{padding:20px;}.ks-message-static{background-color:#eddc91;color:#000;margin-bottom:10px;padding:6px 6px 6px 15px;position:relative;}.ks-message-static-margin{margin-bottom:1em;}.ks-message-static-image{display:inline;left:-9px;position:absolute;top:2px;}.ks-comments{padding:12px;margin-bottom:1em;line-height:1.25em;}.ks-comments:hover{background-color:#fffbc9;}.ks-comments-logged{width:25%;float:left;}.ks-comments-form{width:75%;float:right;text-align:right;}.ks-comments-meta{width:25%;float:left;}.ks-comments-text{width:58%;float:left;}.ks-comments-actions{width:15%;float:right;text-align:right;}#basic-modal-content{display:none;}#simplemodal-overlay{background-color:#000;}#simplemodal-container{width:850px;color:#333;background-color:#fff;border:6px solid #aaa;}#simplemodal-container a{color:#ddd;}#simplemodal-container a.modalCloseImg{background:url(../images/x.png) no-repeat;width:25px;height:29px;display:inline;z-index:9999;position:absolute;top:-12px;right:-12px;cursor:pointer;}.visible{display:block;}.hidden{display:none;}p.noted{margin:0 0 10px 0;color:#39b54a;font-family:Georgia;}.clearfix:after{content:" ";display:block;height:0;clear:both;visibility:hidden;overflow:hidden;}.clearfix{display:block;}.clear{clear:both;height:0;}.clearboth{clear:both;}.ks-form-bordered{border:1px solid #d2d8e3;margin-bottom:1em;}.ks-form-bordered-header{background-color:#e4e6f2;margin:0;padding:4px 6px;}.ks-form-bordered-header-title{color:#424242;display:table;float:left;font-size:1em;height:1%;letter-spacing:0.06em;line-height:1.6em;padding:0 0 0 5px;text-transform:uppercase;}.ks-form-bordered-header-title h4{margin:0;padding:0;}.ks-form-bordered-header-delete{float:right;margin-left:3px;width:12px;height:14px;}.ks-form-bordered-header-delete a{display:block;padding:14px 0 0 0;overflow:hidden;background:transparent url(../images/icons/delete_gray_12px.png) no-repeat right center;height:0 !important;height:14px;}.ks-form-bordered-header-help{float:right;margin-left:3px;width:14px;height:14px;}.ks-form-bordered-header-help a{display:block;padding:14px 0 0 0;overflow:hidden;background:url(../images/icons/help_gray_14px.png) no-repeat right center;height:0 !important;height:14px;}.ks-form-bordered-body{padding:10px 10px 0 10px;}.ks-form-course-format-advanced{background-color:#f1f1f1;margin-bottom:10px;}.ks-form-course-format-advanced-header{background:#fff;padding:4px;}.ks-form-course-format-advanced-body{padding:10px 10px 0 10px;}.ks-form-course-format-activity{padding:10px;margin-bottom:10px;max-width:450px;}.ks-form-course-format-activity-header{border-bottom:1px dotted #ccc;height:1.5em;margin-bottom:0.1em;padding:1px 0;position:relative;}.ks-form-course-format-activity-header-title{color:#424242;display:table;float:left;font-size:1.083em;font-weight:bold;height:1%;line-height:1.7em;text-transform:uppercase;}.ks-form-course-format-activity-header-title h5{margin-bottom:0;color:#424242;}.ks-form-course-format-activity-header-delete{float:right;margin-left:3px;width:12px;height:14px;}.ks-form-course-format-activity-header-delete a{-moz-border-radius:0 4px 0 4px;padding:3px 4px 1px;display:block;padding:14px 0 0 0;overflow:hidden;background:transparent url(../images/icons/delete_gray_12px.png) no-repeat right center;height:0 !important;height:12px;}.ks-form-course-format-activity-header-delete a:hover{background-image:url(../images/icons/delete_blue_12px.png);}.ks-form-course-format-activity-header-help{float:right;margin-left:3px;width:14px;height:14px;}.ks-form-course-format-activity-header-help a{display:block;padding:14px 0 0 0;overflow:hidden;background:url(../images/icons/help_gray_14px.png) no-repeat;height:0 !important;height:14px;}.ks-form-course-format-activity-header-help a:hover{background-image:url(../images/icons/help_blue_14px.png);}.ks-form-module{color:#444;margin-bottom:1em;clear:both;}.ks-form-module-group,.ks-form-module-solo{padding-bottom:5px;margin-bottom:0.1em;}.ks-form-module-fields{float:left;}.ks-form-module-elements{min-width:140px;margin-bottom:1px;float:left;margin-right:20px;line-height:1.4em;}.ks-form-required-for-submit{color:#999;font-size:0.9em;font-style:italic;font-weight:normal;margin-left:4px;}.ks-form-module-elements-required{color:red;}.ks-form-module-elements-inputs{border:solid 1px transparent;padding:2px;display:inline-block;}.ks-form-module-elements-instruction{font-size:1em;color:#000;display:block;line-height:1.4em;}.ks-form-header-title-actions{display:inline-block;float:right;margin-top:2px;line-height:1.2em;}.ks-form-module-elements-help a{-moz-border-radius:7px 7px 7px 7px;background-color:transparent;border:1px solid #ccc;color:#aaa;font-size:11px;font-weight:bold;margin:0 5px;padding:1px 3px 0;text-decoration:none;}.ks-form-module-elements-delete a{border:1px solid #ccc;color:#aaa;font-size:12px;font-weight:bold;padding:0 3px 1px;text-decoration:none;text-transform:lowercase;}.ks-form-module-elements-help a:hover,.ks-form-module-elements-delete a:hover{color:#2c61e6;border-color:#2c61e6;}.ks-form-module-elements-help-text{margin:2px 0 0 0;font-size:0.916em;color:#424242;display:block;}.ks-form-module-validation{float:left;font-size:1em;font-weight:bold;color:red;margin-right:10px;margin-left:0;}.ks-form-module-validation ul{background:transparent url(images/common/exclamation-red.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation li{margin-left:0;padding:3px 0;list-style:none;}.ks-form-module-validation-inline{font-size:1em;font-weight:bold;color:red;margin-left:0;float:left;margin-right:10px;}.ks-form-module-validation-errors ul{background:transparent url(images/common/exclamation-red.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation-warnings ul{background:transparent url(images/common/exclamation-diamond-frame.png) no-repeat scroll left;margin:0;padding-left:20px;}.ks-form-module-validation-inline li{margin-left:0;padding:3px 0;list-style:none;}.ks-form-module label,.ks-form-module h6,.ks-form-module .KS-Common-Title{display:block;font-weight:bold;color:#000;line-height:1.2em;}.ks-form-module label span a{font-weight:normal;margin-left:0.3em;}.ks-form-module-elements label{color:#000;display:block;font-weight:bold;line-height:1.9em;white-space:nowrap;}.ks-form-module-triple-line-margin{margin-top:3.6em;}.ks-form-module-double-line-margin{margin-top:2.4em;}.ks-form-module-single-line-margin{margin-top:1.2em;}.ks-form-module-single-line-margin-narrow{margin-top:0.4em;}.ks-form-module-no-line-margin{margin-top:0;}label.ks-form-module-elements-top-margin,h6.ks-form-module-elements-top-margin{font-size:1em;font-weight:bold;margin-top:0;}.ks-form-module-elements input[type="checkbox"]+label{display:inline;font-weight:normal;line-height:2em;white-space:nowrap;}.ks-form-module-elements input[type="radio"]+label{display:inline;white-space:nowrap;font-weight:normal;}.ks-form-module-elements input[type="text"]{border-bottom:#b5bdbd 1px solid;border-left:#b5bdbd 1px solid;padding-bottom:3px;padding-left:3px;border-top:#b5bdbd 1px solid;border-right:#b5bdbd 1px solid;padding-top:3px;margin-right:0.938em;}.ks-form-module-elements textarea{border:1px solid #b5bdbd;padding:3px;}.ks-form-module-elements select{border:1px solid #aaa;border:solid 1px #aaa;padding:3px;}.ks-form-required{color:red;font-size:14px;}.ks-form-show-advanced{background:transparent url(../images/right_arrow.png) no-repeat left center;padding-left:16px;}.ks-form-hide-advanced{background:transparent url(../images/down_arrow.png) no-repeat left center;padding-left:16px;}.ks-form-button-container{margin-bottom:10px;}a.ks-form-button-large,span.ks-form-button-large{text-decoration:none;background:#f3f3f3 url(images/common/plus_13px.png) no-repeat 6px center;padding:5px 8px 3px 22px;border:solid 1px #d5d5d5;line-height:23px;}a.ks-form-button-small,span.ks-form-button-small{text-decoration:none;font-size:0.9em;text-decoration:none;background:#f3f3f3 url(images/common/plus_13px.png) no-repeat 6px center;padding:5px 8px 3px 22px;border:solid 1px #d5d5d5;line-height:21px;}a:hover.ks-form-button-large,a:hover.ks-form-button-small,a:focus{text-decoration:underline;}span.disabled{background:#f3f3f3 url(../images/icons/plus_gray_13px.png) no-repeat 6px center;color:#888;}.error{background-color:#ffe0e9;}.error .ks-form-bordered-header{background-color:#f5d6df;}.warning{background-color:#f4e271;}.warning .ks-form-bordered-header{background-color:#f5d6df;}.invalid label,.invalid h6,.invalid legend,.invalid .KS-Common-Title,label.invalid,h6.invalid,legend.invalid,.ks-form-error-label{color:red;}.ks-form-warn-label{font-weight:normal;color:black;}.highlighted{background-color:#fffdd4;}.highlighted .ks-form-bordered-header{background-color:#f2f0c9;}.ks-page-sub-navigation-container .ks-page-sub-navigation-container{margin:0 20px;height:1%;}.ks-page-sub-navigation-container .ks-page-sub-navigation{border-bottom:solid 1px #ccc;padding:15px 0;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu{float:left;margin-right:35px;color:#666;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu .KS-Basic-Menu-Toplevel-Item-Label{font-size:0.916em;text-transform:uppercase;font-weight:bold;margin:0 0 3px 0;white-space:nowrap;overflow:hidden;color:#797979;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu ul{margin:0;}.ks-page-sub-navigation-container .ks-page-sub-navigation-menu li{list-style:none;line-height:1.3em;}a.ks-button-primary{border-bottom:#a1baf7 1px solid;border-left:#a1baf7 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#e4ebff;padding-left:15px;padding-right:15px;color:#2c61e6;font-size:1.16em;border-top:#a1baf7 1px solid;font-weight:bold;border-right:#a1baf7 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-primary:focus{color:#2c61e6;border:1px solid #2c61e6;background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);}a.ks-button-primary:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);border:1px solid #2c61e6;}.ks-button-primary-disabled{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#f8f8f8;padding-left:10px;padding-right:10px;color:#999;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-secondary{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#ececec;padding-left:10px;padding-right:10px;color:#2c61e6;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-secondary:focus,a.ks-button-secondary:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);border:1px solid #2c61e6;}.ks-button-secondary-disabled{border-bottom:#999 1px solid;border-left:#999 1px solid;padding-bottom:2px;line-height:1.93em;background-color:#f8f8f8;padding-left:10px;padding-right:10px;color:#999;font-size:1.16em;border-top:#999 1px solid;font-weight:bold;border-right:#999 1px solid;text-decoration:none;padding-top:4px;-moz-border-radius:4px;-webkit-border-radius:4px;}a.ks-button-primary-small{line-height:1.93em;text-decoration:none;background-color:#e4ebff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#e4ebff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#e4ebff,#bfd1ff);-moz-border-radius:4px 4px 4px 4px;-webkit-border-radius:3px;border:1px solid #a1baf7;padding:3px 8px 2px 8px;color:#2c61e6;font-size:1em;font-weight:bold;}a.ks-button-primary-small:focus,a.ks-button-primary-small:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#bfd1ff));background-image:-moz-linear-gradient(-90deg,#fff,#bfd1ff);border:1px solid #2c61e6;}.ks-button-primary-small-disabled{-moz-border-radius:3px 3px 3px 3px;background-color:#f8f8f8;background-image:-moz-linear-gradient(-90deg,#fff,#ccc);border:1px solid #999;color:#999;font-size:1em;font-weight:bold;line-height:1.93em;padding:3px 8px 2px;text-decoration:none;}a.ks-button-secondary-small{line-height:1.93em;text-decoration:none;background-color:#eee;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid #999;padding:3px 8px 2px 8px;color:#2c61e6;font-size:1em;}a.ks-button-secondary-small:focus,a.ks-button-secondary-small:hover{background-color:#fff;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#d8d8d8));background-image:-moz-linear-gradient(-90deg,#fff,#d8d8d8);border:1px solid #2c61e6;}.ks-button-secondary-small-disabled{line-height:1.93em;text-decoration:none;background-color:#f8f8f8;background-image:-webkit-gradient(linear,lefttop,leftbottom,from(#fff),to(#ccc));background-image:-moz-linear-gradient(-90deg,#fff,#ccc);-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid #999;padding:3px 8px 2px 8px;color:#999;font-size:1em;}.ks-link-disabled,.ks-link-large-disabled{color:#999;}.ks-link-large{font-size:1.167em;line-height:2.15em;}.ks-help-popup{background-color:#ffe87c;padding:3px 3px 3px 3px;border:1px solid black;width:250px;}.ks-example-popup{width:300px;}.top-padding{padding-top:10px;}.ks-button-right-margin{margin-right:1em;}.ks-header-edit-link{font-size:0.6em;padding-left:1em;}.horizontal-component{width:50%;float:left;}.accessibility-hidden{position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden;}.ks-multiplicity-section-label{margin-top:0;margin-bottom:0;font-weight:bold;color:#000;}.test{display:inline;}.ks-bordered{border:1px solid #d2d8e3;}

  .google-visualization-table-table{font-family:arial, helvetica;font-size:0.8em;border-collapse:collapse;cursor:default;margin:0;background:white;}.google-visualization-table-table tbody{background:transparent;}.google-visualization-table-table *{margin:0;vertical-align:middle;padding:2px;font-size:10pt;font-family:arial, helvetica;}.google-visualization-table-tr-head,.google-visualization-table-tr-head td{font-weight:bold;text-align:center;}.google-visualization-table-tr-even,.google-visualization-table-tr-even td{background-color:#e2ebf5;}.google-visualization-table-tr-odd,.google-visualization-table-tr-odd td{background-color:#c7d2e1;}.google-visualization-table-tr-sel,.google-visualization-table-tr-sel td{background-color:#d7c7ad;}.google-visualization-table-tr-over,.google-visualization-table-tr-over td{background-color:#ebdbce;}.google-visualization-table-sorthdr{cursor:pointer;}.google-visualization-table-sortind{color:#ccc;font-size:9px;padding-left:6px;}.google-visualization-table-th{border:1px solid #eee;padding:6px;}.google-visualization-table-td{border:1px solid #eee;padding-top:0;padding-bottom:0;padding-right:3px;padding-left:3px;}.google-visualization-table-td-freeze-rightmost{border-right-width:4px;}.google-visualization-table-td-bool{border:1px solid #eee;padding-right:3px;padding-left:3px;text-align:center;font-family:Arial Unicode MS, Arial, Helvetica;}.google-visualization-table-td-center{border:1px solid #eee;padding-right:3px;padding-left:3px;text-align:center;}.google-visualization-table-td-right{border:1px solid #eee;padding-right:3px;padding-left:3px;text-align:right;}.google-visualization-table-seq{border:1px solid #eee;text-align:right;color:#666;padding-right:3px;padding-left:3px;}.google-visualization-table-button{font-size:10px;padding-right:6px;}.google-visualization-table-td-page{text-align:left;vertical-align:middle;height:30px;}.google-visualization-table-arrow-dr{padding-left:13px !important;background:url(arrow_dr.png) no-repeat left;}.google-visualization-table-arrow-ug{padding-left:13px !important;background:url(arrow_ug.png) no-repeat left;}.google-visualization-table-arrow-empty{padding-left:13px !important;}
  .summaryTable{border-collapse:collapse;max-width:800px;width:100%;}.summaryTable .columnTitle{font-size:14px;font-weight:bold;padding:5px;border-bottom:1px dotted #999;}.rowTitleColunm{width:180px;}.cell1{padding-bottom:3px;padding-top:6px;padding-left:14px;min-width:310px;}.cell2{padding-bottom:3px;padding-top:3px;min-width:310px;}.sectionTitleRow{border-bottom:1px dotted #bbb;padding:30px 0 4px 4px;}.sectionTitle{font-size:1.2em;font-weight:bold;letter-spacing:0.03em;}.sectionEditLink{font-size:1.1em;font-weight:bold;letter-spacing:0.02em;margin-bottom:0;margin-left:30px;padding-bottom:0;text-decoration:none;}.rowTitle{font-weight:bold;padding:0.5em 0 0.2em 0.4em;white-space:nowrap;}.columnTitle{font-size:14px;font-weight:bold;padding:5px;border-bottom:1px dotted #999;}.rowHighlight,.cellHighlight{background-color:#ffe0e9;}.rowDiffHighlight{background-color:#fff8c6;}.summary-table-multiplicity-level-1{font-size:1.1em;padding:1.6em 0 0.2em 0.3em;}.summary-table-multiplicity-level-2{font-size:1.1em;}.summaryTable-lo-cell ul{margin:0;padding-left:1.1em;list-style:inherit outside none;}
  .KS-TabPanel-Full{width:100%;}.KS-TabPanel-Full .KS-TabPanel-TabRow{width:100%;overflow:hidden;position:relative;}.KS-TabPanel-Full .KS-TabPanel-Tab{padding-bottom:3px;background-color:#e0e0e0;color:#111;-moz-border-radius-topright:5px;-moz-border-radius-topleft:5px;-webkit-border-top-right-radius:5px;-webkit-border-top-left-radius:5px;-khtml-border-top-right-radius:5px;-khtml-border-top-left-radius:5px;border-radius-top-right-radius:5px;border-radius-top-left-radius:5px;white-space:nowrap;}.KS-TabPanel-Full .KS-TabPanel-Tab .KS-Label,.KS-TabPanel-Full .KS-TabPanel-Tab-Selected .KS-Label{color:#111;}.KS-TabPanel-Full .KS-TabPanel-Tab-Selected{background-color:white;}.KS-TabPanel-Full .KS-TabPanel-Tab-Label-Hover{color:orange;}.KS-TabPanel-Full .KS-TabPanel-Content{background-color:white;padding-top:35px;padding-left:8px;padding-bottom:20px;min-height:800px;height:auto !important;height:800px;}.KS-TabPanel-Full .KS-TabPanel-Tab-Hover{cursor:pointer;background-color:white;}.KS-TabPanel-Full .KS-TabPanel-Left-Panel{margin-left:20px;}.KS-TabPanel-Full .KS-TabPanel-Left-Panel ul{clear:left;float:left;list-style:none;margin:0;padding:0;position:relative;list-style:none;}.KS-TabPanel-Full .KS-TabPanel-Left-Panel ul li{display:block;float:left;list-style:none;margin:0;padding:0;line-height:1.8em;}.KS-TabPanel-Full .KS-TabPanel-Tab-Left{font-size:14px;padding-left:10px;padding-right:10px;padding-top:8px;margin-right:2px;}.KS-TabPanel-Full .KS-TabPanel-Right-Panel{margin-right:15px;position:absolute;bottom:-1px;right:0;}.KS-TabPanel-Full .KS-TabPanel-Right-Panel ul{clear:right;position:absolute;bottom:0;vertical-align:bottom;list-style:none;margin:0;padding:0;position:relative;list-style:none;}.KS-TabPanel-Full .KS-TabPanel-Right-Panel ul li{display:block;float:right;list-style:none;margin:0;padding:0;position:relative;line-height:1.8em;}.KS-TabPanel-Full .KS-TabPanel-Tab-Right{font-size:14px;padding-left:10px;padding-right:10px;padding-top:8px;margin-right:2px;}.KS-TabPanel-Small .KS-TabPanel-TabRow{overflow:hidden;position:relative;top:1px;}.KS-TabPanel-Small .KS-TabPanel-Tab{background-color:#ededed;border:1px solid #9d9d9d;color:#111;-moz-border-radius-topright:5px;-moz-border-radius-topleft:5px;-webkit-border-top-right-radius:5px;-webkit-border-top-left-radius:5px;-khtml-border-top-right-radius:5px;-khtml-border-top-left-radius:5px;border-radius-top-right-radius:5px;border-radius-top-left-radius:5px;white-space:nowrap;}.KS-TabPanel-Small .KS-TabPanel-Tab .KS-Label,.KS-TabPanel-Small .KS-TabPanel-Tab-Selected .KS-Label{color:#111;}.KS-TabPanel-Small .KS-TabPanel-Tab-Selected{background-color:white;border-bottom:1px solid #fff;}.KS-TabPanel-Small .KS-TabPanel-Tab-Label-Hover{color:orange;}.KS-TabPanel-Small .KS-TabPanel-Content{background-color:#f7eee1;border:1px solid #9d9d9d;padding:15px 25px 25px;width:790px;}.KS-TabPanel-Small .KS-TabPanel-Tab-Hover{cursor:pointer;background-color:white;}.KS-TabPanel-Small .KS-TabPanel-Left-Panel{margin-left:20px;}.KS-TabPanel-Small .KS-TabPanel-Left-Panel ul{clear:left;float:left;list-style:none;margin:0;padding:0;position:relative;list-style:none;}.KS-TabPanel-Small .KS-TabPanel-Left-Panel ul li{display:block;float:left;list-style:none;margin:0;padding:0;line-height:1.8em;}.KS-TabPanel-Small .KS-TabPanel-Tab-Left{font-family:sans-serif;font-size:1em;font-weight:bold;letter-spacing:0.07em;padding-left:2em;padding-right:2em;text-align:center;text-transform:uppercase;}.KS-TabPanel-Small .KS-TabPanel-Right-Panel{margin-right:15px;position:absolute;right:0;}.KS-TabPanel-Small .KS-TabPanel-Right-Panel ul{clear:right;position:absolute;bottom:0;vertical-align:bottom;list-style:none;margin:0;padding:0;position:relative;list-style:none;}.KS-TabPanel-Small .KS-TabPanel-Right-Panel ul li{display:block;float:right;list-style:none;margin:0;padding:0;position:relative;line-height:1.8em;}.KS-TabPanel-Small .KS-TabPanel-Tab-Right{font-size:14px;text-align:center;width:9em;margin-right:2px;}
  .KS-Table-ColumnHeader,.KS-Table-RowHeader{background-color:lightblue;}.KS-Table-Row{background-color:white;}.KS-Table-RowAlt{background-color:lightgray;}.ks-table-container{border:solid 1px #aaa;margin-bottom:1em;}.ks-table{border-collapse:collapse;font-size:1em;color:#424242;margin:0;}.ks-table-plain{border-collapse:collapse;}.ks-table td{padding:8px 10px 8px 15px;vertical-align:top;}.ks-table th{padding:8px 10px 8px 15px;vertical-align:top;color:#fff;text-align:left;background:#8b8b8b;border-right:1px solid #aaa;vertical-align:middle;}.ks-table input{margin:0;padding:0;}.ks-table-plain td,.ks-table-plain th{padding:0 5px;}.ks-table th a{color:#fff;}.ks-table td,.ks-table-plain td{border-bottom:1px solid #d5d5d5;vertical-align:top;}.ks-table-plain th{vertical-align:middle;background:none;border-bottom:solid 1px #d5d5d5;}.ks-table td.status{background:#fffccd;text-align:center;color:#000;}td.subhead{background:#d6d6d6;color:#000;font-size:1.083em;}td.subtitle{background:#f1f1f1;font-weight:bold;}th.empty{background-color:#fff;}tbody tr.edit a{color:#fff;}.ks-table-sort{padding-right:18px;}th.sort-down,th.sort-up{background-color:#686868;}.sort-down a.ks-table-sort{background:transparent url(../images/down_arrow_white.png) no-repeat right;}.sort-up a.ks-table-sort{background:transparent url(../images/up_arrow_white.png) no-repeat right;}tbody tr.checked td,td.checked{background-color:#c6d9ff;}tbody tr.activated td{background-color:#ffe3b9;}tbody tr.activated td.subtitle{background-color:#f1f1f1;}tbody tr.hovered td,tbody tr.hovered td.subtitle{background-color:#024fd0;color:#fff;}tbody tr.hovered td.subhead{background-color:#d6d6d6;color:#000;}thead th.hovered{background-color:#686868;}th.last-column,td.last-column{border-right:none;}tbody tr.last-row td{border-bottom:none;}th.remove,td.remove{text-align:center;}.ks-button-configure{float:right;height:20px;width:20px;}.ks-button-configure a{display:block;padding:20px 0 0 0;overflow:hidden;background:transparent url(../images/configure.png) no-repeat 2px 2px;height:0 !important;height:20px;-moz-border-radius:3px;-webkit-border-radius:3px;}.ks-button-configure a:hover{background-color:#555;}
  .KS-Textarea-Focus{background-color:#ecf2fa;}.KS-Textarea{margin:2px;border:1px solid #4583d5;}.watermark-text{color:#989898;font-style:italic;}
  .KS-Textbox-Hover,.KS-Textbox-Focus{background-color:#ecf2fa;}.KS-Textbox{border:1px solid #4583d5;}.ks-one-width{width:1.625em;}.ks-two-width{width:2.125em;}.ks-three-width{width:2.875em;}.ks-four-width{width:3.438em;}.ks-small-width{width:9.375em;}.ks-medium-width{width:15.625em;}.ks-large-width{width:27.5em;}.ks-extra-large-width,.ks-textarea-width{width:37.5em;}.ks-textarea-small-height{height:4.688em;}.ks-textarea-medium-height{height:8.25em;}.ks-textarea-large-height{height:12.563em;}
  .KS-TitleContainer-Link{font-size:14px;font-weight:bold;color:white;}.KS-TitleContainer-Status{font-size:22px;font-weight:bold;color:#525454;}.KS-TitleContainer-Title{margin-top:10px;margin-bottom:25px;font-size:30px;font-weight:bold;color:#666;margin-left:20px;}.KS-TitleContainer-Top-Row{width:100%;}.KS-TitleContainer-Toolbar{width:100%;margin-bottom:20px;margin-left:20px;}.KS-TitleContainer-Right-Panel{float:right;margin-top:20px;margin-right:30px;}.KS-TitleContainer-Layout{width:100%;background-color:#eaeaea;}.KS-TitleContainer{width:98%;margin-top:10px;margin-left:8px;margin-bottom:10px;}.KS-TitleContainer-Messages{background-color:#eaeaea;padding:0 20px;}.KS-Message-Static{background-color:#f4e271;color:#000;margin-bottom:10px;padding:6px 6px 6px 15px;position:relative;}.KS-Workflow-Status{background-color:#e0e0e0;background-image:url(images/common/node.png);background-repeat:no-repeat;margin-left:10px;padding:5px 5px 5px 25px;background-position:5px 5px;width:70%;}.KS-Workflow-Status-Node{font-weight:bold;color:#424242;}
  .gwt-ProgressBar-shell{border:2px solid #faf9f7;border-right:2px solid #848280;border-bottom:2px solid #848280;background-color:#aaa;height:14pt;width:50%;}.gwt-ProgressBar-shell .gwt-ProgressBar-bar{background-color:#67a7e3;}.gwt-ProgressBar-shell .gwt-ProgressBar-text{padding:0;margin:0;color:white;}
  .KS-Wrapper-Header-Content{height:130px;background-color:#a20000;width:99%;min-width:960px;padding-left:25px;padding-bottom:15px;padding-top:10px;}.KS-Wrapper-Header{height:130px;background-color:#a20000;width:100%;}.KS-Wrapper-Footer{padding-left:20px;height:60px;background-color:#a20000;width:100%;}.KS-Wrapper{width:100%;}.KS-Wrapper-Help-Label{font-size:18px;font-weight:bold;color:white;padding-left:5px;padding-right:5px;}.KS-Wrapper-Header-Right-Panel{height:100%;float:right;}.KS-Wrapper-Header-Left-Panel{height:100%;}.KS-Wrapper-Header-Custom-Link{font-size:14px;font-weight:bold;color:#d5d5d5;}.KS-Wrapper-Header-Custom-Link-Panel{background-color:#7b1314;padding-left:10px;padding-right:10px;padding-top:8px;padding-bottom:8px;margin-left:3px;-moz-border-radius:15px;-webkit-border-radius:15px;-khtml-border-radius:15px;border-radius:15px;}.KS-Wrapper-Header-Custom-Link-Panel:hover{background-color:white;}
  /*]]>*/
  </style>
  <style type="text/css">
/*<![CDATA[*/
  .GL3CMX0BEG{padding-top:10px;width:100%;margin-bottom:10px;}.GL3CMX0BDG{width:50%;float:left;margin-bottom:5px;}.GL3CMX0BGG{float:right;width:50%;}.GL3CMX0BBG,.GL3CMX0BIG,.GL3CMX0BHG{float:right;padding:2px;}.GL3CMX0BKG{padding-left:5px;font-weight:bold;font-size:20px;color:gray;}.GL3CMX0BFG,.GL3CMX0BJG,.GL3CMX0BLG,.GL3CMX0BCG{float:right;padding:2px;}.GL3CMX0BAG{clear:both;}.GL3CMX0BPF{border-bottom:1px dotted #c9c9c9;border-top:1px dotted #c9c9c9;clear:both;color:#777;font-family:Georgia, "Times New Roman", Times, serif;font-size:0.9em;letter-spacing:0.04em;padding:3px 0 3px 15px;}.GL3CMX0BPF a{color:#807970;letter-spacing:0.02em;}.GL3CMX0BPF a:hover{color:#2c61e6;}
  .courseProposal .transcriptTitle,.description-plain{width:37.5em;}.courseProposal .readOnlySection{background-color:#f1f1f1;padding:0 15px 15px 15px;border:1px solid #999;}.instructors .gwt-SuggestBox{width:30em;}.cluProposalTitleSection{border-bottom:1px dotted #d8d8d8;}.courseStatusLabel{color:#807970;padding-right:10px;padding-top:7px;}.versionHistoryLink{padding-top:5px;padding-left:10px;float:left;}.selectVersions{width:600px;}.KS-Add-Collaborator-Box{background-color:#f1f1f2;margin-bottom:10px;padding-left:10px;padding-bottom:10px;}.KS-Course-Requisites-Section-header{color:#940b07;}.KS-Course-Requisites-Top-Stmt-Header{border-bottom:1px solid #d7d7d7;padding-top:40px;padding-bottom:8px;}.KS-Course-Requisites-Preview-Rule-Type-Header{padding-top:30px;width:650px;}.KS-Course-Requisites-Preview-Rule-Type-First-Header{padding-top:20px;width:650px;}.KS-Course-Requisites-Preview-Rule-Type-Desc{padding-bottom:15px;width:650px;line-height:1.4em;}.KS-Course-Requisites-Button-Spacer{margin-bottom:15px;width:650px;}.KS-Course-Requisites-Preview-SaveContinue{padding-top:40px;}.KS-Course-Requisites-Manage-Step-header1{width:650px;margin-top:20px;border-bottom:1px solid #d7d7d7;}.KS-Course-Requisites-Manage-Step-header2{width:650px;margin-top:50px;border-bottom:1px solid #d7d7d7;}.KS-Course-Requisites-Save-Button{margin-top:40px;}.KS-Add-Data-Box{background-color:#f1f1f1;border-color:#999;border-style:solid;border-width:1px;padding-left:10px;padding-top:10px;}.KS-Data-Box-ReadOnlyNeedsToBeOnTheRight{margin-left:20px;}
  .KS-LumLandingPage .KS-SearchBox{font-size:1em;width:430px;}.KS-LumLandingPage .gwt-ListBox{font-size:1em;vertical-align:middle;}.KS-LumLandingPage-SearchPanel{margin-bottom:2em;}.KS-LumLandingPage-SearchLabel{margin-top:2em;font-weight:bold;margin-bottom:0.2em;}.KS-CurriculumHome-LinkList{font-size:2em;}
  .FlexTable{border-top:thin solid #444;border-left:thin solid #444;border-right:thin solid #111;border-bottom:thin solid #111;border-collapse:separate;empty-cells:hide;}.FlexTableColumn{background-color:#f0f0f0;}.KS-LUM-Top-Divider{border-top:1px solid #444;}.KS-LUM-Bottom-Divider{border-bottom:1px solid #444;}.KS-FormLayout-Label{width:90px;text-align:left;font-size:11px;padding-bottom:20px;vertical-align:middle;}.KS-FormLayout-Field{padding-bottom:20px;}.KS-Course-Section-Header{font-size:20px;margin-bottom:30px;}.KS-Course-Save-Button{margin-left:100px;}.KS-Course-Number{width:50px;}.KS-LOPicker-TextArea{height:auto;}.KS-LOBuilder-Section{padding-bottom:10px;padding-top:10px;}.KS-LOBuilder-Search-Panel{line-height:1.5em;width:100%;}.KS-LOBuilder-Spacer-Panel{padding:10px;width:250px;}.KS-LOBuilder-Search-Image{cursor:pointer;}.KS-LOBuilder-Search-Link{color:blue;font-size:70%;cursor:pointer;}.KS-LOBuilder-Instructions{font-size:1em;}.KS-LOBuilder-Highlighted-Item,.KS-LOBuilder-LO-Item-Active{background-color:#ffc;}.KS-LOBuilder-LO-Item-InActive{background-color:#fff;}.KS-LOBuilder-LO-Panel{margin-bottom:10px;margin-top:10px;}.KS-LOWindow{padding:5px;border:groove;}.KS-LOSearch-Type-Panel{padding:10px;border-bottom:thin solid #ccc;}.KS-LOSearch-Param-Panel{padding:5px;}.KS-LOSearch-Button-Panel{padding:5px;margin-left:auto;margin-right:auto;width:70%;}.KS-LOSearch-Results-Header{padding:5px;background-color:#ccc;font-weight:bold;}.KS-LOCategoryPicker{border-style:dashed;font-size:1em;margin:0 5px 0 70px;padding:2px 5px 5px;width:100%;}.KS-LOCategoryPicker-Button{font-size:75%;margin:0 0 0 7px;}.KS-LONodePanel{margin-bottom:15px;}.KS-LONodeIndent{width:49px;}.KS-LONodeIndentToolbar{width:28px;background-color:white;}.KS-LOaNode{background-color:#f2f9f9;border:1px solid #d2d8e3;height:50px;width:790px;}.KS-LOOutlineManagerToolbar{width:100%;height:32px;}.KS-LOButtonPanel{border-collapse:collapse;border-color:#d2d8e3;border-style:solid solid none;border-width:1px 1px medium;width:100%;}.KS-LOMoveUpButton{background:url(images/ArrowUp.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LOMoveUpButtonDisabled{background:url(images/ArrowUpDisabled.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LOMoveDownButton{background:url(images/ArrowDown.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LOMoveDownButtonDisabled{background:url(images/ArrowDownDisabled.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LOIndentButton{background:url(images/IncreaseIndent.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 4px 0 0;}.KS-LOIndentButtonDisabled{background:url(images/IncreaseIndentDisabled.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 4px 0 0;}.KS-LOOutdentButton{background:url(images/DecreaseIndent.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LOOutdentButtonDisabled{background:url(images/DecreaseIndentDisabled.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LODeleteButton{background:none repeat scroll 0 0 transparent;border:medium none;color:blue;float:right;font-size:0.916em;margin:8px 4px 1px 320px;}.KS-LODeleteButtonDisabled{background:transparent;border:none;color:#888;font-size:0.916em;margin:8px 4px 1px 422px;}.KS-LOBuilder-New{margin-top:5px;color:blue;cursor:pointer;}.KS-LOTextArea{border:1px solid #888;height:62px;margin:8px;width:35em;}.loText-count-label{margin-left:8px;}.KS-LOSelectedCategories{margin-left:0;}.KS-LOSelectedCategories .ks-selected-list-value{border-bottom:#cdcdcd 1px solid;border-left:#cdcdcd 1px solid;background:white 0 0;border-top:#cdcdcd 1px solid;border-right:#cdcdcd 1px solid;width:15em;}.KSLOLightBoxButtonPanel{background-color:white;height:40px;margin-bottom:30px;padding-top:12px;padding-bottom:20px;padding-left:16px;width:100%;}.KSLOLightBoxButton{padding-right:10px;}.KSLOLightBoxButtonSecondary{margin-right:180px;}.KSLOLightBoxMainPanel{background-color:#a7a7a7;}.KSLOCategoryManagementButtonPanel{background-color:white;margin-bottom:10px;margin-left:10px;}.Lum-DocumentHeader-Spacing{margin-left:0;}.KSLOCategoryManagementMainPanel{margin-top:5px;margin-left:0;}.KSLOCategoryManagementFilterPanel{margin-bottom:1.2em;}.KSLOCategoryManagementFilterLabel{font-weight:bold;font-size:1.5em;margin-top:5px;}.KS-Action-List{width:100%;height:500px;background-color:white;}.KS-ViewCourseDisplayTable{border:thin solid #c0c0c0;border-collapse:collapse;margin-left:3px;}.KS-ViewCourseDisplayTableHeaderCell,.KS-MultiplicityTableHeaderCell{font-weight:bold;background-color:#e6e6e6;}.KS-ViewCourseDisplayTableCell{border:1px solid #c0c0c0;padding:2px;}.KS-MultiplicityTable{margin-left:3px;}.KS-MultiplicityTableBorder{border:thin solid #c0c0c0;border-collapse:collapse;}.KS-MultiplicityTableCell{padding:2px;}.KS-MultiplicityTableCellBorder{border:1px solid #c0c0c0;}.KS-CommentButton{background:transparent;border:none;color:blue;font-size:0.916em;}.KS-CommentButtonDisabled{background:transparent;border:none;color:#888;font-size:0.916em;}.KS-CluSetManagement-chooser{background-color:lightgrey;width:500px;padding:10px;}.KS-CluSetManagement-chooser-unselected{background-color:lightgrey;width:500px;height:100px;padding:10px;}.browseCatalog .KS-TabPanel-Small .KS-TabPanel-Content{width:940px;}.cluInfo-feeType{width:150px;}.cluInfo-feeAmount{width:100px;}.cluInfo-officialIdentifier-division,.cluInfo-officialIdentifier-suffixCode{width:60px;}.cluInfo-officialIdentifier-longName{width:500px;}.cluInfo-primaryInstructor-personId{width:300px;}.cluInfo-creditType{width:150px;}.cluInfo-creditValue,.cluInfo-maxCredits{width:50px;}.TableIndent-0{font-weight:bold;}.TableIndent-1{text-indent:10px;}.TableIndent-2{text-indent:20px;}.TableIndent-3{text-indent:30px;}.TableIndent-4{text-indent:40px;}.TableIndent-5{text-indent:50px;}.TableIndent-6{text-indent:60px;}.TableIndent-7{text-indent:70px;}.TableIndent-8{text-indent:80px;}.SummaryTable-EvenRow{background-color:#fafafa;}.SummaryTable-OddRow{background-color:#f0f0f0;}.KS-LOSecondaryButton{margin-right:10px;}.LOCategoryDialogSpacing{margin-top:1.5em;}.LOCategoryDelete .ks-table-plain td{border-bottom:none;vertical-align:bottom;}.KSLOCategoryManagementTablePanel{margin-top:2em;}.KSLOCategoryManagementTable{margin-top:0.5em;}.KS-LOSelectAllHyperlink{margin-right:7px;font-size:1.1em;}.KS-LOClearHyperlink{margin-left:7px;font-size:1.1em;}.KS-LOFunnelImg{background:url(images/funnel-small.png) no-repeat 2px 2px;width:22px;height:22px;border:none;margin:4px 0 0;}.KS-LODialogTitle{font-size:1.5em;color:red;}.KS-LODialogFieldLabel{font-weight:bold;margin-right:10px;}.KS-LODialogCancel{margin-left:7px;vertical-align:bottom;}.KS-LOSpacer{width:20px;height:20px;border:none;margin:4px 0 0;}.KS-LODialogLabel{font-weight:bold;width:130px;text-align:left;}.KS-Program-Rule-ObjectView-Button,a.KS-Program-Rule-ObjectView-Button{padding-top:16px;}.acknowledgements{margin-left:30px;width:900px;padding-top:20px;}.acknowledgements p{font-size:1.1em;}.acknowledgements h1{padding-bottom:5px;border-bottom:2px solid black;font-weight:bold;}.acknowledgements h2{font-weight:bold;margin-bottom:0;}.acknowledgements h3{font-size:1.1em;font-weight:bold;margin-bottom:0;}.cluSetTitle,.ks-dependency-section-title{font-weight:bold;}.KS-Indent{padding-left:15px;}.ks-dependency-container{display:inline-block;padding-left:20px;white-space:normal;width:950px;}.ks-dependency-search{background:#f1f1f2;padding:15px;}.ks-dependency-search .gwt-SuggestBox{margin-right:10px;}.ks-dependency-results{width:700px;margin-left:15px;margin-top:15px;}.ks-dependency-oversight{padding-top:10px;font-style:italic;}.ks-dependency-type-section,.ks-dependency-section{padding-left:15px;padding-bottom:10px;margin-bottom:0.1em;white-space:normal;}.ks-dependency-section-header{padding-bottom:2px;}.ks-dependency-details{padding-left:30px;padding-bottom:15px;}.ks-dependency-simple-rule,.ks-dependency-complex-rule{padding-bottom:5px;}.ks-dependency-type-label{font-weight:normal;}.ks-dependency-view-link{padding-left:10px;}.ks-dependency-highlight{margin-left:10px;padding-left:2px;padding-right:2px;background:#f1f1f2;}.KS-Filter-Options-Parent-Container{border:1px solid #e8e8e8;background:#f8f8f8;margin-top:15px;width:200px;}.KS-Filter-Options-Title-Panel{padding:5px;}.KS-Filter-Item-Label{background:#d0d0d0;padding:5px;}.KS-Filter-Item input[type="checkbox"]+label{display:inline;line-height:2m;font-weight:normal;}.KS-Filter-Item .gwt-CheckBox{display:block;margin:10px;}.ks-course-admin .ks-menu-layout-leftColumn{position:fixed;}.ks-course-admin .ks-menu-layout-rightColumn{margin-left:180px;}
  .gwt-PagingScrollTable{border-color:#d2d8e3;border-style:solid;border-width:1px 0 1px 1px;}.gwt-PagingScrollTable .headerWrapper{background:#8b8b8b url(images/bg_header_gradient.gif) repeat-x bottom left;}.gwt-PagingScrollTable .footerWrapper{border-top:1px solid #aaa;background:#8bd url(images/bg_header_gradient.gif) repeat-x bottom left;}.gwt-PagingScrollTable .dataTable td{border-color:#aaa;border-style:solid;border-bottom:1px solid #d5d5d5;empty-cells:show;border-width:0 1px 1px 0;white-space:nowrap;overflow:hidden;height:20px;padding-left:5px;padding-bottom:1px;padding-top:2px;vertical-align:middle;}.gwt-PagingScrollTable .headerTable td,.gwt-PagingScrollTable .footerTable td{border-color:#aaa;border-style:solid;border-bottom:1px solid #d5d5d5;empty-cells:show;border-width:0 1px 1px 0;white-space:nowrap;overflow:hidden;height:20px;padding-left:5px;padding-bottom:1px;padding-top:2px;vertical-align:middle;font-weight:bold;text-align:left;color:#fff;}.gwt-PagingScrollTable .headerTable td:hover{background-color:#686868;}.gwt-PagingScrollTable .dataTable tr.highlighted{background:#024fd0;}.gwt-PagingScrollTable .dataTable td.highlighted{background:#024fd0;cursor:hand;cursor:pointer;}.gwt-PagingScrollTable .dataTable tr.selected td{background:#c6d9ff;}.gwt-PagingOptions{background:#e8eef7;border:1px solid #aaa;border-top:none;}.gwt-PagingOptions .errorMessage{color:red;}.pagingOptionsFirstPage,.pagingOptionsLastPage,.pagingOptionsNextPage,.pagingOptionsPrevPage{cursor:hand;cursor:pointer;}.gwt-InlineCellEditor{border:3px solid #7aa5d6;padding:4px;background:white;overflow:auto;}.gwt-InlineCellEditor .accept,.gwt-InlineCellEditor .cancel{cursor:pointer;cursor:hand;}.AbstractOption-Label{font-weight:bold;text-align:right;}
  .KS-Program-Requirements-Section-header{color:#940b07;}.KS-Program-Requirements-Preview-Rule-Type-First-Header{padding-top:20px;font-weight:bold;width:650px;border-bottom:1px solid #d7d7d7;}.KS-Program-Requirements-Preview-Rule-Type-Header{padding-top:40px;font-weight:bold;width:650px;border-bottom:1px solid #d7d7d7;}.KS-Program-Requirements-Preview-Rule-Type-Credits{padding-bottom:20px;}.KS-Program-Requirements-Preview-Rule-Type-Desc{padding-bottom:15px;width:650px;}.KS-Program-Requirements-Preview-No-Rule-Text{padding-top:20px;}.KS-Program-Requirements-Preview-SaveContinue{padding-top:40px;}.KS-Program-Requirements-Manage-Step-header1{width:650px;margin-top:20px;border-bottom:1px solid #d7d7d7;}.KS-Program-Requirements-Manage-Step-header2{width:650px;margin-top:50px;border-bottom:1px solid #d7d7d7;}.KS-Program-Requirements-Save-Button{margin-top:40px;}.KS-Program-Rule-ObjectView-RulePanel label{display:inline;}.KS-Program-History{border-bottom:1px solid #d7d7d7;color:#707270;font-size:1em;letter-spacing:0.02em;line-height:1.4em;padding-left:5px;white-space:nowrap;}.KS-Program-History-Sidebar{width:100%;}.programController .ks-table-plain td{border-bottom:none;}.programController .readOnlySection{background-color:#f1f1f1;padding:0 15px 15px 15px;border:1px solid #999;width:100px;}.readOnlyNeedsToBeOnTheRight{margin-left:400px;}.programController .programInformationView{background-color:#f1f2dc;margin-bottom:2em;padding:15px 15px 0;}.programInformationView .ks-table-plain td{padding-top:0;padding-bottom:0;}.programInformationView h4{border-bottom:1px dotted #808080;font-size:1.1em;letter-spacing:0.03em;margin-right:10px;text-transform:uppercase;}.programInformationView label{white-space:nowrap;}.programController .programActionPanel{padding-top:10px;padding-bottom:10px;width:500px;}.programController .sideBar{padding-top:10px;padding-left:10px;border-spacing:6px;}.programController .sideBar .history{font-weight:bold;}.programController .sideBar .datePanel{border-spacing:2px;}.programController .parentProgram{padding-right:3px;}.editableHeader{height:20px;}.editableHeader .sectionTitle{font-size:17px;float:left;}.editableHeader .editButton{padding-left:4px;padding-top:2px;position:relative;line-height:18px;}.gwt-PopupPanel{z-index:3;}.longTitle,.shortTitle,.diplomaTitle,.shortTitle,.transcriptTitle{width:27.5em;}
  /*]]>*/
  </style>

  <title>Kuali Student: ENG 100 (Proposal) - STEP 2</title>
  <style type="text/css">
/*<![CDATA[*/
  .GL3CMX0BEH h2{font-family:Georgia, "Times New Roman", Times, serif;font-size:1.8em;letter-spacing:0.02em;margin:10px 0 11px;}.GL3CMX0BBH{overflow:auto;text-align:right;}.GL3CMX0BCH,.GL3CMX0BDH{cursor:pointer;float:right;margin-left:10px;}.GL3CMX0BAH{border-bottom:3px solid #000;margin-bottom:1.1em;padding-bottom:2px;}.GL3CMX0BFH{float:left;}.GL3CMX0BHH a{font-size:1.2em;text-decoration:none;color:#000;}.GL3CMX0BHH a:hover{text-decoration:underline;}.GL3CMX0BIH{padding:0 1px 0 3px;}.GL3CMX0BJH{padding:0;}
  /*]]>*/
  </style>
  <style type="text/css">
/*<![CDATA[*/
  .GL3CMX0BPH{border:1px solid #d2d8e3;cursor:pointer;}.GL3CMX0BOH{background-color:#8b8b8b;height:18px;table-layout:fixed;width:100%;}.GL3CMX0BCI{background-color:#888;background-image:url(./images/gear.png);background-position:center;background-repeat:no-repeat;width:20px;height:35px;}.GL3CMX0BOH td{color:white;font-weight:bold;border-bottom:1px solid #aaa;border-right:1px solid #aaa;font-weight:bold;height:35px;padding:2px 0 1px 10px;vertical-align:middle;}.GL3CMX0BOH td:hover{background-color:#686868;}.GL3CMX0BAI{table-layout:fixed;word-wrap:break-word;width:100%;}.GL3CMX0BAI td{border-bottom:1px solid #d5d5d5;border-right:1px solid #d5d5d5;height:35px;padding:2px 0 2px 10px;vertical-align:middle;}.GL3CMX0BBI{valign:top;}.GL3CMX0BNH{background:#c6d9ff;}.GL3CMX0BNH td{border-bottom:1px solid #d6d6d6;}.GL3CMX0BKH{background:#686868;background-image:url(./images/common/up_arrow_white.png);background-position:center;background-repeat:no-repeat;}.GL3CMX0BLH{background:#686868;background-image:url(./images/common/down_arrow_white.png);background-position:center;background-repeat:no-repeat;}.GL3CMX0BMH{background:#686868;}
  /*]]>*/

	.linkcolumn:link {COLOR: #707270; TEXT-DECORATION: none;}
	.linkcolumn:visited {COLOR: #707270; TEXT-DECORATION: none;}
	.linkcolumn:hover {COLOR: #E87B10; TEXT-DECORATION: none; cursor:pointer; !IMPORTANT}

  </style>

</head>

<body>
  <div id="applicationPanel" style="height: 100%; width: 100%; overflow: auto">
    <div class="app-wrap">
      <div>
        <div class="GL3CMX0BEG">
          <div class="header-appTitle">
            Kuali Student - STEP 2
          </div>

          <div class="header-innerDiv">
            <div class="GL3CMX0BDG">
              <div tabindex="1" id="gwt-uid-10" class="KS-Navigation-DropDown">
                <span><input type="text" tabindex="-1" style=
                "opacity: 0; height: 1px; width: 1px; z-index: -1; overflow: hidden; position: absolute;" /></span>
              </div>
            </div>

            <div class="GL3CMX0BGG">
              <div class="GL3CMX0BHG"></div>

              <div class="GL3CMX0BIG"></div>

              <div class="GL3CMX0BBG"></div>

              <div class="GL3CMX0BAG"></div>

              <div class="GL3CMX0BFG">
                <a class="gwt-Anchor" href="##">Logout</a>
              </div>

              <div class="GL3CMX0BJG">
                |
              </div>

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

              <div class="GL3CMX0BFG">
                <a class="gwt-Anchor" href="acs05p.jsp?type=<%=type%>&section=<%=section%>&cps=<%=selectedCampus%>&prt=1" target="_blank">Print</a>
              </div>

              <div class="GL3CMX0BJG">
                |
              </div>

              <div class="GL3CMX0BLG">
                <div class="gwt-Label">
                  <%=user%>
                </div>
              </div>

              <div class="GL3CMX0BCG">
                <div class="gwt-Label">
                  Hi,
                </div>
              </div>
            </div>
          </div>

          <div class="GL3CMX0BPF" style="">
            <div class="gwt-Hyperlink">
              <span><a href="##">
              Home</a></span>
            </div><span><span class="gwt-InlineLabel">&#187;</span></span>

            <div class="gwt-Hyperlink">
              <a href="##">
              Curriculum Management</a>
            </div><span class="gwt-InlineLabel">&#187;</span>

            <div class="gwt-Hyperlink">
              <a href="##">
              ENG 100 (Proposal) - STEP 2</a>
            </div><span class="gwt-InlineLabel">&#187;</span> <span class=
            "gwt-InlineLabel">Course Information</span>
          </div>

        </div>
      </div>

      <div class="app-content">
        <table cellspacing="0" cellpadding="0" class="ks-menu-layout courseProposal">
          <tbody>
            <tr>
				  <td align="left" style="vertical-align: top;">
					 <div class="GL3CMX0BFH ks-menu-layout-leftColumn">
						<table id="collapsePanel" style="height: 285px">
						  <tbody>
							 <tr>
								<td class="GL3CMX0BJH">
								  <div class="GL3CMX0BGH">
									 <table cellspacing="0" cellpadding="0">
										<tbody>
										  <tr>
											 <td align="left" style="vertical-align: top;">
												<div class="ks-menu-layout-menu">
												  <div class="ks-page-sub-navigation">
													 <div class="ks-page-sub-navigation-menu">
														<ul>
														  <li>
															 <div tabindex="-1" class=
															 "KS-Basic-Menu-Item-Panel KS-Basic-Menu-Toplevel-Item-Panel">
															 <input type="text" tabindex="-1" style=
															 "opacity: 0; height: 1px; width: 1px; z-index: -1; overflow: hidden; position: absolute;" />

																<div>
																  <div class=
																  "gwt-Label KS-Label KS-Basic-Menu-Item-Label KS-Horizontal-Block-Flow KS-Basic-Menu-Toplevel-Item-Label"
																  style="white-space: nowrap">
																	 Course Sections
																  </div>
																</div>
															 </div>
														  </li>

<%
	//
	// drawing left navigation
	//
	for(int i = 0; i < links.length; i++){
%>
	<li>
	 <div tabindex="-1" class="KS-Basic-Menu-Item-Panel">
		<input type="text" tabindex="-1" style="opacity: 0; height: 1px; width: 1px; z-index: -1; overflow: hidden; position: absolute;" />
		<div>
		  <div>
			 <span id="gwt-uid-225"></span>
			 <div class="gwt-Label KS-Label KS-Basic-Menu-Item-Label KS-Basic-Menu-Clickable-Item-Label KS-Horizontal-Block-Flow" style="white-space: nowrap">
				<span id="gwt-uid-225"><a class="linkcolumn" href="acs05.jsp?type=course&section=<%=args[i]%>" id="gwt-uid-225anchor" tabindex="10"><%=links[i]%></a></span>
			 </div>
		  </div>
		</div>
	 </div>
	</li>
<%
	} //

	String[] campuses = "HAW,HIL,HON,KAP,KAU,LEE,MAN,UHMC,WIN,WOA".split(",");

	for(int i = 0; i < campuses.length; i++){
%>
	<li>
	 <div tabindex="-1" class="KS-Basic-Menu-Item-Panel">
		<input type="text" tabindex="-1" style="opacity: 0; height: 1px; width: 1px; z-index: -1; overflow: hidden; position: absolute;" />
		<div>
		  <span id="gwt-uid-225"><a class="gwt-Anchor" href="javascript:return%20false;" id="gwt-uid-225anchor" tabindex="10"></a></span>
		  <div>
			 <span id="gwt-uid-225"></span>
			 <div class="gwt-Label KS-Label KS-Basic-Menu-Item-Label KS-Basic-Menu-Clickable-Item-Label KS-Horizontal-Block-Flow" style="white-space: nowrap">
				<span id="gwt-uid-225"><a class="linkcolumn" href="acs05.jsp?type=campus&cps=<%=campuses[i]%>"><%=campuses[i]%></a></span>
			 </div>
		  </div>
		</div>
	 </div>
	</li>
<%
	} // for

	//
	//
	//
%>


														</ul>
													 </div>

													 <div class="ks-page-sub-navigation-menu">
														<ul>
														  <li>
															 <div tabindex="-1" class=
															 "ks-menu-layout-special-menu-item-panel">
																<input type="text" tabindex="-1" style=
																"opacity: 0; height: 1px; width: 1px; z-index: -1; overflow: hidden; position: absolute;" />

																<div>
																  <span id="gwt-uid-226"><a class=
																  "gwt-Anchor" href=
																  "javascript:return%20false;" id=
																  "gwt-uid-226anchor" tabindex=
																  "2"></a></span>

																  <div>
																	 <span id="gwt-uid-226"></span>

																	 <div class=
																	 "gwt-Label KS-Label KS-Basic-Menu-Item-Label KS-Basic-Menu-Clickable-Item-Label KS-Horizontal-Block-Flow"
																	 style="white-space: nowrap">
																		<span id="gwt-uid-226">Review Proposal</span>
																	 </div>
																  </div>
																</div>
															 </div>
														  </li>
														</ul>
													 </div>

													 <div>
														<div class="clear">
														  &nbsp;
														</div>
													 </div>
												  </div>
												</div>
											 </td>
										  </tr>

										  <tr>
											 <td align="left" style="vertical-align: top;"></td>
										  </tr>
										</tbody>
									 </table>
								  </div>
								</td>
								<td class="GL3CMX0BJH" style="vertical-align: top"><span class="GL3CMX0BHH"><span><a class="GL3CMX0BIH" href="javascript:return%20false;" tabindex="0">&#171;</a></span></span></td>
							 </tr>
						  </tbody>
						</table>
					 </div>
				  </td>
              <td align="left" style="vertical-align: top;">
                <div class="ks-menu-layout-rightColumn">
                  <div class="GL3CMX0BAH" style="">
                    <div>
                      <div class="GL3CMX0BEH">
                        <h2>ENG 100 (Proposal) - STEP 2</h2>
                      </div>
                    </div>

                    <div class="contentHeader-utilities">
                      <div class="gwt-Label KS-Label ks-documentHeader-widgetPanel">
                        <span>Proposal Status: Saved</span>
                      </div>

                      <div class="gwt-HTML ks-documentHeader-widgetPanel">
                        <span><span style=
                        "float: left; margin-left: .7em; margin-right: .7em">|</span></span>
                      </div><span><a class="ks-link ks-documentHeader-widgetPanel" href="##" tabindex="0">Comments</a></span>

                      <div class="gwt-HTML ks-documentHeader-widgetPanel">
                        <span style="float: left; margin-left: .7em; margin-right: .7em">|</span>
                      </div><span><a class="ks-link ks-documentHeader-widgetPanel" href="##" tabindex="0">Decisions</a></span>

                      <img onload="this.__gwtLastUnhandledEvent=&quot;load&quot;;" src="./CI_files/clear.cache.gif" style="width: 16px; height: 16px; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACLklEQVR42o2ST2iScRzGX8JbdBASOnpoh9wlPSzmhKyJvGbvwDTRCAxG/kGidXiduNe9koYyiB0kOxk7zPCk89BwkylII4WOFSTs0NAhQVtMB23OPb2/Fza0pfV9+fAe3ufz/N6X90tRPWOdn2fu87xzAFepf42F41x7nQ4a7Ta2Wy18298XyZXLIM/MHDcytMA0N+f+eXiI7d1dfG028XlnB58aDaRWV0GGPKdnZuQDC6ZmZz2toyN8F07tLYkvL58xQtPcwIK7LOttCwU/Dg7OlZA3IZ9DMn0Sz/MXzGYzY7FYXBKJ5CXLshgGyZAscYhLMQxzORAI8E3hJLfbjXA4jGAweA6O4xAKhcRMvV6H3+/niUsZjcZr8Xh8qVarwWazwefzwel0wuFwwGS6h8lJHSYmNBgbuwGD4Y6YWVsrIRKJLBGXomlam8lkStVqFTqdTpBd0OsN0Gi0gnizD52OFjO5XAGLi4kScSmtVmurVCpbxWIRSqUSVutDIcT8Fb1+Ssw4hSudfrdFXEqtVj/J5/NIpVKQy+WwWB6BYR4MhGSSySSy2SyIS6lUKrZcfo+VlTy83qdYWEggFnuFaDTRw+szPJ5nKBQ+ihCXUigUgY2NTayvb8Jut/8XpwXEpWQy2bRUKn1BEP5xjKysMQG8+QC8rXzBrdA0rruiuM2m8ev4mOxB7DRP3L6lujI+/hx/TPfkRKTT7aIj3Elm4CpfGh19fFGhiA6DZHqd32v43W/p3CB9AAAAAElFTkSuQmCC); background-position: 0px 0px; background-repeat: no-repeat no-repeat;"
                      border="0" class="GL3CMX0BCH" /> <img onload="this.__gwtLastUnhandledEvent=&quot;load&quot;;" src=
                      "./CI_files/clear.cache.gif" style="width: 16px; height: 16px; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABhUlEQVR42n2RS0tCQRiG/TPtW9aioEXRJoIIWkXLQtpVu1oF2crIoDCRAkURJDFF1NLEDM2zKIPqhBB0MRRTxFt6vLzNJ6FIMw48fIv3nWfOzFGp/pYky7iQJOSLxYGTeire8sXjoOUMhwdO6nEF3lgMbVZotdtCKKceV+CJRtFkJaXZFEI59bgCVyQCpdXCT6MhhHLqcQV0xxo7pVyvC6GcelyBIxRChZ1SqFaFUE49rsAeCKCoKPgul4VQTj2uwOb3o8A+M8P+twjKqccVWLxe5Go1pAoFIZQvm+LwJav/JWa3G1l2z7dcTgjlM8dPWLKl4JFL/ZJTpxPpSgWv2Wwf62dJzBmeO8wbXzC5J+EoBSycJOF6yPckRocDX+yhkplMH9Nsg+4DUD8Ci4keazIwe3DXExxarfhkAkJOp7tz1ZzA+PYVJnbCHYY3nBi5AaY017DfpnqCXb0eGfbKGjbfSyXupHxoxYSxTS8sl/f9b7BvMGBLq4U/GBw4R9U6aIzn3c2/Sxiaxa49qukAAAAASUVORK5CYII=); display: none; background-position: 0px 0px; background-repeat: no-repeat no-repeat;"
                      border="0" class="GL3CMX0BCH" />

                      <div class="GL3CMX0BBH content-info">
                        Last Updated: 2014-02-03 14:03
                      </div>
                    </div>

                    <div style="clear: both"></div>
                  </div>

                  <div>
                    <div class="KS-LUM-Section">
                      <div class="ks-form-module">
                        <h2 class=
                        "KS-Section-Title KS-H2-Section-Title ks-layout-header"><%=pageTitle%></h2>

                        <div>
                          <img onload="this.__gwtLastUnhandledEvent=&quot;load&quot;;"
                          src="./CI_files/clear.cache.gif" style=
                          "width: 16px; height: 16px; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABu0lEQVR42pWTu0vDUBTG08cf0dFBcBAhgwgKYusDn7iIFEcd6qKTdnJztD5AhIJDQRB0ENFBFNzUVqVCaqrUWtSWtjZRUdKm6CAc7xe8Eh9Ve+EH55z7fR83yY0glFh2u72JMfVOk1DO4mZV2dFUZVsrK+Td7FOVLe31fpKAcruBEN+fIUzgZMwot5vaS26CzOTSKwiZgaaU2cWYy6XXND09RsDr9RrwPnuziJA5aL+am20223w2tZzXkiPE8Xg8BuZZ6nI6Dy083NzKBguZm0D+6XqYOHeJIRJFkRwOB52ddJB83GaAOhIeRcgCvAIr/Kkrf/7xykPgLjFIl2e9FJFaiOUbSJLrG6GQGyF+BCwm47MFmDNxN53LTpJPGw14AO/NHBx0F+DFI7SzInAhjxdi0QaKRes/eFAnDcwzENx3whyA13gPrOlkLEnhfj1xXkscfgLz7GivTocWnk9fgg26rFbrsnTo0pMxkQAP4H14r0aHBtof7wLb6GGC1UhQLGbj1VR4mDBALe1XFbEHza+3kQl6LRbLuhysLKqJKgKoMcPef/+nPmbYjQYrngFqzIQy1wAzhgDqUqI3lmlb1M6SbmsAAAAASUVORK5CYII=); display: none; background-position: 0px 0px; background-repeat: no-repeat no-repeat;"
                          border="0" class="gwt-Image ks-message-static-image" />
                          <div class="ks-message-static-margin"></div>
                          <div style="display: none;"></div>
                        </div>

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
