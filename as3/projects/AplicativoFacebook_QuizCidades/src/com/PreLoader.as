package com
{
	
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	
	import flash.net.URLRequest;
	import flash.display.Loader;
	
	public class PreLoader extends MovieClip
	{
		private var mymovie:URLRequest;
		private var myloader:Loader = new Loader();
		private var date:Date;
		private var numVal:Number;
		
		public function PreLoader()
		{
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("http://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("http://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			date = new Date();
			numVal = date.time;
			var url:String = "appfacebook.swf?v=" + String(numVal);
			mymovie = new URLRequest(url);
			myloader = new Loader();
			
			myloader.contentLoaderInfo.addEventListener(Event.COMPLETE, addMovie);
			myloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, movieProgress);
			
			stage.align = "TL";
			stage.scaleMode = "noScale";
			
			myloader.load(mymovie);
			
			pagIntro.logoMC.scaleX = pagIntro.logoMC.scaleY = 0;
			TweenLite.to(pagIntro.logoMC, 0.5, {scaleX: 2.05, scaleY: 2.05, ease: Back.easeOut});
			TweenLite.delayedCall(0.5, ativarAnimacaoLogo);
		}
		
		private function ativarAnimacaoLogo():void
		{
			TweenLite.to(pagIntro.logoMC, 0.5, {scaleX: 2, scaleY: 2, ease: Back.easeInOut, onComplete: function()
				{
					TweenLite.to(pagIntro.logoMC, 0.5, {scaleX: 2.05, scaleY: 2.05, ease: Back.easeInOut, delay: 3, onComplete: ativarAnimacaoLogo});
				}})
		}
		
		//FUNÇÕES
		//função do evento Complete do loader
		function addMovie(e:Event):void
		{
			//removendo o filme que informa o carregamento
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			//adicionando o conteúdo do loader no palco, no mesmo nível de onde 
			//foi removido o preloader
			addChild(e.target.content);
			with (e.target.content)
			{
				x = 0;
				y = 0;
			}
		}
		
		//função do evento Progress do loader
		function movieProgress(e:ProgressEvent):void
		{
			//informando a scaleX da barra de progresso dividindo o carregado/total, 
			//levando em conta que a escala de objetos agora é de 0 a 1 e não mais de 0 a 100
			preloader.bar.scaleX = e.bytesLoaded / e.bytesTotal;
			//informando o percentual de bytes carregados
			preloader.porcent.porcentagem_txt.text = String(Math.ceil(e.target.bytesLoaded / e.target.bytesTotal * 100) + "%");
		}
	}
}