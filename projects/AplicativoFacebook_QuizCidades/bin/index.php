<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>	 	
		<script type="text/javascript" src="swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/pt_BR/all.js"></script>
		
		<style>	
		 #conteudo{
			display: block;
			margin: 0 auto;
			overflow: hidden;
			position: relative;
			width: 760px;
		}

		#facebookCenter{
			left: 4%;
			overflow: hidden;
			position: absolute;
			width: 450px;
			height: 8%;
		}

		#flashContent {
			padding-top: 40px !important;
		}
	</style>
	</head>
	<body>
	<div id="conteudo">
	<div id="fb-root"></div>
	
	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-3320871-1']);
	  _gaq.push(['_trackPageview']);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	</script>

	
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/pt_BR/all.js#xfbml=1&appId=389910297743963";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
		
		<div>
			<div id="facebookCenter">
				<fb:like href="http://www.facebook.com/epoca.com.br" send="true" width="450" show_faces="true" font="arial"></fb:like>
			</div>
			<div id="flashContent" >
				<h1>You need at least Flash Player 9.0 to view this page.</h1><p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
			</div>
		</div>

		
		<script type="text/javascript">
			//Dynamic publishing with swfObject 
			var flashvars = {
			    server: ""
			};
			var params = {
				menu: "false",
				wmode :"opaque"
			};
			var attributes = {
			  id: "flashContent",
			  name: "flashContent"
			};
			//A 'name' attribute with the same value as the 'id' is REQUIRED for Chrome/Mozilla browsers
			swfobject.embedSWF("preloader.swf?<? echo(time()) ?>", "flashContent", "760", "740", "9.0", null, flashvars, params, attributes); 			
		</script>
	</body>
	</div>
</html>