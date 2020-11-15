    <div id="blankWrapper">
      <div>
        	<script type="text/javascript" src="./js/listnav/jquery-1.3.2.min.js" charset="utf-8"></script>
			<script type="text/javascript" src="./js/listnav/jquery.idTabs.min.js" charset="utf-8"></script>
			<script type="text/javascript" src="./js/listnav/jquery.listnav.pack-2.1.js" charset="utf-8"></script>
			<script type="text/javascript" charset="utf-8">
			//<![CDATA[
            $(function(){
					$("#tabNav ul").idTabs("tab6");

					$('#listNavAse').listnav({
						includeOther: true,
						prefixes: ['the','a']
					});
            });
            //]]>
        </script>

			<div class="demoWrapper">
				<div class="clr"></div>

				<div id="tabNav">
					<ul>
						<li><a href="" class="selected"><%=pageTitle%></a></li>
					</ul>
					<ul>
						<li><a href="?t=c&s=a">Archived</a></li>
					</ul>
					<ul>
						<li><a href="?t=c&s=c">Current</a></li>
					</ul>
					<div class="clr"></div>
				</div>

				<div id="tabs">
					<div id="tab6" class="tab" style="display: block;">
						<div id="nav6">
							<div id="listNavAse-nav" class="listNav"></div>
								<p align="left">
									<br>
									<ul id="listNavAse" class="demo" align="left">
