package com
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	//import flash.system.Security;
	
	public class PreLoader extends MovieClip
	{
		private var asset	:PLAsset;
		private var sndLoad	:SecondLoad;
		private var movieObj:Main;
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
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			asset = new PLAsset();
			this.addChild(asset);
			date = new Date();
			numVal = date.time;
			var url:String;
			if (isLocal)
			{
				url = "Main.swf"
			}
			else
			{
				url = "http://media.mundodositio.globo.com.s3.amazonaws.com/face/matamata/bin-release-build/Main.swf";
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
		
		public function addMovie(e:Event):void
		{
			// Embaralhando...
			sndLoad = new SecondLoad();
			sndLoad.x = 470;
			sndLoad.y = 250;
			sndLoad.scaleX = sndLoad.scaleY = 0.3;
			this.addChild(sndLoad);
			movieObj = e.target.content;
			movieObj.setCompleteFunction(showMovie);
			with (e.target.content)
			{
				x = 0;
				y = 0;
			}
		}
		public function showMovie():void
		{
			destroy();
			addChild(movieObj as Main);
		}
		public function movieProgress(e:ProgressEvent):void
		{
			asset.preloader.bar.scaleX = e.bytesLoaded / e.bytesTotal;
			//asset.preloader.porcent.porcentagem_txt.text = String(Math.ceil(e.target.bytesLoaded / e.target.bytesTotal * 80) + "%");
		}
		private function destroy():void
		{
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
		}
	}
}