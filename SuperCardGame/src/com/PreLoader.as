package com
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class PreLoader extends MovieClip
	{
		private var mymovie:URLRequest;
		private var myloader:Loader = new Loader();
		private var date:Date;
		private var numVal:Number;
		private var isLocal:Boolean = true;
		
		public function PreLoader()
		{
			/*SECURITY.LOADPOLICYFILE("HTTP://GRAPH.FACEBOOK.COM/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://GRAPH.FACEBOOK.COM/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://PROFILE.AK.FBCDN.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://PROFILE.AK.FBCDN.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://FBCDN-PROFILE-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://FBCDN-PROFILE-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://FBCDN-SPHOTOS-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://FBCDN-SPHOTOS-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.ALLOWDOMAIN("*");
			SECURITY.ALLOWINSECUREDOMAIN("*");*/
			
			date = new Date();
			numVal = date.time;
			var url:String;
			if (isLocal)
			{
				url = "Main.swf"
			}
			else
			{
				//url =
			}
			//url = "appfacebook.swf?v=" + String(numVal);
			mymovie = new URLRequest(url);
			myloader = new Loader();
			
			myloader.contentLoaderInfo.addEventListener(Event.COMPLETE, addMovie);
			myloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, movieProgress);
			
			stage.align = "TL";
			stage.scaleMode = "noScale";
			
			myloader.load(mymovie);
		}
		
		
		//FUNÇÕES
		//função do evento Complete do loader
		public function addMovie(e:Event):void
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
		public function movieProgress(e:ProgressEvent):void
		{
			//informando a scaleX da barra de progresso dividindo o carregado/total, 
			//levando em conta que a escala de objetos agora é de 0 a 1 e não mais de 0 a 100
			preloader.bar.scaleX = e.bytesLoaded / e.bytesTotal;
			//informando o percentual de bytes carregados
			preloader.porcent.porcentagem_txt.text = String(Math.ceil(e.target.bytesLoaded / e.target.bytesTotal * 100) + "%");
		}
	}
}